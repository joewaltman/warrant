--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case configuration and building layout for The Fence

local module = {}

function module.getData()
	return {
		caseId = "dock_02",
		caseName = "The Fence",
		district = "Dockside",
		crimeType = "Fencing Stolen Goods",
		difficulty = 2,
		xpReward = 230,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Lucky Lou's Pawn & Trade",
		rooms = {
			{ name = "Counter Area", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Workshop", position = Vector3.new(14, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Basement", position = Vector3.new(0, -8, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Back Alley", position = Vector3.new(14, 0, 14), size = Vector3.new(12, 4, 12) },
		},
		doors = {
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Counter Area to Workshop" },
			{ position = Vector3.new(6, 0, 0), size = Vector3.new(4, 7, 1), name = "Counter Area to Basement Stairs" },
			{ position = Vector3.new(20, 0, 12), size = Vector3.new(4, 7, 1), name = "Workshop to Back Alley" },
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Front Entrance" },
		},
	}
end

return module
