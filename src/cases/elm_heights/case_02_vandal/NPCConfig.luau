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
			position = Vector3.new(32, 2, 4),
			fleeRoute = nil,
			weapon = nil,
			health = 80,
		},
		{
			id = "elm02_suspect_02",
			name = "Jordan Hale",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-4, 2, -28),
			fleeRoute = {
				Vector3.new(-16, 2, -32),
				Vector3.new(-32, 2, -36),
				Vector3.new(-50, 2, -24),
				Vector3.new(-70, 2, -10),
				Vector3.new(-90, 2, 10),
			},
			weapon = nil,
			health = 100,
		},
	}
end

return module
