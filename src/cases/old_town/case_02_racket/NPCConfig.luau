--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Racket

local module = {}

function module.getNPCs()
	return {
		{
			id = "racket_npc01",
			name = "Paddy Doyle",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(16, 0, 16),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 200,
		},
		{
			id = "racket_npc02",
			name = "Enzo Cataldo",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(18, 0, 5),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 170,
		},
		{
			id = "racket_npc03",
			name = "Mickey Flannery",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(6, 0, 5),
			fleeRoute = { Vector3.new(3, 0, 5), Vector3.new(0, 0, 6), Vector3.new(-10, 0, 6) },
			weapon = nil,
			health = 130,
		},
		{
			id = "racket_npc04",
			name = "Big Conor Brennan",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(8, 0, 16),
			fleeRoute = nil,
			weapon = "Baseball Bat",
			health = 190,
		},
		{
			id = "racket_npc05",
			name = "Nina Cataldo",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(10, 10, 10),
			fleeRoute = nil,
			weapon = nil,
			health = 140,
		},
	}
end

return module
