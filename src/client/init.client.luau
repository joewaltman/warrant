--!strict
-- Client entry | WARRANT: Case Closed
-- Initializes all client UI modules and input handling

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("[Client] WARRANT: Case Closed loading...")

------------------------------------------------------------------------
-- STEP 1: Wait for shared modules (these exist via Rojo sync)
------------------------------------------------------------------------
local Shared = ReplicatedStorage:WaitForChild("Shared", 10)
if not Shared then
	warn("[Client] Shared folder not found in ReplicatedStorage")
	return
end

local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

print("[Client] Shared modules loaded")

------------------------------------------------------------------------
-- STEP 2: Helper to safely get remotes (with timeout)
------------------------------------------------------------------------
local function getRemote(name: string): RemoteEvent?
	local remote = ReplicatedStorage:WaitForChild(name, 10)
	if not remote then
		warn("[Client] Remote not found:", name)
		return nil
	end
	return remote :: RemoteEvent
end

------------------------------------------------------------------------
-- STEP 3: Load client modules
------------------------------------------------------------------------
local UIController = require(script.UIController)
local CaseBoardUI = require(script.CaseBoardUI)
local IntelMeterHUD = require(script.IntelMeterHUD)
local RaidHUD = require(script.RaidHUD)
local SyndicateUI = require(script.SyndicateUI)
local InputHandler = require(script.InputHandler)
local ScoreScreen = require(script.ScoreScreen)
local ProfileUI = require(script.ProfileUI)
local EvidenceVisuals = require(script.EvidenceVisuals)
local TutorialOverlay = require(script.TutorialOverlay)

print("[Client] Client modules loaded")

------------------------------------------------------------------------
-- STEP 4: Initialize UI modules
------------------------------------------------------------------------
UIController.init()
CaseBoardUI.init()
IntelMeterHUD.init()
RaidHUD.init()
SyndicateUI.init()
InputHandler.init()
ScoreScreen.init()
ProfileUI.init()
EvidenceVisuals.init()
TutorialOverlay.init()

UIController.registerScreen("CaseBoard", CaseBoardUI)
UIController.registerScreen("Investigation", IntelMeterHUD)
UIController.registerScreen("Raid", RaidHUD)
UIController.registerScreen("Syndicate", SyndicateUI)
UIController.registerScreen("Scoring", ScoreScreen)

print("[Client] UI initialized")

------------------------------------------------------------------------
-- STEP 5: PERSISTENT CASE BOARD BUTTON (always visible in precinct)
------------------------------------------------------------------------
local caseBoardButtonGui = Instance.new("ScreenGui")
caseBoardButtonGui.Name = "CaseBoardButtonGui"
caseBoardButtonGui.ResetOnSpawn = false
caseBoardButtonGui.DisplayOrder = 5
caseBoardButtonGui.Parent = PlayerGui

local caseBoardBtn = Instance.new("TextButton")
caseBoardBtn.Name = "OpenCaseBoard"
caseBoardBtn.Size = UDim2.new(0, 180, 0, 44)
caseBoardBtn.Position = UDim2.new(0, 20, 1, -60)
caseBoardBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
caseBoardBtn.Text = "CASE BOARD"
caseBoardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
caseBoardBtn.TextSize = 16
caseBoardBtn.Font = Enum.Font.GothamBold
caseBoardBtn.BorderSizePixel = 0
caseBoardBtn.Parent = caseBoardButtonGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = caseBoardBtn

local btnIcon = Instance.new("TextLabel")
btnIcon.Size = UDim2.new(0, 30, 1, 0)
btnIcon.BackgroundTransparency = 1
btnIcon.Text = "[B]"
btnIcon.TextColor3 = Color3.fromRGB(200, 220, 255)
btnIcon.TextSize = 12
btnIcon.Font = Enum.Font.Gotham
btnIcon.Parent = caseBoardBtn

-- Profile button (next to case board button)
local profileBtn = Instance.new("TextButton")
profileBtn.Name = "OpenProfile"
profileBtn.Size = UDim2.new(0, 140, 0, 44)
profileBtn.Position = UDim2.new(0, 210, 1, -60)
profileBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 160)
profileBtn.Text = "PROFILE [P]"
profileBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
profileBtn.TextSize = 16
profileBtn.Font = Enum.Font.GothamBold
profileBtn.BorderSizePixel = 0
profileBtn.Parent = caseBoardButtonGui

local profileBtnCorner = Instance.new("UICorner")
profileBtnCorner.CornerRadius = UDim.new(0, 8)
profileBtnCorner.Parent = profileBtn

profileBtn.MouseButton1Click:Connect(function()
	ProfileUI.toggle()
end)

local inCase = false

local function showCaseBoard()
	if inCase then
		return
	end

	-- Load cases from ReplicatedStorage
	local cases: { any } = {}
	local casesFolder = ReplicatedStorage:FindFirstChild("Cases")
	if casesFolder then
		for _, district in casesFolder:GetChildren() do
			if district:IsA("Folder") then
				for _, caseFolder in district:GetChildren() do
					local configModule = caseFolder:FindFirstChild("CaseConfig")
					if configModule and configModule:IsA("ModuleScript") then
						local success, config = pcall(require, configModule)
						if success and config.getData then
							table.insert(cases, config.getData())
						end
					end
				end
			end
		end
	end

	CaseBoardUI.setCases(cases)
	CaseBoardUI.show()
