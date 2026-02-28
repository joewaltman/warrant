--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Elm Heights Case 02 (The Vandal's Mark)
-- 2 suspects: 1 SURRENDER, 1 FLEE (difficulty 1, more cooperative)

local module = {}

function module.getNPCs()
	return {
		{
			id = "elm02_suspect_01",
			name = "Tyler Briggs",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(16, 1, 2),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm02_suspect_02",
			name = "Jordan Hale",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-2, 1, -14),
			fleeRoute = {
				Vector3.new(-8, 1, -16),
				Vector3.new(-16, 1, -18),
				Vector3.new(-25, 1, -12),
				Vector3.new(-35, 1, -5),
				Vector3.new(-45, 1, 5),
			},
			weapon = nil,
			health = 100,
		},
	}
end

return module
