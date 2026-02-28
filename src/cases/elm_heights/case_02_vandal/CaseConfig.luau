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
				size = Vector3.new(32, 24, 28),
			},
			{
				name = "Office",
				position = Vector3.new(30, 0, 0),
				size = Vector3.new(28, 24, 24),
			},
			{
				name = "Storage",
				position = Vector3.new(0, 0, -28),
				size = Vector3.new(28, 24, 20),
			},
			{
				name = "Restroom",
				position = Vector3.new(30, 0, -28),
				size = Vector3.new(20, 24, 20),
				floorColor = Color3.fromRGB(230, 230, 235),
				floorMaterial = Enum.Material.Marble,
				wallColor = Color3.fromRGB(240, 240, 245),
				lighting = { brightness = 1.2, color = Color3.fromRGB(255, 255, 255), range = 24 },
			},
			{
				name = "GymRoom",
				position = Vector3.new(-32, 0, 0),
				size = Vector3.new(32, 24, 32),
				floorColor = Color3.fromRGB(160, 120, 70),
				floorMaterial = Enum.Material.Wood,
			},
			{
				name = "UtilityCloset",
				position = Vector3.new(-32, 0, -28),
				size = Vector3.new(12, 24, 12),
				lighting = { brightness = 0.3, color = Color3.fromRGB(255, 240, 200), range = 12 },
			},
			{
				name = "MainHallway",
				position = Vector3.new(0, 0, 20),
				size = Vector3.new(12, 24, 60),
				lighting = { brightness = 0.7, color = Color3.fromRGB(255, 245, 220), range = 28 },
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 50), size = Vector3.new(8, 14, 2), name = "FrontEntrance" },
			{ position = Vector3.new(16, 0, 0), size = Vector3.new(2, 14, 8), name = "OfficeDoor" },
			{ position = Vector3.new(0, 0, -18), size = Vector3.new(8, 14, 2), name = "StorageDoor" },
			{ position = Vector3.new(30, 0, -18), size = Vector3.new(8, 14, 2), name = "RestroomDoor" },
			{ position = Vector3.new(-16, 0, 0), size = Vector3.new(2, 14, 8), name = "GymDoor" },
			{ position = Vector3.new(-26, 0, -22), size = Vector3.new(8, 14, 2), name = "UtilityDoor" },
			{ position = Vector3.new(0, 0, 14), size = Vector3.new(8, 14, 2), name = "HallwayLobbyDoor" },
		},
		props = {
			-- Lobby props
			{ name = "LobbyCouch", position = Vector3.new(6, 0, 8), preset = "couch" },
			{ name = "LobbyTable", position = Vector3.new(12, 0, 12), preset = "table_round" },
			{ name = "LobbyLamp", position = Vector3.new(-10, 0, 10), preset = "lamp" },
			{ name = "LobbyPlant1", position = Vector3.new(-12, 0, -8), preset = "potted_plant" },
			{ name = "LobbyPlant2", position = Vector3.new(14, 0, -8), preset = "potted_plant" },
			{ name = "LobbyRug", position = Vector3.new(0, 0, 0), preset = "rug" },
			{ name = "LobbyTrash", position = Vector3.new(-14, 0, 4), preset = "trash_can" },
			-- Office props
			{ name = "OfficeDesk", position = Vector3.new(36, 0, 8), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(36, 0, 4), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(42, 0, 0), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(36, 6, 8), preset = "computer" },
			{ name = "OfficeBookshelf", position = Vector3.new(24, 0, -6), preset = "bookshelf" },
			{ name = "OfficeLamp", position = Vector3.new(28, 0, 8), preset = "lamp" },
			-- Storage props
			{ name = "StorageCrate1", position = Vector3.new(4, 0, -24), preset = "crate" },
			{ name = "StorageCrate2", position = Vector3.new(10, 0, -24), preset = "crate" },
			{ name = "StorageShelf", position = Vector3.new(-8, 0, -20), preset = "shelf" },
			{ name = "StorageBarrel", position = Vector3.new(4, 0, -32), preset = "barrel" },
			{ name = "StorageCover", position = Vector3.new(-4, 0, -30), preset = "cover_low" },
			-- Restroom props
			{ name = "RestroomSink", position = Vector3.new(26, 0, -24), preset = "sink" },
			{ name = "RestroomToilet", position = Vector3.new(36, 0, -32), preset = "toilet" },
			{ name = "RestroomMirror", position = Vector3.new(26, 8, -20), preset = "mirror" },
			{ name = "RestroomTrash", position = Vector3.new(34, 0, -24), preset = "trash_can" },
			-- GymRoom props
			{ name = "GymBench1", position = Vector3.new(-24, 0, 10), preset = "bench" },
			{ name = "GymBench2", position = Vector3.new(-40, 0, 10), preset = "bench" },
			{ name = "GymCoverLow", position = Vector3.new(-32, 0, -6), preset = "cover_low" },
			{ name = "GymRug", position = Vector3.new(-32, 0, 0), preset = "rug" },
			-- UtilityCloset props
			{ name = "UtilityShelf", position = Vector3.new(-32, 0, -28), preset = "shelf" },
			{ name = "UtilityBarrel", position = Vector3.new(-28, 0, -24), preset = "barrel" },
			-- MainHallway props
			{ name = "HallwayLamp1", position = Vector3.new(2, 0, 24), preset = "lamp" },
			{ name = "HallwayLamp2", position = Vector3.new(-2, 0, 40), preset = "lamp" },
			-- Outdoor props
			{ name = "OutdoorBench", position = Vector3.new(30, 0, 70), preset = "bench" },
			{ name = "OutdoorTree", position = Vector3.new(-40, 0, 70), preset = "tree" },
			{ name = "OutdoorStreetlight", position = Vector3.new(50, 0, 60), preset = "streetlight" },
			{ name = "OutdoorFireHydrant", position = Vector3.new(-50, 0, 56), preset = "fire_hydrant" },
		},
	}
end

return module
