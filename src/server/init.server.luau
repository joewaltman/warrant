--!strict
-- Server entry | WARRANT: Case Closed
-- Initializes all server systems and wires up RemoteEvent handlers

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for shared modules
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

-- Server modules
local CaseManager = require(script.CaseManager)
local EvidenceSystem = require(script.EvidenceSystem)
local RaidController = require(script.RaidController)
local NPCBehavior = require(script.NPCBehavior)
local CombatSystem = require(script.CombatSystem)
local ScoringSystem = require(script.ScoringSystem)
local ProgressionSystem = require(script.ProgressionSystem)
local SyndicateMatch = require(script.SyndicateMatch)
local AntiExploit = require(script.AntiExploit)
local LayoutBuilder = require(script.LayoutBuilder)

print("[Server] WARRANT: Case Closed loading...")

------------------------------------------------------------------------
-- CENTRAL REMOTE EVENT REGISTRY
-- All RemoteEvents are created here, ONCE. Modules look them up by name.
------------------------------------------------------------------------
local ALL_REMOTES = {
	-- Client -> Server requests
	"RequestCase", "RequestBreach", "RequestInteract",
	"RequestFireWeapon", "RequestWeaponSwitch", "RequestArrest",
	"RequestMedkit", "RequestIdentify",
	"JoinSyndicateQueue", "LeaveSyndicateQueue",
	-- Server -> Client notifications (Case)
	"CaseLoaded", "CaseStateChanged", "CaseCompleted", "CaseAbandoned",
	-- Server -> Client notifications (Evidence / Intel)
	"IntelUpdated", "IntelTierChanged", "BreachInitiated",
	-- Server -> Client notifications (Raid)
	"RaidStarted", "RaidEnded",
	-- Server -> Client notifications (Combat)
	"WeaponEquipped", "PlayerHealthChanged", "PlayerDowned",
	-- Server -> Client notifications (Scoring)
	"ScorePresented",
	-- Server -> Client notifications (Progression)
	"PlayerDataLoaded", "LevelUp", "RankUp", "XPAwarded",
	"TitleUnlocked", "BadgeUnlocked",
	-- Server -> Client notifications (Syndicate)
	"QueueJoined", "QueueLeft", "MatchFound",
	"SetupPhaseStarted", "WaitingForSetup", "DetectivePhaseStarted",
	"MatchEnded", "SuspectExposed", "TeamMateExposed",
}

for _, name in ALL_REMOTES do
	if not ReplicatedStorage:FindFirstChild(name) then
		local remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = ReplicatedStorage
	end
end

-- Helper to fetch an already-created remote
local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent
end

------------------------------------------------------------------------
-- PLAYER JOIN / LEAVE
------------------------------------------------------------------------
Players.PlayerAdded:Connect(function(player: Player)
	ProgressionSystem.loadPlayer(player)
	EvidenceSystem.initForPlayer(player)
	print("[Server] Player joined:", player.Name)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	CaseManager.onPlayerRemoving(player)
	EvidenceSystem.cleanup(player)
	RaidController.cleanup(player)
	CombatSystem.cleanup(player)
	ProgressionSystem.cleanup(player)
	SyndicateMatch.onPlayerRemoving(player)
	AntiExploit.cleanup(player)
end)

