--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Torch
-- Total possible points: 42 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "torch_e01",
			name = "Gasoline Can",
			description = "A dented red gasoline can with fingerprints on the handle.",
			pointValue = 4,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, -9, 4),
		},
		{
			id = "torch_e02",
			name = "Charred Rags",
			description = "Kerosene-soaked rags bundled near the furnace.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(8, -9, 8),
		},
		{
			id = "torch_e03",
			name = "Insurance Policy",
			description = "A recently increased fire insurance policy on the brownstone.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(5, 1, 3),
		},
		{
			id = "torch_e04",
			name = "Matchbook",
			description = "A matchbook from Sal's Tavern with a phone number scrawled inside.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(14, 1, 9),
		},
		{
			id = "torch_e05",
			name = "Burn Pattern Photograph",
			description = "V-shaped burn pattern on the parlor wall indicating accelerant use.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(2, 2, 1),
		},
		{
			id = "torch_e06",
			name = "Threatening Letter",
			description = "A letter demanding protection money, signed with a torch symbol.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, 11, 5),
		},
		{
			id = "torch_e07",
			name = "Disconnected Smoke Detector",
			description = "Smoke detector with its wires deliberately cut.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(6, 13, 6),
		},
		{
			id = "torch_e08",
			name = "Melted Timer Device",
			description = "Remains of an electrical timer wired to an ignition source.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(10, -9, 2),
		},
		{
			id = "torch_e09",
			name = "Witness Statement Note",
			description = "Handwritten note from a neighbor describing a suspicious van at 2 AM.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 1, 6),
		},
		{
			id = "torch_e10",
			name = "Fire Investigator Report",
			description = "Preliminary report classifying the fire as incendiary.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(7, 1, 10),
		},
		{
			id = "torch_e11",
			name = "Bootprint in Ash",
			description = "A size 12 bootprint pressed into wet ash near the basement window.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(1, -9, 10),
		},
		{
			id = "torch_e12",
			name = "Burner Phone",
			description = "A prepaid cell phone with three outgoing calls to the same number.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(3, 21, 3),
		},
		{
			id = "torch_e13",
			name = "Pry Marks on Window",
			description = "Fresh pry marks on the basement window frame.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, -8, 12),
		},
		{
			id = "torch_e14",
			name = "Cash Envelope",
			description = "An envelope stuffed with $2,000 in cash hidden in the attic rafters.",
			pointValue = 1,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 23, 9),
		},
		{
			id = "torch_e15",
			name = "Arsonist's Gloves",
			description = "Heat-resistant gloves discarded behind the kitchen stove.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(20, 1, 3),
		},
	}
end

return module
