local FluentUI = {}

function FluentUI.Init()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    local Window = Fluent:CreateWindow({
        Title = "KIKI Hub V.2.0",
        SubTitle = "By KIKI, Wowzers, BloxyHDD",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = false,
        Theme = "Amethyst",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    local Tabs = {
        GeneralTab = Window:AddTab({ Title = "Main", Icon = "" }),
        PlayerTab = Window:AddTab({ Title = "Player", Icon = "" }),
        RageTab = Window:AddTab({ Title = "Blatant", Icon = "" }),
        EspTab = Window:AddTab({ Title = "Trinket & Esp", Icon = "" }),
        MiscTab = Window:AddTab({ Title = "Miscellaneous", Icon = "" }),
        BotsTab = Window:AddTab({ Title = "Bots", Icon = "" }),
        AutomationTab = Window:AddTab({ Title = "Automation", Icon = "" }),
        ExploitsTab = Window:AddTab({ Title = "Exploits", Icon = "" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
    }
    return {
        Fluent = Fluent,
        SaveManager = SaveManager,
        InterfaceManager = InterfaceManager,
        Window = Window,
        Tabs = Tabs
    }
end

return FluentUI
