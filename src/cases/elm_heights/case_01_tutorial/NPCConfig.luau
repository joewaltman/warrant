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
			position = Vector3.new(-6, 1, 2),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm01_suspect_02",
			name = "Marcus Vega",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(8, 1, -10),
			fleeRoute = {
				Vector3.new(12, 1, -10),
				Vector3.new(18, 1, -15),
				Vector3.new(25, 1, -20),
				Vector3.new(35, 1, -30),
				Vector3.new(45, 1, -40),
			},
			weapon = nil,
			health = 100,
		},
		{
			id = "elm01_suspect_03",
			name = "Razor Trent",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-12, 1, 14),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 120,
		},
	}
end

return module
