--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Elm Heights Case 03 (Missing on Maple Lane)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "elm03_clue_neighbor",
			name = "Across-the-Street Neighbor",
			text = "The neighbor across the street heard yelling and a car door slam around 10 PM last night.",
			position = Vector3.new(45, 1, 15),
			interactRange = 10,
		},
		{
			id = "elm03_clue_mailman",
			name = "Mail Carrier",
			text = "The mail carrier says packages have been piling up for three days. Nobody has collected them.",
			position = Vector3.new(-40, 1, 25),
			interactRange = 10,
		},
		{
			id = "elm03_clue_jogger",
			name = "Morning Jogger",
			text = "A morning jogger noticed a dark sedan with out-of-state plates parked on Maple Lane two nights in a row.",
			position = Vector3.new(50, 1, -30),
			interactRange = 10,
		},
	}
end

return module
