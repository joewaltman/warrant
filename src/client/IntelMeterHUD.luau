--!strict
-- IntelMeterHUD | WARRANT: Case Closed
-- Client-side Intel Meter display: tier progress, evidence notifications, breach button

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local IntelMeterHUD = {}

local screenGui: ScreenGui? = nil
local meterFrame: Frame? = nil
local tierLabel: TextLabel? = nil
local pointsLabel: TextLabel? = nil
local fillBar: Frame? = nil
local breachButton: TextButton? = nil
local notificationLabel: TextLabel? = nil

local currentPoints = 0
local currentTier = 0
local isFrozen = false

local TIER_COLORS = {
	[0] = Color3.fromRGB(128, 128, 128), -- Blind: gray
	[1] = Color3.fromRGB(66, 135, 245),  -- Hunch: blue
	[2] = Color3.fromRGB(245, 194, 66),  -- Lead: gold
	[3] = Color3.fromRGB(245, 130, 66),  -- CaseBuilt: orange
	[4] = Color3.fromRGB(66, 245, 96),   -- Airtight: green
}

local function createHUD()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "IntelMeterHUD"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = PlayerGui

	-- Main container
	meterFrame = Instance.new("Frame")
	meterFrame.Name = "MeterFrame"
	meterFrame.Size = UDim2.new(0, 300, 0, 80)
	meterFrame.Position = UDim2.new(0.5, -150, 0, 10)
	meterFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	meterFrame.BackgroundTransparency = 0.2
	meterFrame.BorderSizePixel = 0
	meterFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = meterFrame

	-- Tier label
	tierLabel = Instance.new("TextLabel")
	tierLabel.Name = "TierLabel"
	tierLabel.Size = UDim2.new(1, -20, 0, 24)
	tierLabel.Position = UDim2.new(0, 10, 0, 5)
	tierLabel.BackgroundTransparency = 1
	tierLabel.Text = "INTEL: Blind"
	tierLabel.TextColor3 = TIER_COLORS[0]
	tierLabel.TextSize = 16
	tierLabel.Font = Enum.Font.GothamBold
	tierLabel.TextXAlignment = Enum.TextXAlignment.Left
	tierLabel.Parent = meterFrame

	-- Points label
	pointsLabel = Instance.new("TextLabel")
	pointsLabel.Name = "PointsLabel"
	pointsLabel.Size = UDim2.new(0, 80, 0, 24)
	pointsLabel.Position = UDim2.new(1, -90, 0, 5)
	pointsLabel.BackgroundTransparency = 1
	pointsLabel.Text = "0 / 30"
	pointsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	pointsLabel.TextSize = 14
	pointsLabel.Font = Enum.Font.Gotham
	pointsLabel.TextXAlignment = Enum.TextXAlignment.Right
	pointsLabel.Parent = meterFrame

	-- Fill bar background
	local barBg = Instance.new("Frame")
	barBg.Name = "BarBackground"
	barBg.Size = UDim2.new(1, -20, 0, 12)
	barBg.Position = UDim2.new(0, 10, 0, 32)
	barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	barBg.BorderSizePixel = 0
	barBg.Parent = meterFrame

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(0, 4)
	barCorner.Parent = barBg

	-- Fill bar
	fillBar = Instance.new("Frame")
	fillBar.Name = "FillBar"
	fillBar.Size = UDim2.new(0, 0, 1, 0)
	fillBar.BackgroundColor3 = TIER_COLORS[0]
	fillBar.BorderSizePixel = 0
	fillBar.Parent = barBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = fillBar

	-- Breach button
	breachButton = Instance.new("TextButton")
	breachButton.Name = "BreachButton"
	breachButton.Size = UDim2.new(0, 120, 0, 28)
	breachButton.Position = UDim2.new(0.5, -60, 0, 48)
	breachButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	breachButton.Text = "BREACH"
	breachButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	breachButton.TextSize = 14
	breachButton.Font = Enum.Font.GothamBold
	breachButton.BorderSizePixel = 0
	breachButton.Parent = meterFrame

	local breachCorner = Instance.new("UICorner")
	breachCorner.CornerRadius = UDim.new(0, 6)
	breachCorner.Parent = breachButton

	breachButton.MouseButton1Click:Connect(function()
		if not isFrozen then
			local breachRemote = ReplicatedStorage:FindFirstChild("RequestBreach") :: RemoteEvent?
			if breachRemote then
				breachRemote:FireServer()
			end
		end
	end)

	-- Notification label (evidence found feedback)
	notificationLabel = Instance.new("TextLabel")
	notificationLabel.Name = "Notification"
	notificationLabel.Size = UDim2.new(0, 300, 0, 30)
	notificationLabel.Position = UDim2.new(0.5, -150, 0, 95)
	notificationLabel.BackgroundTransparency = 1
	notificationLabel.Text = ""
	notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
	notificationLabel.TextSize = 14
	notificationLabel.Font = Enum.Font.GothamBold
	notificationLabel.TextTransparency = 1
	notificationLabel.Parent = screenGui
