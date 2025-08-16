local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
  local Window = Rayfield:CreateWindow({
   Name = "Car Driving Indonesian Scripts",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Car Driving Indonesian Script",
   LoadingSubtitle = "By - X4 Hub",
   ShowText = "@X4 Hub", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "CDID Script Key",
      Subtitle = "You need a key to inject this script",
      Note = "Get the key in X4 HUB discord", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
  Rayfield:Notify({
   Title = "Thx For Using This Script",
   Content = "Have some fun with this script :)",
   Duration = 0.5,
   Image = 4483362458,
})
  local MainTab = Window:CreateTab("Main", false)-- Title, Image
  local Section = MainTab:CreateSection("Player")
  local Slider = MainTab:CreateSlider({
   Name = "Slider Example",
   Range = {0, 200},
   Increment = 10,
   Suffix = "Bananas",
   CurrentValue = 10,
   Flag = "Slider1", 
   Callback = function(Value)
   game.Player.LocalPlayer.Humanoid.WalkSpeed = (Value)
   end,
})
  local Button = Tab:CreateButton({
   Name = "Infinity Jump",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})
  local Toggle = Tab:CreateToggle({
   Name = "Toggle Example",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)

   end,
})
  
  
  if not game.PlaceId = then
    
