--!strict
-- CaseConfig | WARRANT: Case Closed
-- Tutorial case: Elm Heights Case 01 - The Break-In
-- Difficulty 1 (Rookie), 3 suspects, 10 evidence items (32 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_01",
		caseName = "The Elm Heights Break-In",
		district = "Elm Heights",
		crimeType = "Burglary",
		difficulty = 1,
		xpReward = 100,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Elm Heights",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Elm Heights Residence",
		rooms = {
			{
				name = "LivingRoom",
				position = Vector3.new(-6, 0, 0),
				size = Vector3.new(12, 10, 12),
			},
			{
				name = "Kitchen",
				position = Vector3.new(3, 0, -9),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Bedroom",
				position = Vector3.new(-10, 0, 8),
				size = Vector3.new(8, 10, 8),
			},
			{
				name = "Hallway",
				position = Vector3.new(0, 0, 5),
				size = Vector3.new(4, 10, 14),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, -14), size = Vector3.new(4, 7, 1), name = "BackDoor" },
			{ position = Vector3.new(0, 0, 12), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(-6, 0, 5), size = Vector3.new(1, 7, 4), name = "BedroomDoor" },
		},
		props = {
			-- LivingRoom props (room at -6,0,0 size 12x10x12)
			{ name = "LivingCouch", position = Vector3.new(-4, 0, 1), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(-5, 0, 8), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(2, 0, 6), preset = "lamp" },
			{ name = "LivingCover", position = Vector3.new(0, 0, 3), preset = "cover_low" },
			-- Kitchen props (room at 3,0,-9 size 10x10x10)
			{ name = "KitchenCounter", position = Vector3.new(4, 0, -8), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(7, 0, -5), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(6, 0, -4), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(8, 0, -4), preset = "chair" },
			-- Bedroom props (room at -10,0,8 size 8x10x8)
			{ name = "BedroomBed", position = Vector3.new(-8, 0, 12), preset = "bed" },
			{ name = "BedroomDesk", position = Vector3.new(-5, 0, 10), preset = "desk" },
			{ name = "BedroomLamp", position = Vector3.new(-9, 0, 14), preset = "lamp" },
			-- Hallway props (room at 0,0,5 size 4x10x14)
			{ name = "HallwayLamp", position = Vector3.new(1, 0, 10), preset = "lamp" },
		},
	}
end

return module
