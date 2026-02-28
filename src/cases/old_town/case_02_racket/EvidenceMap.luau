--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Racket
-- Total possible points: 44 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "racket_e01",
			name = "Protection Ledger",
			description = "A handwritten ledger listing weekly payments from thirty local businesses.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(18, 1, 15),
		},
		{
			id = "racket_e02",
			name = "Stack of Counterfeit Bills",
			description = "Banded stacks of counterfeit twenties hidden under the bar counter.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(5, 0, 3),
		},
		{
			id = "racket_e03",
			name = "Extortion Letters",
			description = "Carbon copies of threatening letters sent to shop owners on Mulberry Street.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(16, 1, 4),
		},
		{
			id = "racket_e04",
			name = "Baseball Bat with Blood",
			description = "A wooden bat with dried blood stains propped behind the storage door.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(2, 1, 14),
		},
		{
			id = "racket_e05",
			name = "Wiretap Recording Device",
			description = "A concealed recording device taped under the meeting room table.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(19, 0, 17),
		},
		{
			id = "racket_e06",
			name = "Victim's Signed Statement",
			description = "A coerced statement from a deli owner withdrawing his police complaint.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(20, 1, 8),
		},
		{
			id = "racket_e07",
			name = "Envelope of Cash",
			description = "An envelope marked 'Flannery's - March' containing $1,500.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 1, 2),
		},
		{
			id = "racket_e08",
			name = "Lockbox Key",
			description = "A small key on a chain that fits the floor safe in the back room.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(12, 11, 10),
		},
		{
			id = "racket_e09",
			name = "Forged Business License",
			description = "A stack of blank forged business licenses with official city seals.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(6, 1, 18),
		},
		{
			id = "racket_e10",
			name = "Coded Phone List",
			description = "A list of phone numbers with names replaced by nicknames and symbols.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(15, 1, 2),
		},
		{
			id = "racket_e11",
			name = "Bruised Knuckle Wraps",
			description = "Blood-stained hand wraps discarded in the storage room trash.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(10, 0, 16),
		},
		{
			id = "racket_e12",
			name = "Union Dues Skim Records",
			description = "Documents showing systematic skimming from the dockworkers' union fund.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(17, 1, 20),
		},
		{
			id = "racket_e13",
			name = "Pistol in Cigar Box",
			description = "A snub-nose .38 hidden in a cigar box behind the bar mirror.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(3, 2, 1),
		},
		{
			id = "racket_e14",
			name = "Surveillance Photos",
			description = "Photographs of rival gang members taken from the rooftop vantage point.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(8, 11, 15),
		},
		{
			id = "racket_e15",
			name = "Payoff Schedule",
			description = "A calendar with dates and dollar amounts for police payoffs.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(22, 1, 10),
		},
		{
			id = "racket_e16",
			name = "Stolen Goods Manifest",
			description = "An inventory list of hijacked electronics stored in the back of the club.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(4, 0, 20),
		},
	}
end

return module
