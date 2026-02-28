--!strict
-- CaseManager | WARRANT: Case Closed
-- Manages the full case lifecycle: loading, spawning, investigation, breach, completion
-- Supports multi-player (party) cases: all party members share one layout.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

type CaseData = Types.CaseData

export type CaseState = "Loading" | "Investigating" | "Raiding" | "Scoring" | "Complete"

export type ActiveCase = {
	caseData: CaseData,
	player: Player,
	state: CaseState,
	layoutModel: Model?,
	startTime: number,
	breachTime: number?,
}

local CaseManager = {}

local activeCases: { [number]: ActiveCase } = {}
local caseCooldowns: { [string]: number } = {}
local COOLDOWN_SECONDS = 300

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

local function getCaseModules(caseId: string): Folder?
	local Cases = ReplicatedStorage:FindFirstChild("Cases")
	if not Cases then
		return nil
	end
	for _, district in Cases:GetChildren() do
		if district:IsA("Folder") then
			for _, caseFolder in district:GetChildren() do
				if caseFolder:IsA("Folder") then
					local configModule = caseFolder:FindFirstChild("CaseConfig")
					if configModule and configModule:IsA("ModuleScript") then
						local config = require(configModule) :: any
						if config.getData then
							local data = config.getData()
							if data.caseId == caseId then
								return caseFolder
							end
						end
					end
				end
			end
		end
	end
	return nil
end

function CaseManager.isOnCooldown(player: Player, caseId: string): boolean
	local key = tostring(player.UserId) .. "_" .. caseId
	local cooldownEnd = caseCooldowns[key]
	if cooldownEnd and tick() < cooldownEnd then
		return true
	end
	return false
end

function CaseManager.loadCase(players: { Player }, caseId: string, layoutModel: Model?): (boolean, string?)
	-- Check if any player already has an active case
	for _, player in players do
		if activeCases[player.UserId] then
			return false, "Player " .. player.Name .. " already has an active case"
		end
	end

	local caseFolder = getCaseModules(caseId)
	if not caseFolder then
		return false, "Case not found: " .. caseId
	end

	local configModule = caseFolder:FindFirstChild("CaseConfig") :: ModuleScript
	local config = require(configModule) :: any
	local caseData: CaseData = config.getData()

	-- Create an ActiveCase record for each player pointing to the same layoutModel
	for _, player in players do
		local activeCase: ActiveCase = {
			caseData = caseData,
			player = player,
			state = "Loading" :: CaseState,
			layoutModel = layoutModel,
			startTime = tick(),
			breachTime = nil,
		}
		activeCases[player.UserId] = activeCase
		activeCase.state = "Investigating"

		getRemote("CaseLoaded"):FireClient(player, {
			caseId = caseData.caseId,
			caseName = caseData.caseName,
			district = caseData.district,
			crimeType = caseData.crimeType,
			difficulty = caseData.difficulty,
		})
	end

	local playerNames = {}
	for _, player in players do
		table.insert(playerNames, player.Name)
	end
	print("[CaseManager] Case loaded:", caseData.caseName, "for", table.concat(playerNames, ", "))
	return true, nil
end

function CaseManager.getActiveCase(player: Player): ActiveCase?
	return activeCases[player.UserId]
end

function CaseManager.getCaseFolder(caseId: string): Folder?
	return getCaseModules(caseId)
end

function CaseManager.setState(player: Player, newState: CaseState)
	local activeCase = activeCases[player.UserId]
	if not activeCase then
		return
	end
	activeCase.state = newState
	if newState == "Raiding" then
		activeCase.breachTime = tick()
	end
	getRemote("CaseStateChanged"):FireClient(player, newState)
end

function CaseManager.completeCase(player: Player, totalXP: number)
	local activeCase = activeCases[player.UserId]
	if not activeCase then
		return
	end

	activeCase.state = "Complete"

	-- Only destroy layout once (first player to complete owns the cleanup)
	if activeCase.layoutModel then
		-- Check if any other player still references this layout
		local layoutStillUsed = false
		for userId, otherCase in activeCases do
			if userId ~= player.UserId and otherCase.layoutModel == activeCase.layoutModel and otherCase.state ~= "Complete" then
				layoutStillUsed = true
				break
			end
		end
		if not layoutStillUsed then
			activeCase.layoutModel:Destroy()
		end
		activeCase.layoutModel = nil
	end

	local key = tostring(player.UserId) .. "_" .. activeCase.caseData.caseId
	caseCooldowns[key] = tick() + COOLDOWN_SECONDS

	getRemote("CaseCompleted"):FireClient(player, {
		caseId = activeCase.caseData.caseId,
		totalXP = totalXP,
	})

	activeCases[player.UserId] = nil
	print("[CaseManager] Case completed:", activeCase.caseData.caseName, "for", player.Name, "XP:", totalXP)
end

function CaseManager.abandonCase(player: Player)
	local activeCase = activeCases[player.UserId]
	if not activeCase then
		return
	end

	-- Only destroy layout if no other player references it
	if activeCase.layoutModel then
		local layoutStillUsed = false
		for userId, otherCase in activeCases do
			if userId ~= player.UserId and otherCase.layoutModel == activeCase.layoutModel then
				layoutStillUsed = true
				break
			end
		end
		if not layoutStillUsed then
			activeCase.layoutModel:Destroy()
		end
	end

	activeCases[player.UserId] = nil
	getRemote("CaseAbandoned"):FireClient(player)
	print("[CaseManager] Case abandoned by", player.Name)
end

function CaseManager.onPlayerRemoving(player: Player)
	CaseManager.abandonCase(player)
end

return CaseManager
