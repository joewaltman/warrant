--!strict
-- CaseConfig | WARRANT: Case Closed
-- Elm Heights Case 02 - The Vandal's Mark
-- Difficulty 1 (Rookie), 2 suspects, 10 evidence items (32 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_02",
		caseName = "The Vandal's Mark",
		district = "Elm Heights",
		crimeType = "Vandalism",
		difficulty = 1,
		xpReward = 120,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Elm Heights",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Elm Heights Community Center",
		rooms = {
			{
				name = "Lobby",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(16, 12, 14),
			},
			{
				name = "Office",
				position = Vector3.new(15, 0, 0),
				size = Vector3.new(14, 12, 12),
			},
			{
				name = "Storage",
				position = Vector3.new(0, 0, -14),
				size = Vector3.new(14, 12, 10),
			},
			{
				name = "Restroom",
				position = Vector3.new(15, 0, -14),
				size = Vector3.new(10, 12, 10),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 12 },
			},
			{
				name = "GymRoom",
				position = Vector3.new(-16, 0, 0),
				size = Vector3.new(16, 12, 16),
				floorColor = Color3.fromRGB(160, 120, 70),
				floorMaterial = Enum.Material.Wood,
			},
			{
				name = "UtilityCloset",
				position = Vector3.new(-16, 0, -14),
				size = Vector3.new(6, 12, 6),
				lighting = { brightness = 0.3, color = Color3.fromRGB(255, 240, 200), range = 6 },
			},
			{
				name = "MainHallway",
				position = Vector3.new(0, 0, 10),
				size = Vector3.new(6, 12, 30),
				lighting = { brightness = 0.7, color = Color3.fromRGB(255, 245, 220), range = 14 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 25), size = Vector3.new(4, 7, 1), name = "FrontEntrance" },
			{ position = Vector3.new(8, 0, 0), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(0, 0, -9), size = Vector3.new(4, 7, 1), name = "StorageDoor" },
			{ position = Vector3.new(15, 0, -9), size = Vector3.new(4, 7, 1), name = "RestroomDoor" },
			{ position = Vector3.new(-8, 0, 0), size = Vector3.new(1, 7, 4), name = "GymDoor" },
			{ position = Vector3.new(-13, 0, -11), size = Vector3.new(4, 7, 1), name = "UtilityDoor" },
			{ position = Vector3.new(0, 0, 7), size = Vector3.new(4, 7, 1), name = "HallwayLobbyDoor" },
		},
		props = {
			-- Lobby props (room at 0,0,0 size 16x12x14)
			{ name = "LobbyCouch", position = Vector3.new(3, 0, 4), preset = "couch" },
			{ name = "LobbyTable", position = Vector3.new(6, 0, 6), preset = "table_round" },
			{ name = "LobbyLamp", position = Vector3.new(-5, 0, 5), preset = "lamp" },
			{ name = "LobbyPlant1", position = Vector3.new(-6, 0, -4), preset = "potted_plant" },
			{ name = "LobbyPlant2", position = Vector3.new(7, 0, -4), preset = "potted_plant" },
			{ name = "LobbyRug", position = Vector3.new(0, 0, 0), preset = "rug" },
			{ name = "LobbyTrash", position = Vector3.new(-7, 0, 2), preset = "trash_can" },
			-- Office props (room at 15,0,0 size 14x12x12)
			{ name = "OfficeDesk", position = Vector3.new(18, 0, 4), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(18, 0, 2), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(21, 0, 0), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(18, 3, 4), preset = "computer" },
			{ name = "OfficeBookshelf", position = Vector3.new(12, 0, -3), preset = "bookshelf" },
			{ name = "OfficeLamp", position = Vector3.new(14, 0, 4), preset = "lamp" },
			-- Storage props (room at 0,0,-14 size 14x12x10)
			{ name = "StorageCrate1", position = Vector3.new(2, 0, -12), preset = "crate" },
			{ name = "StorageCrate2", position = Vector3.new(5, 0, -12), preset = "crate" },
			{ name = "StorageShelf", position = Vector3.new(-4, 0, -10), preset = "shelf" },
			{ name = "StorageBarrel", position = Vector3.new(2, 0, -16), preset = "barrel" },
			{ name = "StorageCover", position = Vector3.new(-2, 0, -15), preset = "cover_low" },
			-- Restroom props (room at 15,0,-14 size 10x12x10)
			{ name = "RestroomSink", position = Vector3.new(13, 0, -12), preset = "sink" },
			{ name = "RestroomToilet", position = Vector3.new(18, 0, -16), preset = "toilet" },
			{ name = "RestroomMirror", position = Vector3.new(13, 4, -10), preset = "mirror" },
			{ name = "RestroomTrash", position = Vector3.new(17, 0, -12), preset = "trash_can" },
			-- GymRoom props (room at -16,0,0 size 16x12x16)
			{ name = "GymBench1", position = Vector3.new(-12, 0, 5), preset = "bench" },
			{ name = "GymBench2", position = Vector3.new(-20, 0, 5), preset = "bench" },
			{ name = "GymCoverLow", position = Vector3.new(-16, 0, -3), preset = "cover_low" },
			{ name = "GymRug", position = Vector3.new(-16, 0, 0), preset = "rug" },
			-- UtilityCloset props (room at -16,0,-14 size 6x12x6)
			{ name = "UtilityShelf", position = Vector3.new(-16, 0, -14), preset = "shelf" },
			{ name = "UtilityBarrel", position = Vector3.new(-14, 0, -12), preset = "barrel" },
			-- MainHallway props (room at 0,0,10 size 6x12x30)
			{ name = "HallwayLamp1", position = Vector3.new(1, 0, 12), preset = "lamp" },
			{ name = "HallwayLamp2", position = Vector3.new(-1, 0, 20), preset = "lamp" },
			-- Outdoor props
			{ name = "OutdoorBench", position = Vector3.new(15, 0, 35), preset = "bench" },
			{ name = "OutdoorTree", position = Vector3.new(-20, 0, 35), preset = "tree" },
			{ name = "OutdoorStreetlight", position = Vector3.new(25, 0, 30), preset = "streetlight" },
			{ name = "OutdoorFireHydrant", position = Vector3.new(-25, 0, 28), preset = "fire_hydrant" },
		},
	}
end

return module
