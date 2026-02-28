--!strict
-- GameConfig | WARRANT: Case Closed
-- Central game configuration and balance constants

local Types = require(script.Parent.Types)

type IntelTierConfig = Types.IntelTierConfig
type PlayerRank = Types.PlayerRank

local INTEL_THRESHOLDS = table.freeze({
	[0] = 0,
	[1] = 5,
	[2] = 12,
	[3] = 20,
	[4] = 30,
})

local SCORING_TIERS = table.freeze({
	[0] = table.freeze({ investigationXPMult = 0.0, raidDifficultyBonus = 1.5, caseScoreMult = 1.0 }),
	[1] = table.freeze({ investigationXPMult = 0.3, raidDifficultyBonus = 1.3, caseScoreMult = 1.1 }),
	[2] = table.freeze({ investigationXPMult = 0.6, raidDifficultyBonus = 1.15, caseScoreMult = 1.3 }),
	[3] = table.freeze({ investigationXPMult = 0.85, raidDifficultyBonus = 1.0, caseScoreMult = 1.5 }),
	[4] = table.freeze({ investigationXPMult = 1.0, raidDifficultyBonus = 1.0, caseScoreMult = 1.8 }),
})

local SCORING_BONUSES = table.freeze({
	nonLethalArrestBonus = 1.2,
	allNonLethalBonus = 0.20,
	speedBonus = 0.10,
	collateralPenalty = -0.05,
})

local RANKS: { PlayerRank } = table.freeze({
	table.freeze({ rankName = "Cadet", minLevel = 1, maxLevel = 5, unlocks = {} }),
	table.freeze({ rankName = "Officer", minLevel = 6, maxLevel = 15, unlocks = {} }),
	table.freeze({ rankName = "Detective", minLevel = 16, maxLevel = 30, unlocks = {} }),
	table.freeze({ rankName = "Sergeant", minLevel = 31, maxLevel = 50, unlocks = {} }),
	table.freeze({ rankName = "Lieutenant", minLevel = 51, maxLevel = 75, unlocks = {} }),
	table.freeze({ rankName = "Captain", minLevel = 76, maxLevel = 100, unlocks = {} }),
	table.freeze({ rankName = "Commissioner", minLevel = 100, maxLevel = 150, unlocks = {} }),
}) :: any

local XP_CURVE = table.freeze({
	BASE_XP = 100,
	EXPONENT = 1.5,
	MAX_LEVEL = 150,
})

local TOOL_UNLOCKS = table.freeze({
	MagnifyingGlass = 1,
	Camera = 1,
	Tablet = 5,
	Fingerprints = 10,
	UVLight = 15,
	Wiretap = 20,
	Lockpick = 25,
	Drone = 35,
	K9 = 40,
	Thermal = 50,
})

local INTEL_TIER_REVEALS: { IntelTierConfig } = table.freeze({
	table.freeze({
		tier = 0,
		tierName = "Blind" :: Types.IntelTierName,
		pointThreshold = 0,
		revealsSuspectCount = false,
		revealsFloorPlan = false,
		revealsSuspectPositions = false,
		revealsTraps = false,
		autoSurrenderEnabled = false,
	}),
	table.freeze({
		tier = 1,
		tierName = "Hunch" :: Types.IntelTierName,
		pointThreshold = 5,
		revealsSuspectCount = true,
		revealsFloorPlan = false,
		revealsSuspectPositions = false,
		revealsTraps = false,
		autoSurrenderEnabled = false,
	}),
	table.freeze({
		tier = 2,
		tierName = "Lead" :: Types.IntelTierName,
		pointThreshold = 12,
		revealsSuspectCount = true,
		revealsFloorPlan = true,
		revealsSuspectPositions = false,
		revealsTraps = false,
		autoSurrenderEnabled = false,
	}),
	table.freeze({
		tier = 3,
		tierName = "CaseBuilt" :: Types.IntelTierName,
		pointThreshold = 20,
		revealsSuspectCount = true,
		revealsFloorPlan = true,
		revealsSuspectPositions = true,
		revealsTraps = true,
		autoSurrenderEnabled = false,
	}),
	table.freeze({
		tier = 4,
		tierName = "Airtight" :: Types.IntelTierName,
		pointThreshold = 30,
		revealsSuspectCount = true,
		revealsFloorPlan = true,
		revealsSuspectPositions = true,
		revealsTraps = true,
		autoSurrenderEnabled = true,
	}),
}) :: any

return table.freeze({
	INTEL_THRESHOLDS = INTEL_THRESHOLDS,
	SCORING_TIERS = SCORING_TIERS,
	SCORING_BONUSES = SCORING_BONUSES,
	RANKS = RANKS,
	XP_CURVE = XP_CURVE,
	TOOL_UNLOCKS = TOOL_UNLOCKS,
	INTEL_TIER_REVEALS = INTEL_TIER_REVEALS,
})
