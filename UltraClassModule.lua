local UltraClassModule = {}

local UltraAbilities = {
    ["Lightning Drop"] = "Dragon Sage",
    ["Axe Kick"] = "Oni",
    ["Observe"] = "Illusionist",
    ["Verdien"] = "Druid",
    ["Howler"] = "Necromancer",
    ["Elegant Slash"] = "Whisperer",
    ["Joyous Dance"] = "Bard",
    ["Grapple"] = "Shinobi",
    ["Shadow Fan"] = "Faceless",
    ["Dragon Awakening"] = "Dragon Slayer",
    ["Chain Pull"] = "Deep Knight",
    ["Hyper Body"] = "Sigil Knight Commander",
    ["Dark Flame Burst"] = "Dark Sigil",
    ["Grindstone"] = "Lapidarist",
    ["Swallow Reversal"] = "Ronin",
    ["Abyssal Scream"] = "Abysswalker",
    ["Puncture"] = "Vanguard",
}

function UltraClassModule.GetUltraClass(player)
    local containers = {player.Character, player:FindFirstChild("Backpack")}
    for _, container in ipairs(containers) do
        if container then
            for _, item in ipairs(container:GetChildren()) do
                if UltraAbilities[item.Name] then
                    return UltraAbilities[item.Name]
                end
            end
        end
    end
    return nil
end

return UltraClassModule
