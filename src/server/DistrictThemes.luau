--!strict
-- DistrictThemes | WARRANT: Case Closed
-- Visual theme lookup per district for LayoutBuilder

export type DistrictTheme = {
	wallMaterial: Enum.Material,
	wallColor: Color3,
	floorMaterial: Enum.Material,
	floorColor: Color3,
	ceilingMaterial: Enum.Material,
	ceilingColor: Color3,
	exteriorMaterial: Enum.Material,
	exteriorColor: Color3,
	groundMaterial: Enum.Material,
	groundColor: Color3,
	ambientColor: Color3,
	lightBrightness: number,
	fogColor: Color3?,
	fogEnd: number?,
	accentColor: Color3?,
}

local THEMES: { [string]: DistrictTheme } = {
	["Elm Heights"] = {
		wallMaterial = Enum.Material.SmoothPlastic,
		wallColor = Color3.fromRGB(200, 190, 175),
		floorMaterial = Enum.Material.WoodPlanks,
		floorColor = Color3.fromRGB(140, 110, 75),
		ceilingMaterial = Enum.Material.SmoothPlastic,
		ceilingColor = Color3.fromRGB(220, 215, 210),
		exteriorMaterial = Enum.Material.Brick,
		exteriorColor = Color3.fromRGB(160, 120, 90),
		groundMaterial = Enum.Material.Grass,
		groundColor = Color3.fromRGB(80, 130, 60),
		ambientColor = Color3.fromRGB(255, 245, 220),
		lightBrightness = 1.2,
	},
	["Dockside"] = {
		wallMaterial = Enum.Material.Metal,
		wallColor = Color3.fromRGB(100, 100, 110),
		floorMaterial = Enum.Material.Concrete,
		floorColor = Color3.fromRGB(80, 80, 85),
		ceilingMaterial = Enum.Material.DiamondPlate,
		ceilingColor = Color3.fromRGB(90, 90, 95),
		exteriorMaterial = Enum.Material.CorrodedMetal,
		exteriorColor = Color3.fromRGB(120, 90, 70),
		groundMaterial = Enum.Material.Concrete,
		groundColor = Color3.fromRGB(70, 70, 75),
		ambientColor = Color3.fromRGB(180, 200, 220),
		lightBrightness = 0.8,
	},
	["Neon Strip"] = {
		wallMaterial = Enum.Material.SmoothPlastic,
		wallColor = Color3.fromRGB(40, 30, 50),
		floorMaterial = Enum.Material.Marble,
		floorColor = Color3.fromRGB(30, 25, 35),
		ceilingMaterial = Enum.Material.SmoothPlastic,
		ceilingColor = Color3.fromRGB(25, 20, 30),
		exteriorMaterial = Enum.Material.SmoothPlastic,
		exteriorColor = Color3.fromRGB(35, 25, 45),
		groundMaterial = Enum.Material.Asphalt,
		groundColor = Color3.fromRGB(40, 40, 45),
		ambientColor = Color3.fromRGB(200, 100, 255),
		lightBrightness = 1.5,
		accentColor = Color3.fromRGB(255, 50, 200),
	},
	["Old Town"] = {
		wallMaterial = Enum.Material.Brick,
		wallColor = Color3.fromRGB(130, 90, 70),
		floorMaterial = Enum.Material.WoodPlanks,
		floorColor = Color3.fromRGB(100, 75, 55),
		ceilingMaterial = Enum.Material.Wood,
		ceilingColor = Color3.fromRGB(120, 90, 65),
		exteriorMaterial = Enum.Material.Cobblestone,
		exteriorColor = Color3.fromRGB(110, 100, 90),
		groundMaterial = Enum.Material.Cobblestone,
		groundColor = Color3.fromRGB(90, 85, 80),
		ambientColor = Color3.fromRGB(255, 220, 180),
		lightBrightness = 1.0,
	},
	["Financial District"] = {
		wallMaterial = Enum.Material.Granite,
		wallColor = Color3.fromRGB(200, 200, 210),
		floorMaterial = Enum.Material.Marble,
		floorColor = Color3.fromRGB(220, 215, 225),
		ceilingMaterial = Enum.Material.SmoothPlastic,
		ceilingColor = Color3.fromRGB(240, 240, 245),
		exteriorMaterial = Enum.Material.Glass,
		exteriorColor = Color3.fromRGB(180, 200, 220),
		groundMaterial = Enum.Material.Concrete,
		groundColor = Color3.fromRGB(130, 130, 135),
		ambientColor = Color3.fromRGB(220, 230, 255),
		lightBrightness = 1.8,
	},
}

local DistrictThemes = {}

function DistrictThemes.getTheme(districtName: string): DistrictTheme
	local theme = THEMES[districtName]
	if theme then
		return theme
	end
	-- Fallback to Elm Heights if district not found
	return THEMES["Elm Heights"]
end

return DistrictThemes
