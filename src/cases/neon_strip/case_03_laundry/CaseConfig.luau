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
		origin = Vector3.new(0, 0, 0),
		buildingName = "The Golden Ace Casino",
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
