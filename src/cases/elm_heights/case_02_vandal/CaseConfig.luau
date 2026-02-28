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
	}
end

return module
