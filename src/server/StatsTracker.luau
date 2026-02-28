--!strict
-- StatsTracker | WARRANT: Case Closed
-- Records detective stats on case completion and serves profile data

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

local ProgressionSystem = require(script.Parent.ProgressionSystem)

type ScoringResult = Types.ScoringResult
type CaseData = Types.CaseData
type DetectiveStats = Types.DetectiveStats

local StatsTracker = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

local function getRankForLevel(level: number): string
	for _, rank in GameConfig.RANKS do
		if level >= rank.minLevel and level <= rank.maxLevel then
			return rank.rankName
		end
	end
	return GameConfig.RANKS[#GameConfig.RANKS].rankName
end

function StatsTracker.recordCaseStats(
	player: Player,
	caseData: CaseData,
	scoringResult: ScoringResult,
	raidMetrics: any,
	intelTier: number
)
	local data = ProgressionSystem.getPlayerData(player)
	if not data then
		return
	end

	local stats = data.detectiveStats

	-- Increment cases completed
	stats.casesCompleted += 1

	-- Count evidence found from raid metrics
	local evidenceFound = 0
	if raidMetrics and raidMetrics.nonLethalTakedowns ~= nil then
		-- Use the evidence count from the scoring; approximate from investigation XP
		evidenceFound = math.max(1, math.floor(scoringResult.investigationXP / 3))
	end
	stats.totalEvidenceFound += evidenceFound

	-- Perfect raid: 0 lethal takedowns
	if raidMetrics and raidMetrics.lethalTakedowns == 0 then
		stats.perfectRaids += 1
	end

	-- Speed record: under par time
	local parTime = (GameConfig.PAR_TIMES :: any)[caseData.difficulty] or 300
	if raidMetrics and raidMetrics.timeElapsed < parTime then
		stats.speedRecords += 1
	end

	-- Total XP earned
	stats.totalXPEarned += scoringResult.totalXP

	-- Favorite district: track in a simple way (most recent district with most cases)
	stats.favoriteDistrict = caseData.district

	-- Highest intel tier
	if intelTier > stats.highestIntelTier then
		stats.highestIntelTier = intelTier
	end

	-- Check milestones after updating stats
	StatsTracker.checkMilestones(player, stats)

	print("[StatsTracker] Updated stats for", player.Name, "| Cases:", stats.casesCompleted)
end

function StatsTracker.checkMilestones(player: Player, detectiveStats: DetectiveStats)
	local statsMap: { [string]: number } = {
		casesCompleted = detectiveStats.casesCompleted,
		totalEvidenceFound = detectiveStats.totalEvidenceFound,
		perfectRaids = detectiveStats.perfectRaids,
		speedRecords = detectiveStats.speedRecords,
		totalXPEarned = detectiveStats.totalXPEarned,
		highestIntelTier = detectiveStats.highestIntelTier,
	}

	-- Check badges
	for _, badge in GameConfig.BADGE_DEFINITIONS do
		local statValue = statsMap[badge.stat] or 0
		if statValue >= badge.threshold then
			ProgressionSystem.unlockBadge(player, badge.id)
		end
	end

	-- Check titles
	for _, title in GameConfig.TITLE_DEFINITIONS do
		local statValue = statsMap[title.stat] or 0
		if statValue >= title.threshold then
			ProgressionSystem.unlockTitle(player, title.id)
		end
	end
end

function StatsTracker.sendProfileData(player: Player)
	local data = ProgressionSystem.getPlayerData(player)
	if not data then
		return
	end

	local rank = getRankForLevel(data.level)

	getRemote("ProfileDataLoaded"):FireClient(player, {
		level = data.level,
		xp = data.xp,
		rank = rank,
		detectiveStats = data.detectiveStats,
		unlockedBadges = data.unlockedBadges,
		unlockedTitles = data.unlockedTitles,
		equippedTitle = data.equippedTitle,
		completedCases = data.completedCases,
	})
end

return StatsTracker
