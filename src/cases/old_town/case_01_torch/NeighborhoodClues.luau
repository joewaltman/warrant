--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Torch

local module = {}

function module.getClues()
	return {
		{
			id = "torch_clue01",
			text = "Old Mrs. Callahan across the street says she saw a man carrying a red can into the alley around two in the morning.",
			position = Vector3.new(-35, 0, 20),
			interactRange = 10,
		},
		{
			id = "torch_clue02",
			text = "The barber next door mentions the Morettis were three months behind on their protection payments to the Doyle crew.",
			position = Vector3.new(40, 0, -10),
			interactRange = 10,
		},
		{
			id = "torch_clue03",
			text = "A street kid hanging around the fire escape saw Tommy Brogan leave the brownstone basement window around 1:45 AM smelling like gasoline.",
			position = Vector3.new(-20, 0, -45),
			interactRange = 10,
		},
	}
end

return module
