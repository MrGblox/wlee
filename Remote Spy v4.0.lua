-- By Kreatifiti
-- Remote Spy v4.0

if not syn then error("This script requires a supported executor (Synapse/Fluxus/Delta).") end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- [[ PROFESSIONAL ICONS ]] --
local ICONS = {
    LOGO = "rbxassetid://6023426619",
    REMOTE = "rbxassetid://6026568042", 
    EVENT = "rbxassetid://6031075939", -- Professional event icon
    FUNCTION = "rbxassetid://6031075939", -- Professional function icon
    FOLDER = "rbxassetid://6031075939", -- Professional folder icon
    SEARCH = "rbxassetid://6031075939", -- Professional search icon
    SETTINGS = "rbxassetid://6031075939", -- Professional settings icon
    CODE = "rbxassetid://6031075939", -- Professional code icon
    DEBUG = "rbxassetid://6031075939", -- Professional debug icon
    TOOLS = "rbxassetid://6031075939", -- Professional tools icon
    PLAY = "rbxassetid://6031075939", -- Professional play icon
    PAUSE = "rbxassetid://6031075939", -- Professional pause icon
    EXPORT = "rbxassetid://6031075939", -- Professional export icon
    SAVE = "rbxassetid://6031075939", -- Professional save icon
    LOOP = "rbxassetid://6031075939", -- Professional loop icon
    COPY = "rbxassetid://6031075939", -- Professional copy icon
    FAVORITE = "rbxassetid://6031075939", -- Professional favorite icon
    CLOSE = "rbxassetid://6031075939", -- Professional close icon
    MINIMIZE = "rbxassetid://6031075939", -- Professional minimize icon
    MAXIMIZE = "rbxassetid://6031075939", -- Professional maximize icon
    RESIZE = "rbxassetid://6031075939" -- Professional resize icon
}

-- [[ COLOR SCHEME ]] --
local COLORS = {
    PRIMARY = Color3.fromRGB(106, 17, 203), -- Deep purple
    SECONDARY = Color3.fromRGB(80, 80, 180), -- Blue purple
    ACCENT = Color3.fromRGB(150, 150, 255), -- Light blue
    BACKGROUND = Color3.fromRGB(15, 12, 25), -- Deep dark
    CARD = Color3.fromRGB(25, 22, 35), -- Card background
    TEXT = Color3.fromRGB(240, 240, 255), -- Light text
    TEXT_SECONDARY = Color3.fromRGB(180, 180, 200), -- Secondary text
    SUCCESS = Color3.fromRGB(46, 204, 113), -- Green
    WARNING = Color3.fromRGB(241, 196, 15), -- Yellow
    ERROR = Color3.fromRGB(231, 76, 60), -- Red
    INFO = Color3.fromRGB(52, 152, 219) -- Blue
}

-- [[ CONFIGURATION ]] --
local CONFIG = {
    SCRIPT_NAME = "REMOTE SPY SUPREME",
    VERSION = "v4.0",
    DEVELOPER = "Kreatifiti",
    PROFILE_URL = "https://www.roblox.com/users/profile?username=Kreatifiti",
    ICONS = ICONS,
    COLORS = COLORS,
    ANIMATION = {
        DURATION = 0.4,
        EASING = Enum.EasingStyle.Quint,
        DIRECTION = Enum.EasingDirection.Out
    }
}

-- [[ PROFESSIONAL NOTIFICATION SYSTEM ]] --
local NotificationSystem = {}
do
    local notifications = {}
    
    function NotificationSystem:Show(title, message, options)
        options = options or {}
        local duration = options.duration or 4
        local type = options.type or "info"
        local icon = options.icon or CONFIG.ICONS.LOGO
        
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "Notification_" .. HttpService:GenerateGUID(false)
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Parent = player:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 340, 0, 0)
        Frame.Position = UDim2.new(1, 30, 0.8, 0)
        Frame.BackgroundColor3 = CONFIG.COLORS.BACKGROUND
        Frame.BackgroundTransparency = 0.15
        Frame.BorderSizePixel = 0
        Frame.ClipsDescendants = true
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner", Frame)
        UICorner.CornerRadius = UDim.new(0, 14)
        
        local UIStroke = Instance.new("UIStroke", Frame)
        UIStroke.Color = CONFIG.COLORS.ACCENT
        UIStroke.Thickness = 2
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        
        -- Glass effect
        local UIGradient = Instance.new("UIGradient", Frame)
        UIGradient.Color = NumberSequence.new({
            NumberSequenceKeypoint.new(0, Color3.fromRGB(30, 25, 45)),
            NumberSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 35))
        })
        UIGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(1, 0.3)
        })
        
        local Icon = Instance.new("ImageLabel", Frame)
        Icon.Size = UDim2.new(0, 26, 0, 26)
        Icon.Position = UDim2.new(0, 18, 0, 18)
        Icon.BackgroundTransparency = 1
        Icon.Image = icon
        Icon.ImageColor3 = CONFIG.COLORS.ACCENT
        
        local TitleLabel = Instance.new("TextLabel", Frame)
        TitleLabel.Size = UDim2.new(1, -70, 0, 22)
        TitleLabel.Position = UDim2.new(0, 50, 0, 15)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = title
        TitleLabel.TextColor3 = CONFIG.COLORS.TEXT
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextSize = 15
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local MessageLabel = Instance.new("TextLabel", Frame)
        MessageLabel.Size = UDim2.new(1, -45, 0, 0)
        MessageLabel.Position = UDim2.new(0, 20, 0, 42)
        MessageLabel.BackgroundTransparency = 1
        MessageLabel.Text = message
        MessageLabel.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
        MessageLabel.Font = Enum.Font.Gotham
        MessageLabel.TextSize = 13
        MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
        MessageLabel.TextWrapped = true
        MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
        
        -- Auto-size message
        local textService = game:GetService("TextService")
        local textSize = textService:GetTextSize(message, 13, Enum.Font.Gotham, Vector2.new(275, math.huge))
        MessageLabel.Size = UDim2.new(1, -45, 0, textSize.Y + 12)
        
        local finalHeight = 60 + textSize.Y + 12
        Frame.Size = UDim2.new(0, 340, 0, 0)
        
        -- Animate in
        TweenService:Create(Frame, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, CONFIG.ANIMATION.DIRECTION), {
            Size = UDim2.new(0, 340, 0, finalHeight),
            Position = UDim2.new(1, -370, 0.8, 0)
        }):Play()
        
        -- Auto close
        spawn(function()
            wait(duration)
            TweenService:Create(Frame, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 30, 0.8, 0),
                Size = UDim2.new(0, 340, 0, 0)
            }):Play()
            wait(CONFIG.ANIMATION.DURATION)
            ScreenGui:Destroy()
        end)
        
        table.insert(notifications, ScreenGui)
        return ScreenGui
    end
