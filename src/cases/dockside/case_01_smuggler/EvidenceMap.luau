--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Dockside Smuggler
-- Total possible points: 35 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "dock01_ev01",
			name = "Unmarked Shipping Crate",
			description = "A large wooden crate with no customs labels or import stamps. Contains undeclared electronics.",
			pointValue = 4,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 0, 3),
		},
		{
			id = "dock01_ev02",
			name = "Falsified Manifest",
			description = "A cargo manifest listing the shipment as 'dried fish' when the contents are clearly not food.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 3, 4),
		},
		{
			id = "dock01_ev03",
			name = "Burner Phone",
			description = "A prepaid cell phone with text messages arranging late-night dock pickups.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(18, 3, 2),
		},
		{
			id = "dock01_ev04",
			name = "Customs Bribe Ledger",
			description = "A small notebook recording payments to port officials in exchange for waving through shipments.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(20, 3, 8),
		},
		{
			id = "dock01_ev05",
			name = "Hidden Compartment Panel",
			description = "A false wall panel in the cold storage unit concealing a secondary storage space.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(18, 1, 18),
		},
		{
			id = "dock01_ev06",
			name = "Counterfeit Import Stamps",
			description = "A collection of forged customs stamps from multiple countries.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(16, 0, 20),
		},
		{
			id = "dock01_ev07",
			name = "Security Camera Footage",
			description = "A USB drive containing footage of after-hours loading dock activity.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(15, 4, 3),
		},
		{
			id = "dock01_ev08",
			name = "Smuggled Contraband Samples",
			description = "Vacuum-sealed packages of prohibited imported goods hidden among legitimate cargo.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, 0, 16),
		},
		{
			id = "dock01_ev09",
			name = "Forklift Key with Tag",
			description = "A forklift key on a chain with a tag reading 'NIGHT USE ONLY - R.V.'",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 1, 18),
		},
		{
			id = "dock01_ev10",
			name = "Offshore Bank Statements",
			description = "Printed bank statements showing large deposits routed through a shell company in the Caymans.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(19, 2, 6),
		},
		{
			id = "dock01_ev11",
			name = "Bolt Cutters with Residue",
			description = "Heavy-duty bolt cutters with paint transfer matching container seals.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(2, 0, 8),
		},
		{
			id = "dock01_ev12",
			name = "Coded Radio",
			description = "A two-way radio tuned to a non-standard frequency used to coordinate dock arrivals.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(6, 1, 6),
		},
	}
end

return module
