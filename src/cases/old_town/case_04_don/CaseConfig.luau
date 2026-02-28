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
		district = "Old Town",
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
		props = {
			-- Chapel (0,0,0) 16x12x14
			{ name = "ChapelCouch1", position = Vector3.new(2, 0, 3), preset = "couch" },
			{ name = "ChapelCouch2", position = Vector3.new(2, 0, 9), preset = "couch" },
			{ name = "ChapelLamp1", position = Vector3.new(1, 0, 1), preset = "lamp" },
			{ name = "ChapelLamp2", position = Vector3.new(14, 0, 1), preset = "lamp" },
			{ name = "ChapelCover", position = Vector3.new(10, 0, 6), preset = "cover_low" },
			-- Viewing Room (16,0,0) 12x12x14
			{ name = "ViewingChair1", position = Vector3.new(18, 0, 3), preset = "chair" },
			{ name = "ViewingChair2", position = Vector3.new(21, 0, 3), preset = "chair" },
			{ name = "ViewingChair3", position = Vector3.new(18, 0, 8), preset = "chair" },
			{ name = "ViewingChair4", position = Vector3.new(21, 0, 8), preset = "chair" },
			{ name = "ViewingShelf", position = Vector3.new(25, 0, 11), preset = "shelf" },
			{ name = "ViewingLamp", position = Vector3.new(17, 0, 12), preset = "lamp" },
			-- Embalming Room (16,0,14) 12x12x12
			{ name = "EmbalmingCounter", position = Vector3.new(18, 0, 16), preset = "counter" },
			{ name = "EmbalmingShelf", position = Vector3.new(25, 0, 16), preset = "shelf" },
			{ name = "EmbalmingCrate", position = Vector3.new(18, 0, 23), preset = "crate" },
			{ name = "EmbalmingBarrel", position = Vector3.new(22, 0, 23), preset = "barrel" },
			-- Office (0,0,14) 16x12x12
			{ name = "OfficeDesk", position = Vector3.new(4, 0, 18), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(4, 0, 21), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(12, 0, 16), preset = "filing_cabinet" },
			{ name = "OfficeSafe", position = Vector3.new(13, 0, 23), preset = "safe" },
			{ name = "OfficeComputer", position = Vector3.new(5, 0, 18), preset = "computer" },
			-- Hidden Basement (8,-12,7) 16x12x14
			{ name = "BasementCrate1", position = Vector3.new(10, -12, 9), preset = "crate" },
			{ name = "BasementCrate2", position = Vector3.new(13, -12, 9), preset = "crate" },
			{ name = "BasementCrate3", position = Vector3.new(16, -12, 9), preset = "crate" },
			{ name = "BasementCrate4", position = Vector3.new(19, -12, 9), preset = "crate" },
			{ name = "BasementSafe", position = Vector3.new(10, -12, 18), preset = "safe" },
			{ name = "BasementCoverTall1", position = Vector3.new(20, -12, 13), preset = "cover_tall" },
			{ name = "BasementCoverTall2", position = Vector3.new(20, -12, 17), preset = "cover_tall" },
			{ name = "BasementBarrel1", position = Vector3.new(14, -12, 18), preset = "barrel" },
			{ name = "BasementBarrel2", position = Vector3.new(17, -12, 18), preset = "barrel" },
		},
	}
end

return module
