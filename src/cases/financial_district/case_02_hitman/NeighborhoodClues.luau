--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Financial District Case 02 (The Contract)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "fin02_clue_concierge",
			text = "The concierge says a maintenance worker arrived at 11 PM with no scheduled appointment. He carried a heavy toolbox.",
			position = Vector3.new(0, 1, 45),
			interactRange = 10,
		},
		{
			id = "fin02_clue_valet",
			text = "The parking valet remembers a black sedan with no plates idling in the fire lane for thirty minutes before speeding off.",
			position = Vector3.new(-40, 1, 0),
			interactRange = 10,
		},
		{
			id = "fin02_clue_neighbor",
			text = "A resident on the floor below heard two muffled pops and breaking glass around midnight, then complete silence.",
			position = Vector3.new(35, 1, -15),
			interactRange = 10,
		},
	}
end

return module
