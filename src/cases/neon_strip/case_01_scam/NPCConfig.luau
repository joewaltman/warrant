--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Neon Strip Case 01 (Neon Nights Scam)
-- 4 suspects: 2 SURRENDER, 1 FLEE, 1 RESIST

local module = {}

function module.getNPCs()
	return {
		{
			id = "neon01_suspect_01",
			name = "Victor Delacroix",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-14, 1, -8),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "neon01_suspect_02",
			name = "Jasmine Kwon",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(14, 1, -8),
			fleeRoute = nil,
			weapon = nil,
			health = 100,
		},
		{
			id = "neon01_suspect_03",
			name = "Ricky Palazzo",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(-14, 1, 8),
			fleeRoute = {
				Vector3.new(-10, 1, 8),
				Vector3.new(-4, 1, 5),
				Vector3.new(0, 1, 11),
				Vector3.new(8, 1, 18),
			},
			weapon = nil,
			health = 120,
		},
		{
			id = "neon01_suspect_04",
			name = "Dex Morrow",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(14, 1, 8),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 140,
		},
	}
end

return module
