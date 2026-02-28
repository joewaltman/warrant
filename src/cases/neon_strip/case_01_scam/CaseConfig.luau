--!strict
-- CaseConfig | WARRANT: Case Closed
-- Neon Strip Case 01: Neon Nights Scam
-- Difficulty 2, 4 suspects, 13 evidence items (36 pts max)

local module = {}

function module.getData()
	return {
		caseId = "neon_01",
		caseName = "Neon Nights Scam",
		district = "Neon Strip",
		crimeType = "Fraud",
		difficulty = 2,
		xpReward = 250,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Neon Nights Nightclub",
		rooms = {
			{
				name = "MainFloor",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(22, 11, 22),
			},
			{
				name = "VIPRoom",
				position = Vector3.new(-14, 0, -8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "DJBooth",
				position = Vector3.new(14, 0, -8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "Office",
				position = Vector3.new(-14, 0, 8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "Restroom",
				position = Vector3.new(14, 0, 8),
				size = Vector3.new(11, 11, 11),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 11), size = Vector3.new(4, 7, 1), name = "FrontEntrance" },
			{ position = Vector3.new(-8, 0, -3), size = Vector3.new(1, 7, 4), name = "VIPDoor" },
			{ position = Vector3.new(8, 0, -3), size = Vector3.new(1, 7, 4), name = "DJBoothDoor" },
			{ position = Vector3.new(-8, 0, 3), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(8, 0, 3), size = Vector3.new(1, 7, 4), name = "RestroomDoor" },
		},
	}
end

return module
