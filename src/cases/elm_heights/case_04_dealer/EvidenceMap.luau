--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 04 (The Corner Dealer)
-- Total possible points: 35 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Shop evidence
		{
			id = "elm04_fake_register",
			name = "Rigged Cash Register",
			description = "The register has a false bottom compartment with small baggies inside.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(10, 6, 6),
		},
		{
			id = "elm04_ledger",
			name = "Handwritten Sales Ledger",
			description = "A notebook behind the counter with coded entries and dollar amounts.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-6, 6, -6),
		},
		{
			id = "elm04_residue_counter",
			name = "White Powder Residue",
			description = "Traces of white powder on the store counter near the register.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(8, 6, 2),
		},

		-- Back room evidence
		{
			id = "elm04_stash_box",
			name = "Hidden Stash Box",
			description = "A locked metal box hidden behind cleaning supplies. Contains small packages.",
			pointValue = 5,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-10, 1, -40),
		},
		{
			id = "elm04_scale",
			name = "Digital Scale",
			description = "A precision digital scale with residue, tucked under a shelf.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(4, 1, -28),
		},
		{
			id = "elm04_burner_phone",
			name = "Prepaid Burner Phone",
			description = "A cheap prepaid phone with texts referencing pickup times and amounts.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-4, 6, -36),
		},

		-- Hallway evidence
		{
			id = "elm04_shoe_prints",
			name = "Muddy Shoe Prints",
			description = "Repeated foot traffic between the back room and stairway entrance.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(20, 1, -20),
		},

		-- Upstairs studio evidence
		{
			id = "elm04_packaging",
			name = "Packaging Materials",
			description = "Plastic baggies, a heat sealer, and rubber bands on the kitchen table.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-8, 25, -36),
		},
		{
			id = "elm04_cash_bundle",
			name = "Cash Bundle",
			description = "A rolled bundle of twenties and fifties hidden inside a cereal box.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(10, 30, -44),
		},
		{
			id = "elm04_fingerprints_door",
			name = "Fingerprints on Door Handle",
			description = "Multiple sets of latent prints on the studio door handle.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 30, -16),
		},

		-- Exterior evidence
		{
			id = "elm04_camera_footage",
			name = "Traffic Camera Footage",
			description = "City camera shows frequent short stops by the same vehicles outside the store.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(50, 10, 40),
		},
		{
			id = "elm04_dumpster_bag",
			name = "Discarded Duffel Bag",
			description = "A duffel bag in the alley dumpster with traces of contraband residue inside.",
			pointValue = 1,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-30, 1, -28),
		},
	}
end

return module
