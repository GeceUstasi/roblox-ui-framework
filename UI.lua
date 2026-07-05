local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ═══════════════════════════════════════════════════
-- THEME (Neverlose-inspired: Dark, Flat, Compact)
-- ═══════════════════════════════════════════════════
local Theme = {
    Background = Color3.fromRGB(14, 14, 18),
    HeaderBg = Color3.fromRGB(18, 18, 22),
    SidebarBg = Color3.fromRGB(18, 18, 22),
    ContentBg = Color3.fromRGB(20, 20, 24),
    ElementBg = Color3.fromRGB(30, 30, 36),
    ElementHover = Color3.fromRGB(38, 38, 44),
    
    Accent = Color3.fromRGB(85, 130, 255),
    AccentDim = Color3.fromRGB(55, 85, 180),
    
    ToggleOn = Color3.fromRGB(85, 130, 255),
    ToggleOff = Color3.fromRGB(50, 50, 56),
    
    TextPrimary = Color3.fromRGB(210, 210, 215),
    TextSecondary = Color3.fromRGB(110, 110, 120),
    TextMuted = Color3.fromRGB(65, 65, 72),
    TextAccent = Color3.fromRGB(85, 130, 255),
    
    Border = Color3.fromRGB(32, 32, 38),
    Divider = Color3.fromRGB(28, 28, 34),
    
    SliderFill = Color3.fromRGB(85, 130, 255),
    SliderBg = Color3.fromRGB(38, 38, 44),
    
    Font = Enum.Font.Gotham,
    BoldFont = Enum.Font.GothamBold,
    SemiBold = Enum.Font.GothamSemibold,
    
    Corner = UDim.new(0, 4),
    SmallCorner = UDim.new(0, 3),
}

local TweenFast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenSmooth = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- ═══════════════════════════════════════════════════
-- UTILITY HELPERS
-- ═══════════════════════════════════════════════════
local function applyCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius or Theme.Corner
    c.Parent = parent
    return c
end

local function applyStroke(parent, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Transparency = transparency or 0
    s.Thickness = 1
    s.Parent = parent
    return s
end

local function createLabel(text, size, pos, xAlign, isBold)
    local l = Instance.new("TextLabel")
    l.Size = size
    l.Position = pos or UDim2.new(0, 0, 0, 0)
    l.BackgroundTransparency = 1
    l.Font = isBold and Theme.BoldFont or Theme.Font
    l.Text = text
    l.TextColor3 = Theme.TextPrimary
    l.TextSize = 12
    l.TextXAlignment = xAlign or Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd
    return l
end

-- ═══════════════════════════════════════════════════
-- CORE API
-- ═══════════════════════════════════════════════════
function Framework.new()
    return setmetatable({}, Framework)
end

function Framework:CreateWindow(screenGui, titleText, subtitleText)
    -- Main Window
    local Window = Instance.new("Frame")
    Window.Name = "NeverloseWindow"
    Window.Size = UDim2.new(0, 780, 0, 500)
    Window.Position = UDim2.new(0.5, -390, 0.5, -250)
    Window.BackgroundColor3 = Theme.Background
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = screenGui
    applyCorner(Window, UDim.new(0, 6))
    applyStroke(Window)
    
    -- Drop shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 50, 1, 50)
    Shadow.Position = UDim2.new(0, -25, 0, -25)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5028857084"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.4
    Shadow.ZIndex = 0
    Shadow.Parent = Window
    
    -- ═══ HEADER BAR ═══
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 38)
    Header.BackgroundColor3 = Theme.HeaderBg
    Header.BorderSizePixel = 0
    Header.ZIndex = 5
    Header.Parent = Window
    
    -- Bottom border for header
    local HeaderLine = Instance.new("Frame")
    HeaderLine.Size = UDim2.new(1, 0, 0, 1)
    HeaderLine.Position = UDim2.new(0, 0, 1, -1)
    HeaderLine.BackgroundColor3 = Theme.Border
    HeaderLine.BorderSizePixel = 0
    HeaderLine.ZIndex = 5
    HeaderLine.Parent = Header
    
    -- Logo box
    local LogoBox = Instance.new("Frame")
    LogoBox.Size = UDim2.new(0, 28, 0, 20)
    LogoBox.Position = UDim2.new(0, 12, 0.5, -10)
    LogoBox.BackgroundColor3 = Theme.Accent
    LogoBox.ZIndex = 6
    LogoBox.Parent = Header
    applyCorner(LogoBox, UDim.new(0, 3))
    
    local LogoText = Instance.new("TextLabel")
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Font = Theme.BoldFont
    LogoText.Text = string.sub(titleText or "HB", 1, 2):upper()
    LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoText.TextSize = 10
    LogoText.ZIndex = 7
    LogoText.Parent = LogoBox
    
    -- Title
    local TitleLabel = createLabel(titleText or "Hub", UDim2.new(0, 120, 0, 14), UDim2.new(0, 48, 0, 7), Enum.TextXAlignment.Left, true)
    TitleLabel.TextSize = 13
    TitleLabel.ZIndex = 6
    TitleLabel.Parent = Header
    
    -- Subtitle
    local SubLabel = createLabel(subtitleText or "", UDim2.new(0, 120, 0, 12), UDim2.new(0, 48, 0, 21), Enum.TextXAlignment.Left, false)
    SubLabel.TextSize = 10
    SubLabel.TextColor3 = Theme.TextSecondary
    SubLabel.ZIndex = 6
    SubLabel.Parent = Header
    
    -- Minimize & Close buttons (top right)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 38, 0, 38)
    CloseBtn.Position = UDim2.new(1, -38, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Theme.TextSecondary
    CloseBtn.TextSize = 18
    CloseBtn.Font = Theme.Font
    CloseBtn.ZIndex = 6
    CloseBtn.Parent = Header
    CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenFast, {TextColor3 = Color3.fromRGB(220, 80, 80)}):Play() end)
    CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenFast, {TextColor3 = Theme.TextSecondary}):Play() end)
    CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
    
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 38, 0, 38)
    MinBtn.Position = UDim2.new(1, -76, 0, 0)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "−"
    MinBtn.TextColor3 = Theme.TextSecondary
    MinBtn.TextSize = 18
    MinBtn.Font = Theme.Font
    MinBtn.ZIndex = 6
    MinBtn.Parent = Header
    MinBtn.MouseEnter:Connect(function() TweenService:Create(MinBtn, TweenFast, {TextColor3 = Theme.TextPrimary}):Play() end)
    MinBtn.MouseLeave:Connect(function() TweenService:Create(MinBtn, TweenFast, {TextColor3 = Theme.TextSecondary}):Play() end)
    
    local minimized = false
    local savedSize = Window.Size
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            savedSize = Window.Size
            TweenService:Create(Window, TweenSmooth, {Size = UDim2.new(0, savedSize.X.Offset, 0, 38)}):Play()
        else
            TweenService:Create(Window, TweenSmooth, {Size = savedSize}):Play()
        end
    end)
    
    -- ═══ DRAGGING ═══
    local dragging, dragInput, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- ═══ LEFT SIDEBAR ═══
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 150, 1, -38)
    Sidebar.Position = UDim2.new(0, 0, 0, 38)
    Sidebar.BackgroundColor3 = Theme.SidebarBg
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 3
    Sidebar.Parent = Window
    
    -- Sidebar right border
    local SidebarBorder = Instance.new("Frame")
    SidebarBorder.Size = UDim2.new(0, 1, 1, 0)
    SidebarBorder.Position = UDim2.new(1, 0, 0, 0)
    SidebarBorder.BackgroundColor3 = Theme.Border
    SidebarBorder.BorderSizePixel = 0
    SidebarBorder.ZIndex = 4
    SidebarBorder.Parent = Sidebar
    
    -- Tab container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -65)
    TabContainer.Position = UDim2.new(0, 0, 0, 10)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 0
    TabContainer.ZIndex = 4
    TabContainer.Parent = Sidebar
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 2)
    TabLayout.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingLeft = UDim.new(0, 14)
    TabPadding.PaddingRight = UDim.new(0, 14)
    TabPadding.Parent = TabContainer
    
    -- Profile at bottom of sidebar
    local ProfileArea = Instance.new("Frame")
    ProfileArea.Size = UDim2.new(1, 0, 0, 50)
    ProfileArea.Position = UDim2.new(0, 0, 1, -50)
    ProfileArea.BackgroundTransparency = 1
    ProfileArea.ZIndex = 4
    ProfileArea.Parent = Sidebar
    
    local ProfileDivider = Instance.new("Frame")
    ProfileDivider.Size = UDim2.new(1, -24, 0, 1)
    ProfileDivider.Position = UDim2.new(0, 12, 0, 0)
    ProfileDivider.BackgroundColor3 = Theme.Border
    ProfileDivider.BorderSizePixel = 0
    ProfileDivider.ZIndex = 4
    ProfileDivider.Parent = ProfileArea
    
    local Avatar = Instance.new("ImageLabel")
    Avatar.Size = UDim2.new(0, 28, 0, 28)
    Avatar.Position = UDim2.new(0, 14, 0.5, -10)
    Avatar.BackgroundColor3 = Theme.ElementBg
    Avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Avatar.ZIndex = 5
    Avatar.Parent = ProfileArea
    applyCorner(Avatar, UDim.new(1, 0))
    
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        end)
        if ok then Avatar.Image = thumb end
    end
    
    local UserLabel = createLabel(localPlayer and localPlayer.Name or "User", UDim2.new(1, -56, 0, 14), UDim2.new(0, 48, 0.5, -13), Enum.TextXAlignment.Left, true)
    UserLabel.TextSize = 11
    UserLabel.ZIndex = 5
    UserLabel.Parent = ProfileArea
    
    local StatusLabel = createLabel("Online", UDim2.new(1, -56, 0, 12), UDim2.new(0, 48, 0.5, 2), Enum.TextXAlignment.Left, false)
    StatusLabel.TextSize = 10
    StatusLabel.TextColor3 = Color3.fromRGB(80, 180, 100)
    StatusLabel.ZIndex = 5
    StatusLabel.Parent = ProfileArea
    
    -- ═══ CONTENT AREA ═══
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -151, 1, -38)
    ContentArea.Position = UDim2.new(0, 151, 0, 38)
    ContentArea.BackgroundColor3 = Theme.ContentBg
    ContentArea.BorderSizePixel = 0
    ContentArea.ZIndex = 2
    ContentArea.Parent = Window
    
    -- UI Toggle (RightShift)
    local uiVisible = true
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiVisible = not uiVisible
            screenGui.Enabled = uiVisible
        end
    end)
    
    return {
        Frame = Window,
        ScreenGui = screenGui,
        TabContainer = TabContainer,
        ContentArea = ContentArea,
        Tabs = {},
        ActiveTab = nil,
        _configValues = {}
    }
