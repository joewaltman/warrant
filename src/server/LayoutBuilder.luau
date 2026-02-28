--!strict
-- LayoutBuilder | WARRANT: Case Closed
-- Constructs case buildings programmatically from Part definitions
-- Supports district themes, props, room lighting, and exterior shells

local CollectionService = game:GetService("CollectionService")

local DistrictThemes = require(script.Parent.DistrictThemes)

local LayoutBuilder = {}

local WALL_THICKNESS = 1
local FLOOR_THICKNESS = 1
local EXTERIOR_MARGIN = 2
local DOOR_COLOR = Color3.fromRGB(100, 70, 40)

-- Fallback colors if no theme
local DEFAULT_WALL_COLOR = Color3.fromRGB(180, 170, 155)
local DEFAULT_FLOOR_COLOR = Color3.fromRGB(120, 100, 80)
local DEFAULT_CEILING_COLOR = Color3.fromRGB(200, 200, 200)

------------------------------------------------------------------------
-- PROP PRESETS
------------------------------------------------------------------------
type PropPreset = {
	size: Vector3,
	color: Color3,
	material: Enum.Material,
	shape: Enum.PartType?,
	tags: { string }?,
}

local PROP_PRESETS: { [string]: PropPreset } = {
	desk = { size = Vector3.new(5, 3, 3), color = Color3.fromRGB(120, 80, 50), material = Enum.Material.Wood },
	chair = { size = Vector3.new(2, 3, 2), color = Color3.fromRGB(60, 60, 65), material = Enum.Material.SmoothPlastic },
	table_round = { size = Vector3.new(4, 3, 4), color = Color3.fromRGB(120, 80, 50), material = Enum.Material.Wood },
	shelf = { size = Vector3.new(6, 5, 1), color = Color3.fromRGB(110, 75, 45), material = Enum.Material.Wood },
	crate = { size = Vector3.new(3, 3, 3), color = Color3.fromRGB(170, 140, 90), material = Enum.Material.Wood },
	barrel = { size = Vector3.new(2, 3, 2), color = Color3.fromRGB(130, 130, 135), material = Enum.Material.Metal, shape = Enum.PartType.Cylinder },
	computer = { size = Vector3.new(1.5, 1, 1), color = Color3.fromRGB(40, 40, 45), material = Enum.Material.SmoothPlastic },
	filing_cabinet = { size = Vector3.new(2, 4, 2), color = Color3.fromRGB(130, 130, 135), material = Enum.Material.Metal },
	couch = { size = Vector3.new(6, 3, 3), color = Color3.fromRGB(120, 40, 40), material = Enum.Material.Fabric },
	bed = { size = Vector3.new(5, 2, 6), color = Color3.fromRGB(230, 230, 235), material = Enum.Material.Fabric },
	counter = { size = Vector3.new(8, 3, 2), color = Color3.fromRGB(220, 220, 225), material = Enum.Material.Granite },
	safe = { size = Vector3.new(2, 3, 2), color = Color3.fromRGB(70, 70, 75), material = Enum.Material.Metal },
	tv = { size = Vector3.new(3, 2, 0.3), color = Color3.fromRGB(20, 20, 25), material = Enum.Material.SmoothPlastic },
	lamp = { size = Vector3.new(1, 4, 1), color = Color3.fromRGB(230, 200, 140), material = Enum.Material.SmoothPlastic },
	cover_low = { size = Vector3.new(4, 3, 2), color = Color3.fromRGB(100, 100, 105), material = Enum.Material.Concrete, tags = { "Cover" } },
	cover_tall = { size = Vector3.new(2, 5, 2), color = Color3.fromRGB(100, 100, 105), material = Enum.Material.Concrete, tags = { "Cover" } },

	-- Bathroom / Utility
	bathtub = { size = Vector3.new(6, 2, 3), color = Color3.fromRGB(240, 240, 245), material = Enum.Material.Marble },
	toilet = { size = Vector3.new(2, 2.5, 2), color = Color3.fromRGB(240, 240, 245), material = Enum.Material.SmoothPlastic },
	sink = { size = Vector3.new(2, 3, 1.5), color = Color3.fromRGB(240, 240, 245), material = Enum.Material.SmoothPlastic },
	washer_dryer = { size = Vector3.new(3, 3, 3), color = Color3.fromRGB(220, 220, 225), material = Enum.Material.Metal },

	-- Kitchen
	fridge = { size = Vector3.new(3, 6, 3), color = Color3.fromRGB(210, 210, 215), material = Enum.Material.Metal },
	stove = { size = Vector3.new(3, 3, 3), color = Color3.fromRGB(50, 50, 55), material = Enum.Material.Metal },

	-- Decor
	bookshelf = { size = Vector3.new(4, 6, 1.5), color = Color3.fromRGB(100, 65, 35), material = Enum.Material.Wood },
	potted_plant = { size = Vector3.new(1.5, 3, 1.5), color = Color3.fromRGB(60, 120, 40), material = Enum.Material.Grass },
	trash_can = { size = Vector3.new(1.5, 2, 1.5), color = Color3.fromRGB(80, 80, 85), material = Enum.Material.Metal, shape = Enum.PartType.Cylinder },
	rug = { size = Vector3.new(6, 0.2, 4), color = Color3.fromRGB(140, 60, 60), material = Enum.Material.Fabric },
	picture_frame = { size = Vector3.new(2, 2, 0.2), color = Color3.fromRGB(120, 80, 40), material = Enum.Material.Wood },
	mirror = { size = Vector3.new(2, 3, 0.2), color = Color3.fromRGB(200, 220, 240), material = Enum.Material.Glass },
	window_frame = { size = Vector3.new(4, 4, 0.3), color = Color3.fromRGB(180, 200, 220), material = Enum.Material.Glass },

	-- Commercial
	vending_machine = { size = Vector3.new(3, 6, 2), color = Color3.fromRGB(200, 50, 50), material = Enum.Material.Metal },
	register = { size = Vector3.new(2, 1.5, 2), color = Color3.fromRGB(60, 60, 65), material = Enum.Material.Metal },

	-- Outdoor
	dumpster = { size = Vector3.new(5, 4, 3), color = Color3.fromRGB(60, 90, 60), material = Enum.Material.Metal },
	fire_hydrant = { size = Vector3.new(1.5, 2.5, 1.5), color = Color3.fromRGB(200, 40, 40), material = Enum.Material.Metal },
	mailbox = { size = Vector3.new(1.5, 3, 1), color = Color3.fromRGB(40, 60, 140), material = Enum.Material.Metal },
	fence_section = { size = Vector3.new(8, 4, 0.5), color = Color3.fromRGB(200, 190, 170), material = Enum.Material.Wood },
	streetlight = { size = Vector3.new(0.5, 12, 0.5), color = Color3.fromRGB(80, 80, 85), material = Enum.Material.Metal },
	bench = { size = Vector3.new(5, 2, 2), color = Color3.fromRGB(100, 65, 35), material = Enum.Material.Wood },
	tree = { size = Vector3.new(6, 6, 6), color = Color3.fromRGB(40, 100, 30), material = Enum.Material.Grass, shape = Enum.PartType.Ball },
}

