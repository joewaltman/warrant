--!strict
-- CaseConfig | WARRANT: Case Closed
-- Neon Strip Case 02: The Shakedown
-- Difficulty 2, 5 suspects, 14 evidence items (38 pts max)

local module = {}

function module.getData()
	return {
		caseId = "neon_02",
		caseName = "The Shakedown",
		district = "Neon Strip",
		crimeType = "Extortion",
		difficulty = 2,
		xpReward = 280,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Neon Strip",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Sal's Ristorante",
		props = {
			-- DiningRoom (center 0,0,0 size 20x10x16)
			{ name = "DiningRoom_TableRound1", position = Vector3.new(-4, 0, -3), preset = "table_round" },
			{ name = "DiningRoom_TableRound2", position = Vector3.new(4, 0, -3), preset = "table_round" },
			{ name = "DiningRoom_TableRound3", position = Vector3.new(-4, 0, 3), preset = "table_round" },
			{ name = "DiningRoom_TableRound4", position = Vector3.new(4, 0, 3), preset = "table_round" },
			{ name = "DiningRoom_Chair1", position = Vector3.new(-5, 0, -3), preset = "chair" },
			{ name = "DiningRoom_Chair2", position = Vector3.new(-3, 0, -3), preset = "chair" },
			{ name = "DiningRoom_Chair3", position = Vector3.new(5, 0, -3), preset = "chair" },
			{ name = "DiningRoom_Chair4", position = Vector3.new(3, 0, -3), preset = "chair" },
			{ name = "DiningRoom_Chair5", position = Vector3.new(-5, 0, 3), preset = "chair" },
			{ name = "DiningRoom_Chair6", position = Vector3.new(-3, 0, 3), preset = "chair" },
			{ name = "DiningRoom_Chair7", position = Vector3.new(5, 0, 3), preset = "chair" },
			{ name = "DiningRoom_Chair8", position = Vector3.new(3, 0, 3), preset = "chair" },
			{ name = "DiningRoom_Counter1", position = Vector3.new(-7, 0, 0), preset = "counter" },
			{ name = "DiningRoom_Lamp1", position = Vector3.new(-8, 0, -6), preset = "lamp" },
			{ name = "DiningRoom_Lamp2", position = Vector3.new(8, 0, -6), preset = "lamp" },
			-- Kitchen (center -14,0,0 size 12x10x14)
			{ name = "Kitchen_Counter1", position = Vector3.new(-16, 0, -2), preset = "counter" },
			{ name = "Kitchen_Shelf1", position = Vector3.new(-18, 0, 4), preset = "shelf" },
			{ name = "Kitchen_Crate1", position = Vector3.new(-12, 0, -4), preset = "crate" },
			{ name = "Kitchen_Barrel1", position = Vector3.new(-12, 0, 4), preset = "barrel" },
			-- Office (center 14,0,-4 size 10x10x10)
			{ name = "Office_Desk1", position = Vector3.new(14, 0, -6), preset = "desk" },
			{ name = "Office_Chair1", position = Vector3.new(14, 0, -4), preset = "chair" },
			{ name = "Office_Safe1", position = Vector3.new(17, 0, -7), preset = "safe" },
			{ name = "Office_FilingCabinet1", position = Vector3.new(17, 0, -3), preset = "filing_cabinet" },
			-- WineCellar (center 0,-8,-14 size 14x8x10)
			{ name = "WineCellar_Barrel1", position = Vector3.new(-4, -8, -16), preset = "barrel" },
			{ name = "WineCellar_Barrel2", position = Vector3.new(-2, -8, -16), preset = "barrel" },
			{ name = "WineCellar_Barrel3", position = Vector3.new(2, -8, -16), preset = "barrel" },
			{ name = "WineCellar_Barrel4", position = Vector3.new(4, -8, -16), preset = "barrel" },
			{ name = "WineCellar_Crate1", position = Vector3.new(-4, -8, -12), preset = "crate" },
			{ name = "WineCellar_Crate2", position = Vector3.new(4, -8, -12), preset = "crate" },
			{ name = "WineCellar_Shelf1", position = Vector3.new(0, -8, -17), preset = "shelf" },
			{ name = "WineCellar_CoverLow1", position = Vector3.new(0, -8, -12), preset = "cover_low" },
		},
		rooms = {
			{
				name = "DiningRoom",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(20, 10, 16),
			},
			{
				name = "Kitchen",
				position = Vector3.new(-14, 0, 0),
				size = Vector3.new(12, 10, 14),
			},
			{
				name = "Office",
				position = Vector3.new(14, 0, -4),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "WineCellar",
				position = Vector3.new(0, -8, -14),
				size = Vector3.new(14, 8, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 8), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(-9, 0, 0), size = Vector3.new(1, 7, 4), name = "KitchenDoor" },
			{ position = Vector3.new(9, 0, -4), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(0, -4, -9), size = Vector3.new(4, 7, 1), name = "CellarStairs" },
		},
	}
end

return module