end

local function updateDisplay()
	if not fillBar or not tierLabel or not pointsLabel then
		return
	end

	local maxPoints = GameConfig.INTEL_THRESHOLDS[4]
	local fillPct = math.clamp(currentPoints / maxPoints, 0, 1)
	fillBar.Size = UDim2.new(fillPct, 0, 1, 0)

	local tierColor = TIER_COLORS[currentTier] or TIER_COLORS[0]
	fillBar.BackgroundColor3 = tierColor
	tierLabel.TextColor3 = tierColor

	local tierName = GameConfig.INTEL_TIER_REVEALS[currentTier + 1].tierName
	tierLabel.Text = "INTEL: " .. tierName
	pointsLabel.Text = tostring(currentPoints) .. " / " .. tostring(maxPoints)

	if isFrozen and breachButton then
		breachButton.Visible = false
	end
end

local function showNotification(text: string)
	if not notificationLabel then
		return
	end

	notificationLabel.Text = text
	notificationLabel.TextTransparency = 0

	task.spawn(function()
		task.wait(2)
		-- Fade out
		for i = 0, 10 do
			if notificationLabel then
				notificationLabel.TextTransparency = i / 10
			end
			task.wait(0.05)
		end
	end)
end

function IntelMeterHUD.init()
	createHUD()

	-- Listen for server events
	local intelUpdated = ReplicatedStorage:WaitForChild("IntelUpdated", 10) :: RemoteEvent?
	if intelUpdated then
		intelUpdated.OnClientEvent:Connect(function(data: any)
			currentPoints = data.points
			currentTier = data.tier
			updateDisplay()
			showNotification("Evidence found: " .. data.evidenceName .. " (+" .. data.pointValue .. ")")
		end)
	end

	local tierChanged = ReplicatedStorage:WaitForChild("IntelTierChanged", 10) :: RemoteEvent?
	if tierChanged then
		tierChanged.OnClientEvent:Connect(function(data: any)
			currentTier = data.newTier
			updateDisplay()
			showNotification("Intel Tier: " .. data.tierName)
		end)
	end

	local breachInitiated = ReplicatedStorage:WaitForChild("BreachInitiated", 10) :: RemoteEvent?
	if breachInitiated then
		breachInitiated.OnClientEvent:Connect(function(data: any)
			isFrozen = true
			updateDisplay()
		end)
	end
end

function IntelMeterHUD.show()
	if screenGui then
		screenGui.Enabled = true
	end
end

function IntelMeterHUD.hide()
	if screenGui then
		screenGui.Enabled = false
	end
end

function IntelMeterHUD.reset()
	currentPoints = 0
	currentTier = 0
	isFrozen = false
	if breachButton then
		breachButton.Visible = true
	end
	updateDisplay()
end

function IntelMeterHUD.destroy()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

return IntelMeterHUD
