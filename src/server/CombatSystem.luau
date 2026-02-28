--!strict
-- CombatSystem | WARRANT: Case Closed
-- Third-person shooter: weapons, server-authoritative raycasting, cover, collateral

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

export type WeaponType = "Taser" | "BeanBagGun" | "NetGun" | "Firearm"

export type WeaponConfig = {
	name: WeaponType,
	isNonLethal: boolean,
	damage: number,
	range: number,
	cooldown: number,
	stunDuration: number?,
	immobilizeDuration: number?,
}

export type PlayerCombatState = {
	health: number,
	maxHealth: number,
	armor: number,
	equippedWeapon: WeaponType,
	lastFireTime: number,
}

local CombatSystem = {}

local WEAPONS: { [WeaponType]: WeaponConfig } = {
	Taser = {
		name = "Taser",
		isNonLethal = true,
		damage = 0,
		range = 15,
		cooldown = 2.0,
		stunDuration = 3.0,
	},
	BeanBagGun = {
		name = "BeanBagGun",
		isNonLethal = true,
		damage = 15,
		range = 40,
		cooldown = 1.0,
		stunDuration = 1.5,
	},
	NetGun = {
		name = "NetGun",
		isNonLethal = true,
		damage = 0,
		range = 25,
		cooldown = 3.0,
		immobilizeDuration = 5.0,
	},
	Firearm = {
		name = "Firearm",
		isNonLethal = false,
		damage = 35,
		range = 100,
		cooldown = 0.3,
	},
}

local MEDKIT_HEAL = 50
local BASE_PLAYER_HEALTH = 100
local COLLATERAL_TAGS = { "Civilian", "CivilianObject" }

local playerCombatStates: { [number]: PlayerCombatState } = {}

local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild(name) :: RemoteEvent
end

function CombatSystem.initPlayer(player: Player, armorBonus: number?)
	playerCombatStates[player.UserId] = {
		health = BASE_PLAYER_HEALTH,
		maxHealth = BASE_PLAYER_HEALTH,
		armor = armorBonus or 0,
		equippedWeapon = "Firearm",
		lastFireTime = 0,
	}
end

function CombatSystem.getPlayerState(player: Player): PlayerCombatState?
	return playerCombatStates[player.UserId]
end

function CombatSystem.equipWeapon(player: Player, weapon: WeaponType): boolean
	local state = playerCombatStates[player.UserId]
	if not state then
		return false
	end

	if not WEAPONS[weapon] then
		return false
	end

	state.equippedWeapon = weapon
	getRemote("WeaponEquipped"):FireClient(player, weapon)
	return true
end

function CombatSystem.getWeaponConfig(weapon: WeaponType): WeaponConfig?
	return WEAPONS[weapon]
end

-- Server-authoritative raycast for hit detection
function CombatSystem.fireWeapon(player: Player, origin: Vector3, direction: Vector3): {
	hit: boolean,
	target: string?,
	isNPC: boolean,
	isNonLethal: boolean,
	isCollateral: boolean,
	damage: number,
}
	local state = playerCombatStates[player.UserId]
	if not state then
		return { hit = false, target = nil, isNPC = false, isNonLethal = false, isCollateral = false, damage = 0 }
	end

	local weapon = WEAPONS[state.equippedWeapon]
	if not weapon then
		return { hit = false, target = nil, isNPC = false, isNonLethal = false, isCollateral = false, damage = 0 }
	end

	-- Cooldown check
	local now = tick()
	if now - state.lastFireTime < weapon.cooldown then
		return { hit = false, target = nil, isNPC = false, isNonLethal = false, isCollateral = false, damage = 0 }
	end
	state.lastFireTime = now

	-- Range-limited raycast
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	local character = player.Character
	if character then
		rayParams.FilterDescendantsInstances = { character }
	end

	local clampedDir = direction.Unit * math.min(direction.Magnitude, weapon.range)
	local result = workspace:Raycast(origin, clampedDir, rayParams)

	if not result or not result.Instance then
		return { hit = false, target = nil, isNPC = false, isNonLethal = false, isCollateral = false, damage = 0 }
	end

	local hitPart = result.Instance
	local hitModel = hitPart:FindFirstAncestorOfClass("Model")

	-- Check for collateral (civilian tagged objects)
	local isCollateral = false
	for _, tag in COLLATERAL_TAGS do
		if hitPart:HasTag(tag) or (hitModel and hitModel:HasTag(tag)) then
			isCollateral = true
			break
		end
	end

	-- Check if NPC
	local isNPC = false
	local targetId: string? = nil
	if hitModel and hitModel.Name:find("Suspect_") then
		isNPC = true
		targetId = hitModel.Name:gsub("Suspect_", "")
	end

	return {
		hit = true,
		target = targetId,
		isNPC = isNPC,
		isNonLethal = weapon.isNonLethal,
		isCollateral = isCollateral,
		damage = weapon.damage,
	}
end

-- Check line of sight between two positions (cover system)
function CombatSystem.hasLineOfSight(from: Vector3, to: Vector3): boolean
	local direction = to - from
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Include
	-- Only check against cover objects and structure
	-- In production, filter to "Cover" tagged parts

	local result = workspace:Raycast(from, direction, rayParams)
	if result then
		-- Something is between the two positions
		local distToHit = (result.Position - from).Magnitude
		local distToTarget = direction.Magnitude
		return distToHit >= distToTarget * 0.95
	end
	return true
end

function CombatSystem.damagePlayer(player: Player, damage: number): boolean
	local state = playerCombatStates[player.UserId]
	if not state then
		return false
	end

	-- Apply armor reduction
	local effectiveDamage = math.max(0, damage - state.armor)
	state.health = math.max(0, state.health - effectiveDamage)

	getRemote("PlayerHealthChanged"):FireClient(player, {
		health = state.health,
		maxHealth = state.maxHealth,
	})

	if state.health <= 0 then
		getRemote("PlayerDowned"):FireClient(player)
		return true -- player downed
	end

	return false
end

function CombatSystem.healPlayer(player: Player, amount: number?)
	local state = playerCombatStates[player.UserId]
	if not state then
		return
	end

	local healAmount = amount or MEDKIT_HEAL
	state.health = math.min(state.maxHealth, state.health + healAmount)

	getRemote("PlayerHealthChanged"):FireClient(player, {
		health = state.health,
		maxHealth = state.maxHealth,
	})
end

function CombatSystem.cleanup(player: Player)
	playerCombatStates[player.UserId] = nil
end

return CombatSystem