end

-- [[ SOPHISTICATED INJECT ANIMATION ]] --
do
    local InjectGui = Instance.new("ScreenGui")
    InjectGui.Name = "InjectAnimation"
    InjectGui.ResetOnSpawn = false
    InjectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    InjectGui.Parent = player:WaitForChild("PlayerGui")
    
    local InjectFrame = Instance.new("Frame")
    InjectFrame.Size = UDim2.new(1, 0, 1, 0)
    InjectFrame.BackgroundColor3 = CONFIG.COLORS.BACKGROUND
    InjectFrame.BorderSizePixel = 0
    InjectFrame.ZIndex = 9999
    InjectFrame.Parent = InjectGui
    
    -- Background gradient
    local BgGradient = Instance.new("UIGradient", InjectFrame)
    BgGradient.Color = NumberSequence.new({
        NumberSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 40)),
        NumberSequenceKeypoint.new(0.5, Color3.fromRGB(40, 30, 60)),
        NumberSequenceKeypoint.new(1, Color3.fromRGB(25, 20, 40))
    })
    BgGradient.Rotation = 45
    
    local LogoContainer = Instance.new("Frame", InjectFrame)
    LogoContainer.Size = UDim2.new(0, 140, 0, 140)
    LogoContainer.Position = UDim2.new(0.5, -70, 0.4, -70)
    LogoContainer.BackgroundColor3 = CONFIG.COLORS.CARD
    LogoContainer.BackgroundTransparency = 0.2
    LogoContainer.BorderSizePixel = 0
    
    local LogoCorner = Instance.new("UICorner", LogoContainer)
    LogoCorner.CornerRadius = UDim.new(0, 20)
    
    local LogoStroke = Instance.new("UIStroke", LogoContainer)
    LogoStroke.Color = CONFIG.COLORS.ACCENT
    LogoStroke.Thickness = 3
    
    local Logo = Instance.new("ImageLabel", LogoContainer)
    Logo.Size = UDim2.new(0, 80, 0, 80)
    Logo.Position = UDim2.new(0.5, -40, 0.5, -40)
    Logo.BackgroundTransparency = 1
    Logo.Image = CONFIG.ICONS.LOGO
    Logo.ImageColor3 = CONFIG.COLORS.ACCENT
    
    -- Animated glow effect
    local Glow = Instance.new("Frame", LogoContainer)
    Glow.Size = UDim2.new(1, 20, 1, 20)
    Glow.Position = UDim2.new(0, -10, 0, -10)
    Glow.BackgroundTransparency = 0.7
    Glow.BackgroundColor3 = CONFIG.COLORS.ACCENT
    Glow.BorderSizePixel = 0
    
    local GlowCorner = Instance.new("UICorner", Glow)
    GlowCorner.CornerRadius = UDim.new(0, 30)
    
    -- Animate glow
    spawn(function()
        while Glow.Parent do
            TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                BackgroundTransparency = 0.9
            }):Play()
            wait(2)
        end
    end)
    
    local ScriptName = Instance.new("TextLabel", InjectFrame)
    ScriptName.Size = UDim2.new(1, 0, 0, 40)
    ScriptName.Position = UDim2.new(0, 0, 0.6, -20)
    ScriptName.BackgroundTransparency = 1
    ScriptName.Text = CONFIG.SCRIPT_NAME
    ScriptName.TextColor3 = CONFIG.COLORS.TEXT
    ScriptName.Font = Enum.Font.GothamBlack
    ScriptName.TextSize = 28
    ScriptName.TextStrokeTransparency = 0.8
    ScriptName.TextStrokeColor3 = CONFIG.COLORS.ACCENT
    
    local Version = Instance.new("TextLabel", InjectFrame)
    Version.Size = UDim2.new(1, 0, 0, 28)
    Version.Position = UDim2.new(0, 0, 0.6, 25)
    Version.BackgroundTransparency = 1
    Version.Text = CONFIG.VERSION .. " • BY " .. string.upper(CONFIG.DEVELOPER)
    Version.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    Version.Font = Enum.Font.GothamSemibold
    Version.TextSize = 17
    Version.TextStrokeTransparency = 0.9
    
    local Status = Instance.new("TextLabel", InjectFrame)
    Status.Size = UDim2.new(1, 0, 0, 25)
    Status.Position = UDim2.new(0, 0, 0.6, 60)
    Status.BackgroundTransparency = 1
    Status.Text = "INITIALIZING SECURITY PROTOCOLS..."
    Status.TextColor3 = CONFIG.COLORS.INFO
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 14
    
    local LoadingContainer = Instance.new("Frame", InjectFrame)
    LoadingContainer.Size = UDim2.new(0, 300, 0, 8)
    LoadingContainer.Position = UDim2.new(0.5, -150, 0.7, 0)
    LoadingContainer.BackgroundColor3 = CONFIG.COLORS.CARD
    LoadingContainer.BackgroundTransparency = 0.3
    LoadingContainer.BorderSizePixel = 0
    
    local LoadingCorner = Instance.new("UICorner", LoadingContainer)
    LoadingCorner.CornerRadius = UDim.new(0, 4)
    
    local LoadingBar = Instance.new("Frame", LoadingContainer)
    LoadingBar.Size = UDim2.new(0, 0, 1, 0)
    LoadingBar.BackgroundColor3 = CONFIG.COLORS.ACCENT
    LoadingBar.BorderSizePixel = 0
    
    local LoadingBarCorner = Instance.new("UICorner", LoadingBar)
    LoadingBarCorner.CornerRadius = UDim.new(0, 4)
    
    -- Loading stages
    local stages = {
        "LOADING CORE MODULES...",
        "INITIALIZING GUI SYSTEM...",
        "CONNECTING TO REMOTE SERVICES...",
        "FINALIZING SETUP..."
    }
    
    -- Animate loading with stages
    spawn(function()
        for i, stage in ipairs(stages) do
            Status.Text = stage
            local progress = i / #stages
            TweenService:Create(LoadingBar, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(progress, 0, 1, 0)
            }):Play()
            wait(0.8)
        end
        
        Status.Text = "SYSTEM READY • ACCESS GRANTED"
        Status.TextColor3 = CONFIG.COLORS.SUCCESS
        wait(1)
        
        -- Fade out
        TweenService:Create(InjectFrame, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(LogoContainer, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play()
        
        TweenService:Create(ScriptName, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play()
        
        TweenService:Create(Version, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play()
        
        TweenService:Create(Status, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play()
        
        TweenService:Create(LoadingContainer, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        
        TweenService:Create(LoadingBar, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        
        wait(1.5)
        InjectGui:Destroy()
    end)
end

-- [[ PROFESSIONAL MAIN GUI ]] --
local GUI = {}
do
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RemoteSpySupreme"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 600, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
    MainFrame.BackgroundColor3 = CONFIG.COLORS.BACKGROUND
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 18)
    
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Color = CONFIG.COLORS.ACCENT
    UIStroke.Thickness = 3
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- Glass effect gradient
    local MainGradient = Instance.new("UIGradient", MainFrame)
    MainGradient.Color = NumberSequence.new({
        NumberSequenceKeypoint.new(0, Color3.fromRGB(30, 25, 45)),
        NumberSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 35))
    })
    MainGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(1, 0.25)
    })
    
    -- Title Bar
    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = CONFIG.COLORS.CARD
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.BorderSizePixel = 0
    
    local TitleCorner = Instance.new("UICorner", TitleBar)
    TitleCorner.CornerRadius = UDim.new(0, 18)
    
    local TitleIcon = Instance.new("ImageLabel", TitleBar)
    TitleIcon.Size = UDim2.new(0, 28, 0, 28)
    TitleIcon.Position = UDim2.new(0, 15, 0, 8)
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Image = CONFIG.ICONS.LOGO
    TitleIcon.ImageColor3 = CONFIG.COLORS.ACCENT
    
    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(0.7, 0, 1, 0)
    TitleText.Position = UDim2.new(0, 50, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = CONFIG.SCRIPT_NAME .. " " .. CONFIG.VERSION
    TitleText.TextColor3 = CONFIG.COLORS.TEXT
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 17
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    
    local DeveloperText = Instance.new("TextLabel", TitleBar)
    DeveloperText.Size = UDim2.new(0.3, 0, 1, 0)
    DeveloperText.Position = UDim2.new(0.7, 0, 0, 0)
    DeveloperText.BackgroundTransparency = 1
    DeveloperText.Text = "by " .. CONFIG.DEVELOPER
    DeveloperText.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    DeveloperText.Font = Enum.Font.Gotham
    DeveloperText.TextSize = 14
    DeveloperText.TextXAlignment = Enum.TextXAlignment.Right
    
    -- Control Buttons
    local ControlButtons = Instance.new("Frame", TitleBar)
    ControlButtons.Size = UDim2.new(0, 80, 1, -16)
    ControlButtons.Position = UDim2.new(1, -90, 0, 8)
    ControlButtons.BackgroundTransparency = 1
    
    local MinimizeBtn = Instance.new("TextButton", ControlButtons)
    MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    MinimizeBtn.Position = UDim2.new(0, 5, 0, 0)
    MinimizeBtn.Text = "−"
    MinimizeBtn.BackgroundColor3 = CONFIG.COLORS.WARNING
    MinimizeBtn.TextColor3 = CONFIG.COLORS.TEXT
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 18
    
    local CloseBtn = Instance.new("TextButton", ControlButtons)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(0, 35, 0, 0)
    CloseBtn.Text = "✕"
    CloseBtn.BackgroundColor3 = CONFIG.COLORS.ERROR
    CloseBtn.TextColor3 = CONFIG.COLORS.TEXT
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    
    local function styleControlButton(btn, color)
        btn.BackgroundColor3 = color
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 6)
        local stroke = Instance.new("UIStroke", btn)
        stroke.Color = CONFIG.COLORS.ACCENT
        stroke.Thickness = 1
    end
    
    styleControlButton(MinimizeBtn, CONFIG.COLORS.WARNING)
    styleControlButton(CloseBtn, CONFIG.COLORS.ERROR)
    
    -- Search Bar
    local SearchContainer = Instance.new("Frame", MainFrame)
    SearchContainer.Size = UDim2.new(1, -30, 0, 40)
    SearchContainer.Position = UDim2.new(0, 15, 0, 55)
    SearchContainer.BackgroundColor3 = CONFIG.COLORS.CARD
    SearchContainer.BackgroundTransparency = 0.25
    
    local SearchCorner = Instance.new("UICorner", SearchContainer)
    SearchCorner.CornerRadius = UDim.new(0, 12)
    
    local SearchStroke = Instance.new("UIStroke", SearchContainer)
    SearchStroke.Color = CONFIG.COLORS.ACCENT
    SearchStroke.Thickness = 1
    
    local SearchIcon = Instance.new("ImageLabel", SearchContainer)
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Position = UDim2.new(0, 15, 0, 10)
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Image = CONFIG.ICONS.SEARCH
    SearchIcon.ImageColor3 = CONFIG.COLORS.TEXT_SECONDARY
    
    local SearchBar = Instance.new("TextBox", SearchContainer)
    SearchBar.Size = UDim2.new(1, -50, 1, 0)
    SearchBar.Position = UDim2.new(0, 45, 0, 0)
    SearchBar.BackgroundTransparency = 1
    SearchBar.Text = ""
    SearchBar.PlaceholderText = "Search for remotes, functions, or events..."
    SearchBar.TextColor3 = CONFIG.COLORS.TEXT
    SearchBar.PlaceholderColor3 = CONFIG.COLORS.TEXT_SECONDARY
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.TextSize = 15
    SearchBar.ClearTextOnFocus = false
    
    -- Tab Bar
    local TabBar = Instance.new("Frame", MainFrame)
    TabBar.Size = UDim2.new(1, -20, 0, 45)
    TabBar.Position = UDim2.new(0, 10, 0, 105)
    TabBar.BackgroundColor3 = CONFIG.COLORS.CARD
    TabBar.BackgroundTransparency = 0.25
    
    local TabCorner = Instance.new("UICorner", TabBar)
    TabCorner.CornerRadius = UDim.new(0, 12)
    
    local TabStroke = Instance.new("UIStroke", TabBar)
    TabStroke.Color = CONFIG.COLORS.ACCENT
    TabStroke.Thickness = 1
    
    -- Tabs
    local function createTab(name, position, isActive, icon)
        local Tab = Instance.new("TextButton")
        Tab.Size = UDim2.new(0.25, -8, 1, -12)
        Tab.Position = UDim2.new(position * 0.25, position * 8, 0, 6)
        Tab.Text = name
        Tab.BackgroundColor3 = isActive and CONFIG.COLORS.SECONDARY or CONFIG.COLORS.CARD
        Tab.BackgroundTransparency = isActive and 0.2 or 0.4
        Tab.TextColor3 = CONFIG.COLORS.TEXT
        Tab.BorderSizePixel = 0
        Tab.Font = Enum.Font.GothamSemibold
        Tab.TextSize = 13
        Tab.Parent = TabBar
        
        local TabCorner = Instance.new("UICorner", Tab)
        TabCorner.CornerRadius = UDim.new(0, 8)
        
        local TabStroke = Instance.new("UIStroke", Tab)
        TabStroke.Color = CONFIG.COLORS.ACCENT
        TabStroke.Thickness = isActive and 2 or 1
        
        if icon then
            local TabIcon = Instance.new("ImageLabel", Tab)
            TabIcon.Size = UDim2.new(0, 16, 0, 16)
            TabIcon.Position = UDim2.new(0, 8, 0.5, -8)
            TabIcon.BackgroundTransparency = 1
            TabIcon.Image = icon
            TabIcon.ImageColor3 = CONFIG.COLORS.TEXT
            
            Tab.Text = ""
            local IconLabel = Instance.new("TextLabel", Tab)
            IconLabel.Size = UDim2.new(1, -30, 1, 0)
            IconLabel.Position = UDim2.new(0, 30, 0, 0)
            IconLabel.BackgroundTransparency = 1
            IconLabel.Text = name
            IconLabel.TextColor3 = CONFIG.COLORS.TEXT
            IconLabel.Font = Enum.Font.GothamSemibold
            IconLabel.TextSize = 13
            IconLabel.TextXAlignment = Enum.TextXAlignment.Left
        end
        
        return Tab
    end
    
    local tabs = {
        events = createTab("Events", 0, true, CONFIG.ICONS.EVENT),
        functions = createTab("Functions", 1, false, CONFIG.ICONS.FUNCTION),
        favorites = createTab("Favorites", 2, false, CONFIG.ICONS.FAVORITE),
        tools = createTab("Tools", 3, false, CONFIG.ICONS.TOOLS)
    }
    
    -- Content Area
    local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
    ContentFrame.Name = "ContentArea"
    ContentFrame.Size = UDim2.new(1, -20, 1, -180)
    ContentFrame.Position = UDim2.new(0, 10, 0, 160)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 10
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    
    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.Padding = UDim.new(0, 15)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- Status Bar
    local StatusBar = Instance.new("Frame", MainFrame)
    StatusBar.Size = UDim2.new(1, -20, 0, 35)
    StatusBar.Position = UDim2.new(0, 10, 1, -45)
    StatusBar.BackgroundColor3 = CONFIG.COLORS.CARD
    StatusBar.BackgroundTransparency = 0.25
    
    local StatusCorner = Instance.new("UICorner", StatusBar)
    StatusCorner.CornerRadius = UDim.new(0, 10)
    
    local StatusStroke = Instance.new("UIStroke", StatusBar)
    StatusStroke.Color = CONFIG.COLORS.ACCENT
    StatusStroke.Thickness = 1
    
    local StatusLabel = Instance.new("TextLabel", StatusBar)
    StatusLabel.Size = UDim2.new(0.6, 0, 1, 0)
    StatusLabel.Position = UDim2.new(0, 12, 0, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "SYSTEM READY • 0 EVENTS • 0 FUNCTIONS • 0 FAVORITES"
    StatusLabel.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 12
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ControlButtons2 = Instance.new("Frame", StatusBar)
    ControlButtons2.Size = UDim2.new(0.4, -25, 1, 0)
    ControlButtons2.Position = UDim2.new(0.6, 15, 0, 0)
    ControlButtons2.BackgroundTransparency = 1
    
    local PauseButton = Instance.new("TextButton", ControlButtons2)
    PauseButton.Size = UDim2.new(0.45, 0, 1, 0)
    PauseButton.Position = UDim2.new(0, 0, 0, 0)
    PauseButton.Text = "PAUSE"
    PauseButton.BackgroundColor3 = CONFIG.COLORS.SECONDARY
    PauseButton.TextColor3 = CONFIG.COLORS.TEXT
    PauseButton.BorderSizePixel = 0
    PauseButton.Font = Enum.Font.GothamSemibold
    PauseButton.TextSize = 12
    
    local ExportButton = Instance.new("TextButton", ControlButtons2)
    ExportButton.Size = UDim2.new(0.45, 0, 1, 0)
    ExportButton.Position = UDim2.new(0.55, 0, 0, 0)
    ExportButton.Text = "EXPORT"
    ExportButton.BackgroundColor3 = CONFIG.COLORS.INFO
    ExportButton.TextColor3 = CONFIG.COLORS.TEXT
    ExportButton.BorderSizePixel = 0
    ExportButton.Font = Enum.Font.GothamSemibold
    ExportButton.TextSize = 12
    
    local function styleButton(button, color)
        button.BackgroundColor3 = color
        local corner = Instance.new("UICorner", button)
        corner.CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", button)
        stroke.Color = CONFIG.COLORS.ACCENT
        stroke.Thickness = 1
    end
    
    styleButton(PauseButton, CONFIG.COLORS.SECONDARY)
    styleButton(ExportButton, CONFIG.COLORS.INFO)
    
    -- Resize Handle
    local ResizeHandle = Instance.new("Frame", MainFrame)
    ResizeHandle.Size = UDim2.new(0, 25, 0, 25)
    ResizeHandle.Position = UDim2.new(1, -25, 1, -25)
    ResizeHandle.BackgroundColor3 = CONFIG.COLORS.ACCENT
    ResizeHandle.BackgroundTransparency = 0.7
    ResizeHandle.BorderSizePixel = 0
    
    local ResizeCorner = Instance.new("UICorner", ResizeHandle)
    ResizeCorner.CornerRadius = UDim.new(0, 6)
    
    local ResizeIcon = Instance.new("ImageLabel", ResizeHandle)
    ResizeIcon.Size = UDim2.new(0, 16, 0, 16)
    ResizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    ResizeIcon.BackgroundTransparency = 1
    ResizeIcon.Image = CONFIG.ICONS.RESIZE
    ResizeIcon.ImageColor3 = CONFIG.COLORS.TEXT
    ResizeIcon.ImageTransparency = 0.3
    
    -- Event Handlers
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        wait(0.4)
        ScreenGui:Destroy()
    end)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        -- Create restore button in corner
        local RestoreGui = Instance.new("ScreenGui")
        RestoreGui.Name = "RestoreButton"
        RestoreGui.ResetOnSpawn = false
        RestoreGui.Parent = player:WaitForChild("PlayerGui")
        
        local RestoreBtn = Instance.new("TextButton")
        RestoreBtn.Size = UDim2.new(0, 40, 0, 40)
        RestoreBtn.Position = UDim2.new(1, -50, 1, -50)
        RestoreBtn.Text = "RS"
        RestoreBtn.BackgroundColor3 = CONFIG.COLORS.SECONDARY
        RestoreBtn.TextColor3 = CONFIG.COLORS.TEXT
        RestoreBtn.BorderSizePixel = 0
        RestoreBtn.Font = Enum.Font.GothamBold
        RestoreBtn.TextSize = 14
        RestoreBtn.Parent = RestoreGui
        
        local RestoreCorner = Instance.new("UICorner", RestoreBtn)
        RestoreCorner.CornerRadius = UDim.new(0, 10)
        
        RestoreBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = true
            RestoreGui:Destroy()
        end)
    end)
    
    GUI = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        ContentFrame = ContentFrame,
        ContentLayout = ContentLayout,
        SearchBar = SearchBar,
        StatusLabel = StatusLabel,
        PauseButton = PauseButton,
        ExportButton = ExportButton,
        Tabs = tabs,
        ResizeHandle = ResizeHandle
    }
