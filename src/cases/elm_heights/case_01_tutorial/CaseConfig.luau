--!strict
-- CaseConfig | WARRANT: Case Closed
-- Tutorial case: Elm Heights Case 01 - The Break-In
-- Difficulty 1 (Rookie), 3 suspects, 10 evidence items (32 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_01",
		caseName = "The Elm Heights Break-In",
		district = "Elm Heights",
		crimeType = "Burglary",
		difficulty = 1,
		xpReward = 100,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Elm Heights Residence",
		rooms = {
			{
				name = "LivingRoom",
				position = Vector3.new(-6, 0, 0),
				size = Vector3.new(12, 10, 12),
			},
			{
				name = "Kitchen",
				position = Vector3.new(3, 0, -9),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Bedroom",
				position = Vector3.new(-10, 0, 8),
				size = Vector3.new(8, 10, 8),
			},
			{
				name = "Hallway",
				position = Vector3.new(0, 0, 5),
				size = Vector3.new(4, 10, 14),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, -14), size = Vector3.new(4, 7, 1), name = "BackDoor" },
			{ position = Vector3.new(0, 0, 12), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(-6, 0, 5), size = Vector3.new(1, 7, 4), name = "BedroomDoor" },
		},
	}
end

return module
