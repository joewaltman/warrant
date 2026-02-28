--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Neon Strip Case 02 (The Shakedown)
-- Total possible points: 38 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Dining Room
		{
			id = "neon02_threatening_note",
			name = "Threatening Note",
			description = "A note left on a table reads: 'Pay up by Friday or the kitchen burns.' Block letters, no prints.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 3, 2),
		},
		{
			id = "neon02_broken_chair",
			name = "Smashed Chair",
			description = "A dining chair shattered against the wall. Splinters embedded in the drywall.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-4, 1, 5),
		},
		{
			id = "neon02_cctv_footage",
			name = "Dining Room CCTV Still",
			description = "Freeze-frame showing two men in leather jackets confronting the owner at the register.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(6, 6, -1),
		},

		-- Kitchen
		{
			id = "neon02_gasoline_can",
			name = "Gasoline Can",
			description = "A half-empty red gasoline can stashed behind the walk-in freezer. Arson threat made real.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 1, -4),
		},
		{
			id = "neon02_knife_marks",
			name = "Knife Marks on Prep Table",
			description = "Deep gouges carved into the steel prep table. Message reads 'LAST WARNING.'",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-12, 3, 2),
		},
		{
			id = "neon02_burner_sim",
			name = "Discarded SIM Card",
			description = "Snapped SIM card found in the grease trap. Matches the burner number from threatening calls.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-15, 1, 4),
		},
		{
			id = "neon02_bloody_apron",
			name = "Blood-Stained Apron",
			description = "A cook's apron with blood splatter. The sous chef was roughed up last Tuesday.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-18, 4, 0),
		},

		-- Office
		{
			id = "neon02_payment_records",
			name = "Protection Payment Records",
			description = "A ledger tracking weekly cash payments labeled 'consulting fees.' Dates back six months.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(15, 3, -5),
		},
		{
			id = "neon02_voicemail",
			name = "Recorded Voicemail",
			description = "Answering machine with a saved message: a gravelly voice demanding ten thousand by month end.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(12, 4, -3),
		},
		{
			id = "neon02_insurance_claim",
			name = "Rejected Insurance Claim",
			description = "Denied claim for fire damage from three months ago. The 'warning' fire they set.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 3, -7),
		},
		{
			id = "neon02_safe_cash",
			name = "Envelope of Cash in Safe",
			description = "A thick envelope labeled 'Friday' containing $5,000 in mixed bills. This week's payment.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(14, 2, -2),
		},

		-- Wine Cellar
		{
			id = "neon02_baseball_bat",
			name = "Wooden Baseball Bat",
			description = "Louisville Slugger with scuff marks on the barrel. Found propped against a wine rack.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-2, -7, -15),
		},
		{
			id = "neon02_zip_ties",
			name = "Used Zip Ties",
			description = "Cut zip ties on the cellar floor. Someone was restrained down here recently.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(3, -7, -16),
		},
		{
			id = "neon02_photo_evidence",
			name = "Polaroid of Victim's Injuries",
			description = "Polaroid showing bruises on the restaurant owner's face. Taken as a trophy or threat.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(0, -5, -12),
		},
	}
end

return module
