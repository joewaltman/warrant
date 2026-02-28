--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case configuration and building layout for The Dockside Smuggler

local module = {}

function module.getData()
	return {
		caseId = "dock_01",
		caseName = "The Dockside Smuggler",
		district = "Dockside",
		crimeType = "Smuggling",
		difficulty = 2,
		xpReward = 200,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Harborview Import Warehouse",
		rooms = {
			{ name = "Main Floor", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Office", position = Vector3.new(14, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Loading Bay", position = Vector3.new(0, 0, 14), size = Vector3.new(12, 8, 12) },
			{ name = "Cold Storage", position = Vector3.new(14, 0, 14), size = Vector3.new(12, 8, 12) },
		},
		doors = {
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Main Floor to Office" },
			{ position = Vector3.new(6, 0, 12), size = Vector3.new(4, 7, 1), name = "Main Floor to Loading Bay" },
			{ position = Vector3.new(14, 0, 20), size = Vector3.new(4, 7, 1), name = "Loading Bay to Cold Storage" },
			{ position = Vector3.new(20, 0, 12), size = Vector3.new(4, 7, 1), name = "Office to Cold Storage" },
		},
	}
end

return module