------------------------------------------------------------------------
-- CASE SELECTION
------------------------------------------------------------------------
getRemote("RequestCase").OnServerEvent:Connect(function(player: Player, caseId: unknown)
	if typeof(caseId) ~= "string" then
		return
	end

	local caseFolder = CaseManager.getCaseFolder(caseId :: string)
	if not caseFolder then
		return
	end

	local configModule = caseFolder:FindFirstChild("CaseConfig") :: ModuleScript?
	if not configModule then
		return
	end

	local config = require(configModule) :: any
	local caseData = config.getData()

	if not ProgressionSystem.isCaseAvailable(player, caseData.difficulty) then
		return
	end

	-- Build layout programmatically if case provides layout data
	local layoutModel: Model? = nil
	if config.getLayout then
		local layoutDef = config.getLayout()
		layoutModel = LayoutBuilder.build(layoutDef)
		layoutModel.Parent = workspace
	end

	local success, err = CaseManager.loadCase(player, caseId :: string, layoutModel)
	if not success then
		warn("[Server] Case load failed:", err)
		if layoutModel then
			layoutModel:Destroy()
		end
		return
	end

	-- Initialize evidence for this case
	local evidenceModule = caseFolder:FindFirstChild("EvidenceMap")
	if evidenceModule and evidenceModule:IsA("ModuleScript") then
		local evMod = require(evidenceModule) :: any
		if evMod.getEvidence then
			EvidenceSystem.loadEvidence(caseId :: string, evMod.getEvidence())
		end
	end

	-- Initialize combat state
	local armorBonus = if ProgressionSystem.getPlayerLevel(player) >= 50 then 15 else 0
	CombatSystem.initPlayer(player, armorBonus)
end)

------------------------------------------------------------------------
-- BREACH
------------------------------------------------------------------------
getRemote("RequestBreach").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit.checkRateLimit(player, "breach") then
		return
	end

	local activeCase = CaseManager.getActiveCase(player)
	if not activeCase or activeCase.state ~= "Investigating" then
		return
	end

	local success, intelTier = EvidenceSystem.breach(player)
	if not success then
		return
	end

	CaseManager.setState(player, "Raiding")

	-- Load NPC configs from case
	local caseFolder = CaseManager.getCaseFolder(activeCase.caseData.caseId)
	local npcConfigs: { Types.NPCSuspect } = {}
	if caseFolder then
		local npcModule = caseFolder:FindFirstChild("NPCConfig")
		if npcModule and npcModule:IsA("ModuleScript") then
			local npcMod = require(npcModule) :: any
			if npcMod.getNPCs then
				npcConfigs = npcMod.getNPCs()
			end
		end
	end

	-- Start raid with onComplete callback
	RaidController.startRaid(player, activeCase.caseData.caseId, intelTier, npcConfigs, function()
		onRaidComplete(player)
	end)

	-- Spawn NPCs
	local raid = RaidController.getActiveRaid(player)
	if raid then
		for _, activeNPC in raid.npcs do
			local npcInstance = NPCBehavior.spawnNPC(activeNPC.config, activeNPC.assignedBehavior)
			activeNPC.model = npcInstance.model
		end
	end
end)

------------------------------------------------------------------------
-- EVIDENCE INTERACTION
------------------------------------------------------------------------
getRemote("RequestInteract").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit.checkRateLimit(player, "interact") then
		return
	end

	local activeCase = CaseManager.getActiveCase(player)
	if not activeCase or activeCase.state ~= "Investigating" then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return
	end

	local evidence = EvidenceSystem.getEvidence(activeCase.caseData.caseId)
	local nearestId: string? = nil
	local nearestDist = 15

	for _, item in evidence do
		local intel = EvidenceSystem.getPlayerIntel(player)
		if intel and not intel.discoveredEvidence[item.id] then
			local dist = (rootPart.Position - item.position).Magnitude
			if dist < nearestDist then
				nearestDist = dist
				nearestId = item.id
			end
		end
	end

	if nearestId then
		EvidenceSystem.discoverEvidence(player, activeCase.caseData.caseId, nearestId)
	end
end)

------------------------------------------------------------------------
-- WEAPON FIRE
------------------------------------------------------------------------
getRemote("RequestFireWeapon").OnServerEvent:Connect(function(player: Player, origin: unknown, direction: unknown)
	if typeof(origin) ~= "Vector3" or typeof(direction) ~= "Vector3" then
		return
	end

	if not AntiExploit.checkRateLimit(player, "fireWeapon") then
		return
	end

	if not AntiExploit.validateRayOrigin(player, origin :: Vector3) then
		return
	end

	local result = CombatSystem.fireWeapon(player, origin :: Vector3, direction :: Vector3)
	RaidController.recordShot(player)

	if result.hit and result.isNPC and result.target then
		local didHit, isDowned = NPCBehavior.damageNPC(result.target, result.damage)
		if isDowned then
			RaidController.recordTakedown(player, result.target, result.isNonLethal)
		end
	end

	if result.isCollateral then
		RaidController.recordCollateral(player)
	end
end)

