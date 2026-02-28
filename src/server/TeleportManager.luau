--!strict
-- TeleportManager | WARRANT: Case Closed
-- Handles all teleport orchestration: hub → case server and back

local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type TeleportData = Types.TeleportData

local TeleportManager = {}

local MAX_RETRIES = 3
local BASE_BACKOFF = 1 -- seconds
local IS_STUDIO = RunService:IsStudio()

-- Players currently mid-teleport (skip DataStore save in PlayerRemoving)
local teleportingPlayers: { [number]: boolean } = {}

-- In Studio, store teleport data locally since TeleportService doesn't work
local studioTeleportData: { [number]: TeleportData } = {}

------------------------------------------------------------------------
-- STUDIO CHECK
------------------------------------------------------------------------
function TeleportManager.isStudio(): boolean
	return IS_STUDIO
end

------------------------------------------------------------------------
-- RESERVED SERVER CHECK
------------------------------------------------------------------------
function TeleportManager.isReservedServer(): boolean
	return game.PrivateServerId ~= ""
end

------------------------------------------------------------------------
-- TELEPORT TO CASE (hub → reserved server)
-- In Studio, stores teleport data locally and returns false so the
-- caller can fall back to running the case on the same server.
------------------------------------------------------------------------
function TeleportManager.teleportToCase(players: { Player }, caseId: string): boolean
	if #players == 0 then
		return false
	end

	local leader = players[1]
	local memberIds = {}
	for _, p in players do
		table.insert(memberIds, p.UserId)
	end

	local teleportData: TeleportData = {
		caseId = caseId,
		partyLeaderId = leader.UserId,
		partyMembers = memberIds,
	}

	-- Studio: TeleportService doesn't work, fall back to local case
	if IS_STUDIO then
		print("[TeleportManager] Studio detected, running case locally")
		for _, p in players do
			studioTeleportData[p.UserId] = teleportData
		end
		return false
	end

	-- Mark all players as teleporting so hub skips DataStore save
	for _, p in players do
		teleportingPlayers[p.UserId] = true
	end

	local success, code = pcall(function()
		return TeleportService:ReserveServer(game.PlaceId)
	end)
	if not success or not code then
		warn("[TeleportManager] ReserveServer failed:", code)
		for _, p in players do
			teleportingPlayers[p.UserId] = nil
		end
		return false
	end

	local teleportOptions = Instance.new("TeleportOptions")
	teleportOptions.ReservedServerAccessCode = code
	teleportOptions:SetTeleportData(teleportData)

	-- Attempt teleport with retries
	for attempt = 1, MAX_RETRIES do
		local ok, err = pcall(function()
			TeleportService:TeleportAsync(game.PlaceId, players, teleportOptions)
		end)
		if ok then
			print("[TeleportManager] Teleporting", #players, "players to case", caseId)
			return true
		end
		warn("[TeleportManager] Teleport attempt", attempt, "failed:", err)
		if attempt < MAX_RETRIES then
			task.wait(BASE_BACKOFF * (2 ^ (attempt - 1)))
		end
	end

	-- All retries exhausted
	warn("[TeleportManager] All teleport attempts failed for case", caseId)
	for _, p in players do
		teleportingPlayers[p.UserId] = nil
	end
	return false
end

------------------------------------------------------------------------
-- TELEPORT TO HUB (case server → public hub)
------------------------------------------------------------------------
function TeleportManager.teleportToHub(players: { Player })
	if #players == 0 then
		return
	end

	-- Studio: no real teleport, just log
	if IS_STUDIO then
		print("[TeleportManager] Studio detected, skipping hub teleport")
		return
	end

	for attempt = 1, MAX_RETRIES do
		local ok, err = pcall(function()
			TeleportService:TeleportAsync(game.PlaceId, players)
		end)
		if ok then
			print("[TeleportManager] Teleporting", #players, "players back to hub")
			return
		end
		warn("[TeleportManager] Hub teleport attempt", attempt, "failed:", err)
		if attempt < MAX_RETRIES then
			task.wait(BASE_BACKOFF * (2 ^ (attempt - 1)))
		end
	end

	warn("[TeleportManager] All hub teleport attempts failed")
end

------------------------------------------------------------------------
-- READ ARRIVAL DATA (case server reads on PlayerAdded)
------------------------------------------------------------------------
function TeleportManager.getTeleportData(player: Player): TeleportData?
	local success, data = pcall(function()
		return player:GetJoinData().TeleportData
	end)
	if success and data then
		return data :: TeleportData
	end
	return nil
end

------------------------------------------------------------------------
-- TELEPORT STATE QUERIES
------------------------------------------------------------------------
function TeleportManager.isPlayerTeleporting(player: Player): boolean
	return teleportingPlayers[player.UserId] == true
end

function TeleportManager.clearTeleportingFlag(player: Player)
	teleportingPlayers[player.UserId] = nil
end

------------------------------------------------------------------------
-- TELEPORT FAILURE HANDLER
------------------------------------------------------------------------
TeleportService.TeleportInitFailed:Connect(function(player, teleportResult, errorMessage)
	warn("[TeleportManager] TeleportInitFailed for", player.Name, ":", teleportResult.Name, errorMessage)
	teleportingPlayers[player.UserId] = nil
end)

return TeleportManager
