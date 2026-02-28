--!strict
-- ProgressionSystem | WARRANT: Case Closed
-- XP, ranks, DataStore persistence, tool/case unlock validation

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

type PlayerRank = Types.PlayerRank
type SyndicateStats = Types.SyndicateStats
type DetectivePvpStats = Types.DetectivePvpStats
type DetectiveStats = Types.DetectiveStats

export type PlayerData = {
	xp: number,
	level: number,
	completedCases: { [string]: number }, -- caseId -> bestScore
	equippedCosmetics: { [string]: string },
	syndicateStats: SyndicateStats,
	detectivePvpStats: DetectivePvpStats,
	unlockedTitles: { string },
	unlockedBadges: { string },
	equippedTitle: string?,
	detectiveStats: DetectiveStats,
	tutorialStep: number,
}

local ProgressionSystem = {}

local playerDataStore = DataStoreService:GetDataStore("WARRANT_PlayerData_v1")
local playerDataCache: { [number]: PlayerData } = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

local function defaultPlayerData(): PlayerData
	return {
		xp = 0,
		level = 1,
		completedCases = {},
		equippedCosmetics = {},
		syndicateStats = {
			syndicateWins = 0,
			perfectHides = 0,
			disguiseFooled = 0,
			detectivesEliminated = 0,
			trapTriggers = 0,
			clockWins = 0,
			syndicateWinStreak = 0,
		},
		detectivePvpStats = {
			detectivePvpWins = 0,
			disguisesExposed = 0,
			speedSolves = 0,
			cleanSweeps = 0,
			clutchWins = 0,
		},
		unlockedTitles = {},
		unlockedBadges = {},
		equippedTitle = nil,
		detectiveStats = {
			casesCompleted = 0,
			totalEvidenceFound = 0,
			perfectRaids = 0,
			speedRecords = 0,
			totalXPEarned = 0,
			favoriteDistrict = "",
			highestIntelTier = 0,
		},
		tutorialStep = 0,
	}
end

local function xpForLevel(level: number): number
	return math.floor(GameConfig.XP_CURVE.BASE_XP * level ^ GameConfig.XP_CURVE.EXPONENT)
end

local function calculateLevel(totalXP: number): number
	local level = 1
	local xpAccum = 0
	while level < GameConfig.XP_CURVE.MAX_LEVEL do
		local needed = xpForLevel(level)
		if xpAccum + needed > totalXP then
			break
		end
		xpAccum += needed
		level += 1
	end
	return level
end

