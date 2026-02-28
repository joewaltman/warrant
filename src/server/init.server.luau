--!strict
-- Server entry | WARRANT: Case Closed
-- Initializes all server systems and wires up RemoteEvent handlers

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("[Server] WARRANT: Case Closed loading...")

------------------------------------------------------------------------
-- STEP 1: CREATE ALL REMOTE EVENTS FIRST (before anything else)
-- This prevents client WaitForChild hangs if module loads fail.
------------------------------------------------------------------------
local ALL_REMOTES = {
	"RequestCase", "RequestBreach", "RequestInteract",
	"RequestFireWeapon", "RequestWeaponSwitch", "RequestArrest",
	"RequestMedkit", "RequestIdentify",
	"JoinSyndicateQueue", "LeaveSyndicateQueue",
	"CaseLoaded", "CaseStateChanged", "CaseCompleted", "CaseAbandoned",
	"IntelUpdated", "IntelTierChanged", "BreachInitiated",
	"RaidStarted", "RaidEnded",
	"WeaponEquipped", "PlayerHealthChanged", "PlayerDowned",
	"ScorePresented",
	"PlayerDataLoaded", "LevelUp", "RankUp", "XPAwarded",
	"TitleUnlocked", "BadgeUnlocked",
	"QueueJoined", "QueueLeft", "MatchFound",
	"SetupPhaseStarted", "WaitingForSetup", "DetectivePhaseStarted",
	"MatchEnded", "SuspectExposed", "TeamMateExposed",
	"OpenCaseBoard",
	"RequestProfileData", "ProfileDataLoaded",
	"EvidencePositions",
	"TutorialProgress",
	"NPCFired", "SuspectArrested",
}

for _, name in ALL_REMOTES do
	if not ReplicatedStorage:FindFirstChild(name) then
		local remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = ReplicatedStorage
	end
end

print("[Server] RemoteEvents created")

------------------------------------------------------------------------
-- STEP 2: LOAD SHARED MODULES
------------------------------------------------------------------------
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

print("[Server] Shared modules loaded")

------------------------------------------------------------------------
-- STEP 3: LOAD SERVER MODULES (with error reporting)
------------------------------------------------------------------------
local function safeRequire(moduleScript: ModuleScript): any
	local success, result = pcall(require, moduleScript)
	if not success then
		warn("[Server] Failed to load", moduleScript.Name, ":", result)
		return nil
	end
	return result
end

local CaseManager = safeRequire(script.CaseManager)
local EvidenceSystem = safeRequire(script.EvidenceSystem)
local RaidController = safeRequire(script.RaidController)
local NPCBehavior = safeRequire(script.NPCBehavior)
local CombatSystem = safeRequire(script.CombatSystem)
local ScoringSystem = safeRequire(script.ScoringSystem)
local ProgressionSystem = safeRequire(script.ProgressionSystem)
local SyndicateMatch = safeRequire(script.SyndicateMatch)
local AntiExploit = safeRequire(script.AntiExploit)
local LayoutBuilder = safeRequire(script.LayoutBuilder)
local PrecinctBuilder = safeRequire(script.PrecinctBuilder)
local StatsTracker = safeRequire(script.StatsTracker)

print("[Server] Server modules loaded")

------------------------------------------------------------------------
-- STEP 4: BUILD PRECINCT
------------------------------------------------------------------------
local precinctModel: Model? = nil
local caseBoardPart: Part? = nil
local PRECINCT_SPAWN = Vector3.new(0, 5, -15)
local CASE_BUILDING_OFFSET = Vector3.new(200, 0, 0) -- Cases spawn far from precinct

if PrecinctBuilder then
	precinctModel, caseBoardPart = PrecinctBuilder.build()
	print("[Server] Precinct built")

	-- Wire up the ProximityPrompt on the case board
	if caseBoardPart then
		local prompt = caseBoardPart:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			prompt.Triggered:Connect(function(player: Player)
				local remote = ReplicatedStorage:FindFirstChild("OpenCaseBoard") :: RemoteEvent
				if remote then
					remote:FireClient(player)
				end
			end)
		end
	end
else
	-- Fallback: create a basic spawn platform
	local platform = Instance.new("SpawnLocation")
	platform.Size = Vector3.new(20, 1, 20)
	platform.Position = Vector3.new(0, 0, 0)
	platform.Anchored = true
	platform.Material = Enum.Material.Concrete
	platform.Color = Color3.fromRGB(100, 100, 100)
	platform.Parent = workspace
	warn("[Server] PrecinctBuilder failed, using fallback spawn")
end

