--!strict
-- Client entry | WARRANT: Case Closed
-- Initializes all client UI modules and input handling

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

-- Client modules
local UIController = require(script.UIController)
local CaseBoardUI = require(script.CaseBoardUI)
local IntelMeterHUD = require(script.IntelMeterHUD)
local RaidHUD = require(script.RaidHUD)
local SyndicateUI = require(script.SyndicateUI)
local InputHandler = require(script.InputHandler)

print("[Client] WARRANT: Case Closed loading...")

-- Initialize all UI modules
UIController.init()
CaseBoardUI.init()
IntelMeterHUD.init()
RaidHUD.init()
SyndicateUI.init()
InputHandler.init()

-- Register screens with UIController
UIController.registerScreen("CaseBoard", CaseBoardUI)
UIController.registerScreen("Investigation", IntelMeterHUD)
UIController.registerScreen("Raid", RaidHUD)
UIController.registerScreen("Syndicate", SyndicateUI)

-- Mode transitions for input handler
local caseStateChanged = ReplicatedStorage:WaitForChild("CaseStateChanged", 10) :: RemoteEvent?
if caseStateChanged then
	caseStateChanged.OnClientEvent:Connect(function(state: string)
		if state == "Investigating" then
			InputHandler.setMode("Investigation")
			InputHandler.enable()
		elseif state == "Raiding" then
			InputHandler.setMode("Raid")
		elseif state == "Complete" then
			InputHandler.setMode("None")
			InputHandler.disable()
		end
	end)
end

-- Case loaded -> switch to investigation mode
local caseLoaded = ReplicatedStorage:WaitForChild("CaseLoaded", 10) :: RemoteEvent?
if caseLoaded then
	caseLoaded.OnClientEvent:Connect(function(data: any)
		InputHandler.setMode("Investigation")
		InputHandler.enable()
		IntelMeterHUD.show()
	end)
end

-- Breach -> switch to raid mode
local breachInitiated = ReplicatedStorage:WaitForChild("BreachInitiated", 10) :: RemoteEvent?
if breachInitiated then
	breachInitiated.OnClientEvent:Connect(function(data: any)
		InputHandler.setMode("Raid")
		IntelMeterHUD.hide()
		RaidHUD.show()
	end)
end

-- Raid ended -> show scoring
local raidEnded = ReplicatedStorage:WaitForChild("RaidEnded", 10) :: RemoteEvent?
if raidEnded then
	raidEnded.OnClientEvent:Connect(function(data: any)
		InputHandler.disable()
		RaidHUD.hide()
	end)
end

-- Case completed -> return to precinct
local caseCompleted = ReplicatedStorage:WaitForChild("CaseCompleted", 10) :: RemoteEvent?
if caseCompleted then
	caseCompleted.OnClientEvent:Connect(function(data: any)
		IntelMeterHUD.reset()
		InputHandler.setMode("None")
	end)
end

-- Syndicate match found -> switch to syndicate mode
local matchFound = ReplicatedStorage:WaitForChild("MatchFound", 10) :: RemoteEvent?
if matchFound then
	matchFound.OnClientEvent:Connect(function(data: any)
		InputHandler.setMode("Syndicate")
		InputHandler.enable()
	end)
end

print("[Client] WARRANT: Case Closed loaded successfully")
