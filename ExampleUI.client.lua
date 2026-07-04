local Players = game:GetService("Players")

local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UI"))
end)

if not success then
    warn("Could not require UI module locally. Make sure it's named UI.lua")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumKarpiwareHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()
local Window = UI:CreateWindow(ScreenGui, "Premium Hub", "Ultimate Feature Showcase")

local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373")
local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")

-- LEGITBOT TAB
local TopLeft = UI:CreateSection(LegitbotTab, "Aimbot", "Left")
UI:CreateToggle(TopLeft, "Aimbot enabled", false)

-- YENI: Tuş Atama Sistemi
UI:CreateKeybind(TopLeft, "Aimbot Key", Enum.KeyCode.F, function(key, isPressed)
    if isPressed then
        print("Aimbot key pressed:", key)
    else
        print("Aimbot key changed to:", key)
    end
end)

UI:CreateDropdown(TopLeft, "Hitbox", {"Head", "Neck", "Torso", "Legs"}, "Head", function(selected)
    print("Aimbot Hitbox changed to:", selected)
end)

UI:CreateMultiDropdown(TopLeft, "Target Selection", {"Distance", "Health", "FOV", "Threat"}, {"FOV"}, function(selectedList)
    print("Multi Target Selection changed")
end)

UI:CreateSlider(TopLeft, "Field of view", 0, 360, 180)


-- VISUALS TAB
local EspSection = UI:CreateSection(VisualsTab, "ESP Details", "Left")
UI:CreateToggle(EspSection, "Box ESP", true)

-- YENI: Renk Seçici (Color Picker)
UI:CreateColorPicker(EspSection, "Box Color", Color3.fromRGB(0, 255, 150), function(color)
    print("Box color changed to:", color)
end)

local SettingsSection = UI:CreateSection(VisualsTab, "System", "Right")
-- YENI: Bilgi Etiketi
UI:CreateLabel(SettingsSection, "Welcome to the Premium Hub!")

-- YENI: Metin Girişi (TextBox)
UI:CreateTextBox(SettingsSection, "Webhook URL", "https://discord.com/api...", false, function(text, enterPressed)
    print("Webhook set to:", text)
end)

UI:CreateButton(SettingsSection, "Arayüzü Kapat", function() ScreenGui:Destroy() end)

print("Premium UI Components loaded successfully!")
