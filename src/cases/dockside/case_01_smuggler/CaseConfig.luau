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
		district = "Dockside",
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
		props = {
			-- Main Floor (origin 0,0,0 size 12x8x12): crate x3, barrel, cover_low
			{ name = "MainFloorCrate1", position = Vector3.new(2, 0, 2), preset = "crate" },
			{ name = "MainFloorCrate2", position = Vector3.new(5, 0, 3), preset = "crate" },
			{ name = "MainFloorCrate3", position = Vector3.new(8, 0, 2), preset = "crate" },
			{ name = "MainFloorBarrel", position = Vector3.new(3, 0, 8), preset = "barrel" },
			{ name = "MainFloorCoverLow", position = Vector3.new(6, 0, 10), preset = "cover_low" },

			-- Office (origin 14,0,0 size 12x8x12): desk, chair, filing_cabinet, computer
			{ name = "OfficeDesk", position = Vector3.new(18, 0, 3), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(18, 0, 5), preset = "chair" },
			{ name = "OfficeFilingCabinet", position = Vector3.new(22, 0, 2), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(19, 0, 3), preset = "computer" },

			-- Loading Bay (origin 0,0,14 size 12x8x12): crate x3, barrel x2, cover_tall
			{ name = "LoadingBayCrate1", position = Vector3.new(2, 0, 16), preset = "crate" },
			{ name = "LoadingBayCrate2", position = Vector3.new(5, 0, 18), preset = "crate" },
			{ name = "LoadingBayCrate3", position = Vector3.new(8, 0, 17), preset = "crate" },
			{ name = "LoadingBayBarrel1", position = Vector3.new(3, 0, 22), preset = "barrel" },
			{ name = "LoadingBayBarrel2", position = Vector3.new(6, 0, 22), preset = "barrel" },
			{ name = "LoadingBayCoverTall", position = Vector3.new(10, 0, 20), preset = "cover_tall" },

			-- Cold Storage (origin 14,0,14 size 12x8x12): barrel x3, crate x2
			{ name = "ColdStorageBarrel1", position = Vector3.new(16, 0, 16), preset = "barrel" },
			{ name = "ColdStorageBarrel2", position = Vector3.new(19, 0, 17), preset = "barrel" },
			{ name = "ColdStorageBarrel3", position = Vector3.new(22, 0, 16), preset = "barrel" },
			{ name = "ColdStorageCrate1", position = Vector3.new(17, 0, 22), preset = "crate" },
			{ name = "ColdStorageCrate2", position = Vector3.new(21, 0, 22), preset = "crate" },
		},
	}
end

return module