------------------------------------------------------------------------
-- STEP 4B: AMBIENT LIGHTING
------------------------------------------------------------------------
do
	local Lighting = game:GetService("Lighting")
	Lighting.Ambient = Color3.fromRGB(40, 40, 50)
	Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 70)
	Lighting.Brightness = 0.5
	Lighting.ClockTime = 21 -- nighttime (9 PM)
	Lighting.FogEnd = 500
	Lighting.FogColor = Color3.fromRGB(20, 20, 30)

	local atmosphere = Instance.new("Atmosphere")
	atmosphere.Density = 0.3
	atmosphere.Offset = 0.25
	atmosphere.Color = Color3.fromRGB(40, 50, 80)
	atmosphere.Decay = Color3.fromRGB(30, 30, 40)
	atmosphere.Glare = 0
	atmosphere.Haze = 2
	atmosphere.Parent = Lighting

	local colorCorrection = Instance.new("ColorCorrectionEffect")
	colorCorrection.Brightness = -0.05
	colorCorrection.Contrast = 0.15
	colorCorrection.Saturation = -0.1
	colorCorrection.TintColor = Color3.fromRGB(220, 230, 255)
	colorCorrection.Parent = Lighting

	local bloom = Instance.new("BloomEffect")
	bloom.Intensity = 0.3
	bloom.Size = 24
	bloom.Threshold = 2
	bloom.Parent = Lighting

	print("[Server] Ambient lighting configured")
end

------------------------------------------------------------------------
-- HELPERS
------------------------------------------------------------------------
local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent
end

local function teleportPlayer(player: Player, position: Vector3)
	local character = player.Character
	if character then
		local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if rootPart then
			rootPart.CFrame = CFrame.new(position)
		end
	end
end

------------------------------------------------------------------------
-- PLAYER JOIN / LEAVE
------------------------------------------------------------------------
Players.PlayerAdded:Connect(function(player: Player)
	if ProgressionSystem then
		ProgressionSystem.loadPlayer(player)
	end
	if EvidenceSystem then
		EvidenceSystem.initForPlayer(player)
	end
	print("[Server] Player joined:", player.Name)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	if CaseManager then CaseManager.onPlayerRemoving(player) end
	if EvidenceSystem then EvidenceSystem.cleanup(player) end
	if RaidController then RaidController.cleanup(player) end
	if CombatSystem then CombatSystem.cleanup(player) end
	if ProgressionSystem then ProgressionSystem.cleanup(player) end
	if SyndicateMatch then SyndicateMatch.onPlayerRemoving(player) end
	if AntiExploit then AntiExploit.cleanup(player) end
end)

------------------------------------------------------------------------
-- RAID COMPLETION (server-driven callback)
------------------------------------------------------------------------
local function onRaidComplete(player: Player)
	if not RaidController or not CaseManager or not ScoringSystem then
		return
	end

	local raid = RaidController.getActiveRaid(player)
	local activeCase = CaseManager.getActiveCase(player)
	if not raid or not activeCase then
		return
	end

	local intel = if EvidenceSystem then EvidenceSystem.getPlayerIntel(player) else nil
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

	if ProgressionSystem then
		ProgressionSystem.awardXP(player, result.totalXP)
		ProgressionSystem.recordCaseCompletion(player, activeCase.caseData.caseId, result.totalXP)
	end

	if StatsTracker then
		StatsTracker.recordCaseStats(player, activeCase.caseData, result, metrics, raid.intelTier)
	end

	task.spawn(function()
		task.wait(5)
		CaseManager.completeCase(player, result.totalXP)

		if EvidenceSystem then
			EvidenceSystem.cleanup(player)
			EvidenceSystem.cleanupCase(activeCase.caseData.caseId)
		end
		if RaidController then RaidController.cleanup(player) end
		if NPCBehavior then NPCBehavior.cleanup() end

		-- Teleport player back to precinct
		teleportPlayer(player, PRECINCT_SPAWN)
	end)
end

------------------------------------------------------------------------
-- CASE SELECTION
------------------------------------------------------------------------
getRemote("RequestCase").OnServerEvent:Connect(function(player: Player, caseId: unknown)
	if typeof(caseId) ~= "string" or not CaseManager then
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

	if ProgressionSystem and not ProgressionSystem.isCaseAvailable(player, caseData.difficulty) then
		return
	end

	-- Build layout programmatically
	local layoutModel: Model? = nil
	if LayoutBuilder and config.getLayout then
		local layoutDef = config.getLayout()
		-- Offset so building doesn't overlap precinct
		layoutDef.origin = CASE_BUILDING_OFFSET
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

	-- Initialize evidence (offset positions so server-side comparisons work)
	if EvidenceSystem then
		local evidenceModule = caseFolder:FindFirstChild("EvidenceMap")
		if evidenceModule and evidenceModule:IsA("ModuleScript") then
			local evMod = require(evidenceModule) :: any
			if evMod.getEvidence then
				local evidenceList = evMod.getEvidence()

				-- Offset evidence positions to match building location
				for _, ev in evidenceList do
					ev.position = ev.position + CASE_BUILDING_OFFSET
				end

				EvidenceSystem.loadEvidence(caseId :: string, evidenceList)

				-- Send evidence positions to client for visual markers
				local positions = {}
				for _, ev in evidenceList do
					table.insert(positions, {
						id = ev.id,
						position = ev.position,
						discoveryMethod = ev.discoveryMethod,
					})
				end
				getRemote("EvidencePositions"):FireClient(player, positions)
			end
		end
	end

	-- Initialize combat
	if CombatSystem then
		local armorBonus = if ProgressionSystem and ProgressionSystem.getPlayerLevel(player) >= 50 then 15 else 0
		CombatSystem.initPlayer(player, armorBonus)
	end

	-- Teleport player to case building
	teleportPlayer(player, CASE_BUILDING_OFFSET + Vector3.new(0, 5, -20))
end)