end

-- [[ RESIZE FUNCTIONALITY ]] --
do
    local isResizing = false
    local startPos, startSize
    
    GUI.ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isResizing = true
            startPos = input.Position
            startSize = GUI.MainFrame.AbsoluteSize
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End and isResizing then
                    isResizing = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            local newWidth = math.max(500, startSize.X + delta.X)
            local newHeight = math.max(400, startSize.Y + delta.Y)
            GUI.MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

-- [[ CORE LOGIC ]] --
local RemoteSpy = {
    enabled = true,
    remotes = {},
    sections = {},
    favorites = {},
    stats = {
        events = 0,
        functions = 0,
        favorites = 0
    }
}

function RemoteSpy:UpdateStats()
    self.stats.favorites = #self.favorites
    GUI.StatusLabel.Text = string.format(
        "SYSTEM READY • %d EVENTS • %d FUNCTIONS • %d FAVORITES",
        self.stats.events,
        self.stats.functions,
        self.stats.favorites
    )
end

function RemoteSpy:CreateSection(name)
    if self.sections[name] then return self.sections[name] end
    
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -25, 0, 50)
    section.BackgroundColor3 = CONFIG.COLORS.CARD
    section.BackgroundTransparency = 0.2
    section.BorderSizePixel = 0
    section.LayoutOrder = #self.sections
    section.Parent = GUI.ContentFrame
    
    local sectionCorner = Instance.new("UICorner", section)
    sectionCorner.CornerRadius = UDim.new(0, 14)
    
    local sectionStroke = Instance.new("UIStroke", section)
    sectionStroke.Color = CONFIG.COLORS.ACCENT
    sectionStroke.Thickness = 1
    
    local sectionGradient = Instance.new("UIGradient", section)
    sectionGradient.Color = NumberSequence.new({
        NumberSequenceKeypoint.new(0, Color3.fromRGB(35, 30, 50)),
        NumberSequenceKeypoint.new(1, Color3.fromRGB(25, 20, 40))
    })
    sectionGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.2),
        NumberSequenceKeypoint.new(1, 0.3)
    })
    
    local icon = Instance.new("ImageLabel", section)
    icon.Size = UDim2.new(0, 26, 0, 26)
    icon.Position = UDim2.new(0, 18, 0, 12)
    icon.BackgroundTransparency = 1
    icon.Image = CONFIG.ICONS.FOLDER
    icon.ImageColor3 = CONFIG.COLORS.ACCENT
    
    local title = Instance.new("TextLabel", section)
    title.Size = UDim2.new(1, -90, 1, 0)
    title.Position = UDim2.new(0, 50, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = CONFIG.COLORS.TEXT
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    local count = Instance.new("TextLabel", section)
    count.Size = UDim2.new(0, 50, 1, 0)
    count.Position = UDim2.new(1, -70, 0, 0)
    count.BackgroundTransparency = 1
    count.Text = "0"
    count.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    count.Font = Enum.Font.GothamSemibold
    count.TextSize = 15
    
    local toggle = Instance.new("TextButton", section)
    toggle.Size = UDim2.new(0, 32, 0, 32)
    toggle.Position = UDim2.new(1, -40, 0, 9)
    toggle.Text = "▼"
    toggle.BackgroundColor3 = CONFIG.COLORS.SECONDARY
    toggle.TextColor3 = CONFIG.COLORS.TEXT
    toggle.BorderSizePixel = 0
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 15
    
    local toggleCorner = Instance.new("UICorner", toggle)
    local toggleStroke = Instance.new("UIStroke", toggle)
    toggleStroke.Color = CONFIG.COLORS.ACCENT
    toggleStroke.Thickness = 1
    
    local container = Instance.new("Frame", section)
    container.Size = UDim2.new(1, -15, 0, 0)
    container.Position = UDim2.new(0, 7, 1, 8)
    container.BackgroundTransparency = 1
    container.Name = "Container"
    
    local layout = Instance.new("UIListLayout", container)
    layout.Padding = UDim.new(0, 12)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local expanded = true
    local itemCount = 0
    
    toggle.MouseButton1Click:Connect(function()
        expanded = not expanded
        toggle.Text = expanded and "▼" or "►"
        local targetHeight = expanded and (layout.AbsoluteContentSize.Y + 20) or 0
        local size = UDim2.new(1, -15, 0, targetHeight)
        
        TweenService:Create(container, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, CONFIG.ANIMATION.DIRECTION), {
            Size = size
        }):Play()
    end)
    
    self.sections[name] = {
        frame = section,
        container = container,
        layout = layout,
        countLabel = count,
        addItem = function()
            itemCount = itemCount + 1
            count.Text = tostring(itemCount)
        end,
        getItemCount = function()
            return itemCount
        end
    }
    
    return self.sections[name]
