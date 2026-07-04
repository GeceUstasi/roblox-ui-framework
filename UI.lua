local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")

-- Theme & Design Constants
local Theme = {
    BackgroundColor = Color3.fromRGB(20, 20, 25),
    SidebarColor = Color3.fromRGB(15, 15, 20),
    BackgroundTransparency = 0.25,
    SidebarTransparency = 0.4,
    
    ElementColor = Color3.fromRGB(35, 35, 45),
    ElementTransparency = 0.3,
    
    AccentColor = Color3.fromRGB(80, 140, 255),
    
    TextColor = Color3.fromRGB(245, 245, 245),
    TextSecondaryColor = Color3.fromRGB(150, 150, 150),
    
    BorderColor = Color3.fromRGB(255, 255, 255),
    BorderTransparency = 0.85,
    
    Font = Enum.Font.SourceSans,
    BoldFont = Enum.Font.SourceSansBold,
    CornerRadius = UDim.new(0, 8)
}

-- Utility Functions
local function applyCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or Theme.CornerRadius
    corner.Parent = parent
    return corner
end

local function applyStroke(parent)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.BorderColor
    stroke.Transparency = Theme.BorderTransparency
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function createTextLabel(text, size, position, alignment, isBold)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size or UDim2.new(1, 0, 1, 0)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.Font = isBold and Theme.BoldFont or Theme.Font
    label.Text = text
    label.TextColor3 = Theme.TextColor
    label.TextSize = 14
    label.TextXAlignment = alignment or Enum.TextXAlignment.Left
    return label
end

-- Core API
function Framework.new()
    local self = setmetatable({}, Framework)
    return self
end

