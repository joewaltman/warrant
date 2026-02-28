--!strict
-- CaseServerInit | WARRANT: Case Closed
-- Case server entry point — runs when PlaceRegistry.isCasePlace() is true.
-- Map is pre-built in each case place; wires remote handlers, manages lifecycle.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))
local PlaceRegistry = require(Shared:WaitForChild("PlaceRegistry"))

type TeleportData = Types.TeleportData

local CaseServerInit = {}

------------------------------------------------------------------------
-- HELPERS
------------------------------------------------------------------------
local function safeRequire(moduleScript: ModuleScript): any
	local success, result = pcall(require, moduleScript)
	if not success then
		warn("[CaseServer] Failed to load", moduleScript.Name, ":", result)
		return nil
	end
	return result
end

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent
end

local function teleportPlayerLocal(player: Player, position: Vector3)
	local character = player.Character
	if character then
		local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if rootPart then
			rootPart.CFrame = CFrame.new(position)
		end
	end
end

------------------------------------------------------------------------
-- MAIN START
------------------------------------------------------------------------
function CaseServerInit.start()
	print("[CaseServer] Case place server starting...")

	--------------------------------------------------------------------
	-- STEP 1: CREATE ALL REMOTE EVENTS (same list as hub)
	--------------------------------------------------------------------
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
		"QueueJoined", "QueueLeft", "MatchFound",
		"SetupPhaseStarted", "WaitingForSetup", "DetectivePhaseStarted",
		"MatchEnded", "SuspectExposed", "TeamMateExposed",
		"OpenCaseBoard",
		"RequestProfileData", "ProfileDataLoaded",
		"EvidencePositions",
		"TutorialProgress",
		"NPCFired", "SuspectArrested",
		-- Party remotes (needed so client doesn't hang on WaitForChild)
		"PartyInvite", "PartyAccept", "PartyLeave",
		-- Witness system
		"ClueDiscovered",
	}

	for _, name in ALL_REMOTES do
		if not ReplicatedStorage:FindFirstChild(name) then
			local remote = Instance.new("RemoteEvent")
			remote.Name = name
			remote.Parent = ReplicatedStorage
		end
	end

	print("[CaseServer] RemoteEvents created")

	--------------------------------------------------------------------
	-- STEP 2: LOAD SERVER MODULES
	--------------------------------------------------------------------
	local TeleportManager = require(script.Parent.TeleportManager)
	local CaseManager = safeRequire(script.Parent.CaseManager)
	local EvidenceSystem = safeRequire(script.Parent.EvidenceSystem)
	local RaidController = safeRequire(script.Parent.RaidController)
	local NPCBehavior = safeRequire(script.Parent.NPCBehavior)
	local CombatSystem = safeRequire(script.Parent.CombatSystem)
	local ScoringSystem = safeRequire(script.Parent.ScoringSystem)
	local ProgressionSystem = safeRequire(script.Parent.ProgressionSystem)
	local AntiExploit = safeRequire(script.Parent.AntiExploit)
	local StatsTracker = safeRequire(script.Parent.StatsTracker)

	print("[CaseServer] Server modules loaded")

	--------------------------------------------------------------------
	-- STEP 3: AMBIENT LIGHTING (same as hub)
	--------------------------------------------------------------------
	do
		local Lighting = game:GetService("Lighting")
		Lighting.Ambient = Color3.fromRGB(40, 40, 50)
		Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 70)
		Lighting.Brightness = 0.5
		Lighting.ClockTime = 21
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
	end

	--------------------------------------------------------------------
	-- STEP 4: CASE STATE
	--------------------------------------------------------------------
	local caseId: string? = PlaceRegistry.getCaseIdForCurrentPlace()
	if not caseId then
		warn("[CaseServer] This place is not mapped to any caseId in PlaceRegistry")
		return
	end
	print("[CaseServer] Case place detected, caseId:", caseId)

	local caseLoaded = false
	local casePlayers: { Player } = {}
	local CASE_ORIGIN = Vector3.new(0, 0, 0)

	--------------------------------------------------------------------
	-- STEP 5: RAID COMPLETION CALLBACK
	--------------------------------------------------------------------
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
				if caseId then
					EvidenceSystem.cleanupCase(caseId)
				end
			end
			if RaidController then RaidController.cleanup(player) end
			if NPCBehavior then
				NPCBehavior.cleanup()
				NPCBehavior.cleanupWitnesses()
			end

			-- Save progression before teleporting back
			if ProgressionSystem then
				ProgressionSystem.savePlayer(player)
			end

			-- Teleport all case players back to hub
			local playersToTeleport = {}
			for _, p in Players:GetPlayers() do
				table.insert(playersToTeleport, p)
			end
			if #playersToTeleport > 0 then
				TeleportManager.teleportToHub(playersToTeleport)
			end
		end)
	end

	--------------------------------------------------------------------
	-- STEP 6: LOAD CASE FOR A SET OF PLAYERS
	--------------------------------------------------------------------
	local function loadCaseForPlayers(players: { Player })
		if caseLoaded then
			return
		end
		caseLoaded = true
		casePlayers = players

		local caseFolder = if CaseManager then CaseManager.getCaseFolder(caseId :: string) else nil
		if not caseFolder then
			warn("[CaseServer] Case folder not found:", caseId)
			return
		end

		local configModule = caseFolder:FindFirstChild("CaseConfig") :: ModuleScript?
		if not configModule then
			warn("[CaseServer] CaseConfig not found for:", caseId)
			return
		end

		local config = require(configModule) :: any
		local caseData = config.getData()

		-- Map is pre-built in this place — no LayoutBuilder needed

		-- Load case for all players (party)
		if CaseManager then
			local success, err = CaseManager.loadCase(players, caseId :: string, nil)
			if not success then
				warn("[CaseServer] Case load failed:", err)
				return
			end
		end

		-- Initialize evidence
		if EvidenceSystem then
			local evidenceModule = caseFolder:FindFirstChild("EvidenceMap")
			if evidenceModule and evidenceModule:IsA("ModuleScript") then
				local evMod = require(evidenceModule) :: any
				if evMod.getEvidence then
					local evidenceList = evMod.getEvidence()
					-- No offset needed — case is at origin
					EvidenceSystem.loadEvidence(caseId :: string, evidenceList)

					local positions = {}
					for _, ev in evidenceList do
						table.insert(positions, {
							id = ev.id,
							position = ev.position,
							discoveryMethod = ev.discoveryMethod,
						})
					end
					for _, p in players do
						getRemote("EvidencePositions"):FireClient(p, positions)
					end
				end
			end
		end

		-- Initialize witness NPCs from NeighborhoodClues
		if NPCBehavior then
			local cluesModule = caseFolder:FindFirstChild("NeighborhoodClues")
			if cluesModule and cluesModule:IsA("ModuleScript") then
				local cluesMod = require(cluesModule) :: any
				if cluesMod.getClues then
					local clues = cluesMod.getClues()
					for _, clue in clues do
						local witnessData = {
							id = clue.id,
							name = clue.name or "Witness",
							dialogue = clue.text,
							position = clue.position,
							interactRange = clue.interactRange or 10,
						}
						local _, prompt = NPCBehavior.createWitnessNPC(witnessData)
						prompt.Triggered:Connect(function(triggeringPlayer: Player)
							-- Fire dialogue to client
							getRemote("ClueDiscovered"):FireClient(triggeringPlayer, witnessData.name, witnessData.dialogue)

							-- Award 2 intel points
							if EvidenceSystem then
								local intel = EvidenceSystem.getPlayerIntel(triggeringPlayer)
								if intel and not intel.discoveredEvidence["witness_" .. clue.id] then
									intel.discoveredEvidence["witness_" .. clue.id] = true
									intel.points += 2

									-- Recalculate tier
									local oldTier = intel.tier
									local newTier = 0
									for i = 4, 0, -1 do
										if intel.points >= GameConfig.INTEL_THRESHOLDS[i] then
											newTier = i
											break
										end
									end
									intel.tier = newTier

									-- Notify client
									getRemote("IntelUpdated"):FireClient(triggeringPlayer, {
										points = intel.points,
										tier = intel.tier,
										tierName = GameConfig.INTEL_TIER_REVEALS[intel.tier + 1].tierName,
										evidenceId = "witness_" .. clue.id,
										evidenceName = witnessData.name .. " (Witness)",
										pointValue = 2,
									})

									if newTier > oldTier then
										getRemote("IntelTierChanged"):FireClient(triggeringPlayer, {
											newTier = newTier,
											tierName = GameConfig.INTEL_TIER_REVEALS[newTier + 1].tierName,
											tierConfig = GameConfig.INTEL_TIER_REVEALS[newTier + 1],
										})
									end

									-- Destroy the prompt so it can't be triggered again
									prompt:Destroy()
								end
							end
						end)
					end
				end
			end
		end

		-- Initialize combat for all players
		if CombatSystem then
			for _, p in players do
				local armorBonus = if ProgressionSystem and ProgressionSystem.getPlayerLevel(p) >= 50 then 15 else 0
				CombatSystem.initPlayer(p, armorBonus)
			end
		end

		-- Teleport all players to case building entrance
		for _, p in players do
			teleportPlayerLocal(p, CASE_ORIGIN + Vector3.new(0, 5, -20))
		end

		print("[CaseServer] Case loaded:", caseData.caseName, "for", #players, "players")
	end

	--------------------------------------------------------------------
	-- STEP 7: PLAYER ADDED / REMOVING
	--------------------------------------------------------------------
	Players.PlayerAdded:Connect(function(player: Player)
		-- Load progression data
		if ProgressionSystem then
			ProgressionSystem.loadPlayer(player)
		end
		if EvidenceSystem then
			EvidenceSystem.initForPlayer(player)
		end

		-- Read teleport data for party info; validate caseId matches this place
		local teleportData = TeleportManager.getTeleportData(player)
		if teleportData and teleportData.caseId and teleportData.caseId ~= caseId then
			warn("[CaseServer] Player", player.Name, "arrived with mismatched caseId:", teleportData.caseId, "expected:", caseId)
		end

		if not caseLoaded then
			-- Small delay to let other party members connect
			task.wait(2)
			local allPlayers = Players:GetPlayers()
			loadCaseForPlayers(allPlayers)
		elseif caseLoaded and caseId then
			-- Late joiner (party member who arrived after case loaded)
			-- Add them to the existing case
			if CaseManager then
				local caseFolder = CaseManager.getCaseFolder(caseId)
				if caseFolder then
					CaseManager.loadCase({ player }, caseId, nil)
				end
			end
			if CombatSystem then
				local armorBonus = if ProgressionSystem and ProgressionSystem.getPlayerLevel(player) >= 50 then 15 else 0
				CombatSystem.initPlayer(player, armorBonus)
			end
			teleportPlayerLocal(player, CASE_ORIGIN + Vector3.new(0, 5, -20))
		end

		print("[CaseServer] Player joined:", player.Name)
	end)

	Players.PlayerRemoving:Connect(function(player: Player)
		-- Save partial progress for disconnected player
		if ProgressionSystem then
			ProgressionSystem.savePlayer(player)
		end

		if CaseManager then CaseManager.onPlayerRemoving(player) end
		if EvidenceSystem then EvidenceSystem.cleanup(player) end
		if RaidController then RaidController.cleanup(player) end
		if CombatSystem then CombatSystem.cleanup(player) end
		if ProgressionSystem then ProgressionSystem.cleanup(player) end
		if AntiExploit then AntiExploit.cleanup(player) end

		-- Remove from casePlayers
		for i, p in casePlayers do
			if p == player then
				table.remove(casePlayers, i)
				break
			end
		end

		print("[CaseServer] Player left:", player.Name)
	end)

	--------------------------------------------------------------------
	-- STEP 8: WIRE REMOTE HANDLERS (same as hub for case lifecycle)
	--------------------------------------------------------------------

	-- Breach
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

		-- Set state for all party members
		for _, p in Players:GetPlayers() do
			CaseManager.setState(p, "Raiding")
		end

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

		-- No offset needed — case is at origin in reserved server

		RaidController.startRaid(player, activeCase.caseData.caseId, intelTier, npcConfigs, function()
			onRaidComplete(player)
		end)

		local raid = RaidController.getActiveRaid(player)
		if raid and NPCBehavior then
			for _, activeNPC in raid.npcs do
				local npcInstance = NPCBehavior.spawnNPC(activeNPC.config, activeNPC.assignedBehavior)
				activeNPC.model = npcInstance.model
			end
			-- Alert all NPCs with all players as potential targets
			NPCBehavior.alertAllOnBreach(player)
		end
	end)

	-- Evidence interaction
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

	-- Weapon fire
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

	-- Weapon switch
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

	-- Arrest
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

	-- Medkit
	getRemote("RequestMedkit").OnServerEvent:Connect(function(player: Player)
		if CombatSystem then
			CombatSystem.healPlayer(player)
		end
	end)

	-- Profile data (still works on case server)
	getRemote("RequestProfileData").OnServerEvent:Connect(function(player: Player)
		if StatsTracker then
			StatsTracker.sendProfileData(player)
		end
	end)

	-- Tutorial progress
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

	--------------------------------------------------------------------
	-- STEP 9: BIND TO CLOSE (save all player data before shutdown)
	--------------------------------------------------------------------
	game:BindToClose(function()
		print("[CaseServer] Server shutting down, saving all player data...")
		for _, player in Players:GetPlayers() do
			if ProgressionSystem then
				ProgressionSystem.savePlayer(player)
			end
		end
	end)

	print("[CaseServer] Case place server initialized, waiting for players...")
end

return CaseServerInit
