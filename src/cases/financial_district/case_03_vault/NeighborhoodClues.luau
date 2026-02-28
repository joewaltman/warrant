--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Financial District Case 03 (The Vault Job)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "fin03_clue_hotdog_vendor",
			text = "A street vendor across the plaza saw a utility van park behind the bank at closing time. Four people in coveralls went inside and never came out.",
			position = Vector3.new(40, 1, 20),
			interactRange = 10,
		},
		{
			id = "fin03_clue_beat_cop",
			text = "The beat cop says the bank's overnight alarm has been triggering false positives for a week. Dispatch stopped sending cars after the third one.",
			position = Vector3.new(-35, 1, 10),
			interactRange = 10,
		},
		{
			id = "fin03_clue_construction",
			text = "A construction foreman on the adjacent lot noticed his power line junction was tapped. Someone spliced into the grid to run heavy equipment inside the bank.",
			position = Vector3.new(30, 1, -30),
			interactRange = 10,
		},
		{
			id = "fin03_clue_cabbie",
			text = "A cab driver picked up a nervous man three blocks away at 4 AM carrying two heavy duffel bags. He paid cash and asked to go to the waterfront.",
			position = Vector3.new(-30, 1, -25),
			interactRange = 10,
		},
	}
end

return module
