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
				size = Vector3.new(16, 12, 14),
			},
			{
				name = "Kitchen",
				position = Vector3.new(16, 0, 0),
				size = Vector3.new(14, 12, 14),
			},
			{
				name = "MasterBedroom",
				position = Vector3.new(0, 0, -16),
				size = Vector3.new(16, 12, 14),
			},
			{
				name = "ChildsBedroom",
				position = Vector3.new(16, 0, -16),
				size = Vector3.new(12, 12, 12),
			},
			{
				name = "Garage",
				position = Vector3.new(-16, 0, 0),
				size = Vector3.new(16, 12, 14),
				floorColor = Color3.fromRGB(140, 140, 145),
				floorMaterial = Enum.Material.Concrete,
				wallColor = Color3.fromRGB(160, 160, 165),
			},
			{
				name = "Bathroom",
				position = Vector3.new(-16, 0, -16),
				size = Vector3.new(10, 12, 8),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 10 },
			},
			{
				name = "BackPorch",
				position = Vector3.new(0, 0, -28),
				size = Vector3.new(16, 12, 6),
			},
			{
				name = "Laundry",
				position = Vector3.new(-16, 0, -10),
				size = Vector3.new(8, 12, 8),
			},
			{
				name = "Attic",
				position = Vector3.new(0, 12, 0),
				size = Vector3.new(18, 8, 14),
				lighting = { brightness = 0.3, color = Color3.fromRGB(255, 220, 180), range = 10 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 7), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(8, 0, 0), size = Vector3.new(1, 7, 4), name = "KitchenDoor" },
			{ position = Vector3.new(0, 0, -9), size = Vector3.new(4, 7, 1), name = "MasterBedroomDoor" },
			{ position = Vector3.new(16, 0, -10), size = Vector3.new(4, 7, 1), name = "ChildsBedroomDoor" },
			{ position = Vector3.new(-8, 0, 0), size = Vector3.new(1, 7, 4), name = "GarageDoor" },
			{ position = Vector3.new(-11, 0, -12), size = Vector3.new(1, 7, 4), name = "BathroomDoor" },
			{ position = Vector3.new(0, 0, -25), size = Vector3.new(4, 7, 1), name = "BackPorchDoor" },
			{ position = Vector3.new(-12, 0, -6), size = Vector3.new(1, 7, 4), name = "LaundryDoor" },
			{ position = Vector3.new(0, 12, 7), size = Vector3.new(4, 7, 1), name = "AtticHatch" },
		},
		props = {
			-- LivingRoom props (room at 0,0,0 size 16x12x14)
			{ name = "LivingCouch", position = Vector3.new(2, 0, 4), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(2, 0, 8), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(7, 0, 6), preset = "lamp" },
			{ name = "LivingRug", position = Vector3.new(0, 0, 2), preset = "rug" },
			{ name = "LivingBookshelf", position = Vector3.new(-6, 0, 0), preset = "bookshelf" },
			{ name = "LivingPlant", position = Vector3.new(6, 0, -4), preset = "potted_plant" },
			{ name = "LivingPicture", position = Vector3.new(-7, 4, 5), preset = "picture_frame" },
			-- Kitchen props (room at 16,0,0 size 14x12x14)
			{ name = "KitchenCounter", position = Vector3.new(17, 0, 2), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(20, 0, 6), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(19, 0, 5), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(21, 0, 5), preset = "chair" },
			{ name = "KitchenFridge", position = Vector3.new(10, 0, -4), preset = "fridge" },
			{ name = "KitchenStove", position = Vector3.new(14, 0, -4), preset = "stove" },
			{ name = "KitchenTrash", position = Vector3.new(22, 0, -4), preset = "trash_can" },
			-- MasterBedroom props (room at 0,0,-16 size 16x12x14)
			{ name = "MasterBed", position = Vector3.new(2, 0, -14), preset = "bed" },
			{ name = "MasterDesk", position = Vector3.new(7, 0, -12), preset = "desk" },
			{ name = "MasterLamp", position = Vector3.new(-4, 0, -10), preset = "lamp" },
			{ name = "MasterMirror", position = Vector3.new(-7, 4, -16), preset = "mirror" },
			{ name = "MasterRug", position = Vector3.new(0, 0, -16), preset = "rug" },
			-- ChildsBedroom props (room at 16,0,-16 size 12x12x12)
			{ name = "ChildBed", position = Vector3.new(18, 0, -14), preset = "bed" },
			{ name = "ChildShelf", position = Vector3.new(21, 0, -12), preset = "shelf" },
			{ name = "ChildLamp", position = Vector3.new(14, 0, -12), preset = "lamp" },
			{ name = "ChildDesk", position = Vector3.new(14, 0, -18), preset = "desk" },
			-- Garage props (room at -16,0,0 size 16x12x14)
			{ name = "GarageCrate1", position = Vector3.new(-14, 0, 3), preset = "crate" },
			{ name = "GarageCrate2", position = Vector3.new(-11, 0, 3), preset = "crate" },
			{ name = "GarageShelf", position = Vector3.new(-10, 0, 7), preset = "shelf" },
			{ name = "GarageBarrel", position = Vector3.new(-20, 0, 5), preset = "barrel" },
			{ name = "GarageCover", position = Vector3.new(-18, 0, -3), preset = "cover_low" },
			-- Bathroom props (room at -16,0,-16 size 10x12x8)
			{ name = "BathroomTub", position = Vector3.new(-18, 0, -18), preset = "bathtub" },
			{ name = "BathroomToilet", position = Vector3.new(-13, 0, -18), preset = "toilet" },
			{ name = "BathroomSink", position = Vector3.new(-13, 0, -14), preset = "sink" },
			{ name = "BathroomMirror", position = Vector3.new(-13, 4, -12), preset = "mirror" },
			-- BackPorch props (room at 0,0,-28 size 16x12x6)
			{ name = "PorchBench", position = Vector3.new(-3, 0, -28), preset = "bench" },
			{ name = "PorchPlant", position = Vector3.new(5, 0, -28), preset = "potted_plant" },
			-- Laundry props (room at -16,0,-10 size 8x12x8)
			{ name = "LaundryWasher", position = Vector3.new(-16, 0, -12), preset = "washer_dryer" },
			{ name = "LaundryShelf", position = Vector3.new(-14, 0, -8), preset = "shelf" },
			-- Attic props (room at 0,12,0 size 18x8x14)
			{ name = "AtticCrate1", position = Vector3.new(-4, 12, 2), preset = "crate" },
			{ name = "AtticCrate2", position = Vector3.new(-2, 12, 2), preset = "crate" },
			{ name = "AtticShelf", position = Vector3.new(6, 12, -4), preset = "shelf" },
			{ name = "AtticLamp", position = Vector3.new(0, 12, 0), preset = "lamp" },
			-- Outdoor props
			{ name = "FrontMailbox", position = Vector3.new(10, 0, 25), preset = "mailbox" },
			{ name = "FrontTree1", position = Vector3.new(-25, 0, 25), preset = "tree" },
			{ name = "FrontTree2", position = Vector3.new(25, 0, 20), preset = "tree" },
			{ name = "StreetLight1", position = Vector3.new(30, 0, 30), preset = "streetlight" },
			{ name = "OutdoorFence", position = Vector3.new(0, 0, 35), preset = "fence_section" },
		},
	}
end

return module
