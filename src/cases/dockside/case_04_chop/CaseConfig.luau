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
		district = "Dockside",
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
		props = {
			-- Main Bay (origin 0,0,0 size 12x8x12): crate x2, barrel, cover_low x2
			{ name = "MainBayCrate1", position = Vector3.new(2, 0, 2), preset = "crate" },
			{ name = "MainBayCrate2", position = Vector3.new(8, 0, 3), preset = "crate" },
			{ name = "MainBayBarrel", position = Vector3.new(5, 0, 8), preset = "barrel" },
			{ name = "MainBayCoverLow1", position = Vector3.new(3, 0, 10), preset = "cover_low" },
			{ name = "MainBayCoverLow2", position = Vector3.new(9, 0, 9), preset = "cover_low" },

			-- Parts Room (origin 14,0,0 size 12x8x12): shelf x3, crate x2, barrel
			{ name = "PartsRoomShelf1", position = Vector3.new(16, 0, 2), preset = "shelf" },
			{ name = "PartsRoomShelf2", position = Vector3.new(20, 0, 2), preset = "shelf" },
			{ name = "PartsRoomShelf3", position = Vector3.new(24, 0, 2), preset = "shelf" },
			{ name = "PartsRoomCrate1", position = Vector3.new(17, 0, 8), preset = "crate" },
			{ name = "PartsRoomCrate2", position = Vector3.new(21, 0, 9), preset = "crate" },
			{ name = "PartsRoomBarrel", position = Vector3.new(23, 0, 7), preset = "barrel" },

			-- Office (origin 0,0,14 size 12x8x12): desk, chair, filing_cabinet, computer
			{ name = "OfficeDesk", position = Vector3.new(4, 0, 17), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(4, 0, 19), preset = "chair" },
			{ name = "OfficeFilingCabinet", position = Vector3.new(9, 0, 16), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(5, 0, 17), preset = "computer" },

			-- Paint Booth (origin 14,0,14 size 12x8x12): barrel x2, crate, cover_tall
			{ name = "PaintBoothBarrel1", position = Vector3.new(16, 0, 17), preset = "barrel" },
			{ name = "PaintBoothBarrel2", position = Vector3.new(20, 0, 18), preset = "barrel" },
			{ name = "PaintBoothCrate", position = Vector3.new(23, 0, 22), preset = "crate" },
			{ name = "PaintBoothCoverTall", position = Vector3.new(17, 0, 23), preset = "cover_tall" },
		},
	}
end

return module
