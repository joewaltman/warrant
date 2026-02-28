--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Chop Shop

local module = {}

function module.getNPCs()
	return {
		{
			id = "dock04_npc01",
			name = "Marco "Torque" Reeves",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, 0, 4),
			fleeRoute = nil,
			weapon = "Wrench",
			health = 140,
		},
		{
			id = "dock04_npc02",
			name = "Sandra Pham",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(4, 0, 18),
			fleeRoute = { Vector3.new(0, 0, 12), Vector3.new(0, 0, 6), Vector3.new(-10, 0, 0) },
			weapon = nil,
			health = 100,
		},
		{
			id = "dock04_npc03",
			name = "Ray Delgado",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(18, 0, 16),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 150,
		},
		{
			id = "dock04_npc04",
			name = "Tommy Blaine",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(20, 0, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "dock04_npc05",
			name = "Desiree Fontaine",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(16, 0, 10),
			fleeRoute = { Vector3.new(20, 0, 12), Vector3.new(24, 0, 18), Vector3.new(28, 0, 24) },
			weapon = "Knife",
			health = 110,
		},
	}
end

return module
