--!strict
-- EvidenceMap | WARRANT: Case Closed
-- Evidence definitions for The Don's Ledger
-- Total possible points: 48 (enough to reach Tier 4 Airtight at 30)

local module = {}

function module.getEvidence()
	return {
		{
			id = "don_e01",
			name = "The Don's Ledger",
			description = "A leather-bound ledger detailing twenty years of payoffs, rackets, and territorial agreements.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(14, -11, 12),
		},
		{
			id = "don_e02",
			name = "Heroin Bricks",
			description = "Twelve bricks of uncut heroin hidden inside a casket in the viewing room.",
			pointValue = 4,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(22, 1, 6),
		},
		{
			id = "don_e03",
			name = "Money Counting Machine",
			description = "A high-speed bill counter bolted to a table in the hidden basement.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(12, -11, 10),
		},
		{
			id = "don_e04",
			name = "Wiretap Transcripts",
			description = "FBI wiretap transcripts that were stolen from a federal evidence locker.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(6, 1, 18),
		},
		{
			id = "don_e05",
			name = "Hit List",
			description = "A coded list of names with three already crossed out, matching recent unsolved murders.",
			pointValue = 4,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(20, -11, 16),
		},
		{
			id = "don_e06",
			name = "Concealed Wall Safe",
			description = "A safe hidden behind a painting in the office containing bearer bonds.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(4, 2, 22),
		},
		{
			id = "don_e07",
			name = "Embalming Fluid Containers",
			description = "Modified embalming fluid containers used to smuggle liquid narcotics.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(20, 1, 18),
		},
		{
			id = "don_e08",
			name = "Corrupt Judge's Letters",
			description = "Personal letters from a sitting judge discussing case-fixing in exchange for favors.",
			pointValue = 3,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(10, 1, 20),
		},
		{
			id = "don_e09",
			name = "Weapons Cache",
			description = "A crate of automatic rifles and ammunition stored in the basement corner.",
			pointValue = 3,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(22, -11, 8),
		},
		{
			id = "don_e10",
			name = "Offshore Account Records",
			description = "Bank statements from Grand Cayman accounts totaling over $4 million.",
			pointValue = 3,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(16, -11, 18),
		},
		{
			id = "don_e11",
			name = "Blood-Stained Apron",
			description = "An embalmer's apron with blood that does not match any scheduled body.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(24, 1, 22),
		},
		{
			id = "don_e12",
			name = "Falsified Death Certificates",
			description = "A stack of blank death certificates pre-signed by a complicit coroner.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(2, 1, 16),
		},
		{
			id = "don_e13",
			name = "Surveillance Jammer",
			description = "An electronic device designed to disrupt police listening devices.",
			pointValue = 2,
			discoveryMethod = "scan" :: "scan",
			position = Vector3.new(10, -11, 8),
		},
		{
			id = "don_e14",
			name = "Loyalty Oath Document",
			description = "A blood-signed oath of loyalty to the Bianchi family, listing all made members.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(8, 1, 4),
		},
		{
			id = "don_e15",
			name = "Victim's Ring",
			description = "A signet ring belonging to a rival boss reported missing six months ago.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(18, 1, 24),
		},
		{
			id = "don_e16",
			name = "Encrypted Radio",
			description = "A modified two-way radio using encrypted frequencies to coordinate operations.",
			pointValue = 2,
			discoveryMethod = "proximity" :: "proximity",
			position = Vector3.new(20, -11, 12),
		},
		{
			id = "don_e17",
			name = "Blackmail Photographs",
			description = "Compromising photographs of city officials taken at Bianchi-hosted events.",
			pointValue = 2,
			discoveryMethod = "photograph" :: "photograph",
			position = Vector3.new(12, 1, 2),
		},
	}
end

return module
