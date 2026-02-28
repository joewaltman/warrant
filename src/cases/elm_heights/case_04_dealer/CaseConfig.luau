--!strict
-- CaseConfig | WARRANT: Case Closed
-- Elm Heights Case 04 - The Corner Dealer
-- Difficulty 1 (Rookie), 4 suspects, 12 evidence items (35 pts max)

local module = {}

function module.getData()
	return {
		caseId = "elm_04",
		caseName = "The Corner Dealer",
		district = "Elm Heights",
		crimeType = "Drug Possession",
		difficulty = 1,
		xpReward = 150,
	}
end

-- Programmatic layout definition for the case building
-- Used by LayoutBuilder to construct the scene from Parts
function module.getLayout()
	return {
		district = "Elm Heights",
		origin = Vector3.new(0, 0, 0),
		buildingName = "QuikMart Convenience Store",
		rooms = {
			{
				name = "Shop",
				position = Vector3.new(0, 0, 0),
				size = Vector3.new(12, 10, 10),
			},
			{
				name = "BackRoom",
				position = Vector3.new(0, 0, -12),
				size = Vector3.new(10, 10, 10),
			},
			{
				name = "Hallway",
				position = Vector3.new(6, 0, -6),
				size = Vector3.new(4, 10, 8),
			},
			{
				name = "UpstairsStudio",
				position = Vector3.new(0, 10, -12),
				size = Vector3.new(12, 10, 10),
			},
		},
		doors = {
			{ position = Vector3.new(0, 0, 5), size = Vector3.new(4, 7, 1), name = "StoreFront" },
			{ position = Vector3.new(0, 0, -6), size = Vector3.new(4, 7, 1), name = "BackRoomDoor" },
			{ position = Vector3.new(6, 0, -10), size = Vector3.new(1, 7, 4), name = "HallwayDoor" },
			{ position = Vector3.new(-4, 10, -12), size = Vector3.new(4, 7, 1), name = "StudioDoor" },
		},
		props = {
			-- Shop props (room at 0,0,0 size 12x10x10)
			{ name = "ShopCounter", position = Vector3.new(5, 0, 2), preset = "counter" },
			{ name = "ShopShelf1", position = Vector3.new(1, 0, 7), preset = "shelf" },
			{ name = "ShopShelf2", position = Vector3.new(9, 0, 7), preset = "shelf" },
			{ name = "ShopCover", position = Vector3.new(3, 0, 5), preset = "cover_low" },
			-- BackRoom props (room at 0,0,-12 size 10x10x10)
			{ name = "BackCrate1", position = Vector3.new(2, 0, -10), preset = "crate" },
			{ name = "BackCrate2", position = Vector3.new(4, 0, -10), preset = "crate" },
			{ name = "BackSafe", position = Vector3.new(7, 0, -5), preset = "safe" },
			{ name = "BackShelf", position = Vector3.new(1, 0, -5), preset = "shelf" },
			-- Hallway props (room at 6,0,-6 size 4x10x8)
			{ name = "HallwayLamp", position = Vector3.new(7, 0, -8), preset = "lamp" },
			-- UpstairsStudio props (room at 0,10,-12 size 12x10x10)
			{ name = "StudioBed", position = Vector3.new(2, 10, -10), preset = "bed" },
			{ name = "StudioDesk", position = Vector3.new(8, 10, -8), preset = "desk" },
			{ name = "StudioTV", position = Vector3.new(2, 10, -5), preset = "tv" },
			{ name = "StudioCouch", position = Vector3.new(6, 10, -5), preset = "couch" },
		},
	}
end

return module
