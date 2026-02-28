--!strict
-- NPCConfig | WARRANT: Case Closed
-- NPC suspect definitions for Financial District Case 03 (The Vault Job)
-- 7 suspects: 1 SURRENDER, 1 FLEE, 5 RESIST (professional heist crew, heavily armed)

local module = {}

function module.getNPCs()
	return {
		{
			id = "fin03_suspect_01",
			name = "Gerald Pemberton",
			behaviorType = "SURRENDER" :: "SURRENDER",
			position = Vector3.new(-14, 1, 2),
			fleeRoute = nil,
			weapon = nil,
			health = 150,
		},
		{
			id = "fin03_suspect_02",
			name = "Lena Vasiliev",
			behaviorType = "FLEE" :: "FLEE",
			position = Vector3.new(0, 1, 14),
			fleeRoute = {
				Vector3.new(5, 1, 18),
				Vector3.new(10, 1, 22),
				Vector3.new(15, 1, 28),
				Vector3.new(22, 1, 35),
			},
			weapon = nil,
			health = 160,
		},
		{
			id = "fin03_suspect_03",
			name = "Roland Mackey",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, 0),
			fleeRoute = nil,
			weapon = "Shotgun",
			health = 200,
		},
		{
			id = "fin03_suspect_04",
			name = "Tomás Delgado",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(14, 1, 0),
			fleeRoute = nil,
			weapon = "SMG",
			health = 220,
		},
		{
			id = "fin03_suspect_05",
			name = "Nina Okafor",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, -14),
			fleeRoute = nil,
			weapon = "Rifle",
			health = 230,
		},
		{
			id = "fin03_suspect_06",
			name = "Warren Briggs",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(0, 1, -28),
			fleeRoute = nil,
			weapon = "Pistol",
			health = 250,
		},
		{
			id = "fin03_suspect_07",
			name = "Cassandra Holt",
			behaviorType = "RESIST" :: "RESIST",
			position = Vector3.new(-4, 1, -26),
			fleeRoute = nil,
			weapon = "SMG",
			health = 180,
		},
	}
end

return module
