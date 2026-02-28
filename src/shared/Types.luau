--!strict
-- Types | WARRANT: Case Closed
-- Central type definitions for the entire game

-- Enum-like string literal unions
export type IntelTierName = "Blind" | "Hunch" | "Lead" | "CaseBuilt" | "Airtight"
export type DiscoveryMethod = "proximity" | "interact" | "photograph" | "scan"
export type BehaviorType = "SURRENDER" | "FLEE" | "RESIST"
export type SyndicateRolePreference = "Detective" | "Syndicate" | "NoPreference"
export type CosmeticType = "title" | "badge" | "outfit"

-- Runtime frozen enum table for intel tiers
local IntelTier = table.freeze({
	Blind = 0,
	Hunch = 1,
	Lead = 2,
	CaseBuilt = 3,
	Airtight = 4,
})

-- Core data structures
export type CaseData = {
	caseId: string,
	caseName: string,
	district: string,
	crimeType: string,
	difficulty: number,
	xpReward: number,
}

export type EvidenceItem = {
	id: string,
	name: string,
	description: string,
	pointValue: number,
	discoveryMethod: DiscoveryMethod,
	position: Vector3,
}

export type NPCSuspect = {
	id: string,
	name: string,
	behaviorType: BehaviorType,
	position: Vector3,
	fleeRoute: { Vector3 }?,
	weapon: string?,
	health: number,
	difficulty: number?,
}

export type IntelTierConfig = {
	tier: number,
	tierName: IntelTierName,
	pointThreshold: number,
	revealsSuspectCount: boolean,
	revealsFloorPlan: boolean,
	revealsSuspectPositions: boolean,
	revealsTraps: boolean,
	autoSurrenderEnabled: boolean,
}

export type PlayerRank = {
	rankName: string,
	minLevel: number,
	maxLevel: number,
	unlocks: { string },
}

export type ScoringResult = {
	investigationXP: number,
	raidDifficultyBonus: number,
	caseScoreMultiplier: number,
	nonLethalBonus: number,
	speedBonus: number,
	collateralPenalty: number,
	totalXP: number,
	maxPossibleXP: number,
}

export type DetectiveStats = {
	casesCompleted: number,
	totalEvidenceFound: number,
	perfectRaids: number,
	speedRecords: number,
	totalXPEarned: number,
	favoriteDistrict: string,
	highestIntelTier: number,
}

export type BadgeDefinition = {
	id: string,
	name: string,
	description: string,
	stat: string,
	threshold: number,
	icon: string?,
}

export type TitleDefinition = {
	id: string,
	displayName: string,
	description: string,
	stat: string,
	threshold: number,
}

export type SyndicateStats = {
	syndicateWins: number,
	perfectHides: number,
	disguiseFooled: number,
	detectivesEliminated: number,
	trapTriggers: number,
	clockWins: number,
	syndicateWinStreak: number,
}

export type DetectivePvpStats = {
	detectivePvpWins: number,
	disguisesExposed: number,
	speedSolves: number,
	cleanSweeps: number,
	clutchWins: number,
}

export type CosmeticUnlock = {
	id: string,
	name: string,
	type: CosmeticType,
	requirementStat: string,
	requirementThreshold: number,
}

export type TeleportData = {
	caseId: string,
	partyLeaderId: number,
	partyMembers: { number },
}

export type PartyInfo = {
	partyId: string,
	leaderId: number,
	members: { number }, -- UserIds
}

return table.freeze({
	IntelTier = IntelTier,
})
