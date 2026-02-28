--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Fence
-- Total possible points: 36 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "dock02_ev01",
			name = "Stolen Jewelry Display",
			description = "A tray of high-end watches and rings matching recent burglary reports from the uptown district.",
			pointValue = 4,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 3, 4),
		},
		{
			id = "dock02_ev02",
			name = "Serial Number Grinder",
			description = "An electric rotary tool used to file off serial numbers from electronics and appliances.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(16, 2, 5),
		},
		{
			id = "dock02_ev03",
			name = "Buyer Contact List",
			description = "A handwritten list of buyers with initials, phone numbers, and preferred merchandise categories.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(2, 3, 8),
		},
		{
			id = "dock02_ev04",
			name = "Stolen Laptop Stash",
			description = "Six laptops stacked in a box, all with their asset tags partially scraped off.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, -6, 6),
		},
		{
			id = "dock02_ev05",
			name = "Pawn Ticket Duplicates",
			description = "Carbon copies of pawn tickets with fictitious seller names and addresses.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(8, 3, 2),
		},
		{
			id = "dock02_ev06",
			name = "Cash Envelope Bundle",
			description = "A stack of envelopes stuffed with cash, each labeled with a date and a street name.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, -6, 2),
		},
		{
			id = "dock02_ev07",
			name = "Engraving Removal Kit",
			description = "A professional engraving pen and chemical solution used to erase personalized markings on stolen goods.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 2, 8),
		},
		{
			id = "dock02_ev08",
			name = "Surveillance Photo Printouts",
			description = "Photographs of homes and businesses with notes on security systems and entry points.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(6, -6, 10),
		},
		{
			id = "dock02_ev09",
			name = "Alley Drop-Off Duffel",
			description = "A large duffel bag in the alley containing power tools still bearing store security tags.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 0, 18),
		},
		{
			id = "dock02_ev10",
			name = "Fake Receipt Printer",
			description = "A thermal receipt printer loaded with blank receipt rolls and connected to a laptop running forgery software.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(20, 2, 3),
		},
		{
			id = "dock02_ev11",
			name = "Stolen Vehicle Key Ring",
			description = "A ring of car keys with VIN tags that match vehicles reported stolen in the last month.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(10, -6, 4),
		},
		{
			id = "dock02_ev12",
			name = "Burner Phone with Texts",
			description = "A prepaid phone with messages arranging merchandise pickups and price negotiations.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 1, 16),
		},
		{
			id = "dock02_ev13",
			name = "Hidden Floor Safe",
			description = "A floor safe beneath a rug in the workshop containing bundles of marked bills from a recent bank robbery.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(20, 0, 10),
		},
	}
end

return module
