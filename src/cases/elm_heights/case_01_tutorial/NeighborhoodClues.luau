--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Elm Heights Case 01 (Tutorial)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "elm01_clue_neighbor",
			text = "Mrs. Patterson next door heard glass breaking around 2 AM.",
			position = Vector3.new(35, 1, 0),
			interactRange = 10,
		},
		{
			id = "elm01_clue_van",
			text = "A white panel van was parked on Elm St from midnight to 3 AM.",
			position = Vector3.new(-30, 1, -5),
			interactRange = 10,
		},
		{
			id = "elm01_clue_dog",
			text = "Mr. Chen's dog was barking at the backyard fence around 2:15 AM.",
			position = Vector3.new(25, 1, 15),
			interactRange = 10,
		},
	}
end

return module
