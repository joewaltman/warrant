--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for Elm Heights Case 03 (Missing on Maple Lane)
-- Total possible points: 34 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		-- Living room evidence (room at 0,0,0 size 16x12x14)
		{
			id = "elm03_overturned_table",
			name = "Overturned Coffee Table",
			description = "The coffee table is flipped on its side. Signs of a struggle.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-2, 0.5, 3),
		},
		{
			id = "elm03_phone",
			name = "Cracked Cell Phone",
			description = "A cracked smartphone on the floor, screen showing an unsent text: 'Someone is here'.",
			pointValue = 4,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(4, 0.5, -1),
		},
		{
			id = "elm03_blood_smear",
			name = "Small Blood Smear",
			description = "A faint blood smear on the door frame leading to the hallway.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(0, 4, -6),
		},

		-- Kitchen evidence (room at 16,0,0 size 14x12x14)
		{
			id = "elm03_open_back_door",
			name = "Unlocked Back Door",
			description = "The kitchen back door is unlocked and slightly ajar. No forced entry.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(22, 3, -4),
		},
		{
			id = "elm03_medication",
			name = "Prescription Medication",
			description = "An anxiety medication bottle on the counter, prescribed to the missing person.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(14, 3, 3),
		},

		-- Master bedroom evidence (room at 0,0,-16 size 16x12x14)
		{
			id = "elm03_journal",
			name = "Personal Journal",
			description = "A journal with the last entry reading: 'I think they've been watching the house.'",
			pointValue = 5,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(-2, 3, -18),
		},
		{
			id = "elm03_packed_bag",
			name = "Half-Packed Duffel Bag",
			description = "A bag with clothes hastily stuffed in, found on the bed. Never finished packing.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(3, 3, -15),
		},

		-- Child's bedroom evidence (room at 16,0,-16 size 12x12x12)
		{
			id = "elm03_window_unlocked",
			name = "Unlocked Window",
			description = "The bedroom window is unlatched with scuff marks on the outer sill.",
			pointValue = 3,
			discoveryMethod = "interact" :: "interact",
			position = Vector3.new(20, 4, -20),
		},
		{
			id = "elm03_fiber",
			name = "Carpet Fiber Sample",
			description = "Foreign carpet fibers near the window, not matching the house carpet.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(17, 0.5, -18),
		},

		-- Garage evidence (room at -16,0,0 size 16x12x14)
		{
			id = "elm03_tire_tracks",
			name = "Fresh Tire Tracks",
			description = "Tire marks on the garage floor from a vehicle not matching the family car.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(-16, 0.5, 3),
		},

		-- Exterior evidence
		{
			id = "elm03_surveillance",
			name = "Doorbell Camera Footage",
			description = "Doorbell camera shows an unfamiliar sedan idling across the street at 9:30 PM.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(0, 5, 15),
		},
	}
end

return module
