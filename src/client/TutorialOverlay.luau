--!strict
-- TutorialOverlay | WARRANT: Case Closed
-- First-time player onboarding with sequential popup hints

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local TutorialOverlay = {}

local screenGui: ScreenGui? = nil
local currentPopup: Frame? = nil
local currentStep = 0
local tutorialActive = false

local function getRemote(name: string): RemoteEvent?
	local remote = ReplicatedStorage:WaitForChild(name, 10)
	if not remote then return nil end
	return remote :: RemoteEvent
end

local TUTORIAL_STEPS = {
	{ step = 1, text = "Walk to the Case Board to start a case", trigger = "spawn" },
	{ step = 2, text = "Look for glowing evidence markers", trigger = "caseLoaded" },
	{ step = 3, text = "Press E to examine evidence", trigger = "nearEvidence" },
	{ step = 4, text = "Press F to breach when ready", trigger = "someEvidence" },
	{ step = 5, text = "Use 1-4 to switch weapons, click to fire", trigger = "breach" },
	{ step = 6, text = "Press E near suspects to arrest", trigger = "raid" },
}

local function dismissPopup()
	if currentPopup then
		currentPopup:Destroy()
		currentPopup = nil
	end
end

local function showPopup(text: string)
	dismissPopup()

	if not screenGui then return end

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 360, 0, 90)
	frame.Position = UDim2.new(0.5, -180, 1, -140)
	frame.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = frame

	local border = Instance.new("UIStroke")
	border.Color = Color3.fromRGB(80, 140, 255)
	border.Thickness = 2
	border.Parent = frame

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -20, 0, 40)
	textLabel.Position = UDim2.new(0, 10, 0, 8)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = text
	textLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextWrapped = true
	textLabel.Parent = frame

	local gotItBtn = Instance.new("TextButton")
	gotItBtn.Size = UDim2.new(0, 100, 0, 28)
	gotItBtn.Position = UDim2.new(0.5, -50, 1, -36)
	gotItBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
	gotItBtn.Text = "Got it"
	gotItBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	gotItBtn.TextSize = 14
	gotItBtn.Font = Enum.Font.GothamBold
	gotItBtn.BorderSizePixel = 0
	gotItBtn.Parent = frame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = gotItBtn

	gotItBtn.MouseButton1Click:Connect(function()
		dismissPopup()

		-- Persist progress
		local remote = getRemote("TutorialProgress")
		if remote then
			remote:FireServer(currentStep)
		end
	end)

	currentPopup = frame
end

local function tryShowStep(step: number)
	if not tutorialActive then return end
	if step <= currentStep then return end
	if step > #TUTORIAL_STEPS then return end

	currentStep = step
	showPopup(TUTORIAL_STEPS[step].text)
end

function TutorialOverlay.init()
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "TutorialGui"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 90
	screenGui.Parent = PlayerGui

	print("[TutorialOverlay] Initialized")
end

function TutorialOverlay.checkFirstTime(playerData: any)
	if not playerData then return end

	local completedCases = playerData.completedCases
	local tutorialStep = playerData.tutorialStep or 0

	-- Only show tutorial for new players
	local caseCount = 0
	if completedCases then
		for _ in completedCases do
			caseCount += 1
		end
	end

	if caseCount == 0 and tutorialStep < 6 then
		tutorialActive = true
		currentStep = tutorialStep

		-- Show first step if not completed
		if tutorialStep < 1 then
			tryShowStep(1)
		end
	end
end

function TutorialOverlay.onCaseLoaded()
	tryShowStep(2)
end

function TutorialOverlay.onNearEvidence()
	tryShowStep(3)
end

function TutorialOverlay.onSomeEvidence()
	tryShowStep(4)
end

function TutorialOverlay.onBreach()
	tryShowStep(5)
end

function TutorialOverlay.onRaid()
	tryShowStep(6)
end

function TutorialOverlay.complete()
	tutorialActive = false
	dismissPopup()
end

return TutorialOverlay
