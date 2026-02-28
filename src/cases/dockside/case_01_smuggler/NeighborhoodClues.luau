--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for The Dockside Smuggler

local module = {}

function module.getClues()
	return {
		{
			id = "dock01_clue01",
			text = "A dockworker mentions seeing unmarked trucks pulling up to the warehouse after midnight at least three nights a week.",
			position = Vector3.new(35, 0, 10),
			interactRange = 10,
		},
		{
			id = "dock01_clue02",
			text = "The owner of a nearby bait shop says the warehouse never receives deliveries during normal business hours anymore.",
			position = Vector3.new(-30, 0, 20),
			interactRange = 10,
		},
		{
			id = "dock01_clue03",
			text = "A security guard at the adjacent pier recalls hearing forklifts running inside the warehouse well past 2 AM last Tuesday.",
			position = Vector3.new(10, 0, -45),
			interactRange = 10,
		},
	}
end

return module
