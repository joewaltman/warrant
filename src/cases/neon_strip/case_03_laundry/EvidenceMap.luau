--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Neon Strip Case 03 (Dirty Money)
-- Total possible points: 42 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Casino Floor
		{
			id = "neon03_rigged_machine",
			name = "Rigged Slot Machine",
			description = "Slot machine with a modified payout chip. Programmed to report false jackpots for laundering cycles.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-4, 3, 3),
		},
		{
			id = "neon03_chip_tray",
			name = "Excess Chip Tray",
			description = "A chip tray with $50,000 in chips that don't match the casino's current issue. Older design, recycled float.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(5, 3, -2),
		},
		{
			id = "neon03_fake_winner",
			name = "Staged Winner Photograph",
			description = "Framed photo of a 'jackpot winner' who is actually the owner's cousin. Used to justify large payouts.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(0, 6, -5),
		},

		-- Cashier Cage
		{
			id = "neon03_cash_counter",
			name = "Tampered Cash Counter",
			description = "Bill counter with modified firmware. Reads $80,000 as $120,000 on the official tally.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-16, 3, -9),
		},
		{
			id = "neon03_transaction_logs",
			name = "Falsified Transaction Logs",
			description = "Handwritten logs showing buy-ins from phantom players. Over $200,000 laundered this quarter.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-14, 3, -6),
		},
		{
			id = "neon03_currency_bands",
			name = "Foreign Currency Bands",
			description = "Paper bands from overseas banks wrapped around stacks of hundreds. No legitimate import record.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-18, 2, -10),
		},

		-- Manager Office
		{
			id = "neon03_offshore_docs",
			name = "Offshore Account Statements",
			description = "Bank statements from three Caribbean shell accounts. Monthly transfers matching casino 'winnings.'",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(17, 3, -9),
		},
		{
			id = "neon03_coded_notebook",
			name = "Coded Notebook",
			description = "Leather notebook with alphanumeric codes corresponding to laundering batches and drop schedules.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(14, 4, -6),
		},
		{
			id = "neon03_shredded_papers",
			name = "Partially Shredded Documents",
			description = "Cross-cut shreds in the bin. Reassembled fragment shows a wire transfer for $47,000 to a Cayman account.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(18, 1, -10),
		},

		-- Server Room
		{
			id = "neon03_modified_server",
			name = "Modified Payout Server",
			description = "Rack server running custom software that generates fake player sessions and inflated win reports.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(17, 3, 9),
		},
		{
			id = "neon03_usb_drive",
			name = "Encrypted USB Drive",
			description = "USB stick taped behind the server rack. Contains a second set of books with real transaction figures.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(14, 5, 7),
		},
		{
			id = "neon03_network_diagram",
			name = "Network Routing Diagram",
			description = "Whiteboard diagram showing data paths between the casino system and three offshore payment gateways.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(18, 6, 10),
		},

		-- Security Room
		{
			id = "neon03_wiped_tapes",
			name = "Wiped Security Tapes",
			description = "Surveillance DVR with gaps every Friday between 2 AM and 4 AM. Cash delivery windows erased.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-17, 3, 9),
		},
		{
			id = "neon03_guard_payoff",
			name = "Guard Payoff Envelope",
			description = "Envelope in the guard's drawer labeled 'bonus' containing $2,000 in cash. Weekly hush money.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-14, 2, 7),
		},
		{
			id = "neon03_visitor_badge",
			name = "Unregistered Visitor Badge",
			description = "Access badge with no name or photo. Grants entry to the cage and server room after hours.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-18, 1, 10),
		},
	}
end

return module
