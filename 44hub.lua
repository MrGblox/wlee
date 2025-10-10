local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "44Hub | Universal",
    Icon = "earth",
    Author = "By | Someone",
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
Window:CreateTopbarButton("Discord", "copy",    function() setclipboard("discord.gg") end,  990)
local HomeTab = Window:Tab({Title = "Home",Icon = "house",Locked = false,})
local Paragraph = HomeTab:Paragraph({
    Title = "Welxcome to 44hub | Universal !",
    Desc = "Enjoy the script we made! If you find any bugs here, you can report them directly to our Discord :D",
    Image = "smile",
    ImageSize = 25,
    Thumbnail = "https://tr.rbxcdn.com/180DAY-1ef078e0daa7568fa3a0088e9ee6b6b2/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120,
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Join our discord ^^",
            Callback = function() setclipboard("discord.gg") end,
        }
    }
})