end

-- ═══════════════════════════════════════════════════
-- TABS (Neverlose style: text-only with active indicator)
-- ═══════════════════════════════════════════════════
function Framework:CreateTab(windowObj, tabName, iconId)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 30)
    TabBtn.BackgroundColor3 = Theme.SidebarBg
    TabBtn.BackgroundTransparency = 1
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = ""
    TabBtn.ZIndex = 5
    TabBtn.Parent = windowObj.TabContainer
    applyCorner(TabBtn, UDim.new(0, 4))
    
    -- Active indicator (left accent bar)
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0, 14)
    Indicator.Position = UDim2.new(0, 0, 0.5, -7)
    Indicator.BackgroundColor3 = Theme.Accent
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.ZIndex = 6
    Indicator.Parent = TabBtn
    applyCorner(Indicator, UDim.new(0, 2))
    
    -- Icon (small)
    if iconId then
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 14, 0, 14)
        Icon.Position = UDim2.new(0, 12, 0.5, -7)
        Icon.BackgroundTransparency = 1
        Icon.Image = iconId
        Icon.ImageColor3 = Theme.TextSecondary
        Icon.ZIndex = 6
        Icon.Parent = TabBtn
    end
    
    local TabLabel = createLabel(tabName, UDim2.new(1, -40, 1, 0), UDim2.new(0, iconId and 32 or 12, 0, 0), Enum.TextXAlignment.Left, false)
    TabLabel.TextSize = 12
    TabLabel.TextColor3 = Theme.TextSecondary
    TabLabel.ZIndex = 6
    TabLabel.Parent = TabBtn
    
    -- Content page for this tab
    local Page = Instance.new("ScrollingFrame")
    Page.Name = tabName .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Theme.TextMuted
    Page.Visible = false
    Page.ZIndex = 3
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Parent = windowObj.ContentArea
    
    -- Two-column layout container
    local LeftColumn = Instance.new("Frame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.5, -1, 1, 0)
    LeftColumn.Position = UDim2.new(0, 0, 0, 0)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.ZIndex = 3
    LeftColumn.Parent = Page
    
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 0)
    LeftLayout.Parent = LeftColumn
    
    local LeftPad = Instance.new("UIPadding")
    LeftPad.PaddingTop = UDim.new(0, 8)
    LeftPad.PaddingLeft = UDim.new(0, 12)
    LeftPad.PaddingRight = UDim.new(0, 6)
    LeftPad.Parent = LeftColumn
    
    local RightColumn = Instance.new("Frame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.5, -1, 1, 0)
    RightColumn.Position = UDim2.new(0.5, 1, 0, 0)
    RightColumn.BackgroundTransparency = 1
    RightColumn.ZIndex = 3
    RightColumn.Parent = Page
    
    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 0)
    RightLayout.Parent = RightColumn
    
    local RightPad = Instance.new("UIPadding")
    RightPad.PaddingTop = UDim.new(0, 8)
    RightPad.PaddingLeft = UDim.new(0, 6)
    RightPad.PaddingRight = UDim.new(0, 12)
    RightPad.Parent = RightColumn
    
    -- Column divider
    local ColDivider = Instance.new("Frame")
    ColDivider.Size = UDim2.new(0, 1, 1, -16)
    ColDivider.Position = UDim2.new(0.5, 0, 0, 8)
    ColDivider.BackgroundColor3 = Theme.Divider
    ColDivider.BorderSizePixel = 0
    ColDivider.ZIndex = 3
    ColDivider.Parent = Page
    
    local tabData = {
        Button = TabBtn,
        Page = Page,
        Indicator = Indicator,
        Label = TabLabel,
        LeftColumn = LeftColumn,
        RightColumn = RightColumn
    }
    
    table.insert(windowObj.Tabs, tabData)
    
    -- Tab click behavior
    TabBtn.MouseButton1Click:Connect(function()
        -- Deactivate all
        for _, t in ipairs(windowObj.Tabs) do
            t.Page.Visible = false
            t.Indicator.Visible = false
            t.Label.TextColor3 = Theme.TextSecondary
            t.Label.Font = Theme.Font
            TweenService:Create(t.Button, TweenFast, {BackgroundTransparency = 1}):Play()
        end
        -- Activate this
        tabData.Page.Visible = true
        tabData.Indicator.Visible = true
        tabData.Label.TextColor3 = Theme.TextPrimary
        tabData.Label.Font = Theme.SemiBold
        TweenService:Create(TabBtn, TweenFast, {BackgroundTransparency = 0.85}):Play()
        windowObj.ActiveTab = tabData
    end)
    
    TabBtn.MouseEnter:Connect(function()
        if windowObj.ActiveTab ~= tabData then
            TweenService:Create(TabBtn, TweenFast, {BackgroundTransparency = 0.9}):Play()
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if windowObj.ActiveTab ~= tabData then
            TweenService:Create(TabBtn, TweenFast, {BackgroundTransparency = 1}):Play()
        end
    end)
    
    -- Auto-select first tab
    if #windowObj.Tabs == 1 then
        TabBtn.MouseButton1Click:Fire()
    end
    
    return tabData
