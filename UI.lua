local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Theme & Design Constants (Upscaled, Differentiated Modern Style)
local Theme = {
    WindowBackground = Color3.fromRGB(16, 16, 20),
    SidebarBackground = Color3.fromRGB(10, 10, 14),
    SectionBackground = Color3.fromRGB(22, 22, 28),
    
    WindowTransparency = 0.1, -- Very slight glass
    SidebarTransparency = 0.2,
    SectionTransparency = 0.05,
    
    ElementHover = Color3.fromRGB(32, 32, 40),
    TabSelected = Color3.fromRGB(32, 32, 40),
    
    -- Differentiated Accent: Cyberpunk/Modern Neon Pink to Cyan
    AccentStart = Color3.fromRGB(255, 60, 150),
    AccentEnd = Color3.fromRGB(0, 200, 255),
    
    ToggleOff = Color3.fromRGB(35, 35, 42),
    
    TextColor = Color3.fromRGB(250, 250, 250),
    TextSecondaryColor = Color3.fromRGB(130, 130, 140),
    
    BorderColor = Color3.fromRGB(40, 40, 50),
    BorderTransparency = 0.1,
    
    Font = Enum.Font.GothamMedium,
    BoldFont = Enum.Font.GothamBold,
    CornerRadius = UDim.new(0, 10) -- Slightly rounder
}

local TweenInfoFast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- Utility Functions
local function applyCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or Theme.CornerRadius
    corner.Parent = parent
    return corner
end

