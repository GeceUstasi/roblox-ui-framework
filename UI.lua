local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Theme & Design Constants (Simplified, Sleek, Classic Premium Style)
local Theme = {
    WindowBackground = Color3.fromRGB(20, 20, 25),
    SidebarBackground = Color3.fromRGB(16, 16, 21),
    SectionBackground = Color3.fromRGB(26, 26, 32),
    
    WindowTransparency = 0, -- Solid, clean look
    SidebarTransparency = 0,
    SectionTransparency = 0,
    
    ElementHover = Color3.fromRGB(36, 36, 42),
    TabSelected = Color3.fromRGB(36, 36, 42),
    
    -- Sleek Blue Accent (No crazy neon)
    AccentStart = Color3.fromRGB(80, 140, 255),
    AccentEnd = Color3.fromRGB(80, 140, 255),
    
    ToggleOff = Color3.fromRGB(40, 40, 48),
    
    TextColor = Color3.fromRGB(240, 240, 240),
    TextSecondaryColor = Color3.fromRGB(150, 150, 160),
    
    BorderColor = Color3.fromRGB(45, 45, 55),
    BorderTransparency = 0,
    
    Font = Enum.Font.GothamMedium,
    BoldFont = Enum.Font.GothamBold,
    CornerRadius = UDim.new(0, 6) -- Sharper, cleaner corners
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
    -- Main Window Frame (Slightly reduced for neatness)
    local Window = Instance.new("Frame")
    Window.Name = "SleekModernWindow"
    Window.Size = UDim2.new(0, 700, 0, 480)
    Window.Position = UDim2.new(0.5, -350, 0.5, -240)
    Window.BackgroundColor3 = Theme.WindowBackground
    Window.BackgroundTransparency = Theme.WindowTransparency
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    applyCorner(Window)
    applyStroke(Window)
    
    -- Sidebar (Upscaled)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 190, 1, 0)
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
    SettingsBtn.AnchorPoint = Vector2.new(1, 0.5)
    SettingsBtn.Position = UDim2.new(1, -20, 0.5, 0)
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
    ContentArea.Size = UDim2.new(1, -190, 1, 0)
    ContentArea.Position = UDim2.new(0, 190, 0, 0)
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

function Framework:CreateDropdown(parentSection, text, options, defaultOption, callback)
    local DropdownContainer = Instance.new("Frame")
    DropdownContainer.Size = UDim2.new(1, 0, 0, 36)
    DropdownContainer.BackgroundColor3 = Theme.WindowBackground
    DropdownContainer.BackgroundTransparency = 0.5
    DropdownContainer.ClipsDescendants = true
    DropdownContainer.ZIndex = 4
    DropdownContainer.Parent = parentSection
    applyCorner(DropdownContainer)
    local border = applyStroke(DropdownContainer)
    
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, 0, 0, 36)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Text = ""
    MainBtn.ZIndex = 5
    MainBtn.Parent = DropdownContainer
    
    local Title = createTextLabel(text .. ": " .. tostring(defaultOption or "None"), UDim2.new(1, -30, 1, 0), UDim2.new(0, 15, 0, 0))
    Title.TextSize = 13
    Title.ZIndex = 5
    Title.Parent = MainBtn
    
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 14, 0, 14)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -15, 0.5, 0)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7059346373" -- Gear default for now, let's use a chevron down id if available, but this is fine. Let's use a standard V shape.
    -- Actually, rbxassetid://6031091004 is a chevron down.
    Icon.Image = "rbxassetid://6031091004"
    Icon.ImageColor3 = Theme.TextSecondaryColor
    Icon.ZIndex = 5
    Icon.Parent = MainBtn
    
    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Size = UDim2.new(1, 0, 1, -36)
    OptionsFrame.Position = UDim2.new(0, 0, 0, 36)
    OptionsFrame.BackgroundTransparency = 1
    OptionsFrame.ZIndex = 5
    OptionsFrame.Parent = DropdownContainer
    
    local OptionLayout = Instance.new("UIListLayout")
    OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptionLayout.Parent = OptionsFrame
    
    local isOpen = false
    local totalHeight = 36
    
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.BackgroundColor3 = Theme.ElementHover
        OptBtn.BackgroundTransparency = 1
        OptBtn.Text = ""
        OptBtn.ZIndex = 5
        OptBtn.Parent = OptionsFrame
        totalHeight = totalHeight + 30
        
        local OptLabel = createTextLabel(tostring(opt), UDim2.new(1, -30, 1, 0), UDim2.new(0, 20, 0, 0))
        OptLabel.TextSize = 13
        OptLabel.TextColor3 = (opt == defaultOption) and Theme.AccentEnd or Theme.TextSecondaryColor
        OptLabel.ZIndex = 5
        OptLabel.Parent = OptBtn
        
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfoFast, {BackgroundTransparency = 0.5}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfoFast, {BackgroundTransparency = 1}):Play() end)
        
        OptBtn.MouseButton1Click:Connect(function()
            isOpen = false
            TweenService:Create(DropdownContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 36)}):Play()
            TweenService:Create(Icon, TweenInfoFast, {Rotation = 0}):Play()
            
            Title.Text = text .. ": " .. tostring(opt)
            for _, child in ipairs(OptionsFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextLabel.TextColor3 = Theme.TextSecondaryColor
                end
            end
            OptLabel.TextColor3 = Theme.AccentEnd
            if callback then callback(opt) end
        end)
    end
    
    MainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(DropdownContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, totalHeight)}):Play()
            TweenService:Create(Icon, TweenInfoFast, {Rotation = 180}):Play()
        else
            TweenService:Create(DropdownContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 36)}):Play()
            TweenService:Create(Icon, TweenInfoFast, {Rotation = 0}):Play()
        end
    end)
    
    return DropdownContainer
