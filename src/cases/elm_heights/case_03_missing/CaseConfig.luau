--!strict
-- CaseConfig | WARRANT: Case Closed
-- Elm Heights Case 03 - Missing on Maple Lane
-- Difficulty 1 (Rookie), 3 suspects, 11 evidence items (34 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_03",
		caseName = "Missing on Maple Lane",
		district = "Elm Heights",
		crimeType = "Missing Person",
		difficulty = 1,
		xpReward = 130,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		origin = Vector3.new(0, 0, 0),
		buildingName = "Whitfield Residence",
		rooms = {
			{
				name = "LivingRoom",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Kitchen",
				position = Vector3.new(12, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "MasterBedroom",
				position = Vector3.new(0, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "ChildsBedroom",
				position = Vector3.new(12, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Garage",
				position = Vector3.new(-12, 0, 0),
				size = Vector3.new(10, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 5), size = Vector3.new(4, 7, 1), name = "FrontDoor" },
			{ position = Vector3.new(7, 0, 0), size = Vector3.new(1, 7, 4), name = "KitchenDoor" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "MasterBedroomDoor" },
			{ position = Vector3.new(12, 0, -6), size = Vector3.new(4, 7, 1), name = "ChildsBedroomDoor" },
			{ position = Vector3.new(-6, 0, 0), size = Vector3.new(1, 7, 4), name = "GarageDoor" },
		},
	}
end

return module
