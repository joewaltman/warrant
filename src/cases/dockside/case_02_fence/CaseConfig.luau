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
		district = "Dockside",
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
		props = {
			-- Counter Area (origin 0,0,0 size 12x8x12): counter, shelf x2, cover_low
			{ name = "CounterAreaCounter", position = Vector3.new(5, 0, 4), preset = "counter" },
			{ name = "CounterAreaShelf1", position = Vector3.new(2, 0, 10), preset = "shelf" },
			{ name = "CounterAreaShelf2", position = Vector3.new(9, 0, 10), preset = "shelf" },
			{ name = "CounterAreaCoverLow", position = Vector3.new(6, 0, 8), preset = "cover_low" },

			-- Workshop (origin 14,0,0 size 12x8x12): desk, shelf, crate x2, barrel
			{ name = "WorkshopDesk", position = Vector3.new(17, 0, 3), preset = "desk" },
			{ name = "WorkshopShelf", position = Vector3.new(22, 0, 2), preset = "shelf" },
			{ name = "WorkshopCrate1", position = Vector3.new(16, 0, 8), preset = "crate" },
			{ name = "WorkshopCrate2", position = Vector3.new(20, 0, 9), preset = "crate" },
			{ name = "WorkshopBarrel", position = Vector3.new(23, 0, 8), preset = "barrel" },

			-- Basement (origin 0,-8,0 size 12x8x12): crate x3, safe, barrel, cover_tall
			{ name = "BasementCrate1", position = Vector3.new(2, -8, 2), preset = "crate" },
			{ name = "BasementCrate2", position = Vector3.new(5, -8, 3), preset = "crate" },
			{ name = "BasementCrate3", position = Vector3.new(8, -8, 2), preset = "crate" },
			{ name = "BasementSafe", position = Vector3.new(9, -8, 9), preset = "safe" },
			{ name = "BasementBarrel", position = Vector3.new(3, -8, 8), preset = "barrel" },
			{ name = "BasementCoverTall", position = Vector3.new(6, -8, 10), preset = "cover_tall" },

			-- Back Alley (origin 14,0,14 size 12x4x12): crate, barrel
			{ name = "BackAlleyCrate", position = Vector3.new(17, 0, 18), preset = "crate" },
			{ name = "BackAlleyBarrel", position = Vector3.new(22, 0, 20), preset = "barrel" },
		},
	}
end

return module
