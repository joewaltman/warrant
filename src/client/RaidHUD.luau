--!strict
-- RaidHUD | WARRANT: Case Closed
-- Client-side raid phase HUD: health bar, weapon selector, suspect tracker, minimap overlay

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

local RaidHUD = {}

local screenGui: ScreenGui? = nil
local healthBar: Frame? = nil
local healthFill: Frame? = nil
local healthLabel: TextLabel? = nil
local weaponFrame: Frame? = nil
local weaponLabel: TextLabel? = nil
local suspectCounter: TextLabel? = nil
local timerLabel: TextLabel? = nil
local minimapFrame: Frame? = nil

local currentHealth = 100
local maxHealth = 100
local raidStartTime = 0
local timerConnection: RBXScriptConnection? = nil

local WEAPON_DISPLAY = {
	Taser = { name = "Taser", color = Color3.fromRGB(100, 200, 255) },
	BeanBagGun = { name = "Bean Bag", color = Color3.fromRGB(255, 200, 100) },
	NetGun = { name = "Net Gun", color = Color3.fromRGB(100, 255, 150) },
	Firearm = { name = "Firearm", color = Color3.fromRGB(255, 100, 100) },
}

local function createHUD()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "RaidHUD"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	-- Health bar container (bottom left)
	local healthFrame = Instance.new("Frame")
	healthFrame.Name = "HealthFrame"
	healthFrame.Size = UDim2.new(0, 200, 0, 30)
	healthFrame.Position = UDim2.new(0, 20, 1, -60)
	healthFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	healthFrame.BackgroundTransparency = 0.3
	healthFrame.BorderSizePixel = 0
	healthFrame.Parent = screenGui

	local hCorner = Instance.new("UICorner")
	hCorner.CornerRadius = UDim.new(0, 6)
	hCorner.Parent = healthFrame

	healthFill = Instance.new("Frame")
	healthFill.Name = "Fill"
	healthFill.Size = UDim2.new(1, 0, 1, 0)
	healthFill.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	healthFill.BorderSizePixel = 0
	healthFill.Parent = healthFrame

	local fCorner = Instance.new("UICorner")
	fCorner.CornerRadius = UDim.new(0, 6)
	fCorner.Parent = healthFill

	healthLabel = Instance.new("TextLabel")
	healthLabel.Size = UDim2.new(1, 0, 1, 0)
	healthLabel.BackgroundTransparency = 1
	healthLabel.Text = "100 / 100"
	healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	healthLabel.TextSize = 14
	healthLabel.Font = Enum.Font.GothamBold
	healthLabel.ZIndex = 2
	healthLabel.Parent = healthFrame

	healthBar = healthFrame

	-- Weapon display (bottom center)
	weaponFrame = Instance.new("Frame")
	weaponFrame.Name = "WeaponFrame"
	weaponFrame.Size = UDim2.new(0, 160, 0, 36)
	weaponFrame.Position = UDim2.new(0.5, -80, 1, -60)
	weaponFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	weaponFrame.BackgroundTransparency = 0.3
	weaponFrame.BorderSizePixel = 0
	weaponFrame.Parent = screenGui

	local wCorner = Instance.new("UICorner")
	wCorner.CornerRadius = UDim.new(0, 6)
	wCorner.Parent = weaponFrame

	weaponLabel = Instance.new("TextLabel")
	weaponLabel.Size = UDim2.new(1, 0, 1, 0)
	weaponLabel.BackgroundTransparency = 1
	weaponLabel.Text = "Firearm"
	weaponLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	weaponLabel.TextSize = 16
	weaponLabel.Font = Enum.Font.GothamBold
	weaponLabel.Parent = weaponFrame

	-- Suspect counter (top right)
	suspectCounter = Instance.new("TextLabel")
	suspectCounter.Name = "SuspectCounter"
	suspectCounter.Size = UDim2.new(0, 200, 0, 30)
	suspectCounter.Position = UDim2.new(1, -220, 0, 10)
	suspectCounter.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	suspectCounter.BackgroundTransparency = 0.3
	suspectCounter.Text = "Suspects: ? / ?"
	suspectCounter.TextColor3 = Color3.fromRGB(255, 200, 100)
	suspectCounter.TextSize = 14
	suspectCounter.Font = Enum.Font.GothamBold
	suspectCounter.BorderSizePixel = 0
	suspectCounter.Parent = screenGui

	local sCorner = Instance.new("UICorner")
	sCorner.CornerRadius = UDim.new(0, 6)
	sCorner.Parent = suspectCounter

	-- Raid timer (top center)
	timerLabel = Instance.new("TextLabel")
	timerLabel.Name = "Timer"
	timerLabel.Size = UDim2.new(0, 120, 0, 30)
	timerLabel.Position = UDim2.new(0.5, -60, 0, 10)
	timerLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	timerLabel.BackgroundTransparency = 0.3
	timerLabel.Text = "0:00"
	timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	timerLabel.TextSize = 18
	timerLabel.Font = Enum.Font.GothamBold
	timerLabel.BorderSizePixel = 0
	timerLabel.Parent = screenGui

	local tCorner = Instance.new("UICorner")
	tCorner.CornerRadius = UDim.new(0, 6)
	tCorner.Parent = timerLabel

	-- Minimap placeholder (top left)
	minimapFrame = Instance.new("Frame")
	minimapFrame.Name = "Minimap"
	minimapFrame.Size = UDim2.new(0, 150, 0, 150)
	minimapFrame.Position = UDim2.new(0, 20, 0, 50)
	minimapFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	minimapFrame.BackgroundTransparency = 0.2
	minimapFrame.BorderSizePixel = 0
	minimapFrame.Visible = false
	minimapFrame.Parent = screenGui

	local mCorner = Instance.new("UICorner")
	mCorner.CornerRadius = UDim.new(0, 8)
	mCorner.Parent = minimapFrame
