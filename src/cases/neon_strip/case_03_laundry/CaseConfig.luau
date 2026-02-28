--!strict
-- CaseConfig | WARRANT: Case Closed
-- Neon Strip Case 03: Dirty Money
-- Difficulty 3, 5 suspects, 15 evidence items (42 pts max)

local module = {}

function module.getData()
	return {
		caseId = "neon_03",
		caseName = "Dirty Money",
		district = "Neon Strip",
		crimeType = "Money Laundering",
		difficulty = 3,
		xpReward = 350,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Neon Strip",
		origin = Vector3.new(0, 0, 0),
		buildingName = "The Golden Ace Casino",
		props = {
			-- CasinoFloor (center 0,0,0 size 24x12x24)
			{ name = "CasinoFloor_TableRound1", position = Vector3.new(-5, 0, -5), preset = "table_round" },
			{ name = "CasinoFloor_TableRound2", position = Vector3.new(5, 0, -5), preset = "table_round" },
			{ name = "CasinoFloor_TableRound3", position = Vector3.new(-5, 0, 5), preset = "table_round" },
			{ name = "CasinoFloor_TableRound4", position = Vector3.new(5, 0, 5), preset = "table_round" },
			{ name = "CasinoFloor_Chair1", position = Vector3.new(-6, 0, -5), preset = "chair" },
			{ name = "CasinoFloor_Chair2", position = Vector3.new(-4, 0, -5), preset = "chair" },
			{ name = "CasinoFloor_Chair3", position = Vector3.new(6, 0, -5), preset = "chair" },
			{ name = "CasinoFloor_Chair4", position = Vector3.new(4, 0, -5), preset = "chair" },
			{ name = "CasinoFloor_Chair5", position = Vector3.new(-6, 0, 5), preset = "chair" },
			{ name = "CasinoFloor_Chair6", position = Vector3.new(6, 0, 5), preset = "chair" },
			{ name = "CasinoFloor_Couch1", position = Vector3.new(-8, 0, 0), preset = "couch" },
			{ name = "CasinoFloor_Couch2", position = Vector3.new(8, 0, 0), preset = "couch" },
			{ name = "CasinoFloor_Lamp1", position = Vector3.new(-10, 0, -10), preset = "lamp" },
			{ name = "CasinoFloor_Lamp2", position = Vector3.new(10, 0, -10), preset = "lamp" },
			{ name = "CasinoFloor_Lamp3", position = Vector3.new(-10, 0, 10), preset = "lamp" },
			{ name = "CasinoFloor_Lamp4", position = Vector3.new(10, 0, 10), preset = "lamp" },
			{ name = "CasinoFloor_CoverLow1", position = Vector3.new(0, 0, -8), preset = "cover_low" },
			{ name = "CasinoFloor_CoverLow2", position = Vector3.new(-3, 0, 8), preset = "cover_low" },
			{ name = "CasinoFloor_CoverLow3", position = Vector3.new(3, 0, 8), preset = "cover_low" },
			-- CashierCage (center -16,0,-8 size 12x12x12)
			{ name = "CashierCage_Counter1", position = Vector3.new(-16, 0, -6), preset = "counter" },
			{ name = "CashierCage_Safe1", position = Vector3.new(-19, 0, -11), preset = "safe" },
			{ name = "CashierCage_Desk1", position = Vector3.new(-14, 0, -10), preset = "desk" },
			{ name = "CashierCage_Computer1", position = Vector3.new(-14, 0, -8), preset = "computer" },
			-- ManagerOffice (center 16,0,-8 size 12x12x12)
			{ name = "ManagerOffice_Desk1", position = Vector3.new(16, 0, -10), preset = "desk" },
			{ name = "ManagerOffice_Chair1", position = Vector3.new(16, 0, -8), preset = "chair" },
			{ name = "ManagerOffice_Couch1", position = Vector3.new(13, 0, -6), preset = "couch" },
			{ name = "ManagerOffice_FilingCabinet1", position = Vector3.new(19, 0, -11), preset = "filing_cabinet" },
			{ name = "ManagerOffice_Safe1", position = Vector3.new(19, 0, -8), preset = "safe" },
			-- ServerRoom (center 16,0,8 size 12x12x12)
			{ name = "ServerRoom_Shelf1", position = Vector3.new(14, 0, 5), preset = "shelf" },
			{ name = "ServerRoom_Shelf2", position = Vector3.new(16, 0, 5), preset = "shelf" },
			{ name = "ServerRoom_Shelf3", position = Vector3.new(18, 0, 5), preset = "shelf" },
			{ name = "ServerRoom_Computer1", position = Vector3.new(14, 0, 10), preset = "computer" },
			{ name = "ServerRoom_Computer2", position = Vector3.new(18, 0, 10), preset = "computer" },
			-- SecurityRoom (center -16,0,8 size 12x12x12)
			{ name = "SecurityRoom_Desk1", position = Vector3.new(-18, 0, 6), preset = "desk" },
			{ name = "SecurityRoom_Desk2", position = Vector3.new(-14, 0, 6), preset = "desk" },
			{ name = "SecurityRoom_Computer1", position = Vector3.new(-18, 0, 8), preset = "computer" },
			{ name = "SecurityRoom_Computer2", position = Vector3.new(-14, 0, 8), preset = "computer" },
			{ name = "SecurityRoom_Shelf1", position = Vector3.new(-19, 0, 11), preset = "shelf" },
			{ name = "SecurityRoom_CoverTall1", position = Vector3.new(-13, 0, 11), preset = "cover_tall" },
		},
		rooms = {
			{
				name = "CasinoFloor",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(24, 12, 24),
			},
			{
				name = "CashierCage",
				position = Vector3.new(-16, 0, -8),
				size = Vector3.new(12, 12, 12),
			},
			{
				name = "ManagerOffice",
				position = Vector3.new(16, 0, -8),
				size = Vector3.new(12, 12, 12),
			},
			{
				name = "ServerRoom",
				position = Vector3.new(16, 0, 8),
				size = Vector3.new(12, 12, 12),
			},
			{
				name = "SecurityRoom",
				position = Vector3.new(-16, 0, 8),
				size = Vector3.new(12, 12, 12),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 12), size = Vector3.new(4, 7, 1), name = "MainEntrance" },
			{ position = Vector3.new(-10, 0, -3), size = Vector3.new(1, 7, 4), name = "CageDoor" },
			{ position = Vector3.new(10, 0, -3), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(10, 0, 3), size = Vector3.new(1, 7, 4), name = "ServerDoor" },
			{ position = Vector3.new(-10, 0, 3), size = Vector3.new(1, 7, 4), name = "SecurityDoor" },
			{ position = Vector3.new(-16, 0, -14), size = Vector3.new(4, 7, 1), name = "RearExit" },
		},
	}
end

return module