local function applyStroke(parent, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.BorderColor
    stroke.Transparency = transparency or Theme.BorderTransparency
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function applyGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(Theme.AccentStart, Theme.AccentEnd)
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

local function createTextLabel(text, size, position, alignment, isBold)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size or UDim2.new(1, 0, 1, 0)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.Font = isBold and Theme.BoldFont or Theme.Font
    label.Text = text
    label.TextColor3 = Theme.TextColor
    label.TextSize = 14 -- Increased base text size
    label.TextXAlignment = alignment or Enum.TextXAlignment.Left
    return label
end

-- Ambient Glow (Drop Shadow)
local function applyGlow(parent)
    local glow = Instance.new("ImageLabel")
    glow.Name = "AmbientGlow"
    glow.Size = UDim2.new(1, 60, 1, 60)
    glow.Position = UDim2.new(0, -30, 0, -30)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    glow.ImageTransparency = 0.5
    glow.ZIndex = 0
    glow.Parent = parent
    return glow
end

-- Core API
function Framework.new()
    local self = setmetatable({}, Framework)
    return self
end

function Framework:CreateWindow(screenGui, titleText, subtitleText)
    -- Main Window Frame (Upscaled)
    local Window = Instance.new("Frame")
    Window.Name = "UpscaledModernWindow"
    Window.Size = UDim2.new(0, 780, 0, 520) -- Bigger
    Window.Position = UDim2.new(0.5, -390, 0.5, -260)
    Window.BackgroundColor3 = Theme.WindowBackground
    Window.BackgroundTransparency = Theme.WindowTransparency
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    applyCorner(Window)
    applyStroke(Window)
    applyGlow(Window) -- Unique touch
    
    -- Sidebar (Upscaled)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 210, 1, 0) -- Wider
    Sidebar.BackgroundColor3 = Theme.SidebarBackground
    Sidebar.BackgroundTransparency = Theme.SidebarTransparency
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 2
    Sidebar.Parent = Window
    applyCorner(Sidebar)
    
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 12, 1, 0)
    SidebarFix.Position = UDim2.new(1, -12, 0, 0)
    SidebarFix.BackgroundColor3 = Theme.SidebarBackground
    SidebarFix.BackgroundTransparency = Theme.SidebarTransparency
    SidebarFix.BorderSizePixel = 0
    SidebarFix.ZIndex = 2
    SidebarFix.Parent = Sidebar
    
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
    SidebarDivider.BackgroundColor3 = Theme.BorderColor
    SidebarDivider.BackgroundTransparency = Theme.BorderTransparency
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.ZIndex = 3
    SidebarDivider.Parent = Sidebar
    
    -- Title Area
    local TitleArea = Instance.new("Frame")
    TitleArea.Size = UDim2.new(1, 0, 0, 85) -- Taller
    TitleArea.BackgroundTransparency = 1
    TitleArea.ZIndex = 3
    TitleArea.Parent = Sidebar
    
    local Title = createTextLabel(titleText or "Hub", UDim2.new(1, -40, 0, 25), UDim2.new(0, 20, 0, 25), Enum.TextXAlignment.Left, true)
    Title.TextSize = 22 -- Bigger
    Title.ZIndex = 3
    Title.Parent = TitleArea
    
    -- Add subtle gradient to Title
    local titleGrad = applyGradient(Title)
    titleGrad.Color = ColorSequence.new(Theme.AccentEnd, Theme.AccentStart)
    
    local Subtitle = createTextLabel(subtitleText or "Interface", UDim2.new(1, -40, 0, 20), UDim2.new(0, 20, 0, 50), Enum.TextXAlignment.Left, false)
    Subtitle.TextSize = 13 -- Bigger
    Subtitle.TextColor3 = Theme.TextSecondaryColor
    Subtitle.ZIndex = 3
    Subtitle.Parent = TitleArea
    
    -- Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -165)
    TabContainer.Position = UDim2.new(0, 0, 0, 85)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 3
    TabContainer.ScrollBarImageColor3 = Theme.TextSecondaryColor
    TabContainer.ZIndex = 3
    TabContainer.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8) -- More spacing
    TabListLayout.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 20)
    TabPadding.PaddingRight = UDim.new(0, 20)
    TabPadding.Parent = TabContainer
    
    -- Profile Section (Upscaled)
    local ProfileContainer = Instance.new("Frame")
    ProfileContainer.Name = "ProfileContainer"
    ProfileContainer.Size = UDim2.new(1, 0, 0, 80)
    ProfileContainer.Position = UDim2.new(0, 0, 1, -80)
    ProfileContainer.BackgroundTransparency = 1
    ProfileContainer.ZIndex = 3
    ProfileContainer.Parent = Sidebar
    
    local ProfileDivider = Instance.new("Frame")
    ProfileDivider.Size = UDim2.new(1, -40, 0, 1)
    ProfileDivider.Position = UDim2.new(0, 20, 0, 0)
    ProfileDivider.BackgroundColor3 = Theme.BorderColor
    ProfileDivider.BackgroundTransparency = Theme.BorderTransparency
    ProfileDivider.BorderSizePixel = 0
    ProfileDivider.Parent = ProfileContainer
    
    local AvatarIcon = Instance.new("ImageLabel")
    AvatarIcon.Size = UDim2.new(0, 42, 0, 42) -- Bigger avatar
    AvatarIcon.Position = UDim2.new(0, 20, 0.5, -21)
    AvatarIcon.BackgroundColor3 = Theme.SectionBackground
    AvatarIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    AvatarIcon.ZIndex = 3
    AvatarIcon.Parent = ProfileContainer
    applyCorner(AvatarIcon, UDim.new(1, 0))
    
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local success, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        if success then AvatarIcon.Image = thumb end
    end
    
    local UsernameLabel = createTextLabel(localPlayer and localPlayer.Name or "User", UDim2.new(1, -115, 0, 20), UDim2.new(0, 72, 0.5, -20), Enum.TextXAlignment.Left, true)
    UsernameLabel.TextSize = 14
    UsernameLabel.ZIndex = 3
    UsernameLabel.Parent = ProfileContainer
    
    local SubLabel = createTextLabel("Premium User", UDim2.new(1, -115, 0, 15), UDim2.new(0, 72, 0.5, 2), Enum.TextXAlignment.Left, false)
    SubLabel.TextSize = 11
    SubLabel.TextColor3 = Theme.AccentEnd
    SubLabel.ZIndex = 3
    SubLabel.Parent = ProfileContainer
    
    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Size = UDim2.new(0, 18, 0, 18) -- Bigger icon
    SettingsBtn.Position = UDim2.new(1, -38, 0.5, -9)
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Image = "rbxassetid://7059346373"
    SettingsBtn.ImageColor3 = Theme.TextSecondaryColor
    SettingsBtn.ZIndex = 3
    SettingsBtn.Parent = ProfileContainer
    
    SettingsBtn.MouseEnter:Connect(function() 
        TweenService:Create(SettingsBtn, TweenInfoFast, {ImageColor3 = Theme.TextColor, Rotation = 90}):Play()
    end)
    SettingsBtn.MouseLeave:Connect(function() 
        TweenService:Create(SettingsBtn, TweenInfoFast, {ImageColor3 = Theme.TextSecondaryColor, Rotation = 0}):Play()
    end)
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -210, 1, 0)
    ContentArea.Position = UDim2.new(0, 210, 0, 0)
    ContentArea.BackgroundTransparency = 1
    ContentArea.ZIndex = 2
    ContentArea.Parent = Window
    
    return {
        Frame = Window,
        TabContainer = TabContainer,
        ContentArea = ContentArea,
        Tabs = {},
        ActiveTab = nil,
        SettingsButton = SettingsBtn
    }
