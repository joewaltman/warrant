--!strict
-- NPCBehavior | WARRANT: Case Closed
-- Behavior tree system for suspect NPCs: SURRENDER, FLEE, RESIST

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
}

local NPCBehavior = {}

local activeNPCs: { [string]: NPCInstance } = {}

local ALERT_RADIUS = 30
local SURRENDER_HEALTH_THRESHOLD = 0.25
local FLEE_INTERACT_RANGE = 8

local function createNPCModel(config: NPCSuspect): (Model, Humanoid)
	-- Create a basic NPC rig; in production this would clone from a template
	local model = Instance.new("Model")
	model.Name = "Suspect_" .. config.id

	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 1)
	rootPart.Position = config.position
	rootPart.Anchored = false
	rootPart.Parent = model

	local humanoid = Instance.new("Humanoid")
	humanoid.MaxHealth = config.health
	humanoid.Health = config.health
	humanoid.Parent = model

	model.PrimaryPart = rootPart
	model.Parent = workspace

	return model, humanoid
end

function NPCBehavior.spawnNPC(config: NPCSuspect, assignedBehavior: BehaviorType): NPCInstance
	local model, humanoid = createNPCModel(config)

	local npc: NPCInstance = {
		config = config,
		model = model,
		humanoid = humanoid,
		state = "Idle",
		behavior = assignedBehavior,
		health = config.health,
		isAlerted = false,
		targetPlayer = nil,
	}

	activeNPCs[config.id] = npc
	return npc
end

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

	-- Alert chain: notify nearby NPCs
	NPCBehavior.alertNearby(npc, player)
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

function NPCBehavior.executeSurrender(npc: NPCInstance)
	npc.state = "Surrendering"
	-- NPC raises hands — play animation when available
	-- Player can cuff immediately via interaction
	print("[NPCBehavior]", npc.config.name, "is surrendering")
end

function NPCBehavior.executeFlee(npc: NPCInstance)
	npc.state = "Fleeing"
	print("[NPCBehavior]", npc.config.name, "is fleeing")

	local fleeRoute = npc.config.fleeRoute
	if not fleeRoute or #fleeRoute == 0 then
		-- No flee route defined; fall back to pathfinding away from player
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

				local success, err = pcall(function()
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
		return
	end

	-- Follow predefined flee route
	task.spawn(function()
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

			local success, err = pcall(function()
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
				-- Direct move if pathfinding fails
				npc.humanoid:MoveTo(point)
				npc.humanoid.MoveToFinished:Wait()
			end
		end
	end)
end

function NPCBehavior.executeResist(npc: NPCInstance)
	npc.state = "Resisting"
	print("[NPCBehavior]", npc.config.name, "is resisting")

	-- NPC takes cover and engages — combat loop handled by CombatSystem callbacks
	-- Find nearest cover object (tagged parts in the workspace)
	-- For now, NPC stays at position and faces player
	task.spawn(function()
		while npc.state == "Resisting" and npc.health > 0 do
			-- Check if health dropped below threshold
			if npc.health <= npc.config.health * SURRENDER_HEALTH_THRESHOLD then
				-- Switch to surrender or flee
				if math.random() < 0.6 then
					NPCBehavior.executeSurrender(npc)
				else
					NPCBehavior.executeFlee(npc)
				end
				break
			end
			task.wait(0.5)
		end
	end)
end

function NPCBehavior.damageNPC(npcId: string, damage: number): (boolean, boolean)
	local npc = activeNPCs[npcId]
	if not npc or npc.state == "Downed" or npc.state == "Arrested" then
		return false, false
	end

	npc.health = math.max(0, npc.health - damage)
	npc.humanoid.Health = npc.health

	if npc.health <= 0 then
		npc.state = "Downed"
		print("[NPCBehavior]", npc.config.name, "is downed")
		return true, true -- hit, downed
	end

	return true, false -- hit, not downed
end

function NPCBehavior.arrestNPC(npcId: string): boolean
	local npc = activeNPCs[npcId]
	if not npc then
		return false
	end

	if npc.state ~= "Surrendering" and npc.state ~= "Downed" and npc.state ~= "Fleeing" then
		return false
	end

	npc.state = "Arrested"
	print("[NPCBehavior]", npc.config.name, "arrested")
	return true
end

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

function NPCBehavior.cleanup()
	for _, npc in activeNPCs do
		if npc.model then
			npc.model:Destroy()
		end
	end
	table.clear(activeNPCs)
end

return NPCBehavior
