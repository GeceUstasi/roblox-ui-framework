local Players = game:GetService("Players")

local success, UIFramework = pcall(function()
    return require(script.Parent:WaitForChild("UI"))
end)

if not success then
    warn("Could not require UI module locally. Make sure it's named UI.lua")
    return
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CompletePremiumHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()

-- OPTIONAL KEY SYSTEM (Key System'i devre disi birakmak icin bu blogu silin)
local KEY_SYSTEM_ENABLED = false -- true yaparsaniz key gerekir
if KEY_SYSTEM_ENABLED then
    UI:CreateKeySystem(ScreenGui, {"PREMIUM-2025", "VIP-KEY"}, function()
        -- Key basarili, hub yukleniyor
        loadHub()
    end, {
        Title = "Premium Hub Key",
        Subtitle = "Devam etmek icin gecerli bir anahtar girin.",
        MaxAttempts = 3
    })
    return
end

-- WATERMARK (Sol ust kose FPS gostergesi)
UI:CreateWatermark(ScreenGui, "Premium Hub v2.0")

-- ANA PENCERE
local Window = UI:CreateWindow(ScreenGui, "Premium Hub", "Full-Feature Showcase")

-- SEKMELER
local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373")
local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")

-- ═══════════════════════════════════════════════════
-- LEGITBOT SEKMESI
-- ═══════════════════════════════════════════════════
local AimbotSection = UI:CreateSection(LegitbotTab, "Aimbot", "Left")

UI:CreateToggle(AimbotSection, "Aimbot enabled", false)

UI:CreateKeybind(AimbotSection, "Aimbot Key", Enum.KeyCode.F, function(key, isPressed)
    if isPressed then
        print("Aimbot key pressed:", key)
    end
end)

UI:CreateDropdown(AimbotSection, "Hitbox", {"Head", "Neck", "Torso", "Legs"}, "Head", function(selected)
    print("Hitbox:", selected)
end)

UI:CreateSeparator(AimbotSection)

UI:CreateSlider(AimbotSection, "Field of view", 0, 360, 180)

-- Sag kolon
local SettingsSection = UI:CreateSection(LegitbotTab, "Settings", "Right")

UI:CreateMultiDropdown(SettingsSection, "Target", {"Distance", "Health", "FOV", "Threat"}, {"FOV"}, function(sel) end)

UI:CreateTextBox(SettingsSection, "Webhook", "URL girin...", false, function(text)
    print("Webhook:", text)
end)

UI:CreateLabel(SettingsSection, "RightShift ile gizle/goster")

-- ═══════════════════════════════════════════════════
-- VISUALS SEKMESI
-- ═══════════════════════════════════════════════════
local EspSection = UI:CreateSection(VisualsTab, "ESP", "Left")

UI:CreateToggle(EspSection, "Box ESP", true)

UI:CreateColorPicker(EspSection, "Box Color", Color3.fromRGB(0, 255, 150), function(color)
    print("Box color:", color)
end)

UI:CreateColorPicker(EspSection, "Name Color", Color3.fromRGB(255, 255, 0), function(color)
    print("Name color:", color)
end)

local SystemSection = UI:CreateSection(VisualsTab, "System", "Right")

UI:CreateButton(SystemSection, "Bildirim Goster", function()
    UI:Notify(ScreenGui, "Basarili!", "Bildirim sistemi calisiyor.", 3)
end)

UI:CreateButton(SystemSection, "Dialog Goster", function()
    UI:CreateDialog(ScreenGui, "Uyari", "Tum ayarlari sifirlamak istiyor musunuz?", function()
        print("Evet tiklandi")
        UI:Notify(ScreenGui, "Sifirlandi", "Tum ayarlar varsayilana dondu.", 3)
    end, function()
        print("Hayir tiklandi")
    end)
end)

UI:CreateSeparator(SystemSection)

UI:CreateButton(SystemSection, "Arayuzu Kapat", function()
    UI:CreateDialog(ScreenGui, "Cikis", "Arayuzu kapatmak istediginizden emin misiniz?", function()
        ScreenGui:Destroy()
    end)
end)

-- Baslangiç bildirimi
task.delay(1, function()
    UI:Notify(ScreenGui, "Hosgeldiniz!", "Premium Hub basariyla yuklendi.", 4)
end)

print("Complete Premium Hub loaded! Press RightShift to toggle visibility.")
