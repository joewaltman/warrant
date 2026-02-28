--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Financial District Case 01 (Insider Trading)
-- Total possible points: 45 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Open plan area
		{
			id = "fin01_trading_log",
			name = "Anomalous Trading Log",
			description = "Printout showing massive buy orders placed minutes before a merger announcement.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 3, 3),
		},
		{
			id = "fin01_sticky_note",
			name = "Sticky Note with Ticker Symbols",
			description = "Handwritten note listing three ticker symbols and tomorrow's date.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-3, 3, 4),
		},
		{
			id = "fin01_burner_phone",
			name = "Prepaid Burner Phone",
			description = "Disposable phone hidden under a desk. Call history shows encrypted messaging app.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(5, 1, -2),
		},

		-- Corner office
		{
			id = "fin01_offshore_docs",
			name = "Offshore Account Documents",
			description = "Cayman Islands bank statements showing deposits timed with stock surges.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-16, 3, 2),
		},
		{
			id = "fin01_shredded_memo",
			name = "Partially Shredded Memo",
			description = "Reassembled memo referencing confidential merger details from the board.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-12, 1, -4),
		},
		{
			id = "fin01_executive_laptop",
			name = "Executive Laptop",
			description = "CFO's personal laptop left unlocked. Email client shows forwarded SEC filings.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(-18, 3, -2),
		},

		-- Server room
		{
			id = "fin01_usb_drive",
			name = "Encrypted USB Drive",
			description = "USB drive plugged into the main server. Contains database export of pending deals.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, 2, 0),
		},
		{
			id = "fin01_server_logs",
			name = "Tampered Server Logs",
			description = "Access logs showing after-hours entries erased, but backup retained timestamps.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(18, 4, 3),
		},
		{
			id = "fin01_keycard_clone",
			name = "Cloned Access Keycard",
			description = "Duplicate keycard programmed with the CTO's credentials.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(12, 1, -3),
		},

		-- Conference room
		{
			id = "fin01_whiteboard",
			name = "Whiteboard Timeline",
			description = "Erased whiteboard with faint outline of a trading timeline still visible under UV.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 5, -16),
		},
		{
			id = "fin01_nda_copy",
			name = "Unsigned NDA Copy",
			description = "Non-disclosure agreement draft naming a shell company as the receiving party.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-3, 3, -18),
		},
		{
			id = "fin01_recording_device",
			name = "Hidden Recording Device",
			description = "Miniature audio recorder taped under the conference table.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 1, -14),
		},

		-- Mail room
		{
			id = "fin01_courier_envelope",
			name = "Sealed Courier Envelope",
			description = "Overnight envelope addressed to a PO Box containing stock certificates.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(3, 3, 16),
		},
		{
			id = "fin01_shipping_manifest",
			name = "Falsified Shipping Manifest",
			description = "Manifest listing documents sent to three offshore addresses on the same day.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-2, 4, 18),
		},
		{
			id = "fin01_security_badge",
			name = "Stolen Security Badge",
			description = "Badge belonging to a terminated analyst found wedged behind the sorting bins.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(4, 1, 12),
		},
		{
			id = "fin01_wire_transfer",
			name = "Wire Transfer Confirmation",
			description = "Printed confirmation of a $2.4M wire transfer to an unregistered brokerage.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(-4, 3, 15),
		},
	}
end

return module