local function getRankForLevel(level: number): PlayerRank?
	for _, rank in GameConfig.RANKS do
		if level >= rank.minLevel and level <= rank.maxLevel then
			return rank
		end
	end
	-- If above all ranges, return last rank
	return GameConfig.RANKS[#GameConfig.RANKS]
end

function ProgressionSystem.loadPlayer(player: Player)
	local success, data = pcall(function()
		return playerDataStore:GetAsync("player_" .. tostring(player.UserId))
	end)

	if success and data then
		-- Merge with defaults to handle schema migrations
		local defaults = defaultPlayerData()
		local loaded = data :: any

		local playerData: PlayerData = {
			xp = loaded.xp or defaults.xp,
			level = loaded.level or defaults.level,
			completedCases = loaded.completedCases or defaults.completedCases,
			equippedCosmetics = loaded.equippedCosmetics or defaults.equippedCosmetics,
			syndicateStats = loaded.syndicateStats or defaults.syndicateStats,
			detectivePvpStats = loaded.detectivePvpStats or defaults.detectivePvpStats,
			unlockedTitles = loaded.unlockedTitles or defaults.unlockedTitles,
			unlockedBadges = loaded.unlockedBadges or defaults.unlockedBadges,
			equippedTitle = loaded.equippedTitle,
			detectiveStats = loaded.detectiveStats or defaults.detectiveStats,
			tutorialStep = loaded.tutorialStep or defaults.tutorialStep,
		}

		playerDataCache[player.UserId] = playerData
	else
		playerDataCache[player.UserId] = defaultPlayerData()
	end

	-- Send initial data to client
	getRemote("PlayerDataLoaded"):FireClient(player, {
		level = playerDataCache[player.UserId].level,
		xp = playerDataCache[player.UserId].xp,
		rank = getRankForLevel(playerDataCache[player.UserId].level),
	})

	print("[ProgressionSystem] Loaded data for", player.Name, "| Level:", playerDataCache[player.UserId].level)
end

function ProgressionSystem.savePlayer(player: Player)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	local success, err = pcall(function()
		playerDataStore:SetAsync("player_" .. tostring(player.UserId), data)
	end)

	if not success then
		warn("[ProgressionSystem] Failed to save data for", player.Name, ":", err)
	end
end

function ProgressionSystem.getPlayerData(player: Player): PlayerData?
	return playerDataCache[player.UserId]
end

function ProgressionSystem.getPlayerLevel(player: Player): number
	local data = playerDataCache[player.UserId]
	return if data then data.level else 1
end

function ProgressionSystem.awardXP(player: Player, amount: number): (number, boolean, PlayerRank?)
	local data = playerDataCache[player.UserId]
	if not data then
		return 0, false, nil
	end

	local oldLevel = data.level
	data.xp += amount
	data.level = calculateLevel(data.xp)

	local didLevelUp = data.level > oldLevel
	local newRank: PlayerRank? = nil

	if didLevelUp then
		local oldRank = getRankForLevel(oldLevel)
		local currentRank = getRankForLevel(data.level)
		if currentRank and oldRank and currentRank.rankName ~= oldRank.rankName then
			newRank = currentRank
		end

		getRemote("LevelUp"):FireClient(player, {
			newLevel = data.level,
			totalXP = data.xp,
			rank = currentRank,
		})

		if newRank then
			getRemote("RankUp"):FireClient(player, {
				newRank = newRank.rankName,
				level = data.level,
			})
			print("[ProgressionSystem]", player.Name, "ranked up to", newRank.rankName)
		end
	end

	-- Update client
	getRemote("XPAwarded"):FireClient(player, {
		amount = amount,
		totalXP = data.xp,
		level = data.level,
	})

	return data.level, didLevelUp, newRank
end

function ProgressionSystem.recordCaseCompletion(player: Player, caseId: string, score: number)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	local best = data.completedCases[caseId]
	if not best or score > best then
		data.completedCases[caseId] = score
	end
end

function ProgressionSystem.isToolUnlocked(player: Player, toolName: string): boolean
	local level = ProgressionSystem.getPlayerLevel(player)
	local requiredLevel = (GameConfig.TOOL_UNLOCKS :: any)[toolName]
	if not requiredLevel then
		return false
	end
	return level >= requiredLevel
end

function ProgressionSystem.isCaseAvailable(player: Player, difficulty: number): boolean
	local level = ProgressionSystem.getPlayerLevel(player)
	-- Difficulty 1 = level 1+, 2 = level 6+, 3 = level 16+, 4 = level 31+
	local requiredLevels = { [1] = 1, [2] = 6, [3] = 16, [4] = 31 }
	local required = requiredLevels[difficulty] or 1
	return level >= required
end

function ProgressionSystem.getUnlockedTools(player: Player): { string }
	local level = ProgressionSystem.getPlayerLevel(player)
	local tools: { string } = {}
	for name, requiredLevel in GameConfig.TOOL_UNLOCKS :: any do
		if level >= requiredLevel then
			table.insert(tools, name)
		end
	end
	return tools
end

function ProgressionSystem.updateSyndicateStat(player: Player, stat: string, increment: number)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	local stats = data.syndicateStats :: any
	if stats[stat] ~= nil then
		stats[stat] += increment
	end
end

function ProgressionSystem.updateDetectivePvpStat(player: Player, stat: string, increment: number)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	local stats = data.detectivePvpStats :: any
	if stats[stat] ~= nil then
		stats[stat] += increment
	end
end

function ProgressionSystem.unlockTitle(player: Player, title: string)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	-- Check if already unlocked
	for _, t in data.unlockedTitles do
		if t == title then
			return
		end
	end

	table.insert(data.unlockedTitles, title)
	getRemote("TitleUnlocked"):FireClient(player, title)
end

function ProgressionSystem.unlockBadge(player: Player, badge: string)
	local data = playerDataCache[player.UserId]
	if not data then
		return
	end

	for _, b in data.unlockedBadges do
		if b == badge then
			return
		end
	end

	table.insert(data.unlockedBadges, badge)
	getRemote("BadgeUnlocked"):FireClient(player, badge)
end

function ProgressionSystem.cleanup(player: Player)
	ProgressionSystem.savePlayer(player)
	playerDataCache[player.UserId] = nil
end

return ProgressionSystem
