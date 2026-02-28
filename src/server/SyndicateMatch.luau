--!strict
-- SyndicateMatch | WARRANT: Case Closed
-- 4v4 asymmetric PvP: matchmaking, role assignment, setup/detective phases, disguise mechanics

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type SyndicateRolePreference = Types.SyndicateRolePreference

export type MatchPhase = "Lobby" | "SyndicateSetup" | "DetectivePhase" | "PostMatch"

export type MatchRole = "Detective" | "Syndicate"

export type QueueEntry = {
	player: Player,
	preference: SyndicateRolePreference,
	queueTime: number,
	partyId: string?,
}

export type MatchPlayer = {
	player: Player,
	role: MatchRole,
	isAlive: boolean,
	isDisguised: boolean,
	isExposed: boolean,
	preference: SyndicateRolePreference,
}

export type ActiveMatch = {
	matchId: string,
	phase: MatchPhase,
	detectives: { MatchPlayer },
	syndicate: { MatchPlayer },
	phaseStartTime: number,
	contrabandSecured: boolean,
	matchStartTime: number,
}

local SyndicateMatch = {}

local matchQueue: { QueueEntry } = {}
local activeMatches: { [string]: ActiveMatch } = {}
local playerToMatch: { [number]: string } = {}

local MATCH_SIZE = 8 -- 4v4
local TEAM_SIZE = 4
local MATCHMAKING_TIMEOUT = 60
local SETUP_PHASE_DURATION = 60
local DETECTIVE_PHASE_DURATION = 480 -- 8 minutes
local PREFERENCE_HONOR_RATE = 0.80
local NO_PREFERENCE_BONUS_XP = 0.05

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

local function generateMatchId(): string
	return "match_" .. tostring(tick()) .. "_" .. tostring(math.random(1000, 9999))
end

local function assignRoles(entries: { QueueEntry }): ({ QueueEntry }, { QueueEntry })
	local detectivePool: { QueueEntry } = {}
	local syndicatePool: { QueueEntry } = {}
	local flexPool: { QueueEntry } = {}

	for _, entry in entries do
		if entry.preference == "Detective" then
			table.insert(detectivePool, entry)
		elseif entry.preference == "Syndicate" then
			table.insert(syndicatePool, entry)
		else
			table.insert(flexPool, entry)
		end
	end

	local detectives: { QueueEntry } = {}
	local syndicate: { QueueEntry } = {}

	-- Honor preferences up to PREFERENCE_HONOR_RATE
	for _, entry in detectivePool do
		if #detectives < TEAM_SIZE and math.random() < PREFERENCE_HONOR_RATE then
			table.insert(detectives, entry)
		else
			table.insert(flexPool, entry)
		end
	end

	for _, entry in syndicatePool do
		if #syndicate < TEAM_SIZE and math.random() < PREFERENCE_HONOR_RATE then
			table.insert(syndicate, entry)
		else
			table.insert(flexPool, entry)
		end
	end

	-- Fill remaining slots from flex pool
	for _, entry in flexPool do
		if #detectives < TEAM_SIZE then
			table.insert(detectives, entry)
		elseif #syndicate < TEAM_SIZE then
			table.insert(syndicate, entry)
		end
	end

	return detectives, syndicate
end

function SyndicateMatch.joinQueue(player: Player, preference: SyndicateRolePreference, partyId: string?)
	-- Remove if already in queue
	SyndicateMatch.leaveQueue(player)

	local entry: QueueEntry = {
		player = player,
		preference = preference,
		queueTime = tick(),
		partyId = partyId,
	}

	table.insert(matchQueue, entry)
	getRemote("QueueJoined"):FireClient(player, {
		position = #matchQueue,
		preference = preference,
	})

	print("[SyndicateMatch]", player.Name, "joined queue as", preference)

	-- Try to form a match
	SyndicateMatch.tryFormMatch()
end

function SyndicateMatch.leaveQueue(player: Player)
	for i = #matchQueue, 1, -1 do
		if matchQueue[i].player == player then
			table.remove(matchQueue, i)
			getRemote("QueueLeft"):FireClient(player)
			break
		end
	end
end