------------------------------------------------------------------------
-- TYPE DEFINITIONS
------------------------------------------------------------------------
export type PropDef = {
	name: string,
	position: Vector3,
	size: Vector3?,
	color: Color3?,
	material: Enum.Material?,
	shape: Enum.PartType?,
	rotation: Vector3?,
	preset: string?,
	tags: { string }?,
}

export type RoomDef = {
	name: string,
	position: Vector3,
	size: Vector3,
	wallColor: Color3?,
	wallMaterial: Enum.Material?,
	floorColor: Color3?,
	floorMaterial: Enum.Material?,
	lighting: { brightness: number, color: Color3, range: number }?,
}

export type DoorDef = {
	position: Vector3,
	size: Vector3,
	name: string,
}

export type LayoutDef = {
	origin: Vector3,
	buildingName: string,
	district: string?,
	rooms: { RoomDef },
	doors: { DoorDef }?,
	props: { PropDef }?,
}

------------------------------------------------------------------------
-- PART CREATION
------------------------------------------------------------------------
local function createPart(parent: Model, name: string, position: Vector3, size: Vector3, color: Color3, material: Enum.Material?, transparency: number?): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Anchored = true
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.Transparency = transparency or 0
	part.Parent = parent
	return part
end

------------------------------------------------------------------------
-- ROOM BUILDING (with theme support)
------------------------------------------------------------------------
local function buildRoom(parent: Model, room: RoomDef, origin: Vector3, theme: DistrictThemes.DistrictTheme?)
	local pos = origin + room.position
	local sx, sy, sz = room.size.X, room.size.Y, room.size.Z

	-- Determine materials/colors: room override > theme > defaults
	local wallColor = room.wallColor or (if theme then theme.wallColor else DEFAULT_WALL_COLOR)
	local wallMat = room.wallMaterial or (if theme then theme.wallMaterial else Enum.Material.SmoothPlastic)
	local floorColor = room.floorColor or (if theme then theme.floorColor else DEFAULT_FLOOR_COLOR)
	local floorMat = room.floorMaterial or (if theme then theme.floorMaterial else Enum.Material.SmoothPlastic)
	local ceilingColor = if theme then theme.ceilingColor else DEFAULT_CEILING_COLOR
	local ceilingMat = if theme then theme.ceilingMaterial else Enum.Material.SmoothPlastic

	-- Floor
	createPart(parent, room.name .. "_Floor",
		pos + Vector3.new(0, -FLOOR_THICKNESS / 2, 0),
		Vector3.new(sx, FLOOR_THICKNESS, sz),
		floorColor, floorMat)

	-- Ceiling
	createPart(parent, room.name .. "_Ceiling",
		pos + Vector3.new(0, sy + FLOOR_THICKNESS / 2, 0),
		Vector3.new(sx, FLOOR_THICKNESS, sz),
		ceilingColor, ceilingMat)

	-- Walls (4 sides)
	-- North wall (+Z)
	createPart(parent, room.name .. "_WallN",
		pos + Vector3.new(0, sy / 2, sz / 2 + WALL_THICKNESS / 2),
		Vector3.new(sx, sy, WALL_THICKNESS),
		wallColor, wallMat)

	-- South wall (-Z)
	createPart(parent, room.name .. "_WallS",
		pos + Vector3.new(0, sy / 2, -sz / 2 - WALL_THICKNESS / 2),
		Vector3.new(sx, sy, WALL_THICKNESS),
		wallColor, wallMat)

	-- East wall (+X)
	createPart(parent, room.name .. "_WallE",
		pos + Vector3.new(sx / 2 + WALL_THICKNESS / 2, sy / 2, 0),
		Vector3.new(WALL_THICKNESS, sy, sz),
		wallColor, wallMat)

	-- West wall (-X)
	createPart(parent, room.name .. "_WallW",
		pos + Vector3.new(-sx / 2 - WALL_THICKNESS / 2, sy / 2, 0),
		Vector3.new(WALL_THICKNESS, sy, sz),
		wallColor, wallMat)

	-- Room ceiling light
	local lightBrightness = if theme then theme.lightBrightness else 1.0
	local lightColor = if theme then theme.ambientColor else Color3.fromRGB(255, 255, 255)

	if room.lighting then
		lightBrightness = room.lighting.brightness
		lightColor = room.lighting.color
	end

	local lightPart = createPart(parent, room.name .. "_Light",
		pos + Vector3.new(0, sy - 0.5, 0),
		Vector3.new(1, 0.5, 1),
		Color3.fromRGB(255, 255, 240), Enum.Material.Neon)
	lightPart.Transparency = 0.5

	local pointLight = Instance.new("PointLight")
	pointLight.Brightness = lightBrightness
	pointLight.Color = lightColor
	pointLight.Range = if room.lighting then room.lighting.range else math.max(sx, sz) * 1.2
	pointLight.Parent = lightPart
