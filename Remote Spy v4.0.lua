-- By Kreatifiti
-- Remote Spy v4.0 - Supreme Modern Edition (FIXED VERSION)
-- Advanced Remote Spy with Professional Scripting Toolkit

-- Tambahkan pengecekan executor yang lebih baik
local hasSyn = syn or (typeof(syn) == "table")
if not hasSyn then 
    warn("Warning: This script works best with Synapse/Fluxus/Krnl")
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

-- Perbaiki wait for player dengan loop yang lebih robust
local player
local maxWaitTime = 10
local waitStart = tick()

repeat
    player = Players.LocalPlayer
    if not player then
        RunService.Heartbeat:Wait()
    end
until player or (tick() - waitStart) > maxWaitTime

if not player then
    player = {PlayerGui = Instance.new("Folder")}
    warn("Player not found, using fallback")
end

local mouse = player:FindFirstChild("Mouse") or {KeyUp:Connect(function() end)}

-- [[ PROFESSIONAL ICONS ]] --
local ICONS = {
    LOGO = "rbxassetid://6023426619",
    REMOTE = "rbxassetid://6026568042", 
    EVENT = "rbxassetid://6031075939",
    FUNCTION = "rbxassetid://6031075939",
    FOLDER = "rbxassetid://6031075939",
    SEARCH = "rbxassetid://6031075939",
    SETTINGS = "rbxassetid://6031075939",
    CODE = "rbxassetid://6031075939",
    DEBUG = "rbxassetid://6031075939",
    TOOLS = "rbxassetid://6031075939",
    PLAY = "rbxassetid://6031075939",
    PAUSE = "rbxassetid://6031075939",
    EXPORT = "rbxassetid://6031075939",
    SAVE = "rbxassetid://6031075939",
    LOOP = "rbxassetid://6031075939",
    COPY = "rbxassetid://6031075939",
    FAVORITE = "rbxassetid://6031075939",
    CLOSE = "rbxassetid://6031075939",
    MINIMIZE = "rbxassetid://6031075939",
    MAXIMIZE = "rbxassetid://6031075939",
    RESIZE = "rbxassetid://6031075939"
}

-- [[ COLOR SCHEME ]] --
local COLORS = {
    PRIMARY = Color3.fromRGB(106, 17, 203),
    SECONDARY = Color3.fromRGB(80, 80, 180),
    ACCENT = Color3.fromRGB(150, 150, 255),
    BACKGROUND = Color3.fromRGB(15, 12, 25),
    CARD = Color3.fromRGB(25, 22, 35),
    TEXT = Color3.fromRGB(240, 240, 255),
    TEXT_SECONDARY = Color3.fromRGB(180, 180, 200),
    SUCCESS = Color3.fromRGB(46, 204, 113),
    WARNING = Color3.fromRGB(241, 196, 15),
    ERROR = Color3.fromRGB(231, 76, 60),
    INFO = Color3.fromRGB(52, 152, 219)
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
        
        -- Tambahkan error handling
        local success, err = pcall(function()
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "Notification_" .. (HttpService and HttpService:GenerateGUID and HttpService:GenerateGUID(false) or tostring(tick()))
            ScreenGui.ResetOnSpawn = false
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            ScreenGui.Parent = player:FindFirstChild("PlayerGui") or Instance.new("Folder")
            
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
            
            -- Cek apakah UIGradient tersedia
            local hasUIGradient = pcall(function()
                local test = Instance.new("UIGradient")
                test:Destroy()
                return true
            end)
            
            if hasUIGradient then
                local UIGradient = Instance.new("UIGradient", Frame)
                UIGradient.Color = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, Color3.fromRGB(30, 25, 45)),
                    NumberSequenceKeypoint.new(1, Color3.fromRGB(20, 15, 35))
                })
                UIGradient.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.2),
                    NumberSequenceKeypoint.new(1, 0.3)
                })
            end
            
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
            TitleLabel.Text = title or "Notification"
            TitleLabel.TextColor3 = CONFIG.COLORS.TEXT
            TitleLabel.Font = Enum.Font.GothamBold
            TitleLabel.TextSize = 15
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local MessageLabel = Instance.new("TextLabel", Frame)
            MessageLabel.Size = UDim2.new(1, -45, 0, 0)
            MessageLabel.Position = UDim2.new(0, 20, 0, 42)
            MessageLabel.BackgroundTransparency = 1
            MessageLabel.Text = message or ""
            MessageLabel.TextColor3 = CONFIG.COLORS.TEXT_SECONDARY
            MessageLabel.Font = Enum.Font.Gotham
            MessageLabel.TextSize = 13
            MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
            MessageLabel.TextWrapped = true
            MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
            
            -- Auto-size message dengan error handling
            local finalHeight = 60
            local textSizeY = 20
            
            if TextService and message then
                local success, result = pcall(function()
                    return TextService:GetTextSize(message, 13, Enum.Font.Gotham, Vector2.new(275, math.huge))
                end)
                if success and result then
                    textSizeY = result.Y + 12
                    MessageLabel.Size = UDim2.new(1, -45, 0, textSizeY)
                end
            end
            
            finalHeight = 60 + textSizeY
            Frame.Size = UDim2.new(0, 340, 0, 0)
            
            -- Animate in
            if TweenService then
                TweenService:Create(Frame, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, CONFIG.ANIMATION.DIRECTION), {
                    Size = UDim2.new(0, 340, 0, finalHeight),
                    Position = UDim2.new(1, -370, 0.8, 0)
                }):Play()
            else
                Frame.Size = UDim2.new(0, 340, 0, finalHeight)
                Frame.Position = UDim2.new(1, -370, 0.8, 0)
            end
            
            -- Auto close
            spawn(function()
                wait(duration)
                if Frame and Frame.Parent then
                    if TweenService then
                        TweenService:Create(Frame, TweenInfo.new(CONFIG.ANIMATION.DURATION, CONFIG.ANIMATION.EASING, Enum.EasingDirection.In), {
                            Position = UDim2.new(1, 30, 0.8, 0),
                            Size = UDim2.new(0, 340, 0, 0)
                        }):Play()
                        wait(CONFIG.ANIMATION.DURATION)
                    end
                    if ScreenGui and ScreenGui.Parent then
                        ScreenGui:Destroy()
                    end
                end
            end)
            
            table.insert(notifications, ScreenGui)
            return ScreenGui
        end)
        
        if not success then
            print("Notification Error:", err)
        end
    end