function Framework:CreateWindow(screenGui, titleText)
    -- Main Window Frame
    local Window = Instance.new("Frame")
    Window.Name = "GlassWindow"
    Window.Size = UDim2.new(0, 550, 0, 380)
    Window.Position = UDim2.new(0.5, -275, 0.5, -190)
    Window.BackgroundColor3 = Theme.BackgroundColor
    Window.BackgroundTransparency = Theme.BackgroundTransparency
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    
    applyCorner(Window)
    applyStroke(Window)
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = Theme.SidebarColor
    Sidebar.BackgroundTransparency = Theme.SidebarTransparency
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Window
    applyCorner(Sidebar)
    
    -- Fix corner overlap between Sidebar and Window (make left side rounded, right side flat for sidebar visually)
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 10, 1, 0)
    SidebarFix.Position = UDim2.new(1, -10, 0, 0)
    SidebarFix.BackgroundColor3 = Theme.SidebarColor
    SidebarFix.BackgroundTransparency = Theme.SidebarTransparency
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Parent = Sidebar
    
    -- Sidebar Divider
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
    SidebarDivider.BackgroundColor3 = Theme.BorderColor
    SidebarDivider.BackgroundTransparency = Theme.BorderTransparency
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.Parent = Sidebar
    
    -- Title
    local Title = createTextLabel(titleText or "Window", UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 5), Enum.TextXAlignment.Center, true)
    Title.TextSize = 16
    Title.Parent = Sidebar
    
    local TitleDivider = Instance.new("Frame")
    TitleDivider.Size = UDim2.new(1, 0, 0, 1)
    TitleDivider.Position = UDim2.new(0, 0, 1, -1)
    TitleDivider.BackgroundColor3 = Theme.BorderColor
    TitleDivider.BackgroundTransparency = Theme.BorderTransparency
    TitleDivider.BorderSizePixel = 0
    TitleDivider.Parent = Title
    
    -- Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -110)
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 2
    TabContainer.ScrollBarImageColor3 = Theme.AccentColor
    TabContainer.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer
    
    -- Profile Section (Bottom of Sidebar)
    local ProfileContainer = Instance.new("Frame")
    ProfileContainer.Name = "ProfileContainer"
    ProfileContainer.Size = UDim2.new(1, 0, 0, 60)
    ProfileContainer.Position = UDim2.new(0, 0, 1, -60)
    ProfileContainer.BackgroundTransparency = 1
    ProfileContainer.Parent = Sidebar
    
    local ProfileDivider = Instance.new("Frame")
    ProfileDivider.Size = UDim2.new(1, 0, 0, 1)
    ProfileDivider.Position = UDim2.new(0, 0, 0, 0)
    ProfileDivider.BackgroundColor3 = Theme.BorderColor
    ProfileDivider.BackgroundTransparency = Theme.BorderTransparency
    ProfileDivider.BorderSizePixel = 0
    ProfileDivider.Parent = ProfileContainer
    
    local AvatarIcon = Instance.new("ImageLabel")
    AvatarIcon.Size = UDim2.new(0, 36, 0, 36)
    AvatarIcon.Position = UDim2.new(0, 10, 0.5, -18)
    AvatarIcon.BackgroundColor3 = Theme.ElementColor
    AvatarIcon.BackgroundTransparency = Theme.ElementTransparency
    AvatarIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    AvatarIcon.Parent = ProfileContainer
    applyCorner(AvatarIcon, UDim.new(1, 0)) -- Circle
    
    -- Fetch LocalPlayer Avatar
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local success, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        if success then
            AvatarIcon.Image = thumb
        end
    end
    
    local UsernameLabel = createTextLabel(localPlayer and localPlayer.Name or "User", UDim2.new(1, -85, 0, 20), UDim2.new(0, 55, 0.5, -10), Enum.TextXAlignment.Left, true)
    UsernameLabel.TextSize = 13
    UsernameLabel.Parent = ProfileContainer
    
    -- Settings Icon (Lucide Cog Asset ID)
    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Size = UDim2.new(0, 20, 0, 20)
    SettingsBtn.Position = UDim2.new(1, -30, 0.5, -10)
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Image = "rbxassetid://7059346373" -- Settings gear icon
    SettingsBtn.ImageColor3 = Theme.TextSecondaryColor
    SettingsBtn.Parent = ProfileContainer
    
    -- Hover effect for settings
    SettingsBtn.MouseEnter:Connect(function() SettingsBtn.ImageColor3 = Theme.TextColor end)
    SettingsBtn.MouseLeave:Connect(function() SettingsBtn.ImageColor3 = Theme.TextSecondaryColor end)
    
    -- Content Area (Right side)
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -160, 1, 0)
    ContentArea.Position = UDim2.new(0, 160, 0, 0)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = Window
    
    local WindowObj = {
        Frame = Window,
        TabContainer = TabContainer,
        ContentArea = ContentArea,
        Tabs = {},
        ActiveTab = nil,
        SettingsButton = SettingsBtn
    }
    
    return WindowObj
end