end

-- ═══════════════════════════════════════════════════
-- SECTIONS (Neverlose: Just an uppercase title, no box)
-- ═══════════════════════════════════════════════════
function Framework:CreateSection(tabData, sectionName, side)
    local column = (side == "Right") and tabData.RightColumn or tabData.LeftColumn
    
    -- Section header (small uppercase text)
    local SectionHeader = Instance.new("Frame")
    SectionHeader.Size = UDim2.new(1, 0, 0, 24)
    SectionHeader.BackgroundTransparency = 1
    SectionHeader.ZIndex = 4
    SectionHeader.Parent = column
    
    local HeaderLabel = createLabel(string.upper(sectionName), UDim2.new(1, 0, 1, 0), UDim2.new(0, 2, 0, 0), Enum.TextXAlignment.Left, true)
    HeaderLabel.TextSize = 10
    HeaderLabel.TextColor3 = Theme.TextMuted
    HeaderLabel.ZIndex = 5
    HeaderLabel.Parent = SectionHeader
    
    -- Container for elements (no background!)
    local Container = Instance.new("Frame")
    Container.Name = sectionName .. "Container"
    Container.Size = UDim2.new(1, 0, 0, 0)
    Container.BackgroundTransparency = 1
    Container.AutomaticSize = Enum.AutomaticSize.Y
    Container.ZIndex = 4
    Container.Parent = column
    
    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 1)
    Layout.Parent = Container
    
    -- Auto-resize canvas
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local totalY = 0
        for _, col in ipairs({tabData.LeftColumn, tabData.RightColumn}) do
            local ly = col:FindFirstChildOfClass("UIListLayout")
            if ly then totalY = math.max(totalY, ly.AbsoluteContentSize.Y + 20) end
        end
        tabData.Page.CanvasSize = UDim2.new(0, 0, 0, totalY)
    end)
    
    return Container
end

-- ═══════════════════════════════════════════════════
-- TOGGLE (Small circle toggle, Neverlose style)
-- ═══════════════════════════════════════════════════
function Framework:CreateToggle(parentSection, labelText, default)
    local Row = Instance.new("TextButton")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundColor3 = Theme.ContentBg
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.Text = ""
    Row.ZIndex = 5
    Row.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(1, -40, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Row
    
    -- Circle toggle
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
    ToggleCircle.AnchorPoint = Vector2.new(1, 0.5)
    ToggleCircle.Position = UDim2.new(1, -4, 0.5, 0)
    ToggleCircle.BackgroundColor3 = default and Theme.ToggleOn or Theme.ToggleOff
    ToggleCircle.ZIndex = 6
    ToggleCircle.Parent = Row
    applyCorner(ToggleCircle, UDim.new(1, 0))
    
    -- Inner dot (filled when on)
    local InnerDot = Instance.new("Frame")
    InnerDot.Size = UDim2.new(0, 6, 0, 6)
    InnerDot.AnchorPoint = Vector2.new(0.5, 0.5)
    InnerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
    InnerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InnerDot.BackgroundTransparency = default and 0 or 1
    InnerDot.ZIndex = 7
    InnerDot.Parent = ToggleCircle
    applyCorner(InnerDot, UDim.new(1, 0))
    
    local toggled = default or false
    
    Row.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(ToggleCircle, TweenFast, {BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff}):Play()
        TweenService:Create(InnerDot, TweenFast, {BackgroundTransparency = toggled and 0 or 1}):Play()
    end)
    
    Row.MouseEnter:Connect(function() TweenService:Create(Row, TweenFast, {BackgroundTransparency = 0.5}):Play() end)
    Row.MouseLeave:Connect(function() TweenService:Create(Row, TweenFast, {BackgroundTransparency = 1}):Play() end)
    
    return Row
end

-- ═══════════════════════════════════════════════════
-- SLIDER (Thin inline slider)
-- ═══════════════════════════════════════════════════
function Framework:CreateSlider(parentSection, labelText, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 38)
    Container.BackgroundTransparency = 1
    Container.ZIndex = 5
    Container.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(0.6, 0, 0, 18), UDim2.new(0, 4, 0, 2))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Container
    
    local ValueLabel = createLabel(tostring(default), UDim2.new(0, 40, 0, 18), UDim2.new(1, -44, 0, 2), Enum.TextXAlignment.Right, false)
    ValueLabel.TextSize = 11
    ValueLabel.TextColor3 = Theme.Accent
    ValueLabel.ZIndex = 6
    ValueLabel.Parent = Container
    
    -- Slider track
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -8, 0, 4)
    Track.Position = UDim2.new(0, 4, 0, 24)
    Track.BackgroundColor3 = Theme.SliderBg
    Track.BorderSizePixel = 0
    Track.ZIndex = 6
    Track.Parent = Container
    applyCorner(Track, UDim.new(0, 2))
    
    -- Fill
    local pct = (default - min) / math.max(max - min, 1)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.SliderFill
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 7
    Fill.Parent = Track
    applyCorner(Fill, UDim.new(0, 2))
    
    -- Knob
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 10, 0, 10)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new(pct, 0, 0.5, 0)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.ZIndex = 8
    Knob.Parent = Track
    applyCorner(Knob, UDim.new(1, 0))
    
    local sliding = false
    local function updateSlider(inputPos)
        local trackPos = Track.AbsolutePosition.X
        local trackSize = Track.AbsoluteSize.X
        local rel = math.clamp((inputPos.X - trackPos) / trackSize, 0, 1)
        local value = math.floor(min + (max - min) * rel)
        ValueLabel.Text = tostring(value) .. (max > 100 and "" or "%")
        Fill.Size = UDim2.new(rel, 0, 1, 0)
        Knob.Position = UDim2.new(rel, 0, 0.5, 0)
    end
    
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            sliding = true
            updateSlider(input.Position)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
    end)
    
    return Container
