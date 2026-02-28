--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Elm Heights Case 04 (The Corner Dealer)
-- 4 suspects: 2 SURRENDER, 1 FLEE, 1 RESIST (difficulty 1)

local module = {}

function module.getNPCs()
	return {
		{
			id = "elm04_suspect_01",
			name = "Ray Delgado",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(2, 1, -1),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm04_suspect_02",
			name = "Sheila Odom",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-2, 1, -12),
			fleeRoute = nil,
			weapon = nil,
			health = 90,
		},
		{
			id = "elm04_suspect_03",
			name = "Darnell Pruitt",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(1, 11, -14),
			fleeRoute = {
				Vector3.new(-4, 11, -14),
				Vector3.new(-4, 1, -16),
				Vector3.new(-10, 1, -18),
				Vector3.new(-18, 1, -10),
			},
			weapon = nil,
			health = 100,
		},
		{
			id = "elm04_suspect_04",
			name = "Victor Niles",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, 1, -7),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 120,
		},
	}
end

return module
