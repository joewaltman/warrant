--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Neon Strip Case 02 (The Shakedown)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "neon02_clue_barber",
			text = "The barber next door says two guys in leather jackets come by every Friday evening. They never eat, just go straight to the back.",
			position = Vector3.new(25, 1, 5),
			interactRange = 10,
		},
		{
			id = "neon02_clue_delivery",
			text = "A delivery driver saw the restaurant owner with a black eye last week. He said he 'walked into a door.'",
			position = Vector3.new(-20, 1, 12),
			interactRange = 10,
		},
		{
			id = "neon02_clue_smoke",
			text = "The tenant upstairs smelled gasoline near the back alley three months ago. The next morning there was scorch marks on the kitchen wall.",
			position = Vector3.new(0, 1, -25),
			interactRange = 10,
		},
	}
end

return module
