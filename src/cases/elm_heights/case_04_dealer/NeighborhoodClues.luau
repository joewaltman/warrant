--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Elm Heights Case 04 (The Corner Dealer)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "elm04_clue_resident",
			name = "Block Resident",
			text = "A resident on the block says cars pull up to the store at odd hours, stay less than a minute, then leave.",
			position = Vector3.new(45, 1, 15),
			interactRange = 10,
		},
		{
			id = "elm04_clue_teacher",
			name = "School Teacher",
			text = "A teacher at Elm Heights Middle says two students were caught with small baggies matching ones sold nearby.",
			position = Vector3.new(-50, 1, 20),
			interactRange = 10,
		},
		{
			id = "elm04_clue_shopowner",
			name = "Dry Cleaner Owner",
			text = "The dry cleaner next door has noticed a chemical smell coming through the shared wall late at night.",
			position = Vector3.new(40, 1, -30),
			interactRange = 10,
		},
		{
			id = "elm04_clue_delivery",
			name = "Delivery Driver",
			text = "A delivery driver says the store receives unusually frequent shipments from an unlabeled van.",
			position = Vector3.new(-45, 1, -25),
			interactRange = 10,
		},
	}
end

return module