end

-- ═══════════════════════════════════════════════════
-- BUTTON
-- ═══════════════════════════════════════════════════
function Framework:CreateButton(parentSection, labelText, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 28)
    Btn.BackgroundColor3 = Theme.ElementBg
    Btn.BackgroundTransparency = 0.5
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.ZIndex = 5
    Btn.Parent = parentSection
    applyCorner(Btn, Theme.SmallCorner)
    
    local Label = createLabel(labelText, UDim2.new(1, -12, 1, 0), UDim2.new(0, 6, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Btn
    
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenFast, {BackgroundTransparency = 0}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenFast, {BackgroundTransparency = 0.5}):Play() end)
    Btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    return Btn
end

-- ═══════════════════════════════════════════════════
-- DROPDOWN (Inline, Neverlose-style)
-- ═══════════════════════════════════════════════════
function Framework:CreateDropdown(parentSection, labelText, options, default, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 28)
    Container.BackgroundTransparency = 1
    Container.ClipsDescendants = false
    Container.ZIndex = 5
    Container.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(0.45, 0, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Container
    
    -- Dropdown button
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0.52, 0, 0, 22)
    DropBtn.AnchorPoint = Vector2.new(1, 0.5)
    DropBtn.Position = UDim2.new(1, -4, 0.5, 0)
    DropBtn.BackgroundColor3 = Theme.ElementBg
    DropBtn.BorderSizePixel = 0
    DropBtn.Text = ""
    DropBtn.ZIndex = 6
    DropBtn.Parent = Container
    applyCorner(DropBtn, Theme.SmallCorner)
    applyStroke(DropBtn, Theme.Border, 0.5)
    
    local SelectedLabel = createLabel(default or options[1], UDim2.new(1, -22, 1, 0), UDim2.new(0, 8, 0, 0))
    SelectedLabel.TextSize = 11
    SelectedLabel.TextColor3 = Theme.TextSecondary
    SelectedLabel.ZIndex = 7
    SelectedLabel.Parent = DropBtn
    
    local Arrow = createLabel("▾", UDim2.new(0, 14, 1, 0), UDim2.new(1, -18, 0, 0), Enum.TextXAlignment.Center, false)
    Arrow.TextSize = 11
    Arrow.TextColor3 = Theme.TextMuted
    Arrow.ZIndex = 7
    Arrow.Parent = DropBtn
    
    -- Options list
    local OptionsList = Instance.new("Frame")
    OptionsList.Size = UDim2.new(0.52, 0, 0, 0)
    OptionsList.AnchorPoint = Vector2.new(1, 0)
    OptionsList.Position = UDim2.new(1, -4, 1, 2)
    OptionsList.BackgroundColor3 = Theme.ElementBg
    OptionsList.BorderSizePixel = 0
    OptionsList.Visible = false
    OptionsList.ClipsDescendants = true
    OptionsList.ZIndex = 50
    OptionsList.Parent = Container
    applyCorner(OptionsList, Theme.SmallCorner)
    applyStroke(OptionsList, Theme.Border, 0.3)
    
    local OptLayout = Instance.new("UIListLayout")
    OptLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptLayout.Parent = OptionsList
    
    local isOpen = false
    local selected = default or options[1]
    
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 24)
        OptBtn.BackgroundColor3 = Theme.ElementHover
        OptBtn.BackgroundTransparency = 1
        OptBtn.BorderSizePixel = 0
        OptBtn.Text = ""
        OptBtn.ZIndex = 51
        OptBtn.Parent = OptionsList
        
        local OptLabel = createLabel(opt, UDim2.new(1, -12, 1, 0), UDim2.new(0, 8, 0, 0))
        OptLabel.TextSize = 11
        OptLabel.TextColor3 = (opt == selected) and Theme.Accent or Theme.TextSecondary
        OptLabel.ZIndex = 52
        OptLabel.Parent = OptBtn
        
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenFast, {BackgroundTransparency = 0.3}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenFast, {BackgroundTransparency = 1}):Play() end)
        
        OptBtn.MouseButton1Click:Connect(function()
            selected = opt
            SelectedLabel.Text = opt
            isOpen = false
            OptionsList.Visible = false
            -- Update colors
            for _, child in ipairs(OptionsList:GetChildren()) do
                if child:IsA("TextButton") then
                    local lbl = child:FindFirstChildOfClass("TextLabel")
                    if lbl then lbl.TextColor3 = (lbl.Text == opt) and Theme.Accent or Theme.TextSecondary end
                end
            end
            if callback then callback(opt) end
        end)
    end
    
    OptionsList.Size = UDim2.new(0.52, 0, 0, #options * 24)
    
    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        OptionsList.Visible = isOpen
    end)
    
    return Container
end

