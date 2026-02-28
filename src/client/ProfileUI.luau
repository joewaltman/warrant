--!strict
-- ProfileUI | WARRANT: Case Closed
-- Criminal Profile screen with Stats, Badges, and Titles tabs

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local ProfileUI = {}

local screenGui: ScreenGui? = nil
local mainFrame: Frame? = nil
local contentFrame: Frame? = nil
local isVisible = false
local profileData: any = nil
local currentTab = "Stats"

local function getRemote(name: string): RemoteEvent?
	local remote = ReplicatedStorage:WaitForChild(name, 10)
	if not remote then return nil end
	return remote :: RemoteEvent
end

local TAB_NAMES = { "Stats", "Badges", "Titles" }

local function clearContent()
	if not contentFrame then return end
	for _, child in contentFrame:GetChildren() do
		child:Destroy()
	end
end

local function xpForLevel(level: number): number
	return math.floor(GameConfig.XP_CURVE.BASE_XP * level ^ GameConfig.XP_CURVE.EXPONENT)
end

local function showStatsTab()
	if not contentFrame or not profileData then return end
	clearContent()

	local stats = profileData.detectiveStats or {}

	-- Level / Rank / XP
	local headerLabel = Instance.new("TextLabel")
	headerLabel.Size = UDim2.new(1, -20, 0, 30)
	headerLabel.Position = UDim2.new(0, 10, 0, 10)
	headerLabel.BackgroundTransparency = 1
	headerLabel.Text = string.format("Level %d | %s", profileData.level or 1, profileData.rank or "Cadet")
	headerLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
	headerLabel.TextSize = 20
	headerLabel.Font = Enum.Font.GothamBold
	headerLabel.TextXAlignment = Enum.TextXAlignment.Left
	headerLabel.Parent = contentFrame

	-- XP bar
	local xpNeeded = xpForLevel(profileData.level or 1)
	local xpProgress = (profileData.xp or 0) % xpNeeded
	local xpPct = math.clamp(xpProgress / math.max(xpNeeded, 1), 0, 1)

	local xpBarBg = Instance.new("Frame")
	xpBarBg.Size = UDim2.new(1, -20, 0, 16)
	xpBarBg.Position = UDim2.new(0, 10, 0, 48)
	xpBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	xpBarBg.BorderSizePixel = 0
	xpBarBg.Parent = contentFrame

	local xpBarCorner = Instance.new("UICorner")
	xpBarCorner.CornerRadius = UDim.new(0, 4)
	xpBarCorner.Parent = xpBarBg

	local xpBarFill = Instance.new("Frame")
	xpBarFill.Size = UDim2.new(xpPct, 0, 1, 0)
	xpBarFill.BackgroundColor3 = Color3.fromRGB(50, 180, 255)
	xpBarFill.BorderSizePixel = 0
	xpBarFill.Parent = xpBarBg

	local xpFillCorner = Instance.new("UICorner")
	xpFillCorner.CornerRadius = UDim.new(0, 4)
	xpFillCorner.Parent = xpBarFill

	local xpText = Instance.new("TextLabel")
	xpText.Size = UDim2.new(1, -20, 0, 16)
	xpText.Position = UDim2.new(0, 10, 0, 68)
	xpText.BackgroundTransparency = 1
	xpText.Text = string.format("%d / %d XP", xpProgress, xpNeeded)
	xpText.TextColor3 = Color3.fromRGB(160, 160, 170)
	xpText.TextSize = 12
	xpText.Font = Enum.Font.Gotham
	xpText.TextXAlignment = Enum.TextXAlignment.Left
	xpText.Parent = contentFrame

	-- Stats grid
	local statItems = {
		{ "Cases Completed", stats.casesCompleted or 0 },
		{ "Evidence Found", stats.totalEvidenceFound or 0 },
		{ "Perfect Raids", stats.perfectRaids or 0 },
		{ "Speed Records", stats.speedRecords or 0 },
		{ "Total XP Earned", stats.totalXPEarned or 0 },
		{ "Highest Intel", stats.highestIntelTier or 0 },
		{ "Favorite District", stats.favoriteDistrict or "None" },
	}

	for i, item in statItems do
		local row = math.floor((i - 1) / 2)
		local col = (i - 1) % 2

		local statFrame = Instance.new("Frame")
		statFrame.Size = UDim2.new(0.48, 0, 0, 40)
		statFrame.Position = UDim2.new(col * 0.5 + 0.01, 0, 0, 100 + row * 46)
		statFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
		statFrame.BorderSizePixel = 0
		statFrame.Parent = contentFrame

		local statCorner = Instance.new("UICorner")
		statCorner.CornerRadius = UDim.new(0, 4)
		statCorner.Parent = statFrame

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -10, 0, 18)
		nameLabel.Position = UDim2.new(0, 8, 0, 2)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = item[1] :: string
		nameLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		nameLabel.TextSize = 11
		nameLabel.Font = Enum.Font.Gotham
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = statFrame

		local valLabel = Instance.new("TextLabel")
		valLabel.Size = UDim2.new(1, -10, 0, 20)
		valLabel.Position = UDim2.new(0, 8, 0, 18)
		valLabel.BackgroundTransparency = 1
		valLabel.Text = tostring(item[2])
		valLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		valLabel.TextSize = 16
		valLabel.Font = Enum.Font.GothamBold
		valLabel.TextXAlignment = Enum.TextXAlignment.Left
		valLabel.Parent = statFrame
	end
