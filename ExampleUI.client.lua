-- Example Usage of the new Tabbed Roblox UI Framework
-- Place this in StarterPlayerScripts or StarterGui
-- In an executor, just use loadstring on UI.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UI"))
end)

if not success then
    -- Fallback for executors / loadstring testing
    -- In a real repo, this would be the raw github url
    warn("Could not require UI module locally. Make sure it's named UI.lua")
    return
end

-- Create the main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlassmorphismHub"
ScreenGui.ResetOnSpawn = false

-- Use CoreGui if available (Exploit environment), else PlayerGui (Studio environment)
local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

-- Initialize Framework
local UI = UIFramework.new()

-- Create the main window
local Window = UI:CreateWindow(ScreenGui, "Antigravity Hub")

-- Create Tabs
-- We use minimalist Lucide/Material icon asset IDs instead of emojis
local HomeTab = UI:CreateTab(Window, "Ana Sayfa", "rbxassetid://6031094678") -- Home icon
local PlayerTab = UI:CreateTab(Window, "Karakter", "rbxassetid://6031290374") -- User icon
local SettingsTab = UI:CreateTab(Window, "Ayarlar", "rbxassetid://7059346373") -- Gear icon

-- Add elements to the Home Tab
UI:CreateButton(HomeTab, "Hoşgeldin!", function()
    print("Ana sayfadasın.")
end)
UI:CreateToggle(HomeTab, "Otomatik Kasılma", false)

-- Add elements to the Player Tab
UI:CreateSlider(PlayerTab, "Yürüme Hızı", 16, 200, 50)
UI:CreateSlider(PlayerTab, "Zıplama Gücü", 50, 300, 100)
UI:CreateToggle(PlayerTab, "Görünmezlik (ESP)", true)

-- Add elements to the Settings Tab
UI:CreateButton(SettingsTab, "Arayüzü Kapat", function()
    ScreenGui:Destroy()
end)

print("Tabbed Glassmorphism UI loaded successfully!")
