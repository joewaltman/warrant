--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Dockside Smuggler

local module = {}

function module.getNPCs()
	return {
		{
			id = "dock01_npc01",
			name = "Rocco Valenti",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(5, 0, 5),
			fleeRoute = nil,
			weapon = "Crowbar",
			health = 140,
		},
		{
			id = "dock01_npc02",
			name = "Danny Zhao",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(16, 0, 6),
			fleeRoute = { Vector3.new(12, 0, 6), Vector3.new(6, 0, 12), Vector3.new(2, 0, 18) },
			weapon = nil,
			health = 100,
		},
		{
			id = "dock01_npc03",
			name = "Mikhail Petrov",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(18, 0, 16),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 130,
		},
		{
			id = "dock01_npc04",
			name = "Hector Salinas",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(4, 0, 18),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
	}
end

return module
