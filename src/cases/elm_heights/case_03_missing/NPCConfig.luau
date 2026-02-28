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
			position = Vector3.new(13, 1, 1),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm03_suspect_02",
			name = "Nina Castillo",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-12, 1, -1),
			fleeRoute = nil,
			weapon = nil,
			health = 90,
		},
		{
			id = "elm03_suspect_03",
			name = "Derek Loomis",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(14, 1, -13),
			fleeRoute = {
				Vector3.new(16, 1, -16),
				Vector3.new(20, 1, -18),
				Vector3.new(25, 1, -12),
				Vector3.new(30, 1, -5),
			},
			weapon = nil,
			health = 110,
		},
	}
end

return module
