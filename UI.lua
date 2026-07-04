local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Theme & Design Constants (Modern Karpiware + Glass + Gradient)
local Theme = {
    WindowBackground = Color3.fromRGB(18, 18, 22),
    SidebarBackground = Color3.fromRGB(12, 12, 16),
    SectionBackground = Color3.fromRGB(24, 24, 30),
    
    WindowTransparency = 0.15, -- Modern glass hint
    SidebarTransparency = 0.25,
    SectionTransparency = 0.1,
    
    ElementHover = Color3.fromRGB(35, 35, 45),
    TabSelected = Color3.fromRGB(35, 35, 45),
    
    -- Accent colors for gradients
    AccentStart = Color3.fromRGB(90, 120, 255),
    AccentEnd = Color3.fromRGB(160, 100, 255),
    
    ToggleOff = Color3.fromRGB(40, 40, 48),
    
    TextColor = Color3.fromRGB(245, 245, 245),
    TextSecondaryColor = Color3.fromRGB(140, 140, 150),
    
    BorderColor = Color3.fromRGB(45, 45, 55),
    BorderTransparency = 0.3,
    
    Font = Enum.Font.Gotham, -- Modern, clean font
    BoldFont = Enum.Font.GothamBold,
    CornerRadius = UDim.new(0, 8) -- Softer corners
}

local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

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
    label.TextSize = 13
    label.TextXAlignment = alignment or Enum.TextXAlignment.Left
    return label
end

-- Core API
function Framework.new()
    local self = setmetatable({}, Framework)
    return self
end

