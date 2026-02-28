--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 01: The Torch — Arson investigation in an Old Town brownstone

local module = {}

function module.getData()
	return {
		caseId = "old_01",
		caseName = "The Torch",
		district = "Old Town",
		crimeType = "Arson",
		difficulty = 3,
		xpReward = 350,
	}
end

function module.getLayout()
	return {
		district = "Old Town",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Moretti Brownstone",
		rooms = {
			{ name = "Parlor", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Kitchen", position = Vector3.new(12, 0, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Bedroom", position = Vector3.new(0, 10, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Attic", position = Vector3.new(0, 20, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Basement", position = Vector3.new(0, -10, 0), size = Vector3.new(12, 10, 12) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Front Door" },
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Parlor to Kitchen" },
			{ position = Vector3.new(6, 10, 6), size = Vector3.new(4, 7, 1), name = "Stairway to Bedroom" },
			{ position = Vector3.new(6, 20, 6), size = Vector3.new(4, 7, 1), name = "Attic Hatch" },
			{ position = Vector3.new(6, -10, 6), size = Vector3.new(4, 7, 1), name = "Basement Stairs" },
		},
		props = {
			-- Parlor (0,0,0) 12x10x12
			{ name = "ParlorCouch", position = Vector3.new(2, 0, 2), preset = "couch" },
			{ name = "ParlorTable", position = Vector3.new(6, 0, 5), preset = "table_round" },
			{ name = "ParlorLamp1", position = Vector3.new(1, 0, 1), preset = "lamp" },
			{ name = "ParlorLamp2", position = Vector3.new(10, 0, 1), preset = "lamp" },
			{ name = "ParlorCover", position = Vector3.new(9, 0, 9), preset = "cover_low" },
			-- Kitchen (12,0,0) 12x10x12
			{ name = "KitchenCounter", position = Vector3.new(13, 0, 1), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(18, 0, 6), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(17, 0, 4), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(20, 0, 4), preset = "chair" },
			-- Bedroom (0,10,0) 12x10x12
			{ name = "BedroomBed", position = Vector3.new(2, 10, 2), preset = "bed" },
			{ name = "BedroomDesk", position = Vector3.new(8, 10, 2), preset = "desk" },
			{ name = "BedroomLamp", position = Vector3.new(1, 10, 8), preset = "lamp" },
			{ name = "BedroomShelf", position = Vector3.new(10, 10, 9), preset = "shelf" },
			-- Attic (0,20,0) 12x8x12
			{ name = "AtticCrate1", position = Vector3.new(2, 20, 2), preset = "crate" },
			{ name = "AtticCrate2", position = Vector3.new(5, 20, 8), preset = "crate" },
			{ name = "AtticCrate3", position = Vector3.new(9, 20, 3), preset = "crate" },
			{ name = "AtticShelf", position = Vector3.new(10, 20, 10), preset = "shelf" },
			-- Basement (0,-10,0) 12x10x12
			{ name = "BasementCrate1", position = Vector3.new(2, -10, 2), preset = "crate" },
			{ name = "BasementCrate2", position = Vector3.new(5, -10, 2), preset = "crate" },
			{ name = "BasementBarrel1", position = Vector3.new(9, -10, 3), preset = "barrel" },
			{ name = "BasementBarrel2", position = Vector3.new(9, -10, 6), preset = "barrel" },
			{ name = "BasementCover", position = Vector3.new(3, -10, 9), preset = "cover_tall" },
		},
	}
end

return module