-- ═══════════════════════════════════════════════════
-- MULTI DROPDOWN
-- ═══════════════════════════════════════════════════
function Framework:CreateMultiDropdown(parentSection, labelText, options, defaults, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 28)
    Container.BackgroundTransparency = 1
    Container.ClipsDescendants = false
    Container.ZIndex = 5
    Container.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(0.45, 0, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Container
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(0.52, 0, 0, 22)
    DropBtn.AnchorPoint = Vector2.new(1, 0.5)
    DropBtn.Position = UDim2.new(1, -4, 0.5, 0)
    DropBtn.BackgroundColor3 = Theme.ElementBg
    DropBtn.BorderSizePixel = 0
    DropBtn.Text = ""
    DropBtn.ZIndex = 6
    DropBtn.Parent = Container
    applyCorner(DropBtn, Theme.SmallCorner)
    applyStroke(DropBtn, Theme.Border, 0.5)
    
    local selectedMap = {}
    for _, d in ipairs(defaults or {}) do selectedMap[d] = true end
    
    local function getDisplayText()
        local sel = {}
        for _, o in ipairs(options) do
            if selectedMap[o] then table.insert(sel, o) end
        end
        if #sel == 0 then return "None" end
        return table.concat(sel, ", ")
    end
    
    local SelectedLabel = createLabel(getDisplayText(), UDim2.new(1, -22, 1, 0), UDim2.new(0, 8, 0, 0))
    SelectedLabel.TextSize = 11
    SelectedLabel.TextColor3 = Theme.TextSecondary
    SelectedLabel.ZIndex = 7
    SelectedLabel.Parent = DropBtn
    
    local Arrow = createLabel("▾", UDim2.new(0, 14, 1, 0), UDim2.new(1, -18, 0, 0), Enum.TextXAlignment.Center, false)
    Arrow.TextSize = 11
    Arrow.TextColor3 = Theme.TextMuted
    Arrow.ZIndex = 7
    Arrow.Parent = DropBtn
    
    local OptionsList = Instance.new("Frame")
    OptionsList.Size = UDim2.new(0.52, 0, 0, #options * 24)
    OptionsList.AnchorPoint = Vector2.new(1, 0)
    OptionsList.Position = UDim2.new(1, -4, 1, 2)
    OptionsList.BackgroundColor3 = Theme.ElementBg
    OptionsList.BorderSizePixel = 0
    OptionsList.Visible = false
    OptionsList.ClipsDescendants = true
    OptionsList.ZIndex = 50
    OptionsList.Parent = Container
    applyCorner(OptionsList, Theme.SmallCorner)
    applyStroke(OptionsList, Theme.Border, 0.3)
    
    local OptLayout = Instance.new("UIListLayout")
    OptLayout.SortOrder = Enum.SortOrder.LayoutOrder
    OptLayout.Parent = OptionsList
    
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(1, 0, 0, 24)
        OptBtn.BackgroundTransparency = 1
        OptBtn.BorderSizePixel = 0
        OptBtn.Text = ""
        OptBtn.ZIndex = 51
        OptBtn.Parent = OptionsList
        
        local Check = Instance.new("Frame")
        Check.Size = UDim2.new(0, 10, 0, 10)
        Check.Position = UDim2.new(0, 8, 0.5, -5)
        Check.BackgroundColor3 = selectedMap[opt] and Theme.Accent or Theme.ToggleOff
        Check.ZIndex = 52
        Check.Parent = OptBtn
        applyCorner(Check, UDim.new(0, 2))
        
        local OptLabel = createLabel(opt, UDim2.new(1, -30, 1, 0), UDim2.new(0, 24, 0, 0))
        OptLabel.TextSize = 11
        OptLabel.TextColor3 = selectedMap[opt] and Theme.TextPrimary or Theme.TextSecondary
        OptLabel.ZIndex = 52
        OptLabel.Parent = OptBtn
        
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenFast, {BackgroundTransparency = 0.3}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenFast, {BackgroundTransparency = 1}):Play() end)
        
        OptBtn.MouseButton1Click:Connect(function()
            selectedMap[opt] = not selectedMap[opt]
            TweenService:Create(Check, TweenFast, {BackgroundColor3 = selectedMap[opt] and Theme.Accent or Theme.ToggleOff}):Play()
            OptLabel.TextColor3 = selectedMap[opt] and Theme.TextPrimary or Theme.TextSecondary
            SelectedLabel.Text = getDisplayText()
            local sel = {}
            for _, o in ipairs(options) do if selectedMap[o] then table.insert(sel, o) end end
            if callback then callback(sel) end
        end)
    end
    
    local isOpen = false
    DropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        OptionsList.Visible = isOpen
    end)
    
    return Container
end

