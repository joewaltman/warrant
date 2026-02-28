--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 04 (The Corner Dealer)
-- Total possible points: 35 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Shop evidence (room at 0,0,0 size 20x12x16)
		{
			id = "elm04_fake_register",
			name = "Rigged Cash Register",
			description = "The register has a false bottom compartment with small baggies inside.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(5, 3, 3),
		},
		{
			id = "elm04_ledger",
			name = "Handwritten Sales Ledger",
			description = "A notebook behind the counter with coded entries and dollar amounts.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-3, 3, -3),
		},
		{
			id = "elm04_residue_counter",
			name = "White Powder Residue",
			description = "Traces of white powder on the store counter near the register.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, 3, 1),
		},

		-- Back room evidence (room at 0,0,-16 size 16x12x14)
		{
			id = "elm04_stash_box",
			name = "Hidden Stash Box",
			description = "A locked metal box hidden behind cleaning supplies. Contains small packages.",
			pointValue = 5,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-5, 0.5, -20),
		},
		{
			id = "elm04_scale",
			name = "Digital Scale",
			description = "A precision digital scale with residue, tucked under a shelf.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(2, 0.5, -14),
		},
		{
			id = "elm04_burner_phone",
			name = "Prepaid Burner Phone",
			description = "A cheap prepaid phone with texts referencing pickup times and amounts.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-2, 3, -18),
		},

		-- Hallway evidence (room at 10,0,-8 size 6x12x12)
		{
			id = "elm04_shoe_prints",
			name = "Muddy Shoe Prints",
			description = "Repeated foot traffic between the back room and stairway entrance.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(10, 0.5, -10),
		},

		-- Upstairs studio evidence (room at 0,12,-16 size 20x12x16)
		{
			id = "elm04_packaging",
			name = "Packaging Materials",
			description = "Plastic baggies, a heat sealer, and rubber bands on the kitchen table.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-4, 12.5, -18),
		},
		{
			id = "elm04_cash_bundle",
			name = "Cash Bundle",
			description = "A rolled bundle of twenties and fifties hidden inside a cereal box.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(5, 15, -22),
		},
		{
			id = "elm04_fingerprints_door",
			name = "Fingerprints on Door Handle",
			description = "Multiple sets of latent prints on the studio door handle.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 15, -8),
		},

		-- Exterior evidence
		{
			id = "elm04_camera_footage",
			name = "Traffic Camera Footage",
			description = "City camera shows frequent short stops by the same vehicles outside the store.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(25, 5, 20),
		},
		{
			id = "elm04_dumpster_bag",
			name = "Discarded Duffel Bag",
			description = "A duffel bag in the alley dumpster with traces of contraband residue inside.",
			pointValue = 1,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-15, 0.5, -14),
		},
	}
end

return module
