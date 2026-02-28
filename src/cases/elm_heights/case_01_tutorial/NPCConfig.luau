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
			position = Vector3.new(-12, 2, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm01_suspect_02",
			name = "Marcus Vega",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(16, 2, -20),
			fleeRoute = {
				Vector3.new(24, 2, -20),
				Vector3.new(36, 2, -30),
				Vector3.new(50, 2, -40),
				Vector3.new(70, 2, -60),
				Vector3.new(90, 2, -80),
			},
			weapon = nil,
			health = 100,
		},
		{
			id = "elm01_suspect_03",
			name = "Razor Trent",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-24, 2, 28),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 120,
		},
	}
end

return module
