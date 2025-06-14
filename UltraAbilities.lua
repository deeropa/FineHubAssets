local UltraAbilities = {}

UltraAbilities.UltraAbilitiesMap = {
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
    ["Puncture"] = "Vanguard"
}

function UltraAbilities.getUltraClass(player)
    for _, container in ipairs({player.Character, player:FindFirstChild("Backpack")}) do
        if container then
            for _, item in ipairs(container:GetChildren()) do
                local ultra = UltraAbilities.UltraAbilitiesMap[item.Name]
                if ultra then
                    return ultra
                end
            end
        end
    end
    return nil
end

return UltraAbilities
