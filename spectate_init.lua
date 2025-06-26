local SpectateInit = {}
local PlayerUtils = require(script.Parent.player_utils)

function SpectateInit.initSpectate(Frame, Camera, Player)
    local spectating = false
    local function Spectate(plrName)
        spectating = PlayerUtils.spectate(plrName, Camera, Player, spectating)
    end
    local function init2()
        pcall(function()
            local objects = Frame:GetChildren();
            for _, obj in pairs(objects) do
                if obj:FindFirstChild("spec") then
                    obj:FindFirstChild("spec"):Destroy()
                end
            end
        end)
    end
    local function init(showInv)
        pcall(function()
            local objects = Frame:GetChildren();
            for _, ch in pairs(game.Workspace.Live:GetChildren()) do
                ch.Archivable = true
            end
            for _, obj in pairs(objects) do
                if obj:IsA("TextLabel") then
                    if not obj:FindFirstChild("spec") then
                        local btn = Instance.new("TextButton", obj)
                        btn.Size = UDim2.new(1,0,1,0)
                        btn.BackgroundTransparency = 1
                        btn.Text = ""
                        btn.Name = "spec"
                        btn.MouseButton2Click:Connect(function()
                            local plrName = btn.Parent.Text
                            plrName = plrName:gsub("%s+", "")
                            Spectate(plrName)
                        end)
                        btn.MouseButton1Click:Connect(function()
                            local plrName = btn.Parent.Text
                            plrName = plrName:gsub("%s+", "")
                            showInv(plrName)
                        end)
                    end
                end
            end
        end)
    end
    return {
        Spectate = Spectate,
        init2 = init2,
        init = init
    }
end

return SpectateInit
