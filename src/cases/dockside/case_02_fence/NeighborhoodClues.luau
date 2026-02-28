--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Fence

local module = {}

function module.getClues()
	return {
		{
			id = "dock02_clue01",
			text = "A mailman says he's seen people carrying TVs and electronics in through the back alley at all hours, but never any delivery trucks.",
			position = Vector3.new(40, 0, 5),
			interactRange = 10,
		},
		{
			id = "dock02_clue02",
			text = "The coffee shop owner across the street noticed the pawn shop stays open well past its posted hours, always with the blinds drawn.",
			position = Vector3.new(-35, 0, 15),
			interactRange = 10,
		},
		{
			id = "dock02_clue03",
			text = "A local resident says expensive items in the pawn shop window change daily but the listed prices are always suspiciously low.",
			position = Vector3.new(15, 0, -40),
			interactRange = 10,
		},
	}
end

return module