function SyndicateMatch.tryFormMatch()
	if #matchQueue < MATCH_SIZE then
		return
	end

	-- Check for parties that need to stay together
	local entries: { QueueEntry } = {}
	local usedIndices: { [number]: boolean } = {}

	-- Simple approach: take first MATCH_SIZE entries
	-- In production, group parties together
	for i = 1, math.min(MATCH_SIZE, #matchQueue) do
		table.insert(entries, matchQueue[i])
		usedIndices[i] = true
	end

	if #entries < MATCH_SIZE then
		return
	end

	-- Remove matched entries from queue (reverse order to preserve indices)
	for i = MATCH_SIZE, 1, -1 do
		table.remove(matchQueue, i)
	end

	-- Assign roles
	local detectiveEntries, syndicateEntries = assignRoles(entries)

	-- Create match
	local matchId = generateMatchId()

	local detectivePlayers: { MatchPlayer } = {}
	for _, entry in detectiveEntries do
		table.insert(detectivePlayers, {
			player = entry.player,
			role = "Detective",
			isAlive = true,
			isDisguised = false,
			isExposed = false,
			preference = entry.preference,
		})
		playerToMatch[entry.player.UserId] = matchId
	end

	local syndicatePlayers: { MatchPlayer } = {}
	for _, entry in syndicateEntries do
		table.insert(syndicatePlayers, {
			player = entry.player,
			role = "Syndicate",
			isAlive = true,
			isDisguised = false,
			isExposed = false,
			preference = entry.preference,
		})
		playerToMatch[entry.player.UserId] = matchId
	end

	local match: ActiveMatch = {
		matchId = matchId,
		phase = "Lobby",
		detectives = detectivePlayers,
		syndicate = syndicatePlayers,
		phaseStartTime = tick(),
		contrabandSecured = false,
		matchStartTime = tick(),
	}

	activeMatches[matchId] = match

	-- Notify all players
	for _, mp in detectivePlayers do
		getRemote("MatchFound"):FireClient(mp.player, {
			matchId = matchId,
			role = "Detective",
			teamSize = TEAM_SIZE,
		})
	end
	for _, mp in syndicatePlayers do
		getRemote("MatchFound"):FireClient(mp.player, {
			matchId = matchId,
			role = "Syndicate",
			teamSize = TEAM_SIZE,
		})
	end

	print("[SyndicateMatch] Match formed:", matchId)

	-- Start setup phase
	SyndicateMatch.startSetupPhase(matchId)
end

function SyndicateMatch.startSetupPhase(matchId: string)
	local match = activeMatches[matchId]
	if not match then
		return
	end

	match.phase = "SyndicateSetup"
	match.phaseStartTime = tick()

	-- Notify syndicate to set up
	for _, mp in match.syndicate do
		getRemote("SetupPhaseStarted"):FireClient(mp.player, {
			duration = SETUP_PHASE_DURATION,
		})
	end

	-- Detectives wait
	for _, mp in match.detectives do
		getRemote("WaitingForSetup"):FireClient(mp.player, {
			duration = SETUP_PHASE_DURATION,
		})
	end

	-- Timer to transition to detective phase
	task.spawn(function()
		task.wait(SETUP_PHASE_DURATION)
		if activeMatches[matchId] and match.phase == "SyndicateSetup" then
			SyndicateMatch.startDetectivePhase(matchId)
		end
	end)
end

function SyndicateMatch.startDetectivePhase(matchId: string)
	local match = activeMatches[matchId]
	if not match then
		return
	end

	match.phase = "DetectivePhase"
	match.phaseStartTime = tick()

	-- Syndicate players disguise as NPCs
	for _, mp in match.syndicate do
		mp.isDisguised = true
	end

	-- Notify all players
	local allPlayers = {}
	for _, mp in match.detectives do
		table.insert(allPlayers, mp.player)
	end
	for _, mp in match.syndicate do
		table.insert(allPlayers, mp.player)
	end

	for _, player in allPlayers do
		getRemote("DetectivePhaseStarted"):FireClient(player, {
			duration = DETECTIVE_PHASE_DURATION,
		})
	end

	-- Timer for clock win
	task.spawn(function()
		task.wait(DETECTIVE_PHASE_DURATION)
		if activeMatches[matchId] and match.phase == "DetectivePhase" then
			-- Syndicate wins by running out the clock
			SyndicateMatch.endMatch(matchId, "Syndicate", "ClockExpired")
		end
	end)
end

function SyndicateMatch.identifySuspect(detectivePlayer: Player, targetPlayer: Player): boolean
	local matchId = playerToMatch[detectivePlayer.UserId]
	if not matchId then
		return false
	end

	local match = activeMatches[matchId]
	if not match or match.phase ~= "DetectivePhase" then
		return false
	end

	-- Check if target is a syndicate player
	for _, mp in match.syndicate do
		if mp.player == targetPlayer and mp.isDisguised and not mp.isExposed then
			mp.isExposed = true
			mp.isDisguised = false

			-- Notify all match players
			for _, dmp in match.detectives do
				getRemote("SuspectExposed"):FireClient(dmp.player, {
					targetName = targetPlayer.Name,
				})
			end
			for _, smp in match.syndicate do
				getRemote("TeamMateExposed"):FireClient(smp.player, {
					targetName = targetPlayer.Name,
				})
			end

			return true
		end
	end

	return false
end

function SyndicateMatch.eliminatePlayer(matchId: string, targetPlayer: Player)
	local match = activeMatches[matchId]
	if not match then
		return
	end

	-- Find and mark player as eliminated
	for _, mp in match.detectives do
		if mp.player == targetPlayer then
			mp.isAlive = false
			break
		end
	end
	for _, mp in match.syndicate do
		if mp.player == targetPlayer then
			mp.isAlive = false
			break
		end
	end

	-- Check win conditions
	local detectivesAlive = 0
	for _, mp in match.detectives do
		if mp.isAlive then
			detectivesAlive += 1
		end
	end

	local syndicateAlive = 0
	for _, mp in match.syndicate do
		if mp.isAlive then
			syndicateAlive += 1
		end
	end

	if detectivesAlive == 0 then
		SyndicateMatch.endMatch(matchId, "Syndicate", "AllDetectivesEliminated")
	elseif syndicateAlive == 0 then
		SyndicateMatch.endMatch(matchId, "Detective", "AllSyndicateArrested")
	end
end

function SyndicateMatch.secureContraband(matchId: string)
	local match = activeMatches[matchId]
	if not match then
		return
	end

	match.contrabandSecured = true
	SyndicateMatch.endMatch(matchId, "Detective", "ContrabandSecured")
end

function SyndicateMatch.endMatch(matchId: string, winner: MatchRole, reason: string)
	local match = activeMatches[matchId]
	if not match or match.phase == "PostMatch" then
		return
	end

	match.phase = "PostMatch"

	-- Notify all players
	local allMatchPlayers: { MatchPlayer } = {}
	for _, mp in match.detectives do
		table.insert(allMatchPlayers, mp)
	end
	for _, mp in match.syndicate do
		table.insert(allMatchPlayers, mp)
	end

	for _, mp in allMatchPlayers do
		local isWinner = mp.role == winner
		local bonusXP = if mp.preference == "NoPreference" then NO_PREFERENCE_BONUS_XP else 0

		getRemote("MatchEnded"):FireClient(mp.player, {
			winner = winner,
			reason = reason,
			isWinner = isWinner,
			role = mp.role,
			bonusXP = bonusXP,
		})
	end

	print("[SyndicateMatch] Match ended:", matchId, "| Winner:", winner, "| Reason:", reason)

	-- Cleanup after delay
	task.spawn(function()
		task.wait(15) -- Post-match screen time
		SyndicateMatch.cleanupMatch(matchId)
	end)
end

function SyndicateMatch.getMatch(matchId: string): ActiveMatch?
	return activeMatches[matchId]
end

function SyndicateMatch.getPlayerMatch(player: Player): ActiveMatch?
	local matchId = playerToMatch[player.UserId]
	if matchId then
		return activeMatches[matchId]
	end
	return nil
end

function SyndicateMatch.cleanupMatch(matchId: string)
	local match = activeMatches[matchId]
	if not match then
		return
	end

	for _, mp in match.detectives do
		playerToMatch[mp.player.UserId] = nil
	end
	for _, mp in match.syndicate do
		playerToMatch[mp.player.UserId] = nil
	end

	activeMatches[matchId] = nil
end

function SyndicateMatch.onPlayerRemoving(player: Player)
	SyndicateMatch.leaveQueue(player)

	local matchId = playerToMatch[player.UserId]
	if matchId then
		SyndicateMatch.eliminatePlayer(matchId, player)
		playerToMatch[player.UserId] = nil
	end
end

return SyndicateMatch