end

local function showBadgesTab()
	if not contentFrame or not profileData then return end
	clearContent()

	local earned: { [string]: boolean } = {}
	for _, b in profileData.unlockedBadges or {} do
		earned[b] = true
	end

	for i, badge in GameConfig.BADGE_DEFINITIONS do
		local row = math.floor((i - 1) / 3)
		local col = (i - 1) % 3

		local badgeFrame = Instance.new("Frame")
		badgeFrame.Size = UDim2.new(0.31, 0, 0, 70)
		badgeFrame.Position = UDim2.new(col * 0.33 + 0.01, 0, 0, 10 + row * 78)
		badgeFrame.BackgroundColor3 = if earned[badge.id] then Color3.fromRGB(35, 50, 35) else Color3.fromRGB(30, 30, 35)
		badgeFrame.BorderSizePixel = 0
		badgeFrame.Parent = contentFrame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = badgeFrame

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -10, 0, 20)
		nameLabel.Position = UDim2.new(0, 5, 0, 5)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = badge.name
		nameLabel.TextColor3 = if earned[badge.id] then Color3.fromRGB(100, 255, 100) else Color3.fromRGB(100, 100, 110)
		nameLabel.TextSize = 13
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = badgeFrame

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, -10, 0, 30)
		descLabel.Position = UDim2.new(0, 5, 0, 28)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = badge.description
		descLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
		descLabel.TextSize = 11
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextXAlignment = Enum.TextXAlignment.Left
		descLabel.TextWrapped = true
		descLabel.Parent = badgeFrame
	end
end

local function showTitlesTab()
	if not contentFrame or not profileData then return end
	clearContent()

	local earned: { [string]: boolean } = {}
	for _, t in profileData.unlockedTitles or {} do
		earned[t] = true
	end

	local equippedTitle = profileData.equippedTitle

	for i, title in GameConfig.TITLE_DEFINITIONS do
		local isEarned = earned[title.id] == true
		local isEquipped = equippedTitle == title.id

		local titleFrame = Instance.new("Frame")
		titleFrame.Size = UDim2.new(1, -20, 0, 50)
		titleFrame.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 58)
		titleFrame.BackgroundColor3 = if isEquipped then Color3.fromRGB(40, 55, 80) elseif isEarned then Color3.fromRGB(35, 45, 35) else Color3.fromRGB(30, 30, 35)
		titleFrame.BorderSizePixel = 0
		titleFrame.Parent = contentFrame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = titleFrame

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(0.5, -10, 0, 24)
		nameLabel.Position = UDim2.new(0, 10, 0, 4)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = title.displayName
		nameLabel.TextColor3 = if isEarned then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(100, 100, 110)
		nameLabel.TextSize = 16
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = titleFrame

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(0.5, -10, 0, 20)
		descLabel.Position = UDim2.new(0, 10, 0, 26)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = title.description
		descLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
		descLabel.TextSize = 11
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextXAlignment = Enum.TextXAlignment.Left
		descLabel.Parent = titleFrame

		if isEarned then
			local equipBtn = Instance.new("TextButton")
			equipBtn.Size = UDim2.new(0, 80, 0, 28)
			equipBtn.Position = UDim2.new(1, -90, 0.5, -14)
			equipBtn.BackgroundColor3 = if isEquipped then Color3.fromRGB(80, 160, 80) else Color3.fromRGB(50, 120, 200)
			equipBtn.Text = if isEquipped then "EQUIPPED" else "EQUIP"
			equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			equipBtn.TextSize = 12
			equipBtn.Font = Enum.Font.GothamBold
			equipBtn.BorderSizePixel = 0
			equipBtn.Parent = titleFrame

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 4)
			btnCorner.Parent = equipBtn
		end

		if isEquipped then
			local equippedTag = Instance.new("TextLabel")
			equippedTag.Size = UDim2.new(0, 60, 0, 16)
			equippedTag.Position = UDim2.new(0.5, -30, 0, 4)
			equippedTag.BackgroundTransparency = 1
			equippedTag.Text = "[ACTIVE]"
			equippedTag.TextColor3 = Color3.fromRGB(100, 200, 255)
			equippedTag.TextSize = 11
			equippedTag.Font = Enum.Font.GothamBold
			equippedTag.Parent = titleFrame
		end
	end
