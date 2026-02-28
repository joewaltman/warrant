--!strict
-- Server entry | WARRANT: Case Closed
-- Initializes all server systems and wires up RemoteEvent handlers
-- Branches at runtime: reserved servers run CaseServerInit, public servers run the hub.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("[Server] WARRANT: Case Closed loading...")

------------------------------------------------------------------------
-- EARLY BRANCH: RESERVED SERVER → CASE SERVER
------------------------------------------------------------------------
local TeleportManager = require(script.TeleportManager)

if TeleportManager.isReservedServer() then
	-- CASE SERVER: delegate entirely to CaseServerInit
	require(script.CaseServerInit).start()
	return
end

------------------------------------------------------------------------
-- HUB SERVER: Everything below runs only on public servers
------------------------------------------------------------------------
print("[Hub] Initializing hub server...")

------------------------------------------------------------------------
-- STEP 1: CREATE ALL REMOTE EVENTS FIRST (before anything else)
-- This prevents client WaitForChild hangs if module loads fail.
------------------------------------------------------------------------
local ALL_REMOTES = {
	"RequestCase", "RequestBreach", "RequestInteract",
	"RequestFireWeapon", "RequestWeaponSwitch", "RequestArrest",
	"RequestMedkit", "RequestIdentify",
	"JoinSyndicateQueue", "LeaveSyndicateQueue",
	"CaseLoaded", "CaseStateChanged", "CaseCompleted", "CaseAbandoned",
	"IntelUpdated", "IntelTierChanged", "BreachInitiated",
	"RaidStarted", "RaidEnded",
	"WeaponEquipped", "PlayerHealthChanged", "PlayerDowned",
	"ScorePresented",
	"PlayerDataLoaded", "LevelUp", "RankUp", "XPAwarded",
	"TitleUnlocked", "BadgeUnlocked",
	"QueueJoined", "QueueLeft", "MatchFound",
	"SetupPhaseStarted", "WaitingForSetup", "DetectivePhaseStarted",
	"MatchEnded", "SuspectExposed", "TeamMateExposed",
	"OpenCaseBoard",
	"RequestProfileData", "ProfileDataLoaded",
	"EvidencePositions",
	"TutorialProgress",
	"NPCFired", "SuspectArrested",
	-- Party remotes
	"PartyInvite", "PartyAccept", "PartyLeave",
}

for _, name in ALL_REMOTES do
	if not ReplicatedStorage:FindFirstChild(name) then
		local remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = ReplicatedStorage
	end
end

print("[Hub] RemoteEvents created")

------------------------------------------------------------------------
-- STEP 2: LOAD SHARED MODULES
------------------------------------------------------------------------
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Types = require(Shared:WaitForChild("Types"))
local GameConfig = require(Shared:WaitForChild("GameConfig"))

print("[Hub] Shared modules loaded")

------------------------------------------------------------------------
-- STEP 3: LOAD SERVER MODULES (with error reporting)
------------------------------------------------------------------------
local function safeRequire(moduleScript: ModuleScript): any
	local success, result = pcall(require, moduleScript)
	if not success then
		warn("[Hub] Failed to load", moduleScript.Name, ":", result)
		return nil
	end
	return result
end

local CaseManager = safeRequire(script.CaseManager)
local ProgressionSystem = safeRequire(script.ProgressionSystem)
local SyndicateMatch = safeRequire(script.SyndicateMatch)
local AntiExploit = safeRequire(script.AntiExploit)
local PrecinctBuilder = safeRequire(script.PrecinctBuilder)
local StatsTracker = safeRequire(script.StatsTracker)
local PartyManager = safeRequire(script.PartyManager)

print("[Hub] Server modules loaded")

------------------------------------------------------------------------
-- STEP 4: BUILD PRECINCT
------------------------------------------------------------------------
local precinctModel: Model? = nil
local caseBoardPart: Part? = nil
local PRECINCT_SPAWN = Vector3.new(0, 5, -15)

