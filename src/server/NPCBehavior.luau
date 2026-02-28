--!strict
-- NPCBehavior | WARRANT: Case Closed
-- Behavior tree system for suspect NPCs: SURRENDER, FLEE, RESIST
-- Includes R6-style character rigs, combat AI, and visual state indicators

local Players = game:GetService("Players")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type BehaviorType = Types.BehaviorType
type NPCSuspect = Types.NPCSuspect

export type NPCState = "Idle" | "Surrendering" | "Fleeing" | "Resisting" | "Downed" | "Arrested"

export type NPCInstance = {
	config: NPCSuspect,
	model: Model,
	humanoid: Humanoid,
	state: NPCState,
	behavior: BehaviorType,
	health: number,
	isAlerted: boolean,
	targetPlayer: Player?,
	billboard: BillboardGui?,
	healthBarFill: Frame?,
	statusLabel: TextLabel?,
}

local NPCBehavior = {}

local activeNPCs: { [string]: NPCInstance } = {}

local ALERT_RADIUS = 30
local SURRENDER_HEALTH_THRESHOLD = 0.25
local FLEE_INTERACT_RANGE = 8

-- Skin tone palette for NPC variety
local SKIN_TONES = {
	Color3.fromRGB(255, 220, 185),
	Color3.fromRGB(215, 175, 140),
	Color3.fromRGB(180, 140, 105),
	Color3.fromRGB(140, 100, 70),
	Color3.fromRGB(100, 70, 50),
}

-- Clothing color palette
local CLOTHING_COLORS = {
	Color3.fromRGB(50, 50, 55),
	Color3.fromRGB(80, 30, 30),
	Color3.fromRGB(30, 50, 80),
	Color3.fromRGB(60, 60, 40),
	Color3.fromRGB(90, 90, 95),
	Color3.fromRGB(40, 40, 50),
	Color3.fromRGB(100, 60, 30),
	Color3.fromRGB(70, 30, 70),
}

-- NPC difficulty scaling for combat
local DIFFICULTY_STATS = {
	[1] = { damage = 8, accuracy = 0.25, fireInterval = { 2.0, 2.5 } },
	[2] = { damage = 10, accuracy = 0.35, fireInterval = { 1.8, 2.3 } },
	[3] = { damage = 12, accuracy = 0.45, fireInterval = { 1.5, 2.2 } },
	[4] = { damage = 15, accuracy = 0.55, fireInterval = { 1.5, 2.0 } },
}

------------------------------------------------------------------------
-- NPC MODEL CREATION (R6-style rig)
------------------------------------------------------------------------
local function createBodyPart(parent: Model, name: string, size: Vector3, offset: CFrame, color: Color3, shape: Enum.PartType?): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.CFrame = offset
	part.Anchored = false
	part.CanCollide = false
	part.Color = color
	if shape then
		part.Shape = shape
	end
	part.Parent = parent
	return part
end

local function weldParts(parent: BasePart, child: BasePart)
	local weld = Instance.new("Motor6D")
	weld.Part0 = parent
	weld.Part1 = child
	weld.C0 = parent.CFrame:ToObjectSpace(child.CFrame)
	weld.Parent = parent
end

local function createBillboard(model: Model, npcName: string): (BillboardGui, Frame, TextLabel)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NPCBillboard"
	billboard.Size = UDim2.new(0, 120, 0, 40)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Enabled = false -- Hidden until raid
	billboard.Adornee = model.PrimaryPart
	billboard.Parent = model

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "NameLabel"
	nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = npcName
	nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.TextSize = 12
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Parent = billboard

	local healthBg = Instance.new("Frame")
	healthBg.Name = "HealthBg"
	healthBg.Size = UDim2.new(0.8, 0, 0.2, 0)
	healthBg.Position = UDim2.new(0.1, 0, 0.5, 0)
	healthBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	healthBg.BorderSizePixel = 0
	healthBg.Parent = billboard

	local healthFill = Instance.new("Frame")
	healthFill.Name = "Fill"
	healthFill.Size = UDim2.new(1, 0, 1, 0)
	healthFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	healthFill.BorderSizePixel = 0
	healthFill.Parent = healthBg

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, 0, 0.3, 0)
	statusLabel.Position = UDim2.new(0, 0, 0.7, 0)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = ""
	statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
	statusLabel.TextSize = 10
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextStrokeTransparency = 0.5
	statusLabel.Parent = billboard

	return billboard, healthFill, statusLabel
