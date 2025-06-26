local EspTrinket = {}

local Meshes = {
    ["rbxassetid://5196776695"] = "Ring",
    ["rbxassetid://5204003946"] = "Goblet",
    ["rbxassetid://5196782997"] = "Old Ring",
    ["rbxassetid://5204453430"] = "Scroll",
    ["rbxassetid://5196551436"] = "Amulet",
    ["rbxassetid://5196577540"] = "Old Amulet",
    ["rbxassetid://4103271893"] = "Candy",
    ["rbxassetid://4027112893"] = "Bound Book"
}

local labels, artilabels = {}, {}
local TrinketEspColor = Color3.new(1, 1, 1)
local ArtifactEspColor = Color3.new(1, 1, 1)

local function WTS(pos)
    local cam = workspace.CurrentCamera
    local screenPos, visible = cam:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), visible, screenPos.Z
end

local function AddLabelToTable(label, isArtifact)
    table.insert(isArtifact and artilabels or labels, label)
end

local function GetLabelName(obj)
    local p = obj.Parent
    if p and p:IsA("Part") then
        -- LOST SUNSHINE (Simple color check)
    end
    local color = p.Color
    local mesh = p:FindFirstChildWhichIsA("SpecialMesh")
    local attachment = p:FindFirstChild("Attachment")
    local particle = p:FindFirstChildWhichIsA("ParticleEmitter", true)
    if p:IsA("Part") then
        return "Unregistered Artifact", true
    elseif p:IsA("UnionOperation") then
        if color == Color3.fromRGB(111, 113, 125) then return "Idol Of Forgotten", false end
    elseif p:IsA("MeshPart") then
    end
    if mesh and Meshes[mesh.MeshId] then
        return Meshes[mesh.MeshId], false
    end
    return nil
end

local function CreateESP(obj)
    local label = Drawing.new("Text")
    local bottom = Drawing.new("Text")
    local labelName, isArtifact = GetLabelName(obj)
    if not labelName then return end
    label.Text = labelName
    AddLabelToTable(label, isArtifact)
end

function EspTrinket.EnableESP()
    -- ESP enabling logic here
end

function EspTrinket.DisableESP()
    getgenv().ESPTOGGLE1 = false
end

function EspTrinket.SetTrinketColor(color)
    TrinketEspColor = color
end

function EspTrinket.SetArtifactColor(color)
    ArtifactEspColor = color
end

return EspTrinket