end

function RemoteSpy:AddRemote(remote, args)
    if not self.enabled then return end
    
    local name = remote.Name
    local path = remote:GetFullName()
    local remoteType = remote:IsA("RemoteEvent") and "Event" or "Function"
    
    -- Update stats
    if remote:IsA("RemoteEvent") then
        self.stats.events = self.stats.events + 1
    else
        self.stats.functions = self.stats.functions + 1
    end
    self:UpdateStats()
    
    -- Store remote data
    table.insert(self.remotes, {
        name = name,
        path = path,
        type = remoteType,
        args = args,
        timestamp = tick(),
        remote = remote
    })
    
    -- Create section
    local section = self:CreateSection(name)
    section:addItem()
    
    local container = section.container
    local layout = section.layout
    
    -- Create remote item
    local item = Instance.new("Frame")
    item.Size = UDim2.new(1, -30, 0, 110)
    item.BackgroundColor3 = CONFIG.COLORS.CARD
    item.BackgroundTransparency = 0.25
    item.BorderSizePixel = 0
    item.LayoutOrder = layout.AbsoluteContentSize.Y
    item.Parent = container
    
    local itemCorner = Instance.new("UICorner", item)
    itemCorner.CornerRadius = UDim.new(0, 14)
    
    local itemStroke = Instance.new("UIStroke", item)
    itemStroke.Color = CONFIG.COLORS.ACCENT
    itemStroke.Thickness = 1
    
    local itemGradient = Instance.new("UIGradient", item)
    itemGradient.Color = NumberSequence.new({
        NumberSequenceKeypoint.new(0, Color3.fromRGB(40, 35, 55)),
        NumberSequenceKeypoint.new(1, Color3.fromRGB(30, 25, 45))
    })
    itemGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.25),
        NumberSequenceKeypoint.new(1, 0.35)
    })
    
    -- Animate item appearance
    item.BackgroundTransparency = 1
    item.Position = UDim2.new(0, 0, 0, 15)
    TweenService:Create(item, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, CONFIG.ANIMATION.DIRECTION), {
        BackgroundTransparency = 0.25,
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    local icon = Instance.new("ImageLabel", item)
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 18, 0, 18)
    icon.BackgroundTransparency = 1
    icon.Image = remote:IsA("RemoteEvent") and CONFIG.ICONS.EVENT or CONFIG.ICONS.FUNCTION
    icon.ImageColor3 = CONFIG.COLORS.ACCENT
    
    local nameLabel = Instance.new("TextLabel", item)
    nameLabel.Size = UDim2.new(1, -70, 0, 26)
    nameLabel.Position = UDim2.new(0, 55, 0, 15)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = CONFIG.COLORS.TEXT
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local typeLabel = Instance.new("TextLabel", item)
    typeLabel.Size = UDim2.new(0, 80, 0, 20)
    typeLabel.Position = UDim2.new(1, -95, 0, 18)
    typeLabel.BackgroundTransparency = 1
    typeLabel.Text = remoteType
    typeLabel.TextColor3 = remote:IsA("RemoteEvent") and CONFIG.COLORS.WARNING or CONFIG.COLORS.INFO
    typeLabel.Font = Enum.Font.GothamSemibold
    typeLabel.TextSize = 12
    
    local pathLabel = Instance.new("TextLabel", item)
    pathLabel.Size = UDim2.new(1, -40, 0, 22)
    pathLabel.Position = UDim2.new(0, 22, 0, 45)
    pathLabel.BackgroundTransparency = 1
    pathLabel.Text = "Path: " .. path
    pathLabel.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    pathLabel.Font = Enum.Font.Gotham
    pathLabel.TextSize = 13
    pathLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local argsLabel = Instance.new("TextLabel", item)
    argsLabel.Size = UDim2.new(1, -40, 0, 30)
    argsLabel.Position = UDim2.new(0, 22, 0, 70)
    argsLabel.BackgroundTransparency = 1
    argsLabel.Text = "Args: " .. tostring(args):sub(1, 80) .. (string.len(tostring(args)) > 80 and "..." or "")
    argsLabel.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
    argsLabel.Font = Enum.Font.Code
    argsLabel.TextSize = 11
    argsLabel.TextXAlignment = Enum.TextXAlignment.Left
    argsLabel.TextTruncate = Enum.TextTruncate.AtEnd
    
    -- Buttons Container
    local buttonsContainer = Instance.new("Frame", item)
    buttonsContainer.Size = UDim2.new(1, -35, 0, 35)
    buttonsContainer.Position = UDim2.new(0, 17, 1, -40)
    buttonsContainer.BackgroundTransparency = 1
    
    local buttonsLayout = Instance.new("UIListLayout", buttonsContainer)
    buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    buttonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    buttonsLayout.Padding = UDim.new(0, 10)
    
    local function createActionButton(text, color, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 70, 1, 0)
        btn.Text = text
        btn.BackgroundColor3 = color
        btn.TextColor3 = CONFIG.COLORS.TEXT
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 11
        btn.Parent = buttonsContainer
        
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 8)
        
        local btnStroke = Instance.new("UIStroke", btn)
        btnStroke.Color = CONFIG.COLORS.ACCENT
        btnStroke.Thickness = 1
        
        if icon then
            local btnIcon = Instance.new("ImageLabel", btn)
            btnIcon.Size = UDim2.new(0, 14, 0, 14)
            btnIcon.Position = UDim2.new(0, 8, 0.5, -7)
            btnIcon.BackgroundTransparency = 1
            btnIcon.Image = icon
            btnIcon.ImageColor3 = CONFIG.COLORS.TEXT
            
            btn.Text = ""
            local btnText = Instance.new("TextLabel", btn)
            btnText.Size = UDim2.new(1, -25, 1, 0)
            btnText.Position = UDim2.new(0, 25, 0, 0)
            btnText.BackgroundTransparency = 1
            btnText.Text = text
            btnText.TextColor3 = CONFIG.COLORS.TEXT
            btnText.Font = Enum.Font.GothamSemibold
            btnText.TextSize = 11
            btnText.TextXAlignment = Enum.TextXAlignment.Left
        end
        
        return btn
    end
    
    local useBtn = createActionButton("Use", CONFIG.COLORS.SECONDARY, CONFIG.ICONS.PLAY)
    local loopBtn = createActionButton("Loop", CONFIG.COLORS.WARNING, CONFIG.ICONS.LOOP)
    local copyBtn = createActionButton("Copy", CONFIG.COLORS.SUCCESS, CONFIG.ICONS.COPY)
    local saveBtn = createActionButton("Save", CONFIG.COLORS.ERROR, CONFIG.ICONS.SAVE)
    
    -- Button Hover Effects
    local function addHoverEffect(button, hoverColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = hoverColor
            }):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = button.BackgroundColor3
            }):Play()
        end)
    end
    
    addHoverEffect(useBtn, CONFIG.COLORS.INFO)
    addHoverEffect(loopBtn, Color3.fromRGB(220, 150, 20))
    addHoverEffect(copyBtn, Color3.fromRGB(30, 180, 100))
    addHoverEffect(saveBtn, Color3.fromRGB(200, 50, 50))
    
    -- Button actions
    useBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(unpack(args))
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(unpack(args))
            end
        end)
        NotificationSystem:Show(
            "Remote Executed",
            success and (name .. " executed successfully!") or ("Error: " .. tostring(err)),
            {type = success and "success" or "error", duration = 3, icon = CONFIG.ICONS.PLAY}
        )
    end)
    
    loopBtn.MouseButton1Click:Connect(function()
        local countStr = prompt("Loop Count:", "50")
        if not countStr then return end
        
        local count = tonumber(countStr) or 50
        local successCount = 0
        
        NotificationSystem:Show(
            "Loop Started",
            "Executing " .. name .. " " .. count .. " times...",
            {type = "info", duration = 2, icon = CONFIG.ICONS.LOOP}
        )
        
        for i = 1, count do
            task.spawn(function()
                local success = pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(unpack(args))
                    end
                    successCount = successCount + 1
                end)
            end)
            wait(0.05)
        end
        
        wait(1)
        NotificationSystem:Show(
            "Loop Complete",
            string.format("%s looped %d/%d times successfully!", name, successCount, count),
            {type = "success", duration = 4, icon = CONFIG.ICONS.LOOP}
        )
    end)
    
    copyBtn.MouseButton1Click:Connect(function()
        local code = ""
        if remote:IsA("RemoteEvent") then
            code = string.format('game:GetService("ReplicatedStorage"):WaitForChild("%s"):FireServer(%s)', 
                remote.Name, table.concat(args, ", "))
        elseif remote:IsA("RemoteFunction") then
            code = string.format('game:GetService("ReplicatedStorage"):WaitForChild("%s"):InvokeServer(%s)', 
                remote.Name, table.concat(args, ", "))
        end
        setclipboard(code)
        NotificationSystem:Show(
            "Code Copied",
            "Remote execution code copied to clipboard!",
            {type = "success", duration = 3, icon = CONFIG.ICONS.COPY}
        )
    end)
    
    saveBtn.MouseButton1Click:Connect(function()
        table.insert(self.favorites, {
            name = name,
            path = path,
            type = remoteType,
            remote = remote,
            args = args
        })
        self.stats.favorites = self.stats.favorites + 1
        self:UpdateStats()
        
        NotificationSystem:Show(
            "Remote Saved",
            name .. " added to favorites!",
            {type = "success", duration = 3, icon = CONFIG.ICONS.SAVE}
        )
        
        -- Change button appearance
        saveBtn.Text = "Saved"
        saveBtn.BackgroundColor3 = CONFIG.COLORS.SUCCESS
        wait(2)
        saveBtn.Text = "Save"
        saveBtn.BackgroundColor3 = CONFIG.COLORS.ERROR
    end)
    
    -- Update container size
    local newHeight = layout.AbsoluteContentSize.Y + 20
    container.Size = UDim2.new(1, -15, 0, newHeight)