------------------------------------------------------------------------
-- BREACH
------------------------------------------------------------------------
getRemote("RequestBreach").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit or not AntiExploit.checkRateLimit(player, "breach") then
		return
	end

	if not CaseManager or not EvidenceSystem or not RaidController then
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

	-- Offset NPC positions to match case building location
	for _, npc in npcConfigs do
		npc.position = npc.position + CASE_BUILDING_OFFSET
		if npc.fleeRoute then
			for i, point in npc.fleeRoute do
				npc.fleeRoute[i] = point + CASE_BUILDING_OFFSET
			end
		end
	end

	RaidController.startRaid(player, activeCase.caseData.caseId, intelTier, npcConfigs, function()
		onRaidComplete(player)
	end)

	local raid = RaidController.getActiveRaid(player)
	if raid and NPCBehavior then
		for _, activeNPC in raid.npcs do
			local npcInstance = NPCBehavior.spawnNPC(activeNPC.config, activeNPC.assignedBehavior)
			activeNPC.model = npcInstance.model
		end
		-- Alert all NPCs on breach with staggered delay
		NPCBehavior.alertAllOnBreach(player)
	end
end)

------------------------------------------------------------------------
-- EVIDENCE INTERACTION
------------------------------------------------------------------------
getRemote("RequestInteract").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit or not AntiExploit.checkRateLimit(player, "interact") then
		return
	end

	if not CaseManager or not EvidenceSystem then
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

	if not AntiExploit or not AntiExploit.checkRateLimit(player, "fireWeapon") then
		return
	end

	if not AntiExploit.validateRayOrigin(player, origin :: Vector3) then
		return
	end

	if not CombatSystem or not RaidController then
		return
	end

	local result = CombatSystem.fireWeapon(player, origin :: Vector3, direction :: Vector3)
	RaidController.recordShot(player)

	if result.hit and result.isNPC and result.target and NPCBehavior then
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

	if ProgressionSystem and not ProgressionSystem.isToolUnlocked(player, weapon :: string) then
		return
	end

	if CombatSystem then
		CombatSystem.equipWeapon(player, weapon :: any)
	end
end)

------------------------------------------------------------------------
-- ARREST
------------------------------------------------------------------------
getRemote("RequestArrest").OnServerEvent:Connect(function(player: Player)
	if not AntiExploit or not AntiExploit.checkRateLimit(player, "interact") then
		return
	end

	if not NPCBehavior or not RaidController then
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
	for id, _npc in allNPCs do
		if NPCBehavior.isNPCInRange(id, rootPart.Position, 8) then
			if NPCBehavior.arrestNPC(id) then
				RaidController.recordTakedown(player, id, true)

				-- Fire SuspectArrested to client for HUD update
				local raid = RaidController.getActiveRaid(player)
				if raid then
					getRemote("SuspectArrested"):FireClient(player, {
						arrested = raid.metrics.suspectsArrested,
						total = raid.metrics.totalSuspects,
					})
				end
				break
			end
		end
	end
end)

------------------------------------------------------------------------
-- MEDKIT
------------------------------------------------------------------------
getRemote("RequestMedkit").OnServerEvent:Connect(function(player: Player)
	if CombatSystem then
		CombatSystem.healPlayer(player)
	end
end)

------------------------------------------------------------------------
-- SYNDICATE MODE
------------------------------------------------------------------------
getRemote("JoinSyndicateQueue").OnServerEvent:Connect(function(player: Player, preference: unknown)
	if typeof(preference) ~= "string" or not SyndicateMatch then
		return
	end
	local validPrefs = { Detective = true, Syndicate = true, NoPreference = true }
	if not validPrefs[preference :: string] then
		return
	end
	SyndicateMatch.joinQueue(player, preference :: Types.SyndicateRolePreference)
end)

getRemote("LeaveSyndicateQueue").OnServerEvent:Connect(function(player: Player)
	if SyndicateMatch then
		SyndicateMatch.leaveQueue(player)
	end
end)

getRemote("RequestIdentify").OnServerEvent:Connect(function(player: Player)
	if not SyndicateMatch then
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

------------------------------------------------------------------------
-- PROFILE DATA
------------------------------------------------------------------------
getRemote("RequestProfileData").OnServerEvent:Connect(function(player: Player)
	if StatsTracker then
		StatsTracker.sendProfileData(player)
	end
end)

------------------------------------------------------------------------
-- TUTORIAL PROGRESS
------------------------------------------------------------------------
getRemote("TutorialProgress").OnServerEvent:Connect(function(player: Player, step: unknown)
	if typeof(step) ~= "number" then
		return
	end

	if ProgressionSystem then
		local data = ProgressionSystem.getPlayerData(player)
		if data and (step :: number) > data.tutorialStep then
			data.tutorialStep = step :: number
		end
	end
end)

print("[Server] WARRANT: Case Closed loaded successfully")
