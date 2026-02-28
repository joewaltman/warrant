--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Elm Heights Case 03 (Missing on Maple Lane)
-- 3 suspects: 2 SURRENDER, 1 FLEE (difficulty 1, mostly cooperative)

local module = {}

function module.getNPCs()
	return {
		{
			id = "elm03_suspect_01",
			name = "Greg Whitfield",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(34, 2, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm03_suspect_02",
			name = "Nina Castillo",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-32, 2, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 90,
		},
		{
			id = "elm03_suspect_03",
			name = "Derek Loomis",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(36, 2, -32),
			fleeRoute = {
				Vector3.new(44, 2, -40),
				Vector3.new(56, 2, -44),
				Vector3.new(70, 2, -30),
				Vector3.new(84, 2, -10),
				Vector3.new(100, 2, 10),
			},
			weapon = nil,
			health = 110,
		},
	}
end

return module
