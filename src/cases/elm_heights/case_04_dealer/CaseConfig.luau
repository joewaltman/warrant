--!strict
-- CaseConfig | WARRANT: Case Closed
-- Elm Heights Case 04 - The Corner Dealer
-- Difficulty 1 (Rookie), 4 suspects, 12 evidence items (35 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_04",
		caseName = "The Corner Dealer",
		district = "Elm Heights",
		crimeType = "Drug Possession",
		difficulty = 1,
		xpReward = 150,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Elm Heights",
		origin = Vector3.new(0, 0, 0),
		buildingName = "QuikMart Convenience Store",
		rooms = {
			{
				name = "Shop",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(20, 12, 16),
			},
			{
				name = "BackRoom",
				position = Vector3.new(0, 0, -16),
				size = Vector3.new(16, 12, 14),
			},
			{
				name = "Hallway",
				position = Vector3.new(10, 0, -8),
				size = Vector3.new(6, 12, 12),
			},
			{
				name = "UpstairsStudio",
				position = Vector3.new(0, 12, -16),
				size = Vector3.new(20, 12, 16),
			},
			{
				name = "StoreOffice",
				position = Vector3.new(-12, 0, 0),
				size = Vector3.new(10, 12, 10),
			},
			{
				name = "AlleyEntrance",
				position = Vector3.new(-12, 0, -12),
				size = Vector3.new(8, 12, 6),
			},
			{
				name = "UpstairsBathroom",
				position = Vector3.new(-12, 12, -16),
				size = Vector3.new(8, 12, 8),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.0, color = Color3.fromRGB(255, 255, 255), range = 10 },
			},
			{
				name = "UpstairsKitchenette",
				position = Vector3.new(12, 12, -16),
				size = Vector3.new(10, 12, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 8), size = Vector3.new(4, 7, 1), name = "StoreFront" },
			{ position = Vector3.new(0, 0, -9), size = Vector3.new(4, 7, 1), name = "BackRoomDoor" },
			{ position = Vector3.new(8, 0, -8), size = Vector3.new(1, 7, 4), name = "HallwayDoor" },
			{ position = Vector3.new(-7, 0, 0), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(-12, 0, -9), size = Vector3.new(4, 7, 1), name = "AlleyDoor" },
			{ position = Vector3.new(0, 12, -8), size = Vector3.new(4, 7, 1), name = "StudioDoor" },
			{ position = Vector3.new(-8, 12, -16), size = Vector3.new(1, 7, 4), name = "UpstairsBathroomDoor" },
			{ position = Vector3.new(7, 12, -16), size = Vector3.new(1, 7, 4), name = "UpstairsKitchenetteDoor" },
		},
		props = {
			-- Shop props (room at 0,0,0 size 20x12x16)
			{ name = "ShopCounter", position = Vector3.new(5, 0, 3), preset = "counter" },
			{ name = "ShopShelf1", position = Vector3.new(-6, 0, 7), preset = "shelf" },
			{ name = "ShopShelf2", position = Vector3.new(6, 0, 7), preset = "shelf" },
			{ name = "ShopCover", position = Vector3.new(3, 0, 5), preset = "cover_low" },
			{ name = "ShopRegister", position = Vector3.new(5, 3, 3), preset = "register" },
			{ name = "ShopVending", position = Vector3.new(-8, 0, 0), preset = "vending_machine" },
			{ name = "ShopTrash", position = Vector3.new(9, 0, -5), preset = "trash_can" },
			{ name = "ShopPlant", position = Vector3.new(-9, 0, 6), preset = "potted_plant" },
			-- BackRoom props (room at 0,0,-16 size 16x12x14)
			{ name = "BackCrate1", position = Vector3.new(2, 0, -14), preset = "crate" },
			{ name = "BackCrate2", position = Vector3.new(5, 0, -14), preset = "crate" },
			{ name = "BackSafe", position = Vector3.new(7, 0, -10), preset = "safe" },
			{ name = "BackShelf", position = Vector3.new(-4, 0, -10), preset = "shelf" },
			{ name = "BackBarrel", position = Vector3.new(-6, 0, -18), preset = "barrel" },
			{ name = "BackCover", position = Vector3.new(2, 0, -20), preset = "cover_low" },
			-- Hallway props (room at 10,0,-8 size 6x12x12)
			{ name = "HallwayLamp", position = Vector3.new(11, 0, -10), preset = "lamp" },
			-- StoreOffice props (room at -12,0,0 size 10x12x10)
			{ name = "OfficeDesk", position = Vector3.new(-12, 0, 2), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(-12, 0, 0), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(-15, 0, 4), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(-12, 3, 2), preset = "computer" },
			-- AlleyEntrance props (room at -12,0,-12 size 8x12x6)
			{ name = "AlleyDumpster", position = Vector3.new(-14, 0, -12), preset = "dumpster" },
			{ name = "AlleyTrash", position = Vector3.new(-10, 0, -14), preset = "trash_can" },
			-- UpstairsStudio props (room at 0,12,-16 size 20x12x16)
			{ name = "StudioBed", position = Vector3.new(2, 12, -14), preset = "bed" },
			{ name = "StudioDesk", position = Vector3.new(8, 12, -12), preset = "desk" },
			{ name = "StudioTV", position = Vector3.new(-4, 12, -10), preset = "tv" },
			{ name = "StudioCouch", position = Vector3.new(4, 12, -10), preset = "couch" },
			{ name = "StudioLamp", position = Vector3.new(-6, 12, -20), preset = "lamp" },
			{ name = "StudioRug", position = Vector3.new(0, 12, -16), preset = "rug" },
			{ name = "StudioBookshelf", position = Vector3.new(8, 12, -22), preset = "bookshelf" },
			{ name = "StudioPlant", position = Vector3.new(-8, 12, -14), preset = "potted_plant" },
			-- UpstairsBathroom props (room at -12,12,-16 size 8x12x8)
			{ name = "UpBathroomToilet", position = Vector3.new(-14, 12, -18), preset = "toilet" },
			{ name = "UpBathroomSink", position = Vector3.new(-10, 12, -14), preset = "sink" },
			{ name = "UpBathroomMirror", position = Vector3.new(-10, 16, -12), preset = "mirror" },
			-- UpstairsKitchenette props (room at 12,12,-16 size 10x12x10)
			{ name = "UpKitchenCounter", position = Vector3.new(14, 12, -14), preset = "counter" },
			{ name = "UpKitchenFridge", position = Vector3.new(16, 12, -20), preset = "fridge" },
			{ name = "UpKitchenStove", position = Vector3.new(12, 12, -20), preset = "stove" },
			{ name = "UpKitchenTrash", position = Vector3.new(10, 12, -14), preset = "trash_can" },
			-- Outdoor props
			{ name = "OutdoorStreetlight1", position = Vector3.new(20, 0, 25), preset = "streetlight" },
			{ name = "OutdoorStreetlight2", position = Vector3.new(-20, 0, 25), preset = "streetlight" },
			{ name = "OutdoorBench", position = Vector3.new(15, 0, 20), preset = "bench" },
			{ name = "OutdoorFireHydrant", position = Vector3.new(-18, 0, 15), preset = "fire_hydrant" },
			{ name = "OutdoorDumpster", position = Vector3.new(-20, 0, -20), preset = "dumpster" },
			{ name = "OutdoorTree", position = Vector3.new(25, 0, 15), preset = "tree" },
		},
	}
end

return module
