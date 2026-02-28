--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 02: The Racket — Racketeering operation in an Old Town social club

local module = {}

function module.getData()
	return {
		caseId = "old_02",
		caseName = "The Racket",
		district = "Old Town",
		crimeType = "Racketeering",
		difficulty = 3,
		xpReward = 400,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Doyle Social Club",
		rooms = {
			{ name = "Bar", position = Vector3.new(0, 0, 0), size = Vector3.new(14, 10, 12) },
			{ name = "Back Room", position = Vector3.new(14, 0, 0), size = Vector3.new(10, 10, 12) },
			{ name = "Meeting Room", position = Vector3.new(14, 0, 12), size = Vector3.new(10, 10, 10) },
			{ name = "Storage", position = Vector3.new(0, 0, 12), size = Vector3.new(14, 10, 10) },
			{ name = "Rooftop", position = Vector3.new(0, 10, 0), size = Vector3.new(24, 6, 22) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Front Entrance" },
			{ position = Vector3.new(14, 0, 6), size = Vector3.new(4, 7, 1), name = "Bar to Back Room" },
			{ position = Vector3.new(19, 0, 12), size = Vector3.new(4, 7, 1), name = "Back Room to Meeting Room" },
			{ position = Vector3.new(14, 0, 16), size = Vector3.new(4, 7, 1), name = "Storage Entrance" },
			{ position = Vector3.new(12, 10, 5), size = Vector3.new(4, 7, 1), name = "Rooftop Access" },
			{ position = Vector3.new(24, 0, 6), size = Vector3.new(4, 7, 1), name = "Rear Exit" },
		},
	}
end

return module
