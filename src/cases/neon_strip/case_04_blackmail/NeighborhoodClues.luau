--!strict
-- NeighborhoodClues | WARRANT: Case Closed
-- Neighborhood investigation clues for Neon Strip Case 04 (The Blackmailer)
-- These are hints found outside the target building before breach

local module = {}

function module.getClues()
	return {
		{
			id = "neon04_clue_doorman",
			text = "The doorman says a woman in dark glasses has been receiving large envelopes at the front desk every week. She always pays cash and never signs her real name.",
			position = Vector3.new(0, 1, 22),
			interactRange = 10,
		},
		{
			id = "neon04_clue_florist",
			text = "The florist across the street delivered flowers to the penthouse last month. The card read: 'Consider this a reminder. --E.T.' The recipient looked terrified.",
			position = Vector3.new(-25, 1, 8),
			interactRange = 10,
		},
		{
			id = "neon04_clue_bellhop",
			text = "A former bellhop was let go after he asked about the locked suite on the 14th floor. He says he heard a typewriter clacking at all hours of the night.",
			position = Vector3.new(20, 1, -12),
			interactRange = 10,
		},
		{
			id = "neon04_clue_photographer",
			text = "A street photographer recognized one of the hotel guests from a stakeout job. He was hired to follow a city councilman but was told to hand over all the photos and forget about it.",
			position = Vector3.new(-18, 1, -20),
			interactRange = 10,
		},
	}
end

return module
