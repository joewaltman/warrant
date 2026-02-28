--!strict
-- EvidenceSystem | WARRANT: Case Closed
-- Server-authoritative evidence discovery, Intel Meter tracking, and breach triggering

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

type EvidenceItem = Types.EvidenceItem
type DiscoveryMethod = Types.DiscoveryMethod

export type PlayerIntelState = {
	points: number,
	tier: number,
	discoveredEvidence: { [string]: boolean },
	frozen: boolean,
}

local EvidenceSystem = {}

-- Intel state per player (keyed by UserId)
local playerIntel: { [number]: PlayerIntelState } = {}

-- Evidence items for active cases (keyed by caseId)
local caseEvidence: { [string]: { EvidenceItem } } = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

local function calculateTier(points: number): number
	local tier = 0
	for i = 4, 0, -1 do
		if points >= GameConfig.INTEL_THRESHOLDS[i] then
			tier = i
			break
		end
	end
	return tier
end

function EvidenceSystem.initForPlayer(player: Player)
	playerIntel[player.UserId] = {
		points = 0,
		tier = 0,
		discoveredEvidence = {},
		frozen = false,
	}
end

function EvidenceSystem.loadEvidence(caseId: string, evidence: { EvidenceItem })
	caseEvidence[caseId] = evidence
end

function EvidenceSystem.getEvidence(caseId: string): { EvidenceItem }
	return caseEvidence[caseId] or {}
end

function EvidenceSystem.getPlayerIntel(player: Player): PlayerIntelState?
	return playerIntel[player.UserId]
end

function EvidenceSystem.discoverEvidence(player: Player, caseId: string, evidenceId: string): (boolean, string?)
	local intel = playerIntel[player.UserId]
	if not intel then
		return false, "No intel state for player"
	end

	-- Cannot discover after breach
	if intel.frozen then
		return false, "Intel meter is frozen (breach in progress)"
	end

	-- Check if already discovered
	if intel.discoveredEvidence[evidenceId] then
		return false, "Evidence already discovered"
	end

	-- Find the evidence item
	local evidence = caseEvidence[caseId]
	if not evidence then
		return false, "No evidence loaded for case"
	end

	local item: EvidenceItem? = nil
	for _, e in evidence do
		if e.id == evidenceId then
			item = e
			break
		end
	end

	if not item then
		return false, "Invalid evidence ID"
	end

	-- Award points
	intel.discoveredEvidence[evidenceId] = true
	intel.points += item.pointValue

	-- Recalculate tier
	local oldTier = intel.tier
	intel.tier = calculateTier(intel.points)

	-- Notify client of intel update
	getRemote("IntelUpdated"):FireClient(player, {
		points = intel.points,
		tier = intel.tier,
		tierName = GameConfig.INTEL_TIER_REVEALS[intel.tier + 1].tierName,
		evidenceId = evidenceId,
		evidenceName = item.name,
		pointValue = item.pointValue,
	})

	-- Notify on tier change
	if intel.tier > oldTier then
		getRemote("IntelTierChanged"):FireClient(player, {
			newTier = intel.tier,
			tierName = GameConfig.INTEL_TIER_REVEALS[intel.tier + 1].tierName,
			tierConfig = GameConfig.INTEL_TIER_REVEALS[intel.tier + 1],
		})
	end

	print("[EvidenceSystem]", player.Name, "discovered:", item.name, "Points:", intel.points, "Tier:", intel.tier)
	return true, nil
end

function EvidenceSystem.breach(player: Player): (boolean, number)
	local intel = playerIntel[player.UserId]
	if not intel then
		return false, 0
	end

	if intel.frozen then
		return false, intel.tier
	end

	-- Freeze the intel meter — no more evidence collection
	intel.frozen = true

	-- Notify client
	getRemote("BreachInitiated"):FireClient(player, {
		tier = intel.tier,
		tierName = GameConfig.INTEL_TIER_REVEALS[intel.tier + 1].tierName,
		points = intel.points,
	})

	print("[EvidenceSystem] BREACH by", player.Name, "at Tier", intel.tier, "(", intel.points, "pts)")
	return true, intel.tier
end

function EvidenceSystem.getDiscoveredCount(player: Player): number
	local intel = playerIntel[player.UserId]
	if not intel then
		return 0
	end

	local count = 0
	for _ in intel.discoveredEvidence do
		count += 1
	end
	return count
end

function EvidenceSystem.cleanup(player: Player)
	playerIntel[player.UserId] = nil
end

function EvidenceSystem.cleanupCase(caseId: string)
	caseEvidence[caseId] = nil
end

return EvidenceSystem
