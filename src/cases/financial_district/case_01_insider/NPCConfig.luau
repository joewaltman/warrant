--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Financial District Case 01 (Insider Trading)
-- 5 suspects: 1 SURRENDER, 1 FLEE, 3 RESIST (armed guards and corporate conspirators)

local module = {}

function module.getNPCs()
	return {
		{
			id = "fin01_suspect_01",
			name = "Carolyn Whitmore",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-16, 1, 0),
			fleeRoute = nil,
			weapon = nil,
			health = 150,
		},
		{
			id = "fin01_suspect_02",
			name = "Derek Langston",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(2, 1, 2),
			fleeRoute = {
				Vector3.new(2, 1, 8),
				Vector3.new(5, 1, 14),
				Vector3.new(5, 1, 20),
				Vector3.new(10, 1, 28),
			},
			weapon = nil,
			health = 160,
		},
		{
			id = "fin01_suspect_03",
			name = "Victor Hale",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(16, 1, 2),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 180,
		},
		{
			id = "fin01_suspect_04",
			name = "Nadia Czerny",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, -16),
			fleeRoute = nil,
			weapon = "SMG",
			health = 200,
		},
		{
			id = "fin01_suspect_05",
			name = "Raymond Stokes",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 16),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 190,
		},
	}
end

return module
