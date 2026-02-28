--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 01 (Tutorial: The Break-In)
-- Total possible points: 32 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Front yard / exterior clues (easy to find)
		{
			id = "elm01_footprints",
			name = "Muddy Footprints",
			description = "Fresh boot prints leading from the sidewalk to the back door.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(30, 1, -20),
		},
		{
			id = "elm01_broken_lock",
			name = "Broken Door Lock",
			description = "The back door lock has been forced open with a pry bar.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(0, 6, -38),
		},
		{
			id = "elm01_glove",
			name = "Discarded Latex Glove",
			description = "A torn latex glove caught on the fence. Partial print visible.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(50, 1, -30),
		},

		-- Interior - living room
		{
			id = "elm01_safe",
			name = "Cracked Safe",
			description = "A wall safe behind a painting, drilled open. Contents missing.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-24, 8, -8),
		},
		{
			id = "elm01_glass",
			name = "Shattered Display Case",
			description = "Glass display case smashed. Jewelry collection stolen.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-28, 1, 4),
		},

		-- Interior - kitchen
		{
			id = "elm01_prints",
			name = "Fingerprints on Counter",
			description = "Latent prints on the kitchen counter near the back door.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 6, -24),
		},
		{
			id = "elm01_receipt",
			name = "Hardware Store Receipt",
			description = "Receipt for a pry bar and bolt cutters, purchased yesterday.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(20, 6, -20),
		},

		-- Interior - bedroom
		{
			id = "elm01_ransacked",
			name = "Ransacked Dresser",
			description = "Drawers pulled out, clothing scattered. Suspect was searching.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-28, 1, 28),
		},
		{
			id = "elm01_hair",
			name = "Hair Fiber on Windowsill",
			description = "A dark hair fiber snagged on the window frame. DNA potential.",
			pointValue = 5,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-36, 10, 32),
		},

		-- Neighborhood clue turned evidence
		{
			id = "elm01_camera",
			name = "Security Camera Footage",
			description = "Neighbor's camera caught a figure entering the backyard at 2:14 AM.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(60, 10, -50),
		},
	}
end

return module