end

------------------------------------------------------------------------
-- DOOR BUILDING
------------------------------------------------------------------------
local function buildDoor(parent: Model, door: DoorDef, origin: Vector3)
	local pos = origin + door.position
	local part = createPart(parent, "Door_" .. door.name,
		pos + Vector3.new(0, door.size.Y / 2, 0),
		door.size,
		DOOR_COLOR, Enum.Material.Wood,
		0.5)
	part.CanCollide = false
	CollectionService:AddTag(part, "Door")
end

------------------------------------------------------------------------
-- PROP BUILDING
------------------------------------------------------------------------
local function buildProp(parent: Model, prop: PropDef, origin: Vector3)
	-- Resolve preset as base
	local preset: PropPreset? = if prop.preset then PROP_PRESETS[prop.preset] else nil

	local size = prop.size or (if preset then preset.size else Vector3.new(2, 2, 2))
	local color = prop.color or (if preset then preset.color else Color3.fromRGB(150, 150, 150))
	local material = prop.material or (if preset then preset.material else Enum.Material.SmoothPlastic)
	local shape = prop.shape or (if preset then preset.shape else nil)

	local pos = origin + prop.position
	local part = createPart(parent, "Prop_" .. prop.name,
		pos + Vector3.new(0, size.Y / 2, 0),
		size, color, material)

	-- Apply shape
	if shape then
		part.Shape = shape
	end

	-- Apply rotation
	if prop.rotation then
		part.CFrame = CFrame.new(part.Position) * CFrame.Angles(
			math.rad(prop.rotation.X),
			math.rad(prop.rotation.Y),
			math.rad(prop.rotation.Z)
		)
	end

	-- Apply tags
	CollectionService:AddTag(part, "CivilianObject")

	local tags = prop.tags or (if preset then preset.tags else nil)
	if tags then
		for _, tag in tags do
			CollectionService:AddTag(part, tag)
		end
	end

	-- Lamp preset adds a PointLight
	if prop.preset == "lamp" then
		local light = Instance.new("PointLight")
		light.Brightness = 0.8
		light.Color = Color3.fromRGB(255, 230, 180)
		light.Range = 16
		light.Parent = part
	end

	-- Streetlight preset adds a PointLight at the top
	if prop.preset == "streetlight" then
		local light = Instance.new("PointLight")
		light.Brightness = 1.2
		light.Color = Color3.fromRGB(255, 240, 200)
		light.Range = 30
		light.Parent = part
	end

	-- Tree preset adds a brown trunk child part
	if prop.preset == "tree" then
		local trunk = Instance.new("Part")
		trunk.Name = "Trunk"
		trunk.Size = Vector3.new(1, 6, 1)
		trunk.CFrame = CFrame.new(part.Position - Vector3.new(0, size.Y / 2 + 3, 0))
		trunk.Anchored = true
		trunk.Color = Color3.fromRGB(100, 65, 35)
		trunk.Material = Enum.Material.Wood
		trunk.Parent = parent
		CollectionService:AddTag(trunk, "CivilianObject")
	end
