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

local PAR_TIMES = table.freeze({
	[1] = 180, -- 3 minutes
	[2] = 300, -- 5 minutes
	[3] = 420, -- 7 minutes
	[4] = 600, -- 10 minutes
})

local SCORE_GRADES = table.freeze({
	table.freeze({ letter = "S", minPct = 0.90, stars = 5 }),
	table.freeze({ letter = "A", minPct = 0.75, stars = 4 }),
	table.freeze({ letter = "B", minPct = 0.60, stars = 3 }),
	table.freeze({ letter = "C", minPct = 0.40, stars = 2 }),
	table.freeze({ letter = "D", minPct = 0.20, stars = 2 }),
	table.freeze({ letter = "F", minPct = 0, stars = 1 }),
}) :: any

local DISTRICT_ORDER = table.freeze({
	"Elm Heights",
	"Dockside",
	"Neon Strip",
	"Old Town",
	"Financial District",
})

local BADGE_DEFINITIONS: { Types.BadgeDefinition } = table.freeze({
	table.freeze({ id = "first_case", name = "First Case", description = "Complete your first case", stat = "casesCompleted", threshold = 1 }),
	table.freeze({ id = "detective", name = "Detective", description = "Complete 5 cases", stat = "casesCompleted", threshold = 5 }),
	table.freeze({ id = "veteran_detective", name = "Veteran Detective", description = "Complete 15 cases", stat = "casesCompleted", threshold = 15 }),
	table.freeze({ id = "sharpshooter", name = "Sharpshooter", description = "Complete 3 perfect raids", stat = "perfectRaids", threshold = 3 }),
	table.freeze({ id = "pacifist", name = "Pacifist", description = "Complete 10 perfect raids", stat = "perfectRaids", threshold = 10 }),
	table.freeze({ id = "evidence_hound", name = "Evidence Hound", description = "Find 50 total evidence", stat = "totalEvidenceFound", threshold = 50 }),
	table.freeze({ id = "forensic_expert", name = "Forensic Expert", description = "Find 150 total evidence", stat = "totalEvidenceFound", threshold = 150 }),
	table.freeze({ id = "speedster", name = "Speedster", description = "Beat par time 3 times", stat = "speedRecords", threshold = 3 }),
	table.freeze({ id = "lightning", name = "Lightning", description = "Beat par time 10 times", stat = "speedRecords", threshold = 10 }),
	table.freeze({ id = "xp_hoarder", name = "XP Hoarder", description = "Earn 5000 total XP", stat = "totalXPEarned", threshold = 5000 }),
	table.freeze({ id = "xp_mogul", name = "XP Mogul", description = "Earn 25000 total XP", stat = "totalXPEarned", threshold = 25000 }),
	table.freeze({ id = "airtight", name = "Airtight", description = "Reach Airtight intel tier", stat = "highestIntelTier", threshold = 4 }),
}) :: any

local TITLE_DEFINITIONS: { Types.TitleDefinition } = table.freeze({
	table.freeze({ id = "rookie_cop", displayName = "Rookie Cop", description = "Complete your first case", stat = "casesCompleted", threshold = 1 }),
	table.freeze({ id = "the_detective", displayName = "The Detective", description = "Complete 10 cases", stat = "casesCompleted", threshold = 10 }),
	table.freeze({ id = "ghost", displayName = "Ghost", description = "Complete 5 perfect raids", stat = "perfectRaids", threshold = 5 }),
	table.freeze({ id = "cowboy_cop", displayName = "Cowboy Cop", description = "Earn 10000 total XP", stat = "totalXPEarned", threshold = 10000 }),
	table.freeze({ id = "speed_demon", displayName = "Speed Demon", description = "Beat par time 5 times", stat = "speedRecords", threshold = 5 }),
	table.freeze({ id = "bloodhound", displayName = "Bloodhound", description = "Find 100 total evidence", stat = "totalEvidenceFound", threshold = 100 }),
	table.freeze({ id = "commissioner", displayName = "Commissioner", description = "Complete 20 cases", stat = "casesCompleted", threshold = 20 }),
	table.freeze({ id = "legend", displayName = "Legend", description = "Earn 50000 total XP", stat = "totalXPEarned", threshold = 50000 }),
}) :: any

return table.freeze({
	INTEL_THRESHOLDS = INTEL_THRESHOLDS,
	SCORING_TIERS = SCORING_TIERS,
	SCORING_BONUSES = SCORING_BONUSES,
	RANKS = RANKS,
	XP_CURVE = XP_CURVE,
	TOOL_UNLOCKS = TOOL_UNLOCKS,
	INTEL_TIER_REVEALS = INTEL_TIER_REVEALS,
	PAR_TIMES = PAR_TIMES,
	SCORE_GRADES = SCORE_GRADES,
	DISTRICT_ORDER = DISTRICT_ORDER,
	BADGE_DEFINITIONS = BADGE_DEFINITIONS,
	TITLE_DEFINITIONS = TITLE_DEFINITIONS,
})