end

function Framework:CreateTab(windowObj, tabName, iconId)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 42) -- Taller
    TabButton.BackgroundColor3 = Theme.TabSelected
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.ZIndex = 4
    TabButton.Parent = windowObj.TabContainer
    applyCorner(TabButton)
    
    local TabIcon = Instance.new("ImageLabel")
    TabIcon.Size = UDim2.new(0, 18, 0, 18) -- Bigger icon
    TabIcon.Position = UDim2.new(0, 15, 0.5, -9)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Image = iconId or "rbxassetid://6031094678"
    TabIcon.ImageColor3 = Theme.TextSecondaryColor
    TabIcon.ZIndex = 4
    TabIcon.Parent = TabButton
    
    local TabLabel = createTextLabel(tabName, UDim2.new(1, -45, 1, 0), UDim2.new(0, 42, 0, 0), Enum.TextXAlignment.Left, true)
    TabLabel.TextColor3 = Theme.TextSecondaryColor
    TabLabel.TextSize = 14
    TabLabel.ZIndex = 4
    TabLabel.Parent = TabButton
    
    local TabContent = Instance.new("Frame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.ZIndex = 2
    TabContent.Parent = windowObj.ContentArea
    
    local LeftColumn = Instance.new("ScrollingFrame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.5, -20, 1, -40)
    LeftColumn.Position = UDim2.new(0, 20, 0, 20)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.BorderSizePixel = 0
    LeftColumn.ScrollBarThickness = 0
    LeftColumn.ZIndex = 3
    LeftColumn.Parent = TabContent
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Padding = UDim.new(0, 15) -- More spacing
    LeftLayout.Parent = LeftColumn
    
    local RightColumn = Instance.new("ScrollingFrame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.5, -20, 1, -40)
    RightColumn.Position = UDim2.new(0.5, 5, 0, 20)
    RightColumn.BackgroundTransparency = 1
    RightColumn.BorderSizePixel = 0
    RightColumn.ScrollBarThickness = 0
    RightColumn.ZIndex = 3
    RightColumn.Parent = TabContent
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.Padding = UDim.new(0, 15)
    RightLayout.Parent = RightColumn
    
    local function SelectTab()
        for _, t in pairs(windowObj.Tabs) do
            TweenService:Create(t.Button, TweenInfoFast, {BackgroundTransparency = 1}):Play()
            TweenService:Create(t.Icon, TweenInfoFast, {ImageColor3 = Theme.TextSecondaryColor}):Play()
            TweenService:Create(t.Label, TweenInfoFast, {TextColor3 = Theme.TextSecondaryColor}):Play()
            t.Content.Visible = false
        end
        TweenService:Create(TabButton, TweenInfoFast, {BackgroundTransparency = 0.3}):Play() -- More vivid highlight
        TweenService:Create(TabIcon, TweenInfoFast, {ImageColor3 = Theme.AccentEnd}):Play()
        TweenService:Create(TabLabel, TweenInfoFast, {TextColor3 = Theme.TextColor}):Play()
        TabContent.Visible = true
        windowObj.ActiveTab = TabContent
    end
    
    TabButton.MouseButton1Click:Connect(SelectTab)
    
    local tabData = { Button = TabButton, Icon = TabIcon, Label = TabLabel, Content = TabContent, Left = LeftColumn, Right = RightColumn }
    table.insert(windowObj.Tabs, tabData)
    
    if #windowObj.Tabs == 1 then SelectTab() end
    
    return tabData
end

function Framework:CreateSection(parentTab, title, side)
    local col = (side == "Right") and parentTab.Right or parentTab.Left
    
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = "Section_" .. (title or "Group")
    SectionFrame.Size = UDim2.new(1, 0, 0, 50)
    SectionFrame.BackgroundColor3 = Theme.SectionBackground
    SectionFrame.BackgroundTransparency = Theme.SectionTransparency
    SectionFrame.ZIndex = 3
    SectionFrame.Parent = col
    applyCorner(SectionFrame)
    local border = applyStroke(SectionFrame)
    
    -- Differentiating touch: Section stroke slightly glows on hover
    SectionFrame.MouseEnter:Connect(function()
        TweenService:Create(border, TweenInfoFast, {Transparency = 0, Color = Theme.AccentEnd}):Play()
    end)
    SectionFrame.MouseLeave:Connect(function()
        TweenService:Create(border, TweenInfoFast, {Transparency = Theme.BorderTransparency, Color = Theme.BorderColor}):Play()
    end)
    
    local SectionContent = Instance.new("Frame")
    SectionContent.Size = UDim2.new(1, 0, 1, 0)
    SectionContent.Position = UDim2.new(0, 0, 0, 0)
    SectionContent.BackgroundTransparency = 1
    SectionContent.ZIndex = 4
    SectionContent.Parent = SectionFrame
    
    if title and title ~= "" then
        local SectionTitle = createTextLabel(title, UDim2.new(1, -30, 0, 36), UDim2.new(0, 15, 0, 0), Enum.TextXAlignment.Left, true)
        SectionTitle.TextColor3 = Theme.TextSecondaryColor
        SectionTitle.TextSize = 14
        SectionTitle.ZIndex = 4
        SectionTitle.Parent = SectionFrame
        
        local TitleLine = Instance.new("Frame")
        TitleLine.Size = UDim2.new(1, -30, 0, 1)
        TitleLine.Position = UDim2.new(0, 15, 0, 36)
        TitleLine.BackgroundColor3 = Theme.BorderColor
        TitleLine.BackgroundTransparency = Theme.BorderTransparency
        TitleLine.BorderSizePixel = 0
        TitleLine.ZIndex = 4
        TitleLine.Parent = SectionFrame
        
        SectionContent.Size = UDim2.new(1, 0, 1, -40)
        SectionContent.Position = UDim2.new(0, 0, 0, 40)
    end
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 8) -- Spaced out elements inside sections
    ListLayout.Parent = SectionContent
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 12)
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.PaddingRight = UDim.new(0, 15)
    Padding.PaddingBottom = UDim.new(0, 12)
    Padding.Parent = SectionContent
    
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local extra = (title and title ~= "") and 52 or 24
        SectionContent.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y)
        SectionFrame.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y + extra)
        col.CanvasSize = UDim2.new(0, 0, 0, col.UIListLayout.AbsoluteContentSize.Y + 15)
    end)
    
    return SectionContent