end

local function switchTab(tabName: string)
	currentTab = tabName
	if tabName == "Stats" then
		showStatsTab()
	elseif tabName == "Badges" then
		showBadgesTab()
	elseif tabName == "Titles" then
		showTitlesTab()
	end
end

function ProfileUI.init()
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ProfileGui"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 40
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	mainFrame = Instance.new("Frame")
	mainFrame.Name = "ProfileOverlay"
	mainFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
	mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	mainFrame.BackgroundTransparency = 0.05
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 12)
	mainCorner.Parent = mainFrame

	-- Title bar
	local titleBar = Instance.new("Frame")
	titleBar.Size = UDim2.new(1, 0, 0, 50)
	titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	titleBar.BorderSizePixel = 0
	titleBar.Parent = mainFrame

	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 12)
	titleCorner.Parent = titleBar

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
	titleLabel.Position = UDim2.new(0, 16, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "CRIMINAL PROFILE"
	titleLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
	titleLabel.TextSize = 20
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = titleBar

	-- Close button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 40, 0, 40)
	closeBtn.Position = UDim2.new(1, -45, 0, 5)
	closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.TextSize = 18
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.BorderSizePixel = 0
	closeBtn.Parent = titleBar

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 6)
	closeCorner.Parent = closeBtn

	closeBtn.MouseButton1Click:Connect(function()
		ProfileUI.hide()
	end)

	-- Tab bar
	local tabBar = Instance.new("Frame")
	tabBar.Size = UDim2.new(1, 0, 0, 36)
	tabBar.Position = UDim2.new(0, 0, 0, 52)
	tabBar.BackgroundTransparency = 1
	tabBar.Parent = mainFrame

	for i, tabName in TAB_NAMES do
		local tabBtn = Instance.new("TextButton")
		tabBtn.Size = UDim2.new(0, 100, 0, 30)
		tabBtn.Position = UDim2.new(0, 10 + (i - 1) * 110, 0, 3)
		tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
		tabBtn.Text = tabName
		tabBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
		tabBtn.TextSize = 14
		tabBtn.Font = Enum.Font.GothamBold
		tabBtn.BorderSizePixel = 0
		tabBtn.Name = "Tab_" .. tabName
		tabBtn.Parent = tabBar

		local tabCorner = Instance.new("UICorner")
		tabCorner.CornerRadius = UDim.new(0, 6)
		tabCorner.Parent = tabBtn

		tabBtn.MouseButton1Click:Connect(function()
			switchTab(tabName)
		end)
	end

	-- Content area
	contentFrame = Instance.new("ScrollingFrame")
	contentFrame.Name = "Content"
	contentFrame.Size = UDim2.new(1, -20, 1, -100)
	contentFrame.Position = UDim2.new(0, 10, 0, 92)
	contentFrame.BackgroundTransparency = 1
	contentFrame.BorderSizePixel = 0
	contentFrame.ScrollBarThickness = 6
	contentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
	contentFrame.Parent = mainFrame

	-- Listen for profile data
	local profileRemote = getRemote("ProfileDataLoaded")
	if profileRemote then
		profileRemote.OnClientEvent:Connect(function(data: any)
			profileData = data
			if isVisible then
				switchTab(currentTab)
			end
		end)
	end

	print("[ProfileUI] Initialized")
end

function ProfileUI.show()
	if not screenGui then return end

	-- Request fresh data
	local requestRemote = getRemote("RequestProfileData")
	if requestRemote then
		requestRemote:FireServer()
	end

	screenGui.Enabled = true
	isVisible = true

	if profileData then
		switchTab(currentTab)
	end
end

function ProfileUI.hide()
	if screenGui then
		screenGui.Enabled = false
		isVisible = false
	end
end

function ProfileUI.toggle()
	if isVisible then
		ProfileUI.hide()
	else
		ProfileUI.show()
	end
end

return ProfileUI
