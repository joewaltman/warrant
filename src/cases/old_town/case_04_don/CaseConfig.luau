--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 04: The Don's Ledger — Organized crime bust in an Old Town funeral home

local module = {}

function module.getData()
	return {
		caseId = "old_04",
		caseName = "The Don's Ledger",
		district = "Old Town",
		crimeType = "Organized Crime",
		difficulty = 3,
		xpReward = 500,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Bianchi & Sons Funeral Home",
		rooms = {
			{ name = "Chapel", position = Vector3.new(0, 0, 0), size = Vector3.new(16, 12, 14) },
			{ name = "Viewing Room", position = Vector3.new(16, 0, 0), size = Vector3.new(12, 12, 14) },
			{ name = "Embalming Room", position = Vector3.new(16, 0, 14), size = Vector3.new(12, 12, 12) },
			{ name = "Office", position = Vector3.new(0, 0, 14), size = Vector3.new(16, 12, 12) },
			{ name = "Hidden Basement", position = Vector3.new(8, -12, 7), size = Vector3.new(16, 12, 14) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 7), size = Vector3.new(4, 7, 1), name = "Chapel Front Doors" },
			{ position = Vector3.new(16, 0, 7), size = Vector3.new(4, 7, 1), name = "Chapel to Viewing Room" },
			{ position = Vector3.new(22, 0, 14), size = Vector3.new(4, 7, 1), name = "Viewing Room to Embalming" },
			{ position = Vector3.new(16, 0, 20), size = Vector3.new(4, 7, 1), name = "Embalming to Office" },
			{ position = Vector3.new(8, 0, 14), size = Vector3.new(4, 7, 1), name = "Office Entry" },
			{ position = Vector3.new(16, -12, 14), size = Vector3.new(4, 7, 1), name = "Hidden Basement Trapdoor" },
			{ position = Vector3.new(28, 0, 7), size = Vector3.new(4, 7, 1), name = "Rear Service Exit" },
		},
	}
end

return module
