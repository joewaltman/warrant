--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Elm Heights Case 02 (The Vandal's Mark)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "elm02_clue_janitor",
			text = "The janitor found the front door propped open with a rock when he arrived at 6 AM.",
			position = Vector3.new(30, 1, 10),
			interactRange = 10,
		},
		{
			id = "elm02_clue_dogwalker",
			text = "A late-night dog walker saw two teens running from the building around midnight.",
			position = Vector3.new(-35, 1, 5),
			interactRange = 10,
		},
		{
			id = "elm02_clue_shopkeeper",
			text = "The corner store clerk sold four cans of red spray paint to a kid in a hoodie yesterday evening.",
			position = Vector3.new(40, 1, -15),
			interactRange = 10,
		},
	}
end

return module
