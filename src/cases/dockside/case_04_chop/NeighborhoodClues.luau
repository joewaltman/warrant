--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Chop Shop

local module = {}

function module.getClues()
	return {
		{
			id = "dock04_clue01",
			text = "A neighbor says cars get towed into the garage late at night but she never sees those same cars leave in one piece.",
			position = Vector3.new(-40, 0, 10),
			interactRange = 10,
		},
		{
			id = "dock04_clue02",
			text = "The owner of the tire shop next door complains about the constant sound of angle grinders and power tools running until dawn.",
			position = Vector3.new(50, 0, 5),
			interactRange = 10,
		},
		{
			id = "dock04_clue03",
			text = "A delivery driver noticed a flatbed truck dropping off a brand-new SUV with no plates at the garage around midnight.",
			position = Vector3.new(10, 0, -45),
			interactRange = 10,
		},
		{
			id = "dock04_clue04",
			text = "A street vendor says he has seen people loading car doors and engines into unmarked vans parked in the alley behind the shop.",
			position = Vector3.new(-15, 0, 45),
			interactRange = 10,
		},
	}
end

return module
