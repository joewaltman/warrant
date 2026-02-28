--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Neon Strip Case 04 (The Blackmailer)
-- Total possible points: 44 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Lobby
		{
			id = "neon04_guest_register",
			name = "Falsified Guest Register",
			description = "Hotel check-in log with a fake name matching the alias used in the blackmail letters.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(3, 3, 4),
		},
		{
			id = "neon04_lobby_cam",
			name = "Lobby Security Camera Angle",
			description = "Camera positioned to capture everyone entering the elevator. Timestamp shows the suspect at 11:42 PM.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-5, 8, 2),
		},
		{
			id = "neon04_concierge_note",
			name = "Concierge Message Slip",
			description = "Handwritten message: 'Package left at front desk for Room 1407. Do not open.' Matches blackmail drop pattern.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(6, 3, 0),
		},

		-- Suite
		{
			id = "neon04_blackmail_drafts",
			name = "Blackmail Letter Drafts",
			description = "Crumpled drafts in the wastebasket. Multiple versions demanding $500,000 for silence.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-16, 9, -6),
		},
		{
			id = "neon04_typewriter",
			name = "Portable Typewriter",
			description = "Vintage typewriter with a distinctive chipped 'e' key matching the blackmail letters.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-12, 9, -2),
		},
		{
			id = "neon04_surveillance_photos",
			name = "Surveillance Photographs",
			description = "Telephoto shots of the victim entering a motel, a rival's office, and a private clinic. Leverage material.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-18, 10, -4),
		},
		{
			id = "neon04_victim_dossier",
			name = "Victim Dossier",
			description = "Manila folder with the victim's financial records, daily schedule, and list of personal secrets.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-14, 9, -8),
		},

		-- Bathroom
		{
			id = "neon04_burned_negatives",
			name = "Partially Burned Negatives",
			description = "Film negatives melted in the sink. Surviving frames show compromising images of the victim.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-14, 9, 11),
		},
		{
			id = "neon04_latex_gloves",
			name = "Discarded Latex Gloves",
			description = "Used latex gloves in the trash. No prints on the blackmail letters but these may carry DNA.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 9, 9),
		},

		-- Penthouse
		{
			id = "neon04_payment_records",
			name = "Wire Transfer Confirmations",
			description = "Printouts confirming three wire transfers totaling $1.2 million into an offshore account.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(15, 17, -2),
		},
		{
			id = "neon04_voice_recorder",
			name = "Digital Voice Recorder",
			description = "Recorder with a taped phone call. The blackmailer's voice threatens to release the photos to the press.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(12, 17, 3),
		},
		{
			id = "neon04_safe_contents",
			name = "Hotel Safe Contents",
			description = "Open safe containing $80,000 in banded cash, three burner phones, and a forged passport.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(18, 17, -4),
		},
		{
			id = "neon04_laptop_emails",
			name = "Laptop with Draft Emails",
			description = "Open laptop with unsent emails to media outlets. Subject lines reference the victim's secrets.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 17, 4),
		},

		-- Rooftop
		{
			id = "neon04_dead_drop_bag",
			name = "Dead Drop Duffel Bag",
			description = "Black duffel bag stashed behind an HVAC unit. Contains cash payment from the latest demand.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-6, 25, -8),
		},
		{
			id = "neon04_binoculars",
			name = "High-Power Binoculars",
			description = "Binoculars positioned overlooking the victim's apartment building six blocks away. Surveillance perch.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 25, 10),
		},

		-- Elevator Shaft
		{
			id = "neon04_hidden_phone",
			name = "Hidden Burner Phone",
			description = "Phone duct-taped to the elevator shaft wall. Call log shows dozens of calls to the victim's private number.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 12, -9),
		},
	}
end

return module
