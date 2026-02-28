--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Torch

local module = {}

function module.getNPCs()
	return {
		{
			id = "torch_npc01",
			name = "Carmine Moretti",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(5, 0, 5),
			fleeRoute = nil,
			weapon = "Revolver",
			health = 180,
		},
		{
			id = "torch_npc02",
			name = "Denny Sullivan",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(15, 0, 8),
			fleeRoute = { Vector3.new(15, 0, 12), Vector3.new(20, 0, 12), Vector3.new(24, 0, 6) },
			weapon = nil,
			health = 120,
		},
		{
			id = "torch_npc03",
			name = "Sal Ferrante",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(4, 10, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 130,
		},
		{
			id = "torch_npc04",
			name = "Tommy \"Matches\" Brogan",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, -10, 6),
			fleeRoute = nil,
			weapon = "Molotov",
			health = 160,
		},
		{
			id = "torch_npc05",
			name = "Gina Moretti",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(8, 20, 5),
			fleeRoute = nil,
			weapon = nil,
			health = 120,
		},
	}
end

return module
