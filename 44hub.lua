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
-- Wind UI -> Report to Discord Webhook (executor-friendly)
-- Ganti WEBHOOK_URL dengan webhook Discord kamu
local WEBHOOK_URL = "https://discord.com/api/webhooks/...." -- <-- ganti di sini
local COOLDOWN = 20 -- detik antara laporan supaya tidak spam

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

-- simple rate limit
local lastSent = 0

-- build payload (Discord embed)
local function buildPayload(playerName, playerId, bugText)
    local embed = {
        title = "New Script Bug Report",
        color = 15277667,
        fields = {
            { name = "Player", value = playerName .. " (ID: "..tostring(playerId)..")", inline = true },
            { name = "PlaceId", value = tostring(game.PlaceId or "unknown"), inline = true },
            { name = "Time (UTC)", value = os.date("!%Y-%m-%d %H:%M:%S UTC", os.time()), inline = false },
            { name = "Bug Description", value = bugText, inline = false },
        }
    }
    local payload = {
        username = "Script Reports",
        embeds = { embed }
    }
    return HttpService:JSONEncode(payload)
end

-- Try multiple executor http functions. Returns (ok, err)
local function trySend(url, body)
    -- synapse
    if syn and syn.request then
        local ok, res = pcall(function()
            return syn.request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
        if ok and res and (res.Status == 200 or res.Status == 204) then
            return true
        else
            return false, ("syn.request failed: %s"):format(tostring(res and res.Body or res))
        end
    end

    -- krnl / some others: request
    if request then
        local ok, res = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
        if ok and res and (res.StatusCode == 200 or res.StatusCode == 204 or res.status == 200) then
            return true
        else
            return false, ("request failed: %s"):format(tostring(res and (res.Body or res) or res))
        end
    end

    -- older http_request name
    if http_request then
        local ok, res = pcall(function()
            return http_request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
        if ok and res and (res.StatusCode == 200 or res.StatusCode == 204 or res.status == 200) then
            return true
        else
            return false, ("http_request failed: %s"):format(tostring(res and (res.Body or res) or res))
        end
    end

    -- fluxus-style (http.request)
    if http and http.request then
        local ok, res = pcall(function()
            return http.request({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
        if ok and res and (res.Success or res.success or res.Status == 200 or res.StatusCode == 200) then
            return true
        else
            return false, ("http.request failed: %s"):format(tostring(res and (res.Body or res) or res))
        end
    end

    -- last resort: try HttpService (only works if environment allows client PostAsync)
    local ok, res = pcall(function()
        return HttpService:PostAsync(url, body, Enum.HttpContentType.ApplicationJson)
    end)
    if ok then
        return true
    else
        return false, ("HttpService:PostAsync failed: %s"):format(tostring(res))
    end
end

-- main send function (handles cooldown & returns success,bool)
local function sendReportToWebhook(bugText)
    if not WEBHOOK_URL or WEBHOOK_URL == "" then
        return false, "Webhook URL not set"
    end
    local now = os.time()
    if now - lastSent < COOLDOWN then
        return false, ("Cooldown: please wait %d more second(s)"):format(COOLDOWN - (now - lastSent))
    end
    lastSent = now

    local playerName = localPlayer and localPlayer.Name or "Unknown"
    local playerId = localPlayer and localPlayer.UserId or 0
    local safeText = tostring(bugText):gsub("```", "`\u200b``") -- avoid triple backtick abuse
    local body = buildPayload(playerName, playerId, safeText)

    local ok, err = trySend(WEBHOOK_URL, body)
    if ok then
        return true
    else
        return false, err or "Unknown error sending webhook"
    end
end

local Input = HomeTab:Input({
    Title = "Laporkan Bug",
    Desc = "Jelaskan bug yang ditemukan. (ID kamu otomatis terlampir)",
    Value = "",
    InputIcon = "bird",
    Type = "Textarea",
    Placeholder = "Contoh: Lokasi: Spawn, Step: 3, Error: nil reference...",
    Callback = function(input)
        -- basic validation
        if not input or tostring(input):match("^%s*$") then
            -- kamu bisa tunjukin notifikasi Wind UI; di sini pake print
            print("Isi laporan terlebih dahulu.")
            return
        end

        -- kirim
        local ok, err = sendReportToWebhook(input)
        if ok then
            -- notifikasi sukses (ganti dengan notifier Wind UI jika ada)
            print("Laporan terkirim, terima kasih.")
        else
            print("Gagal kirim laporan:", err)
            -- fallback: tampilkan dialog / copy ke clipboard (tergantung executor)
        end
    end
})