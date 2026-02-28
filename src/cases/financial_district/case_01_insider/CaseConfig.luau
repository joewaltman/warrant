--!strict
-- CaseConfig | WARRANT: Case Closed
-- Financial District Case 01 - Insider Trading
-- Difficulty 4, 5 suspects, 16 evidence items (45 pts max)

local module = {}

function module.getData()
	return {
		caseId = "fin_01",
		caseName = "Insider Trading",
		district = "Financial District",
		crimeType = "Corporate Espionage",
		difficulty = 4,
		xpReward = 500,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Whitmore & Associates Tower",
		rooms = {
			{
				name = "OpenPlan",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "CornerOffice",
				position = Vector3.new(-14, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "ServerRoom",
				position = Vector3.new(14, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "ConferenceRoom",
				position = Vector3.new(0, 0, -14),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "MailRoom",
				position = Vector3.new(0, 0, 14),
				size = Vector3.new(14, 10, 14),
			},
		},
		doors = {
			{ position = Vector3.new(-7, 0, 0), size = Vector3.new(1, 7, 4), name = "CornerOfficeDoor" },
			{ position = Vector3.new(7, 0, 0), size = Vector3.new(1, 7, 4), name = "ServerRoomDoor" },
			{ position = Vector3.new(0, 0, -7), size = Vector3.new(4, 7, 1), name = "ConferenceDoor" },
			{ position = Vector3.new(0, 0, 7), size = Vector3.new(4, 7, 1), name = "MailRoomDoor" },
			{ position = Vector3.new(0, 0, 21), size = Vector3.new(4, 7, 1), name = "MainEntrance" },
		},
	}
end

return module
