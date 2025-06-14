local ColorModule = {}

local UltraClassModule = require(script.Parent.UltraClassModule) -- Adjust path as needed
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ColorModule.Colors = {
    Ultra = Color3.fromRGB(255, 0, 0),
    NoUltra = Color3.fromRGB(100, 100, 100),
    Illusionist = Color3.fromRGB(0, 170, 255),
    Yourself = Color3.fromRGB(0, 255, 0),
}

function ColorModule.GetLabelColor(player)
    if not player then
        return ColorModule.Colors.NoUltra
    elseif player == LocalPlayer then
        return ColorModule.Colors.Yourself
    else
        local ultraClass = UltraClassModule.GetUltraClass(player)
        if ultraClass == "Illusionist" then
            return ColorModule.Colors.Illusionist
        elseif ultraClass then
            return ColorModule.Colors.Ultra
        else
            return ColorModule.Colors.NoUltra
        end
    end
end

return ColorModule
