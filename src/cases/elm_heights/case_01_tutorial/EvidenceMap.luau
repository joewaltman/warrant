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
			position = Vector3.new(15, 0.5, -10),
		},
		{
			id = "elm01_broken_lock",
			name = "Broken Door Lock",
			description = "The back door lock has been forced open with a pry bar.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(0, 3, -19),
		},
		{
			id = "elm01_glove",
			name = "Discarded Latex Glove",
			description = "A torn latex glove caught on the fence. Partial print visible.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(25, 0.5, -15),
		},

		-- Interior - living room (room at -9,0,0 size 18x12x16)
		{
			id = "elm01_safe",
			name = "Cracked Safe",
			description = "A wall safe behind a painting, drilled open. Contents missing.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-12, 4, -4),
		},
		{
			id = "elm01_glass",
			name = "Shattered Display Case",
			description = "Glass display case smashed. Jewelry collection stolen.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-14, 0.5, 2),
		},

		-- Interior - kitchen (room at 7,0,-12 size 14x12x14)
		{
			id = "elm01_prints",
			name = "Fingerprints on Counter",
			description = "Latent prints on the kitchen counter near the back door.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(8, 3, -12),
		},
		{
			id = "elm01_receipt",
			name = "Hardware Store Receipt",
			description = "Receipt for a pry bar and bolt cutters, purchased yesterday.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(10, 3, -10),
		},

		-- Interior - bedroom (room at -12,0,12 size 14x12x12)
		{
			id = "elm01_ransacked",
			name = "Ransacked Dresser",
			description = "Drawers pulled out, clothing scattered. Suspect was searching.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-14, 0.5, 14),
		},
		{
			id = "elm01_hair",
			name = "Hair Fiber on Windowsill",
			description = "A dark hair fiber snagged on the window frame. DNA potential.",
			pointValue = 5,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-18, 5, 16),
		},

		-- Neighborhood clue turned evidence
		{
			id = "elm01_camera",
			name = "Security Camera Footage",
			description = "Neighbor's camera caught a figure entering the backyard at 2:14 AM.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(30, 5, -25),
		},
	}
end

return module
