local UltraAbilities = {}

UltraAbilities.List = {
    ["Lightning Drop"] = "Dragon Sage",
    ["Axe Kick"] = "Oni",
    ["Observe"] = "Illusionist",
    -- etc
}

function UltraAbilities.getUltraClass(player)
    for _, container in ipairs({player.Character, player:FindFirstChild("Backpack")}) do
        if container then
            for _, item in ipairs(container:GetChildren()) do
                local ultra = UltraAbilities.List[item.Name]
                if ultra then
                    return ultra
                end
            end
        end
    end
    return nil
end

function UltraAbilities.getFakeName(player)
    if not player.Character then return nil end
    for _, child in ipairs(player.Character:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChild("FakeHumanoid") and child:FindFirstChild("Head") then
            return child.Name
        end
    end
    return nil
end

return UltraAbilities
