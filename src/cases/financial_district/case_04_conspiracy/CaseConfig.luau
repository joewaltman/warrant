--!strict
-- CaseConfig | WARRANT: Case Closed
-- Financial District Case 04 - The Conspiracy
-- Difficulty 4, 8 suspects, 20 evidence items (55 pts max)

local module = {}

function module.getData()
	return {
		caseId = "fin_04",
		caseName = "The Conspiracy",
		district = "Financial District",
		crimeType = "Conspiracy",
		difficulty = 4,
		xpReward = 700,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Financial District",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Hargrove & Associates Law Firm",
		rooms = {
			{
				name = "Reception",
				position = Vector3.new(0, 0, 18),
				size = Vector3.new(14, 10, 10),
			},
			{
				name = "Office",
				position = Vector3.new(-14, 0, 6),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Library",
				position = Vector3.new(14, 0, 6),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "ConferenceRoom",
				position = Vector3.new(0, 0, 6),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Stairwell",
				position = Vector3.new(0, 0, -8),
				size = Vector3.new(8, 14, 8),
			},
			{
				name = "WarRoom",
				position = Vector3.new(0, -10, -20),
				size = Vector3.new(16, 10, 14),
			},
			{
				name = "Armory",
				position = Vector3.new(16, -10, -20),
				size = Vector3.new(10, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 23), size = Vector3.new(4, 7, 1), name = "MainEntrance" },
			{ position = Vector3.new(0, 0, 13), size = Vector3.new(4, 7, 1), name = "ReceptionToConference" },
			{ position = Vector3.new(-7, 0, 6), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(7, 0, 6), size = Vector3.new(1, 7, 4), name = "LibraryDoor" },
			{ position = Vector3.new(0, 0, -1), size = Vector3.new(4, 7, 1), name = "StairwellDoor" },
			{ position = Vector3.new(0, -10, -13), size = Vector3.new(4, 7, 1), name = "WarRoomDoor" },
			{ position = Vector3.new(11, -10, -20), size = Vector3.new(1, 7, 4), name = "ArmoryDoor" },
		},
		props = {
			-- Reception (center 0,0,18 size 14x10x10)
			{ name = "ReceptionCouch", position = Vector3.new(-4, 0, 20), preset = "couch" },
			{ name = "ReceptionCounter", position = Vector3.new(3, 0, 17), preset = "counter" },
			{ name = "ReceptionLamp", position = Vector3.new(5, 0, 21), preset = "lamp" },

			-- Office (center -14,0,6 size 14x10x14)
			{ name = "OfficeDesk", position = Vector3.new(-16, 0, 3), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(-16, 0, 5), preset = "chair" },
			{ name = "OfficeCabinet", position = Vector3.new(-19, 0, 9), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(-16, 0, 3), preset = "computer" },
			{ name = "OfficeShelf", position = Vector3.new(-19, 0, 2), preset = "shelf" },

			-- Library (center 14,0,6 size 14x10x14)
			{ name = "LibraryShelf1", position = Vector3.new(10, 0, 2), preset = "shelf" },
			{ name = "LibraryShelf2", position = Vector3.new(10, 0, 10), preset = "shelf" },
			{ name = "LibraryShelf3", position = Vector3.new(18, 0, 2), preset = "shelf" },
			{ name = "LibraryShelf4", position = Vector3.new(18, 0, 10), preset = "shelf" },
			{ name = "LibraryChair1", position = Vector3.new(13, 0, 4), preset = "chair" },
			{ name = "LibraryChair2", position = Vector3.new(15, 0, 4), preset = "chair" },
			{ name = "LibraryDesk", position = Vector3.new(14, 0, 8), preset = "desk" },
			{ name = "LibraryLamp", position = Vector3.new(14, 0, 10), preset = "lamp" },

			-- ConferenceRoom (center 0,0,6 size 14x10x14)
			{ name = "ConferenceTable", position = Vector3.new(0, 0, 6), preset = "table_round" },
			{ name = "ConferenceChair1", position = Vector3.new(-3, 0, 4), preset = "chair" },
			{ name = "ConferenceChair2", position = Vector3.new(3, 0, 4), preset = "chair" },
			{ name = "ConferenceChair3", position = Vector3.new(-3, 0, 8), preset = "chair" },
			{ name = "ConferenceChair4", position = Vector3.new(3, 0, 8), preset = "chair" },
			{ name = "ConferenceChair5", position = Vector3.new(-5, 0, 6), preset = "chair" },
			{ name = "ConferenceChair6", position = Vector3.new(5, 0, 6), preset = "chair" },
			{ name = "ConferenceTv", position = Vector3.new(0, 0, 11), preset = "tv" },
			{ name = "ConferenceCoverLow", position = Vector3.new(5, 0, 1), preset = "cover_low" },

			-- Stairwell (center 0,0,-8 size 8x14x8) - no props

			-- WarRoom (center 0,-10,-20 size 16x10x14)
			{ name = "WarRoomDesk1", position = Vector3.new(-4, -10, -22), preset = "desk" },
			{ name = "WarRoomDesk2", position = Vector3.new(4, -10, -22), preset = "desk" },
			{ name = "WarRoomComputer1", position = Vector3.new(-4, -10, -22), preset = "computer" },
			{ name = "WarRoomComputer2", position = Vector3.new(4, -10, -22), preset = "computer" },
			{ name = "WarRoomSafe", position = Vector3.new(0, -10, -25), preset = "safe" },
			{ name = "WarRoomCoverTall1", position = Vector3.new(-6, -10, -18), preset = "cover_tall" },
			{ name = "WarRoomCoverTall2", position = Vector3.new(6, -10, -18), preset = "cover_tall" },
			{ name = "WarRoomShelf", position = Vector3.new(0, -10, -16), preset = "shelf" },

			-- Armory (center 16,-10,-20 size 10x10x10)
			{ name = "ArmoryShelf1", position = Vector3.new(14, -10, -22), preset = "shelf" },
			{ name = "ArmoryShelf2", position = Vector3.new(18, -10, -22), preset = "shelf" },
			{ name = "ArmoryCrate1", position = Vector3.new(14, -10, -18), preset = "crate" },
			{ name = "ArmoryCrate2", position = Vector3.new(16, -10, -18), preset = "crate" },
			{ name = "ArmoryCrate3", position = Vector3.new(18, -10, -18), preset = "crate" },
			{ name = "ArmorySafe", position = Vector3.new(19, -10, -23), preset = "safe" },
			{ name = "ArmoryCoverTall", position = Vector3.new(13, -10, -23), preset = "cover_tall" },
		},
	}
end

return module
