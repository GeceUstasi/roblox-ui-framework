-- Example Usage of the Roblox UI Framework
-- Place this in StarterPlayerScripts or StarterGui
-- Ensure UIFramework module is correctly referenced (e.g. in ReplicatedStorage)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- Get the local player
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- In a real scenario, you'd require it from ReplicatedStorage
-- local UIFramework = require(ReplicatedStorage:WaitForChild("UIFramework"))
-- For the sake of this example, we assume it's a sibling of this script if placed in StarterGui:
local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UIFramework"))
end)

-- If the above fails, let's just make sure we tell the user how to set it up
if not success then
    warn("UIFramework module not found! Please place it in the same folder as this script, or update the require path.")
    return
end

-- Create the main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlassmorphismHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Initialize Framework
local UI = UIFramework.new()

-- Create the main window
local Window = UI:CreateWindow(ScreenGui, "Antigravity Hub")

-- Add some non-functional elegant UI elements
UI:CreateButton(Window, "Özellik 1 (İşlevsiz)", function()
    print("Özellik 1 tıklandı!")
end)

UI:CreateButton(Window, "Özellik 2 (İşlevsiz)", function()
    print("Özellik 2 tıklandı!")
end)

UI:CreateSlider(Window, "Hız Ayarı", 16, 100, 50)
UI:CreateSlider(Window, "Zıplama Gücü", 50, 200, 100)

UI:CreateToggle(Window, "Görünmezlik (ESP)", true)
UI:CreateToggle(Window, "Otomatik Tıklama", false)

-- Back button mock-up at the bottom
local BackButton = UI:CreateButton(Window, "Geri Dön (İşlevsiz)", function()
    print("Geri dön tıklandı!")
end)

-- Styling the back button a bit differently if we wanted to
-- but for now it just blends with the glassmorphism theme perfectly

print("Glassmorphism UI loaded successfully!")
