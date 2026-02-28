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
		district = "Old Town",
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
		props = {
			-- Main Floor (0,0,0) 20x12x13
			{ name = "MainCrate1", position = Vector3.new(2, 0, 2), preset = "crate" },
			{ name = "MainCrate2", position = Vector3.new(5, 0, 2), preset = "crate" },
			{ name = "MainCrate3", position = Vector3.new(14, 0, 2), preset = "crate" },
			{ name = "MainCrate4", position = Vector3.new(17, 0, 10), preset = "crate" },
			{ name = "MainBarrel1", position = Vector3.new(8, 0, 10), preset = "barrel" },
			{ name = "MainBarrel2", position = Vector3.new(11, 0, 10), preset = "barrel" },
			{ name = "MainCoverLow1", position = Vector3.new(3, 0, 7), preset = "cover_low" },
			{ name = "MainCoverLow2", position = Vector3.new(14, 0, 6), preset = "cover_low" },
			{ name = "MainCoverTall", position = Vector3.new(10, 0, 3), preset = "cover_tall" },
			-- Office (20,0,0) 13x12x13
			{ name = "OfficeDesk", position = Vector3.new(24, 0, 3), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(24, 0, 6), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(30, 0, 2), preset = "filing_cabinet" },
			{ name = "OfficeShelf", position = Vector3.new(30, 0, 10), preset = "shelf" },
			{ name = "OfficeComputer", position = Vector3.new(25, 0, 3), preset = "computer" },
			-- Boiler Room (0,-10,0) 13x10x13
			{ name = "BoilerBarrel1", position = Vector3.new(2, -10, 2), preset = "barrel" },
			{ name = "BoilerBarrel2", position = Vector3.new(5, -10, 2), preset = "barrel" },
			{ name = "BoilerBarrel3", position = Vector3.new(8, -10, 2), preset = "barrel" },
			{ name = "BoilerCrate", position = Vector3.new(2, -10, 9), preset = "crate" },
			{ name = "BoilerCover", position = Vector3.new(10, -10, 9), preset = "cover_tall" },
			-- Mezzanine (0,12,0) 20x6x13
			{ name = "MezzCrate1", position = Vector3.new(3, 12, 3), preset = "crate" },
			{ name = "MezzCrate2", position = Vector3.new(15, 12, 9), preset = "crate" },
			{ name = "MezzCover", position = Vector3.new(10, 12, 5), preset = "cover_low" },
			-- Holding Cell (20,-10,0) 13x10x13
			{ name = "CellCover", position = Vector3.new(24, -10, 3), preset = "cover_low" },
			{ name = "CellCrate", position = Vector3.new(28, -10, 2), preset = "crate" },
			{ name = "CellBarrel", position = Vector3.new(28, -10, 9), preset = "barrel" },
		},
	}
end

return module
