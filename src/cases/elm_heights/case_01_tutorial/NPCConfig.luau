--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Elm Heights Case 01 (Tutorial: The Break-In)
-- 3 suspects: 1 SURRENDER, 1 FLEE, 1 RESIST (demonstrates all behavior types)

local module = {}

function module.getNPCs()
	return {
		{
			id = "elm01_suspect_01",
			name = "Danny Kowalski",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-5, 1, 5),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm01_suspect_02",
			name = "Marcus Vega",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(5, 1, -5),
			fleeRoute = {
				Vector3.new(10, 1, -5),
				Vector3.new(15, 1, -10),
				Vector3.new(20, 1, -15),
				Vector3.new(30, 1, -20),
			},
			weapon = nil,
			health = 100,
		},
		{
			id = "elm01_suspect_03",
			name = "Razor Trent",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-10, 1, 8),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 120,
		},
	}
end

return module