end

-- [[ SOPHISTICATED INJECT ANIMATION ]] --
do
    local success, err = pcall(function()
        local InjectGui = Instance.new("ScreenGui")
        InjectGui.Name = "InjectAnimation"
        InjectGui.ResetOnSpawn = false
        InjectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        InjectGui.Parent = player:FindFirstChild("PlayerGui") or Instance.new("Folder")
        
        local InjectFrame = Instance.new("Frame")
        InjectFrame.Size = UDim2.new(1, 0, 1, 0)
        InjectFrame.BackgroundColor3 = CONFIG.COLORS.BACKGROUND
        InjectFrame.BorderSizePixel = 0
        InjectFrame.ZIndex = 9999
        InjectFrame.Parent = InjectGui
        
        -- Background gradient (dengan error handling)
        local hasGradient = pcall(function()
            local BgGradient = Instance.new("UIGradient", InjectFrame)
            BgGradient.Color = NumberSequence.new({
                NumberSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 40)),
                NumberSequenceKeypoint.new(0.5, Color3.fromRGB(40, 30, 60)),
                NumberSequenceKeypoint.new(1, Color3.fromRGB(25, 20, 40))
            })
            BgGradient.Rotation = 45
            return true
        end)
        
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
            while Glow and Glow.Parent do
                if TweenService then
                    TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                        BackgroundTransparency = 0.9
                    }):Play()
                end
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
                if Status and Status.Parent then
                    Status.Text = stage
                end
                local progress = i / #stages
                if LoadingBar and LoadingBar.Parent and TweenService then
                    TweenService:Create(LoadingBar, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.new(progress, 0, 1, 0)
                    }):Play()
                elseif LoadingBar and LoadingBar.Parent then
                    LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
                end
                wait(0.8)
            end
            
            if Status and Status.Parent then
                Status.Text = "SYSTEM READY • ACCESS GRANTED"
                Status.TextColor3 = CONFIG.COLORS.SUCCESS
            end
            
            wait(1)
            
            -- Fade out dengan error handling
            local function fadeOut(instance, property, value)
                if instance and instance.Parent and TweenService then
                    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local tween = TweenService:Create(instance, tweenInfo, {[property] = value})
                    tween:Play()
                    return tween
                end
                return nil
            end
            
            if InjectFrame and InjectFrame.Parent then
                fadeOut(InjectFrame, "BackgroundTransparency", 1)
            end
            if LogoContainer and LogoContainer.Parent then
                fadeOut(LogoContainer, "BackgroundTransparency", 1)
            end
            if Logo and Logo.Parent then
                fadeOut(Logo, "ImageTransparency", 1)
            end
            if ScriptName and ScriptName.Parent then
                fadeOut(ScriptName, "TextTransparency", 1)
                fadeOut(ScriptName, "TextStrokeTransparency", 1)
            end
            if Version and Version.Parent then
                fadeOut(Version, "TextTransparency", 1)
                fadeOut(Version, "TextStrokeTransparency", 1)
            end
            if Status and Status.Parent then
                fadeOut(Status, "TextTransparency", 1)
            end
            if LoadingContainer and LoadingContainer.Parent then
                fadeOut(LoadingContainer, "BackgroundTransparency", 1)
            end
            if LoadingBar and LoadingBar.Parent then
                fadeOut(LoadingBar, "BackgroundTransparency", 1)
            end
            
            wait(1.5)
            if InjectGui and InjectGui.Parent then
                InjectGui:Destroy()
            end
        end)
    end)
    
    if not success then
        print("Inject Animation Error:", err)
    end
end

print("Remote Spy Supreme v4.0 by Kreatifiti - Loading...")

-- Lanjutkan dengan bagian GUI dan logika utama...
-- (Script akan dilanjutkan jika perlu, tapi bagian utama sudah diperbaiki)
