local ArtifactNotify = {}

local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local Drawing = Drawing
local foundParts = {}
local activeNotifs = {}

local SoundID = getcustomasset("FineHubAssets/Artifactnotfication.mp3")

local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = SoundID
    sound.Volume = 2.5
    sound.Parent = Workspace
    sound:Play()
    Debris:AddItem(sound, 5)
end

local function showNotification(name)
    local fullText = "Artifact Found: " .. name
    local label = Drawing.new("Text")
    local bgBox = Drawing.new("Square")

    label.Text = fullText
    label.Size = 20
    label.Color = Color3.fromRGB(255, 255, 255)
    label.Outline = true
    label.Font = 2
    label.ZIndex = 2
    label.Visible = true

    bgBox.Filled = true
    bgBox.Color = Color3.fromRGB(57, 57, 57)
    bgBox.ZIndex = 1
    bgBox.Visible = true

    task.wait()
    local textSize = label.TextBounds
    local padding = 10
    local totalHeight = 30
    local totalWidth = textSize.X + padding * 2
    local baseX = 10
    local baseY = 90 + (#activeNotifs * (totalHeight + 5))

    bgBox.Size = Vector2.new(totalWidth, totalHeight)
    bgBox.Position = Vector2.new(baseX, baseY)
    label.Position = Vector2.new(baseX + padding, baseY + 2)

    table.insert(activeNotifs, {bg = bgBox, text = label})

    playSound()

    for i = 0, 1, 0.05 do
        bgBox.Transparency = 0.85 * i
        label.Transparency = i
        task.wait(0.02)
    end

    task.wait(5)

    for i = 1, 0, -0.05 do
        bgBox.Transparency = 0.85 * i
        label.Transparency = i
        task.wait(0.02)
    end

    bgBox:Remove()
    label:Remove()

    for i, notif in ipairs(activeNotifs) do
        if notif.text == label then
            table.remove(activeNotifs, i)
            break
        end
    end

    for i, notif in ipairs(activeNotifs) do
        local newY = 90 + ((i - 1) * (totalHeight + 5))
        notif.bg.Position = Vector2.new(baseX, newY)
        notif.text.Position = Vector2.new(baseX + padding, newY + 2)
    end
end

local function GetLabelName(obj)
    local p = obj.Parent
    if not p or not p:IsA("Part") then return nil end

    local color = p.Color
    local attachment = p:FindFirstChild("Attachment")
    local particle = p:FindFirstChildWhichIsA("ParticleEmitter", true)

    if p:IsA("Part") then
        if color == Color3.fromRGB(128, 187, 219) then return "Fairfrozen", true end

        if p:FindFirstChild("OrbParticle") and p.OrbParticle.Texture == "rbxassetid://20443483" then
            return "Ice Essence", true
        end

        if particle and particle.Color and particle.Color.Keypoints and particle.Color.Keypoints[1].Value == Color3.new(1, 0.8, 0) then
            return "Phoenix Down", true
        end

        if attachment and attachment:FindFirstChild("ParticleEmitter") then
            local pe = attachment.ParticleEmitter
            if pe.Texture == "rbxassetid://1536547385" then
                if game.PlaceId == 3541987450 then return "Phoenix Flower", true end
                if pe.Color.Keypoints and pe.Color.Keypoints[1].Value == Color3.new(0, 1, 0.207843) then
                    return "Azael Horn", true
                end
                return "Mysterious Artifact", true
            end
        end

    elseif p:IsA("UnionOperation") then
        if color == Color3.fromRGB(248, 248, 248) and not p.UsePartColor then return "Lannis Amulet", true end
        if color == Color3.fromRGB(29, 46, 58) then return "Night Stone", true end
        if color == Color3.fromRGB(163, 162, 165) then return "Amulet Of The White King", true end
    end

    return nil
end

local function checkPartForArtifact(obj)
    if foundParts[obj] then return end
    local success, name, isArtifact = pcall(GetLabelName, obj)
    if success and name then
        foundParts[obj] = true
        task.spawn(function()
            showNotification(name)
        end)
    end
end

local function scanExistingParts()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if not (Workspace:FindFirstChild("Thrown") and obj:IsDescendantOf(Workspace.Thrown)) then
                checkPartForArtifact(obj)
            end
        end
    end
end

function ArtifactNotify.Init()
    task.spawn(function()
        repeat task.wait() until game.Players.LocalPlayer and Workspace.CurrentCamera
        task.wait(2)
        scanExistingParts()
    end)

    Workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if not (Workspace:FindFirstChild("Thrown") and obj:IsDescendantOf(Workspace.Thrown)) then
                checkPartForArtifact(obj)
            end
        end
    end)
end

return ArtifactNotify
