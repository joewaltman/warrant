--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Cargo Hijack
-- Total possible points: 38 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "dock03_ev01",
			name = "Hijacked Trailer Manifest",
			description = "The original shipping manifest for the stolen trailer, listing high-value consumer electronics.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(4, 2, 4),
		},
		{
			id = "dock03_ev02",
			name = "Cut Padlock",
			description = "A heavy-duty padlock severed with industrial bolt cutters, still attached to the trailer latch.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(10, 1, 2),
		},
		{
			id = "dock03_ev03",
			name = "GPS Jammer Device",
			description = "A portable GPS signal jammer used to disable the trailer's tracking system during the hijack.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(6, 0, 8),
		},
		{
			id = "dock03_ev04",
			name = "Repackaged Electronics",
			description = "Stolen TVs and game consoles being reboxed in plain brown cartons inside Container A.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 0, 4),
		},
		{
			id = "dock03_ev05",
			name = "Cloned Transponder Key",
			description = "An electronic key fob programmed to start the hijacked trailer's cab without the original key.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(30, 2, 8),
		},
		{
			id = "dock03_ev06",
			name = "Guard Bribe Envelope",
			description = "An envelope addressed to the night guard containing cash and a handwritten note reading 'Look the other way.'",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(32, 2, 10),
		},
		{
			id = "dock03_ev07",
			name = "Stolen License Plates",
			description = "A stack of license plates from different states, used to swap onto hijacked vehicles.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(4, 0, 18),
		},
		{
			id = "dock03_ev08",
			name = "Police Scanner Radio",
			description = "A handheld radio tuned to local police dispatch frequencies to monitor law enforcement activity.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 1, 18),
		},
		{
			id = "dock03_ev09",
			name = "Route Planning Map",
			description = "A highway map with marked routes, truck stops, and timing notes for intercepting cargo shipments.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(30, 3, 12),
		},
		{
			id = "dock03_ev10",
			name = "Tire Spike Strip",
			description = "A collapsible spike strip used to force cargo trucks to stop on isolated road stretches.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 0, 16),
		},
		{
			id = "dock03_ev11",
			name = "Walkie-Talkie Set",
			description = "A pair of encrypted walkie-talkies used for coordinating the hijack team in real time.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(20, 1, 8),
		},
		{
			id = "dock03_ev12",
			name = "Forged DOT Inspection Sticker",
			description = "A counterfeit Department of Transportation inspection sticker ready to be applied to the stolen trailer.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 2, 10),
		},
		{
			id = "dock03_ev13",
			name = "Getaway Van Keys",
			description = "Keys to a white cargo van parked outside the yard, used to transport repackaged stolen goods.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(22, 0, 20),
		},
		{
			id = "dock03_ev14",
			name = "Shipping Label Printer",
			description = "A label printer loaded with pre-addressed labels for distributing stolen merchandise to buyers.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 2, 16),
		},
	}
end

return module
