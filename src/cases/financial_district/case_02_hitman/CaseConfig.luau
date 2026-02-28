--!strict
-- CaseConfig | WARRANT: Case Closed
-- Financial District Case 02 - The Contract
-- Difficulty 4, 6 suspects, 17 evidence items (48 pts max)

local module = {}

function module.getData()
	return {
		caseId = "fin_02",
		caseName = "The Contract",
		district = "Financial District",
		crimeType = "Assassination",
		difficulty = 4,
		xpReward = 550,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Financial District",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Kensington Penthouse",
		rooms = {
			{
				name = "Foyer",
				position = Vector3.new(0, 0, 14),
				size = Vector3.new(10, 10, 8),
			},
			{
				name = "GreatRoom",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(16, 10, 16),
			},
			{
				name = "Study",
				position = Vector3.new(-14, 0, 0),
				size = Vector3.new(12, 10, 12),
			},
			{
				name = "Bedroom",
				position = Vector3.new(14, 0, 0),
				size = Vector3.new(12, 10, 12),
			},
			{
				name = "Terrace",
				position = Vector3.new(0, 0, -16),
				size = Vector3.new(20, 6, 10),
			},
			{
				name = "PanicRoom",
				position = Vector3.new(-14, 0, -14),
				size = Vector3.new(8, 8, 8),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 10), size = Vector3.new(4, 7, 1), name = "FoyerDoor" },
			{ position = Vector3.new(-8, 0, 0), size = Vector3.new(1, 7, 4), name = "StudyDoor" },
			{ position = Vector3.new(8, 0, 0), size = Vector3.new(1, 7, 4), name = "BedroomDoor" },
			{ position = Vector3.new(0, 0, -8), size = Vector3.new(4, 7, 1), name = "TerraceDoor" },
			{ position = Vector3.new(-14, 0, -10), size = Vector3.new(1, 7, 4), name = "PanicRoomDoor" },
			{ position = Vector3.new(0, 0, 18), size = Vector3.new(4, 7, 1), name = "MainEntrance" },
		},
		props = {
			-- Foyer (center 0,0,14 size 10x10x8)
			{ name = "FoyerLamp1", position = Vector3.new(-3, 0, 16), preset = "lamp" },
			{ name = "FoyerLamp2", position = Vector3.new(3, 0, 16), preset = "lamp" },
			{ name = "FoyerCoverLow", position = Vector3.new(0, 0, 12), preset = "cover_low" },

			-- GreatRoom (center 0,0,0 size 16x10x16)
			{ name = "GreatRoomCouch1", position = Vector3.new(-4, 0, 2), preset = "couch" },
			{ name = "GreatRoomCouch2", position = Vector3.new(4, 0, 2), preset = "couch" },
			{ name = "GreatRoomTable", position = Vector3.new(0, 0, 0), preset = "table_round" },
			{ name = "GreatRoomTv", position = Vector3.new(0, 0, -6), preset = "tv" },
			{ name = "GreatRoomLamp1", position = Vector3.new(-6, 0, -5), preset = "lamp" },
			{ name = "GreatRoomLamp2", position = Vector3.new(6, 0, -5), preset = "lamp" },
			{ name = "GreatRoomCoverLow", position = Vector3.new(6, 0, 5), preset = "cover_low" },

			-- Study (center -14,0,0 size 12x10x12)
			{ name = "StudyDesk", position = Vector3.new(-16, 0, -3), preset = "desk" },
			{ name = "StudyChair", position = Vector3.new(-16, 0, -1), preset = "chair" },
			{ name = "StudyShelf1", position = Vector3.new(-18, 0, 3), preset = "shelf" },
			{ name = "StudyShelf2", position = Vector3.new(-18, 0, -4), preset = "shelf" },
			{ name = "StudyComputer", position = Vector3.new(-16, 0, -3), preset = "computer" },
			{ name = "StudyCabinet", position = Vector3.new(-11, 0, -4), preset = "filing_cabinet" },

			-- Bedroom (center 14,0,0 size 12x10x12)
			{ name = "BedroomBed", position = Vector3.new(16, 0, -3), preset = "bed" },
			{ name = "BedroomDesk", position = Vector3.new(11, 0, 3), preset = "desk" },
			{ name = "BedroomLamp", position = Vector3.new(18, 0, -3), preset = "lamp" },

			-- Terrace (center 0,0,-16 size 20x6x10)
			{ name = "TerraceCoverLow1", position = Vector3.new(-6, 0, -18), preset = "cover_low" },
			{ name = "TerraceCoverLow2", position = Vector3.new(6, 0, -18), preset = "cover_low" },
			{ name = "TerraceCoverTall", position = Vector3.new(0, 0, -14), preset = "cover_tall" },

			-- PanicRoom (center -14,0,-14 size 8x8x8)
			{ name = "PanicRoomSafe", position = Vector3.new(-15, 0, -16), preset = "safe" },
			{ name = "PanicRoomCoverTall", position = Vector3.new(-12, 0, -13), preset = "cover_tall" },
			{ name = "PanicRoomComputer", position = Vector3.new(-15, 0, -12), preset = "computer" },
		},
	}
end

return module
