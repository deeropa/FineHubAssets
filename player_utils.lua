local PlayerUtils = {}

local UltraAbilities = {
    ["Lightning Drop"] = "Dragon Sage",
    ["Axe Kick"] = "Oni",
    ["Observe"] = "Illusionist",
    ["Perflora"] = "Druid",
    ["Secare"] = "Necromancer",
    ["Elegant Slash"] = "Whisperer",
    ["Joyous Dance"] = "Bard",
    ["Grapple"] = "Shinobi",
    ["Shadow Fan"] = "Faceless",
    ["Dragon Awakening"] = "Dragon Slayer",
    ["Chain Pull"] = "Deep Knight",
    ["Hyper Body"] = "Sigil Knight Commander",
    ["Dark Eruption"] = "Dark Sigil",
    ["Hammer"] = "Lapidarist",
    ["Katana"] = "Ronin",
    ["Abyssal Scream"] = "Abysswalker",
    ["Puncture"] = "Vanguard"
}

function PlayerUtils.getInv(player, invLabel)
    local itemCounts = {}
    pcall(function()
        if player.Character and player:FindFirstChild("Backpack") then
            local items = player.Backpack:GetChildren()
            for _, item in pairs(items) do
                if item:IsA("Tool") then
                    local itemName = item.Name
                    if itemCounts[itemName] then
                        itemCounts[itemName] = itemCounts[itemName] + 1
                    else
                        itemCounts[itemName] = 1
                    end
                end
            end
        end
    end)
    local content = "Items in Backpack: "
    for itemName, itemCount in pairs(itemCounts) do
        if itemCount > 1 then
            content = content .. itemCount .. "x " .. itemName .. ", "
        else
            content = content .. itemName .. ", "
        end
    end
    if invLabel then
        invLabel.Text = content
    end
    return content
end

function PlayerUtils.getPlayerClass(player)
    for ability, className in pairs(UltraAbilities) do
        if player.Character:FindFirstChild(ability) or (player.Backpack and player.Backpack:FindFirstChild(ability)) then
            return className
        end
    end
    return "N/A"
end

function PlayerUtils.showInv(plrName, Frame, user, Artifact, class, health, inv, previous_p)
    pcall(function()
        local player
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(plrName), "[^%w%s_]+", ""))) then
                player = v
                break
            end
        end
        if not player then return previous_p end
        if player == previous_p then
            Frame.Visible = false
            previous_p = nil
            return previous_p
        else
            if previous_p then
                Frame.Visible = false
            end
            Frame.Visible = true
        end
        user.Text = plrName
        local artifactText = "Artifacts: "
        if player.Character and player.Character:FindFirstChild("Artifacts") then
            for i, v in pairs(player.Character.Artifacts:GetChildren()) do
                artifactText = artifactText .. v.Name .. " "
            end
        end
        Artifact.Text = artifactText
        class.Text = "Class: " .. PlayerUtils.getPlayerClass(player)
        health.TextLabel.Text = math.floor(player.Character.Humanoid.Health) .. "/" .. math.floor(player.Character.Humanoid.MaxHealth)
        health.Frame.Size = UDim2.fromScale((player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth), 1)
        inv.Text = PlayerUtils.getInv(player, inv)
        previous_p = player
        return previous_p
    end)
    return previous_p
end

function PlayerUtils.spectate(plrName, Camera, Player, spectating)
    pcall(function()
        local player
        for _,v in pairs(game.Players:GetPlayers()) do
            if v.Character ~= nil and (string.lower(v.Character.Name) == string.lower(string.gsub(tostring(plrName),"[^%w%s_]+",""))) then
                player = v
                break
            end
        end
        if not player then return spectating end
        if not spectating then
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = player.Character.Humanoid
                spectating = true
            end
        else
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then 
                Camera.CameraSubject = Player.Character.Humanoid
                spectating = false
            end
        end
        return spectating
    end)
    return spectating
end

return PlayerUtils
