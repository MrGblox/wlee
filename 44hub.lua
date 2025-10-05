local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44 HUB | UNIVERSAl",
    Icon = "earth",
    Author = "BY | 4izfr",
    Folder = "MySuperHub",

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
    
    User = {Enabled = true,Anonymous = false,Callback = function()print("clicked")end,},})
Window:Tag({
    Title = "v1.6.4",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 12, 
})
Window:Tag({
    Title = "v1.6.4",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 12, 
})
