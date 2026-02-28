--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Neon Strip Case 01 (Neon Nights Scam)
-- Total possible points: 36 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Main Floor
		{
			id = "neon01_fake_tickets",
			name = "Counterfeit VIP Tickets",
			description = "A stack of bogus VIP passes printed on cheap cardstock. Different serial format than real ones.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(2, 1, 3),
		},
		{
			id = "neon01_skimmer",
			name = "Card Skimmer Device",
			description = "A credit card skimmer attached to the bar's POS terminal, capturing customer data.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-3, 3, -2),
		},
		{
			id = "neon01_complaint_log",
			name = "Customer Complaint Log",
			description = "Handwritten log of customer disputes over phantom charges. Over forty entries this month.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(5, 3, 1),
		},

		-- VIP Room
		{
			id = "neon01_vip_ledger",
			name = "VIP Bottle Service Ledger",
			description = "Inflated receipts showing $800 bottles billed at $3,000. Markup scheme documented in pen.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-14, 3, -10),
		},
		{
			id = "neon01_burner_phone",
			name = "Prepaid Burner Phone",
			description = "Disposable phone with texts coordinating fake event promotions and ticket drops.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 1, -6),
		},

		-- DJ Booth
		{
			id = "neon01_fake_promo",
			name = "Fraudulent Promo Flyers",
			description = "Flyers advertising a DJ who never agreed to perform. Used to sell advance tickets.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(15, 2, -10),
		},
		{
			id = "neon01_sound_invoice",
			name = "Phantom Invoice for Sound Equipment",
			description = "Invoice from a shell company for $12,000 in sound gear that was never delivered.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(12, 4, -7),
		},

		-- Office
		{
			id = "neon01_laptop",
			name = "Encrypted Laptop",
			description = "Laptop running a cloned payment portal used to harvest credit card numbers.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-15, 3, 9),
		},
		{
			id = "neon01_shell_docs",
			name = "Shell Company Documents",
			description = "Incorporation papers for three fictitious LLCs all registered to the same P.O. box.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-12, 3, 7),
		},
		{
			id = "neon01_cash_bundle",
			name = "Hidden Cash Bundle",
			description = "Rubber-banded stack of hundreds hidden inside a hollowed-out speaker cabinet.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 1, 11),
		},

		-- Restroom
		{
			id = "neon01_victim_wallet",
			name = "Victim's Stolen Wallet",
			description = "Wallet belonging to a fraud victim, cards still inside. Dumped in the trash.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(15, 1, 10),
		},
		{
			id = "neon01_cloned_cards",
			name = "Cloned Credit Cards",
			description = "Blank magstripe cards with handwritten names. Ready to be encoded with stolen data.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(13, 3, 7),
		},
		{
			id = "neon01_security_photo",
			name = "Security Camera Still",
			description = "Printed still from the club camera showing the skimmer being installed at 1:47 AM.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(16, 5, 9),
		},
	}
end

return module
