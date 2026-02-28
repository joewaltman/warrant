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
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Office",
				position = Vector3.new(12, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Storage",
				position = Vector3.new(0, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Restroom",
				position = Vector3.new(12, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 5), size = Vector3.new(4, 7, 1), name = "FrontEntrance" },
			{ position = Vector3.new(7, 0, 0), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "StorageDoor" },
			{ position = Vector3.new(12, 0, -6), size = Vector3.new(4, 7, 1), name = "RestroomDoor" },
		},
		props = {
			-- Lobby props (room at 0,0,0 size 10x10x10)
			{ name = "LobbyCouch", position = Vector3.new(2, 0, 3), preset = "couch" },
			{ name = "LobbyTable", position = Vector3.new(5, 0, 5), preset = "table_round" },
			{ name = "LobbyLamp", position = Vector3.new(8, 0, 7), preset = "lamp" },
			-- Office props (room at 12,0,0 size 10x10x10)
			{ name = "OfficeDesk", position = Vector3.new(15, 0, 4), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(15, 0, 2), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(19, 0, 7), preset = "filing_cabinet" },
			-- Storage props (room at 0,0,-12 size 10x10x10)
			{ name = "StorageCrate1", position = Vector3.new(2, 0, -10), preset = "crate" },
			{ name = "StorageCrate2", position = Vector3.new(4, 0, -10), preset = "crate" },
			{ name = "StorageShelf", position = Vector3.new(7, 0, -6), preset = "shelf" },
			{ name = "StorageBarrel", position = Vector3.new(2, 0, -6), preset = "barrel" },
			-- Restroom props (room at 12,0,-12 size 10x10x10)
			{ name = "RestroomCover", position = Vector3.new(15, 0, -9), preset = "cover_low" },
		},
	}
end

return module