end

-- [[ HOOK SYSTEM ]] --
do
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if RemoteSpy.enabled and (method == "FireServer" or method == "InvokeServer") then
            if self:IsA("RemoteEvent") or self:IsA("RemoteFunction") then
                RemoteSpy:AddRemote(self, args)
            end
        end
        
        return oldNamecall(self, ...)
    end))
end

-- [[ EVENT HANDLERS ]] --
GUI.SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = GUI.SearchBar.Text:lower()
    for name, section in pairs(RemoteSpy.sections) do
        local visible = searchText == "" or name:lower():find(searchText) ~= nil
        section.frame.Visible = visible
    end
end)

GUI.PauseButton.MouseButton1Click:Connect(function()
    RemoteSpy.enabled = not RemoteSpy.enabled
    GUI.PauseButton.Text = RemoteSpy.enabled and "PAUSE" or "RESUME"
    GUI.PauseButton.BackgroundColor3 = RemoteSpy.enabled and CONFIG.COLORS.SECONDARY or CONFIG.COLORS.ERROR
    NotificationSystem:Show(
        "Spy " .. (RemoteSpy.enabled and "Paused" or "Resumed"),
        "Remote spy is now " .. (RemoteSpy.enabled and "paused" or "active"),
        {type = RemoteSpy.enabled and "warning" or "success", duration = 3, icon = RemoteSpy.enabled and CONFIG.ICONS.PAUSE or CONFIG.ICONS.PLAY}
    )
end)

