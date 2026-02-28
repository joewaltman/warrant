--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Neon Strip Case 03 (Dirty Money)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "neon03_clue_valet",
			text = "The valet says a black SUV with tinted windows pulls up every Friday at 2 AM. Two guys carry duffel bags inside and leave empty-handed.",
			position = Vector3.new(0, 1, 28),
			interactRange = 10,
		},
		{
			id = "neon03_clue_pawnshop",
			text = "The pawn shop owner down the block cashed a casino chip once. Said it was worth ten grand but the serial number didn't match any gaming commission registry.",
			position = Vector3.new(-30, 1, 0),
			interactRange = 10,
		},
		{
			id = "neon03_clue_janitor",
			text = "A former janitor says he was fired for asking about the locked room behind the server closet. He heard counting machines running at 3 AM.",
			position = Vector3.new(28, 1, -10),
			interactRange = 10,
		},
		{
			id = "neon03_clue_cabdriver",
			text = "A cab driver picks up the same man from the casino every Saturday morning. He always pays with crisp hundreds and never gives a name.",
			position = Vector3.new(-15, 1, 25),
			interactRange = 10,
		},
	}
end

return module
