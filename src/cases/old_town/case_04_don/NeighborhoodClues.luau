--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Don's Ledger

local module = {}

function module.getClues()
	return {
		{
			id = "don_clue01",
			text = "The priest at St. Anthony's says Don Bianchi confesses every Sunday but the funerals at his parlor outnumber the parish death notices three to one.",
			position = Vector3.new(-40, 0, 15),
			interactRange = 10,
		},
		{
			id = "don_clue02",
			text = "A retired detective drinking at the corner pub says the Bianchi family has had a judge in their pocket since the seventies and nobody on the force will touch them.",
			position = Vector3.new(50, 0, -25),
			interactRange = 10,
		},
		{
			id = "don_clue03",
			text = "The dry cleaner next door has seen men in suits carrying heavy duffel bags into the funeral home's side entrance after midnight every first of the month.",
			position = Vector3.new(-20, 0, -40),
			interactRange = 10,
		},
		{
			id = "don_clue04",
			text = "A flower delivery girl says the basement always smells like chemicals that are definitely not embalming fluid and the staff get nervous whenever she lingers too long.",
			position = Vector3.new(35, 0, 45),
			interactRange = 10,
		},
	}
end

return module
