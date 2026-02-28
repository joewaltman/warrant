--!strict
-- CaseConfig | WARRANT: Case Closed
-- Neon Strip Case 01: Neon Nights Scam
-- Difficulty 2, 4 suspects, 13 evidence items (36 pts max)

local module = {}

function module.getData()
	return {
		caseId = "neon_01",
		caseName = "Neon Nights Scam",
		district = "Neon Strip",
		crimeType = "Fraud",
		difficulty = 2,
		xpReward = 250,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Neon Strip",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Neon Nights Nightclub",
		props = {
			-- MainFloor (center 0,0,0 size 22x11x22)
			{ name = "MainFloor_Couch1", position = Vector3.new(-6, 0, -6), preset = "couch" },
			{ name = "MainFloor_Couch2", position = Vector3.new(6, 0, -6), preset = "couch" },
			{ name = "MainFloor_TableRound1", position = Vector3.new(-4, 0, 0), preset = "table_round" },
			{ name = "MainFloor_TableRound2", position = Vector3.new(0, 0, 0), preset = "table_round" },
			{ name = "MainFloor_TableRound3", position = Vector3.new(4, 0, 0), preset = "table_round" },
			{ name = "MainFloor_Lamp1", position = Vector3.new(-8, 0, -8), preset = "lamp" },
			{ name = "MainFloor_Lamp2", position = Vector3.new(8, 0, -8), preset = "lamp" },
			{ name = "MainFloor_Lamp3", position = Vector3.new(-8, 0, 8), preset = "lamp" },
			{ name = "MainFloor_Lamp4", position = Vector3.new(8, 0, 8), preset = "lamp" },
			{ name = "MainFloor_CoverLow1", position = Vector3.new(-3, 0, 6), preset = "cover_low" },
			{ name = "MainFloor_CoverLow2", position = Vector3.new(3, 0, 6), preset = "cover_low" },
			-- VIPRoom (center -14,0,-8 size 11x11x11)
			{ name = "VIPRoom_Couch1", position = Vector3.new(-16, 0, -10), preset = "couch" },
			{ name = "VIPRoom_Couch2", position = Vector3.new(-12, 0, -10), preset = "couch" },
			{ name = "VIPRoom_TableRound1", position = Vector3.new(-14, 0, -8), preset = "table_round" },
			{ name = "VIPRoom_Lamp1", position = Vector3.new(-17, 0, -6), preset = "lamp" },
			-- DJBooth (center 14,0,-8 size 11x11x11)
			{ name = "DJBooth_Desk1", position = Vector3.new(14, 0, -10), preset = "desk" },
			{ name = "DJBooth_Computer1", position = Vector3.new(14, 0, -8), preset = "computer" },
			{ name = "DJBooth_Shelf1", position = Vector3.new(17, 0, -10), preset = "shelf" },
			-- Office (center -14,0,8 size 11x11x11)
			{ name = "Office_Desk1", position = Vector3.new(-14, 0, 6), preset = "desk" },
			{ name = "Office_Chair1", position = Vector3.new(-14, 0, 8), preset = "chair" },
			{ name = "Office_FilingCabinet1", position = Vector3.new(-17, 0, 10), preset = "filing_cabinet" },
			{ name = "Office_Safe1", position = Vector3.new(-17, 0, 6), preset = "safe" },
			{ name = "Office_Computer1", position = Vector3.new(-12, 0, 6), preset = "computer" },
			-- Restroom (center 14,0,8 size 11x11x11)
			{ name = "Restroom_CoverLow1", position = Vector3.new(14, 0, 8), preset = "cover_low" },
		},
		rooms = {
			{
				name = "MainFloor",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(22, 11, 22),
			},
			{
				name = "VIPRoom",
				position = Vector3.new(-14, 0, -8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "DJBooth",
				position = Vector3.new(14, 0, -8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "Office",
				position = Vector3.new(-14, 0, 8),
				size = Vector3.new(11, 11, 11),
			},
			{
				name = "Restroom",
				position = Vector3.new(14, 0, 8),
				size = Vector3.new(11, 11, 11),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 11), size = Vector3.new(4, 7, 1), name = "FrontEntrance" },
			{ position = Vector3.new(-8, 0, -3), size = Vector3.new(1, 7, 4), name = "VIPDoor" },
			{ position = Vector3.new(8, 0, -3), size = Vector3.new(1, 7, 4), name = "DJBoothDoor" },
			{ position = Vector3.new(-8, 0, 3), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(8, 0, 3), size = Vector3.new(1, 7, 4), name = "RestroomDoor" },
		},
	}
end

return module
