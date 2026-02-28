--!strict
-- CaseBoardUI | WARRANT: Case Closed
-- Case selection interface: grid of case cards, filtering by district/difficulty/crime type

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type CaseData = Types.CaseData

export type FilterState = {
	district: string?,
	difficulty: number?,
	crimeType: string?,
}

local CaseBoardUI = {}

local screenGui: ScreenGui? = nil
local boardFrame: Frame? = nil
local cardContainer: Frame? = nil
local filterFrame: Frame? = nil

local allCases: { CaseData } = {}
local currentFilter: FilterState = {
	district = nil,
	difficulty = nil,
	crimeType = nil,
}

local DIFFICULTY_COLORS = {
	[1] = Color3.fromRGB(80, 200, 80),   -- Easy: green
	[2] = Color3.fromRGB(200, 200, 80),  -- Medium: yellow
	[3] = Color3.fromRGB(200, 130, 60),  -- Hard: orange
	[4] = Color3.fromRGB(200, 60, 60),   -- Expert: red
}

local DIFFICULTY_NAMES = {
	[1] = "Rookie",
	[2] = "Standard",
	[3] = "Veteran",
	[4] = "Expert",
}

local function createCaseCard(caseData: CaseData, index: number): Frame
	local card = Instance.new("Frame")
	card.Name = "Case_" .. caseData.caseId
	card.Size = UDim2.new(0, 220, 0, 140)
	card.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	card.BorderSizePixel = 0

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = card

	-- Difficulty stripe
	local stripe = Instance.new("Frame")
	stripe.Size = UDim2.new(1, 0, 0, 4)
	stripe.Position = UDim2.new(0, 0, 0, 0)
	stripe.BackgroundColor3 = DIFFICULTY_COLORS[caseData.difficulty] or DIFFICULTY_COLORS[1]
	stripe.BorderSizePixel = 0
	stripe.Parent = card

	-- Case name
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -16, 0, 24)
	nameLabel.Position = UDim2.new(0, 8, 0, 12)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = caseData.caseName
	nameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
	nameLabel.TextSize = 14
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
	nameLabel.Parent = card

	-- District
	local districtLabel = Instance.new("TextLabel")
	districtLabel.Size = UDim2.new(1, -16, 0, 18)
	districtLabel.Position = UDim2.new(0, 8, 0, 38)
	districtLabel.BackgroundTransparency = 1
	districtLabel.Text = caseData.district
	districtLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
	districtLabel.TextSize = 12
	districtLabel.Font = Enum.Font.Gotham
	districtLabel.TextXAlignment = Enum.TextXAlignment.Left
	districtLabel.Parent = card

	-- Crime type
	local crimeLabel = Instance.new("TextLabel")
	crimeLabel.Size = UDim2.new(0.5, -8, 0, 18)
	crimeLabel.Position = UDim2.new(0, 8, 0, 60)
	crimeLabel.BackgroundTransparency = 1
	crimeLabel.Text = caseData.crimeType
	crimeLabel.TextColor3 = Color3.fromRGB(180, 160, 140)
	crimeLabel.TextSize = 11
	crimeLabel.Font = Enum.Font.Gotham
	crimeLabel.TextXAlignment = Enum.TextXAlignment.Left
	crimeLabel.Parent = card

	-- Difficulty badge
	local diffLabel = Instance.new("TextLabel")
	diffLabel.Size = UDim2.new(0.5, -8, 0, 18)
	diffLabel.Position = UDim2.new(0.5, 0, 0, 60)
	diffLabel.BackgroundTransparency = 1
	diffLabel.Text = DIFFICULTY_NAMES[caseData.difficulty] or "Unknown"
	diffLabel.TextColor3 = DIFFICULTY_COLORS[caseData.difficulty] or DIFFICULTY_COLORS[1]
	diffLabel.TextSize = 11
	diffLabel.Font = Enum.Font.GothamBold
	diffLabel.TextXAlignment = Enum.TextXAlignment.Right
	diffLabel.Parent = card

	-- XP reward
	local xpLabel = Instance.new("TextLabel")
	xpLabel.Size = UDim2.new(1, -16, 0, 18)
	xpLabel.Position = UDim2.new(0, 8, 0, 82)
	xpLabel.BackgroundTransparency = 1
	xpLabel.Text = "XP: " .. tostring(caseData.xpReward)
	xpLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	xpLabel.TextSize = 12
	xpLabel.Font = Enum.Font.Gotham
	xpLabel.TextXAlignment = Enum.TextXAlignment.Left
	xpLabel.Parent = card

	-- Select button
	local selectBtn = Instance.new("TextButton")
	selectBtn.Size = UDim2.new(1, -16, 0, 28)
	selectBtn.Position = UDim2.new(0, 8, 1, -36)
	selectBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
	selectBtn.Text = "SELECT CASE"
	selectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	selectBtn.TextSize = 12
	selectBtn.Font = Enum.Font.GothamBold
	selectBtn.BorderSizePixel = 0
	selectBtn.Parent = card

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = selectBtn

	selectBtn.MouseButton1Click:Connect(function()
		local remote = ReplicatedStorage:FindFirstChild("RequestCase") :: RemoteEvent?
		if remote then
			remote:FireServer(caseData.caseId)
		end
	end)

	return card
