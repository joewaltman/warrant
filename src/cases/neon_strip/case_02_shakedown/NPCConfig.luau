--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Neon Strip Case 02 (The Shakedown)
-- 5 suspects: 2 SURRENDER, 1 FLEE, 2 RESIST

local module = {}

function module.getNPCs()
	return {
		{
			id = "neon02_suspect_01",
			name = "Sal Fontaine",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(0, 1, 3),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "neon02_suspect_02",
			name = "Tommy Gallo",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-14, 1, -2),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 140,
		},
		{
			id = "neon02_suspect_03",
			name = "Bianca Serrano",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(14, 1, -4),
			fleeRoute = {
				Vector3.new(9, 1, -4),
				Vector3.new(5, 1, 0),
				Vector3.new(0, 1, 8),
				Vector3.new(-5, 1, 16),
			},
			weapon = nil,
			health = 110,
		},
		{
			id = "neon02_suspect_04",
			name = "Nicky Carvello",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, -7, -14),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 150,
		},
		{
			id = "neon02_suspect_05",
			name = "Frankie Bianchi",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-16, 1, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
	}
end

return module
