--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case configuration and building layout for The Chop Shop

local module = {}

function module.getData()
	return {
		caseId = "dock_04",
		caseName = "The Chop Shop",
		district = "Dockside",
		crimeType = "Auto Theft",
		difficulty = 2,
		xpReward = 300,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Bayside Auto Body & Repair",
		rooms = {
			{ name = "Main Bay", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Parts Room", position = Vector3.new(14, 0, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Office", position = Vector3.new(0, 0, 14), size = Vector3.new(12, 8, 12) },
			{ name = "Paint Booth", position = Vector3.new(14, 0, 14), size = Vector3.new(12, 8, 12) },
		},
		doors = {
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Main Bay to Parts Room" },
			{ position = Vector3.new(6, 0, 12), size = Vector3.new(4, 7, 1), name = "Main Bay to Office" },
			{ position = Vector3.new(20, 0, 12), size = Vector3.new(4, 7, 1), name = "Parts Room to Paint Booth" },
			{ position = Vector3.new(12, 0, 20), size = Vector3.new(4, 7, 1), name = "Office to Paint Booth" },
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Garage Entrance" },
		},
	}
end

return module
