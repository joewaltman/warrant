--!strict
-- CaseConfig | WARRANT: Case Closed
-- Financial District Case 03 - The Vault Job
-- Difficulty 4, 7 suspects, 18 evidence items (50 pts max)

local module = {}

function module.getData()
	return {
		caseId = "fin_03",
		caseName = "The Vault Job",
		district = "Financial District",
		crimeType = "Heist",
		difficulty = 4,
		xpReward = 650,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Sterling National Bank",
		rooms = {
			{
				name = "Lobby",
				position = Vector3.new(0, 0, 14),
				size = Vector3.new(14, 12, 14),
			},
			{
				name = "TellersArea",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Office",
				position = Vector3.new(-14, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Anteroom",
				position = Vector3.new(0, 0, -14),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "Vault",
				position = Vector3.new(0, 0, -28),
				size = Vector3.new(14, 10, 14),
			},
			{
				name = "SecurityRoom",
				position = Vector3.new(14, 0, 0),
				size = Vector3.new(14, 10, 14),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 21), size = Vector3.new(4, 7, 1), name = "MainEntrance" },
			{ position = Vector3.new(0, 0, 7), size = Vector3.new(4, 7, 1), name = "LobbyToTellers" },
			{ position = Vector3.new(-7, 0, 0), size = Vector3.new(1, 7, 4), name = "OfficeDoor" },
			{ position = Vector3.new(7, 0, 0), size = Vector3.new(1, 7, 4), name = "SecurityDoor" },
			{ position = Vector3.new(0, 0, -7), size = Vector3.new(4, 7, 1), name = "AnteroomDoor" },
			{ position = Vector3.new(0, 0, -21), size = Vector3.new(4, 7, 1), name = "VaultDoor" },
		},
	}
end

return module
