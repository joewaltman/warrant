--!strict
-- ScoringSystem | WARRANT: Case Closed
-- End-of-case scoring: balances Cowboy (Tier 0) vs Detective (Tier 4) playstyles

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

type ScoringResult = Types.ScoringResult
type CaseData = Types.CaseData

export type RaidMetricsInput = {
	timeElapsed: number,
	shotsFired: number,
	nonLethalTakedowns: number,
	lethalTakedowns: number,
	collateralDamage: number,
	suspectsArrested: number,
	totalSuspects: number,
	evidenceDestroyed: number,
}

local ScoringSystem = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

-- Par times per difficulty (in seconds)
local PAR_TIMES = {
	[1] = 180, -- 3 minutes
	[2] = 300, -- 5 minutes
	[3] = 420, -- 7 minutes
	[4] = 600, -- 10 minutes
}

function ScoringSystem.calculateScore(
	caseData: CaseData,
	intelTier: number,
	evidencePoints: number,
	raidMetrics: RaidMetricsInput
): ScoringResult
	local tierConfig = GameConfig.SCORING_TIERS[intelTier]
	local bonuses = GameConfig.SCORING_BONUSES

	-- 1. Investigation XP: evidence points scaled by tier multiplier
	local investigationXP = evidencePoints * tierConfig.investigationXPMult * caseData.xpReward / 30
	-- Normalize: at tier 4 with 30 points (max), investigationXP = full xpReward portion

	-- 2. Raid difficulty bonus: base XP scaled by tier's raid multiplier
	local baseRaidXP = caseData.xpReward * 0.5
	local raidDifficultyBonus = baseRaidXP * tierConfig.raidDifficultyBonus

	-- 3. Case score multiplier applied to total
	local caseScoreMultiplier = tierConfig.caseScoreMult

	-- 4. Non-lethal bonus
	local nonLethalBonus = 0
	local totalTakedowns = raidMetrics.nonLethalTakedowns + raidMetrics.lethalTakedowns
	if totalTakedowns > 0 then
		-- Per-suspect non-lethal bonus
		nonLethalBonus = raidMetrics.nonLethalTakedowns * bonuses.nonLethalArrestBonus

		-- All-nonlethal bonus
		if raidMetrics.lethalTakedowns == 0 and raidMetrics.nonLethalTakedowns > 0 then
			nonLethalBonus += bonuses.allNonLethalBonus * (investigationXP + raidDifficultyBonus)
		end
	end

	-- 5. Speed bonus
	local speedBonus = 0
	local parTime = PAR_TIMES[caseData.difficulty] or 300
	if raidMetrics.timeElapsed < parTime then
		speedBonus = bonuses.speedBonus * (investigationXP + raidDifficultyBonus)
	end

	-- 6. Collateral penalty
	local collateralPenalty = 0
	if raidMetrics.collateralDamage > 0 then
		collateralPenalty = raidMetrics.collateralDamage * bonuses.collateralPenalty * (investigationXP + raidDifficultyBonus)
		collateralPenalty = math.abs(collateralPenalty) -- Store as positive for display, subtract below
	end

	-- Total XP calculation
	local subtotal = (investigationXP + raidDifficultyBonus + nonLethalBonus + speedBonus - collateralPenalty)
	local totalXP = math.max(0, math.floor(subtotal * caseScoreMultiplier))

	local result: ScoringResult = {
		investigationXP = math.floor(investigationXP),
		raidDifficultyBonus = math.floor(raidDifficultyBonus),
		caseScoreMultiplier = caseScoreMultiplier,
		nonLethalBonus = math.floor(nonLethalBonus),
		speedBonus = math.floor(speedBonus),
		collateralPenalty = math.floor(collateralPenalty),
		totalXP = totalXP,
	}

	return result
end

function ScoringSystem.presentScore(player: Player, result: ScoringResult)
	getRemote("ScorePresented"):FireClient(player, {
		investigationXP = result.investigationXP,
		raidDifficultyBonus = result.raidDifficultyBonus,
		caseScoreMultiplier = result.caseScoreMultiplier,
		nonLethalBonus = result.nonLethalBonus,
		speedBonus = result.speedBonus,
		collateralPenalty = result.collateralPenalty,
		totalXP = result.totalXP,
	})

	print("[ScoringSystem] Score for", player.Name, "| Total XP:", result.totalXP)
end

return ScoringSystem
