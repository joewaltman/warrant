--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Chop Shop
-- Total possible points: 40 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "dock04_ev01",
			name = "Stripped Vehicle Frame",
			description = "The bare chassis of a late-model sedan with its VIN plate pried off, sitting on jack stands.",
			pointValue = 4,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(6, 0, 6),
		},
		{
			id = "dock04_ev02",
			name = "VIN Plate Collection",
			description = "A drawer full of removed Vehicle Identification Number plates from at least a dozen different cars.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(16, 2, 4),
		},
		{
			id = "dock04_ev03",
			name = "Stolen Parts Inventory",
			description = "A spiral notebook cataloging stripped parts with make, model, year, and resale prices.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(4, 3, 16),
		},
		{
			id = "dock04_ev04",
			name = "Key Programmer Device",
			description = "An OBD-II key programming tool used to create new ignition keys for stolen vehicles.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(18, 2, 8),
		},
		{
			id = "dock04_ev05",
			name = "Freshly Painted Bumpers",
			description = "Three bumpers drying in the paint booth, repainted to disguise their origin from stolen vehicles.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 1, 18),
		},
		{
			id = "dock04_ev06",
			name = "Counterfeit Title Documents",
			description = "Blank vehicle title certificates from multiple states, ready to be filled out for laundered cars.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(8, 3, 18),
		},
		{
			id = "dock04_ev07",
			name = "Slim Jim and Lock Pick Set",
			description = "A professional auto theft kit including slim jims, lock picks, and a steering wheel club cutter.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(2, 1, 4),
		},
		{
			id = "dock04_ev08",
			name = "Airbag Stash",
			description = "A shelf stacked with airbags removed from stolen vehicles, each worth hundreds on the black market.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(22, 3, 2),
		},
		{
			id = "dock04_ev09",
			name = "Customer Order Texts",
			description = "A phone with text messages requesting specific vehicle makes and models to be 'sourced' by the crew.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(2, 3, 20),
		},
		{
			id = "dock04_ev10",
			name = "Hidden VIN Stamp Tool",
			description = "A metal stamping kit for re-stamping new VIN numbers onto stolen vehicle frames.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(10, 0, 2),
		},
		{
			id = "dock04_ev11",
			name = "Paint Mixing Records",
			description = "Detailed records matching factory paint codes to stolen vehicles being repainted for resale.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(20, 2, 16),
		},
		{
			id = "dock04_ev12",
			name = "Catalytic Converter Pile",
			description = "A stack of catalytic converters cut from underneath stolen vehicles, valuable for their precious metals.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(14, 0, 10),
		},
		{
			id = "dock04_ev13",
			name = "Garage Security Feed",
			description = "A DVR connected to interior cameras showing the crew stripping a vehicle in fast motion overnight.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(6, 4, 14),
		},
		{
			id = "dock04_ev14",
			name = "Tow Truck Dispatch Log",
			description = "A logbook from a tow truck recording late-night pickups at residential addresses with no corresponding service calls.",
			pointValue = 2,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(10, 3, 22),
		},
	}
end

return module