-- ═══════════════════════════════════════════════════
-- KEYBIND
-- ═══════════════════════════════════════════════════
function Framework:CreateKeybind(parentSection, labelText, defaultKey, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 5
    Row.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(0.6, 0, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Row
    
    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(0, 60, 0, 20)
    KeyBtn.AnchorPoint = Vector2.new(1, 0.5)
    KeyBtn.Position = UDim2.new(1, -4, 0.5, 0)
    KeyBtn.BackgroundColor3 = Theme.ElementBg
    KeyBtn.BorderSizePixel = 0
    KeyBtn.Text = defaultKey and defaultKey.Name or "None"
    KeyBtn.Font = Theme.Font
    KeyBtn.TextColor3 = Theme.TextSecondary
    KeyBtn.TextSize = 10
    KeyBtn.ZIndex = 6
    KeyBtn.Parent = Row
    applyCorner(KeyBtn, Theme.SmallCorner)
    applyStroke(KeyBtn, Theme.Border, 0.5)
    
    local listening = false
    local currentKey = defaultKey
    
    KeyBtn.MouseButton1Click:Connect(function()
        listening = true
        KeyBtn.Text = "..."
        KeyBtn.TextColor3 = Theme.Accent
    end)
    
    UserInputService.InputBegan:Connect(function(input, gp)
        if not listening then
            if currentKey and input.KeyCode == currentKey then
                if callback then callback(currentKey.Name, true) end
            end
            return
        end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentKey = input.KeyCode
            KeyBtn.Text = input.KeyCode.Name
            KeyBtn.TextColor3 = Theme.TextSecondary
            listening = false
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            KeyBtn.Text = "MB2"
            KeyBtn.TextColor3 = Theme.TextSecondary
            currentKey = nil
            listening = false
        end
    end)
    
    return Row
end

-- ═══════════════════════════════════════════════════
-- TEXTBOX
-- ═══════════════════════════════════════════════════
function Framework:CreateTextBox(parentSection, labelText, placeholder, isSecret, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 28)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 5
    Row.Parent = parentSection
    
    local Label = createLabel(labelText, UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 6
    Label.Parent = Row
    
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0.55, 0, 0, 20)
    Input.AnchorPoint = Vector2.new(1, 0.5)
    Input.Position = UDim2.new(1, -4, 0.5, 0)
    Input.BackgroundColor3 = Theme.ElementBg
    Input.BorderSizePixel = 0
    Input.Font = Theme.Font
    Input.Text = ""
    Input.PlaceholderText = placeholder or ""
    Input.TextColor3 = Theme.TextPrimary
    Input.PlaceholderColor3 = Theme.TextMuted
    Input.TextSize = 11
    Input.ClearTextOnFocus = false
    Input.ZIndex = 6
    Input.Parent = Row
    applyCorner(Input, Theme.SmallCorner)
    applyStroke(Input, Theme.Border, 0.5)
    
    local Pad = Instance.new("UIPadding")
    Pad.PaddingLeft = UDim.new(0, 6)
    Pad.PaddingRight = UDim.new(0, 6)
    Pad.Parent = Input
    
    Input.FocusLost:Connect(function(enter)
        if enter and callback then callback(Input.Text) end
    end)
    
    return Row
end

-- ═══════════════════════════════════════════════════
-- LABEL
-- ═══════════════════════════════════════════════════
function Framework:CreateLabel(parentSection, text)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 22)
    Row.BackgroundTransparency = 1
    Row.ZIndex = 5
    Row.Parent = parentSection
    
    local L = createLabel(text, UDim2.new(1, -8, 1, 0), UDim2.new(0, 4, 0, 0))
    L.TextSize = 11
    L.TextColor3 = Theme.TextSecondary
    L.ZIndex = 6
    L.Parent = Row
    
    return Row
end

-- ═══════════════════════════════════════════════════
-- SEPARATOR
-- ═══════════════════════════════════════════════════
function Framework:CreateSeparator(parentSection)
    local Sep = Instance.new("Frame")
    Sep.Size = UDim2.new(1, -8, 0, 1)
    Sep.Position = UDim2.new(0, 4, 0, 0)
    Sep.BackgroundColor3 = Theme.Divider
    Sep.BorderSizePixel = 0
    Sep.ZIndex = 4
    Sep.Parent = parentSection
    
    -- Add some vertical spacing
    local Spacer = Instance.new("Frame")
    Spacer.Size = UDim2.new(1, 0, 0, 6)
    Spacer.BackgroundTransparency = 1
    Spacer.Parent = parentSection
    
    return Sep
end

-- ═══════════════════════════════════════════════════
-- COLOR PICKER (HSV Wheel, Neverlose compact)
-- ═══════════════════════════════════════════════════
function Framework:CreateColorPicker(parentSection, labelText, defaultColor, callback)
    local ColorContainer = Instance.new("Frame")
    ColorContainer.Size = UDim2.new(1, 0, 0, 28)
    ColorContainer.BackgroundTransparency = 1
    ColorContainer.ClipsDescendants = true
    ColorContainer.ZIndex = 5
    ColorContainer.Parent = parentSection
    
    -- Main row
    local MainRow = Instance.new("TextButton")
    MainRow.Size = UDim2.new(1, 0, 0, 28)
    MainRow.BackgroundTransparency = 1
    MainRow.BorderSizePixel = 0
    MainRow.Text = ""
    MainRow.ZIndex = 6
    MainRow.Parent = ColorContainer
    
    local Label = createLabel(labelText, UDim2.new(1, -40, 1, 0), UDim2.new(0, 4, 0, 0))
    Label.TextSize = 12
    Label.ZIndex = 7
    Label.Parent = MainRow
    
    -- Color preview swatch
    local Swatch = Instance.new("Frame")
    Swatch.Size = UDim2.new(0, 22, 0, 14)
    Swatch.AnchorPoint = Vector2.new(1, 0.5)
    Swatch.Position = UDim2.new(1, -4, 0.5, 0)
    Swatch.BackgroundColor3 = defaultColor
    Swatch.ZIndex = 7
    Swatch.Parent = MainRow
    applyCorner(Swatch, UDim.new(0, 3))
    applyStroke(Swatch, Theme.Border, 0.3)
    
    -- Expanded panel
    local Panel = Instance.new("Frame")
    Panel.Size = UDim2.new(1, -4, 0, 150)
    Panel.Position = UDim2.new(0, 2, 0, 32)
    Panel.BackgroundColor3 = Theme.ElementBg
    Panel.ZIndex = 6
    Panel.Parent = ColorContainer
    applyCorner(Panel, Theme.SmallCorner)
    
    -- HSV Color Wheel
    local WheelSize = 110
    local WheelImg = Instance.new("ImageLabel")
    WheelImg.Size = UDim2.new(0, WheelSize, 0, WheelSize)
    WheelImg.Position = UDim2.new(0, 15, 0, 20)
    WheelImg.BackgroundTransparency = 1
    WheelImg.Image = "rbxassetid://6020110098"
    WheelImg.ZIndex = 7
    WheelImg.Parent = Panel
    
    local WheelCursor = Instance.new("Frame")
    WheelCursor.Size = UDim2.new(0, 8, 0, 8)
    WheelCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    WheelCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
    WheelCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WheelCursor.ZIndex = 9
    WheelCursor.Parent = WheelImg
    applyCorner(WheelCursor, UDim.new(1, 0))
    applyStroke(WheelCursor, Color3.fromRGB(0, 0, 0), 0)
    
    -- Value slider
    local ValSlider = Instance.new("TextButton")
    ValSlider.Size = UDim2.new(0, 14, 0, WheelSize)
    ValSlider.Position = UDim2.new(0, WheelSize + 35, 0, 20)
    ValSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValSlider.BorderSizePixel = 0
    ValSlider.Text = ""
    ValSlider.ZIndex = 7
    ValSlider.Parent = Panel
    applyCorner(ValSlider, UDim.new(0, 4))
    
    local ValGrad = Instance.new("UIGradient")
    ValGrad.Rotation = 90
    ValGrad.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
    ValGrad.Parent = ValSlider
    
    local ValKnob = Instance.new("Frame")
    ValKnob.Size = UDim2.new(1, 4, 0, 4)
    ValKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    ValKnob.Position = UDim2.new(0.5, 0, 0, 0)
    ValKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ValKnob.ZIndex = 8
    ValKnob.Parent = ValSlider
    applyCorner(ValKnob, UDim.new(0, 2))
    applyStroke(ValKnob, Color3.fromRGB(0, 0, 0), 0)
    
    -- Color preview in panel
    local Preview = Instance.new("Frame")
    Preview.Size = UDim2.new(0, 50, 0, 20)
    Preview.Position = UDim2.new(0, WheelSize + 60, 0, 20)
    Preview.BackgroundColor3 = defaultColor
    Preview.ZIndex = 7
    Preview.Parent = Panel
    applyCorner(Preview, Theme.SmallCorner)
    applyStroke(Preview, Theme.Border, 0.3)
    
    -- Hex label
    local function colorToHex(c)
        return string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
    end
    
    local HexLabel = createLabel(colorToHex(defaultColor), UDim2.new(0, 60, 0, 14), UDim2.new(0, WheelSize + 60, 0, 46))
    HexLabel.TextSize = 10
    HexLabel.TextColor3 = Theme.TextSecondary
    HexLabel.ZIndex = 7
    HexLabel.Parent = Panel
    
    -- HSV state
    local h, s, v = Color3.toHSV(defaultColor)
    local wheelDragging, valDragging = false, false
    local centerX, centerY = WheelSize / 2, WheelSize / 2
    local radius = WheelSize / 2
    
    local function updateColor()
        local c = Color3.fromHSV(h, s, v)
        Swatch.BackgroundColor3 = c
        Preview.BackgroundColor3 = c
        HexLabel.Text = colorToHex(c)
        if callback then callback(c) end
    end
    
    local function updateWheelInput(pos)
        local absPos = WheelImg.AbsolutePosition
        local lx = pos.X - absPos.X - centerX
        local ly = pos.Y - absPos.Y - centerY
        local dist = math.sqrt(lx * lx + ly * ly)
        if dist > radius then
            lx = lx / dist * radius
            ly = ly / dist * radius
            dist = radius
        end
        h = (math.atan2(ly, lx) / (2 * math.pi) + 0.5) % 1
        s = math.clamp(dist / radius, 0, 1)
        WheelCursor.Position = UDim2.new(0.5, lx, 0.5, ly)
        updateColor()
    end
    
    local function updateValInput(pos)
        local absPos = ValSlider.AbsolutePosition
        local absSize = ValSlider.AbsoluteSize
        local rel = math.clamp((pos.Y - absPos.Y) / absSize.Y, 0, 1)
        v = 1 - rel
        ValKnob.Position = UDim2.new(0.5, 0, rel, 0)
        updateColor()
    end
    
    WheelImg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            wheelDragging = true
            updateWheelInput(input.Position)
        end
    end)
    ValSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            valDragging = true
            updateValInput(input.Position)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if wheelDragging then updateWheelInput(input.Position) end
            if valDragging then updateValInput(input.Position) end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            wheelDragging = false
            valDragging = false
        end
    end)
    
    -- Toggle expand
    local isOpen = false
    MainRow.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        TweenService:Create(ColorContainer, TweenSmooth, {
            Size = isOpen and UDim2.new(1, 0, 0, 190) or UDim2.new(1, 0, 0, 28)
        }):Play()
    end)
    
    MainRow.MouseEnter:Connect(function() TweenService:Create(MainRow, TweenFast, {BackgroundTransparency = 0.5}):Play() end)
    MainRow.MouseLeave:Connect(function() TweenService:Create(MainRow, TweenFast, {BackgroundTransparency = 1}):Play() end)
    
    return ColorContainer
end

