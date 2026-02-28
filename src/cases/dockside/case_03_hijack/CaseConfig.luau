--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case configuration and building layout for Cargo Hijack

local module = {}

function module.getData()
	return {
		caseId = "dock_03",
		caseName = "Cargo Hijack",
		district = "Dockside",
		crimeType = "Theft",
		difficulty = 2,
		xpReward = 270,
	}
end

function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Pacific Freight Container Yard",
		rooms = {
			{ name = "Trailer", position = Vector3.new(0, 0, 0), size = Vector3.new(12, 6, 12) },
			{ name = "Container A", position = Vector3.new(14, 0, 0), size = Vector3.new(12, 6, 12) },
			{ name = "Container B", position = Vector3.new(0, 0, 14), size = Vector3.new(12, 6, 12) },
			{ name = "Container C", position = Vector3.new(14, 0, 14), size = Vector3.new(12, 6, 12) },
			{ name = "Guard Shack", position = Vector3.new(28, 0, 6), size = Vector3.new(8, 6, 8) },
		},
		doors = {
			{ position = Vector3.new(12, 0, 6), size = Vector3.new(4, 7, 1), name = "Trailer to Container A" },
			{ position = Vector3.new(6, 0, 12), size = Vector3.new(4, 7, 1), name = "Trailer to Container B" },
			{ position = Vector3.new(14, 0, 20), size = Vector3.new(4, 7, 1), name = "Container B to Container C" },
			{ position = Vector3.new(24, 0, 6), size = Vector3.new(4, 7, 1), name = "Container A to Guard Shack" },
			{ position = Vector3.new(20, 0, 12), size = Vector3.new(4, 7, 1), name = "Container A to Container C" },
		},
	}
end

return module
