--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Neon Strip Case 03 (Dirty Money)
-- 5 suspects: 1 SURRENDER, 1 FLEE, 3 RESIST (higher difficulty = more resistance)

local module = {}

function module.getNPCs()
	return {
		{
			id = "neon03_suspect_01",
			name = "Leland Cross",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(16, 1, -8),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 160,
		},
		{
			id = "neon03_suspect_02",
			name = "Maxine Zhao",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-16, 1, -8),
			fleeRoute = {
				Vector3.new(-16, 1, -14),
				Vector3.new(-20, 1, -18),
				Vector3.new(-25, 1, -22),
				Vector3.new(-30, 1, -28),
			},
			weapon = nil,
			health = 120,
		},
		{
			id = "neon03_suspect_03",
			name = "Dominic Hargrove",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(16, 1, 8),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 180,
		},
		{
			id = "neon03_suspect_04",
			name = "Pearl Nakamura",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-16, 1, 8),
			fleeRoute = nil,
			weapon = nil,
			health = 120,
		},
		{
			id = "neon03_suspect_05",
			name = "Colt Brennan",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 0),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 150,
		},
	}
end

return module