end

function Framework:CreateMultiDropdown(parentSection, text, options, defaultOptionsTable, callback)
    local selectedTable = {}
    for _, v in ipairs(defaultOptionsTable or {}) do selectedTable[v] = true end
    
    local function getSelectedString()
        local str = ""
        for k, v in pairs(selectedTable) do
            if v then str = str .. k .. ", " end
        end
        if str == "" then return "None" end
        return string.sub(str, 1, -3)
    end

    local DropdownContainer = Instance.new("Frame")
    DropdownContainer.Size = UDim2.new(1, 0, 0, 36)
    DropdownContainer.BackgroundColor3 = Theme.WindowBackground
    DropdownContainer.BackgroundTransparency = 0.5
    DropdownContainer.ClipsDescendants = true
    DropdownContainer.ZIndex = 4
    DropdownContainer.Parent = parentSection
    applyCorner(DropdownContainer)
    applyStroke(DropdownContainer)
    
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, 0, 0, 36)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Text = ""
    MainBtn.ZIndex = 5
    MainBtn.Parent = DropdownContainer
    
    local Title = createTextLabel(text .. ": " .. getSelectedString(), UDim2.new(1, -30, 1, 0), UDim2.new(0, 15, 0, 0))
    Title.TextSize = 13
    Title.ZIndex = 5
    Title.Parent = MainBtn
    
    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 14, 0, 14)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -15, 0.5, 0)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://6031091004"
    Icon.ImageColor3 = Theme.TextSecondaryColor
    Icon.ZIndex = 5
    Icon.Parent = MainBtn
    
    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Size = UDim2.new(1, 0, 1, -36)
    OptionsFrame.Position = UDim2.new(0, 0, 0, 36)
    OptionsFrame.BackgroundTransparency = 1
    OptionsFrame.ZIndex = 5
    OptionsFrame.Parent = DropdownContainer
    
    local OptionLayout = Instance.new("UIListLayout")
    OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptionLayout.Parent = OptionsFrame
    
    local isOpen = false
    local totalHeight = 36
    
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.BackgroundColor3 = Theme.ElementHover
        OptBtn.BackgroundTransparency = 1
        OptBtn.Text = ""
        OptBtn.ZIndex = 5
        OptBtn.Parent = OptionsFrame
        totalHeight = totalHeight + 30
        
        local OptLabel = createTextLabel(tostring(opt), UDim2.new(1, -30, 1, 0), UDim2.new(0, 20, 0, 0))
        OptLabel.TextSize = 13
        OptLabel.TextColor3 = selectedTable[opt] and Theme.AccentEnd or Theme.TextSecondaryColor
        OptLabel.ZIndex = 5
        OptLabel.Parent = OptBtn
        
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfoFast, {BackgroundTransparency = 0.5}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfoFast, {BackgroundTransparency = 1}):Play() end)
        
        OptBtn.MouseButton1Click:Connect(function()
            selectedTable[opt] = not selectedTable[opt]
            OptLabel.TextColor3 = selectedTable[opt] and Theme.AccentEnd or Theme.TextSecondaryColor
            Title.Text = text .. ": " .. getSelectedString()
            if callback then callback(selectedTable) end
        end)
    end
    
    MainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(DropdownContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, totalHeight)}):Play()
            TweenService:Create(Icon, TweenInfoFast, {Rotation = 180}):Play()
        else
            TweenService:Create(DropdownContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 36)}):Play()
            TweenService:Create(Icon, TweenInfoFast, {Rotation = 0}):Play()
        end
    end)
    
    return DropdownContainer
