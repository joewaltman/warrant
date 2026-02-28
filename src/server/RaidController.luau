--!strict
-- RaidController | WARRANT: Case Closed
-- Manages the raid phase: NPC spawning, tier-based scaling, metrics tracking, completion

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

type NPCSuspect = Types.NPCSuspect
type IntelTierConfig = Types.IntelTierConfig
type BehaviorType = Types.BehaviorType

export type RaidMetrics = {
	timeElapsed: number,
	shotsFired: number,
	nonLethalTakedowns: number,
	lethalTakedowns: number,
	collateralDamage: number,
	suspectsArrested: number,
	totalSuspects: number,
	evidenceDestroyed: number,
}

export type ActiveRaid = {
	player: Player,
	caseId: string,
	intelTier: number,
	tierConfig: IntelTierConfig,
	npcs: { ActiveNPC },
	metrics: RaidMetrics,
	startTime: number,
	evidenceDestroyTimer: number,
	isComplete: boolean,
}

export type ActiveNPC = {
	config: NPCSuspect,
	model: Model?,
	assignedBehavior: BehaviorType,
	isAlive: boolean,
	isArrested: boolean,
	isAlerted: boolean,
	health: number,
}

local RaidController = {}

local activeRaids: { [number]: ActiveRaid } = {}
local raidCompleteCallbacks: { [number]: () -> () } = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

-- Assigns behavior types based on intel tier
-- Lower tier = more RESIST, higher tier = more SURRENDER
local function assignBehaviors(npcs: { NPCSuspect }, tier: number): { BehaviorType }
	local behaviors: { BehaviorType } = {}

	for i, npc in npcs do
		local baseBehavior = npc.behaviorType

		if tier >= 4 then
			-- Airtight: most surrender
			if baseBehavior == "RESIST" then
				-- 60% chance to switch to SURRENDER
				if math.random() < 0.6 then
					behaviors[i] = "SURRENDER"
				else
					behaviors[i] = "FLEE"
				end
			else
				behaviors[i] = "SURRENDER"
			end
		elseif tier == 3 then
			-- CaseBuilt: some surrender
			if baseBehavior == "RESIST" then
				if math.random() < 0.3 then
					behaviors[i] = "SURRENDER"
				else
					behaviors[i] = baseBehavior
				end
			else
				behaviors[i] = baseBehavior
			end
		elseif tier == 1 then
			-- Hunch: some flee instead of resist
			if baseBehavior == "RESIST" then
				if math.random() < 0.25 then
					behaviors[i] = "FLEE"
				else
					behaviors[i] = baseBehavior
				end
			else
				behaviors[i] = baseBehavior
			end
		elseif tier == 0 then
			-- Blind: all resist, override flee/surrender
			if baseBehavior == "SURRENDER" then
				behaviors[i] = "RESIST"
			elseif baseBehavior == "FLEE" then
				if math.random() < 0.5 then
					behaviors[i] = "RESIST"
				else
					behaviors[i] = baseBehavior
				end
			else
				behaviors[i] = baseBehavior
			end
		else
			-- Tier 2: use default behaviors
			behaviors[i] = baseBehavior
		end
	end

	return behaviors
end