end

local function createNPCModel(config: NPCSuspect): (Model, Humanoid)
	local model = Instance.new("Model")
	model.Name = "Suspect_" .. config.id

	local skinColor = SKIN_TONES[math.random(1, #SKIN_TONES)]
	local clothingColor = CLOTHING_COLORS[math.random(1, #CLOTHING_COLORS)]

	-- HumanoidRootPart
	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 1)
	rootPart.CFrame = CFrame.new(config.position + Vector3.new(0, 3, 0))
	rootPart.Anchored = false
	rootPart.Transparency = 1
	rootPart.CanCollide = false
	rootPart.Parent = model

	model.PrimaryPart = rootPart

	-- Torso
	local torso = createBodyPart(model, "Torso", Vector3.new(2, 2, 1),
		CFrame.new(config.position + Vector3.new(0, 3, 0)), clothingColor)
	weldParts(rootPart, torso)

	-- Head
	local head = createBodyPart(model, "Head", Vector3.new(1.2, 1.2, 1.2),
		CFrame.new(config.position + Vector3.new(0, 4.6, 0)), skinColor, Enum.PartType.Ball)
	weldParts(torso, head)

	-- Left Arm
	local leftArm = createBodyPart(model, "Left Arm", Vector3.new(1, 2, 1),
		CFrame.new(config.position + Vector3.new(-1.5, 3, 0)), clothingColor)
	weldParts(torso, leftArm)

	-- Right Arm
	local rightArm = createBodyPart(model, "Right Arm", Vector3.new(1, 2, 1),
		CFrame.new(config.position + Vector3.new(1.5, 3, 0)), clothingColor)
	weldParts(torso, rightArm)

	-- Left Leg
	local leftLeg = createBodyPart(model, "Left Leg", Vector3.new(1, 2, 1),
		CFrame.new(config.position + Vector3.new(-0.5, 1, 0)), Color3.fromRGB(50, 50, 55))
	weldParts(torso, leftLeg)

	-- Right Leg
	local rightLeg = createBodyPart(model, "Right Leg", Vector3.new(1, 2, 1),
		CFrame.new(config.position + Vector3.new(0.5, 1, 0)), Color3.fromRGB(50, 50, 55))
	weldParts(torso, rightLeg)

	-- Humanoid
	local humanoid = Instance.new("Humanoid")
	humanoid.MaxHealth = config.health
	humanoid.Health = config.health
	humanoid.WalkSpeed = 16
	humanoid.JumpPower = 0
	humanoid.Parent = model

	model.Parent = workspace

	return model, humanoid
end

------------------------------------------------------------------------
-- HELPER: Get remote event
------------------------------------------------------------------------
local function getRemote(name: string): RemoteEvent?
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent?
end

------------------------------------------------------------------------
-- NPC SPAWNING
------------------------------------------------------------------------
function NPCBehavior.spawnNPC(config: NPCSuspect, assignedBehavior: BehaviorType): NPCInstance
	local model, humanoid = createNPCModel(config)

	-- Create billboard
	local billboard, healthFill, statusLabel = createBillboard(model, config.name)
	billboard.Enabled = true -- Show during raid

	local npc: NPCInstance = {
		config = config,
		model = model,
		humanoid = humanoid,
		state = "Idle",
		behavior = assignedBehavior,
		health = config.health,
		isAlerted = false,
		targetPlayer = nil,
		billboard = billboard,
		healthBarFill = healthFill,
		statusLabel = statusLabel,
	}

	activeNPCs[config.id] = npc
	return npc
end

------------------------------------------------------------------------
-- VISUAL STATE UPDATES
------------------------------------------------------------------------
local function updateVisualState(npc: NPCInstance)
	if not npc.statusLabel then
		return
	end

	if npc.state == "Surrendering" then
		npc.statusLabel.Text = "SURRENDERING"
		npc.statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		-- Arms up visual: move head part up slightly
		local head = npc.model:FindFirstChild("Head") :: BasePart?
		if head then
			local motor = head:FindFirstChildOfClass("Motor6D")
			if motor then
				motor.C0 = motor.C0 + Vector3.new(0, 0.5, 0)
			end
		end
	elseif npc.state == "Fleeing" then
		npc.statusLabel.Text = "FLEEING"
		npc.statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
	elseif npc.state == "Resisting" then
		npc.statusLabel.Text = "HOSTILE"
		npc.statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
	elseif npc.state == "Downed" then
		npc.statusLabel.Text = "DOWNED"
		npc.statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		-- Fall over
		local rootPart = npc.model.PrimaryPart
		if rootPart then
			rootPart.CFrame = rootPart.CFrame * CFrame.Angles(math.rad(90), 0, 0)
		end
	elseif npc.state == "Arrested" then
		npc.statusLabel.Text = "ARRESTED"
		npc.statusLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
		-- Dim the model
		for _, child in npc.model:GetDescendants() do
			if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
				child.Transparency = 0.5
			end
		end
	end

	-- Update health bar
	if npc.healthBarFill then
		local pct = math.clamp(npc.health / npc.config.health, 0, 1)
		npc.healthBarFill.Size = UDim2.new(pct, 0, 1, 0)
		if pct > 0.5 then
			npc.healthBarFill.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		elseif pct > 0.25 then
			npc.healthBarFill.BackgroundColor3 = Color3.fromRGB(200, 200, 50)
		else
			npc.healthBarFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		end
	end
end

------------------------------------------------------------------------
-- ALERT SYSTEM
------------------------------------------------------------------------
function NPCBehavior.alertNPC(npcId: string, player: Player)
	local npc = activeNPCs[npcId]
	if not npc or npc.isAlerted then
		return
	end

	npc.isAlerted = true
	npc.targetPlayer = player

	-- Execute behavior
	if npc.behavior == "SURRENDER" then
		NPCBehavior.executeSurrender(npc)
	elseif npc.behavior == "FLEE" then
		NPCBehavior.executeFlee(npc)
	elseif npc.behavior == "RESIST" then
		NPCBehavior.executeResist(npc)
	end
end

-- Alert all NPCs on breach with staggered delay
function NPCBehavior.alertAllOnBreach(player: Player)
	local delay = 0
	for _, npc in activeNPCs do
		if not npc.isAlerted and npc.state ~= "Arrested" and npc.state ~= "Downed" then
			task.delay(delay, function()
				NPCBehavior.alertNPC(npc.config.id, player)
			end)
			delay += 0.5
		end
	end
end

function NPCBehavior.alertNearby(sourceNPC: NPCInstance, player: Player)
	local sourcePos = sourceNPC.model.PrimaryPart
	if not sourcePos then
		return
	end

	for id, npc in activeNPCs do
		if id ~= sourceNPC.config.id and not npc.isAlerted and npc.state ~= "Arrested" and npc.state ~= "Downed" then
			local npcRoot = npc.model.PrimaryPart
			if npcRoot then
				local dist = (npcRoot.Position - sourcePos.Position).Magnitude
				if dist <= ALERT_RADIUS then
					NPCBehavior.alertNPC(id, player)
				end
			end
		end
	end
end

------------------------------------------------------------------------
-- BEHAVIOR: SURRENDER
------------------------------------------------------------------------
function NPCBehavior.executeSurrender(npc: NPCInstance)
	npc.state = "Surrendering"
	updateVisualState(npc)
	print("[NPCBehavior]", npc.config.name, "is surrendering")
end

------------------------------------------------------------------------
-- BEHAVIOR: FLEE
------------------------------------------------------------------------
function NPCBehavior.executeFlee(npc: NPCInstance)
	npc.state = "Fleeing"
	updateVisualState(npc)
	print("[NPCBehavior]", npc.config.name, "is fleeing")

	local fleeRoute = npc.config.fleeRoute

	task.spawn(function()
		-- Follow predefined route first
		if fleeRoute and #fleeRoute > 0 then
			for _, point in fleeRoute do
				if npc.state ~= "Fleeing" then
					break
				end

				local path = PathfindingService:CreatePath({
					AgentRadius = 2,
					AgentHeight = 5,
					AgentCanJump = false,
				})

				local npcRoot = npc.model.PrimaryPart
				if not npcRoot then
					break
				end

				local success, _err = pcall(function()
					path:ComputeAsync(npcRoot.Position, point)
				end)

				if success and path.Status == Enum.PathStatus.Success then
					local waypoints = path:GetWaypoints()
					for _, waypoint in waypoints do
						if npc.state ~= "Fleeing" then
							break
						end
						npc.humanoid:MoveTo(waypoint.Position)
						npc.humanoid.MoveToFinished:Wait()
					end
				else
					npc.humanoid:MoveTo(point)
					npc.humanoid.MoveToFinished:Wait()
				end
			end
		else
			-- No route: flee away from player
			if npc.targetPlayer and npc.targetPlayer.Character then
				local playerRoot = npc.targetPlayer.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
				local npcRoot = npc.model.PrimaryPart
				if playerRoot and npcRoot then
					local awayDir = (npcRoot.Position - playerRoot.Position).Unit
					local fleeTarget = npcRoot.Position + awayDir * 50

					local path = PathfindingService:CreatePath({
						AgentRadius = 2,
						AgentHeight = 5,
						AgentCanJump = false,
					})

					local success, _err = pcall(function()
						path:ComputeAsync(npcRoot.Position, fleeTarget)
					end)

					if success and path.Status == Enum.PathStatus.Success then
						local waypoints = path:GetWaypoints()
						for _, waypoint in waypoints do
							npc.humanoid:MoveTo(waypoint.Position)
							npc.humanoid.MoveToFinished:Wait()
							if npc.state ~= "Fleeing" then
								break
							end
						end
					end
				end
			end
		end

		-- After reaching all flee waypoints, keep fleeing to random positions
		while npc.state == "Fleeing" do
			task.wait(3)
			if npc.state ~= "Fleeing" then
				break
			end
			local npcRoot = npc.model.PrimaryPart
			if not npcRoot then
				break
			end
			-- Pick a random nearby position
			local randOffset = Vector3.new(
				math.random(-30, 30),
				0,
				math.random(-30, 30)
			)
			local target = npcRoot.Position + randOffset
			npc.humanoid:MoveTo(target)
			npc.humanoid.MoveToFinished:Wait()
		end
	end)
end

------------------------------------------------------------------------
-- HELPER: Find nearest player to an NPC
------------------------------------------------------------------------
local function findNearestPlayer(npc: NPCInstance): Player?
	local npcRoot = npc.model.PrimaryPart
	if not npcRoot then
		return nil
	end

	local nearestPlayer: Player? = nil
	local nearestDist = math.huge

	for _, player in Players:GetPlayers() do
		local character = player.Character
		if character then
			local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
			if rootPart then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 then
					local dist = (rootPart.Position - npcRoot.Position).Magnitude
					if dist < nearestDist then
						nearestDist = dist
						nearestPlayer = player
					end
				end
			end
		end
	end

	return nearestPlayer
end

------------------------------------------------------------------------
-- BEHAVIOR: RESIST (with combat AI, multi-target support)
------------------------------------------------------------------------
function NPCBehavior.executeResist(npc: NPCInstance)
	npc.state = "Resisting"
	updateVisualState(npc)
	print("[NPCBehavior]", npc.config.name, "is resisting")

	-- Resolve difficulty stats
	local diff = npc.config.difficulty or 1
	local stats = DIFFICULTY_STATS[diff] or DIFFICULTY_STATS[1]

	-- Combat loop: NPC shoots at nearest player
	task.spawn(function()
		while npc.state == "Resisting" and npc.health > 0 do
			-- Check if health dropped below threshold
			if npc.health <= npc.config.health * SURRENDER_HEALTH_THRESHOLD then
				if math.random() < 0.6 then
					NPCBehavior.executeSurrender(npc)
				else
					NPCBehavior.executeFlee(npc)
				end
				break
			end

			-- Pick nearest player as target (re-evaluate each tick)
			local currentTarget = findNearestPlayer(npc)
			if not currentTarget then
				-- Fall back to original target if no players found nearby
				currentTarget = npc.targetPlayer
			end

			-- Fire at target
			if currentTarget and currentTarget.Character then
				local playerRoot = currentTarget.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
				local npcRoot = npc.model.PrimaryPart
				if playerRoot and npcRoot then
					-- Face the player
					local lookDir = (playerRoot.Position - npcRoot.Position).Unit
					npcRoot.CFrame = CFrame.new(npcRoot.Position, npcRoot.Position + Vector3.new(lookDir.X, 0, lookDir.Z))

					-- Line of sight check (simple raycast)
					local rayParams = RaycastParams.new()
					rayParams.FilterType = Enum.RaycastFilterType.Exclude
					rayParams.FilterDescendantsInstances = { npc.model }

					local direction = playerRoot.Position - npcRoot.Position
					local result = workspace:Raycast(npcRoot.Position, direction, rayParams)

					local hasLOS = false
					if result then
						local hitModel = result.Instance:FindFirstAncestorOfClass("Model")
						if hitModel and hitModel == currentTarget.Character then
							hasLOS = true
						end
					elseif not result then
						hasLOS = true
					end

					if hasLOS then
						-- Accuracy roll
						local hitRoll = math.random() < stats.accuracy

						-- Lazy require to avoid circular dependency
						local CombatSystem = require(script.Parent.CombatSystem) :: any

						if hitRoll then
							CombatSystem.damagePlayer(currentTarget, stats.damage)
						end

						-- Fire visual feedback to client
						local npcFiredRemote = getRemote("NPCFired")
						if npcFiredRemote then
							npcFiredRemote:FireClient(currentTarget, {
								npcId = npc.config.id,
								position = npcRoot.Position,
								hit = hitRoll,
							})
						end
					end
				end
			end

			-- Randomized fire interval
			local interval = stats.fireInterval[1] + math.random() * (stats.fireInterval[2] - stats.fireInterval[1])
			task.wait(interval)
		end
	end)
end

------------------------------------------------------------------------
-- DAMAGE
------------------------------------------------------------------------
function NPCBehavior.damageNPC(npcId: string, damage: number): (boolean, boolean)
	local npc = activeNPCs[npcId]
	if not npc or npc.state == "Downed" or npc.state == "Arrested" then
		return false, false
	end

	npc.health = math.max(0, npc.health - damage)
	npc.humanoid.Health = npc.health

	-- Update health bar visual
	updateVisualState(npc)

	if npc.health <= 0 then
		npc.state = "Downed"
		updateVisualState(npc)
		print("[NPCBehavior]", npc.config.name, "is downed")
		return true, true -- hit, downed
	end

	return true, false -- hit, not downed
end

------------------------------------------------------------------------
-- ARREST
------------------------------------------------------------------------
function NPCBehavior.arrestNPC(npcId: string): boolean
	local npc = activeNPCs[npcId]
	if not npc then
		return false
	end

	if npc.state ~= "Surrendering" and npc.state ~= "Downed" and npc.state ~= "Fleeing" then
		return false
	end

	npc.state = "Arrested"
	updateVisualState(npc)
	print("[NPCBehavior]", npc.config.name, "arrested")
	return true
end

------------------------------------------------------------------------
-- QUERIES
------------------------------------------------------------------------
function NPCBehavior.getNPC(npcId: string): NPCInstance?
	return activeNPCs[npcId]
end

function NPCBehavior.getAllNPCs(): { [string]: NPCInstance }
	return activeNPCs
end

function NPCBehavior.isNPCInRange(npcId: string, position: Vector3, range: number): boolean
	local npc = activeNPCs[npcId]
	if not npc then
		return false
	end

	local root = npc.model.PrimaryPart
	if not root then
		return false
	end

	return (root.Position - position).Magnitude <= range
end

------------------------------------------------------------------------
-- CLEANUP
------------------------------------------------------------------------
function NPCBehavior.cleanup()
	for _, npc in activeNPCs do
		if npc.model then
			npc.model:Destroy()
		end
	end
	table.clear(activeNPCs)
end

return NPCBehavior