if PrecinctBuilder then
	precinctModel, caseBoardPart = PrecinctBuilder.build()
	print("[Hub] Precinct built")

	-- Wire up the ProximityPrompt on the case board
	if caseBoardPart then
		local prompt = caseBoardPart:FindFirstChildOfClass("ProximityPrompt")
		if prompt then
			prompt.Triggered:Connect(function(player: Player)
				local remote = ReplicatedStorage:FindFirstChild("OpenCaseBoard") :: RemoteEvent
				if remote then
					remote:FireClient(player)
				end
			end)
		end
	end
else
	-- Fallback: create a basic spawn platform
	local platform = Instance.new("SpawnLocation")
	platform.Size = Vector3.new(20, 1, 20)
	platform.Position = Vector3.new(0, 0, 0)
	platform.Anchored = true
	platform.Material = Enum.Material.Concrete
	platform.Color = Color3.fromRGB(100, 100, 100)
	platform.Parent = workspace
	warn("[Hub] PrecinctBuilder failed, using fallback spawn")
end

------------------------------------------------------------------------
-- STEP 4B: AMBIENT LIGHTING
------------------------------------------------------------------------
do
	local Lighting = game:GetService("Lighting")
	Lighting.Ambient = Color3.fromRGB(40, 40, 50)
	Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 70)
	Lighting.Brightness = 0.5
	Lighting.ClockTime = 21 -- nighttime (9 PM)
	Lighting.FogEnd = 500
	Lighting.FogColor = Color3.fromRGB(20, 20, 30)

	local atmosphere = Instance.new("Atmosphere")
	atmosphere.Density = 0.3
	atmosphere.Offset = 0.25
	atmosphere.Color = Color3.fromRGB(40, 50, 80)
	atmosphere.Decay = Color3.fromRGB(30, 30, 40)
	atmosphere.Glare = 0
	atmosphere.Haze = 2
	atmosphere.Parent = Lighting

	local colorCorrection = Instance.new("ColorCorrectionEffect")
	colorCorrection.Brightness = -0.05
	colorCorrection.Contrast = 0.15
	colorCorrection.Saturation = -0.1
	colorCorrection.TintColor = Color3.fromRGB(220, 230, 255)
	colorCorrection.Parent = Lighting

	local bloom = Instance.new("BloomEffect")
	bloom.Intensity = 0.3
	bloom.Size = 24
	bloom.Threshold = 2
	bloom.Parent = Lighting

	print("[Hub] Ambient lighting configured")
end

------------------------------------------------------------------------
-- HELPERS
------------------------------------------------------------------------
local function getRemote(name: string): RemoteEvent
	return ReplicatedStorage:FindFirstChild(name) :: RemoteEvent
end

------------------------------------------------------------------------
-- PLAYER JOIN / LEAVE
------------------------------------------------------------------------
Players.PlayerAdded:Connect(function(player: Player)
	if ProgressionSystem then
		ProgressionSystem.loadPlayer(player)
	end
	print("[Hub] Player joined:", player.Name)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	-- If player is teleporting to a case server, skip DataStore save
	if TeleportManager.isPlayerTeleporting(player) then
		TeleportManager.clearTeleportingFlag(player)
		-- Still clean up non-persistent state
		if SyndicateMatch then SyndicateMatch.onPlayerRemoving(player) end
		if AntiExploit then AntiExploit.cleanup(player) end
		if PartyManager then PartyManager.onPlayerRemoving(player) end
		print("[Hub] Player teleporting to case server, skipping save:", player.Name)
		return
	end

	if ProgressionSystem then ProgressionSystem.cleanup(player) end
	if SyndicateMatch then SyndicateMatch.onPlayerRemoving(player) end
	if AntiExploit then AntiExploit.cleanup(player) end
	if PartyManager then PartyManager.onPlayerRemoving(player) end
end)

