--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 03: The Snatch — Kidnapping investigation in an Old Town factory

local module = {}

function module.getData()
	return {
		caseId = "old_03",
		caseName = "The Snatch",
		district = "Old Town",
		crimeType = "Kidnapping",
		difficulty = 3,
		xpReward = 450,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Abandoned Rizzo Textile Factory",
		rooms = {
			{ name = "Main Floor", position = Vector3.new(0, 0, 0), size = Vector3.new(20, 12, 13) },
			{ name = "Office", position = Vector3.new(20, 0, 0), size = Vector3.new(13, 12, 13) },
			{ name = "Boiler Room", position = Vector3.new(0, -10, 0), size = Vector3.new(13, 10, 13) },
			{ name = "Mezzanine", position = Vector3.new(0, 12, 0), size = Vector3.new(20, 6, 13) },
			{ name = "Holding Cell", position = Vector3.new(20, -10, 0), size = Vector3.new(13, 10, 13) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Loading Bay Door" },
			{ position = Vector3.new(20, 0, 6), size = Vector3.new(4, 7, 1), name = "Main Floor to Office" },
			{ position = Vector3.new(6, -10, 6), size = Vector3.new(4, 7, 1), name = "Boiler Room Stairs" },
			{ position = Vector3.new(10, 12, 6), size = Vector3.new(4, 7, 1), name = "Mezzanine Catwalk" },
			{ position = Vector3.new(26, -10, 6), size = Vector3.new(4, 7, 1), name = "Holding Cell Door" },
			{ position = Vector3.new(33, 0, 6), size = Vector3.new(4, 7, 1), name = "Office Rear Exit" },
		},
	}
end

return module
