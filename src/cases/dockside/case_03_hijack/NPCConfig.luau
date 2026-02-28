--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Cargo Hijack

local module = {}

function module.getNPCs()
	return {
		{
			id = "dock03_npc01",
			name = "Earl "Big Rig" Mossman",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, 0, 4),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 150,
		},
		{
			id = "dock03_npc02",
			name = "Tyler Hooks",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(18, 0, 6),
			fleeRoute = { Vector3.new(24, 0, 6), Vector3.new(30, 0, 6), Vector3.new(36, 0, 0) },
			weapon = nil,
			health = 100,
		},
		{
			id = "dock03_npc03",
			name = "Jamal Price",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(4, 0, 16),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 140,
		},
		{
			id = "dock03_npc04",
			name = "Krystal Vega",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(18, 0, 18),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "dock03_npc05",
			name = "Dennis Kowalski",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(30, 0, 10),
			fleeRoute = { Vector3.new(28, 0, 14), Vector3.new(20, 0, 20), Vector3.new(14, 0, 26) },
			weapon = "Knife",
			health = 110,
		},
	}
end

return module
