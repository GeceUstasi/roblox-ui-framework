local Framework = {}
Framework.__index = Framework

-- Theme & Design Constants (Glassmorphism & Dark Mode)
local Theme = {
    BackgroundColor = Color3.fromRGB(20, 20, 25),
    BackgroundTransparency = 0.25, -- Glassmorphism transparency
    
    ElementColor = Color3.fromRGB(35, 35, 45),
    ElementTransparency = 0.3,
    
    AccentColor = Color3.fromRGB(80, 140, 255), -- Nice blue accent
    
    TextColor = Color3.fromRGB(245, 245, 245),
    TextSecondaryColor = Color3.fromRGB(180, 180, 180),
    
    BorderColor = Color3.fromRGB(255, 255, 255),
    BorderTransparency = 0.85, -- Subtle white outline for glass effect
    
    Font = Enum.Font.SourceSans,
    CornerRadius = UDim.new(0, 8)
}

-- Utility Functions
local function applyCorner(parent)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = Theme.CornerRadius
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

local function createTextLabel(text, size, position, alignment)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size or UDim2.new(1, 0, 1, 0)
    label.Position = position or UDim2.new(0, 0, 0, 0)
    label.Font = Theme.Font
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
    Window.Size = UDim2.new(0, 450, 0, 350)
    Window.Position = UDim2.new(0.5, -225, 0.5, -175)
    Window.BackgroundColor3 = Theme.BackgroundColor
    Window.BackgroundTransparency = Theme.BackgroundTransparency
    Window.BorderSizePixel = 0
    Window.Parent = screenGui
    
    applyCorner(Window)
    applyStroke(Window)
    
    -- Top Bar (Draggable Area conceptually)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Window
    
    local Title = createTextLabel(titleText or "Window Title", UDim2.new(1, -30, 1, 0), UDim2.new(0, 15, 0, 0))
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = TopBar
    
    -- Divider
    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(1, 0, 0, 1)
    Divider.Position = UDim2.new(0, 0, 1, -1)
    Divider.BackgroundColor3 = Theme.BorderColor
    Divider.BackgroundTransparency = Theme.BorderTransparency
    Divider.BorderSizePixel = 0
    Divider.Parent = TopBar
    
    -- Content Container (where elements will be placed)
    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -20, 1, -50)
    Content.Position = UDim2.new(0, 10, 0, 45)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = Theme.AccentColor
    Content.Parent = Window
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Content
    
    -- Padding for list layout
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 5)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.PaddingBottom = UDim.new(0, 5)
    UIPadding.Parent = Content
    
    -- Return an object that represents this window
    local WindowObj = {}
    WindowObj.Frame = Window
    WindowObj.Container = Content
    
    return WindowObj
end

function Framework:CreateButton(parentWindow, text, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = "ButtonContainer_" .. text
    ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
    ButtonFrame.BackgroundColor3 = Theme.ElementColor
    ButtonFrame.BackgroundTransparency = Theme.ElementTransparency
    ButtonFrame.Parent = parentWindow.Container
    
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
    
    -- Simple Hover Effect
    TextButton.MouseEnter:Connect(function()
        ButtonFrame.BackgroundTransparency = Theme.ElementTransparency - 0.1
    end)
    TextButton.MouseLeave:Connect(function()
        ButtonFrame.BackgroundTransparency = Theme.ElementTransparency
    end)
    
    if callback then
        TextButton.MouseButton1Click:Connect(callback)
    end
    
    return TextButton
end

function Framework:CreateSlider(parentWindow, text, min, max, default)
    min = min or 0
    max = max or 100
    default = default or 50
    
    local SliderContainer = Instance.new("Frame")
    SliderContainer.Name = "SliderContainer_" .. text
    SliderContainer.Size = UDim2.new(1, 0, 0, 50)
    SliderContainer.BackgroundTransparency = 1
    SliderContainer.Parent = parentWindow.Container
    
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
    
    local Fill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.AccentColor
    Fill.Parent = SliderBg
    applyCorner(Fill)
    
    -- Non-functional visually appealing slider knob
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(1, -7, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = Fill
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0) -- Circle
    KnobCorner.Parent = Knob
    
    return SliderContainer
end

function Framework:CreateToggle(parentWindow, text, default)
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Name = "ToggleContainer_" .. text
    ToggleContainer.Size = UDim2.new(1, 0, 0, 35)
    ToggleContainer.BackgroundTransparency = 1
    ToggleContainer.Parent = parentWindow.Container
    
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
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    return ToggleContainer
end

return Framework
