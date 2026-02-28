--!strict
-- PrecinctBuilder | WARRANT: Case Closed
-- Constructs the precinct lobby environment where players spawn

local PrecinctBuilder = {}

local FLOOR_COLOR = Color3.fromRGB(60, 60, 70)
local WALL_COLOR = Color3.fromRGB(80, 85, 95)
local DESK_COLOR = Color3.fromRGB(110, 80, 50)
local BOARD_COLOR = Color3.fromRGB(40, 50, 35)
local ACCENT_COLOR = Color3.fromRGB(180, 150, 50)

local function makePart(parent: Instance, name: string, pos: Vector3, size: Vector3, color: Color3, material: Enum.Material?): Part
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Position = pos
	p.Anchored = true
	p.Color = color
	p.Material = material or Enum.Material.SmoothPlastic
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Parent = parent
	return p
end

function PrecinctBuilder.build(): (Model, Part)
	local model = Instance.new("Model")
	model.Name = "Precinct"

	-- Floor
	local floor = makePart(model, "Floor", Vector3.new(0, -0.5, 0), Vector3.new(80, 1, 80), FLOOR_COLOR, Enum.Material.Concrete)

	-- Walls
	makePart(model, "WallN", Vector3.new(0, 8, 40.5), Vector3.new(80, 16, 1), WALL_COLOR, Enum.Material.Concrete)
	makePart(model, "WallS", Vector3.new(0, 8, -40.5), Vector3.new(80, 16, 1), WALL_COLOR, Enum.Material.Concrete)
	makePart(model, "WallE", Vector3.new(40.5, 8, 0), Vector3.new(1, 16, 80), WALL_COLOR, Enum.Material.Concrete)
	makePart(model, "WallW", Vector3.new(-40.5, 8, 0), Vector3.new(1, 16, 80), WALL_COLOR, Enum.Material.Concrete)

	-- Ceiling
	makePart(model, "Ceiling", Vector3.new(0, 16.5, 0), Vector3.new(80, 1, 80), Color3.fromRGB(200, 200, 200), Enum.Material.SmoothPlastic)

	-- Desks (scattered around the precinct)
	local deskPositions = {
		Vector3.new(-15, 1.5, -10),
		Vector3.new(-15, 1.5, 5),
		Vector3.new(-15, 1.5, 20),
		Vector3.new(15, 1.5, -10),
		Vector3.new(15, 1.5, 5),
		Vector3.new(15, 1.5, 20),
	}
	for i, pos in deskPositions do
		makePart(model, "Desk" .. i, pos, Vector3.new(6, 3, 4), DESK_COLOR, Enum.Material.Wood)
		-- Chair behind desk
		makePart(model, "Chair" .. i, pos + Vector3.new(0, 0, -3), Vector3.new(2, 4, 2), Color3.fromRGB(50, 50, 60))
	end

	-- Front reception desk
	makePart(model, "ReceptionDesk", Vector3.new(0, 2, -30), Vector3.new(16, 4, 3), DESK_COLOR, Enum.Material.Wood)

	-- WARRANT sign on back wall
	local sign = makePart(model, "WarrantSign", Vector3.new(0, 12, 39.5), Vector3.new(20, 4, 0.5), Color3.fromRGB(30, 30, 40))
	local signGui = Instance.new("SurfaceGui")
	signGui.Name = "SignGui"
	signGui.Face = Enum.NormalId.Back
	signGui.Parent = sign

	local signLabel = Instance.new("TextLabel")
	signLabel.Size = UDim2.new(1, 0, 1, 0)
	signLabel.BackgroundTransparency = 1
	signLabel.Text = "W A R R A N T"
	signLabel.TextColor3 = ACCENT_COLOR
	signLabel.TextScaled = true
	signLabel.Font = Enum.Font.GothamBold
	signLabel.Parent = signGui

	-- Case Board (the physical object players interact with)
	local boardBase = makePart(model, "CaseBoardBase", Vector3.new(0, 5, 38), Vector3.new(14, 10, 1.5), BOARD_COLOR, Enum.Material.Wood)
	boardBase:AddTag("CaseBoard")

	-- Board surface GUI
	local boardGui = Instance.new("SurfaceGui")
	boardGui.Name = "BoardGui"
	boardGui.Face = Enum.NormalId.Back
	boardGui.Parent = boardBase

	local boardTitle = Instance.new("TextLabel")
	boardTitle.Size = UDim2.new(1, 0, 0.15, 0)
	boardTitle.BackgroundTransparency = 1
	boardTitle.Text = "CASE BOARD"
	boardTitle.TextColor3 = Color3.fromRGB(255, 220, 100)
	boardTitle.TextScaled = true
	boardTitle.Font = Enum.Font.GothamBold
	boardTitle.Parent = boardGui

	local boardSubtext = Instance.new("TextLabel")
	boardSubtext.Size = UDim2.new(1, 0, 0.1, 0)
	boardSubtext.Position = UDim2.new(0, 0, 0.15, 0)
	boardSubtext.BackgroundTransparency = 1
	boardSubtext.Text = "Press E or click to view available cases"
	boardSubtext.TextColor3 = Color3.fromRGB(180, 180, 180)
	boardSubtext.TextScaled = true
	boardSubtext.Font = Enum.Font.Gotham
	boardSubtext.Parent = boardGui

	-- Case pins on the board (decorative)
	local pinPositions = {
		UDim2.new(0.1, 0, 0.35, 0), UDim2.new(0.35, 0, 0.4, 0),
		UDim2.new(0.6, 0, 0.35, 0), UDim2.new(0.15, 0, 0.65, 0),
		UDim2.new(0.5, 0, 0.7, 0), UDim2.new(0.75, 0, 0.55, 0),
	}
	local pinColors = {
		Color3.fromRGB(200, 60, 60), Color3.fromRGB(60, 120, 200),
		Color3.fromRGB(200, 180, 60), Color3.fromRGB(60, 200, 80),
		Color3.fromRGB(200, 100, 60), Color3.fromRGB(150, 60, 200),
	}
	for i, pinPos in pinPositions do
		local pin = Instance.new("Frame")
		pin.Size = UDim2.new(0.15, 0, 0.2, 0)
		pin.Position = pinPos
		pin.BackgroundColor3 = Color3.fromRGB(220, 210, 190)
		pin.BorderSizePixel = 0
		pin.Rotation = math.random(-5, 5)
		pin.Parent = boardGui

		local pinCorner = Instance.new("UICorner")
		pinCorner.CornerRadius = UDim.new(0, 3)
		pinCorner.Parent = pin

		local dot = Instance.new("Frame")
		dot.Size = UDim2.new(0, 8, 0, 8)
		dot.Position = UDim2.new(0.5, -4, 0, -4)
		dot.BackgroundColor3 = pinColors[i] or Color3.fromRGB(200, 60, 60)
		dot.Parent = pin

		local dotCorner = Instance.new("UICorner")
		dotCorner.CornerRadius = UDim.new(1, 0)
		dotCorner.Parent = dot
	end

	-- ProximityPrompt on the case board
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "View Cases"
	prompt.ObjectText = "Case Board"
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.MaxActivationDistance = 12
	prompt.HoldDuration = 0
	prompt.Parent = boardBase

	-- Spawn location
	local spawnLocation = Instance.new("SpawnLocation")
	spawnLocation.Name = "PrecinctSpawn"
	spawnLocation.Position = Vector3.new(0, 0.5, -15)
	spawnLocation.Size = Vector3.new(8, 1, 8)
	spawnLocation.Anchored = true
	spawnLocation.Transparency = 1
	spawnLocation.CanCollide = false
	spawnLocation.Parent = model

	-- Lighting (point lights on ceiling)
	local lightPositions = {
		Vector3.new(-15, 15, -15), Vector3.new(15, 15, -15),
		Vector3.new(-15, 15, 15), Vector3.new(15, 15, 15),
		Vector3.new(0, 15, 0),
	}
	for i, lPos in lightPositions do
		local lightPart = Instance.new("Part")
		lightPart.Name = "Light" .. i
		lightPart.Size = Vector3.new(3, 0.5, 3)
		lightPart.Position = lPos
		lightPart.Anchored = true
		lightPart.Color = Color3.fromRGB(240, 240, 230)
		lightPart.Material = Enum.Material.Neon
		lightPart.Parent = model

		local light = Instance.new("PointLight")
		light.Brightness = 1.5
		light.Range = 30
		light.Color = Color3.fromRGB(255, 245, 220)
		light.Parent = lightPart
	end

	model.PrimaryPart = floor
	model.Parent = workspace

	return model, boardBase
end

return PrecinctBuilder
