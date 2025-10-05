local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44 HUB | UNIVERSAL",
    Icon = "earth", -- lucide icon
    Author = "By | @4izfr",
    Folder = "44HUBONTOP",
    
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
Window:CreateTopbarButton({"Discord", "clipboard-paste", function() setclippboard("coming soon"),})
Window:Tag({Title = "Working",Color = Color3.fromHex("#01fb00"),Radius = 0,})
Window:Tag({Title = "Beta Version",Color = Color3.fromHex("#fbec00"),Radius = 0,})
WindUI:Notify({Title = "Welcome to the 44 HUB | UNIVERSAL",Content = "Thx for using our script, enjoy it :d",Duration = 120,Icon = "bell",})
-- Main Section
local MainSection = Window:Section({Title = "Main",Opened = true,})

-- Main Tabs
local HomeTab = Window:Tab({Title = "Home",Icon = "house",Locked = false,})
HomeTab:Paragraph({
    Title = "Welcome to 44 HUB | UNIVERSAL :D",
    Desc = "hopefully you like the script we created, if when you use this script you experience an error, you can report the bug to our discord, and you can also join our discord server to find friends or look for the script you want",
    Image = "smile",
    ImageSize = 20,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "external-link",
            Title = "Join our discord",
            Callback = function() setclippboard("coming soon") end,
        }
    }
})