-- ═══════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════
function Framework:Notify(screenGui, title, message, duration)
    duration = duration or 4
    
    local Holder = screenGui:FindFirstChild("NotifHolder")
    if not Holder then
        Holder = Instance.new("Frame")
        Holder.Name = "NotifHolder"
        Holder.Size = UDim2.new(0, 260, 1, -20)
        Holder.AnchorPoint = Vector2.new(1, 1)
        Holder.Position = UDim2.new(1, -12, 1, -10)
        Holder.BackgroundTransparency = 1
        Holder.ZIndex = 100
        Holder.Parent = screenGui
        
        local L = Instance.new("UIListLayout")
        L.SortOrder = Enum.SortOrder.LayoutOrder
        L.VerticalAlignment = Enum.VerticalAlignment.Bottom
        L.Padding = UDim.new(0, 6)
        L.Parent = Holder
    end
    
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(1, 0, 0, 52)
    Notif.BackgroundColor3 = Theme.HeaderBg
    Notif.ZIndex = 101
    Notif.ClipsDescendants = true
    Notif.Parent = Holder
    applyCorner(Notif, Theme.SmallCorner)
    applyStroke(Notif, Theme.Border, 0.3)
    
    -- Accent top line
    local AccLine = Instance.new("Frame")
    AccLine.Size = UDim2.new(1, 0, 0, 2)
    AccLine.BackgroundColor3 = Theme.Accent
    AccLine.BorderSizePixel = 0
    AccLine.ZIndex = 102
    AccLine.Parent = Notif
    
    local NTitle = createLabel(title or "Info", UDim2.new(1, -16, 0, 16), UDim2.new(0, 10, 0, 6), Enum.TextXAlignment.Left, true)
    NTitle.TextSize = 11
    NTitle.ZIndex = 102
    NTitle.Parent = Notif
    
    local NMsg = createLabel(message or "", UDim2.new(1, -16, 0, 20), UDim2.new(0, 10, 0, 22), Enum.TextXAlignment.Left, false)
    NMsg.TextSize = 10
    NMsg.TextColor3 = Theme.TextSecondary
    NMsg.TextWrapped = true
    NMsg.ZIndex = 102
    NMsg.Parent = Notif
    
    local Progress = Instance.new("Frame")
    Progress.Size = UDim2.new(1, 0, 0, 2)
    Progress.Position = UDim2.new(0, 0, 1, -2)
    Progress.BackgroundColor3 = Theme.Accent
    Progress.BorderSizePixel = 0
    Progress.ZIndex = 102
    Progress.Parent = Notif
    
    -- Slide in
    Notif.Position = UDim2.new(1, 20, 0, 0)
    TweenService:Create(Notif, TweenSmooth, {Position = UDim2.new(0, 0, 0, 0)}):Play()
    TweenService:Create(Progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    
    task.delay(duration, function()
        TweenService:Create(Notif, TweenSmooth, {Position = UDim2.new(1, 20, 0, 0)}):Play()
        task.delay(0.3, function() Notif:Destroy() end)
    end)
    
    return Notif
end

-- ═══════════════════════════════════════════════════
-- TOOLTIP
-- ═══════════════════════════════════════════════════
function Framework:AddTooltip(guiElement, tooltipText)
    local Tip = Instance.new("Frame")
    local w = #tooltipText * 6 + 16
    Tip.Size = UDim2.new(0, w, 0, 22)
    Tip.AnchorPoint = Vector2.new(0.5, 1)
    Tip.Position = UDim2.new(0.5, 0, 0, -3)
    Tip.BackgroundColor3 = Theme.HeaderBg
    Tip.Visible = false
    Tip.ZIndex = 200
    Tip.Parent = guiElement
    applyCorner(Tip, UDim.new(0, 3))
    applyStroke(Tip, Theme.Border, 0.3)
    
    local TipLabel = createLabel(tooltipText, UDim2.new(1, -8, 1, 0), UDim2.new(0, 4, 0, 0))
    TipLabel.TextSize = 10
    TipLabel.TextColor3 = Theme.TextSecondary
    TipLabel.ZIndex = 201
    TipLabel.Parent = Tip
    
    guiElement.MouseEnter:Connect(function() Tip.Visible = true end)
    guiElement.MouseLeave:Connect(function() Tip.Visible = false end)
    
    return Tip
end

-- ═══════════════════════════════════════════════════
-- DIALOG
-- ═══════════════════════════════════════════════════
function Framework:CreateDialog(screenGui, title, message, onConfirm, onCancel)
    local Overlay = Instance.new("TextButton")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.Text = ""
    Overlay.ZIndex = 150
    Overlay.Parent = screenGui
    
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 300, 0, 140)
    Box.AnchorPoint = Vector2.new(0.5, 0.5)
    Box.Position = UDim2.new(0.5, 0, 0.5, 0)
    Box.BackgroundColor3 = Theme.Background
    Box.ZIndex = 151
    Box.Parent = Overlay
    applyCorner(Box, UDim.new(0, 6))
    applyStroke(Box)
    
    local AccLine = Instance.new("Frame")
    AccLine.Size = UDim2.new(1, 0, 0, 2)
    AccLine.BackgroundColor3 = Theme.Accent
    AccLine.BorderSizePixel = 0
    AccLine.ZIndex = 152
    AccLine.Parent = Box
    
    local DTitle = createLabel(title or "Confirm", UDim2.new(1, -24, 0, 20), UDim2.new(0, 12, 0, 12), Enum.TextXAlignment.Left, true)
    DTitle.TextSize = 14
    DTitle.ZIndex = 152
    DTitle.Parent = Box
    
    local DMsg = createLabel(message or "", UDim2.new(1, -24, 0, 30), UDim2.new(0, 12, 0, 36))
    DMsg.TextSize = 12
    DMsg.TextColor3 = Theme.TextSecondary
    DMsg.TextWrapped = true
    DMsg.ZIndex = 152
    DMsg.Parent = Box
    
    local YesBtn = Instance.new("TextButton")
    YesBtn.Size = UDim2.new(0.44, 0, 0, 30)
    YesBtn.Position = UDim2.new(0.04, 0, 1, -42)
    YesBtn.BackgroundColor3 = Theme.Accent
    YesBtn.Text = "Evet"
    YesBtn.Font = Theme.BoldFont
    YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    YesBtn.TextSize = 12
    YesBtn.ZIndex = 152
    YesBtn.Parent = Box
    applyCorner(YesBtn, Theme.SmallCorner)
    
    local NoBtn = Instance.new("TextButton")
    NoBtn.Size = UDim2.new(0.44, 0, 0, 30)
    NoBtn.Position = UDim2.new(0.52, 0, 1, -42)
    NoBtn.BackgroundColor3 = Theme.ElementBg
    NoBtn.Text = "Hayir"
    NoBtn.Font = Theme.BoldFont
    NoBtn.TextColor3 = Theme.TextPrimary
    NoBtn.TextSize = 12
    NoBtn.ZIndex = 152
    NoBtn.Parent = Box
    applyCorner(NoBtn, Theme.SmallCorner)
    applyStroke(NoBtn, Theme.Border, 0.3)
    
    YesBtn.MouseButton1Click:Connect(function() if onConfirm then onConfirm() end; Overlay:Destroy() end)
    NoBtn.MouseButton1Click:Connect(function() if onCancel then onCancel() end; Overlay:Destroy() end)
    Overlay.MouseButton1Click:Connect(function() Overlay:Destroy() end)
    
    return Overlay
