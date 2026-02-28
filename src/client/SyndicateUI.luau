--!strict
-- SyndicateUI | WARRANT: Case Closed
-- Client UI for Syndicate mode: queue screen, role display, setup phase, match HUD

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))

type SyndicateRolePreference = Types.SyndicateRolePreference

local SyndicateUI = {}

local screenGui: ScreenGui? = nil
local queueFrame: Frame? = nil
local matchHUDFrame: Frame? = nil
local roleLabel: TextLabel? = nil
local phaseLabel: TextLabel? = nil
local timerLabel: TextLabel? = nil

local function createUI()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SyndicateUI"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = PlayerGui

	-- Queue screen
	queueFrame = Instance.new("Frame")
	queueFrame.Name = "QueueFrame"
	queueFrame.Size = UDim2.new(0, 400, 0, 350)
	queueFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
	queueFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	queueFrame.BackgroundTransparency = 0.05
	queueFrame.BorderSizePixel = 0
	queueFrame.Parent = screenGui

	local qCorner = Instance.new("UICorner")
	qCorner.CornerRadius = UDim.new(0, 12)
	qCorner.Parent = queueFrame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.BackgroundTransparency = 1
	title.Text = "SYNDICATE MODE"
	title.TextColor3 = Color3.fromRGB(200, 80, 80)
	title.TextSize = 22
	title.Font = Enum.Font.GothamBold
	title.Parent = queueFrame

	local subtitle = Instance.new("TextLabel")
	subtitle.Size = UDim2.new(1, 0, 0, 24)
	subtitle.Position = UDim2.new(0, 0, 0, 48)
	subtitle.BackgroundTransparency = 1
	subtitle.Text = "Select your preference:"
	subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
	subtitle.TextSize = 14
	subtitle.Font = Enum.Font.Gotham
	subtitle.Parent = queueFrame

	-- Role preference buttons
	local preferences: { { label: string, value: SyndicateRolePreference, color: Color3, desc: string } } = {
		{ label = "Detective", value = "Detective", color = Color3.fromRGB(60, 130, 220), desc = "Investigate and arrest" },
		{ label = "Syndicate", value = "Syndicate", color = Color3.fromRGB(200, 60, 60), desc = "Hide and deceive" },
		{ label = "No Preference", value = "NoPreference", color = Color3.fromRGB(120, 120, 140), desc = "Fastest queue + 5% XP" },
	}

	for i, pref in preferences do
		local btn = Instance.new("TextButton")
		btn.Name = pref.value
		btn.Size = UDim2.new(0, 340, 0, 50)
		btn.Position = UDim2.new(0.5, -170, 0, 80 + (i - 1) * 60)
		btn.BackgroundColor3 = pref.color
		btn.Text = pref.label
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 16
		btn.Font = Enum.Font.GothamBold
		btn.BorderSizePixel = 0
		btn.Parent = queueFrame

		local bCorner = Instance.new("UICorner")
		bCorner.CornerRadius = UDim.new(0, 8)
		bCorner.Parent = btn

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, 0, 0, 16)
		descLabel.Position = UDim2.new(0, 0, 1, -18)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = pref.desc
		descLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		descLabel.TextSize = 10
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextTransparency = 0.3
		descLabel.Parent = btn

		local val = pref.value
		btn.MouseButton1Click:Connect(function()
			local remote = ReplicatedStorage:FindFirstChild("JoinSyndicateQueue") :: RemoteEvent?
			if remote then
				remote:FireServer(val)
			end
			SyndicateUI.showWaiting()
		end)
	end

	-- Close button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 100, 0, 36)
	closeBtn.Position = UDim2.new(0.5, -50, 1, -50)
	closeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
	closeBtn.Text = "BACK"
	closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	closeBtn.TextSize = 14
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.BorderSizePixel = 0
	closeBtn.Parent = queueFrame

	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(0, 6)
	cCorner.Parent = closeBtn

	closeBtn.MouseButton1Click:Connect(function()
		SyndicateUI.hide()
		local remote = ReplicatedStorage:FindFirstChild("LeaveSyndicateQueue") :: RemoteEvent?
		if remote then
			remote:FireServer()
		end
	end)

	-- Match HUD (shown during match)
	matchHUDFrame = Instance.new("Frame")
	matchHUDFrame.Name = "MatchHUD"
	matchHUDFrame.Size = UDim2.new(0, 250, 0, 60)
	matchHUDFrame.Position = UDim2.new(0.5, -125, 0, 10)
	matchHUDFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	matchHUDFrame.BackgroundTransparency = 0.2
	matchHUDFrame.BorderSizePixel = 0
	matchHUDFrame.Visible = false
	matchHUDFrame.Parent = screenGui

	local mCorner = Instance.new("UICorner")
	mCorner.CornerRadius = UDim.new(0, 8)
	mCorner.Parent = matchHUDFrame

	roleLabel = Instance.new("TextLabel")
	roleLabel.Size = UDim2.new(0.5, -5, 0, 24)
	roleLabel.Position = UDim2.new(0, 10, 0, 5)
	roleLabel.BackgroundTransparency = 1
	roleLabel.Text = "DETECTIVE"
	roleLabel.TextColor3 = Color3.fromRGB(60, 130, 220)
	roleLabel.TextSize = 14
	roleLabel.Font = Enum.Font.GothamBold
	roleLabel.TextXAlignment = Enum.TextXAlignment.Left
	roleLabel.Parent = matchHUDFrame

	phaseLabel = Instance.new("TextLabel")
	phaseLabel.Size = UDim2.new(0.5, -5, 0, 24)
	phaseLabel.Position = UDim2.new(0.5, 0, 0, 5)
	phaseLabel.BackgroundTransparency = 1
	phaseLabel.Text = "Setup Phase"
	phaseLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	phaseLabel.TextSize = 14
	phaseLabel.Font = Enum.Font.Gotham
	phaseLabel.TextXAlignment = Enum.TextXAlignment.Right
	phaseLabel.Parent = matchHUDFrame

	timerLabel = Instance.new("TextLabel")
	timerLabel.Size = UDim2.new(1, -20, 0, 24)
	timerLabel.Position = UDim2.new(0, 10, 0, 32)
	timerLabel.BackgroundTransparency = 1
	timerLabel.Text = "8:00"
	timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	timerLabel.TextSize = 20
	timerLabel.Font = Enum.Font.GothamBold
	timerLabel.Parent = matchHUDFrame
