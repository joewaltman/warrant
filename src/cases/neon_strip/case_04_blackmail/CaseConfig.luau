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
		origin = Vector3.new(0, 0, 0),
		buildingName = "The Avalon Grand Hotel",
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