function RaidController.startRaid(player: Player, caseId: string, intelTier: number, npcConfigs: { NPCSuspect }, onComplete: (() -> ())?): ActiveRaid
	local tierConfig = GameConfig.INTEL_TIER_REVEALS[intelTier + 1]
	local behaviors = assignBehaviors(npcConfigs, intelTier)

	local activeNpcs: { ActiveNPC } = {}
	for i, config in npcConfigs do
		table.insert(activeNpcs, {
			config = config,
			model = nil, -- NPCBehavior will spawn the model
			assignedBehavior = behaviors[i],
			isAlive = true,
			isArrested = false,
			isAlerted = false,
			health = config.health,
		})
	end

	local raid: ActiveRaid = {
		player = player,
		caseId = caseId,
		intelTier = intelTier,
		tierConfig = tierConfig,
		npcs = activeNpcs,
		metrics = {
			timeElapsed = 0,
			shotsFired = 0,
			nonLethalTakedowns = 0,
			lethalTakedowns = 0,
			collateralDamage = 0,
			suspectsArrested = 0,
			totalSuspects = #npcConfigs,
			evidenceDestroyed = 0,
		},
		startTime = tick(),
		evidenceDestroyTimer = 0,
		isComplete = false,
	}

	activeRaids[player.UserId] = raid
	if onComplete then
		raidCompleteCallbacks[player.UserId] = onComplete
	end

	-- Notify client of raid start with tier-appropriate reveals
	getRemote("RaidStarted"):FireClient(player, {
		intelTier = intelTier,
		tierConfig = {
			tierName = tierConfig.tierName,
			revealsSuspectCount = tierConfig.revealsSuspectCount,
			revealsFloorPlan = tierConfig.revealsFloorPlan,
			revealsSuspectPositions = tierConfig.revealsSuspectPositions,
			revealsTraps = tierConfig.revealsTraps,
			autoSurrenderEnabled = tierConfig.autoSurrenderEnabled,
		},
		suspectCount = if tierConfig.revealsSuspectCount then #npcConfigs else nil,
	})

	print("[RaidController] Raid started for", player.Name, "| Tier:", intelTier, "| Suspects:", #npcConfigs)
	return raid
end

function RaidController.getActiveRaid(player: Player): ActiveRaid?
	return activeRaids[player.UserId]
end

function RaidController.recordShot(player: Player)
	local raid = activeRaids[player.UserId]
	if not raid or raid.isComplete then
		return
	end
	raid.metrics.shotsFired += 1
end

function RaidController.recordTakedown(player: Player, npcId: string, isNonLethal: boolean)
	local raid = activeRaids[player.UserId]
	if not raid or raid.isComplete then
		return
	end

	for _, npc in raid.npcs do
		if npc.config.id == npcId then
			npc.isArrested = true
			npc.isAlive = not (not isNonLethal)
			break
		end
	end

	if isNonLethal then
		raid.metrics.nonLethalTakedowns += 1
	else
		raid.metrics.lethalTakedowns += 1
	end
	raid.metrics.suspectsArrested += 1

	-- Check if all suspects handled — fire completion callback
	if raid.metrics.suspectsArrested >= raid.metrics.totalSuspects then
		local callback = raidCompleteCallbacks[player.UserId]
		if callback then
			task.spawn(callback)
		end
	end
end

function RaidController.recordCollateral(player: Player)
	local raid = activeRaids[player.UserId]
	if not raid or raid.isComplete then
		return
	end
	raid.metrics.collateralDamage += 1
end

function RaidController.recordEvidenceDestroyed(player: Player)
	local raid = activeRaids[player.UserId]
	if not raid or raid.isComplete then
		return
	end
	raid.metrics.evidenceDestroyed += 1
end

function RaidController.endRaid(player: Player): RaidMetrics?
	local raid = activeRaids[player.UserId]
	if not raid or raid.isComplete then
		return nil
	end

	raid.isComplete = true
	raid.metrics.timeElapsed = tick() - raid.startTime

	-- Despawn NPC models
	for _, npc in raid.npcs do
		if npc.model then
			npc.model:Destroy()
			npc.model = nil
		end
	end

	getRemote("RaidEnded"):FireClient(player, {
		metrics = raid.metrics,
	})

	print("[RaidController] Raid ended for", player.Name, "| Time:", string.format("%.1f", raid.metrics.timeElapsed), "s")
	return raid.metrics
end

function RaidController.cleanup(player: Player)
	local raid = activeRaids[player.UserId]
	if raid then
		for _, npc in raid.npcs do
			if npc.model then
				npc.model:Destroy()
			end
		end
	end
	activeRaids[player.UserId] = nil
	raidCompleteCallbacks[player.UserId] = nil
end

return RaidController
