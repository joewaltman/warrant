--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for The Snatch

local module = {}

function module.getNPCs()
	return {
		{
			id = "snatch_npc01",
			name = "Rocco Rizzo",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(24, 0, 6),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 220,
		},
		{
			id = "snatch_npc02",
			name = "Frankie \"The Needle\" Lombardi",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(25, -10, 5),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 190,
		},
		{
			id = "snatch_npc03",
			name = "Seamus O'Malley",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(10, 0, 6),
			fleeRoute = nil,
			weapon = "Knife",
			health = 170,
		},
		{
			id = "snatch_npc04",
			name = "Declan Byrne",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(5, 12, 4),
			fleeRoute = { Vector3.new(10, 12, 4), Vector3.new(15, 12, 10), Vector3.new(20, 0, 13) },
			weapon = nil,
			health = 140,
		},
		{
			id = "snatch_npc05",
			name = "Paulie Cefalu",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(6, -10, 8),
			fleeRoute = nil,
			weapon = "Pipe Wrench",
			health = 180,
		},
		{
			id = "snatch_npc06",
			name = "Teresa Rizzo",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(30, 0, 10),
			fleeRoute = nil,
			weapon = nil,
			health = 150,
		},
	}
end

return module