GUI.ExportButton.MouseButton1Click:Connect(function()
    local log = string.format("=== Remote Spy Supreme Log ===\nDeveloper: %s\nVersion: %s\nExport Time: %s\n\n", 
        CONFIG.DEVELOPER, CONFIG.VERSION, os.date("%Y-%m-%d %H:%M:%S"))
    
    log = log .. string.format("Statistics:\n- Events: %d\n- Functions: %d\n- Favorites: %d\n\n", 
        RemoteSpy.stats.events, RemoteSpy.stats.functions, RemoteSpy.stats.favorites)
    
    for i, remote in ipairs(RemoteSpy.remotes) do
        log = log .. string.format("[%d] [%s] %s\nPath: %s\nArgs: %s\nTimestamp: %.2f\n---\n", 
            i, remote.type, remote.name, remote.path, tostring(remote.args), remote.timestamp)
    end
    
    setclipboard(log)
    NotificationSystem:Show(
        "Log Exported",
        string.format("Remote log (%d entries) copied to clipboard!", #RemoteSpy.remotes),
        {type = "success", duration = 4, icon = CONFIG.ICONS.EXPORT}
    )
end)

-- Tab switching
for tabName, tabButton in pairs(GUI.Tabs) do
    tabButton.MouseButton1Click:Connect(function()
        for name, button in pairs(GUI.Tabs) do
            local isActive = name == tabName
            button.BackgroundColor3 = isActive and CONFIG.COLORS.SECONDARY or CONFIG.COLORS.CARD
            button.BackgroundTransparency = isActive and 0.2 or 0.4
            local stroke = button:FindFirstChild("UIStroke")
            if stroke then
                stroke.Thickness = isActive and 2 or 1
            end
        end
        -- In real implementation, would switch content here
    end)
end

-- [[ FINALIZATION ]] --
RemoteSpy:UpdateStats()
NotificationSystem:Show(
    "System Online",
    CONFIG.SCRIPT_NAME .. " " .. CONFIG.VERSION .. " by " .. CONFIG.DEVELOPER .. " is now operational!",
    {type = "success", duration = 5, icon = CONFIG.ICONS.LOGO}
)

print("[" .. CONFIG.DEVELOPER .. "] " .. CONFIG.SCRIPT_NAME .. " " .. CONFIG.VERSION .. " initialized successfully!")
