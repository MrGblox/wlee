local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44 | Universal",
    Icon = "earth",
    Author = "By Someone",
    Folder = "44HubOnTop",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
   User = {Enabled = true, Anonymous = false, Callback = function() local player = game.Players.LocalPlayer local username = player.Name if setclipboard then setclipboard(username) WindUI:Notify({Title = "Copied!", Content = "your username has been copied!: " .. username, Duration = 3, Icon = "check"}) print("✅ Copied username:", username) else WindUI:Notify({Title = "fail", Content = "can't copy your username!", Duration = 3, Icon = "x"}) end end,}

})
-- home tab
local HomeTab = Window:Tab({Title = "Home",Icon = "house",Locked = false,})
local Paragraph = HomeTab:Paragraph({
    Title = "Paragraph with Image, Thumbnail, Buttons",
    Desc = "Test Paragraph",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "Button",
            Callback = function() print("1 Button") end,
        }
    }
})
