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
		district = "Dockside",
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
		props = {
			-- Trailer (origin 0,0,0 size 12x6x12): crate x3, cover_low
			{ name = "TrailerCrate1", position = Vector3.new(2, 0, 2), preset = "crate" },
			{ name = "TrailerCrate2", position = Vector3.new(5, 0, 4), preset = "crate" },
			{ name = "TrailerCrate3", position = Vector3.new(8, 0, 2), preset = "crate" },
			{ name = "TrailerCoverLow", position = Vector3.new(4, 0, 9), preset = "cover_low" },

			-- Container A (origin 14,0,0 size 12x6x12): crate x2, barrel, cover_tall
			{ name = "ContainerACrate1", position = Vector3.new(16, 0, 3), preset = "crate" },
			{ name = "ContainerACrate2", position = Vector3.new(20, 0, 4), preset = "crate" },
			{ name = "ContainerABarrel", position = Vector3.new(23, 0, 8), preset = "barrel" },
			{ name = "ContainerACoverTall", position = Vector3.new(17, 0, 9), preset = "cover_tall" },

			-- Container B (origin 0,0,14 size 12x6x12): crate x3, barrel
			{ name = "ContainerBCrate1", position = Vector3.new(2, 0, 16), preset = "crate" },
			{ name = "ContainerBCrate2", position = Vector3.new(5, 0, 18), preset = "crate" },
			{ name = "ContainerBCrate3", position = Vector3.new(9, 0, 16), preset = "crate" },
			{ name = "ContainerBBarrel", position = Vector3.new(3, 0, 23), preset = "barrel" },

			-- Container C (origin 14,0,14 size 12x6x12): crate x2, barrel x2, cover_low
			{ name = "ContainerCCrate1", position = Vector3.new(16, 0, 17), preset = "crate" },
			{ name = "ContainerCCrate2", position = Vector3.new(20, 0, 16), preset = "crate" },
			{ name = "ContainerCBarrel1", position = Vector3.new(23, 0, 20), preset = "barrel" },
			{ name = "ContainerCBarrel2", position = Vector3.new(17, 0, 22), preset = "barrel" },
			{ name = "ContainerCCoverLow", position = Vector3.new(21, 0, 23), preset = "cover_low" },

			-- Guard Shack (origin 28,0,6 size 8x6x8): desk, chair, shelf
			{ name = "GuardShackDesk", position = Vector3.new(30, 0, 8), preset = "desk" },
			{ name = "GuardShackChair", position = Vector3.new(30, 0, 10), preset = "chair" },
			{ name = "GuardShackShelf", position = Vector3.new(34, 0, 9), preset = "shelf" },
		},
	}
end

return module
