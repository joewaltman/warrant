--!strict
-- CombatFeedback | WARRANT: Case Closed
-- Client-side combat visual feedback: crosshair, hit markers, damage flash, weapon HUD

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CombatFeedback = {}

local screenGui: ScreenGui? = nil
local crosshair: Frame? = nil
local damageVignette: Frame? = nil
local weaponHUDFrame: Frame? = nil
local weaponSlots: { [string]: Frame } = {}

local isActive = false

local CROSSHAIR_SIZE = 20
local CROSSHAIR_GAP = 4
local CROSSHAIR_THICKNESS = 2

local WEAPON_KEYBINDS = {
	{ key = "1", weapon = "Taser", color = Color3.fromRGB(100, 200, 255) },
	{ key = "2", weapon = "BeanBagGun", display = "Bean Bag", color = Color3.fromRGB(255, 200, 100) },
	{ key = "3", weapon = "NetGun", display = "Net Gun", color = Color3.fromRGB(100, 255, 150) },
	{ key = "4", weapon = "Firearm", color = Color3.fromRGB(255, 100, 100) },
}

------------------------------------------------------------------------
-- CROSSHAIR
------------------------------------------------------------------------
local function createCrosshairLine(parent: Frame, name: string, pos: UDim2, size: UDim2): Frame
	local line = Instance.new("Frame")
	line.Name = name
	line.Size = size
	line.Position = pos
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	line.BorderSizePixel = 0
	line.Parent = parent
	return line
end

local function createCrosshair(parent: ScreenGui): Frame
	local container = Instance.new("Frame")
	container.Name = "Crosshair"
	container.Size = UDim2.new(0, CROSSHAIR_SIZE * 2, 0, CROSSHAIR_SIZE * 2)
	container.Position = UDim2.new(0.5, 0, 0.5, 0)
	container.AnchorPoint = Vector2.new(0.5, 0.5)
	container.BackgroundTransparency = 1
	container.Parent = parent

	-- Top
	createCrosshairLine(container, "Top",
		UDim2.new(0.5, 0, 0.5, -(CROSSHAIR_GAP + CROSSHAIR_SIZE)),
		UDim2.new(0, CROSSHAIR_THICKNESS, 0, CROSSHAIR_SIZE))

	-- Bottom
	createCrosshairLine(container, "Bottom",
		UDim2.new(0.5, 0, 0.5, CROSSHAIR_GAP + CROSSHAIR_SIZE),
		UDim2.new(0, CROSSHAIR_THICKNESS, 0, CROSSHAIR_SIZE))

	-- Left
	createCrosshairLine(container, "Left",
		UDim2.new(0.5, -(CROSSHAIR_GAP + CROSSHAIR_SIZE), 0.5, 0),
		UDim2.new(0, CROSSHAIR_SIZE, 0, CROSSHAIR_THICKNESS))

	-- Right
	createCrosshairLine(container, "Right",
		UDim2.new(0.5, CROSSHAIR_GAP + CROSSHAIR_SIZE, 0.5, 0),
		UDim2.new(0, CROSSHAIR_SIZE, 0, CROSSHAIR_THICKNESS))

	-- Center dot
	local dot = Instance.new("Frame")
	dot.Name = "Dot"
	dot.Size = UDim2.new(0, 2, 0, 2)
	dot.Position = UDim2.new(0.5, 0, 0.5, 0)
	dot.AnchorPoint = Vector2.new(0.5, 0.5)
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dot.BorderSizePixel = 0
	dot.Parent = container

	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = dot

	return container
end

------------------------------------------------------------------------
-- HIT MARKER
------------------------------------------------------------------------
local function showHitMarker(hitType: string)
	if not screenGui then
		return
	end

	local color = Color3.fromRGB(255, 255, 255) -- normal
	if hitType == "lethal" then
		color = Color3.fromRGB(255, 60, 60)
	elseif hitType == "nonlethal" then
		color = Color3.fromRGB(80, 180, 255)
	end

	-- Create X marker
	local marker = Instance.new("Frame")
	marker.Name = "HitMarker"
	marker.Size = UDim2.new(0, 30, 0, 30)
	marker.Position = UDim2.new(0.5, 0, 0.5, 0)
	marker.AnchorPoint = Vector2.new(0.5, 0.5)
	marker.BackgroundTransparency = 1
	marker.Parent = screenGui

	-- X lines
	for _, rotation in { 45, -45 } do
		local line = Instance.new("Frame")
		line.Size = UDim2.new(0, 2, 0, 20)
		line.Position = UDim2.new(0.5, 0, 0.5, 0)
		line.AnchorPoint = Vector2.new(0.5, 0.5)
		line.BackgroundColor3 = color
		line.BorderSizePixel = 0
		line.Rotation = rotation
		line.Parent = marker
	end

	-- Flash crosshair color
	if crosshair then
		for _, child in crosshair:GetChildren() do
			if child:IsA("Frame") then
				child.BackgroundColor3 = color
			end
		end
		task.delay(0.15, function()
			if crosshair then
				for _, child in crosshair:GetChildren() do
					if child:IsA("Frame") then
						child.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					end
				end
			end
		end)
	end

	-- Fade out
	task.delay(0.2, function()
		if marker.Parent then
			local tween = TweenService:Create(marker, TweenInfo.new(0.15), { })
			-- Fade all children
			for _, child in marker:GetChildren() do
				if child:IsA("Frame") then
					TweenService:Create(child, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
				end
			end
			tween:Play()
			task.delay(0.2, function()
				marker:Destroy()
			end)
		end
	end)
end

------------------------------------------------------------------------
-- DAMAGE VIGNETTE
------------------------------------------------------------------------
local function createDamageVignette(parent: ScreenGui): Frame
	local vignette = Instance.new("Frame")
	vignette.Name = "DamageVignette"
	vignette.Size = UDim2.new(1, 0, 1, 0)
	vignette.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	vignette.BackgroundTransparency = 1
	vignette.BorderSizePixel = 0
	vignette.ZIndex = 10
	vignette.Parent = parent

	-- Use UIGradient for vignette effect
	local gradient = Instance.new("UIGradient")
	gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.3, 0.7),
		NumberSequenceKeypoint.new(1, 1),
	})
	gradient.Parent = vignette

	return vignette