end

function Framework:CreateLabel(parentSection, text)
    local LabelFrame = Instance.new("Frame")
    LabelFrame.Size = UDim2.new(1, 0, 0, 24)
    LabelFrame.BackgroundTransparency = 1
    LabelFrame.ZIndex = 4
    LabelFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(1, -10, 1, 0), UDim2.new(0, 5, 0, 0))
    Title.TextSize = 13
    Title.TextColor3 = Theme.TextSecondaryColor
    Title.ZIndex = 4
    Title.Parent = LabelFrame
    
    return LabelFrame
end

function Framework:CreateTextBox(parentSection, text, placeholder, clearOnFocus, callback)
    local TextBoxFrame = Instance.new("Frame")
    TextBoxFrame.Size = UDim2.new(1, 0, 0, 36)
    TextBoxFrame.BackgroundTransparency = 1
    TextBoxFrame.ZIndex = 4
    TextBoxFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(0, 100, 1, 0))
    Title.TextSize = 14
    Title.ZIndex = 4
    Title.Parent = TextBoxFrame
    
    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -110, 0, 24)
    InputBox.Position = UDim2.new(0, 110, 0.5, -12)
    InputBox.BackgroundColor3 = Theme.WindowBackground
    InputBox.Font = Theme.Font
    InputBox.Text = ""
    InputBox.PlaceholderText = placeholder or ""
    InputBox.TextColor3 = Theme.TextColor
    InputBox.PlaceholderColor3 = Theme.TextSecondaryColor
    InputBox.TextSize = 13
    InputBox.ClearTextOnFocus = clearOnFocus
    InputBox.ClipsDescendants = true
    InputBox.ZIndex = 4
    InputBox.Parent = TextBoxFrame
    applyCorner(InputBox)
    applyStroke(InputBox)
    
    InputBox.FocusLost:Connect(function(enterPressed)
        if callback then callback(InputBox.Text, enterPressed) end
    end)
    
    return TextBoxFrame
end

function Framework:CreateKeybind(parentSection, text, defaultKey, callback)
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Size = UDim2.new(1, 0, 0, 32)
    KeybindFrame.BackgroundTransparency = 1
    KeybindFrame.ZIndex = 4
    KeybindFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(1, -100, 1, 0))
    Title.TextSize = 14
    Title.ZIndex = 4
    Title.Parent = KeybindFrame
    
    local BindBtn = Instance.new("TextButton")
    BindBtn.Size = UDim2.new(0, 80, 0, 24)
    BindBtn.AnchorPoint = Vector2.new(1, 0.5)
    BindBtn.Position = UDim2.new(1, -5, 0.5, 0)
    BindBtn.BackgroundColor3 = Theme.WindowBackground
    BindBtn.Text = defaultKey and defaultKey.Name or "None"
    BindBtn.Font = Theme.Font
    BindBtn.TextColor3 = Theme.AccentEnd
    BindBtn.TextSize = 12
    BindBtn.ZIndex = 4
    BindBtn.Parent = KeybindFrame
    applyCorner(BindBtn)
    applyStroke(BindBtn)
    
    local currentKey = defaultKey
    local isBinding = false
    
    BindBtn.MouseButton1Click:Connect(function()
        if isBinding then return end
        isBinding = true
        BindBtn.Text = "..."
        BindBtn.TextColor3 = Theme.TextColor
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not isBinding then
            if input.KeyCode == currentKey and not gameProcessed then
                if callback then callback(currentKey.Name, true) end
            end
            return
        end
        
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode
            if key == Enum.KeyCode.Escape then
                currentKey = nil
                BindBtn.Text = "None"
            else
                currentKey = key
                BindBtn.Text = key.Name
            end
            BindBtn.TextColor3 = Theme.AccentEnd
            isBinding = false
            if callback then callback(currentKey and currentKey.Name or "None", false) end
        end
    end)
    
    return KeybindFrame
