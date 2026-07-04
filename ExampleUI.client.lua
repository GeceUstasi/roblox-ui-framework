local Players = game:GetService("Players")

local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UI"))
end)

if not success then
    warn("Could not require UI module locally. Make sure it's named UI.lua")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KarpiwareHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()
local Window = UI:CreateWindow(ScreenGui, "Karpiware 0.1.0", "Super Cool Exploit Interface")

-- TABS (Exact match from screenshot)
local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373") -- target/crosshair
local AntiAimTab = UI:CreateTab(Window, "Anti-Aim", "rbxassetid://7059346373")
local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://7059346373")
local SkinsTab = UI:CreateTab(Window, "Skins", "rbxassetid://7059346373")
local MiscTab = UI:CreateTab(Window, "Miscellaneous", "rbxassetid://7059346373")
local ConfigsTab = UI:CreateTab(Window, "Configs", "rbxassetid://7059346373")
local ScriptsTab = UI:CreateTab(Window, "Scripts", "rbxassetid://7059346373")

-- LEGITBOT TAB PROPERTIES (From red circles) --

-- Top Left Box (No Title)
local TopLeft = UI:CreateSection(LegitbotTab, nil, "Left")
UI:CreateToggle(TopLeft, "Aimbot enabled", false)
UI:CreateToggle(TopLeft, "Silent aim", false)
UI:CreateSlider(TopLeft, "Field of view", 0, 360, 180)
UI:CreateToggle(TopLeft, "Override resolver", false)

-- Top Right Box (No Title)
local TopRight = UI:CreateSection(LegitbotTab, nil, "Right")
UI:CreateSlider(TopRight, "Minimum damage", 0, 100, 30)
UI:CreateToggle(TopRight, "Automatic penetration", true)
UI:CreateToggle(TopRight, "Force body aim", false)
UI:CreateToggle(TopRight, "Delay shot", false)
-- Extra options faintly visible below "Delay shot"
UI:CreateToggle(TopRight, "Hitchance", false)
UI:CreateToggle(TopRight, "Multiple hitbox...", false)
UI:CreateToggle(TopRight, "Auto stop condition...", false)

-- Bottom Left Box
local BottomLeft = UI:CreateSection(LegitbotTab, nil, "Left")
UI:CreateToggle(BottomLeft, "Autostrafe", false)
UI:CreateSlider(BottomLeft, "Strafe speed", 0, 100, 50)
UI:CreateToggle(BottomLeft, "Strafe point scale", false)
UI:CreateSlider(BottomLeft, "Strafe scale", 0, 100, 70)
UI:CreateSlider(BottomLeft, "Strafe p. scale", 0, 100, 60)
UI:CreateToggle(BottomLeft, "Force directional...", false)

-- Bottom Right Box
local BottomRight = UI:CreateSection(LegitbotTab, nil, "Right")
UI:CreateToggle(BottomRight, "Double tap", false)
UI:CreateToggle(BottomRight, "Hide shots", false)
UI:CreateSlider(BottomRight, "Expand fake lag limit", 0, 14, 14)

print("Karpiware exact match UI loaded successfully!")
