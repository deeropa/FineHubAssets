local ColorsModule = {}

function ColorsModule.createColorPickers(Tabs)
    local UltraColor = Tabs.EspTab:AddColorpicker("UltraColor", {
        Title = "Ultra ESP Color",
        Default = Color3.fromRGB(255, 0, 0)
    })
    UltraColor:SetValueRGB(Color3.fromRGB(255, 0, 0))

    local IllusionistColor = Tabs.EspTab:AddColorpicker("IllusionistColor", {
        Title = "Illusionist Color",
        Default = Color3.fromRGB(0, 170, 255)
    })
    IllusionistColor:SetValueRGB(Color3.fromRGB(0, 170, 255))

    local NoUltraColor = Tabs.EspTab:AddColorpicker("NoUltraColor", {
        Title = "No Ultra Color",
        Default = Color3.fromRGB(255, 255, 255)
    })
    NoUltraColor:SetValueRGB(Color3.fromRGB(255, 255, 255))

    local YourselfColor = Tabs.EspTab:AddColorpicker("YourselfColor", {
        Title = "Yourself Color",
        Default = Color3.fromRGB(0, 255, 0)
    })
    YourselfColor:SetValueRGB(Color3.fromRGB(0, 255, 0))

    return {
        UltraColor = UltraColor,
        IllusionistColor = IllusionistColor,
        NoUltraColor = NoUltraColor,
        YourselfColor = YourselfColor
    }
end

return ColorsModule
