--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Fence

local module = {}

function module.getNPCs()
	return {
		{
			id = "dock02_npc01",
			name = "Lou Kaplan",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(4, 0, 6),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "dock02_npc02",
			name = "Terrence Briggs",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(18, 0, 4),
			fleeRoute = nil,
			weapon = "Baseball Bat",
			health = 130,
		},
		{
			id = "dock02_npc03",
			name = "Nina Okafor",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(6, -8, 6),
			fleeRoute = { Vector3.new(6, 0, 0), Vector3.new(0, 0, 6), Vector3.new(-10, 0, 6) },
			weapon = nil,
			health = 100,
		},
		{
			id = "dock02_npc04",
			name = "Vince DeLuca",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(18, 0, 18),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 140,
		},
	}
end

return module
