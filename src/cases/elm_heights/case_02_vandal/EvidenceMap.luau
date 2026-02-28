--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 02 (The Vandal's Mark)
-- Total possible points: 32 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Lobby evidence
		{
			id = "elm02_graffiti_tag",
			name = "Graffiti Tag on Wall",
			description = "A large spray-painted tag reading 'KNGZ' across the lobby mural.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(0, 10, -10),
		},
		{
			id = "elm02_spray_can",
			name = "Discarded Spray Can",
			description = "A red spray can rolled under a bench. Fingerprints visible on the nozzle.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-10, 1, 6),
		},
		{
			id = "elm02_shoe_print",
			name = "Paint-Stained Shoe Print",
			description = "A clear shoe print in red paint on the lobby tile. Size 11 sneaker tread.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(6, 1, 0),
		},

		-- Office evidence
		{
			id = "elm02_smashed_computer",
			name = "Smashed Computer Monitor",
			description = "The office computer monitor has been knocked off the desk and cracked.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(34, 1, 4),
		},
		{
			id = "elm02_torn_flyer",
			name = "Torn Event Flyer",
			description = "A community event flyer ripped in half with 'CANCELLED' scrawled on it.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(24, 6, -6),
		},
		{
			id = "elm02_fingerprints_desk",
			name = "Fingerprints on Desk",
			description = "Latent prints on the director's desk near scattered papers.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(36, 6, 0),
		},

		-- Storage evidence
		{
			id = "elm02_broken_window",
			name = "Broken Storage Window",
			description = "A small window shattered inward. Entry point with fabric caught on glass.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-8, 10, -34),
		},
		{
			id = "elm02_toppled_shelves",
			name = "Toppled Supply Shelves",
			description = "Metal shelving pushed over deliberately. Paint supplies scattered.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(6, 1, -28),
		},

		-- Restroom evidence
		{
			id = "elm02_stencil",
			name = "Cardboard Stencil",
			description = "A cut-out stencil matching the lobby graffiti pattern, hidden in a trash can.",
			pointValue = 5,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(34, 1, -32),
		},

		-- Exterior evidence
		{
			id = "elm02_security_footage",
			name = "Parking Lot Camera Footage",
			description = "Security camera captured two hooded figures approaching at 11:47 PM.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(60, 10, 40),
		},
	}
end

return module
