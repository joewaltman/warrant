--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Snatch

local module = {}

function module.getClues()
	return {
		{
			id = "snatch_clue01",
			text = "A homeless man camped behind the factory says he heard muffled screaming coming from below ground three nights ago.",
			position = Vector3.new(-25, 0, 30),
			interactRange = 10,
		},
		{
			id = "snatch_clue02",
			text = "The owner of the bodega across the street noticed a black panel van with no plates parked at the loading bay every night this week.",
			position = Vector3.new(50, 0, -15),
			interactRange = 10,
		},
		{
			id = "snatch_clue03",
			text = "A mail carrier says Rocco Rizzo has been picking up food orders for six people even though the factory has been shut down for two years.",
			position = Vector3.new(-40, 0, -20),
			interactRange = 10,
		},
		{
			id = "snatch_clue04",
			text = "A night-shift cabbie remembers dropping off two large men near the factory at midnight who paid in cash and told him to forget the fare.",
			position = Vector3.new(30, 0, -45),
			interactRange = 10,
		},
	}
end

return module