end

local function getFilteredCases(): { CaseData }
	local filtered: { CaseData } = {}
	for _, caseData in allCases do
		local pass = true
		if currentFilter.district and caseData.district ~= currentFilter.district then
			pass = false
		end
		if currentFilter.difficulty and caseData.difficulty ~= currentFilter.difficulty then
			pass = false
		end
		if currentFilter.crimeType and caseData.crimeType ~= currentFilter.crimeType then
			pass = false
		end
		if pass then
			table.insert(filtered, caseData)
		end
	end
	return filtered
end

local function refreshCards()
	if not cardContainer then
		return
	end

	-- Clear existing cards
	for _, child in cardContainer:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	local cases = getFilteredCases()
	for i, caseData in cases do
		local card = createCaseCard(caseData, i)
		card.Parent = cardContainer
	end
end

local function createBoard()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CaseBoardUI"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	-- Main board frame
	boardFrame = Instance.new("Frame")
	boardFrame.Name = "BoardFrame"
	boardFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
	boardFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
	boardFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	boardFrame.BackgroundTransparency = 0.05
	boardFrame.BorderSizePixel = 0
	boardFrame.Parent = screenGui

	local boardCorner = Instance.new("UICorner")
	boardCorner.CornerRadius = UDim.new(0, 12)
	boardCorner.Parent = boardFrame

	-- Title
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.Text = "CASE BOARD"
	title.TextColor3 = Color3.fromRGB(255, 220, 100)
	title.TextSize = 24
	title.Font = Enum.Font.GothamBold
	title.Parent = boardFrame

	-- Filter bar
	filterFrame = Instance.new("Frame")
	filterFrame.Name = "Filters"
	filterFrame.Size = UDim2.new(1, -20, 0, 36)
	filterFrame.Position = UDim2.new(0, 10, 0, 50)
	filterFrame.BackgroundTransparency = 1
	filterFrame.Parent = boardFrame

	-- Difficulty filter buttons
	local filterLayout = Instance.new("UIListLayout")
	filterLayout.FillDirection = Enum.FillDirection.Horizontal
	filterLayout.Padding = UDim.new(0, 8)
	filterLayout.Parent = filterFrame

	local allBtn = Instance.new("TextButton")
	allBtn.Size = UDim2.new(0, 60, 1, 0)
	allBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	allBtn.Text = "All"
	allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	allBtn.TextSize = 12
	allBtn.Font = Enum.Font.GothamBold
	allBtn.BorderSizePixel = 0
	allBtn.Parent = filterFrame
	allBtn.MouseButton1Click:Connect(function()
		currentFilter.difficulty = nil
		refreshCards()
	end)

	local allCorner = Instance.new("UICorner")
	allCorner.CornerRadius = UDim.new(0, 6)
	allCorner.Parent = allBtn

	for diff = 1, 4 do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 80, 1, 0)
		btn.BackgroundColor3 = DIFFICULTY_COLORS[diff]
		btn.Text = DIFFICULTY_NAMES[diff]
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 12
		btn.Font = Enum.Font.GothamBold
		btn.BorderSizePixel = 0
		btn.Parent = filterFrame

		local btnC = Instance.new("UICorner")
		btnC.CornerRadius = UDim.new(0, 6)
		btnC.Parent = btn

		local d = diff
		btn.MouseButton1Click:Connect(function()
			currentFilter.difficulty = d
			refreshCards()
		end)
	end

	-- Card container with grid layout
	cardContainer = Instance.new("Frame")
	cardContainer.Name = "Cards"
	cardContainer.Size = UDim2.new(1, -20, 1, -100)
	cardContainer.Position = UDim2.new(0, 10, 0, 96)
	cardContainer.BackgroundTransparency = 1
	cardContainer.ClipsDescendants = true
	cardContainer.Parent = boardFrame

	local gridLayout = Instance.new("UIGridLayout")
	gridLayout.CellSize = UDim2.new(0, 220, 0, 140)
	gridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
	gridLayout.FillDirection = Enum.FillDirection.Horizontal
	gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	gridLayout.Parent = cardContainer

	-- Close button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 36, 0, 36)
	closeBtn.Position = UDim2.new(1, -46, 0, 10)
	closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.TextSize = 18
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.BorderSizePixel = 0
	closeBtn.Parent = boardFrame

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 6)
	closeCorner.Parent = closeBtn

	closeBtn.MouseButton1Click:Connect(function()
		CaseBoardUI.hide()
	end)
end

function CaseBoardUI.init()
	createBoard()
end

function CaseBoardUI.setCases(cases: { CaseData })
	allCases = cases
	refreshCards()
end

function CaseBoardUI.setFilter(filter: FilterState)
	currentFilter = filter
	refreshCards()
end

function CaseBoardUI.show()
	if screenGui then
		screenGui.Enabled = true
		refreshCards()
	end
end

function CaseBoardUI.hide()
	if screenGui then
		screenGui.Enabled = false
	end
end

function CaseBoardUI.destroy()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

return CaseBoardUI
