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
			position = Vector3.new(17, 1, 2),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm03_suspect_02",
			name = "Nina Castillo",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-16, 1, 2),
			fleeRoute = nil,
			weapon = nil,
			health = 90,
		},
		{
			id = "elm03_suspect_03",
			name = "Derek Loomis",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(18, 1, -16),
			fleeRoute = {
				Vector3.new(22, 1, -20),
				Vector3.new(28, 1, -22),
				Vector3.new(35, 1, -15),
				Vector3.new(42, 1, -5),
				Vector3.new(50, 1, 5),
			},
			weapon = nil,
			health = 110,
		},
	}
end

return module
