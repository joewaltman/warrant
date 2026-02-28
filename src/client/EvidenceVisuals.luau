--!strict
-- EvidenceVisuals | WARRANT: Case Closed
-- Creates glowing 3D evidence markers at evidence positions in the world

local RunService = game:GetService("RunService")

local EvidenceVisuals = {}

local markers: { [string]: { part: Part, light: PointLight, billboard: BillboardGui } } = {}
local heartbeatConn: RBXScriptConnection? = nil
local elapsed = 0

local METHOD_COLORS = {
	proximity = Color3.fromRGB(80, 150, 255),   -- blue
	interact = Color3.fromRGB(255, 220, 80),     -- yellow
	scan = Color3.fromRGB(180, 80, 255),         -- purple
	photograph = Color3.fromRGB(80, 255, 120),   -- green
}

local function createMarker(id: string, position: Vector3, discoveryMethod: string): { part: Part, light: PointLight, billboard: BillboardGui }
	local color = METHOD_COLORS[discoveryMethod] or Color3.fromRGB(255, 255, 255)

	local part = Instance.new("Part")
	part.Name = "EvidenceMarker_" .. id
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(1.5, 1.5, 1.5)
	part.Position = position + Vector3.new(0, 2, 0)
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	part.Color = color
	part.Transparency = 0.3
	part.Parent = workspace

	local light = Instance.new("PointLight")
	light.Color = color
	light.Brightness = 2
	light.Range = 12
	light.Parent = part

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 100, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = part

	local promptLabel = Instance.new("TextLabel")
	promptLabel.Size = UDim2.new(1, 0, 1, 0)
	promptLabel.BackgroundTransparency = 1
	promptLabel.Text = "Press E"
	promptLabel.TextColor3 = color
	promptLabel.TextSize = 14
	promptLabel.Font = Enum.Font.GothamBold
	promptLabel.Parent = billboard

	return { part = part, light = light, billboard = billboard }
end

function EvidenceVisuals.init()
	-- Start pulse animation
	if heartbeatConn then
		heartbeatConn:Disconnect()
	end

	elapsed = 0
	heartbeatConn = RunService.Heartbeat:Connect(function(dt: number)
		elapsed += dt
		local pulse = 0.3 + 0.2 * math.sin(elapsed * 3)
		for _, marker in markers do
			marker.part.Transparency = pulse
		end
	end)

	print("[EvidenceVisuals] Initialized")
end

function EvidenceVisuals.loadPositions(positions: { { id: string, position: Vector3, discoveryMethod: string } })
	-- Clear existing markers first
	EvidenceVisuals.reset()

	for _, ev in positions do
		markers[ev.id] = createMarker(ev.id, ev.position, ev.discoveryMethod)
	end

	print("[EvidenceVisuals] Loaded", #positions, "evidence markers")
end

function EvidenceVisuals.onEvidenceDiscovered(evidenceId: string)
	local marker = markers[evidenceId]
	if marker then
		marker.part:Destroy()
		markers[evidenceId] = nil
	end
end

function EvidenceVisuals.reset()
	for id, marker in markers do
		marker.part:Destroy()
		markers[id] = nil
	end
	markers = {}
end

return EvidenceVisuals
