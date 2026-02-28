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
				position = Vector3.new(-18, 0, 0),
				size = Vector3.new(36, 24, 32),
			},
			{
				name = "Kitchen",
				position = Vector3.new(14, 0, -24),
				size = Vector3.new(28, 24, 28),
			},
			{
				name = "Bedroom",
				position = Vector3.new(-24, 0, 24),
				size = Vector3.new(28, 24, 24),
			},
			{
				name = "Hallway",
				position = Vector3.new(0, 0, 16),
				size = Vector3.new(12, 24, 36),
			},
			{
				name = "DiningRoom",
				position = Vector3.new(20, 0, 8),
				size = Vector3.new(28, 24, 24),
			},
			{
				name = "Bathroom",
				position = Vector3.new(-28, 0, -20),
				size = Vector3.new(16, 24, 16),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 20 },
			},
			{
				name = "FrontPorch",
				position = Vector3.new(0, 0, 40),
				size = Vector3.new(40, 24, 12),
			},
			{
				name = "Closet",
				position = Vector3.new(-10, 0, -12),
				size = Vector3.new(12, 24, 12),
				lighting = { brightness = 0.4, color = Color3.fromRGB(255, 240, 200), range = 12 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, -38), size = Vector3.new(8, 14, 2), name = "BackDoor" },
			{ position = Vector3.new(0, 0, 34), size = Vector3.new(8, 14, 2), name = "FrontDoor" },
			{ position = Vector3.new(-10, 0, 12), size = Vector3.new(2, 14, 8), name = "BedroomDoor" },
			{ position = Vector3.new(6, 0, 8), size = Vector3.new(2, 14, 8), name = "DiningRoomDoor" },
			{ position = Vector3.new(-20, 0, -12), size = Vector3.new(2, 14, 8), name = "BathroomDoor" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(8, 14, 2), name = "ClosetDoor" },
			{ position = Vector3.new(14, 0, -10), size = Vector3.new(8, 14, 2), name = "KitchenDoor" },
		},
		props = {
			-- LivingRoom props
			{ name = "LivingCouch", position = Vector3.new(-12, 0, 4), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(-16, 0, 20), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(4, 0, 16), preset = "lamp" },
			{ name = "LivingCover", position = Vector3.new(-4, 0, 8), preset = "cover_low" },
			{ name = "LivingRug", position = Vector3.new(-12, 0, 10), preset = "rug" },
			{ name = "LivingBookshelf", position = Vector3.new(-32, 0, 0), preset = "bookshelf" },
			{ name = "LivingPlant", position = Vector3.new(0, 0, -8), preset = "potted_plant" },
			{ name = "LivingPicture", position = Vector3.new(-34, 8, 10), preset = "picture_frame" },
			-- Kitchen props
			{ name = "KitchenCounter", position = Vector3.new(16, 0, -20), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(24, 0, -14), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(22, 0, -12), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(26, 0, -12), preset = "chair" },
			{ name = "KitchenFridge", position = Vector3.new(2, 0, -32), preset = "fridge" },
			{ name = "KitchenStove", position = Vector3.new(10, 0, -32), preset = "stove" },
			{ name = "KitchenTrash", position = Vector3.new(26, 0, -32), preset = "trash_can" },
			-- Bedroom props
			{ name = "BedroomBed", position = Vector3.new(-20, 0, 32), preset = "bed" },
			{ name = "BedroomDesk", position = Vector3.new(-12, 0, 28), preset = "desk" },
			{ name = "BedroomLamp", position = Vector3.new(-28, 0, 36), preset = "lamp" },
			{ name = "BedroomMirror", position = Vector3.new(-36, 8, 24), preset = "mirror" },
			{ name = "BedroomRug", position = Vector3.new(-20, 0, 26), preset = "rug" },
			-- Hallway props
			{ name = "HallwayLamp", position = Vector3.new(2, 0, 28), preset = "lamp" },
			{ name = "HallwayPlant", position = Vector3.new(-4, 0, 20), preset = "potted_plant" },
			-- DiningRoom props
			{ name = "DiningTable", position = Vector3.new(20, 0, 8), preset = "table_round" },
			{ name = "DiningChair1", position = Vector3.new(18, 0, 6), preset = "chair" },
			{ name = "DiningChair2", position = Vector3.new(22, 0, 6), preset = "chair" },
			{ name = "DiningChair3", position = Vector3.new(18, 0, 10), preset = "chair" },
			{ name = "DiningChair4", position = Vector3.new(22, 0, 10), preset = "chair" },
			{ name = "DiningShelf", position = Vector3.new(32, 0, 16), preset = "bookshelf" },
			{ name = "DiningLamp", position = Vector3.new(30, 0, 4), preset = "lamp" },
			-- Bathroom props
			{ name = "BathroomTub", position = Vector3.new(-32, 0, -24), preset = "bathtub" },
			{ name = "BathroomToilet", position = Vector3.new(-24, 0, -24), preset = "toilet" },
			{ name = "BathroomSink", position = Vector3.new(-24, 0, -16), preset = "sink" },
			{ name = "BathroomMirror", position = Vector3.new(-24, 8, -12), preset = "mirror" },
			-- FrontPorch props
			{ name = "PorchBench", position = Vector3.new(-10, 0, 44), preset = "bench" },
			{ name = "PorchPlant1", position = Vector3.new(12, 0, 44), preset = "potted_plant" },
			{ name = "PorchPlant2", position = Vector3.new(-16, 0, 44), preset = "potted_plant" },
			-- Closet props
			{ name = "ClosetShelf", position = Vector3.new(-10, 0, -12), preset = "shelf" },
			-- Outdoor props
			{ name = "FrontMailbox", position = Vector3.new(16, 0, 60), preset = "mailbox" },
			{ name = "FrontTree", position = Vector3.new(-40, 0, 60), preset = "tree" },
			{ name = "StreetLight1", position = Vector3.new(50, 0, 70), preset = "streetlight" },
		},
	}
end

return module
