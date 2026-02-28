--!strict
-- CaseConfig | WARRANT: Case Closed
-- Elm Heights Case 03 - Missing on Maple Lane
-- Difficulty 1 (Rookie), 3 suspects, 11 evidence items (34 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_03",
		caseName = "Missing on Maple Lane",
		district = "Elm Heights",
		crimeType = "Missing Person",
		difficulty = 1,
		xpReward = 130,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Elm Heights",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Whitfield Residence",
		rooms = {
			{
				name = "LivingRoom",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Kitchen",
				position = Vector3.new(12, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "MasterBedroom",
				position = Vector3.new(0, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "ChildsBedroom",
				position = Vector3.new(12, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Garage",
				position = Vector3.new(-12, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 5), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(7, 0, 0), size = Vector3.new(1, 7, 4), name = "KitchenDoor" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "MasterBedroomDoor" },
			{ position = Vector3.new(12, 0, -6), size = Vector3.new(4, 7, 1), name = "ChildsBedroomDoor" },
			{ position = Vector3.new(-6, 0, 0), size = Vector3.new(1, 7, 4), name = "GarageDoor" },
		},
		props = {
			-- LivingRoom props (room at 0,0,0 size 10x10x10)
			{ name = "LivingCouch", position = Vector3.new(2, 0, 3), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(2, 0, 8), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(7, 0, 7), preset = "lamp" },
			-- Kitchen props (room at 12,0,0 size 10x10x10)
			{ name = "KitchenCounter", position = Vector3.new(13, 0, 1), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(16, 0, 5), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(15, 0, 4), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(17, 0, 4), preset = "chair" },
			-- MasterBedroom props (room at 0,0,-12 size 10x10x10)
			{ name = "MasterBed", position = Vector3.new(2, 0, -10), preset = "bed" },
			{ name = "MasterDesk", position = Vector3.new(7, 0, -8), preset = "desk" },
			{ name = "MasterLamp", position = Vector3.new(1, 0, -5), preset = "lamp" },
			-- ChildsBedroom props (room at 12,0,-12 size 10x10x10)
			{ name = "ChildBed", position = Vector3.new(14, 0, -10), preset = "bed" },
			{ name = "ChildShelf", position = Vector3.new(19, 0, -6), preset = "shelf" },
			{ name = "ChildLamp", position = Vector3.new(14, 0, -5), preset = "lamp" },
			-- Garage props (room at -12,0,0 size 10x10x10)
			{ name = "GarageCrate1", position = Vector3.new(-10, 0, 2), preset = "crate" },
			{ name = "GarageCrate2", position = Vector3.new(-8, 0, 2), preset = "crate" },
			{ name = "GarageShelf", position = Vector3.new(-5, 0, 7), preset = "shelf" },
		},
	}
end

return module