function Framework:CreateWindow(screenGui, titleText, subtitleText)
    -- Main Window Frame
    local Window = Instance.new("Frame")
    Window.Name = "ModernWindow"
    Window.Size = UDim2.new(0, 680, 0, 460)
    Window.Position = UDim2.new(0.5, -340, 0.5, -230)
    Window.BackgroundColor3 = Theme.WindowBackground
    Window.BackgroundTransparency = Theme.WindowTransparency
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    applyCorner(Window)
    applyStroke(Window)
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 180, 1, 0)
    Sidebar.BackgroundColor3 = Theme.SidebarBackground
    Sidebar.BackgroundTransparency = Theme.SidebarTransparency
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Window
    applyCorner(Sidebar)
    
    -- Fix corner overlap between Sidebar and Window
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 10, 1, 0)
    SidebarFix.Position = UDim2.new(1, -10, 0, 0)
    SidebarFix.BackgroundColor3 = Theme.SidebarBackground
    SidebarFix.BackgroundTransparency = Theme.SidebarTransparency
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Parent = Sidebar
    
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
    SidebarDivider.BackgroundColor3 = Theme.BorderColor
    SidebarDivider.BackgroundTransparency = Theme.BorderTransparency
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.Parent = Sidebar
    
    -- Title Area
    local TitleArea = Instance.new("Frame")
    TitleArea.Size = UDim2.new(1, 0, 0, 70)
    TitleArea.BackgroundTransparency = 1
    TitleArea.Parent = Sidebar
    
    local Title = createTextLabel(titleText or "Hub", UDim2.new(1, -30, 0, 20), UDim2.new(0, 15, 0, 20), Enum.TextXAlignment.Left, true)
    Title.TextSize = 18
    Title.Parent = TitleArea
    
    local Subtitle = createTextLabel(subtitleText or "Interface", UDim2.new(1, -30, 0, 15), UDim2.new(0, 15, 0, 42), Enum.TextXAlignment.Left, false)
    Subtitle.TextSize = 11
    Subtitle.TextColor3 = Theme.TextSecondaryColor
    Subtitle.Parent = TitleArea
    
    -- Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -130)
    TabContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 2
    TabContainer.ScrollBarImageColor3 = Theme.TextSecondaryColor
    TabContainer.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 6)
    TabListLayout.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 15)
    TabPadding.PaddingRight = UDim.new(0, 15)
    TabPadding.Parent = TabContainer
    
    -- Profile Section
    local ProfileContainer = Instance.new("Frame")
    ProfileContainer.Name = "ProfileContainer"
    ProfileContainer.Size = UDim2.new(1, 0, 0, 60)
    ProfileContainer.Position = UDim2.new(0, 0, 1, -60)
    ProfileContainer.BackgroundTransparency = 1
    ProfileContainer.Parent = Sidebar
    
    local ProfileDivider = Instance.new("Frame")
    ProfileDivider.Size = UDim2.new(1, -30, 0, 1)
    ProfileDivider.Position = UDim2.new(0, 15, 0, 0)
    ProfileDivider.BackgroundColor3 = Theme.BorderColor
    ProfileDivider.BackgroundTransparency = Theme.BorderTransparency
    ProfileDivider.BorderSizePixel = 0
    ProfileDivider.Parent = ProfileContainer
    
    local AvatarIcon = Instance.new("ImageLabel")
    AvatarIcon.Size = UDim2.new(0, 34, 0, 34)
    AvatarIcon.Position = UDim2.new(0, 15, 0.5, -17)
    AvatarIcon.BackgroundColor3 = Theme.SectionBackground
    AvatarIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    AvatarIcon.Parent = ProfileContainer
    applyCorner(AvatarIcon, UDim.new(1, 0))
    
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local success, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        if success then AvatarIcon.Image = thumb end
    end
    
    local UsernameLabel = createTextLabel(localPlayer and localPlayer.Name or "User", UDim2.new(1, -95, 0, 15), UDim2.new(0, 58, 0.5, -16), Enum.TextXAlignment.Left, true)
    UsernameLabel.TextSize = 12
    UsernameLabel.Parent = ProfileContainer
    
    local SubLabel = createTextLabel("Premium", UDim2.new(1, -95, 0, 15), UDim2.new(0, 58, 0.5, 0), Enum.TextXAlignment.Left, false)
    SubLabel.TextSize = 10
    SubLabel.TextColor3 = Theme.AccentEnd
    SubLabel.Parent = ProfileContainer
    
    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Size = UDim2.new(0, 16, 0, 16)
    SettingsBtn.Position = UDim2.new(1, -30, 0.5, -8)
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Image = "rbxassetid://7059346373"
    SettingsBtn.ImageColor3 = Theme.TextSecondaryColor
    SettingsBtn.Parent = ProfileContainer
    
    SettingsBtn.MouseEnter:Connect(function() 
        TweenService:Create(SettingsBtn, TweenInfoFast, {ImageColor3 = Theme.TextColor}):Play()
    end)
    SettingsBtn.MouseLeave:Connect(function() 
        TweenService:Create(SettingsBtn, TweenInfoFast, {ImageColor3 = Theme.TextSecondaryColor}):Play()
    end)
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -180, 1, 0)
    ContentArea.Position = UDim2.new(0, 180, 0, 0)
    ContentArea.BackgroundTransparency = 1
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
    TabButton.Size = UDim2.new(1, 0, 0, 36)
    TabButton.BackgroundColor3 = Theme.TabSelected
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.Parent = windowObj.TabContainer
    applyCorner(TabButton)
    
    local TabIcon = Instance.new("ImageLabel")
    TabIcon.Size = UDim2.new(0, 16, 0, 16)
    TabIcon.Position = UDim2.new(0, 12, 0.5, -8)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Image = iconId or "rbxassetid://6031094678"
    TabIcon.ImageColor3 = Theme.TextSecondaryColor
    TabIcon.Parent = TabButton
    
    local TabLabel = createTextLabel(tabName, UDim2.new(1, -40, 1, 0), UDim2.new(0, 36, 0, 0), Enum.TextXAlignment.Left, true)
    TabLabel.TextColor3 = Theme.TextSecondaryColor
    TabLabel.TextSize = 13
    TabLabel.Parent = TabButton
    
    -- Tab Content columns
    local TabContent = Instance.new("Frame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = windowObj.ContentArea
    
    local LeftColumn = Instance.new("ScrollingFrame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.5, -15, 1, -30)
    LeftColumn.Position = UDim2.new(0, 15, 0, 15)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.BorderSizePixel = 0
    LeftColumn.ScrollBarThickness = 0
    LeftColumn.Parent = TabContent
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Padding = UDim.new(0, 12)
    LeftLayout.Parent = LeftColumn
    
    local RightColumn = Instance.new("ScrollingFrame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.5, -15, 1, -30)
    RightColumn.Position = UDim2.new(0.5, 5, 0, 15)
    RightColumn.BackgroundTransparency = 1
    RightColumn.BorderSizePixel = 0
    RightColumn.ScrollBarThickness = 0
    RightColumn.Parent = TabContent
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.Padding = UDim.new(0, 12)
    RightLayout.Parent = RightColumn
    
    local function SelectTab()
        for _, t in pairs(windowObj.Tabs) do
            TweenService:Create(t.Button, TweenInfoFast, {BackgroundTransparency = 1}):Play()
            TweenService:Create(t.Icon, TweenInfoFast, {ImageColor3 = Theme.TextSecondaryColor}):Play()
            TweenService:Create(t.Label, TweenInfoFast, {TextColor3 = Theme.TextSecondaryColor}):Play()
            t.Content.Visible = false
        end
        TweenService:Create(TabButton, TweenInfoFast, {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(TabIcon, TweenInfoFast, {ImageColor3 = Theme.TextColor}):Play()
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
    SectionFrame.Parent = col
    applyCorner(SectionFrame)
    applyStroke(SectionFrame)
    
    local SectionContent = Instance.new("Frame")
    SectionContent.Size = UDim2.new(1, 0, 1, 0)
    SectionContent.Position = UDim2.new(0, 0, 0, 0)
    SectionContent.BackgroundTransparency = 1
    SectionContent.Parent = SectionFrame
    
    if title and title ~= "" then
        local SectionTitle = createTextLabel(title, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 0), Enum.TextXAlignment.Left, true)
        SectionTitle.TextColor3 = Theme.TextSecondaryColor
        SectionTitle.Parent = SectionFrame
        
        local TitleLine = Instance.new("Frame")
        TitleLine.Size = UDim2.new(1, -20, 0, 1)
        TitleLine.Position = UDim2.new(0, 10, 0, 30)
        TitleLine.BackgroundColor3 = Theme.BorderColor
        TitleLine.BackgroundTransparency = Theme.BorderTransparency
        TitleLine.BorderSizePixel = 0
        TitleLine.Parent = SectionFrame
        
        SectionContent.Size = UDim2.new(1, 0, 1, -35)
        SectionContent.Position = UDim2.new(0, 0, 0, 35)
    end
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.Parent = SectionContent
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.PaddingRight = UDim.new(0, 12)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = SectionContent
    
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local extra = (title and title ~= "") and 45 or 20
        SectionContent.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y)
        SectionFrame.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y + extra)
        col.CanvasSize = UDim2.new(0, 0, 0, col.UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    return SectionContent
end

function Framework:CreateToggle(parentSection, text, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 26)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(1, -45, 1, 0), UDim2.new(0, 0, 0, 0))
    Title.TextSize = 13
    Title.Parent = ToggleFrame
    
    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Text = ""
    SwitchBg.Size = UDim2.new(0, 36, 0, 20)
    SwitchBg.Position = UDim2.new(1, -36, 0.5, -10)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchBg.Parent = ToggleFrame
    applyCorner(SwitchBg, UDim.new(1, 0))
    
    -- Add Gradient that only shows when ON
    local bgGradient = applyGradient(SwitchBg)
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(default and 1 or 0, default and -18 or 2, 0.5, -8)
    Circle.BackgroundColor3 = default and Theme.WindowBackground or Theme.TextSecondaryColor
    Circle.Parent = SwitchBg
    applyCorner(Circle, UDim.new(1, 0))
    
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.fromRGB(0,0,0)
    shadow.Transparency = 0.8
    shadow.Thickness = 2
    shadow.Parent = Circle
    
    local toggled = default
    
    -- Initial state visual setup
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
            TweenService:Create(Circle, TweenInfoFast, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(SwitchBg, TweenInfoFast, {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            bgGradient.Enabled = false
            TweenService:Create(Circle, TweenInfoFast, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Theme.TextSecondaryColor}):Play()
            TweenService:Create(SwitchBg, TweenInfoFast, {BackgroundColor3 = Theme.ToggleOff}):Play()
        end
    end)
    
    return ToggleFrame
end

function Framework:CreateSlider(parentSection, text, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 36)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(0, 100, 0, 16))
    Title.TextSize = 13
    Title.Parent = SliderFrame
    
    local ValueBox = Instance.new("Frame")
    ValueBox.Size = UDim2.new(0, 32, 0, 18)
    ValueBox.Position = UDim2.new(1, -32, 0, 0)
    ValueBox.BackgroundColor3 = Theme.WindowBackground
    ValueBox.Parent = SliderFrame
    applyCorner(ValueBox)
    applyStroke(ValueBox)
    
    local ValueLabel = createTextLabel(tostring(default), UDim2.new(1, 0, 1, 0), UDim2.new(0,0,0,0), Enum.TextXAlignment.Center, true)
    ValueLabel.TextSize = 11
    ValueLabel.Parent = ValueBox
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, 0, 0, 6)
    Track.Position = UDim2.new(0, 0, 1, -6)
    Track.BackgroundColor3 = Theme.ToggleOff
    Track.Parent = SliderFrame
    applyCorner(Track, UDim.new(1, 0))
    
    local percent = (default - min) / (max - min)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Fill.Parent = Track
    applyCorner(Fill, UDim.new(1, 0))
    
    -- Gradient for Slider Fill
    applyGradient(Fill)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new(1, -6, 0.5, -6)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = Fill
    applyCorner(Knob, UDim.new(1, 0))
    
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.fromRGB(0,0,0)
    shadow.Transparency = 0.8
    shadow.Thickness = 2
    shadow.Parent = Knob
    
    return SliderFrame
end

function Framework:CreateButton(parentSection, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 28)
    ButtonFrame.BackgroundColor3 = Theme.ElementHover
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = parentSection
    applyCorner(ButtonFrame)
    applyStroke(ButtonFrame)
    
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    TextButton.BackgroundTransparency = 1
    TextButton.Font = Theme.Font
    TextButton.Text = text
    TextButton.TextColor3 = Theme.TextColor
    TextButton.TextSize = 13
    TextButton.Parent = ButtonFrame
    
    TextButton.MouseEnter:Connect(function() 
        TweenService:Create(ButtonFrame, TweenInfoFast, {BackgroundTransparency = 0.5}):Play()
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