end

caseBoardBtn.MouseButton1Click:Connect(showCaseBoard)

-- B keybind to open case board
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.B and not inCase then
		showCaseBoard()
	elseif input.KeyCode == Enum.KeyCode.P then
		ProfileUI.toggle()
	end
end)

-- Server can also tell us to open the case board (ProximityPrompt)
local openBoardRemote = getRemote("OpenCaseBoard")
if openBoardRemote then
	openBoardRemote.OnClientEvent:Connect(function()
		showCaseBoard()
	end)
end

------------------------------------------------------------------------
-- STEP 6: CASE LIFECYCLE EVENT WIRING
------------------------------------------------------------------------

-- Case loaded -> hide case board, enter investigation
local caseLoaded = getRemote("CaseLoaded")
if caseLoaded then
	caseLoaded.OnClientEvent:Connect(function(data: any)
		inCase = true
		CaseBoardUI.hide()
		caseBoardBtn.Visible = false
		InputHandler.setMode("Investigation")
		InputHandler.enable()
		IntelMeterHUD.show()
		UIController.showNotification("Case Loaded", data.caseName)
		TutorialOverlay.onCaseLoaded()
	end)
end

-- Case state changes
local caseStateChanged = getRemote("CaseStateChanged")
if caseStateChanged then
	caseStateChanged.OnClientEvent:Connect(function(state: string)
		if state == "Investigating" then
			InputHandler.setMode("Investigation")
			InputHandler.enable()
		elseif state == "Raiding" then
			InputHandler.setMode("Raid")
		elseif state == "Scoring" then
			InputHandler.disable()
		elseif state == "Complete" then
			InputHandler.setMode("None")
			InputHandler.disable()
		end
	end)
end

-- Breach -> switch to raid HUD
local breachInitiated = getRemote("BreachInitiated")
if breachInitiated then
	breachInitiated.OnClientEvent:Connect(function(data: any)
		InputHandler.setMode("Raid")
		IntelMeterHUD.hide()
		RaidHUD.show()
		TutorialOverlay.onBreach()
		-- Slight delay for raid tutorial step
		task.delay(2, function()
			TutorialOverlay.onRaid()
		end)
	end)
end

-- Raid ended
local raidEnded = getRemote("RaidEnded")
if raidEnded then
	raidEnded.OnClientEvent:Connect(function(data: any)
		InputHandler.disable()
		RaidHUD.hide()
	end)
end

-- Case completed -> return to precinct mode
local caseCompleted = getRemote("CaseCompleted")
if caseCompleted then
	caseCompleted.OnClientEvent:Connect(function(data: any)
		inCase = false
		IntelMeterHUD.reset()
		IntelMeterHUD.hide()
		RaidHUD.hide()
		ScoreScreen.hide()
		EvidenceVisuals.reset()
		caseBoardBtn.Visible = true
		InputHandler.setMode("None")
		UIController.showNotification("Case Complete", "Earned " .. tostring(data.totalXP) .. " XP")
	end)
end

-- Level up / Rank up
local levelUp = getRemote("LevelUp")
if levelUp then
	levelUp.OnClientEvent:Connect(function(data: any)
		UIController.showNotification("Level Up!", "You are now level " .. tostring(data.newLevel), 5)
	end)
end

local rankUp = getRemote("RankUp")
if rankUp then
	rankUp.OnClientEvent:Connect(function(data: any)
		UIController.showNotification("Rank Up!", "You are now a " .. data.newRank, 7)
	end)
end

-- Score screen
local scorePresented = getRemote("ScorePresented")
if scorePresented then
	scorePresented.OnClientEvent:Connect(function(data: any)
		ScoreScreen.showScore(data)
	end)
end

-- Evidence visuals
local evidencePositions = getRemote("EvidencePositions")
if evidencePositions then
	evidencePositions.OnClientEvent:Connect(function(positions: any)
		EvidenceVisuals.loadPositions(positions)
	end)
end

-- Wire intel updates to remove discovered evidence markers
local intelUpdated = getRemote("IntelUpdated")
if intelUpdated then
	intelUpdated.OnClientEvent:Connect(function(data: any)
		if data and data.evidenceId then
			EvidenceVisuals.onEvidenceDiscovered(data.evidenceId)
			TutorialOverlay.onNearEvidence()
		end
		-- After discovering some evidence, hint about breach
		if data and data.points and data.points >= 10 then
			TutorialOverlay.onSomeEvidence()
		end
	end)
end

-- Player data loaded — check tutorial
local playerDataLoaded = getRemote("PlayerDataLoaded")
if playerDataLoaded then
	playerDataLoaded.OnClientEvent:Connect(function(data: any)
		TutorialOverlay.checkFirstTime(data)
	end)
end

-- Syndicate
local matchFound = getRemote("MatchFound")
if matchFound then
	matchFound.OnClientEvent:Connect(function(data: any)
		InputHandler.setMode("Syndicate")
		InputHandler.enable()
	end)
end

print("[Client] WARRANT: Case Closed loaded successfully")
