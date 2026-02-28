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
			position = Vector3.new(6, 2, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm04_suspect_02",
			name = "Sheila Odom",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-8, 2, -32),
			fleeRoute = nil,
			weapon = nil,
			health = 90,
		},
		{
			id = "elm04_suspect_03",
			name = "Darnell Pruitt",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(4, 26, -36),
			fleeRoute = {
				Vector3.new(-12, 26, -36),
				Vector3.new(-12, 2, -44),
				Vector3.new(-30, 2, -50),
				Vector3.new(-50, 2, -30),
				Vector3.new(-80, 2, -10),
				Vector3.new(-100, 2, 20),
			},
			weapon = nil,
			health = 100,
		},
		{
			id = "elm04_suspect_04",
			name = "Victor Niles",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(20, 2, -20),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 120,
		},
	}
end

return module