end

------------------------------------------------------------------------
-- EXTERIOR SHELL
------------------------------------------------------------------------
local function buildExterior(parent: Model, rooms: { RoomDef }, origin: Vector3, theme: DistrictThemes.DistrictTheme?)
	if #rooms == 0 then
		return
	end

	-- Compute bounding box of all rooms
	local minX, minY, minZ = math.huge, math.huge, math.huge
	local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

	for _, room in rooms do
		local rp = room.position
		local rs = room.size
		local halfX, halfZ = rs.X / 2, rs.Z / 2
		minX = math.min(minX, rp.X - halfX)
		minZ = math.min(minZ, rp.Z - halfZ)
		minY = math.min(minY, rp.Y)
		maxX = math.max(maxX, rp.X + halfX)
		maxZ = math.max(maxZ, rp.Z + halfZ)
		maxY = math.max(maxY, rp.Y + rs.Y)
	end

	-- Add margin
	minX -= EXTERIOR_MARGIN
	minZ -= EXTERIOR_MARGIN
	maxX += EXTERIOR_MARGIN
	maxZ += EXTERIOR_MARGIN
	maxY += EXTERIOR_MARGIN

	local extColor = if theme then theme.exteriorColor else Color3.fromRGB(140, 130, 120)
	local extMat = if theme then theme.exteriorMaterial else Enum.Material.Brick

	local sizeX = maxX - minX
	local sizeZ = maxZ - minZ
	local sizeY = maxY - minY
	local centerX = origin.X + (minX + maxX) / 2
	local centerZ = origin.Z + (minZ + maxZ) / 2
	local centerY = origin.Y + minY + sizeY / 2

	-- North exterior wall (+Z)
	createPart(parent, "Exterior_N",
		Vector3.new(centerX, centerY, origin.Z + maxZ + WALL_THICKNESS / 2),
		Vector3.new(sizeX + WALL_THICKNESS * 2, sizeY, WALL_THICKNESS),
		extColor, extMat)

	-- South exterior wall (-Z)
	createPart(parent, "Exterior_S",
		Vector3.new(centerX, centerY, origin.Z + minZ - WALL_THICKNESS / 2),
		Vector3.new(sizeX + WALL_THICKNESS * 2, sizeY, WALL_THICKNESS),
		extColor, extMat)

	-- East exterior wall (+X)
	createPart(parent, "Exterior_E",
		Vector3.new(origin.X + maxX + WALL_THICKNESS / 2, centerY, centerZ),
		Vector3.new(WALL_THICKNESS, sizeY, sizeZ),
		extColor, extMat)

	-- West exterior wall (-X)
	createPart(parent, "Exterior_W",
		Vector3.new(origin.X + minX - WALL_THICKNESS / 2, centerY, centerZ),
		Vector3.new(WALL_THICKNESS, sizeY, sizeZ),
		extColor, extMat)
