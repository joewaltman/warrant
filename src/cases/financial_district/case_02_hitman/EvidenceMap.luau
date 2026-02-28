--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Financial District Case 02 (The Contract)
-- Total possible points: 48 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Foyer
		{
			id = "fin02_guest_log",
			name = "Forged Guest Log",
			description = "Building guest register with a fake name matching the night of the killing.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(2, 3, 16),
		},
		{
			id = "fin02_elevator_cam",
			name = "Elevator Camera Still",
			description = "Printed frame grab showing a figure in a maintenance uniform at 11:47 PM.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-3, 4, 13),
		},

		-- Great room
		{
			id = "fin02_blood_spatter",
			name = "Blood Spatter Pattern",
			description = "Arterial spray pattern on the marble floor consistent with a bladed weapon.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 0.5, 0),
		},
		{
			id = "fin02_champagne_glass",
			name = "Champagne Glass with Residue",
			description = "Half-empty glass with a faint chemical residue. Possible sedative.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, 3, -3),
		},
		{
			id = "fin02_fiber_sample",
			name = "Kevlar Fiber Sample",
			description = "Fiber caught on a broken sculpture. Matches tactical vest material.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-5, 2, 4),
		},
		{
			id = "fin02_phone_smashed",
			name = "Smashed Smartphone",
			description = "Victim's phone crushed underfoot. SIM card still partially intact.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 0.5, 5),
		},

		-- Study
		{
			id = "fin02_contract_draft",
			name = "Hit Contract Draft",
			description = "Coded document outlining target details, payment terms, and a dead drop location.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-16, 3, 2),
		},
		{
			id = "fin02_burner_laptop",
			name = "Air-Gapped Laptop",
			description = "Laptop with no network card. Contains encrypted communications and wire confirmations.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-12, 3, -2),
		},
		{
			id = "fin02_wall_safe",
			name = "Hidden Wall Safe",
			description = "Safe behind a bookshelf containing $200K in banded cash and a passport.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-18, 4, 0),
		},

		-- Bedroom
		{
			id = "fin02_suppressor",
			name = "Threaded Suppressor",
			description = "Pistol suppressor hidden inside a hollowed-out book on the nightstand.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 3, 2),
		},
		{
			id = "fin02_disguise_kit",
			name = "Disguise Kit",
			description = "Makeup, wigs, and prosthetics in a duffel bag under the bed.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(12, 1, -2),
		},
		{
			id = "fin02_bloody_gloves",
			name = "Blood-Stained Gloves",
			description = "Surgical gloves with the victim's blood type found in a trash bag.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(18, 1, 4),
		},

		-- Terrace
		{
			id = "fin02_rappel_anchor",
			name = "Rappelling Anchor Point",
			description = "Freshly drilled bolt anchored to the terrace railing. Rope fibers present.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(6, 2, -20),
		},
		{
			id = "fin02_cigarette_butt",
			name = "Cigarette Butt",
			description = "Foreign brand cigarette with DNA-viable saliva. Killer waited here.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-4, 0.5, -18),
		},

		-- Panic room
		{
			id = "fin02_panic_monitor",
			name = "Security Monitor Footage",
			description = "Panic room monitors recorded the killer's entry path through all six cameras.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-14, 3, -14),
		},
		{
			id = "fin02_victim_phone",
			name = "Victim's Backup Phone",
			description = "Second phone inside the panic room with a partially dialed 911 call.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-16, 2, -16),
		},
		{
			id = "fin02_shell_casing",
			name = "Shell Casing",
			description = "9mm casing wedged in the panic room door frame. Fired during forced entry.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-14, 0.5, -10),
		},
	}
end

return module
