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
	}
end

return module
