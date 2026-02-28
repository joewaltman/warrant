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
	}
end

return module