end

-- ═══════════════════════════════════════════════════
-- WATERMARK
-- ═══════════════════════════════════════════════════
function Framework:CreateWatermark(screenGui, hubName)
    local Wm = Instance.new("Frame")
    Wm.Size = UDim2.new(0, 200, 0, 22)
    Wm.Position = UDim2.new(0, 12, 0, 8)
    Wm.BackgroundColor3 = Theme.HeaderBg
    Wm.BackgroundTransparency = 0.1
    Wm.ZIndex = 90
    Wm.Parent = screenGui
    applyCorner(Wm, UDim.new(0, 3))
    applyStroke(Wm, Theme.Border, 0.5)
    
    local WmLabel = createLabel(hubName or "Hub", UDim2.new(1, -8, 1, 0), UDim2.new(0, 6, 0, 0), Enum.TextXAlignment.Left, true)
    WmLabel.TextSize = 10
    WmLabel.ZIndex = 91
    WmLabel.Parent = Wm
    
    local FpsLabel = createLabel("0 FPS", UDim2.new(0, 50, 1, 0), UDim2.new(1, -56, 0, 0), Enum.TextXAlignment.Right, false)
    FpsLabel.TextSize = 10
    FpsLabel.TextColor3 = Theme.Accent
    FpsLabel.ZIndex = 91
    FpsLabel.Parent = Wm
    
    local fc, lt = 0, tick()
    RunService.RenderStepped:Connect(function()
        fc = fc + 1
        local now = tick()
        if now - lt >= 1 then
            FpsLabel.Text = tostring(fc) .. " FPS"
            fc = 0
            lt = now
        end
    end)
    
    return Wm
end

-- ═══════════════════════════════════════════════════
-- CONFIG SAVE / LOAD
-- ═══════════════════════════════════════════════════
function Framework:SaveConfig(windowObj, configName)
    local data = HttpService:JSONEncode(windowObj._configValues or {})
    local ok, err = pcall(function() writefile(configName .. ".json", data) end)
    return ok, err
end

function Framework:LoadConfig(windowObj, configName)
    local ok, data = pcall(function() return readfile(configName .. ".json") end)
    if ok and data then
        local decoded = HttpService:JSONDecode(data)
        windowObj._configValues = decoded
        return true, decoded
    end
    return false, nil
end

-- ═══════════════════════════════════════════════════
-- KEY SYSTEM (Optional)
-- ═══════════════════════════════════════════════════
function Framework:CreateKeySystem(screenGui, validKeys, onSuccess, options)
    options = options or {}
    local title = options.Title or "Key System"
    local subtitle = options.Subtitle or "Enter a valid key to continue."
    local maxAttempts = options.MaxAttempts or 5
    local attempts = 0
    
    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.3
    Overlay.ZIndex = 200
    Overlay.Parent = screenGui
    
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 340, 0, 185)
    Box.AnchorPoint = Vector2.new(0.5, 0.5)
    Box.Position = UDim2.new(0.5, 0, 0.5, 0)
    Box.BackgroundColor3 = Theme.Background
    Box.ZIndex = 201
    Box.Parent = Overlay
    applyCorner(Box, UDim.new(0, 6))
    applyStroke(Box)
    
    local AccLine = Instance.new("Frame")
    AccLine.Size = UDim2.new(1, 0, 0, 2)
    AccLine.BackgroundColor3 = Theme.Accent
    AccLine.BorderSizePixel = 0
    AccLine.ZIndex = 202
    AccLine.Parent = Box
    
    local KTitle = createLabel(title, UDim2.new(1, -24, 0, 24), UDim2.new(0, 12, 0, 12), Enum.TextXAlignment.Left, true)
    KTitle.TextSize = 16
    KTitle.ZIndex = 202
    KTitle.Parent = Box
    
    local KSub = createLabel(subtitle, UDim2.new(1, -24, 0, 16), UDim2.new(0, 12, 0, 38))
    KSub.TextSize = 11
    KSub.TextColor3 = Theme.TextSecondary
    KSub.ZIndex = 202
    KSub.Parent = Box
    
    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -24, 0, 30)
    KeyInput.Position = UDim2.new(0, 12, 0, 65)
    KeyInput.BackgroundColor3 = Theme.ElementBg
    KeyInput.Font = Theme.Font
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "Key..."
    KeyInput.TextColor3 = Theme.TextPrimary
    KeyInput.PlaceholderColor3 = Theme.TextMuted
    KeyInput.TextSize = 12
    KeyInput.ClearTextOnFocus = true
    KeyInput.ZIndex = 202
    KeyInput.Parent = Box
    applyCorner(KeyInput, Theme.SmallCorner)
    applyStroke(KeyInput, Theme.Border, 0.5)
    
    local KPad = Instance.new("UIPadding")
    KPad.PaddingLeft = UDim.new(0, 8)
    KPad.Parent = KeyInput
    
    local StatusLbl = createLabel("", UDim2.new(1, -24, 0, 14), UDim2.new(0, 12, 0, 100))
    StatusLbl.TextSize = 10
    StatusLbl.TextColor3 = Color3.fromRGB(200, 60, 60)
    StatusLbl.ZIndex = 202
    StatusLbl.Parent = Box
    
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(1, -24, 0, 30)
    SubmitBtn.Position = UDim2.new(0, 12, 1, -42)
    SubmitBtn.BackgroundColor3 = Theme.Accent
    SubmitBtn.Text = "Verify"
    SubmitBtn.Font = Theme.BoldFont
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.TextSize = 12
    SubmitBtn.ZIndex = 202
    SubmitBtn.Parent = Box
    applyCorner(SubmitBtn, Theme.SmallCorner)
    
    local function tryValidate()
        local entered = KeyInput.Text
        local valid = false
        if type(validKeys) == "table" then
            for _, k in ipairs(validKeys) do if k == entered then valid = true; break end end
        elseif type(validKeys) == "string" then
            valid = (entered == validKeys)
        end
        if valid then
            StatusLbl.TextColor3 = Color3.fromRGB(60, 200, 80)
            StatusLbl.Text = "Valid key! Loading..."
            task.delay(0.8, function() Overlay:Destroy(); if onSuccess then onSuccess() end end)
        else
            attempts = attempts + 1
            StatusLbl.TextColor3 = Color3.fromRGB(200, 60, 60)
            if attempts >= maxAttempts then
                StatusLbl.Text = "Too many failed attempts."
                task.delay(1.5, function() screenGui:Destroy() end)
            else
                StatusLbl.Text = "Invalid key! (" .. attempts .. "/" .. maxAttempts .. ")"
                TweenService:Create(Box, TweenInfo.new(0.04, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 3, true), {Position = UDim2.new(0.5, 4, 0.5, 0)}):Play()
            end
        end
    end
    
    SubmitBtn.MouseButton1Click:Connect(tryValidate)
    KeyInput.FocusLost:Connect(function(enter) if enter then tryValidate() end end)
    
    return Overlay
end

return Framework
