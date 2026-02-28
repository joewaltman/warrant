--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Financial District Case 04 (The Conspiracy)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "fin04_clue_courier",
			text = "A bike courier says he delivers sealed envelopes to this address every Friday night. No return address, always paid in cash.",
			position = Vector3.new(40, 1, 25),
			interactRange = 10,
		},
		{
			id = "fin04_clue_parking_attendant",
			text = "The parking garage attendant noticed armored SUVs with blacked-out windows arriving after midnight. Men in tactical gear unload crates into the service elevator.",
			position = Vector3.new(-40, 1, 0),
			interactRange = 10,
		},
		{
			id = "fin04_clue_window_washer",
			text = "A window washer on the adjacent building saw the law firm's basement lights on through a ventilation grate. There are no windows down there on the blueprints.",
			position = Vector3.new(35, 1, -30),
			interactRange = 10,
		},
		{
			id = "fin04_clue_food_delivery",
			text = "A delivery driver says he brings food for twelve people to a firm that only lists four employees. They always meet him at the curb and never let him inside.",
			position = Vector3.new(-30, 1, 35),
			interactRange = 10,
		},
	}
end

return module
