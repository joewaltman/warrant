--!strict
-- PlaceRegistry | WARRANT: Case Closed
-- Central caseId ↔ placeId registry for multi-place universe.
-- All placeIds default to 0; fill in real IDs after publishing places in Studio.

local PlaceRegistry = {}

-- The main hub / start place (fill in after publishing)
PlaceRegistry.HUB_PLACE_ID = 0 :: number

-- caseId → placeId map (one place per case type)
-- Set each value to the published placeId for that case.
local CASE_PLACE_IDS: { [string]: number } = {
	-- Elm Heights
	elm_01 = 0,
	elm_02 = 0,
	elm_03 = 0,
	elm_04 = 0,
	-- Neon Strip
	neon_01 = 0,
	neon_02 = 0,
	neon_03 = 0,
	neon_04 = 0,
	-- Dockside
	dock_01 = 0,
	dock_02 = 0,
	dock_03 = 0,
	dock_04 = 0,
	-- Old Town
	old_01 = 0,
	old_02 = 0,
	old_03 = 0,
	old_04 = 0,
	-- Financial District
	fin_01 = 0,
	fin_02 = 0,
	fin_03 = 0,
	fin_04 = 0,
}

-- Reverse lookup: placeId → caseId (built once at require time)
local PLACE_TO_CASE: { [number]: string } = {}
for caseId, placeId in CASE_PLACE_IDS do
	if placeId ~= 0 then
		PLACE_TO_CASE[placeId] = caseId
	end
end

------------------------------------------------------------------------
-- PUBLIC API
------------------------------------------------------------------------

--- Returns the placeId for a given caseId, or nil if unknown.
function PlaceRegistry.getPlaceId(caseId: string): number?
	return CASE_PLACE_IDS[caseId]
end

--- Returns the caseId that matches the current game.PlaceId, or nil if
--- this place is not a case place (e.g. hub or Studio).
function PlaceRegistry.getCaseIdForCurrentPlace(): string?
	return PLACE_TO_CASE[game.PlaceId]
end

--- True when the current server is the hub place.
function PlaceRegistry.isHubPlace(): boolean
	return PlaceRegistry.HUB_PLACE_ID ~= 0 and game.PlaceId == PlaceRegistry.HUB_PLACE_ID
end

--- True when the current server is one of the case places.
function PlaceRegistry.isCasePlace(): boolean
	return PLACE_TO_CASE[game.PlaceId] ~= nil
end

return PlaceRegistry
