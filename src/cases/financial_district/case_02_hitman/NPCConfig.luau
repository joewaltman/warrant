--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Financial District Case 02 (The Contract)
-- 6 suspects: 1 SURRENDER, 1 FLEE, 4 RESIST (heavily armed hitman crew)

local module = {}

function module.getNPCs()
	return {
		{
			id = "fin02_suspect_01",
			name = "Evelyn Marchetti",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(0, 1, 14),
			fleeRoute = nil,
			weapon = nil,
			health = 150,
		},
		{
			id = "fin02_suspect_02",
			name = "Julian Cortes",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(14, 1, 0),
			fleeRoute = {
				Vector3.new(14, 1, -6),
				Vector3.new(8, 1, -16),
				Vector3.new(0, 1, -20),
				Vector3.new(-8, 1, -26),
			},
			weapon = nil,
			health = 170,
		},
		{
			id = "fin02_suspect_03",
			name = "Konstantin Volkov",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 0),
			fleeRoute = nil,
			weapon = "Rifle",
			health = 220,
		},
		{
			id = "fin02_suspect_04",
			name = "Sienna Blackwell",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-14, 1, 0),
			fleeRoute = nil,
			weapon = "SMG",
			health = 200,
		},
		{
			id = "fin02_suspect_05",
			name = "Marcus Thorne",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, -16),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 190,
		},
		{
			id = "fin02_suspect_06",
			name = "Dietrich Voss",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-14, 1, -14),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 180,
		},
	}
end

return module
