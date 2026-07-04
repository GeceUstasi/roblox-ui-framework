local Framework = {}
Framework.__index = Framework

local Players = game:GetService("Players")

-- Theme & Design Constants (Karpiware Style)
local Theme = {
    WindowBackground = Color3.fromRGB(22, 22, 22),
    SidebarBackground = Color3.fromRGB(15, 15, 15),
    SectionBackground = Color3.fromRGB(28, 28, 28),
    
    ElementHover = Color3.fromRGB(35, 35, 35),
    TabSelected = Color3.fromRGB(35, 35, 35),
    
    AccentColor = Color3.fromRGB(255, 255, 255), -- White accent like the screenshot
    ToggleOn = Color3.fromRGB(255, 255, 255),
    ToggleOff = Color3.fromRGB(45, 45, 45),
    
    TextColor = Color3.fromRGB(240, 240, 240),
    TextSecondaryColor = Color3.fromRGB(130, 130, 130),
    
    BorderColor = Color3.fromRGB(40, 40, 40),
    BorderTransparency = 0,
    
    Font = Enum.Font.SourceSans,
    BoldFont = Enum.Font.SourceSansBold,
    CornerRadius = UDim.new(0, 6)
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

function Framework:CreateWindow(screenGui, titleText, subtitleText)
    -- Main Window Frame
    local Window = Instance.new("Frame")
    Window.Name = "KarpiwareWindow"
    Window.Size = UDim2.new(0, 650, 0, 450)
    Window.Position = UDim2.new(0.5, -325, 0.5, -225)
    Window.BackgroundColor3 = Theme.WindowBackground
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    applyCorner(Window)
    applyStroke(Window)
    
    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 180, 1, 0)
    Sidebar.BackgroundColor3 = Theme.SidebarBackground
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Window
    applyCorner(Sidebar)
    
    -- Fix corner overlap between Sidebar and Window
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 10, 1, 0)
    SidebarFix.Position = UDim2.new(1, -10, 0, 0)
    SidebarFix.BackgroundColor3 = Theme.SidebarBackground
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Parent = Sidebar
    
    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
    SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
    SidebarDivider.BackgroundColor3 = Theme.BorderColor
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.Parent = Sidebar
    
    -- Title Area
    local TitleArea = Instance.new("Frame")
    TitleArea.Size = UDim2.new(1, 0, 0, 60)
    TitleArea.BackgroundTransparency = 1
    TitleArea.Parent = Sidebar
    
    local Title = createTextLabel(titleText or "Hub", UDim2.new(1, -30, 0, 20), UDim2.new(0, 15, 0, 15), Enum.TextXAlignment.Left, true)
    Title.TextSize = 16
    Title.Parent = TitleArea
    
    local Subtitle = createTextLabel(subtitleText or "Interface", UDim2.new(1, -30, 0, 15), UDim2.new(0, 15, 0, 35), Enum.TextXAlignment.Left, false)
    Subtitle.TextSize = 12
    Subtitle.TextColor3 = Theme.TextSecondaryColor
    Subtitle.Parent = TitleArea
    
    -- Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -120)
    TabContainer.Position = UDim2.new(0, 0, 0, 60)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.ScrollBarThickness = 2
    TabContainer.ScrollBarImageColor3 = Theme.TextSecondaryColor
    TabContainer.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
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
    ProfileDivider.Size = UDim2.new(1, 0, 0, 1)
    ProfileDivider.Position = UDim2.new(0, 0, 0, 0)
    ProfileDivider.BackgroundColor3 = Theme.BorderColor
    ProfileDivider.BorderSizePixel = 0
    ProfileDivider.Parent = ProfileContainer
    
    local AvatarIcon = Instance.new("ImageLabel")
    AvatarIcon.Size = UDim2.new(0, 32, 0, 32)
    AvatarIcon.Position = UDim2.new(0, 15, 0.5, -16)
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
    
    local UsernameLabel = createTextLabel(localPlayer and localPlayer.Name or "User", UDim2.new(1, -95, 0, 15), UDim2.new(0, 55, 0.5, -15), Enum.TextXAlignment.Left, true)
    UsernameLabel.TextSize = 13
    UsernameLabel.Parent = ProfileContainer
    
    local SubLabel = createTextLabel("Premium", UDim2.new(1, -95, 0, 15), UDim2.new(0, 55, 0.5, 0), Enum.TextXAlignment.Left, false)
    SubLabel.TextSize = 11
    SubLabel.TextColor3 = Theme.TextSecondaryColor
    SubLabel.Parent = ProfileContainer
    
    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Size = UDim2.new(0, 16, 0, 16)
    SettingsBtn.Position = UDim2.new(1, -30, 0.5, -8)
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Image = "rbxassetid://7059346373"
    SettingsBtn.ImageColor3 = Theme.TextSecondaryColor
    SettingsBtn.Parent = ProfileContainer
    SettingsBtn.MouseEnter:Connect(function() SettingsBtn.ImageColor3 = Theme.TextColor end)
    SettingsBtn.MouseLeave:Connect(function() SettingsBtn.ImageColor3 = Theme.TextSecondaryColor end)
    
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
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Theme.TabSelected
    TabButton.BackgroundTransparency = 1 -- Transparent default
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
    
    local TabLabel = createTextLabel(tabName, UDim2.new(1, -40, 1, 0), UDim2.new(0, 36, 0, 0))
    TabLabel.TextColor3 = Theme.TextSecondaryColor
    TabLabel.Parent = TabButton
    
    -- Tab Content columns
    local TabContent = Instance.new("Frame")
    TabContent.Name = tabName .. "Content"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = windowObj.ContentArea
    
    -- We use two columns for sections
    local LeftColumn = Instance.new("ScrollingFrame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.5, -15, 1, -30)
    LeftColumn.Position = UDim2.new(0, 15, 0, 15)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.BorderSizePixel = 0
    LeftColumn.ScrollBarThickness = 0
    LeftColumn.Parent = TabContent
    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.Padding = UDim.new(0, 10)
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
    RightLayout.Padding = UDim.new(0, 10)
    RightLayout.Parent = RightColumn
    
    local function SelectTab()
        for _, t in pairs(windowObj.Tabs) do
            t.Button.BackgroundTransparency = 1
            t.Icon.ImageColor3 = Theme.TextSecondaryColor
            t.Label.TextColor3 = Theme.TextSecondaryColor
            t.Content.Visible = false
        end
        TabButton.BackgroundTransparency = 0
        TabIcon.ImageColor3 = Theme.AccentColor
        TabLabel.TextColor3 = Theme.TextColor
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
    SectionFrame.Name = "Section_" .. title
    SectionFrame.Size = UDim2.new(1, 0, 0, 50) -- Height will auto-adjust
    SectionFrame.BackgroundColor3 = Theme.SectionBackground
    SectionFrame.Parent = col
    applyCorner(SectionFrame)
    applyStroke(SectionFrame)
    
    local SectionTitle = createTextLabel(title, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 0), Enum.TextXAlignment.Left, true)
    SectionTitle.TextColor3 = Theme.TextSecondaryColor
    SectionTitle.Parent = SectionFrame
    
    local SectionContent = Instance.new("Frame")
    SectionContent.Size = UDim2.new(1, 0, 1, -30)
    SectionContent.Position = UDim2.new(0, 0, 0, 30)
    SectionContent.BackgroundTransparency = 1
    SectionContent.Parent = SectionFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.Parent = SectionContent
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = SectionContent
    
    -- Auto-resize logic
    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SectionContent.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y)
        SectionFrame.Size = UDim2.new(1, 0, 0, ListLayout.AbsoluteContentSize.Y + 40)
        col.CanvasSize = UDim2.new(0, 0, 0, col.UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    return SectionContent
end

function Framework:CreateToggle(parentSection, text, default)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 24)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(1, -40, 1, 0), UDim2.new(0, 0, 0, 0))
    Title.TextSize = 13
    Title.Parent = ToggleFrame
    
    -- iOS Style Switch
    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Text = ""
    SwitchBg.Size = UDim2.new(0, 32, 0, 18)
    SwitchBg.Position = UDim2.new(1, -32, 0.5, -9)
    SwitchBg.BackgroundColor3 = default and Theme.ToggleOn or Theme.ToggleOff
    SwitchBg.Parent = ToggleFrame
    applyCorner(SwitchBg, UDim.new(1, 0))
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = UDim2.new(default and 1 or 0, default and -16 or 2, 0.5, -7)
    Circle.BackgroundColor3 = default and Theme.WindowBackground or Theme.TextSecondaryColor
    Circle.Parent = SwitchBg
    applyCorner(Circle, UDim.new(1, 0))
    
    local toggled = default
    SwitchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        SwitchBg.BackgroundColor3 = toggled and Theme.ToggleOn or Theme.ToggleOff
        Circle.Position = UDim2.new(toggled and 1 or 0, toggled and -16 or 2, 0.5, -7)
        Circle.BackgroundColor3 = toggled and Theme.WindowBackground or Theme.TextSecondaryColor
    end)
    
    return ToggleFrame
