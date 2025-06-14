local ColorsModule = {}

function ColorsModule.createColorPickers(Tabs)
    local colors = {}

    colors.UltraColor = Tabs.EspTab:AddColorpicker("UltraColor", {
        Title = "Ultra ESP Color",
        Default = Color3.fromRGB(255, 0, 0)
    })
    colors.UltraColor:SetValueRGB(Color3.fromRGB(255, 0, 0))

    colors.IllusionistColor = Tabs.EspTab:AddColorpicker("IllusionistColor", {
        Title = "Illusionist Color",
        Default = Color3.fromRGB(0, 170, 255)
    })
    colors.IllusionistColor:SetValueRGB(Color3.fromRGB(0, 170, 255))

    colors.NoUltraColor = Tabs.EspTab:AddColorpicker("NoUltraColor", {
        Title = "No Ultra Color",
        Default = Color3.fromRGB(255, 255, 255)
    })
    colors.NoUltraColor:SetValueRGB(Color3.fromRGB(255, 255, 255))

    colors.YourselfColor = Tabs.EspTab:AddColorpicker("YourselfColor", {
        Title = "Yourself Color",
        Default = Color3.fromRGB(0, 255, 0)
    })
    colors.YourselfColor:SetValueRGB(Color3.fromRGB(0, 255, 0))

    return colors
end

return ColorsModule
