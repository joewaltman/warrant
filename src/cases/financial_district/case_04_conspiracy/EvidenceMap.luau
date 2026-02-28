--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Financial District Case 04 (The Conspiracy)
-- Total possible points: 55 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Reception
		{
			id = "fin04_visitor_log",
			name = "Sanitized Visitor Log",
			description = "Reception log with pages torn out. Remaining entries show coded initials.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(3, 3, 20),
		},
		{
			id = "fin04_receptionist_note",
			name = "Receptionist's Hidden Note",
			description = "Handwritten note taped under the desk: 'If they ask, the Senator was never here.'",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-2, 1, 16),
		},

		-- Office
		{
			id = "fin04_ledger",
			name = "Double-Entry Ledger",
			description = "Leather-bound ledger with two columns: legitimate billings and off-book payments.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-16, 3, 8),
		},
		{
			id = "fin04_shell_corps",
			name = "Shell Corporation Registry",
			description = "Filing cabinet containing incorporation papers for twelve shell companies across six states.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-12, 3, 2),
		},
		{
			id = "fin04_encrypted_drive",
			name = "Encrypted External Drive",
			description = "256-bit encrypted drive labeled 'Client Privileged.' Contains blackmail material.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-18, 2, 10),
		},

		-- Library
		{
			id = "fin04_hollowed_book",
			name = "Hollowed Law Volume",
			description = "Copy of 'Corporate Liability, 4th Ed.' hollowed out to conceal a satellite phone.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 5, 8),
		},
		{
			id = "fin04_annotated_statute",
			name = "Annotated Statute Book",
			description = "Tax code volume with margin notes detailing how to exploit specific loopholes.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(12, 4, 4),
		},
		{
			id = "fin04_microfiche",
			name = "Hidden Microfiche Reel",
			description = "Microfiche concealed in a book spine. Contains photographed government contracts.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(18, 6, 10),
		},

		-- Conference room
		{
			id = "fin04_whiteboard_photo",
			name = "Erased Whiteboard Residue",
			description = "UV scan reveals an organizational chart linking shell companies to political figures.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 5, 8),
		},
		{
			id = "fin04_wine_glass_dna",
			name = "Wine Glass with DNA",
			description = "Crystal glass left behind after a meeting. Saliva DNA matches a fugitive financier.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-3, 3, 4),
		},
		{
			id = "fin04_signed_contract",
			name = "Signed Kickback Agreement",
			description = "Notarized agreement detailing quarterly payments to a city official in exchange for permits.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(4, 3, 10),
		},

		-- Stairwell
		{
			id = "fin04_security_bypass",
			name = "Biometric Bypass Device",
			description = "Custom hardware wired into the stairwell keypad. Spoofs fingerprint authentication.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, -3, -8),
		},
		{
			id = "fin04_dropped_badge",
			name = "Dropped Security Badge",
			description = "Badge with the name 'J. Hargrove' and clearance level ALPHA. Grants bunker access.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-1, -5, -10),
		},

		-- War room
		{
			id = "fin04_ops_board",
			name = "Operations Planning Board",
			description = "Wall-mounted board with photos, timelines, and strings connecting targets to operatives.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(0, -7, -24),
		},
		{
			id = "fin04_comms_terminal",
			name = "Encrypted Communications Terminal",
			description = "Military-grade radio station with logs of coded transmissions to overseas cells.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-6, -7, -18),
		},
		{
			id = "fin04_passports",
			name = "Forged Passport Collection",
			description = "Drawer containing eight passports from different countries, all with the same man's photo.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(4, -8, -22),
		},
		{
			id = "fin04_money_counter",
			name = "Money Counting Machine",
			description = "Bill counter with traces of currency from four different nations. Serial numbers logged.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-4, -9, -16),
		},

		-- Armory
		{
			id = "fin04_weapons_manifest",
			name = "Weapons Manifest",
			description = "Inventory list of military-grade weapons with serial numbers filed off. Matches ATF watchlist.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(18, -7, -22),
		},
		{
			id = "fin04_c4_residue",
			name = "C4 Explosive Residue",
			description = "Trace plastic explosive residue on a workbench. Batch number links to a stolen military shipment.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(14, -8, -18),
		},
		{
			id = "fin04_body_armor",
			name = "Tagged Body Armor",
			description = "Level IV vest with a police evidence tag still attached. Stolen from an evidence locker.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(20, -9, -20),
		},
	}
end

return module
