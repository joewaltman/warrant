--!strict
-- CaseConfig | WARRANT: Case Closed
-- Neon Strip Case 04: The Blackmailer
-- Difficulty 3, 6 suspects, 16 evidence items (44 pts max)

local module = {}

function module.getData()
	return {
		caseId = "neon_04",
		caseName = "The Blackmailer",
		district = "Neon Strip",
		crimeType = "Blackmail",
		difficulty = 3,
		xpReward = 400,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Neon Strip",
		origin = Vector3.new(0, 0, 0),
		buildingName = "The Avalon Grand Hotel",
		props = {
			-- Lobby (center 0,0,0 size 20x12x18)
			{ name = "Lobby_Couch1", position = Vector3.new(-6, 0, -4), preset = "couch" },
			{ name = "Lobby_Couch2", position = Vector3.new(6, 0, -4), preset = "couch" },
			{ name = "Lobby_TableRound1", position = Vector3.new(0, 0, -2), preset = "table_round" },
			{ name = "Lobby_Counter1", position = Vector3.new(0, 0, 5), preset = "counter" },
			{ name = "Lobby_Lamp1", position = Vector3.new(-8, 0, -7), preset = "lamp" },
			{ name = "Lobby_Lamp2", position = Vector3.new(8, 0, -7), preset = "lamp" },
			-- Suite (center -14,8,-4 size 14x10x14)
			{ name = "Suite_Bed1", position = Vector3.new(-17, 8, -7), preset = "bed" },
			{ name = "Suite_Desk1", position = Vector3.new(-11, 8, -8), preset = "desk" },
			{ name = "Suite_TV1", position = Vector3.new(-18, 8, -2), preset = "tv" },
			{ name = "Suite_Couch1", position = Vector3.new(-14, 8, -2), preset = "couch" },
			{ name = "Suite_Lamp1", position = Vector3.new(-19, 8, -8), preset = "lamp" },
			-- Bathroom (center -14,8,10 size 8x10x8)
			{ name = "Bathroom_CoverLow1", position = Vector3.new(-14, 8, 10), preset = "cover_low" },
			-- Penthouse (center 14,16,0 size 16x12x16)
			{ name = "Penthouse_Couch1", position = Vector3.new(10, 16, -4), preset = "couch" },
			{ name = "Penthouse_Couch2", position = Vector3.new(18, 16, -4), preset = "couch" },
			{ name = "Penthouse_Desk1", position = Vector3.new(10, 16, 4), preset = "desk" },
			{ name = "Penthouse_TV1", position = Vector3.new(18, 16, 0), preset = "tv" },
			{ name = "Penthouse_Safe1", position = Vector3.new(19, 16, 5), preset = "safe" },
			{ name = "Penthouse_Lamp1", position = Vector3.new(8, 16, -6), preset = "lamp" },
			{ name = "Penthouse_Lamp2", position = Vector3.new(20, 16, -6), preset = "lamp" },
			{ name = "Penthouse_CoverTall1", position = Vector3.new(14, 16, 6), preset = "cover_tall" },
			-- Rooftop (center 0,24,0 size 24x4x24)
			{ name = "Rooftop_CoverLow1", position = Vector3.new(-6, 24, -6), preset = "cover_low" },
			{ name = "Rooftop_CoverLow2", position = Vector3.new(6, 24, 6), preset = "cover_low" },
			{ name = "Rooftop_Crate1", position = Vector3.new(8, 24, -8), preset = "crate" },
			-- ElevatorShaft: no props (too small)
		},
		rooms = {
			{
				name = "Lobby",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(20, 12, 18),
			},
			{
				name = "Suite",
				position = Vector3.new(-14, 8, -4),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Bathroom",
				position = Vector3.new(-14, 8, 10),
				size = Vector3.new(8, 10, 8),
			},
			{
				name = "Penthouse",
				position = Vector3.new(14, 16, 0),
				size = Vector3.new(16, 12, 16),
			},
			{
				name = "Rooftop",
				position = Vector3.new(0, 24, 0),
				size = Vector3.new(24, 4, 24),
			},
			{
				name = "ElevatorShaft",
				position = Vector3.new(0, 8, -9),
				size = Vector3.new(6, 20, 6),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 9), size = Vector3.new(4, 7, 1), name = "LobbyEntrance" },
			{ position = Vector3.new(-7, 8, -4), size = Vector3.new(1, 7, 4), name = "SuiteDoor" },
			{ position = Vector3.new(-14, 8, 6), size = Vector3.new(4, 7, 1), name = "BathroomDoor" },
			{ position = Vector3.new(6, 16, 0), size = Vector3.new(1, 7, 4), name = "PenthouseDoor" },
			{ position = Vector3.new(6, 24, 0), size = Vector3.new(4, 7, 1), name = "RooftopAccess" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "ElevatorLobby" },
		},
	}
end

return module