------------------------------------------------------------------------
-- CASE SELECTION → TELEPORT TO RESERVED SERVER
------------------------------------------------------------------------
getRemote("RequestCase").OnServerEvent:Connect(function(player: Player, caseId: unknown)
	if typeof(caseId) ~= "string" or not CaseManager then
		return
	end

	local caseFolder = CaseManager.getCaseFolder(caseId :: string)
	if not caseFolder then
		return
	end

	local configModule = caseFolder:FindFirstChild("CaseConfig") :: ModuleScript?
	if not configModule then
		return
	end

	local config = require(configModule) :: any
	local caseData = config.getData()

	if ProgressionSystem and not ProgressionSystem.isCaseAvailable(player, caseData.difficulty) then
		return
	end

	if CaseManager.isOnCooldown(player, caseId :: string) then
		return
	end

	-- Gather party members (or just the solo player)
	local playersToTeleport: { Player }
	if PartyManager then
		local party = PartyManager.getParty(player)
		playersToTeleport = party or { player }
	else
		playersToTeleport = { player }
	end

	-- Teleport to a reserved case server
	TeleportManager.teleportToCase(playersToTeleport, caseId :: string)
end)

------------------------------------------------------------------------
-- SYNDICATE MODE
------------------------------------------------------------------------
getRemote("JoinSyndicateQueue").OnServerEvent:Connect(function(player: Player, preference: unknown)
	if typeof(preference) ~= "string" or not SyndicateMatch then
		return
	end
	local validPrefs = { Detective = true, Syndicate = true, NoPreference = true }
	if not validPrefs[preference :: string] then
		return
	end
	SyndicateMatch.joinQueue(player, preference :: Types.SyndicateRolePreference)
end)

getRemote("LeaveSyndicateQueue").OnServerEvent:Connect(function(player: Player)
	if SyndicateMatch then
		SyndicateMatch.leaveQueue(player)
	end
end)

getRemote("RequestIdentify").OnServerEvent:Connect(function(player: Player)
	if not SyndicateMatch then
		return
	end

	local character = player.Character
	if not character then
		return
	end
	local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not rootPart then
		return
	end

	for _, otherPlayer in Players:GetPlayers() do
		if otherPlayer ~= player then
			local otherChar = otherPlayer.Character
			if otherChar then
				local otherRoot = otherChar:FindFirstChild("HumanoidRootPart") :: BasePart?
				if otherRoot and (otherRoot.Position - rootPart.Position).Magnitude <= 10 then
					SyndicateMatch.identifySuspect(player, otherPlayer)
					break
				end
			end
		end
	end
end)

------------------------------------------------------------------------
-- PROFILE DATA
------------------------------------------------------------------------
getRemote("RequestProfileData").OnServerEvent:Connect(function(player: Player)
	if StatsTracker then
		StatsTracker.sendProfileData(player)
	end
end)

------------------------------------------------------------------------
-- TUTORIAL PROGRESS
------------------------------------------------------------------------
getRemote("TutorialProgress").OnServerEvent:Connect(function(player: Player, step: unknown)
	if typeof(step) ~= "number" then
		return
	end

	if ProgressionSystem then
		local data = ProgressionSystem.getPlayerData(player)
		if data and (step :: number) > data.tutorialStep then
			data.tutorialStep = step :: number
		end
	end
end)

------------------------------------------------------------------------
-- PARTY REMOTES
------------------------------------------------------------------------
getRemote("PartyInvite").OnServerEvent:Connect(function(player: Player, targetName: unknown)
	if typeof(targetName) ~= "string" or not PartyManager then
		return
	end

	local targetPlayer = Players:FindFirstChild(targetName :: string) :: Player?
	if not targetPlayer then
		return
	end

	-- Create party if leader doesn't have one
	local partyInfo = PartyManager.getPartyInfo(player)
	if not partyInfo then
		PartyManager.createParty(player)
	end

	-- Send invite to target player
	local partyInfoNow = PartyManager.getPartyInfo(player)
	if partyInfoNow then
		getRemote("PartyInvite"):FireClient(targetPlayer, {
			partyId = partyInfoNow.partyId,
			leaderName = player.Name,
		})
	end
end)

getRemote("PartyAccept").OnServerEvent:Connect(function(player: Player, partyId: unknown)
	if typeof(partyId) ~= "string" or not PartyManager then
		return
	end
	PartyManager.joinParty(player, partyId :: string)
end)

getRemote("PartyLeave").OnServerEvent:Connect(function(player: Player)
	if PartyManager then
		PartyManager.leaveParty(player)
	end
end)

print("[Hub] WARRANT: Case Closed hub server loaded successfully")
