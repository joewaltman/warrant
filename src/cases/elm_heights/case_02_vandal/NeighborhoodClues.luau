--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Elm Heights Case 02 (The Vandal's Mark)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "elm02_clue_janitor",
			name = "Frank the Janitor",
			text = "The janitor found the front door propped open with a rock when he arrived at 6 AM.",
			position = Vector3.new(80, 2, 40),
			interactRange = 10,
		},
		{
			id = "elm02_clue_dogwalker",
			name = "Dog Walker",
			text = "A late-night dog walker saw two teens running from the building around midnight.",
			position = Vector3.new(-90, 2, 30),
			interactRange = 10,
		},
		{
			id = "elm02_clue_shopkeeper",
			name = "Corner Store Clerk",
			text = "The corner store clerk sold four cans of red spray paint to a kid in a hoodie yesterday evening.",
			position = Vector3.new(100, 2, -50),
			interactRange = 10,
		},
	}
end

return module
