local NameMapModule = {}

local Players = game:GetService("Players")

local function getFakeName(player)
    local char = player.Character
    if not char then return nil end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChild("FakeHumanoid") and child:FindFirstChild("Head") then
            return child.Name
        end
    end
    return nil
end

function NameMapModule.BuildNameMap()
    local map = {}
    for _, player in ipairs(Players:GetPlayers()) do
        map[player.Name] = player
        map[player.DisplayName] = player
        local fake = getFakeName(player)
        if fake then
            map[fake] = player
        end
    end
    return map
end

return NameMapModule
