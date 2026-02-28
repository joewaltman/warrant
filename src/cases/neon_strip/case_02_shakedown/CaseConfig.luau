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
		origin = Vector3.new(0, 0, 0),
		buildingName = "Sal's Ristorante",
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
