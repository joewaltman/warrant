--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Don's Ledger

local module = {}

function module.getNPCs()
	return {
		{
			id = "don_npc01",
			name = "Don Vittorio Bianchi",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(14, -12, 14),
			fleeRoute = nil,
			weapon = "Gold-Plated Pistol",
			health = 250,
		},
		{
			id = "don_npc02",
			name = "Marco \"The Undertaker\" Bianchi",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(20, 0, 20),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 220,
		},
		{
			id = "don_npc03",
			name = "Liam Gallagher",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, 0, 6),
			fleeRoute = nil,
			weapon = "Tommy Gun",
			health = 200,
		},
		{
			id = "don_npc04",
			name = "Nicky Fontana",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(22, -12, 10),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 190,
		},
		{
			id = "don_npc05",
			name = "Eamon \"Red\" Kavanaugh",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(20, 0, 6),
			fleeRoute = { Vector3.new(24, 0, 6), Vector3.new(28, 0, 7), Vector3.new(34, 0, 10) },
			weapon = "Derringer",
			health = 150,
		},
		{
			id = "don_npc06",
			name = "Sofia Bianchi",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(8, 0, 18),
			fleeRoute = nil,
			weapon = nil,
			health = 160,
		},
	}
end

return module
