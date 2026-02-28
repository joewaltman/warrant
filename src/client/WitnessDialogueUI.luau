--!strict
-- WitnessDialogueUI | WARRANT: Case Closed
-- Client module that shows a bottom-screen dialogue popup when a witness clue is discovered
-- Displays witness name, quote text, and "+2 Intel Points" indicator. Auto-dismisses after 5 seconds.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local WitnessDialogueUI = {}

local screenGui: ScreenGui? = nil
local dialogueFrame: Frame? = nil
local dismissThread: thread? = nil

local function createUI()
	if screenGui then
		return
	end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "WitnessDialogueGui"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 15
	screenGui.Parent = PlayerGui

	-- Main frame at bottom center
	dialogueFrame = Instance.new("Frame")
	dialogueFrame.Name = "DialogueFrame"
	dialogueFrame.Size = UDim2.new(0, 420, 0, 110)
	dialogueFrame.Position = UDim2.new(0.5, -210, 1, -130)
	dialogueFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	dialogueFrame.BackgroundTransparency = 0.1
	dialogueFrame.BorderSizePixel = 0
	dialogueFrame.Visible = false
	dialogueFrame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = dialogueFrame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 220, 80)
	stroke.Thickness = 2
	stroke.Transparency = 0.3
	stroke.Parent = dialogueFrame

	-- Witness name label
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "WitnessName"
	nameLabel.Size = UDim2.new(1, -20, 0, 24)
	nameLabel.Position = UDim2.new(0, 10, 0, 8)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = ""
	nameLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
	nameLabel.TextSize = 16
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Parent = dialogueFrame

	-- Quote text label
	local quoteLabel = Instance.new("TextLabel")
	quoteLabel.Name = "QuoteText"
	quoteLabel.Size = UDim2.new(1, -20, 0, 44)
	quoteLabel.Position = UDim2.new(0, 10, 0, 34)
	quoteLabel.BackgroundTransparency = 1
	quoteLabel.Text = ""
	quoteLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
	quoteLabel.TextSize = 13
	quoteLabel.Font = Enum.Font.Gotham
	quoteLabel.TextXAlignment = Enum.TextXAlignment.Left
	quoteLabel.TextYAlignment = Enum.TextYAlignment.Top
	quoteLabel.TextWrapped = true
	quoteLabel.TextStrokeTransparency = 0.7
	quoteLabel.Parent = dialogueFrame

	-- Intel points indicator
	local intelLabel = Instance.new("TextLabel")
	intelLabel.Name = "IntelPoints"
	intelLabel.Size = UDim2.new(1, -20, 0, 20)
	intelLabel.Position = UDim2.new(0, 10, 1, -26)
	intelLabel.BackgroundTransparency = 1
	intelLabel.Text = "+2 Intel Points"
	intelLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
	intelLabel.TextSize = 14
	intelLabel.Font = Enum.Font.GothamBold
	intelLabel.TextXAlignment = Enum.TextXAlignment.Right
	intelLabel.TextStrokeTransparency = 0.5
	intelLabel.Parent = dialogueFrame
end

local function showDialogue(witnessName: string, dialogue: string)
	if not dialogueFrame then
		return
	end

	local nameLabel = dialogueFrame:FindFirstChild("WitnessName") :: TextLabel?
	local quoteLabel = dialogueFrame:FindFirstChild("QuoteText") :: TextLabel?

	if nameLabel then
		nameLabel.Text = witnessName
	end
	if quoteLabel then
		quoteLabel.Text = '"' .. dialogue .. '"'
	end

	dialogueFrame.Visible = true

	-- Cancel any existing dismiss timer
	if dismissThread then
		task.cancel(dismissThread)
	end

	dismissThread = task.delay(5, function()
		if dialogueFrame then
			dialogueFrame.Visible = false
		end
		dismissThread = nil
	end)
end

function WitnessDialogueUI.init()
	createUI()

	-- Listen for ClueDiscovered remote
	local clueDiscovered = ReplicatedStorage:WaitForChild("ClueDiscovered", 10)
	if clueDiscovered and clueDiscovered:IsA("RemoteEvent") then
		(clueDiscovered :: RemoteEvent).OnClientEvent:Connect(function(witnessName: string, dialogue: string)
			showDialogue(witnessName, dialogue)
		end)
	end
end

return WitnessDialogueUI
