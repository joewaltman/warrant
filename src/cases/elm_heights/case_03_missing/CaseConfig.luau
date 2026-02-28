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
				size = Vector3.new(32, 24, 28),
			},
			{
				name = "Kitchen",
				position = Vector3.new(32, 0, 0),
				size = Vector3.new(28, 24, 28),
			},
			{
				name = "MasterBedroom",
				position = Vector3.new(0, 0, -32),
				size = Vector3.new(32, 24, 28),
			},
			{
				name = "ChildsBedroom",
				position = Vector3.new(32, 0, -32),
				size = Vector3.new(24, 24, 24),
			},
			{
				name = "Garage",
				position = Vector3.new(-32, 0, 0),
				size = Vector3.new(32, 24, 28),
				floorColor = Color3.fromRGB(140, 140, 145),
				floorMaterial = Enum.Material.Concrete,
				wallColor = Color3.fromRGB(160, 160, 165),
			},
			{
				name = "Bathroom",
				position = Vector3.new(-32, 0, -32),
				size = Vector3.new(20, 24, 16),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 20 },
			},
			{
				name = "BackPorch",
				position = Vector3.new(0, 0, -56),
				size = Vector3.new(32, 24, 12),
			},
			{
				name = "Laundry",
				position = Vector3.new(-32, 0, -20),
				size = Vector3.new(16, 24, 16),
			},
			{
				name = "Attic",
				position = Vector3.new(0, 24, 0),
				size = Vector3.new(36, 16, 28),
				lighting = { brightness = 0.3, color = Color3.fromRGB(255, 220, 180), range = 20 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 14), size = Vector3.new(8, 14, 2), name = "FrontDoor" },
			{ position = Vector3.new(16, 0, 0), size = Vector3.new(2, 14, 8), name = "KitchenDoor" },
			{ position = Vector3.new(0, 0, -18), size = Vector3.new(8, 14, 2), name = "MasterBedroomDoor" },
			{ position = Vector3.new(32, 0, -20), size = Vector3.new(8, 14, 2), name = "ChildsBedroomDoor" },
			{ position = Vector3.new(-16, 0, 0), size = Vector3.new(2, 14, 8), name = "GarageDoor" },
			{ position = Vector3.new(-22, 0, -24), size = Vector3.new(2, 14, 8), name = "BathroomDoor" },
			{ position = Vector3.new(0, 0, -50), size = Vector3.new(8, 14, 2), name = "BackPorchDoor" },
			{ position = Vector3.new(-24, 0, -12), size = Vector3.new(2, 14, 8), name = "LaundryDoor" },
			{ position = Vector3.new(0, 24, 14), size = Vector3.new(8, 14, 2), name = "AtticHatch" },
		},
		props = {
			-- LivingRoom props
			{ name = "LivingCouch", position = Vector3.new(4, 0, 8), preset = "couch" },
			{ name = "LivingTV", position = Vector3.new(4, 0, 16), preset = "tv" },
			{ name = "LivingLamp", position = Vector3.new(14, 0, 12), preset = "lamp" },
			{ name = "LivingRug", position = Vector3.new(0, 0, 4), preset = "rug" },
			{ name = "LivingBookshelf", position = Vector3.new(-12, 0, 0), preset = "bookshelf" },
			{ name = "LivingPlant", position = Vector3.new(12, 0, -8), preset = "potted_plant" },
			{ name = "LivingPicture", position = Vector3.new(-14, 8, 10), preset = "picture_frame" },
			-- Kitchen props
			{ name = "KitchenCounter", position = Vector3.new(34, 0, 4), preset = "counter" },
			{ name = "KitchenTable", position = Vector3.new(40, 0, 12), preset = "table_round" },
			{ name = "KitchenChair1", position = Vector3.new(38, 0, 10), preset = "chair" },
			{ name = "KitchenChair2", position = Vector3.new(42, 0, 10), preset = "chair" },
			{ name = "KitchenFridge", position = Vector3.new(20, 0, -8), preset = "fridge" },
			{ name = "KitchenStove", position = Vector3.new(28, 0, -8), preset = "stove" },
			{ name = "KitchenTrash", position = Vector3.new(44, 0, -8), preset = "trash_can" },
			-- MasterBedroom props
			{ name = "MasterBed", position = Vector3.new(4, 0, -28), preset = "bed" },
			{ name = "MasterDesk", position = Vector3.new(14, 0, -24), preset = "desk" },
			{ name = "MasterLamp", position = Vector3.new(-8, 0, -20), preset = "lamp" },
			{ name = "MasterMirror", position = Vector3.new(-14, 8, -32), preset = "mirror" },
			{ name = "MasterRug", position = Vector3.new(0, 0, -32), preset = "rug" },
			-- ChildsBedroom props
			{ name = "ChildBed", position = Vector3.new(36, 0, -28), preset = "bed" },
			{ name = "ChildShelf", position = Vector3.new(42, 0, -24), preset = "shelf" },
			{ name = "ChildLamp", position = Vector3.new(28, 0, -24), preset = "lamp" },
			{ name = "ChildDesk", position = Vector3.new(28, 0, -36), preset = "desk" },
			-- Garage props
			{ name = "GarageCrate1", position = Vector3.new(-28, 0, 6), preset = "crate" },
			{ name = "GarageCrate2", position = Vector3.new(-22, 0, 6), preset = "crate" },
			{ name = "GarageShelf", position = Vector3.new(-20, 0, 14), preset = "shelf" },
			{ name = "GarageBarrel", position = Vector3.new(-40, 0, 10), preset = "barrel" },
			{ name = "GarageCover", position = Vector3.new(-36, 0, -6), preset = "cover_low" },
			-- Bathroom props
			{ name = "BathroomTub", position = Vector3.new(-36, 0, -36), preset = "bathtub" },
			{ name = "BathroomToilet", position = Vector3.new(-26, 0, -36), preset = "toilet" },
			{ name = "BathroomSink", position = Vector3.new(-26, 0, -28), preset = "sink" },
			{ name = "BathroomMirror", position = Vector3.new(-26, 8, -24), preset = "mirror" },
			-- BackPorch props
			{ name = "PorchBench", position = Vector3.new(-6, 0, -56), preset = "bench" },
			{ name = "PorchPlant", position = Vector3.new(10, 0, -56), preset = "potted_plant" },
			-- Laundry props
			{ name = "LaundryWasher", position = Vector3.new(-32, 0, -24), preset = "washer_dryer" },
			{ name = "LaundryShelf", position = Vector3.new(-28, 0, -16), preset = "shelf" },
			-- Attic props
			{ name = "AtticCrate1", position = Vector3.new(-8, 24, 4), preset = "crate" },
			{ name = "AtticCrate2", position = Vector3.new(-4, 24, 4), preset = "crate" },
			{ name = "AtticShelf", position = Vector3.new(12, 24, -8), preset = "shelf" },
			{ name = "AtticLamp", position = Vector3.new(0, 24, 0), preset = "lamp" },
			-- Outdoor props
			{ name = "FrontMailbox", position = Vector3.new(20, 0, 50), preset = "mailbox" },
			{ name = "FrontTree1", position = Vector3.new(-50, 0, 50), preset = "tree" },
			{ name = "FrontTree2", position = Vector3.new(50, 0, 40), preset = "tree" },
			{ name = "StreetLight1", position = Vector3.new(60, 0, 60), preset = "streetlight" },
			{ name = "OutdoorFence", position = Vector3.new(0, 0, 70), preset = "fence_section" },
		},
	}
end

return module
