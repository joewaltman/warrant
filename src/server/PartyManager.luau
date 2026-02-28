--!strict
-- PartyManager | WARRANT: Case Closed
-- Simple party formation system for the hub server

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type PartyInfo = Types.PartyInfo

local PartyManager = {}

local parties: { [string]: PartyInfo } = {}
local playerParty: { [number]: string } = {} -- UserId → partyId

local nextPartyId = 1

------------------------------------------------------------------------
-- PARTY CREATION
------------------------------------------------------------------------
function PartyManager.createParty(leader: Player): string
	-- Leave existing party first
	PartyManager.leaveParty(leader)

	local partyId = "party_" .. tostring(nextPartyId)
	nextPartyId += 1

	parties[partyId] = {
		partyId = partyId,
		leaderId = leader.UserId,
		members = { leader.UserId },
	}
	playerParty[leader.UserId] = partyId

	print("[PartyManager] Party created:", partyId, "leader:", leader.Name)
	return partyId
end

------------------------------------------------------------------------
-- JOIN / LEAVE
------------------------------------------------------------------------
function PartyManager.joinParty(player: Player, partyId: string): boolean
	local party = parties[partyId]
	if not party then
		return false
	end

	-- Leave current party first
	PartyManager.leaveParty(player)

	table.insert(party.members, player.UserId)
	playerParty[player.UserId] = partyId

	print("[PartyManager]", player.Name, "joined party", partyId)
	return true
end

function PartyManager.leaveParty(player: Player)
	local partyId = playerParty[player.UserId]
	if not partyId then
		return
	end

	local party = parties[partyId]
	if not party then
		playerParty[player.UserId] = nil
		return
	end

	-- Remove from members list
	for i, userId in party.members do
		if userId == player.UserId then
			table.remove(party.members, i)
			break
		end
	end
	playerParty[player.UserId] = nil

	-- If leader left or party is empty, disband
	if #party.members == 0 or party.leaderId == player.UserId then
		PartyManager.disbandParty(partyId)
	end

	print("[PartyManager]", player.Name, "left party", partyId)
end

------------------------------------------------------------------------
-- DISBAND
------------------------------------------------------------------------
function PartyManager.disbandParty(partyId: string)
	local party = parties[partyId]
	if not party then
		return
	end

	for _, userId in party.members do
		playerParty[userId] = nil
	end
	parties[partyId] = nil

	print("[PartyManager] Party disbanded:", partyId)
end

------------------------------------------------------------------------
-- QUERIES
------------------------------------------------------------------------
function PartyManager.getParty(player: Player): { Player }?
	local partyId = playerParty[player.UserId]
	if not partyId then
		return nil
	end

	local party = parties[partyId]
	if not party then
		return nil
	end

	local playerList: { Player } = {}
	for _, userId in party.members do
		local p = Players:GetPlayerByUserId(userId)
		if p then
			table.insert(playerList, p)
		end
	end

	return if #playerList > 0 then playerList else nil
end

function PartyManager.getPartyInfo(player: Player): PartyInfo?
	local partyId = playerParty[player.UserId]
	if not partyId then
		return nil
	end
	return parties[partyId]
end

------------------------------------------------------------------------
-- CLEANUP ON PLAYER LEAVE
------------------------------------------------------------------------
function PartyManager.onPlayerRemoving(player: Player)
	PartyManager.leaveParty(player)
end

return PartyManager