------------------------------------------------------------------------
-- WEAPON SWITCH
------------------------------------------------------------------------
getRemote("RequestWeaponSwitch").OnServerEvent:Connect(function(player: Player, weapon: unknown)
	if typeof(weapon) ~= "string" then
		return
	end

	if not ProgressionSystem.isToolUnlocked(player, weapon :: string) then
		return
	end

	CombatSystem.equipWeapon(player, weapon :: any)
end)

------------------------------------------------------------------------
-- ARREST
------------------------------------------------------------------------
getRemote("RequestArrest").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit.checkRateLimit(player, "interact") then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return
	end

	local allNPCs = NPCBehavior.getAllNPCs()
	for id, npc in allNPCs do
		if NPCBehavior.isNPCInRange(id, rootPart.Position, 8) then
			if NPCBehavior.arrestNPC(id) then
				RaidController.recordTakedown(player, id, true)
				break
			end
		end
	end
end)

------------------------------------------------------------------------
-- MEDKIT
------------------------------------------------------------------------
getRemote("RequestMedkit").OnServerEvent:Connect(function(player: Player)
	CombatSystem.healPlayer(player)
end)

------------------------------------------------------------------------
-- RAID COMPLETION -> SCORING (server-driven, no client event needed)
------------------------------------------------------------------------
function onRaidComplete(player: Player)
	local raid = RaidController.getActiveRaid(player)
	local activeCase = CaseManager.getActiveCase(player)
	if not raid or not activeCase then
		return
	end

	local intel = EvidenceSystem.getPlayerIntel(player)
	local evidencePoints = if intel then intel.points else 0

	CaseManager.setState(player, "Scoring")

	local metrics = RaidController.endRaid(player)
	if not metrics then
		return
	end

	local result = ScoringSystem.calculateScore(
		activeCase.caseData,
		raid.intelTier,
		evidencePoints,
		metrics
	)

	ScoringSystem.presentScore(player, result)

	-- Award XP
	local newLevel, didLevelUp, newRank = ProgressionSystem.awardXP(player, result.totalXP)
	ProgressionSystem.recordCaseCompletion(player, activeCase.caseData.caseId, result.totalXP)

	-- Let player see score screen, then complete
	task.spawn(function()
		task.wait(5)
		CaseManager.completeCase(player, result.totalXP)

		-- Cleanup
		EvidenceSystem.cleanup(player)
		EvidenceSystem.cleanupCase(activeCase.caseData.caseId)
		RaidController.cleanup(player)
		NPCBehavior.cleanup()
	end)
end

------------------------------------------------------------------------
-- SYNDICATE MODE
------------------------------------------------------------------------
getRemote("JoinSyndicateQueue").OnServerEvent:Connect(function(player: Player, preference: unknown)
	if typeof(preference) ~= "string" then
		return
	end
	local validPrefs = { Detective = true, Syndicate = true, NoPreference = true }
	if not validPrefs[preference :: string] then
		return
	end
	SyndicateMatch.joinQueue(player, preference :: Types.SyndicateRolePreference)
end)

getRemote("LeaveSyndicateQueue").OnServerEvent:Connect(function(player: Player)
	SyndicateMatch.leaveQueue(player)
end)

getRemote("RequestIdentify").OnServerEvent:Connect(function(player: Player)
	local character = player.Character
	if not character then
		return
	end
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return
	end

	for _, otherPlayer in Players:GetPlayers() do
		if otherPlayer ~= player then
			local otherChar = otherPlayer.Character
			if otherChar then
				local otherRoot = otherChar:FindFirstChild("HumanoidRootPart") :: BasePart?
				if otherRoot and (otherRoot.Position - rootPart.Position).Magnitude <= 10 then
					SyndicateMatch.identifySuspect(player, otherPlayer)
					break
				end
			end
		end
	end
end)

print("[Server] WARRANT: Case Closed loaded successfully")
