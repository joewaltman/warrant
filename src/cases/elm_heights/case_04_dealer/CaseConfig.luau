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
		origin = Vector3.new(0, 0, 0),
		buildingName = "QuikMart Convenience Store",
		rooms = {
			{
				name = "Shop",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(12, 10, 10),
			},
			{
				name = "BackRoom",
				position = Vector3.new(0, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Hallway",
				position = Vector3.new(6, 0, -6),
				size = Vector3.new(4, 10, 8),
			},
			{
				name = "UpstairsStudio",
				position = Vector3.new(0, 10, -12),
				size = Vector3.new(12, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 5), size = Vector3.new(4, 7, 1), name = "StoreFront" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "BackRoomDoor" },
			{ position = Vector3.new(6, 0, -10), size = Vector3.new(1, 7, 4), name = "HallwayDoor" },
			{ position = Vector3.new(-4, 10, -12), size = Vector3.new(4, 7, 1), name = "StudioDoor" },
		},
	}
end

return module
