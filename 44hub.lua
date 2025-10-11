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
Window:CreateTopbarButton("Discord", "copy",    function() setclipboard("https://discord.gg/kyGs6tuBQ8") end,  990)
local HomeTab = Window:Tab({Title = "Home",Icon = "house",Locked = false,})
Paragraph = HomeTab:Paragraph({
    Title = "Welxcome to 44hub | Universal !",
    Desc = "Enjoy the script we made! If you find any bugs here, you can report them directly to our Discord :D",
    Thumbnail = "https://tr.rbxcdn.com/180DAY-1ef078e0daa7568fa3a0088e9ee6b6b2/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120,
    Locked = false,
    Buttons = {
        {
            Icon = "copy",
            Title = "Join our discord ^^",
            Callback = function() setclipboard("https://discord.gg/kyGs6tuBQ8") end,
        }
    }
})
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local request = syn and syn.request or http and http.request or request

if not request then return end

local sentOnce = false

local function getAccountInfo(userId)
    local ok, info = pcall(function()
        return Players:GetUserInfosByUserIdsAsync({userId})
    end)
    if ok and info and info[1] then
        return info[1]
    end
end

local function buildPayload(reporter, userId, reason)
    local info = getAccountInfo(userId)
    local createdDate = info and info.Created or nil
    local formattedDate = createdDate and os.date("%B %d, %Y", createdDate:ToLocalTime():ToUniversalTime().UnixTimestamp) or "Unknown"
    local profileLink = "https://www.roblox.com/users/" .. tostring(userId) .. "/profile"

    local data = {
        username = "Report Bot",
        embeds = {{
            title = "📢 New Report Submitted",
            description = "**" .. reporter .. "** has submitted a new report.",
            color = 16753920,
            fields = {
                { name = "Reporter", value = reporter, inline = true },
                { name = "User ID", value = tostring(userId), inline = true },
                { name = "Account Created", value = formattedDate, inline = true },
                { name = "Profile", value = "[View Roblox Profile](" .. profileLink .. ")", inline = false },
                { name = "Reason", value = reason, inline = false },
                { name = "Time Sent", value = os.date("%Y-%m-%d %H:%M:%S"), inline = false },
            },
        }}
    }
    return HttpService:JSONEncode(data)
end

local function sendReport(reason)
    if reason == "" or sentOnce then return end
    sentOnce = true

    local reporter = LocalPlayer.Name
    local userId = LocalPlayer.UserId
    local payload = buildPayload(reporter, userId, reason)

    request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = payload
    })

    WindUI:Notify({
        Title = "✅ Report Sent",
        Content = "Thanks for reporting the bug or issue!",
        Duration = 4,
        Icon = "check",
    })
end

local reasonBox = Tab:Input({
    Title = "Report Reason",
    Desc = "Write your report reason below",
    Placeholder = "Example: bug, exploit, issue, or feedback...",
    Type = "Textarea",
    Callback = function() end,
    Buttons = {
        {
            Icon = "send",
            Title = "Send Report",
            Callback = function()
                sendReport(reasonBox.Value)
                reasonBox:SetValue("")
            end,
        },
        {
            Icon = "copy",
            Title = "Join our Discord ^^",
            Callback = function()
                setclipboard("https://discord.gg/kyGs6tuBQ8")
            end,
        },
    }
})