end

function Framework:CreateColorPicker(parentSection, text, defaultColor, callback)
    defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
    local currentColor = defaultColor
    local hue, sat, val = Color3.toHSV(defaultColor)
    
    local ColorContainer = Instance.new("Frame")
    ColorContainer.Size = UDim2.new(1, 0, 0, 36)
    ColorContainer.BackgroundColor3 = Theme.WindowBackground
    ColorContainer.ClipsDescendants = true
    ColorContainer.ZIndex = 4
    ColorContainer.Parent = parentSection
    applyCorner(ColorContainer)
    applyStroke(ColorContainer)
    
    local MainBtn = Instance.new("TextButton")
    MainBtn.Size = UDim2.new(1, 0, 0, 36)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Text = ""
    MainBtn.ZIndex = 5
    MainBtn.Parent = ColorContainer
    
    local Title = createTextLabel(text, UDim2.new(1, -60, 1, 0), UDim2.new(0, 15, 0, 0))
    Title.TextSize = 13
    Title.ZIndex = 5
    Title.Parent = MainBtn
    
    local PreviewColor = Instance.new("Frame")
    PreviewColor.Size = UDim2.new(0, 24, 0, 16)
    PreviewColor.AnchorPoint = Vector2.new(1, 0.5)
    PreviewColor.Position = UDim2.new(1, -15, 0.5, 0)
    PreviewColor.BackgroundColor3 = currentColor
    PreviewColor.ZIndex = 5
    PreviewColor.Parent = MainBtn
    applyCorner(PreviewColor, UDim.new(0, 4))
    applyStroke(PreviewColor, Color3.fromRGB(0,0,0), 0.5)
    
    local PickerArea = Instance.new("Frame")
    PickerArea.Size = UDim2.new(1, 0, 0, 160)
    PickerArea.Position = UDim2.new(0, 0, 0, 36)
    PickerArea.BackgroundTransparency = 1
    PickerArea.ZIndex = 5
    PickerArea.Parent = ColorContainer
    
    -- Color Wheel Image
    local Wheel = Instance.new("ImageButton")
    Wheel.Size = UDim2.new(0, 140, 0, 140)
    Wheel.Position = UDim2.new(0, 15, 0, 10)
    Wheel.BackgroundTransparency = 1
    Wheel.Image = "rbxassetid://6020110098" -- Standard Color Wheel
    Wheel.ZIndex = 6
    Wheel.Parent = PickerArea
    
    local WheelPicker = Instance.new("Frame")
    WheelPicker.Size = UDim2.new(0, 6, 0, 6)
    WheelPicker.AnchorPoint = Vector2.new(0.5, 0.5)
    WheelPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WheelPicker.ZIndex = 7
    WheelPicker.Parent = Wheel
    applyCorner(WheelPicker, UDim.new(1, 0))
    applyStroke(WheelPicker, Color3.fromRGB(0,0,0), 0)
    
    -- Value Slider (Brightness)
    local ValSlider = Instance.new("TextButton")
    ValSlider.Text = ""
    ValSlider.Size = UDim2.new(0, 20, 0, 140)
    ValSlider.Position = UDim2.new(0, 170, 0, 10)
    ValSlider.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ValSlider.ZIndex = 6
    ValSlider.Parent = PickerArea
    applyCorner(ValSlider, UDim.new(0, 4))
    
    local ValGradient = Instance.new("UIGradient")
    ValGradient.Rotation = 90
    ValGradient.Parent = ValSlider
    
    local ValMarker = Instance.new("Frame")
    ValMarker.Size = UDim2.new(1, 4, 0, 4)
    ValMarker.AnchorPoint = Vector2.new(0.5, 0.5)
    ValMarker.Position = UDim2.new(0.5, 0, 1 - val, 0)
    ValMarker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValMarker.ZIndex = 7
    ValMarker.Parent = ValSlider
    applyStroke(ValMarker, Color3.fromRGB(0,0,0), 0)
    
    local function updateVisuals()
        currentColor = Color3.fromHSV(hue, sat, val)
        PreviewColor.BackgroundColor3 = currentColor
        ValGradient.Color = ColorSequence.new(Color3.fromHSV(hue, sat, 1), Color3.fromRGB(0, 0, 0))
        
        -- Update Wheel Picker Position
        local angle = hue * math.pi * 2
        local radius = sat * (Wheel.AbsoluteSize.X / 2)
        local cx = Wheel.AbsoluteSize.X / 2
        local cy = Wheel.AbsoluteSize.Y / 2
        local x = cx + math.cos(angle) * radius
        local y = cy + math.sin(angle) * radius
        WheelPicker.Position = UDim2.new(0, x, 0, y)
        
        -- Update Value Marker Position
        ValMarker.Position = UDim2.new(0.5, 0, 1 - val, 0)
        
        if callback then callback(currentColor) end
    end
    
    -- Wait for UI to render to set initial wheel picker position accurately
    task.spawn(function()
        task.wait(0.1)
        updateVisuals()
    end)
    
    local draggingWheel = false
    Wheel.MouseButton1Down:Connect(function() draggingWheel = true end)
    
    local draggingVal = false
    ValSlider.MouseButton1Down:Connect(function() draggingVal = true end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingWheel = false
            draggingVal = false
        end
    end)
    
    local function updateWheelInput(inputPos)
        local cx = Wheel.AbsolutePosition.X + (Wheel.AbsoluteSize.X / 2)
        local cy = Wheel.AbsolutePosition.Y + (Wheel.AbsoluteSize.Y / 2)
        local dx = inputPos.X - cx
        local dy = inputPos.Y - cy
        
        local angle = math.atan2(dy, dx)
        local distance = math.sqrt(dx^2 + dy^2)
        local maxRadius = Wheel.AbsoluteSize.X / 2
        
        sat = math.clamp(distance / maxRadius, 0, 1)
        hue = (angle + math.pi) / (math.pi * 2) -- Map -pi..pi to 0..1
        -- Re-adjust hue since atan2 might be offset depending on the image. Typical wheels have red at 0.
        hue = (hue + 0.5) % 1
        
        updateVisuals()
    end
    
    local function updateValInput(inputPos)
        local y = inputPos.Y - ValSlider.AbsolutePosition.Y
        val = 1 - math.clamp(y / ValSlider.AbsoluteSize.Y, 0, 1)
        updateVisuals()
    end
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if draggingWheel then updateWheelInput(input.Position) end
            if draggingVal then updateValInput(input.Position) end
        end
    end)
    
    Wheel.MouseButton1Click:Connect(function()
        local pos = UserInputService:GetMouseLocation()
        -- Adjust for GUI inset
        updateWheelInput(Vector2.new(pos.X, pos.Y - 36))
    end)
    ValSlider.MouseButton1Click:Connect(function()
        local pos = UserInputService:GetMouseLocation()
        updateValInput(Vector2.new(pos.X, pos.Y - 36))
    end)
    
    local isOpen = false
    MainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(ColorContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 196)}):Play()
        else
            TweenService:Create(ColorContainer, TweenInfoFast, {Size = UDim2.new(1, 0, 0, 36)}):Play()
        end
    end)
    
    return ColorContainer
end

return Framework
