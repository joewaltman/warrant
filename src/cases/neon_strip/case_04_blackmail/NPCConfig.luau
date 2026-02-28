--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Neon Strip Case 04 (The Blackmailer)
-- 6 suspects: 2 SURRENDER, 1 FLEE, 3 RESIST (difficulty 3)

local module = {}

function module.getNPCs()
	return {
		{
			id = "neon04_suspect_01",
			name = "Roland Ashford",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(3, 1, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 120,
		},
		{
			id = "neon04_suspect_02",
			name = "Celeste Duval",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-14, 9, -4),
			fleeRoute = {
				Vector3.new(-7, 9, -4),
				Vector3.new(0, 9, -9),
				Vector3.new(0, 16, -4),
				Vector3.new(6, 16, 0),
				Vector3.new(0, 24, 5),
			},
			weapon = nil,
			health = 130,
		},
		{
			id = "neon04_suspect_03",
			name = "Edgar Thorne",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(14, 17, 0),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 180,
		},
		{
			id = "neon04_suspect_04",
			name = "Vera Sloane",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-14, 9, 10),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 160,
		},
		{
			id = "neon04_suspect_05",
			name = "Harlan Briggs",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 25, 0),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 200,
		},
		{
			id = "neon04_suspect_06",
			name = "Mona Castellan",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(0, 9, -9),
			fleeRoute = nil,
			weapon = nil,
			health = 120,
		},
	}
end

return module