end

function Framework:CreateSlider(parentSection, text, min, max, default)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 24)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = parentSection
    
    local Title = createTextLabel(text, UDim2.new(0, 100, 1, 0))
    Title.TextSize = 13
    Title.Parent = SliderFrame
    
    -- Value Box
    local ValueBox = Instance.new("Frame")
    ValueBox.Size = UDim2.new(0, 30, 0, 18)
    ValueBox.Position = UDim2.new(1, -30, 0.5, -9)
    ValueBox.BackgroundColor3 = Theme.WindowBackground
    ValueBox.Parent = SliderFrame
    applyCorner(ValueBox)
    applyStroke(ValueBox)
    
    local ValueLabel = createTextLabel(tostring(default), UDim2.new(1, 0, 1, 0), UDim2.new(0,0,0,0), Enum.TextXAlignment.Center)
    ValueLabel.TextSize = 12
    ValueLabel.Parent = ValueBox
    
    -- Track
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -145, 0, 4)
    Track.Position = UDim2.new(0, 105, 0.5, -2)
    Track.BackgroundColor3 = Theme.ToggleOff
    Track.Parent = SliderFrame
    applyCorner(Track)
    
    local percent = (default - min) / (max - min)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.AccentColor
    Fill.Parent = Track
    applyCorner(Fill)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 10, 0, 10)
    Knob.Position = UDim2.new(1, -5, 0.5, -5)
    Knob.BackgroundColor3 = Theme.AccentColor
    Knob.Parent = Fill
    applyCorner(Knob, UDim.new(1, 0))
    
    return SliderFrame
end

return Framework
