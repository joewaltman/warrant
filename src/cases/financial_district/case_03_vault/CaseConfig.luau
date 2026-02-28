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
		district = "Financial District",
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
		props = {
			-- Lobby (center 0,0,14 size 14x12x14)
			{ name = "LobbyCouch1", position = Vector3.new(-4, 0, 16), preset = "couch" },
			{ name = "LobbyCouch2", position = Vector3.new(4, 0, 16), preset = "couch" },
			{ name = "LobbyCounter", position = Vector3.new(0, 0, 12), preset = "counter" },
			{ name = "LobbyLamp1", position = Vector3.new(-5, 0, 19), preset = "lamp" },
			{ name = "LobbyLamp2", position = Vector3.new(5, 0, 19), preset = "lamp" },

			-- TellersArea (center 0,0,0 size 14x10x14)
			{ name = "TellersCounter1", position = Vector3.new(-3, 0, 2), preset = "counter" },
			{ name = "TellersCounter2", position = Vector3.new(3, 0, 2), preset = "counter" },
			{ name = "TellersDesk", position = Vector3.new(0, 0, -3), preset = "desk" },
			{ name = "TellersChair1", position = Vector3.new(-3, 0, 0), preset = "chair" },
			{ name = "TellersChair2", position = Vector3.new(3, 0, 0), preset = "chair" },
			{ name = "TellersCoverLow", position = Vector3.new(5, 0, -5), preset = "cover_low" },

			-- Office (center -14,0,0 size 14x10x14)
			{ name = "OfficeDesk", position = Vector3.new(-16, 0, -3), preset = "desk" },
			{ name = "OfficeChair", position = Vector3.new(-16, 0, -1), preset = "chair" },
			{ name = "OfficeCabinet1", position = Vector3.new(-19, 0, 4), preset = "filing_cabinet" },
			{ name = "OfficeCabinet2", position = Vector3.new(-19, 0, -4), preset = "filing_cabinet" },
			{ name = "OfficeComputer", position = Vector3.new(-16, 0, -3), preset = "computer" },
			{ name = "OfficeSafe", position = Vector3.new(-11, 0, -5), preset = "safe" },

			-- Anteroom (center 0,0,-14 size 14x10x14)
			{ name = "AnteroomDesk", position = Vector3.new(0, 0, -12), preset = "desk" },
			{ name = "AnteroomComputer", position = Vector3.new(0, 0, -12), preset = "computer" },
			{ name = "AnteroomCoverTall1", position = Vector3.new(-5, 0, -17), preset = "cover_tall" },
			{ name = "AnteroomCoverTall2", position = Vector3.new(5, 0, -17), preset = "cover_tall" },

			-- Vault (center 0,0,-28 size 14x10x14)
			{ name = "VaultSafe1", position = Vector3.new(-4, 0, -30), preset = "safe" },
			{ name = "VaultSafe2", position = Vector3.new(4, 0, -30), preset = "safe" },
			{ name = "VaultShelf1", position = Vector3.new(-5, 0, -25), preset = "shelf" },
			{ name = "VaultShelf2", position = Vector3.new(5, 0, -25), preset = "shelf" },
			{ name = "VaultCrate", position = Vector3.new(0, 0, -32), preset = "crate" },
			{ name = "VaultCoverTall", position = Vector3.new(0, 0, -26), preset = "cover_tall" },

			-- SecurityRoom (center 14,0,0 size 14x10x14)
			{ name = "SecurityDesk1", position = Vector3.new(12, 0, -3), preset = "desk" },
			{ name = "SecurityDesk2", position = Vector3.new(16, 0, -3), preset = "desk" },
			{ name = "SecurityComputer1", position = Vector3.new(12, 0, -3), preset = "computer" },
			{ name = "SecurityComputer2", position = Vector3.new(16, 0, -3), preset = "computer" },
			{ name = "SecurityShelf", position = Vector3.new(19, 0, 4), preset = "shelf" },
		},
	}
end

return module