end

------------------------------------------------------------------------
-- MAIN BUILD
------------------------------------------------------------------------
function LayoutBuilder.build(layoutDef: LayoutDef): Model
	local model = Instance.new("Model")
	model.Name = layoutDef.buildingName

	local origin = layoutDef.origin

	-- Resolve theme
	local theme: DistrictThemes.DistrictTheme? = nil
	if layoutDef.district then
		theme = DistrictThemes.getTheme(layoutDef.district)
	end

	-- Build all rooms
	for _, room in layoutDef.rooms do
		buildRoom(model, room, origin, theme)
	end

	-- Build doors
	if layoutDef.doors then
		for _, door in layoutDef.doors do
			buildDoor(model, door, origin)
		end
	end

	-- Build props
	if layoutDef.props then
		for _, prop in layoutDef.props do
			buildProp(model, prop, origin)
		end
	end

	-- Build exterior shell
	buildExterior(model, layoutDef.rooms, origin, theme)

	-- Ground plane
	local groundColor = if theme then theme.groundColor else Color3.fromRGB(80, 130, 60)
	local groundMat = if theme then theme.groundMaterial else Enum.Material.Grass
	createPart(model, "Ground",
		origin + Vector3.new(0, -0.5, 0),
		Vector3.new(120, 1, 120),
		groundColor, groundMat)

	-- Set primary part
	local firstFloor = model:FindFirstChild("LivingRoom_Floor")
		or model:FindFirstChild("Lobby_Floor")
		or model:FindFirstChild("MainFloor_Floor")
		or model:FindFirstChildWhichIsA("Part")
	if firstFloor and firstFloor:IsA("BasePart") then
		model.PrimaryPart = firstFloor :: Part
	end

	return model
end

return LayoutBuilder
