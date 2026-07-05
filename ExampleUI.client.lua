local Players = game:GetService("Players")

-- 1. Framework'ü Doğrudan GitHub'dan Yükle
local url = "https://raw.githubusercontent.com/GeceUstasi/roblox-ui-framework/master/UI.lua?t=" .. tostring(tick())
local UIFramework = loadstring(game:HttpGet(url))()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CompletePremiumHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()

-- =====================================================================
-- 2. ANA ARAYÜZ FONKSİYONU
-- =====================================================================
local function LoadInterface()
    -- Watermark & FPS
    UI:CreateWatermark(ScreenGui, "Premium Hub v2.0")

    -- Pencere (Sürüklenebilir, Küçültülebilir)
    local Window = UI:CreateWindow(ScreenGui, "Premium Hub", "Ultimate Feature Showcase")

    -- Sekmeler
    local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373")
    local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")
    local SettingsTab = UI:CreateTab(Window, "Settings", "rbxassetid://7059346373")

    -- ==========================================
    -- LEGITBOT SEKMESİ
    -- ==========================================
    local AimbotSection = UI:CreateSection(LegitbotTab, "Aimbot", "Left")
    
    local aimbotToggle = UI:CreateToggle(AimbotSection, "Aimbot enabled", false)
    UI:AddTooltip(aimbotToggle, "Aimbot'u açıp kapatır.")
    
    UI:CreateKeybind(AimbotSection, "Aimbot Key", Enum.KeyCode.F, function(key, isPressed)
        if isPressed then print("Aimbot tuşuna basıldı:", key) end
    end)
    
    UI:CreateSeparator(AimbotSection)
    
    UI:CreateDropdown(AimbotSection, "Hitbox", {"Head", "Neck", "Torso"}, "Head", function(selected)
        Window._configValues["Hitbox"] = selected
    end)
    
    UI:CreateMultiDropdown(AimbotSection, "Targeting", {"Distance", "Health", "FOV"}, {"FOV"}, function(selectedList)
        print("Çoklu seçim değişti")
    end)
    
    local WeaponSection = UI:CreateSection(LegitbotTab, "Weapon", "Right")
    UI:CreateSlider(WeaponSection, "Field of view", 0, 360, 180)
    UI:CreateSlider(WeaponSection, "Smoothing", 1, 10, 5)

    -- ==========================================
    -- VISUALS SEKMESİ
    -- ==========================================
    local EspSection = UI:CreateSection(VisualsTab, "ESP", "Left")
    UI:CreateToggle(EspSection, "Box ESP", true)
    UI:CreateColorPicker(EspSection, "Box Color", Color3.fromRGB(0, 255, 150), function(color) end)
    
    UI:CreateSeparator(EspSection)
    
    UI:CreateColorPicker(EspSection, "Name Color", Color3.fromRGB(255, 255, 0), function(color) end)

    local InfoSection = UI:CreateSection(VisualsTab, "Information", "Right")
    UI:CreateToggle(InfoSection, "Show Health", true)
    UI:CreateToggle(InfoSection, "Show Distance", true)

    -- ==========================================
    -- SETTINGS SEKMESİ
    -- ==========================================
    local SystemSection = UI:CreateSection(SettingsTab, "System", "Left")
    UI:CreateTextBox(SystemSection, "Webhook URL", "https://discord...", false, function(text) end)
    
    UI:CreateSeparator(SystemSection)
    UI:CreateLabel(SystemSection, "Gelişmiş ayarlar")
    
    UI:CreateButton(SystemSection, "Test Bildirimi", function()
        UI:Notify(ScreenGui, "Başarılı", "Bildirim sistemi kusursuz çalışıyor!", 3)
    end)
    
    UI:CreateButton(SystemSection, "Ayarları Sıfırla", function()
        UI:CreateDialog(ScreenGui, "Uyarı", "Tüm ayarları sıfırlamak istiyor musunuz?", 
        function() UI:Notify(ScreenGui, "Sıfırlandı", "Ayarlar varsayılana döndü.", 3) end, 
        function() print("İptal edildi.") end)
    end)
    
    local ConfigSection = UI:CreateSection(SettingsTab, "Config", "Right")
    UI:CreateTextBox(ConfigSection, "Config Adı", "default", false, function(text)
        Window._configValues["ConfigName"] = text
    end)
    
    UI:CreateButton(ConfigSection, "Kaydet (Save)", function()
        local name = Window._configValues["ConfigName"] or "default"
        local success = UI:SaveConfig(Window, name)
        if success then
            UI:Notify(ScreenGui, "Config", name .. " başarıyla kaydedildi!", 3)
        else
            UI:Notify(ScreenGui, "Hata", "Config kaydedilemedi.", 3)
        end
    end)
    
    UI:CreateButton(ConfigSection, "Yükle (Load)", function()
        local name = Window._configValues["ConfigName"] or "default"
        local success, data = UI:LoadConfig(Window, name)
        if success then UI:Notify(ScreenGui, "Config", name .. " yüklendi!", 3) end
    end)
    
    UI:CreateSeparator(ConfigSection)
    
    UI:CreateButton(ConfigSection, "Arayüzü Kapat", function()
        UI:CreateDialog(ScreenGui, "Çıkış", "Premium Hub'ı kapatmak istiyor musunuz?", function()
            ScreenGui:Destroy()
        end)
    end)

    task.delay(1, function()
        UI:Notify(ScreenGui, "Premium Hub", "Arayüz yüklendi. Gizlemek için RightShift'e basın.", 5)
    end)
end

-- =====================================================================
-- 3. KEY SYSTEM & BAŞLATMA
-- =====================================================================
local USE_KEY_SYSTEM = false -- Key sistemini aktif etmek için bunu 'true' yapın

if USE_KEY_SYSTEM then
    UI:CreateKeySystem(ScreenGui, {"PREMIUM-2025", "VIP"}, function()
        -- Doğru şifre girilince arayüzü başlat
        LoadInterface()
    end, {
        Title = "Karpiware Premium",
        Subtitle = "Devam etmek için şifre girin. (Şifre: VIP)",
        MaxAttempts = 3
    })
else
    -- Direkt başlat
    LoadInterface()
end
