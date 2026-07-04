-- Example Usage of the Karpiware-style Tabbed Roblox UI Framework

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

-- Tabs
local LegitTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://6031094678")
local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")
local SettingsTab = UI:CreateTab(Window, "Settings", "rbxassetid://7059346373")

-- LEGITBOT TAB SECTIONS --

-- Left Column
local AimbotSection = UI:CreateSection(LegitTab, "Aimbot", "Left")
UI:CreateToggle(AimbotSection, "Aimbot enabled", false)
UI:CreateToggle(AimbotSection, "Silent aim", false)
UI:CreateSlider(AimbotSection, "Field of view", 0, 360, 180)
UI:CreateToggle(AimbotSection, "Override resolver", false)

local MovementSection = UI:CreateSection(LegitTab, "Movement", "Left")
UI:CreateToggle(MovementSection, "Autostrafe", false)
UI:CreateSlider(MovementSection, "Strafe speed", 0, 100, 50)
UI:CreateToggle(MovementSection, "Bhop", true)

-- Right Column
local WeaponSection = UI:CreateSection(LegitTab, "Weapon", "Right")
UI:CreateSlider(WeaponSection, "Minimum damage", 0, 100, 30)
UI:CreateToggle(WeaponSection, "Automatic penetration", true)
UI:CreateToggle(WeaponSection, "Force body aim", false)
UI:CreateToggle(WeaponSection, "Delay shot", false)

local MiscSection = UI:CreateSection(LegitTab, "Miscellaneous", "Right")
UI:CreateToggle(MiscSection, "Auto stop", true)
UI:CreateToggle(MiscSection, "Hide shots", false)
UI:CreateSlider(MiscSection, "Fake lag limit", 0, 14, 14)


-- SETTINGS TAB --
local UiSection = UI:CreateSection(SettingsTab, "Interface", "Left")
-- Simple custom button using a toggle style visually, but just to show it's here
UI:CreateToggle(UiSection, "Dark Mode", true)

print("Karpiware UI loaded successfully!")
