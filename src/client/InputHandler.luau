--!strict
-- InputHandler | WARRANT: Case Closed
-- Client input processing: weapon switching, firing, interaction, breach trigger

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local InputHandler = {}

local isEnabled = false
local currentMode: "Investigation" | "Raid" | "Syndicate" | "None" = "None"

-- Weapon keybinds (1-4)
local WEAPON_KEYS = {
	[Enum.KeyCode.One] = "Taser",
	[Enum.KeyCode.Two] = "BeanBagGun",
	[Enum.KeyCode.Three] = "NetGun",
	[Enum.KeyCode.Four] = "Firearm",
}

local function getRemote(name: string): RemoteEvent?
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent?
end

local function onInputBegan(input: InputObject, gameProcessed: boolean)
	if gameProcessed or not isEnabled then
		return
	end

	-- Weapon switching (raid mode)
	if currentMode == "Raid" then
		local weapon = WEAPON_KEYS[input.KeyCode]
		if weapon then
			local remote = getRemote("RequestWeaponSwitch")
			if remote then
				remote:FireServer(weapon)
			end
			return
		end

		-- Fire weapon (left mouse button)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local character = LocalPlayer.Character
			if not character then
				return
			end

			local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
			if not rootPart then
				return
			end

			-- Ray from camera through mouse position
			local mousePos = UserInputService:GetMouseLocation()
			local ray = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
			local origin = rootPart.Position
			local direction = ray.Direction * 200

			local remote = getRemote("RequestFireWeapon")
			if remote then
				remote:FireServer(origin, direction)
			end
			return
		end
	end

	-- Interact key (E)
	if input.KeyCode == Enum.KeyCode.E then
		if currentMode == "Investigation" then
			-- Interact with evidence
			local remote = getRemote("RequestInteract")
			if remote then
				remote:FireServer()
			end
		elseif currentMode == "Raid" then
			-- Arrest / cuff suspect
			local remote = getRemote("RequestArrest")
			if remote then
				remote:FireServer()
			end
		elseif currentMode == "Syndicate" then
			-- Identify suspect
			local remote = getRemote("RequestIdentify")
			if remote then
				remote:FireServer()
			end
		end
		return
	end

	-- Breach key (F)
	if input.KeyCode == Enum.KeyCode.F and currentMode == "Investigation" then
		local remote = getRemote("RequestBreach")
		if remote then
			remote:FireServer()
		end
		return
	end

	-- Medkit key (H)
	if input.KeyCode == Enum.KeyCode.H and currentMode == "Raid" then
		local remote = getRemote("RequestMedkit")
		if remote then
			remote:FireServer()
		end
		return
	end
end

function InputHandler.init()
	UserInputService.InputBegan:Connect(onInputBegan)
end

function InputHandler.enable()
	isEnabled = true
end

function InputHandler.disable()
	isEnabled = false
end

function InputHandler.setMode(mode: "Investigation" | "Raid" | "Syndicate" | "None")
	currentMode = mode
end

function InputHandler.getMode(): string
	return currentMode
end

return InputHandler
