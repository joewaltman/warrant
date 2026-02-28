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
		district = "Financial District",
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
		props = {
			-- OpenPlan (center 0,0,0 size 14x10x14)
			{ name = "OpenPlanDesk1", position = Vector3.new(-4, 0, -3), preset = "desk" },
			{ name = "OpenPlanDesk2", position = Vector3.new(0, 0, -3), preset = "desk" },
			{ name = "OpenPlanDesk3", position = Vector3.new(4, 0, -3), preset = "desk" },
			{ name = "OpenPlanChair1", position = Vector3.new(-4, 0, -1), preset = "chair" },
			{ name = "OpenPlanChair2", position = Vector3.new(0, 0, -1), preset = "chair" },
			{ name = "OpenPlanChair3", position = Vector3.new(4, 0, -1), preset = "chair" },
			{ name = "OpenPlanComputer1", position = Vector3.new(-4, 0, -3), preset = "computer" },
			{ name = "OpenPlanComputer2", position = Vector3.new(4, 0, -3), preset = "computer" },
			{ name = "OpenPlanCoverLow1", position = Vector3.new(-5, 0, 4), preset = "cover_low" },
			{ name = "OpenPlanCoverLow2", position = Vector3.new(5, 0, 4), preset = "cover_low" },

			-- CornerOffice (center -14,0,0 size 14x10x14)
			{ name = "CornerOfficeDesk", position = Vector3.new(-16, 0, -3), preset = "desk" },
			{ name = "CornerOfficeChair", position = Vector3.new(-16, 0, -1), preset = "chair" },
			{ name = "CornerOfficeCouch", position = Vector3.new(-11, 0, 4), preset = "couch" },
			{ name = "CornerOfficeTv", position = Vector3.new(-11, 0, -5), preset = "tv" },
			{ name = "CornerOfficeCabinet", position = Vector3.new(-19, 0, -4), preset = "filing_cabinet" },
			{ name = "CornerOfficeLamp", position = Vector3.new(-18, 0, 2), preset = "lamp" },

			-- ServerRoom (center 14,0,0 size 14x10x14)
			{ name = "ServerShelf1", position = Vector3.new(11, 0, -4), preset = "shelf" },
			{ name = "ServerShelf2", position = Vector3.new(14, 0, -4), preset = "shelf" },
			{ name = "ServerShelf3", position = Vector3.new(17, 0, -4), preset = "shelf" },
			{ name = "ServerComputer1", position = Vector3.new(11, 0, 2), preset = "computer" },
			{ name = "ServerComputer2", position = Vector3.new(17, 0, 2), preset = "computer" },
			{ name = "ServerCoverTall", position = Vector3.new(14, 0, 5), preset = "cover_tall" },

			-- ConferenceRoom (center 0,0,-14 size 14x10x14)
			{ name = "ConferenceTable", position = Vector3.new(0, 0, -14), preset = "table_round" },
			{ name = "ConferenceChair1", position = Vector3.new(-3, 0, -16), preset = "chair" },
			{ name = "ConferenceChair2", position = Vector3.new(3, 0, -16), preset = "chair" },
			{ name = "ConferenceChair3", position = Vector3.new(-3, 0, -12), preset = "chair" },
			{ name = "ConferenceChair4", position = Vector3.new(3, 0, -12), preset = "chair" },
			{ name = "ConferenceChair5", position = Vector3.new(-5, 0, -14), preset = "chair" },
			{ name = "ConferenceChair6", position = Vector3.new(5, 0, -14), preset = "chair" },
			{ name = "ConferenceTv", position = Vector3.new(0, 0, -19), preset = "tv" },
			{ name = "ConferenceLamp", position = Vector3.new(5, 0, -19), preset = "lamp" },

			-- MailRoom (center 0,0,14 size 14x10x14)
			{ name = "MailShelf1", position = Vector3.new(-4, 0, 11), preset = "shelf" },
			{ name = "MailShelf2", position = Vector3.new(4, 0, 11), preset = "shelf" },
			{ name = "MailCrate1", position = Vector3.new(-3, 0, 17), preset = "crate" },
			{ name = "MailCrate2", position = Vector3.new(3, 0, 17), preset = "crate" },
			{ name = "MailCounter", position = Vector3.new(0, 0, 14), preset = "counter" },
			{ name = "MailCoverLow", position = Vector3.new(5, 0, 19), preset = "cover_low" },
		},
	}
end

return module
