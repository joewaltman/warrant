--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Financial District Case 01 (Insider Trading)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "fin01_clue_doorman",
			text = "The building doorman says the CFO has been coming in at odd hours, always carrying a briefcase she never had before.",
			position = Vector3.new(0, 1, 40),
			interactRange = 10,
		},
		{
			id = "fin01_clue_food_vendor",
			text = "A street vendor across the road noticed two men in suits meeting in the parking garage every Tuesday at midnight.",
			position = Vector3.new(-35, 1, 10),
			interactRange = 10,
		},
		{
			id = "fin01_clue_janitor",
			text = "The overnight janitor found shredder bags being taken out through the loading dock instead of the usual trash pickup.",
			position = Vector3.new(30, 1, -20),
			interactRange = 10,
		},
	}
end

return module
