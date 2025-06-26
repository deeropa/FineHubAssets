local AntiCheatBypass = {}

function AntiCheatBypass.Init()
    if not LPH_OBFUSCATED then
        LPH_NO_VIRTUALIZE = function(...) return ... end;
    end
    LPH_NO_VIRTUALIZE(function()
        local lp = game:GetService("Players").LocalPlayer
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local success,err = pcall(function()
            repeat task.wait() until lp.Character
            local RunService = game:GetService("RunService");
            local scriptContextError = game:GetService("ScriptContext").Error
            local call;
            for i, v in next, getconnections(scriptContextError) do
                v:Disable();
            end
            call = hookmetamethod(game,'__namecall', newcclosure(function(Self,...)
                if not checkcaller() then
                    local method = getnamecallmethod();
                    local args = {...}
                    if Self == RunService and method == 'IsStudio' then
                        return true;
                    end;
                    if Self == scriptContextError and method == 'Connect' then
                        return coroutine.yield();
                    end    
                end
                return call(Self,...)
            end));
            local OldCoroutineWrap
            OldCoroutineWrap = hookfunction(coroutine.wrap, function(Self, ...)
                if not checkcaller() then
                    if debug.getinfo(Self).source:match("Input") then
                        local args = {...};
                        local constants = getconstants(Self);
                        if constants[5] and typeof(constants[5]) == "string" and constants[5]:match("CHECK PASSED:") then
                            return OldCoroutineWrap(Self, ...);
                        end
                        if constants[1] and typeof(constants[1]) == "string" and constants[2] and typeof(constants[2]) == "string"  and (constants[1]:match("scr") and constants[2]:match("Parent")) then
                            game:GetService("Players").LocalPlayer:Kick("KIKI Hub Ban Prevented (You can rejoin)");
                            return coroutine.yield();
                        end
                    end
                end
                return OldCoroutineWrap(Self, ...)
            end)
            getgenv().SAntiCheatBypass = true
        end)
        if not success then
            lp:Kick("Failed to Disable Anti-Cheat please rejoin");
            warn(success,err);
            return;
        end
    end)();
    -- Ban and Analytics hooks
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local namecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" and tostring(self) == "Ban" then
           return
        end
        return namecall(self, table.unpack(args))
    end)
    -- Analytics
    local mt2 = getrawmetatable(game)
    setreadonly(mt2, false)
    local namecall2 = mt2.__namecall
    mt2.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" and tostring(self) == "ReportGoogleAnalyticsEvent" then
           return
        end
        return namecall2(self, table.unpack(args))
    end)
    -- ScriptContext and LogService disables
    local scriptContext = game:GetService("ScriptContext")
    local logService = game:GetService("LogService")
    if not isfolder("KikiHubPaths") then 
        makefolder("KikiHubPaths")
    end
    if not isfolder("KikiHubAssets") then 
        makefolder("KikiHubAssets")
        writefile("KikiHubAssets/ModeratorJoin.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/ModeratorJoin.mp3"))
        writefile("KikiHubAssets/IlluJoin.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/IlluJoin.mp3"))
        writefile("KikiHubAssets/ObserveEquip.mp3", game:HttpGet("https://github.com/KIKISQQ/gu/raw/main/ObserveEquip.mp3"))
    end
    for _, connection in pairs(getconnections(scriptContext.Error)) do
        connection:Disable()
    end
    for _, connection in pairs(getconnections(logService.MessageOut)) do
        connection:Disable()
    end
    local function errorHandler(message, trace)
        local amongus = trace or "haha he tried it"
        print(message.." "..amongus)
    end
    scriptContext.Error:Connect(errorHandler)
end

return AntiCheatBypass
