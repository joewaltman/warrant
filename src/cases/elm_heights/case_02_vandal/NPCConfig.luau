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
			position = Vector3.new(13, 1, 1),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm02_suspect_02",
			name = "Jordan Hale",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-2, 1, -12),
			fleeRoute = {
				Vector3.new(-5, 1, -14),
				Vector3.new(-10, 1, -16),
				Vector3.new(-15, 1, -10),
				Vector3.new(-20, 1, -5),
			},
			weapon = nil,
			health = 100,
		},
	}
end

return module
