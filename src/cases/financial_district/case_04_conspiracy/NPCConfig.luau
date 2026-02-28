--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Financial District Case 04 (The Conspiracy)
-- 8 suspects: 1 SURRENDER, 1 FLEE, 6 RESIST (heavily armed conspiracy network)

local module = {}

function module.getNPCs()
	return {
		{
			id = "fin04_suspect_01",
			name = "Phillip Hargrove",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-14, 1, 8),
			fleeRoute = nil,
			weapon = nil,
			health = 180,
		},
		{
			id = "fin04_suspect_02",
			name = "Mirela Costin",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(14, 1, 6),
			fleeRoute = {
				Vector3.new(10, 1, 12),
				Vector3.new(4, 1, 18),
				Vector3.new(0, 1, 23),
				Vector3.new(-6, 1, 30),
			},
			weapon = nil,
			health = 190,
		},
		{
			id = "fin04_suspect_03",
			name = "Grant Mercer",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 18),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 200,
		},
		{
			id = "fin04_suspect_04",
			name = "Dominika Reznik",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 6),
			fleeRoute = nil,
			weapon = "SMG",
			health = 210,
		},
		{
			id = "fin04_suspect_05",
			name = "Barrett Knox",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, -9, -18),
			fleeRoute = nil,
			weapon = "Rifle",
			health = 250,
		},
		{
			id = "fin04_suspect_06",
			name = "Yuri Anatolev",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-4, -9, -24),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 240,
		},
		{
			id = "fin04_suspect_07",
			name = "Sloane Beckett",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(16, -9, -20),
			fleeRoute = nil,
			weapon = "Rifle",
			health = 230,
		},
		{
			id = "fin04_suspect_08",
			name = "Aldric Brandt",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(20, -9, -18),
			fleeRoute = nil,
			weapon = "SMG",
			health = 220,
		},
	}
end

return module