end

function Framework:CreateToggle(parentSection, text, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30) -- Taller
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.ZIndex = 4
    ToggleFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(1, -50, 1, 0), UDim2.new(0, 0, 0, 0))
    Title.TextSize = 14
    Title.ZIndex = 4
    Title.Parent = ToggleFrame
    
    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Text = ""
    SwitchBg.Size = UDim2.new(0, 44, 0, 24) -- Bigger switch
    SwitchBg.Position = UDim2.new(1, -44, 0.5, -12)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchBg.ZIndex = 4
    SwitchBg.Parent = ToggleFrame
    applyCorner(SwitchBg, UDim.new(1, 0))
    
    local bgGradient = applyGradient(SwitchBg)
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18) -- Bigger circle
    Circle.Position = UDim2.new(default and 1 or 0, default and -21 or 3, 0.5, -9)
    Circle.BackgroundColor3 = default and Theme.WindowBackground or Theme.TextSecondaryColor
    Circle.ZIndex = 5
    Circle.Parent = SwitchBg
    applyCorner(Circle, UDim.new(1, 0))
    
    local toggled = default
    
    if default then
        SwitchBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bgGradient.Enabled = true
        Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        SwitchBg.BackgroundColor3 = Theme.ToggleOff
        bgGradient.Enabled = false
        Circle.BackgroundColor3 = Theme.TextSecondaryColor
    end

    SwitchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            bgGradient.Enabled = true
            TweenService:Create(Circle, TweenInfoFast, {Position = UDim2.new(1, -21, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(SwitchBg, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            bgGradient.Enabled = false
            TweenService:Create(Circle, TweenInfoFast, {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Theme.TextSecondaryColor}):Play()
            TweenService:Create(SwitchBg, TweenInfoFast, {BackgroundColor3 = Theme.ToggleOff}):Play()
        end
    end)
    
    return ToggleFrame
end

function Framework:CreateSlider(parentSection, text, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 42) -- Taller
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.ZIndex = 4
    SliderFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(0, 120, 0, 20))
    Title.TextSize = 14
    Title.ZIndex = 4
    Title.Parent = SliderFrame
    
    local ValueBox = Instance.new("Frame")
    ValueBox.Size = UDim2.new(0, 36, 0, 20) -- Bigger value box
    ValueBox.Position = UDim2.new(1, -36, 0, 0)
    ValueBox.BackgroundColor3 = Theme.WindowBackground
    ValueBox.ZIndex = 4
    ValueBox.Parent = SliderFrame
    applyCorner(ValueBox)
    applyStroke(ValueBox)
    
    local ValueLabel = createTextLabel(tostring(default), UDim2.new(1, 0, 1, 0), UDim2.new(0,0,0,0), Enum.TextXAlignment.Center, true)
    ValueLabel.TextSize = 12
    ValueLabel.ZIndex = 4
    ValueLabel.Parent = ValueBox
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 6)
    Track.Position = UDim2.new(0, 0, 1, -6)
    Track.BackgroundColor3 = Theme.ToggleOff
    Track.ZIndex = 4
    Track.Parent = SliderFrame
    applyCorner(Track, UDim.new(1, 0))
    
    local percent = (default - min) / (max - min)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Fill.ZIndex = 4
    Fill.Parent = Track
    applyCorner(Fill, UDim.new(1, 0))
    
    applyGradient(Fill)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14) -- Bigger knob
    Knob.Position = UDim2.new(1, -7, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.ZIndex = 5
    Knob.Parent = Fill
    applyCorner(Knob, UDim.new(1, 0))
    
    return SliderFrame
end

function Framework:CreateButton(parentSection, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 32) -- Taller
    ButtonFrame.BackgroundColor3 = Theme.ElementHover
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.ZIndex = 4
    ButtonFrame.Parent = parentSection
    applyCorner(ButtonFrame)
    applyStroke(ButtonFrame)
    
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.BackgroundTransparency = 1
    TextButton.Font = Theme.Font
    TextButton.Text = text
    TextButton.TextColor3 = Theme.TextColor
    TextButton.TextSize = 14
    TextButton.ZIndex = 4
    TextButton.Parent = ButtonFrame
    
    TextButton.MouseEnter:Connect(function() 
        TweenService:Create(ButtonFrame, TweenInfoFast, {BackgroundTransparency = 0.6}):Play()
    end)
    TextButton.MouseLeave:Connect(function() 
        TweenService:Create(ButtonFrame, TweenInfoFast, {BackgroundTransparency = 1}):Play()
    end)
    
    if callback then
        TextButton.MouseButton1Click:Connect(callback)
    end
    
    return TextButton
end

return Framework