end

local function flashDamageVignette()
	if not damageVignette then
		return
	end

	damageVignette.BackgroundTransparency = 0.5
	TweenService:Create(damageVignette, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1,
	}):Play()
end

------------------------------------------------------------------------
-- MUZZLE FLASH (NPC shot visual)
------------------------------------------------------------------------
local function showMuzzleFlash(position: Vector3)
	local flash = Instance.new("Part")
	flash.Name = "MuzzleFlash"
	flash.Size = Vector3.new(1, 1, 1)
	flash.Position = position + Vector3.new(0, 3, 0)
	flash.Shape = Enum.PartType.Ball
	flash.Material = Enum.Material.Neon
	flash.Color = Color3.fromRGB(255, 200, 50)
	flash.Anchored = true
	flash.CanCollide = false
	flash.CastShadow = false
	flash.Parent = workspace

	local light = Instance.new("PointLight")
	light.Brightness = 3
	light.Range = 8
	light.Color = Color3.fromRGB(255, 200, 50)
	light.Parent = flash

	task.delay(0.1, function()
		flash:Destroy()
	end)
end

------------------------------------------------------------------------
-- WEAPON HUD
------------------------------------------------------------------------
local function createWeaponHUD(parent: ScreenGui): Frame
	local frame = Instance.new("Frame")
	frame.Name = "WeaponHUD"
	frame.Size = UDim2.new(0, 260, 0, 36)
	frame.Position = UDim2.new(0.5, -130, 1, -100)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Padding = UDim.new(0, 4)
	layout.Parent = frame

	for _, info in WEAPON_KEYBINDS do
		local slot = Instance.new("Frame")
		slot.Name = info.weapon
		slot.Size = UDim2.new(0, 60, 0, 36)
		slot.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		slot.BackgroundTransparency = 0.4
		slot.BorderSizePixel = 0
		slot.Parent = frame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 4)
		corner.Parent = slot

		local keyLabel = Instance.new("TextLabel")
		keyLabel.Size = UDim2.new(0, 16, 0, 16)
		keyLabel.Position = UDim2.new(0, 3, 0, 2)
		keyLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
		keyLabel.BackgroundTransparency = 0.3
		keyLabel.Text = info.key
		keyLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
		keyLabel.TextSize = 10
		keyLabel.Font = Enum.Font.GothamBold
		keyLabel.BorderSizePixel = 0
		keyLabel.Parent = slot

		local keyCorner = Instance.new("UICorner")
		keyCorner.CornerRadius = UDim.new(0, 3)
		keyCorner.Parent = keyLabel

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -22, 1, 0)
		nameLabel.Position = UDim2.new(0, 20, 0, 0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = info.display or info.weapon
		nameLabel.TextColor3 = info.color
		nameLabel.TextSize = 10
		nameLabel.Font = Enum.Font.Gotham
		nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
		nameLabel.Parent = slot

		weaponSlots[info.weapon] = slot
	end

	return frame
end

------------------------------------------------------------------------
-- PUBLIC API
------------------------------------------------------------------------
function CombatFeedback.init()
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CombatFeedbackGui"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 20
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	crosshair = createCrosshair(screenGui)
	damageVignette = createDamageVignette(screenGui)
	weaponHUDFrame = createWeaponHUD(screenGui)
end

function CombatFeedback.show()
	if screenGui then
		screenGui.Enabled = true
		isActive = true
	end
end

function CombatFeedback.hide()
	if screenGui then
		screenGui.Enabled = false
		isActive = false
	end
end

function CombatFeedback.onHit(hitType: string)
	if not isActive then
		return
	end
	showHitMarker(hitType)
end

function CombatFeedback.onDamageTaken(_data: any)
	if not isActive then
		return
	end
	flashDamageVignette()
end

function CombatFeedback.onEnemyFired(data: any)
	if not isActive then
		return
	end
	if data and data.position then
		showMuzzleFlash(data.position)
	end
end

function CombatFeedback.setActiveWeapon(weapon: string)
	for name, slot in weaponSlots do
		if name == weapon then
			slot.BackgroundTransparency = 0
			local stroke = slot:FindFirstChildOfClass("UIStroke")
			if not stroke then
				stroke = Instance.new("UIStroke")
				stroke.Thickness = 1.5
				stroke.Color = Color3.fromRGB(255, 255, 255)
				stroke.Parent = slot
			end
			stroke.Transparency = 0
		else
			slot.BackgroundTransparency = 0.4
			local stroke = slot:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Transparency = 1
			end
		end
	end
end

function CombatFeedback.destroy()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

return CombatFeedback
