local Players = game:GetService("Players")

local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UI"))
end)

if not success then
    warn("Could not require UI module locally. Make sure it's named UI.lua")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UpscaledKarpiwareHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()
local Window = UI:CreateWindow(ScreenGui, "Modern Hub", "Fluid & Animated Interface")

local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373")
local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")

-- LEGITBOT TAB PROPERTIES
local TopLeft = UI:CreateSection(LegitbotTab, nil, "Left")
UI:CreateToggle(TopLeft, "Aimbot enabled", false)

-- DROPDOWN EXAMPLES
UI:CreateDropdown(TopLeft, "Hitbox", {"Head", "Neck", "Torso", "Legs"}, "Head", function(selected)
    print("Aimbot Hitbox changed to:", selected)
end)

UI:CreateMultiDropdown(TopLeft, "Target Selection", {"Distance", "Health", "FOV", "Threat"}, {"FOV"}, function(selectedList)
    print("Multi Target Selection changed")
    for k, v in pairs(selectedList) do
        if v then print("- Selected:", k) end
    end
end)

UI:CreateSlider(TopLeft, "Field of view", 0, 360, 180)

local TopRight = UI:CreateSection(LegitbotTab, nil, "Right")
UI:CreateSlider(TopRight, "Minimum damage", 0, 100, 30)
UI:CreateToggle(TopRight, "Automatic penetration", true)

-- VISUALS TAB
local EspSection = UI:CreateSection(VisualsTab, "ESP", "Left")
UI:CreateToggle(EspSection, "Box ESP", true)
UI:CreateMultiDropdown(EspSection, "Filter", {"Enemies", "Teammates", "NPCs", "Items"}, {"Enemies", "Items"}, function(sel)
    print("ESP Filter updated")
end)

local SettingsSection = UI:CreateSection(VisualsTab, "System", "Right")
UI:CreateButton(SettingsSection, "Arayüzü Kapat", function() ScreenGui:Destroy() end)

print("Dropdown components UI loaded successfully!")
