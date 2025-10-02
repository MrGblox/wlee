local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44 Hub | Universal",
    Icon = "earth", -- lucide icon
    Author = "By | @4izfr",
    Folder = "game",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },
})
-- Main Section
local MainSection = Window:Section({Title = "•Main",Opened = true,})
local MainTab = MainSection:Tab({Title = "Home",Icon = "house",Locked = false,})
-- Main tab content
local Paragraph = Tab:Paragraph({
    Title = "Enjoy our script!",
    Desc = "",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Join our discord :3",
            Callback = setclipboard("kontolkau") end,
        }
    }
})