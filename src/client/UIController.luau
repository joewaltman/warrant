--!strict
-- UIController | WARRANT: Case Closed
-- Central client UI manager: coordinates HUD elements, screen transitions, modal overlays

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

export type UIScreen = "Precinct" | "CaseBoard" | "Investigation" | "Raid" | "Scoring" | "Syndicate" | "SyndicateQueue"

local UIController = {}

local currentScreen: UIScreen = "Precinct"
local screenModules: { [UIScreen]: any } = {}

function UIController.registerScreen(screen: UIScreen, module: any)
	screenModules[screen] = module
end

function UIController.getCurrentScreen(): UIScreen
	return currentScreen
end

function UIController.switchScreen(screen: UIScreen)
	-- Hide current screen
	local currentModule = screenModules[currentScreen]
	if currentModule and currentModule.hide then
		currentModule.hide()
	end

	-- Show new screen
	currentScreen = screen
	local newModule = screenModules[screen]
	if newModule and newModule.show then
		newModule.show()
	end

	print("[UIController] Screen:", screen)
end

function UIController.showNotification(title: string, message: string, duration: number?)
	local gui = Instance.new("ScreenGui")
	gui.Name = "Notification"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 100
	gui.Parent = PlayerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 350, 0, 80)
	frame.Position = UDim2.new(0.5, -175, 0, -90)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 28)
	titleLabel.Position = UDim2.new(0, 10, 0, 8)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = frame

	local msgLabel = Instance.new("TextLabel")
	msgLabel.Size = UDim2.new(1, -20, 0, 28)
	msgLabel.Position = UDim2.new(0, 10, 0, 38)
	msgLabel.BackgroundTransparency = 1
	msgLabel.Text = message
	msgLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	msgLabel.TextSize = 14
	msgLabel.Font = Enum.Font.Gotham
	msgLabel.TextXAlignment = Enum.TextXAlignment.Left
	msgLabel.Parent = frame

	-- Slide in animation
	task.spawn(function()
		for i = 0, 10 do
			frame.Position = UDim2.new(0.5, -175, 0, -90 + (i * 10))
			task.wait(0.02)
		end

		task.wait(duration or 3)

		-- Slide out
		for i = 0, 10 do
			frame.Position = UDim2.new(0.5, -175, 0, 10 - (i * 10))
			task.wait(0.02)
		end

		gui:Destroy()
	end)
end

function UIController.init()
	-- Listen for case state changes
	local caseLoaded = ReplicatedStorage:WaitForChild("CaseLoaded", 10) :: RemoteEvent?
	if caseLoaded then
		caseLoaded.OnClientEvent:Connect(function(data: any)
			UIController.switchScreen("Investigation")
			UIController.showNotification("Case Loaded", data.caseName)
		end)
	end

	local caseStateChanged = ReplicatedStorage:WaitForChild("CaseStateChanged", 10) :: RemoteEvent?
	if caseStateChanged then
		caseStateChanged.OnClientEvent:Connect(function(state: string)
			if state == "Raiding" then
				UIController.switchScreen("Raid")
			elseif state == "Scoring" then
				UIController.switchScreen("Scoring")
			elseif state == "Complete" then
				UIController.switchScreen("Precinct")
			end
		end)
	end

	local levelUp = ReplicatedStorage:WaitForChild("LevelUp", 10) :: RemoteEvent?
	if levelUp then
		levelUp.OnClientEvent:Connect(function(data: any)
			UIController.showNotification("Level Up!", "You are now level " .. tostring(data.newLevel), 5)
		end)
	end

	local rankUp = ReplicatedStorage:WaitForChild("RankUp", 10) :: RemoteEvent?
	if rankUp then
		rankUp.OnClientEvent:Connect(function(data: any)
			UIController.showNotification("Rank Up!", "You are now a " .. data.newRank, 7)
		end)
	end

	print("[UIController] Initialized")
end

return UIController
