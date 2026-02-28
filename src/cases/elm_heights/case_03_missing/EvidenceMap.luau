--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 03 (Missing on Maple Lane)
-- Total possible points: 34 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Living room evidence
		{
			id = "elm03_overturned_table",
			name = "Overturned Coffee Table",
			description = "The coffee table is flipped on its side. Signs of a struggle.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-4, 1, 6),
		},
		{
			id = "elm03_phone",
			name = "Cracked Cell Phone",
			description = "A cracked smartphone on the floor, screen showing an unsent text: 'Someone is here'.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(8, 1, -2),
		},
		{
			id = "elm03_blood_smear",
			name = "Small Blood Smear",
			description = "A faint blood smear on the door frame leading to the hallway.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 8, -12),
		},

		-- Kitchen evidence
		{
			id = "elm03_open_back_door",
			name = "Unlocked Back Door",
			description = "The kitchen back door is unlocked and slightly ajar. No forced entry.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(44, 6, -8),
		},
		{
			id = "elm03_medication",
			name = "Prescription Medication",
			description = "An anxiety medication bottle on the counter, prescribed to the missing person.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(28, 6, 6),
		},

		-- Master bedroom evidence
		{
			id = "elm03_journal",
			name = "Personal Journal",
			description = "A journal with the last entry reading: 'I think they've been watching the house.'",
			pointValue = 5,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-4, 6, -36),
		},
		{
			id = "elm03_packed_bag",
			name = "Half-Packed Duffel Bag",
			description = "A bag with clothes hastily stuffed in, found on the bed. Never finished packing.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(6, 6, -30),
		},

		-- Child's bedroom evidence
		{
			id = "elm03_window_unlocked",
			name = "Unlocked Window",
			description = "The bedroom window is unlatched with scuff marks on the outer sill.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(40, 8, -40),
		},
		{
			id = "elm03_fiber",
			name = "Carpet Fiber Sample",
			description = "Foreign carpet fibers near the window, not matching the house carpet.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(34, 1, -36),
		},

		-- Garage evidence
		{
			id = "elm03_tire_tracks",
			name = "Fresh Tire Tracks",
			description = "Tire marks on the garage floor from a vehicle not matching the family car.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-32, 1, 6),
		},

		-- Exterior evidence
		{
			id = "elm03_surveillance",
			name = "Doorbell Camera Footage",
			description = "Doorbell camera shows an unfamiliar sedan idling across the street at 9:30 PM.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(0, 10, 30),
		},
	}
end

return module
