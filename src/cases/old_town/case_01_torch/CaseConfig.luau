--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 01: The Torch — Arson investigation in an Old Town brownstone

local module = {}

function module.getData()
	return {
		caseId = "old_01",
		caseName = "The Torch",
		district = "Old Town",
		crimeType = "Arson",
		difficulty = 3,
		xpReward = 350,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Moretti Brownstone",
		rooms = {
			{ name = "Parlor", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Kitchen", position = Vector3.new(12, 0, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Bedroom", position = Vector3.new(0, 10, 0), size = Vector3.new(12, 10, 12) },
			{ name = "Attic", position = Vector3.new(0, 20, 0), size = Vector3.new(12, 8, 12) },
			{ name = "Basement", position = Vector3.new(0, -10, 0), size = Vector3.new(12, 10, 12) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Front Door" },
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Parlor to Kitchen" },
			{ position = Vector3.new(6, 10, 6), size = Vector3.new(4, 7, 1), name = "Stairway to Bedroom" },
			{ position = Vector3.new(6, 20, 6), size = Vector3.new(4, 7, 1), name = "Attic Hatch" },
			{ position = Vector3.new(6, -10, 6), size = Vector3.new(4, 7, 1), name = "Basement Stairs" },
		},
	}
end

return module
