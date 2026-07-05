local Players = game:GetService("Players")

-- 1. Framework'ü Yükle
local url = "https://raw.githubusercontent.com/GeceUstasi/roblox-ui-framework/master/UI.lua?t=" .. tostring(tick())
local success, UIFramework = pcall(function()
    return loadstring(game:HttpGet(url))()
end)

if not success then
    -- Lokal test için (GitHub'dan çekemezse dosyadan oku)
    UIFramework = require(script.Parent:WaitForChild("UI"))
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CompletePremiumHub"
ScreenGui.ResetOnSpawn = false

local envSuccess, coreGui = pcall(function() return game:GetService("CoreGui") end)
ScreenGui.Parent = envSuccess and coreGui or Players.LocalPlayer:WaitForChild("PlayerGui")

local UI = UIFramework.new()

-- =====================================================================
-- 2. KEY SYSTEM (İsteğe Bağlı)
-- =====================================================================
local USE_KEY_SYSTEM = false

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

-- =====================================================================
-- 3. ANA ARAYÜZ (LoadInterface Fonksiyonu)
-- =====================================================================
function LoadInterface()
    -- Watermark & FPS
    UI:CreateWatermark(ScreenGui, "Premium Hub v2.0")

    -- Pencere (Sürüklenebilir, Küçültülebilir)
    local Window = UI:CreateWindow(ScreenGui, "Premium Hub", "Ultimate Feature Showcase")
    
    -- Config değerlerini tutmak için Window'u hazırlayalım (Otomatik yapılıyor)

    -- Sekmeler
    local LegitbotTab = UI:CreateTab(Window, "Legitbot", "rbxassetid://7059346373")
    local VisualsTab = UI:CreateTab(Window, "Visuals", "rbxassetid://6031290374")
    local SettingsTab = UI:CreateTab(Window, "Settings", "rbxassetid://7059346373")

    -- ==========================================
    -- LEGITBOT SEKMESİ
    -- ==========================================
    local AimbotSection = UI:CreateSection(LegitbotTab, "Aimbot", "Left")
    
    -- Toggle
    local aimbotToggle = UI:CreateToggle(AimbotSection, "Aimbot enabled", false)
    UI:AddTooltip(aimbotToggle, "Aimbot'u açıp kapatır.") -- Tooltip örneği
    
    -- Keybind
    UI:CreateKeybind(AimbotSection, "Aimbot Key", Enum.KeyCode.F, function(key, isPressed)
        if isPressed then print("Aimbot tuşuna basıldı:", key) end
    end)
    
    UI:CreateSeparator(AimbotSection) -- Ayırıcı Çizgi
    
    -- Dropdown
    UI:CreateDropdown(AimbotSection, "Hitbox", {"Head", "Neck", "Torso"}, "Head", function(selected)
        print("Hitbox değişti:", selected)
        Window._configValues["Hitbox"] = selected -- Config için manuel kayıt örneği
    end)
    
    -- MultiDropdown
    UI:CreateMultiDropdown(AimbotSection, "Targeting", {"Distance", "Health", "FOV"}, {"FOV"}, function(selectedList)
        print("Çoklu seçim değişti")
    end)
    
    local WeaponSection = UI:CreateSection(LegitbotTab, "Weapon", "Right")
    
    -- Slider
    UI:CreateSlider(WeaponSection, "Field of view", 0, 360, 180)
    UI:CreateSlider(WeaponSection, "Smoothing", 1, 10, 5)

    -- ==========================================
    -- VISUALS SEKMESİ
    -- ==========================================
    local EspSection = UI:CreateSection(VisualsTab, "ESP", "Left")
    
    UI:CreateToggle(EspSection, "Box ESP", true)
    
    -- ColorPicker (Renk Çarkı)
    UI:CreateColorPicker(EspSection, "Box Color", Color3.fromRGB(0, 255, 150), function(color)
        print("ESP Rengi:", color)
    end)
    
    UI:CreateSeparator(EspSection)
    
    UI:CreateColorPicker(EspSection, "Name Color", Color3.fromRGB(255, 255, 0), function(color) end)

    local InfoSection = UI:CreateSection(VisualsTab, "Information", "Right")
    UI:CreateToggle(InfoSection, "Show Health", true)
    UI:CreateToggle(InfoSection, "Show Distance", true)

    -- ==========================================
    -- SETTINGS SEKMESİ
    -- ==========================================
    local SystemSection = UI:CreateSection(SettingsTab, "System", "Left")
    
    -- TextBox
    UI:CreateTextBox(SystemSection, "Webhook URL", "https://discord...", false, function(text)
        print("Webhook URL kaydedildi:", text)
    end)
    
    UI:CreateSeparator(SystemSection)
    
    -- Label & Buton
    UI:CreateLabel(SystemSection, "Gelişmiş ayarlar")
    
    -- Bildirim (Notification)
    UI:CreateButton(SystemSection, "Test Bildirimi", function()
        UI:Notify(ScreenGui, "Başarılı", "Bildirim sistemi kusursuz çalışıyor!", 3)
    end)
    
    -- Dialog (Onay Kutusu)
    UI:CreateButton(SystemSection, "Ayarları Sıfırla", function()
        UI:CreateDialog(ScreenGui, "Uyarı", "Tüm ayarları sıfırlamak istiyor musunuz?", 
        function() -- Evet'e basılırsa
            UI:Notify(ScreenGui, "Sıfırlandı", "Ayarlar varsayılana döndü.", 3)
        end, 
        function() -- Hayır'a basılırsa
            print("İptal edildi.")
        end)
    end)
    
    local ConfigSection = UI:CreateSection(SettingsTab, "Config", "Right")
    
    -- Config Sistemi (Save / Load)
    UI:CreateTextBox(ConfigSection, "Config Adı", "default", false, function(text)
        Window._configValues["ConfigName"] = text
    end)
    
    UI:CreateButton(ConfigSection, "Kaydet (Save)", function()
        local name = Window._configValues["ConfigName"] or "default"
        local success = UI:SaveConfig(Window, name)
        if success then
            UI:Notify(ScreenGui, "Config", name .. " başarıyla kaydedildi!", 3)
        else
            UI:Notify(ScreenGui, "Hata", "Config kaydedilemedi (Executor desteklemiyor olabilir).", 3)
        end
    end)
    
    UI:CreateButton(ConfigSection, "Yükle (Load)", function()
        local name = Window._configValues["ConfigName"] or "default"
        local success, data = UI:LoadConfig(Window, name)
        if success then
            UI:Notify(ScreenGui, "Config", name .. " yüklendi!", 3)
            print("Yüklenen veri:", data)
        else
            UI:Notify(ScreenGui, "Hata", "Config bulunamadı.", 3)
        end
    end)
    
    UI:CreateSeparator(ConfigSection)
    
    -- Arayüzü Kapatma Dialog'u
    UI:CreateButton(ConfigSection, "Arayüzü Kapat", function()
        UI:CreateDialog(ScreenGui, "Çıkış", "Premium Hub'ı kapatmak istiyor musunuz?", function()
            ScreenGui:Destroy()
        end)
    end)

    -- Başlangıç Bildirimi
    task.delay(1, function()
        UI:Notify(ScreenGui, "Premium Hub", "Arayüz yüklendi. Gizlemek için RightShift'e basın.", 5)
    end)
end