end

function SyndicateUI.init()
	createUI()

	local matchFound = ReplicatedStorage:WaitForChild("MatchFound", 10) :: RemoteEvent?
	if matchFound then
		matchFound.OnClientEvent:Connect(function(data: any)
			SyndicateUI.showMatchHUD(data.role)
		end)
	end

	local setupStarted = ReplicatedStorage:WaitForChild("SetupPhaseStarted", 10) :: RemoteEvent?
	if setupStarted then
		setupStarted.OnClientEvent:Connect(function(data: any)
			SyndicateUI.updatePhase("Syndicate Setup", data.duration)
		end)
	end

	local detectivePhase = ReplicatedStorage:WaitForChild("DetectivePhaseStarted", 10) :: RemoteEvent?
	if detectivePhase then
		detectivePhase.OnClientEvent:Connect(function(data: any)
			SyndicateUI.updatePhase("Detective Phase", data.duration)
		end)
	end

	local matchEnded = ReplicatedStorage:WaitForChild("MatchEnded", 10) :: RemoteEvent?
	if matchEnded then
		matchEnded.OnClientEvent:Connect(function(data: any)
			SyndicateUI.showResult(data.winner, data.reason, data.isWinner)
		end)
	end
end

function SyndicateUI.show()
	if screenGui then
		screenGui.Enabled = true
		if queueFrame then
			queueFrame.Visible = true
		end
		if matchHUDFrame then
			matchHUDFrame.Visible = false
		end
	end
end

function SyndicateUI.hide()
	if screenGui then
		screenGui.Enabled = false
	end
end

function SyndicateUI.showWaiting()
	-- Could add a "searching..." animation here
end

function SyndicateUI.showMatchHUD(role: string)
	if queueFrame then
		queueFrame.Visible = false
	end
	if matchHUDFrame then
		matchHUDFrame.Visible = true
	end
	if roleLabel then
		roleLabel.Text = string.upper(role)
		roleLabel.TextColor3 = if role == "Detective"
			then Color3.fromRGB(60, 130, 220)
			else Color3.fromRGB(200, 60, 60)
	end
end

function SyndicateUI.updatePhase(phase: string, duration: number)
	if phaseLabel then
		phaseLabel.Text = phase
	end

	-- Countdown timer
	task.spawn(function()
		local remaining = duration
		while remaining > 0 do
			if timerLabel then
				local mins = math.floor(remaining / 60)
				local secs = math.floor(remaining % 60)
				timerLabel.Text = string.format("%d:%02d", mins, secs)
			end
			task.wait(1)
			remaining -= 1
		end
	end)
end

function SyndicateUI.showResult(winner: string, reason: string, isWinner: boolean)
	if matchHUDFrame then
		matchHUDFrame.Visible = false
	end

	-- Simple result overlay
	local resultFrame = Instance.new("Frame")
	resultFrame.Size = UDim2.new(0, 400, 0, 200)
	resultFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
	resultFrame.BackgroundColor3 = if isWinner then Color3.fromRGB(30, 60, 30) else Color3.fromRGB(60, 30, 30)
	resultFrame.BorderSizePixel = 0
	resultFrame.Parent = screenGui

	local rCorner = Instance.new("UICorner")
	rCorner.CornerRadius = UDim.new(0, 12)
	rCorner.Parent = resultFrame

	local resultTitle = Instance.new("TextLabel")
	resultTitle.Size = UDim2.new(1, 0, 0, 50)
	resultTitle.Position = UDim2.new(0, 0, 0, 30)
	resultTitle.BackgroundTransparency = 1
	resultTitle.Text = if isWinner then "VICTORY" else "DEFEAT"
	resultTitle.TextColor3 = if isWinner then Color3.fromRGB(100, 255, 100) else Color3.fromRGB(255, 100, 100)
	resultTitle.TextSize = 32
	resultTitle.Font = Enum.Font.GothamBold
	resultTitle.Parent = resultFrame

	local reasonLabel = Instance.new("TextLabel")
	reasonLabel.Size = UDim2.new(1, 0, 0, 30)
	reasonLabel.Position = UDim2.new(0, 0, 0, 90)
	reasonLabel.BackgroundTransparency = 1
	reasonLabel.Text = winner .. " wins: " .. reason
	reasonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	reasonLabel.TextSize = 16
	reasonLabel.Font = Enum.Font.Gotham
	reasonLabel.Parent = resultFrame

	task.spawn(function()
		task.wait(10)
		resultFrame:Destroy()
		SyndicateUI.hide()
	end)
end

function SyndicateUI.destroy()
	if screenGui then
		screenGui:Destroy()
		screenGui = nil
	end
end

return SyndicateUI