function Framework:CreateTab(windowObj, tabName, iconId)
    -- Tab Button in Sidebar
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 32)
    TabButton.BackgroundColor3 = Theme.ElementColor
    TabButton.BackgroundTransparency = 1 -- Transparent by default
    TabButton.Text = ""
    TabButton.Parent = windowObj.TabContainer
    applyCorner(TabButton)
    
    local TabIcon = Instance.new("ImageLabel")
    TabIcon.Size = UDim2.new(0, 16, 0, 16)
    TabIcon.Position = UDim2.new(0, 10, 0.5, -8)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Image = iconId or "rbxassetid://6031094678" -- Default icon
    TabIcon.ImageColor3 = Theme.TextSecondaryColor
    TabIcon.Parent = TabButton
    
    local TabLabel = createTextLabel(tabName, UDim2.new(1, -36, 1, 0), UDim2.new(0, 36, 0, 0))
    TabLabel.TextColor3 = Theme.TextSecondaryColor
    TabLabel.Parent = TabButton
    
    -- Tab Content Container (ScrollingFrame)
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, -20, 1, -20)
    TabContent.Position = UDim2.new(0, 10, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 4
    TabContent.ScrollBarImageColor3 = Theme.AccentColor
    TabContent.Visible = false
    TabContent.Parent = windowObj.ContentArea
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = TabContent
    
    -- Selection logic
    local function SelectTab()
        -- Reset all tabs
        for _, t in pairs(windowObj.Tabs) do
            t.Button.BackgroundTransparency = 1
            t.Icon.ImageColor3 = Theme.TextSecondaryColor
            t.Label.TextColor3 = Theme.TextSecondaryColor
            t.Content.Visible = false
        end
        -- Highlight this tab
        TabButton.BackgroundTransparency = Theme.ElementTransparency
        TabIcon.ImageColor3 = Theme.AccentColor
        TabLabel.TextColor3 = Theme.TextColor
        TabContent.Visible = true
        windowObj.ActiveTab = TabContent
    end
    
    TabButton.MouseButton1Click:Connect(SelectTab)
    
    local tabData = {
        Button = TabButton,
        Icon = TabIcon,
        Label = TabLabel,
        Content = TabContent
    }
    table.insert(windowObj.Tabs, tabData)
    
    -- Auto-select the first tab
    if #windowObj.Tabs == 1 then
        SelectTab()
    end
    
    return TabContent
end

function Framework:CreateButton(parentTab, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, -10, 0, 35)
    ButtonFrame.BackgroundColor3 = Theme.ElementColor
    ButtonFrame.BackgroundTransparency = Theme.ElementTransparency
    ButtonFrame.Parent = parentTab
    
    applyCorner(ButtonFrame)
    applyStroke(ButtonFrame)
    
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.BackgroundTransparency = 1
    TextButton.Font = Theme.Font
    TextButton.Text = text
    TextButton.TextColor3 = Theme.TextColor
    TextButton.TextSize = 14
    TextButton.Parent = ButtonFrame
    
    TextButton.MouseEnter:Connect(function() ButtonFrame.BackgroundTransparency = Theme.ElementTransparency - 0.1 end)
    TextButton.MouseLeave:Connect(function() ButtonFrame.BackgroundTransparency = Theme.ElementTransparency end)
    
    if callback then
        TextButton.MouseButton1Click:Connect(callback)
    end
    
    return TextButton
end

function Framework:CreateSlider(parentTab, text, min, max, default)
    min = min or 0; max = max or 100; default = default or 50
    
    local SliderContainer = Instance.new("Frame")
    SliderContainer.Size = UDim2.new(1, -10, 0, 50)
    SliderContainer.BackgroundTransparency = 1
    SliderContainer.Parent = parentTab
    
    local Title = createTextLabel(text, UDim2.new(1, 0, 0, 20))
    Title.Parent = SliderContainer
    
    local ValueLabel = createTextLabel(tostring(default), UDim2.new(0, 50, 0, 20), UDim2.new(1, -50, 0, 0), Enum.TextXAlignment.Right)
    ValueLabel.TextColor3 = Theme.AccentColor
    ValueLabel.Parent = SliderContainer
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, 0, 0, 8)
    SliderBg.Position = UDim2.new(0, 0, 1, -15)
    SliderBg.BackgroundColor3 = Theme.ElementColor
    SliderBg.BackgroundTransparency = Theme.ElementTransparency
    SliderBg.Parent = SliderContainer
    applyCorner(SliderBg)
    
    local percent = (default - min) / (max - min)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.AccentColor
    Fill.Parent = SliderBg
    applyCorner(Fill)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(1, -7, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = Fill
    applyCorner(Knob, UDim.new(1, 0))
    
    return SliderContainer
end

function Framework:CreateToggle(parentTab, text, default)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Size = UDim2.new(1, -10, 0, 35)
    ToggleContainer.BackgroundTransparency = 1
    ToggleContainer.Parent = parentTab
    
    local Title = createTextLabel(text, UDim2.new(1, -50, 1, 0))
    Title.Parent = ToggleContainer
    
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(0, 40, 0, 20)
    ToggleBg.Position = UDim2.new(1, -40, 0.5, -10)
    ToggleBg.BackgroundColor3 = default and Theme.AccentColor or Theme.ElementColor
    ToggleBg.BackgroundTransparency = default and 0 or Theme.ElementTransparency
    ToggleBg.Parent = ToggleContainer
    applyCorner(ToggleBg)
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 16, 0, 16)
    Indicator.Position = UDim2.new(default and 1 or 0, default and -18 or 2, 0.5, -8)
    Indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Indicator.Parent = ToggleBg
    applyCorner(Indicator, UDim.new(1, 0))
    
    return ToggleContainer
end

return Framework
