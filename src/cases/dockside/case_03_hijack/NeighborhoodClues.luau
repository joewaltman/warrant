--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Cargo Hijack

local module = {}

function module.getClues()
	return {
		{
			id = "dock03_clue01",
			text = "A truck driver who parks nearby says he saw a group of men cutting a lock off a shipping container around 3 AM last Friday.",
			position = Vector3.new(45, 0, 10),
			interactRange = 10,
		},
		{
			id = "dock03_clue02",
			text = "The gas station attendant across the highway noticed a white cargo van making repeated trips to the container yard every night this week.",
			position = Vector3.new(-30, 0, 30),
			interactRange = 10,
		},
		{
			id = "dock03_clue03",
			text = "A homeless man camping near the fence heard loud arguments about money and saw the night guard accept an envelope from a man in a leather jacket.",
			position = Vector3.new(20, 0, -50),
			interactRange = 10,
		},
	}
end

return module
