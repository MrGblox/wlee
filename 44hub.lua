local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44 Universal Hub",
    Icon = "earth",
    Author = "By | 4izfr",
    Folder = "cowoganteng",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    ScrollBarEnabled = false,
    
    User = {
        Enabled = true,
        Callback = function()
            print("clicked")
        end,
    },
})
local MainSection = Window:Section({Title = "- Main",Opened = true,})
-- HomeTab
local HomeTab = MainSection:Tab({Title = "home",Icon = "house",Locked = false,})
-- home tab contents 
HomeTab:Paragraph({
    Title = "Welcome to our universal script",
    Desc = "I hope those of you who use our script like our script, if there is a problem with this script, you can join our discord server to report any bugs that occur.",
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "join our discord :d",
            Callback = setclipboard("https://discord.gg/44hub") end,
        }
    }
})

