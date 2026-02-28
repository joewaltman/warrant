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
				position = Vector3.new(-9, 0, 0),
				size = Vector3.new(18, 12, 16),
			},
			{
				name = "Kitchen",
				position = Vector3.new(7, 0, -12),
				size = Vector3.new(14, 12, 14),
			},
			{
				name = "Bedroom",
				position = Vector3.new(-12, 0, 12),
				size = Vector3.new(14, 12, 12),
			},
			{
				name = "Hallway",
				position = Vector3.new(0, 0, 8),
				size = Vector3.new(6, 12, 18),
			},
			{
				name = "DiningRoom",
				position = Vector3.new(10, 0, 4),
				size = Vector3.new(14, 12, 12),
			},
			{
				name = "Bathroom",
				position = Vector3.new(-14, 0, -10),
				size = Vector3.new(8, 12, 8),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 10 },
			},
			{
				name = "FrontPorch",
				position = Vector3.new(0, 0, 20),
				size = Vector3.new(20, 12, 6),
			},
			{
				name = "Closet",
				position = Vector3.new(-5, 0, -6),
				size = Vector3.new(6, 12, 6),
				lighting = { brightness = 0.4, color = Color3.fromRGB(255, 240, 200), range = 6 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, -19), size = Vector3.new(4, 7, 1), name = "BackDoor" },
			{ position = Vector3.new(0, 0, 17), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(-5, 0, 6), size = Vector3.new(1, 7, 4), name = "BedroomDoor" },
			{ position = Vector3.new(3, 0, 4), size = Vector3.new(1, 7, 4), name = "DiningRoomDoor" },
			{ position = Vector3.new(-10, 0, -6), size = Vector3.new(1, 7, 4), name = "BathroomDoor" },
			{ position = Vector3.new(0, 0, -3), size = Vector3.new(4, 7, 1), name = "ClosetDoor" },
			{ position = Vector3.new(7, 0, -5), size = Vector3.new(4, 7, 1), name = "KitchenDoor" },
		},
		props = {
			-- LivingRoom props (room at -9,0,0 size 18x12x16)
			{ name = "LivingCouch", position = Vector3.new(-6, 0, 2), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(-8, 0, 10), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(2, 0, 8), preset = "lamp" },
			{ name = "LivingCover", position = Vector3.new(-2, 0, 4), preset = "cover_low" },
			{ name = "LivingRug", position = Vector3.new(-6, 0, 5), preset = "rug" },
			{ name = "LivingBookshelf", position = Vector3.new(-16, 0, 0), preset = "bookshelf" },
			{ name = "LivingPlant", position = Vector3.new(0, 0, -4), preset = "potted_plant" },
			{ name = "LivingPicture", position = Vector3.new(-17, 4, 5), preset = "picture_frame" },
			-- Kitchen props (room at 7,0,-12 size 14x12x14)
			{ name = "KitchenCounter", position = Vector3.new(8, 0, -10), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(12, 0, -7), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(11, 0, -6), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(13, 0, -6), preset = "chair" },
			{ name = "KitchenFridge", position = Vector3.new(1, 0, -16), preset = "fridge" },
			{ name = "KitchenStove", position = Vector3.new(5, 0, -16), preset = "stove" },
			{ name = "KitchenTrash", position = Vector3.new(13, 0, -16), preset = "trash_can" },
			-- Bedroom props (room at -12,0,12 size 14x12x12)
			{ name = "BedroomBed", position = Vector3.new(-10, 0, 16), preset = "bed" },
			{ name = "BedroomDesk", position = Vector3.new(-6, 0, 14), preset = "desk" },
			{ name = "BedroomLamp", position = Vector3.new(-14, 0, 18), preset = "lamp" },
			{ name = "BedroomMirror", position = Vector3.new(-18, 4, 12), preset = "mirror" },
			{ name = "BedroomRug", position = Vector3.new(-10, 0, 13), preset = "rug" },
			-- Hallway props (room at 0,0,8 size 6x12x18)
			{ name = "HallwayLamp", position = Vector3.new(1, 0, 14), preset = "lamp" },
			{ name = "HallwayPlant", position = Vector3.new(-2, 0, 10), preset = "potted_plant" },
			-- DiningRoom props (room at 10,0,4 size 14x12x12)
			{ name = "DiningTable", position = Vector3.new(10, 0, 4), preset = "table_round" },
			{ name = "DiningChair1", position = Vector3.new(9, 0, 3), preset = "chair" },
			{ name = "DiningChair2", position = Vector3.new(11, 0, 3), preset = "chair" },
			{ name = "DiningChair3", position = Vector3.new(9, 0, 5), preset = "chair" },
			{ name = "DiningChair4", position = Vector3.new(11, 0, 5), preset = "chair" },
			{ name = "DiningShelf", position = Vector3.new(16, 0, 8), preset = "bookshelf" },
			{ name = "DiningLamp", position = Vector3.new(15, 0, 2), preset = "lamp" },
			-- Bathroom props (room at -14,0,-10 size 8x12x8)
			{ name = "BathroomTub", position = Vector3.new(-16, 0, -12), preset = "bathtub" },
			{ name = "BathroomToilet", position = Vector3.new(-12, 0, -12), preset = "toilet" },
			{ name = "BathroomSink", position = Vector3.new(-12, 0, -8), preset = "sink" },
			{ name = "BathroomMirror", position = Vector3.new(-12, 4, -6), preset = "mirror" },
			-- FrontPorch props (room at 0,0,20 size 20x12x6)
			{ name = "PorchBench", position = Vector3.new(-5, 0, 22), preset = "bench" },
			{ name = "PorchPlant1", position = Vector3.new(6, 0, 22), preset = "potted_plant" },
			{ name = "PorchPlant2", position = Vector3.new(-8, 0, 22), preset = "potted_plant" },
			-- Closet props (room at -5,0,-6 size 6x12x6)
			{ name = "ClosetShelf", position = Vector3.new(-5, 0, -6), preset = "shelf" },
			-- Outdoor props
			{ name = "FrontMailbox", position = Vector3.new(8, 0, 30), preset = "mailbox" },
			{ name = "FrontTree", position = Vector3.new(-20, 0, 30), preset = "tree" },
			{ name = "StreetLight1", position = Vector3.new(25, 0, 35), preset = "streetlight" },
		},
	}
end

return module
