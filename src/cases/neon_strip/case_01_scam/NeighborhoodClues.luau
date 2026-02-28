--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Neon Strip Case 01 (Neon Nights Scam)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "neon01_clue_bouncer",
			text = "The bouncer out front says the owner started running 'private VIP events' three months ago. Nobody real ever shows up to DJ.",
			position = Vector3.new(0, 1, 25),
			interactRange = 10,
		},
		{
			id = "neon01_clue_vendor",
			text = "A hot dog vendor across the street noticed guests arguing about being double-charged every weekend.",
			position = Vector3.new(-25, 1, 15),
			interactRange = 10,
		},
		{
			id = "neon01_clue_rideshare",
			text = "A rideshare driver says a guy in a silk jacket loads boxes of blank plastic cards into the back entrance every Thursday night.",
			position = Vector3.new(30, 1, 10),
			interactRange = 10,
		},
	}
end

return module
