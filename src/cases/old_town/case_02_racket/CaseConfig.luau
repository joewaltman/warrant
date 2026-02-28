--!strict
-- CaseConfig | WARRANT: Case Closed
-- Case 02: The Racket — Racketeering operation in an Old Town social club

local module = {}

function module.getData()
	return {
		caseId = "old_02",
		caseName = "The Racket",
		district = "Old Town",
		crimeType = "Racketeering",
		difficulty = 3,
		xpReward = 400,
	}
end

function module.getLayout()
	return {
		district = "Old Town",
		origin = Vector3.new(0, 0, 0),
		buildingName = "Doyle Social Club",
		rooms = {
			{ name = "Bar", position = Vector3.new(0, 0, 0), size = Vector3.new(14, 10, 12) },
			{ name = "Back Room", position = Vector3.new(14, 0, 0), size = Vector3.new(10, 10, 12) },
			{ name = "Meeting Room", position = Vector3.new(14, 0, 12), size = Vector3.new(10, 10, 10) },
			{ name = "Storage", position = Vector3.new(0, 0, 12), size = Vector3.new(14, 10, 10) },
			{ name = "Rooftop", position = Vector3.new(0, 10, 0), size = Vector3.new(24, 6, 22) },
		},
		doors = {
			{ position = Vector3.new(0, 0, 6), size = Vector3.new(4, 7, 1), name = "Front Entrance" },
			{ position = Vector3.new(14, 0, 6), size = Vector3.new(4, 7, 1), name = "Bar to Back Room" },
			{ position = Vector3.new(19, 0, 12), size = Vector3.new(4, 7, 1), name = "Back Room to Meeting Room" },
			{ position = Vector3.new(14, 0, 16), size = Vector3.new(4, 7, 1), name = "Storage Entrance" },
			{ position = Vector3.new(12, 10, 5), size = Vector3.new(4, 7, 1), name = "Rooftop Access" },
			{ position = Vector3.new(24, 0, 6), size = Vector3.new(4, 7, 1), name = "Rear Exit" },
		},
		props = {
			-- Bar (0,0,0) 14x10x12
			{ name = "BarCounter", position = Vector3.new(2, 0, 2), preset = "counter" },
			{ name = "BarCouch1", position = Vector3.new(8, 0, 2), preset = "couch" },
			{ name = "BarCouch2", position = Vector3.new(8, 0, 8), preset = "couch" },
			{ name = "BarLamp1", position = Vector3.new(1, 0, 10), preset = "lamp" },
			{ name = "BarLamp2", position = Vector3.new(12, 0, 10), preset = "lamp" },
			{ name = "BarCover", position = Vector3.new(5, 0, 5), preset = "cover_low" },
			-- Back Room (14,0,0) 10x10x12
			{ name = "BackRoomTable", position = Vector3.new(18, 0, 5), preset = "table_round" },
			{ name = "BackRoomChair1", position = Vector3.new(16, 0, 3), preset = "chair" },
			{ name = "BackRoomChair2", position = Vector3.new(20, 0, 3), preset = "chair" },
			{ name = "BackRoomChair3", position = Vector3.new(16, 0, 7), preset = "chair" },
			{ name = "BackRoomChair4", position = Vector3.new(20, 0, 7), preset = "chair" },
			{ name = "BackRoomShelf", position = Vector3.new(22, 0, 10), preset = "shelf" },
			-- Meeting Room (14,0,12) 10x10x10
			{ name = "MeetingDesk", position = Vector3.new(18, 0, 15), preset = "desk" },
			{ name = "MeetingChair1", position = Vector3.new(16, 0, 14), preset = "chair" },
			{ name = "MeetingChair2", position = Vector3.new(20, 0, 14), preset = "chair" },
			{ name = "MeetingCabinet", position = Vector3.new(22, 0, 20), preset = "filing_cabinet" },
			{ name = "MeetingSafe", position = Vector3.new(15, 0, 20), preset = "safe" },
			-- Storage (0,0,12) 14x10x10
			{ name = "StorageCrate1", position = Vector3.new(2, 0, 14), preset = "crate" },
			{ name = "StorageCrate2", position = Vector3.new(5, 0, 14), preset = "crate" },
			{ name = "StorageCrate3", position = Vector3.new(8, 0, 14), preset = "crate" },
			{ name = "StorageBarrel1", position = Vector3.new(2, 0, 18), preset = "barrel" },
			{ name = "StorageBarrel2", position = Vector3.new(5, 0, 18), preset = "barrel" },
			{ name = "StorageShelf", position = Vector3.new(11, 0, 19), preset = "shelf" },
			-- Rooftop (0,10,0) 24x6x22
			{ name = "RooftopCover1", position = Vector3.new(4, 10, 4), preset = "cover_low" },
			{ name = "RooftopCover2", position = Vector3.new(18, 10, 16), preset = "cover_low" },
			{ name = "RooftopCrate", position = Vector3.new(20, 10, 3), preset = "crate" },
		},
	}
end

return module