end

function RaidHUD.init()
	createHUD()

	-- Listen for server events
	local healthChanged = ReplicatedStorage:WaitForChild("PlayerHealthChanged", 10) :: RemoteEvent?
	if healthChanged then
		healthChanged.OnClientEvent:Connect(function(data: any)
			RaidHUD.updateHealth(data.health, data.maxHealth)
		end)
	end

	local weaponEquipped = ReplicatedStorage:WaitForChild("WeaponEquipped", 10) :: RemoteEvent?
	if weaponEquipped then
		weaponEquipped.OnClientEvent:Connect(function(weapon: string)
			RaidHUD.updateWeapon(weapon)
		end)
	end

	local raidStarted = ReplicatedStorage:WaitForChild("RaidStarted", 10) :: RemoteEvent?
	if raidStarted then
		raidStarted.OnClientEvent:Connect(function(data: any)
			raidStartTime = tick()
			if data.tierConfig.revealsFloorPlan and minimapFrame then
				minimapFrame.Visible = true
			end
			if data.suspectCount and suspectCounter then
				suspectCounter.Text = "Suspects: 0 / " .. tostring(data.suspectCount)
			end
		end)
	end
end

function RaidHUD.updateHealth(health: number, max: number)
	currentHealth = health
	maxHealth = max

	if healthFill and healthLabel then
		local pct = math.clamp(health / max, 0, 1)
		healthFill.Size = UDim2.new(pct, 0, 1, 0)

		-- Color based on health
		if pct > 0.5 then
			healthFill.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		elseif pct > 0.25 then
			healthFill.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
		else
			healthFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		end

		healthLabel.Text = tostring(math.floor(health)) .. " / " .. tostring(math.floor(max))
	end
end

function RaidHUD.updateWeapon(weapon: string)
	if weaponLabel then
		local info = WEAPON_DISPLAY[weapon]
		if info then
			weaponLabel.Text = info.name
			weaponLabel.TextColor3 = info.color
		else
			weaponLabel.Text = weapon
		end
	end
end

function RaidHUD.updateSuspects(arrested: number, total: number)
	if suspectCounter then
		suspectCounter.Text = "Suspects: " .. tostring(arrested) .. " / " .. tostring(total)
	end
end

function RaidHUD.show()
	if screenGui then
		screenGui.Enabled = true
		raidStartTime = tick()

		-- Start timer heartbeat
		if timerConnection then
			timerConnection:Disconnect()
		end
		timerConnection = RunService.Heartbeat:Connect(function()
			if not timerLabel then
				return
			end
			local elapsed = math.floor(tick() - raidStartTime)
			local minutes = math.floor(elapsed / 60)
			local seconds = elapsed % 60
			timerLabel.Text = string.format("%d:%02d", minutes, seconds)
		end)
	end
end

function RaidHUD.hide()
	if screenGui then
		screenGui.Enabled = false
	end
	if timerConnection then
		timerConnection:Disconnect()
		timerConnection = nil
	end
end

function RaidHUD.destroy()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

return RaidHUD
