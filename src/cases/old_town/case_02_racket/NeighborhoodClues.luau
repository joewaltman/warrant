--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Racket

local module = {}

function module.getClues()
	return {
		{
			id = "racket_clue01",
			text = "The florist on the corner says Paddy Doyle's boys collect envelopes from every shop on the block every Tuesday like clockwork.",
			position = Vector3.new(-30, 0, 25),
			interactRange = 10,
		},
		{
			id = "racket_clue02",
			text = "A dockworker nursing a black eye at the diner says anyone who misses a payment to the Doyle crew gets a visit from Big Conor with his bat.",
			position = Vector3.new(45, 0, -20),
			interactRange = 10,
		},
		{
			id = "racket_clue03",
			text = "The newsstand owner whispers that the social club gets deliveries of crates every Thursday night that definitely aren't liquor.",
			position = Vector3.new(-15, 0, -40),
			interactRange = 10,
		},
	}
end

return module
