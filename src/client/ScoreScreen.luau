--!strict
-- ScoreScreen | WARRANT: Case Closed
-- Animated score breakdown overlay shown after case completion

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local ScoreScreen = {}

local screenGui: ScreenGui? = nil
local mainFrame: Frame? = nil
local isVisible = false

function ScoreScreen.init()
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ScoreScreenGui"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 50
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	mainFrame = Instance.new("Frame")
	mainFrame.Name = "ScoreOverlay"
	mainFrame.Size = UDim2.new(1, 0, 1, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
	mainFrame.BackgroundTransparency = 0.15
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	print("[ScoreScreen] Initialized")
end

local function clearContent()
	if not mainFrame then return end
	for _, child in mainFrame:GetChildren() do
		child:Destroy()
	end
end

local function getGrade(totalXP: number, maxXP: number): (string, number)
	if maxXP <= 0 then
		return "F", 1
	end
	local pct = totalXP / maxXP
	for _, grade in GameConfig.SCORE_GRADES do
		if pct >= grade.minPct then
			return grade.letter, grade.stars
		end
	end
	return "F", 1
end

local function createLineItem(parent: Frame, yOffset: number, label: string, value: number, isNegative: boolean?): TextLabel
	local row = Instance.new("Frame")
	row.Size = UDim2.new(0, 400, 0, 30)
	row.Position = UDim2.new(0.5, -200, 0, yOffset)
	row.BackgroundTransparency = 1
	row.Parent = parent

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = label
	nameLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
	nameLabel.TextSize = 16
	nameLabel.Font = Enum.Font.Gotham
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = row

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0.4, 0, 1, 0)
	valueLabel.Position = UDim2.new(0.6, 0, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.TextSize = 16
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.BackgroundTransparency = 1
	valueLabel.Parent = row

	if isNegative and value > 0 then
		valueLabel.Text = "-" .. tostring(value) .. " XP"
		valueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	else
		valueLabel.Text = "+" .. tostring(value) .. " XP"
		valueLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
	end

	-- Start invisible for animation
	nameLabel.TextTransparency = 1
	valueLabel.TextTransparency = 1

	return valueLabel
end

function ScoreScreen.showScore(data: any)
	if not screenGui or not mainFrame then return end

	clearContent()
	screenGui.Enabled = true
	isVisible = true

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0, 400, 0, 50)
	title.Position = UDim2.new(0.5, -200, 0, 60)
	title.BackgroundTransparency = 1
	title.Text = "CASE COMPLETE"
	title.TextColor3 = Color3.fromRGB(255, 220, 100)
	title.TextSize = 32
	title.Font = Enum.Font.GothamBold
	title.Parent = mainFrame

	-- Line items
	local lineItems = {
		{ label = "Investigation XP", value = data.investigationXP or 0, negative = false },
		{ label = "Raid Bonus", value = data.raidDifficultyBonus or 0, negative = false },
		{ label = "Non-Lethal Bonus", value = data.nonLethalBonus or 0, negative = false },
		{ label = "Speed Bonus", value = data.speedBonus or 0, negative = false },
		{ label = "Collateral Penalty", value = data.collateralPenalty or 0, negative = true },
	}

	local yStart = 140
	local createdLabels: { TextLabel } = {}

	for i, item in lineItems do
		local label = createLineItem(mainFrame, yStart + (i - 1) * 38, item.label, item.value, item.negative)
		table.insert(createdLabels, label)
	end

	-- Multiplier line
	local multRow = Instance.new("Frame")
	multRow.Size = UDim2.new(0, 400, 0, 30)
	multRow.Position = UDim2.new(0.5, -200, 0, yStart + #lineItems * 38 + 10)
	multRow.BackgroundTransparency = 1
	multRow.Parent = mainFrame

	local multLabel = Instance.new("TextLabel")
	multLabel.Size = UDim2.new(0.6, 0, 1, 0)
	multLabel.BackgroundTransparency = 1
	multLabel.Text = "Case Multiplier"
	multLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
	multLabel.TextSize = 16
	multLabel.Font = Enum.Font.Gotham
	multLabel.TextXAlignment = Enum.TextXAlignment.Left
	multLabel.TextTransparency = 1
	multLabel.Parent = multRow

	local multValue = Instance.new("TextLabel")
	multValue.Size = UDim2.new(0.4, 0, 1, 0)
	multValue.Position = UDim2.new(0.6, 0, 0, 0)
	multValue.BackgroundTransparency = 1
	multValue.Text = string.format("x%.1f", data.caseScoreMultiplier or 1)
	multValue.TextColor3 = Color3.fromRGB(180, 180, 255)
	multValue.TextSize = 16
	multValue.Font = Enum.Font.GothamBold
	multValue.TextXAlignment = Enum.TextXAlignment.Right
	multValue.TextTransparency = 1
	multValue.Parent = multRow

	-- Separator
	local sep = Instance.new("Frame")
	sep.Size = UDim2.new(0, 400, 0, 2)
	sep.Position = UDim2.new(0.5, -200, 0, yStart + #lineItems * 38 + 50)
	sep.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
	sep.BorderSizePixel = 0
	sep.BackgroundTransparency = 1
	sep.Parent = mainFrame

	-- Total
	local totalLabel = Instance.new("TextLabel")
	totalLabel.Size = UDim2.new(0, 400, 0, 40)
	totalLabel.Position = UDim2.new(0.5, -200, 0, yStart + #lineItems * 38 + 60)
	totalLabel.BackgroundTransparency = 1
	totalLabel.Text = "TOTAL: " .. tostring(data.totalXP or 0) .. " XP"
	totalLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	totalLabel.TextSize = 24
	totalLabel.Font = Enum.Font.GothamBold
	totalLabel.TextTransparency = 1
	totalLabel.Parent = mainFrame

	-- Grade
	local letter, stars = getGrade(data.totalXP or 0, data.maxPossibleXP or 1)

	local gradeLabel = Instance.new("TextLabel")
	gradeLabel.Size = UDim2.new(0, 120, 0, 120)
	gradeLabel.Position = UDim2.new(0.5, -60, 0, yStart + #lineItems * 38 + 110)
	gradeLabel.BackgroundTransparency = 1
	gradeLabel.Text = letter
	gradeLabel.TextColor3 = if letter == "S" then Color3.fromRGB(255, 215, 0)
		elseif letter == "A" then Color3.fromRGB(100, 255, 100)
		elseif letter == "B" then Color3.fromRGB(100, 200, 255)
		else Color3.fromRGB(200, 200, 200)
	gradeLabel.TextSize = 72
	gradeLabel.Font = Enum.Font.GothamBold
	gradeLabel.TextTransparency = 1
	gradeLabel.Parent = mainFrame

	-- Stars
	local starText = string.rep("*", stars)
	local starLabel = Instance.new("TextLabel")
	starLabel.Size = UDim2.new(0, 200, 0, 30)
	starLabel.Position = UDim2.new(0.5, -100, 0, yStart + #lineItems * 38 + 230)
	starLabel.BackgroundTransparency = 1
	starLabel.Text = starText
	starLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
	starLabel.TextSize = 28
	starLabel.Font = Enum.Font.GothamBold
	starLabel.TextTransparency = 1
	starLabel.Parent = mainFrame

	-- Continue button
	local continueBtn = Instance.new("TextButton")
	continueBtn.Size = UDim2.new(0, 200, 0, 44)
	continueBtn.Position = UDim2.new(0.5, -100, 0, yStart + #lineItems * 38 + 280)
	continueBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
	continueBtn.Text = "CONTINUE"
	continueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	continueBtn.TextSize = 16
	continueBtn.Font = Enum.Font.GothamBold
	continueBtn.BorderSizePixel = 0
	continueBtn.TextTransparency = 1
	continueBtn.BackgroundTransparency = 1
	continueBtn.Parent = mainFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = continueBtn

	continueBtn.MouseButton1Click:Connect(function()
		ScoreScreen.hide()
	end)

	-- Animate line items appearing sequentially
	task.spawn(function()
		task.wait(0.3)

		-- Animate each line item
		for i, item in lineItems do
			local row = mainFrame:GetChildren()[i + 1] -- +1 for title
			if row and row:IsA("Frame") then
				for _, child in row:GetChildren() do
					if child:IsA("TextLabel") then
						child.TextTransparency = 0
					end
				end
			end
			task.wait(0.4)
		end

		-- Multiplier
		task.wait(0.3)
		multLabel.TextTransparency = 0
		multValue.TextTransparency = 0

		-- Separator
		task.wait(0.2)
		sep.BackgroundTransparency = 0

		-- Total
		task.wait(0.3)
		totalLabel.TextTransparency = 0

		-- Grade
		task.wait(0.5)
		gradeLabel.TextTransparency = 0

		-- Stars
		task.wait(0.3)
		starLabel.TextTransparency = 0

		-- Continue button
		task.wait(0.3)
		continueBtn.TextTransparency = 0
		continueBtn.BackgroundTransparency = 0
	end)
end

function ScoreScreen.show()
	if screenGui then
		screenGui.Enabled = true
		isVisible = true
	end
end

function ScoreScreen.hide()
	if screenGui then
		screenGui.Enabled = false
		isVisible = false
	end
	clearContent()
end

return ScoreScreen
