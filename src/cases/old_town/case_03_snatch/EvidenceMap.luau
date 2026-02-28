--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Snatch
-- Total possible points: 45 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "snatch_e01",
			name = "Ransom Note",
			description = "A cut-and-paste ransom note demanding $200,000 for the victim's safe return.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(24, 1, 5),
		},
		{
			id = "snatch_e02",
			name = "Victim's Wristwatch",
			description = "An engraved gold wristwatch belonging to the victim, dropped near the loading bay.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 0, 4),
		},
		{
			id = "snatch_e03",
			name = "Duct Tape Roll",
			description = "A partially used roll of duct tape with hair fibers stuck to the adhesive.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(22, -9, 4),
		},
		{
			id = "snatch_e04",
			name = "Chloroform Bottle",
			description = "A brown glass bottle of chloroform with a rag stuffed in the neck.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(8, -9, 8),
		},
		{
			id = "snatch_e05",
			name = "Burner Phone with Texts",
			description = "A prepaid phone containing text messages coordinating the abduction timeline.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(28, 1, 10),
		},
		{
			id = "snatch_e06",
			name = "Van Registration Papers",
			description = "Registration papers for a black panel van traced to a stolen identity.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(15, 1, 2),
		},
		{
			id = "snatch_e07",
			name = "Rope Binding Fragments",
			description = "Cut sections of nylon rope with knot patterns consistent with the restraints.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(25, -9, 8),
		},
		{
			id = "snatch_e08",
			name = "Bloody Zip Ties",
			description = "Used zip ties with blood residue found near the holding cell drain.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(30, -9, 3),
		},
		{
			id = "snatch_e09",
			name = "Surveillance Camera Footage",
			description = "A memory card from a hidden camera showing suspects entering with the victim.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(5, 13, 2),
		},
		{
			id = "snatch_e10",
			name = "Victim's Torn Jacket",
			description = "The victim's suit jacket with a torn lapel, discarded on the main floor.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(12, 0, 10),
		},
		{
			id = "snatch_e11",
			name = "Handwritten Guard Schedule",
			description = "A schedule showing who was assigned to watch the victim in four-hour shifts.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(18, 13, 8),
		},
		{
			id = "snatch_e12",
			name = "Food Receipts",
			description = "Takeout receipts from a nearby deli timestamped over the past five days.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(10, 0, 6),
		},
		{
			id = "snatch_e13",
			name = "Map with Marked Routes",
			description = "A city map with escape routes marked in red ink and police patrol times noted.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(22, 1, 11),
		},
		{
			id = "snatch_e14",
			name = "Cigarette Butts",
			description = "A cluster of cigarette butts by the boiler, DNA-testable for suspect identification.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, -9, 11),
		},
		{
			id = "snatch_e15",
			name = "Padlock with Key",
			description = "A heavy-duty padlock and key used to secure the holding cell door.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(20, -9, 6),
		},
		{
			id = "snatch_e16",
			name = "Polaroid of Victim",
			description = "A proof-of-life Polaroid photograph of the victim holding today's newspaper.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(26, 1, 2),
		},
	}
end

return module
