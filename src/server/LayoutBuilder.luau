--!strict
-- LayoutBuilder | WARRANT: Case Closed
-- Constructs case buildings programmatically from Part definitions
-- Used when no pre-built Studio model exists in ServerStorage

local LayoutBuilder = {}

local WALL_THICKNESS = 1
local FLOOR_THICKNESS = 1
local WALL_COLOR = Color3.fromRGB(180, 170, 155)
local FLOOR_COLOR = Color3.fromRGB(120, 100, 80)
local CEILING_COLOR = Color3.fromRGB(200, 200, 200)
local DOOR_COLOR = Color3.fromRGB(100, 70, 40)

export type RoomDef = {
	name: string,
	position: Vector3,
	size: Vector3,
}

export type DoorDef = {
	position: Vector3,
	size: Vector3,
	name: string,
}

export type LayoutDef = {
	origin: Vector3,
	buildingName: string,
	rooms: { RoomDef },
	doors: { DoorDef }?,
}

local function createPart(parent: Model, name: string, position: Vector3, size: Vector3, color: Color3, transparency: number?): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Anchored = true
	part.Color = color
	part.Material = Enum.Material.SmoothPlastic
	part.Transparency = transparency or 0
	part.Parent = parent
	return part
end

local function buildRoom(parent: Model, room: RoomDef, origin: Vector3)
	local pos = origin + room.position
	local sx, sy, sz = room.size.X, room.size.Y, room.size.Z

	-- Floor
	createPart(parent, room.name .. "_Floor",
		pos + Vector3.new(0, -FLOOR_THICKNESS / 2, 0),
		Vector3.new(sx, FLOOR_THICKNESS, sz),
		FLOOR_COLOR)

	-- Ceiling
	createPart(parent, room.name .. "_Ceiling",
		pos + Vector3.new(0, sy + FLOOR_THICKNESS / 2, 0),
		Vector3.new(sx, FLOOR_THICKNESS, sz),
		CEILING_COLOR)

	-- Walls (4 sides)
	-- North wall (+Z)
	createPart(parent, room.name .. "_WallN",
		pos + Vector3.new(0, sy / 2, sz / 2 + WALL_THICKNESS / 2),
		Vector3.new(sx, sy, WALL_THICKNESS),
		WALL_COLOR)

	-- South wall (-Z)
	createPart(parent, room.name .. "_WallS",
		pos + Vector3.new(0, sy / 2, -sz / 2 - WALL_THICKNESS / 2),
		Vector3.new(sx, sy, WALL_THICKNESS),
		WALL_COLOR)

	-- East wall (+X)
	createPart(parent, room.name .. "_WallE",
		pos + Vector3.new(sx / 2 + WALL_THICKNESS / 2, sy / 2, 0),
		Vector3.new(WALL_THICKNESS, sy, sz),
		WALL_COLOR)

	-- West wall (-X)
	createPart(parent, room.name .. "_WallW",
		pos + Vector3.new(-sx / 2 - WALL_THICKNESS / 2, sy / 2, 0),
		Vector3.new(WALL_THICKNESS, sy, sz),
		WALL_COLOR)
end

local function buildDoor(parent: Model, door: DoorDef, origin: Vector3)
	local pos = origin + door.position
	-- Door is a transparent/semi-transparent part that marks an opening
	local part = createPart(parent, "Door_" .. door.name,
		pos + Vector3.new(0, door.size.Y / 2, 0),
		door.size,
		DOOR_COLOR,
		0.5)
	part.CanCollide = false
	part:AddTag("Door")
end

function LayoutBuilder.build(layoutDef: LayoutDef): Model
	local model = Instance.new("Model")
	model.Name = layoutDef.buildingName

	local origin = layoutDef.origin

	-- Build all rooms
	for _, room in layoutDef.rooms do
		buildRoom(model, room, origin)
	end

	-- Build doors (cut openings represented as transparent parts)
	if layoutDef.doors then
		for _, door in layoutDef.doors do
			buildDoor(model, door, origin)
		end
	end

	-- Ground plane around building
	createPart(model, "Ground",
		origin + Vector3.new(0, -0.5, 0),
		Vector3.new(80, 1, 80),
		Color3.fromRGB(80, 130, 60))

	-- Set primary part to first floor for positioning
	local firstFloor = model:FindFirstChild("LivingRoom_Floor") or model:FindFirstChildWhichIsA("Part")
	if firstFloor and firstFloor:IsA("BasePart") then
		model.PrimaryPart = firstFloor :: Part
	end

	return model
end

return LayoutBuilder
