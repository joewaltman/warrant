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
				size = Vector3.new(40, 24, 32),
			},
			{
				name = "BackRoom",
				position = Vector3.new(0, 0, -32),
				size = Vector3.new(32, 24, 28),
			},
			{
				name = "Hallway",
				position = Vector3.new(20, 0, -16),
				size = Vector3.new(12, 24, 24),
			},
			{
				name = "UpstairsStudio",
				position = Vector3.new(0, 24, -32),
				size = Vector3.new(40, 24, 32),
			},
			{
				name = "StoreOffice",
				position = Vector3.new(-24, 0, 0),
				size = Vector3.new(20, 24, 20),
			},
			{
				name = "AlleyEntrance",
				position = Vector3.new(-24, 0, -24),
				size = Vector3.new(16, 24, 12),
			},
			{
				name = "UpstairsBathroom",
				position = Vector3.new(-24, 24, -32),
				size = Vector3.new(16, 24, 16),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.0, color = Color3.fromRGB(255, 255, 255), range = 20 },
			},
			{
				name = "UpstairsKitchenette",
				position = Vector3.new(24, 24, -32),
				size = Vector3.new(20, 24, 20),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 16), size = Vector3.new(8, 14, 2), name = "StoreFront" },
			{ position = Vector3.new(0, 0, -18), size = Vector3.new(8, 14, 2), name = "BackRoomDoor" },
			{ position = Vector3.new(16, 0, -16), size = Vector3.new(2, 14, 8), name = "HallwayDoor" },
			{ position = Vector3.new(-14, 0, 0), size = Vector3.new(2, 14, 8), name = "OfficeDoor" },
			{ position = Vector3.new(-24, 0, -18), size = Vector3.new(8, 14, 2), name = "AlleyDoor" },
			{ position = Vector3.new(0, 24, -16), size = Vector3.new(8, 14, 2), name = "StudioDoor" },
			{ position = Vector3.new(-16, 24, -32), size = Vector3.new(2, 14, 8), name = "UpstairsBathroomDoor" },
			{ position = Vector3.new(14, 24, -32), size = Vector3.new(2, 14, 8), name = "UpstairsKitchenetteDoor" },
		},
		props = {
			-- Shop props
			{ name = "ShopCounter", position = Vector3.new(10, 0, 6), preset = "counter" },
			{ name = "ShopShelf1", position = Vector3.new(-12, 0, 14), preset = "shelf" },
			{ name = "ShopShelf2", position = Vector3.new(12, 0, 14), preset = "shelf" },
			{ name = "ShopCover", position = Vector3.new(6, 0, 10), preset = "cover_low" },
			{ name = "ShopRegister", position = Vector3.new(10, 6, 6), preset = "register" },
			{ name = "ShopVending", position = Vector3.new(-16, 0, 0), preset = "vending_machine" },
			{ name = "ShopTrash", position = Vector3.new(18, 0, -10), preset = "trash_can" },
			{ name = "ShopPlant", position = Vector3.new(-18, 0, 12), preset = "potted_plant" },
			-- BackRoom props
			{ name = "BackCrate1", position = Vector3.new(4, 0, -28), preset = "crate" },
			{ name = "BackCrate2", position = Vector3.new(10, 0, -28), preset = "crate" },
			{ name = "BackSafe", position = Vector3.new(14, 0, -20), preset = "safe" },
			{ name = "BackShelf", position = Vector3.new(-8, 0, -20), preset = "shelf" },
			{ name = "BackBarrel", position = Vector3.new(-12, 0, -36), preset = "barrel" },
			{ name = "BackCover", position = Vector3.new(4, 0, -40), preset = "cover_low" },
			-- Hallway props
			{ name = "HallwayLamp", position = Vector3.new(22, 0, -20), preset = "lamp" },
			-- StoreOffice props
			{ name = "OfficeDesk", position = Vector3.new(-24, 0, 4), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(-24, 0, 0), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(-30, 0, 8), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(-24, 6, 4), preset = "computer" },
			-- AlleyEntrance props
			{ name = "AlleyDumpster", position = Vector3.new(-28, 0, -24), preset = "dumpster" },
			{ name = "AlleyTrash", position = Vector3.new(-20, 0, -28), preset = "trash_can" },
			-- UpstairsStudio props
			{ name = "StudioBed", position = Vector3.new(4, 24, -28), preset = "bed" },
			{ name = "StudioDesk", position = Vector3.new(16, 24, -24), preset = "desk" },
			{ name = "StudioTV", position = Vector3.new(-8, 24, -20), preset = "tv" },
			{ name = "StudioCouch", position = Vector3.new(8, 24, -20), preset = "couch" },
			{ name = "StudioLamp", position = Vector3.new(-12, 24, -40), preset = "lamp" },
			{ name = "StudioRug", position = Vector3.new(0, 24, -32), preset = "rug" },
			{ name = "StudioBookshelf", position = Vector3.new(16, 24, -44), preset = "bookshelf" },
			{ name = "StudioPlant", position = Vector3.new(-16, 24, -28), preset = "potted_plant" },
			-- UpstairsBathroom props
			{ name = "UpBathroomToilet", position = Vector3.new(-28, 24, -36), preset = "toilet" },
			{ name = "UpBathroomSink", position = Vector3.new(-20, 24, -28), preset = "sink" },
			{ name = "UpBathroomMirror", position = Vector3.new(-20, 32, -24), preset = "mirror" },
			-- UpstairsKitchenette props
			{ name = "UpKitchenCounter", position = Vector3.new(28, 24, -28), preset = "counter" },
			{ name = "UpKitchenFridge", position = Vector3.new(32, 24, -40), preset = "fridge" },
			{ name = "UpKitchenStove", position = Vector3.new(24, 24, -40), preset = "stove" },
			{ name = "UpKitchenTrash", position = Vector3.new(20, 24, -28), preset = "trash_can" },
			-- Outdoor props
			{ name = "OutdoorStreetlight1", position = Vector3.new(40, 0, 50), preset = "streetlight" },
			{ name = "OutdoorStreetlight2", position = Vector3.new(-40, 0, 50), preset = "streetlight" },
			{ name = "OutdoorBench", position = Vector3.new(30, 0, 40), preset = "bench" },
			{ name = "OutdoorFireHydrant", position = Vector3.new(-36, 0, 30), preset = "fire_hydrant" },
			{ name = "OutdoorDumpster", position = Vector3.new(-40, 0, -40), preset = "dumpster" },
			{ name = "OutdoorTree", position = Vector3.new(50, 0, 30), preset = "tree" },
		},
	}
end

return module
