--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Financial District Case 03 (The Vault Job)
-- Total possible points: 50 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Lobby
		{
			id = "fin03_lobby_cam",
			name = "Disabled Lobby Camera",
			description = "Security camera spray-painted black. Paint brand traceable to a local hardware store.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(4, 8, 18),
		},
		{
			id = "fin03_fake_id",
			name = "Forged Bank Inspector ID",
			description = "Fake FDIC credentials dropped near the entrance. Photo matches a known associate.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-3, 0.5, 12),
		},
		{
			id = "fin03_zip_ties",
			name = "Cut Zip Ties",
			description = "Heavy-duty zip ties used to restrain hostages, cut and discarded.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(5, 0.5, 16),
		},

		-- Tellers area
		{
			id = "fin03_cash_dye",
			name = "Dye Pack Residue",
			description = "Exploded dye pack staining the counter and scattered bills blue.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 3, 2),
		},
		{
			id = "fin03_alarm_panel",
			name = "Bypassed Alarm Panel",
			description = "Silent alarm panel with wires cut and a bypass device still attached.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-5, 4, -3),
		},
		{
			id = "fin03_note_demand",
			name = "Demand Note",
			description = "Handwritten note passed to a teller demanding access to the vault. Ink analysis possible.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(0, 3, 4),
		},

		-- Office
		{
			id = "fin03_manager_keys",
			name = "Stolen Manager Keys",
			description = "Branch manager's vault key ring found on the floor. Taken by force.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 0.5, 2),
		},
		{
			id = "fin03_office_phone",
			name = "Disconnected Phone Line",
			description = "Office phone with the line physically severed. Prevents outgoing calls.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-12, 3, -2),
		},
		{
			id = "fin03_blueprints",
			name = "Bank Floor Blueprints",
			description = "Annotated architectural blueprints with vault access routes highlighted in red.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-18, 3, 4),
		},

		-- Anteroom
		{
			id = "fin03_thermal_lance",
			name = "Thermal Lance Canister",
			description = "Spent thermic lance cylinder used to breach the vault anteroom gate.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(3, 1, -16),
		},
		{
			id = "fin03_boot_print",
			name = "Distinctive Boot Print",
			description = "Unique sole pattern pressed into melted floor tile. Size 12, military-grade tread.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-2, 0.5, -12),
		},
		{
			id = "fin03_radio_earpiece",
			name = "Dropped Radio Earpiece",
			description = "Encrypted frequency earpiece. Still receiving static from an active channel.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(4, 0.5, -18),
		},

		-- Vault
		{
			id = "fin03_deposit_boxes",
			name = "Pried Safety Deposit Boxes",
			description = "Seventeen boxes drilled open. Contents removed, serial numbers logged on the doors.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(2, 3, -30),
		},
		{
			id = "fin03_drill_bit",
			name = "Diamond Drill Bit",
			description = "Industrial drill bit snapped off inside a deposit box lock. Manufacturer traceable.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-3, 2, -26),
		},
		{
			id = "fin03_vault_fingerprint",
			name = "Latent Print on Vault Handle",
			description = "Partial thumbprint on the interior vault door handle, left when glove tore.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 4, -21),
		},

		-- Security room
		{
			id = "fin03_wiped_drives",
			name = "Wiped Security Drives",
			description = "DVR hard drives magnetically wiped. Recovery software may retrieve fragments.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 3, 2),
		},
		{
			id = "fin03_guard_log",
			name = "Altered Guard Rotation Log",
			description = "Shift log with whiteout corrections. Original times visible under UV light.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(12, 3, -4),
		},
		{
			id = "fin03_bribe_envelope",
			name = "Cash Bribe Envelope",
			description = "Envelope marked 'R.M.' containing $10,000 in hundreds. Found in a guard's locker.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(18, 2, 4),
		},
	}
end

return module
