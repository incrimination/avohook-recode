t1 = game.Workspace.Players:GetChildren()[1]
t2 = game.Workspace.Players:GetChildren()[2]

local devmode = true

local avohook = {
    Username = devmode and "admin" or "user1",
    Build = devmode and 'developer' or 'live',
}

local Config = {
    Aimbot = {
        trigger = {
            enabled = false,
            hsonly = false,
        },
        master = {
            enabled = false,
            hitboxselection = 'head',
            fov = 30,
            circle = false,
        }
    },

    Visuals = {
        chams = {
            enabled = false,
            ccolor = Color3.new(1, 1, 1),
            chosenteam = '1',
            vischeck = false,
            enablecc = false,
            ocolor = Color3.fromRGB(255, 255, 255),
            outline = false,
        },
        lplr = {
            rsleeves = false,
            rgloves = false,
            onehand = false,
            ach = false,
            armchams = 'neon',
            armcolor = Color3.fromRGB(255, 255, 255),
        },
        world = {
            ambient = {
                enabled = false,
                color = Color3.fromRGB(255, 255 ,255),
            },
            outdoor = {
                enabled = false,
                time = 12,
            },
            fog = {
                enabled = false,
                fogstart = 0,
                fogend = 5000,
                color = Color3.fromRGB(255, 255, 255),
            },
        },
    },

    misc = {
        hitsound = {
            chosensound = 'gamesense',
            hsvol = 1,
            hsound = false,
        },
        movement = {
            flyhack = {
                master = false,
                flyingspeed = 25,
                keybind = false,
                flying = false,
            },
            speedhack = {
                master = false,
                amount = 5,
            }
        },
        random = {
            keybinds = {
                enabled = false,
            },
            antivotekick = {
                enabled = false,
            },
        },
    },

    config = {

    },
        
}

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'avohook recode (user: ' .. avohook.Username .. ", build: " .. avohook.Build .. ')',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    aimbot = Window:AddTab('aimbot'),
    visuals = Window:AddTab('visuals'),
    misc = Window:AddTab('misc'),
    config = Window:AddTab('config'),
}

local aimbottabbox = Tabs.aimbot:AddLeftTabbox('aimbottabbox')

local ragetab = aimbottabbox:AddTab('rage')

ragetab:AddToggle('aimbot', {
    Text = 'aimbot [buggy]',
    Default = false, -- Default value (true / false)
    Tooltip = 'aimbot module', -- Information shown when you hover over the toggle

    Callback = function(Value)
        Config.Aimbot.master.enabled = Value
    end
})

ragetab:AddDropdown('hitboxes', {
    Values = { 'head', 'all' },
    Default = 1, 
    Multi = false, 

    Text = 'hitbox selection',
    Tooltip = 'selected target hitbox for the aimbot', 

    Callback = function(Value)
        Config.Aimbot.master.hitboxselection = Value
    end
})

local legittab = aimbottabbox:AddTab('legit')

legittab:AddToggle('triggerbot', {
    Text = 'triggerbot',
    Default = false, 
    Tooltip = 'triggerbot module (shoots for you)', 

    Callback = function(Value)
        Config.Aimbot.trigger.enabled = Value
    end
})

local chamstab = Tabs.visuals:AddLeftGroupbox('chams')
local localtab = Tabs.visuals:AddLeftGroupbox('local')
local worldtab = Tabs.visuals:AddRightGroupbox('world')

chamstab:AddToggle('chams', {
    Text = 'enable chams',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.chams.enabled = Value
        Config.Visuals.chams.enablecc = Value
    end
}):AddColorPicker('chamscolor', {
    Default = Color3.new(1, 1, 1), 
    Title = 'chams colorpicker',
    Transparency = 1, 

    Callback = function(Value)
        Config.Visuals.chams.ccolor = Value
    end
})

Options.chamscolor:SetValueRGB(Color3.fromRGB(255, 255, 255))

chamstab:AddToggle('outline', {
    Text = 'glow',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.chams.outline = Value
    end
}):AddColorPicker('outlinecolor', {
    Default = Color3.new(1, 1, 1), 
    Title = 'glow colorpicker',
    Transparency = 1, 

    Callback = function(Value)
        Config.Visuals.chams.ocolor = Value
    end
})

chamstab:AddToggle('vischeck', {
    Text = 'visible check',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.chams.vischeck = Value
    end
})

localtab:AddToggle('remove', {
    Text = 'remove sleeves',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.lplr.rsleeves = Value
    end
})

localtab:AddToggle('gloves', {
    Text = 'remove gloves',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.lplr.rgloves = Value
    end
})

localtab:AddToggle('armremover', {
    Text = 'one handed',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.lplr.onehand = Value
    end
})

localtab:AddToggle('armss', {
    Text = 'arm chams',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.lplr.ach = Value
    end
}):AddColorPicker('armcolor', {
    Default = Color3.new(1, 1, 1), 
    Title = 'arm colorpicker',
    Transparency = 1, 

    Callback = function(Value)
        Config.Visuals.lplr.armcolor = Value
    end
})

localtab:AddDropdown('armmat', {
    Values = { 'neon', 'ghost' },
    Default = 1, 
    Multi = false, 

    Text = 'cham type',

    Callback = function(Value)
        Config.Visuals.lplr.armchams = Value
    end
})

Options.armcolor:SetValueRGB(Color3.fromRGB(255, 255, 255))

worldtab:AddToggle('ambient', {
    Text = 'nightmode',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.world.ambient.enabled = Value
    end
}):AddColorPicker('ambientcolor', {
    Default = Color3.new(1, 1, 1), 
    Title = 'ambience colorpicker',
    Transparency = 1, 

    Callback = function(Value)
        Config.Visuals.world.ambient.color = Value
    end
})

Options.ambientcolor:SetValueRGB(Color3.fromRGB(255, 255, 255))

worldtab:AddToggle('fog', {
    Text = 'fog',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.world.fog.enabled = Value
    end
}):AddColorPicker('fogcolor', {
    Default = Color3.new(1, 1, 1), 
    Title = 'fog colorpicker',
    Transparency = 1, 

    Callback = function(Value)
        Config.Visuals.world.fog.color = Value
    end
})

worldtab:AddSlider('fogend', {
    Text = 'end',
    Default = 5000,
    Min = 0,
    Max = 10000,
    Rounding = 50,
    Compact = false,

    Callback = function(Value)
        Config.Visuals.world.fog.fogend = Value
    end
})

worldtab:AddSlider('fogstart', {
    Text = 'start',
    Default = 0,
    Min = 0,
    Max = 10000,
    Rounding = 50,
    Compact = false,

    Callback = function(Value)
        Config.Visuals.world.fog.fogstart = Value
    end
})

worldtab:AddToggle('time', {
    Text = 'time changer',
    Default = false, 

    Callback = function(Value)
        Config.Visuals.world.outdoor.enabled = Value
    end
})

worldtab:AddSlider('timeslider', {
    Text = 'end',
    Default = 12,
    Min = 0,
    Max = 24,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        Config.Visuals.world.outdoor.time = Value
    end
})

local misctab = Tabs.misc:AddLeftGroupbox('targeting')

misctab:AddDropdown('team', {
    Values = { '1', '2' },
    Default = 1, 
    Multi = false, 

    Text = 'team selection',
    Tooltip = 'selected target team for the aimbot and triggerbot', 

    Callback = function(Value)
        Config.Visuals.chams.enabled = not Config.Visuals.chams.enabled
        wait()
        Config.Visuals.chams.chosenteam = Value
        Config.Visuals.chams.enabled = not Config.Visuals.chams.enabled
    end
})

local movementtab = Tabs.misc:AddRightGroupbox('movement')

if devmode then
    movementtab:AddToggle('flyhack', {
        Text = 'flyhack [dev only]',
        Default = false, 

        Callback = function(Value)
            Config.misc.movement.flyhack.master = Value
        end
    }):AddKeyPicker('KeyPicker', {
    
        Default = 'End', 
        SyncToggleState = false,
    
        Mode = 'Toggle',
    
        Text = 'flyin on dem niggas', 
        NoUI = false, 
    
        Callback = function(Value)
            Config.misc.movement.flyhack.flying = not Config.misc.movement.flyhack.flying
        end,
    
        ChangedCallback = function(New)
            Library:Notify(string.format('[avohook] keybind for flyhack changed to ' .. tostring(New)))
        end
    })

    movementtab:AddSlider('flyspeed', {
        Text = 'flyhack speed',
        Default = 25,
        Min = 0,
        Max = 50,
        Rounding = 1,
        Compact = false,

        Callback = function(Value)
            Config.misc.movement.flyhack.flyingspeed = Value
        end
    })

    --[[Options.KeyPicker:OnClick(function()
        Config.misc.movement.flyhack.flying = Options.KeyPicker:GetState()
    end)]]

end

movementtab:AddToggle('speedhack', {
    Text = 'speedhack',
    Default = false, 

    Callback = function(Value)
        Config.misc.movement.speedhack.master = Value
    end
})

movementtab:AddSlider('speeeedd', {
    Text = 'speedhack speed',
    Default = 5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        Config.misc.movement.speedhack.amount = Value
    end
})

local randomtab = Tabs.misc:AddLeftGroupbox('settings')

randomtab:AddToggle('antivk', {
    Text = 'anti votekick [broken atm]',
    Default = false, 

    Callback = function(Value)
        Config.misc.random.antivotekick.enabled = Value
    end
})

randomtab:AddToggle('keybinds', {
    Text = 'keybind list',
    Default = false, 

    Callback = function(Value)
        Config.misc.random.keybinds.enabled = Value
        if Config.misc.random.keybinds.enabled then
            Library.KeybindFrame.Visible = true
        else
            Library.KeybindFrame.Visible = false
        end
    end
})

Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('avohook (' .. avohook.Build .. ') | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    Library.Unloaded = true
end)

local MenuGroup = Tabs.config:AddLeftGroupbox('menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind 

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('avohook')
SaveManager:SetFolder('avohook/cfg')
SaveManager:BuildConfigSection(Tabs.config)
ThemeManager:ApplyToTab(Tabs.config)
SaveManager:LoadAutoloadConfig()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local HudScreenGui = LocalPlayer.PlayerGui.HudScreenGui
local Main = HudScreenGui.Main
local ImageHitmarker = Main:FindFirstChild("ImageHitmarker")

local function arewedeadass()
    if targetteam then
        for i,v in targetteam:GetDescendants() do
            if Config.Visuals.chams.enabled then
                if v.ClassName == "Model" then
                    if v:FindFirstChild("Highlight") then
                        if Config.Visuals.chams.enablecc then 
                            v.Highlight.FillColor = Config.Visuals.chams.ccolor
                        end
                        if Config.Visuals.chams.outline then
                            v.Highlight.OutlineTransparency = 0
                            v.Highlight.OutlineColor = Config.Visuals.chams.ocolor
                        else
                            v.Highlight.OutlineTransparency = 1
                        end
                        if Config.Visuals.chams.vischeck then
                            v.Highlight.DepthMode = "Occluded"
                        else
                            v.Highlight.DepthMode = "AlwaysOnTop"
                        end
                    else
                        local hl = Instance.new("Highlight", v)
                        if Config.Visuals.chams.outline then
                            hl.OutlineTransparency = 0
                            hl.OutlineColor = Config.Visuals.chams.ocolor
                        else
                            hl.OutlineTransparency = 1
                        end
                        if Config.Visuals.chams.enablecc then 
                            hl.FillColor = Config.Visuals.chams.ccolor
                        end
                        if Config.Visuals.chams.vischeck then
                            hl.DepthMode = "Occluded"
                        else hl.DepthMode = "AlwaysOnTop"
                        end
                    end 
                end
            else
                if v:FindFirstChild("Highlight") then
                    v.Highlight:Destroy()
                end
            end
        end
    end
end

local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
local function viewmodel()
    if Config.Visuals.lplr.ach then 
        if Config.Visuals.lplr.armchams == 'neon' then
            for i,v in cam:GetDescendants() do
                if v:FindFirstChild("SkinTone") then
                    v.SkinTone.Material = "Neon"
                    v.SkinTone.Color = Config.Visuals.lplr.armcolor
                    v.SkinTone.TextureID = ''
                    if v.SkinTone:FindFirstChild("Highlight") then
                        v.SkinTone.Highlight:Destroy()
                    end
                end
            end
        elseif Config.Visuals.lplr.armchams == 'ghost' then
            for i,v in cam:GetDescendants() do
                if v:FindFirstChild("SkinTone") then
                    v.SkinTone.Material = "ForceField"
                    v.SkinTone.Color = Config.Visuals.lplr.armcolor
                    v.SkinTone.TextureID = 'rbxassetid://3232760968'
                end
            end
        end
    else 
        for i,v in cam:GetDescendants() do
            if v:FindFirstChild("SkinTone") then
                v.SkinTone.Material = 'SmoothPlastic'
                v.SkinTone.Color = Color3.fromRGB(255, 204, 153)
                v.SkinTone.TextureID = ''
            end
        end
    end
end

local function gloveremover()
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    for i,v in cam:GetDescendants() do
        if v:FindFirstChild("Part") then
            for i2, v2 in v:GetChildren() do
                if Config.Visuals.lplr.rgloves then
                    v.Part:Destroy()
                end
            end
        end
    end
end

local function sleeveremover()
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    for i,v in cam:GetDescendants() do
        if v:FindFirstChild("Sleeves") then
            if Config.Visuals.lplr.rsleeves then
                v.Sleeves:Destroy()
            end
        end
    end
end

local function onehanded()
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    for i,v in cam:GetChildren() do
        if v:FindFirstChild("Arm") then
            if Config.Visuals.lplr.onehand and cam:GetChildren()[4] then 
                v:Destroy()
            end
        end
    end
end

local Mouse = LocalPlayer:GetMouse()

local function tb()
    if targetteam and Config.Aimbot.trigger.enabled then
        for i,v in targetteam:GetDescendants() do
            if Config.Aimbot.trigger.enabled then
                if v.ClassName == "Model" then
                    local target = Mouse.Target
                    if target then
                        for _, part in v:GetChildren() do
                            if target == part then
                                if Config.Aimbot.trigger.hsonly and part:FindFirstChildWhichIsA("Decal") then
                                    local VirtualInputManager = game:GetService("VirtualInputManager")
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                    wait(0.5)
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                else
                                    local VirtualInputManager = game:GetService("VirtualInputManager")
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                    wait(0.5)
                                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

local function headhitboxes()
    local head
    local helmet
    if targetteam then
        for i,v in targetteam:GetDescendants() do
            if v.ClassName == "Model" and v:FindFirstChildWhichIsA("Part") then
                local player = v
                local part = player:FindFirstChildWhichIsA("Part")
                if part:FindFirstChildWhichIsA("Decal") then
                    head = part
                end
                if v and v:FindFirstChildWhichIsA("Folder") then
                    local helmetfolder = v:FindFirstChildWhichIsA("Folder")
                    if helmetfolder:FindFirstChildWhichIsA("MeshPart") then
                        helmet = helmetfolder:FindFirstChildWhichIsA("MeshPart")
                    end
                end
            end
        end
    end
    return head, helmet
end

local function getallhitboxes()
    local randomhitbox
    if targetteam then
        for i,v in targetteam:GetDescendants() do
            if v.ClassName == "Model" and v:FindFirstChildWhichIsA("Part") then
                randomhitbox = v:FindFirstChildWhichIsA("Part")
            end
        end
    end
    return randomhitbox
end

local function closesthitboxtocrosshair()
    local hitboxes
    local closestPart
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    local cameraLookVector = cam.CFrame.LookVector
    if Config.Aimbot.master.enabled then
        if Config.Aimbot.master.hitboxselection == 'head' then
            hitboxes = headhitboxes()
        else
            hitboxes = getallhitboxes()
        end
        if hitboxes then
            local smallestAngle = math.huge
            local path = (hitboxes.Position - cam.CFrame.Position).unit
            local angle = math.acos(cameraLookVector:Dot(path))

            if angle < smallestAngle then
                smallestAngle = angle
                closestPart = hitboxes
            end
        end
    end
    return closestPart
end

-- thank chatgpt for this function
local function moveMouseToTarget(targetPosition)
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    local viewportPoint = cam:WorldToViewportPoint(targetPosition)
    local mouse = LocalPlayer:GetMouse()
    local screenX, screenY = viewportPoint.X, viewportPoint.Y
    local mouseX, mouseY = mouse.X, mouse.Y
    mousemoverel(screenX - mouseX, screenY - mouseY)
end

local function aimbot()
    if Config.Aimbot.master.enabled then
        local closesthitboxes = closesthitboxtocrosshair()
        if closesthitboxes then
            moveMouseToTarget(closesthitboxes.Position)
        end
    end
end

--[[local function aimbot()
    if Config.Aimbot.master.enabled then
        local closesthitboxes = closesthitboxtocrosshair()
        if closesthitboxes then
            local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
            local cameraPosition = cam.CFrame.Position
            local lookAtCFrame = CFrame.lookAt(cameraPosition, closesthitboxes.Position)
            local UserInputService = game:GetService("UserInputService")
            --[[local keypressed

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    keypressed = true
                end
            end)

            UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    keypressed = false
                end
            end)

            if keypressed then
                print("m2 triggered, aimbot initialized")
                cam.CFrame = lookAtCFrame
            end
            cam.CFrame = lookAtCFrame
        end
    end
end]]

local lighting = game:GetService("Lighting")

local function fog()
    if lighting and Config.Visuals.world.fog.enabled then
        lighting.FogColor = Config.Visuals.world.fog.color
        lighting.FogStart = Config.Visuals.world.fog.fogstart
        lighting.FogEnd = Config.Visuals.world.fog.fogend
        if lighting:FindFirstChild("Atmosphere") then
            local fold = Instance.new("Folder", game:GetService("Workspace"))
            fold.Name = "avohookstorage"

            local atmo = lighting:FindFirstChild("Atmosphere"):Clone()
            atmo.Parent = game:GetService("Workspace"):FindFirstChild("avohookstorage")
            lighting:FindFirstChild("Atmosphere"):Destroy()
        end
    else
        if game:GetService("Workspace"):FindFirstChild("avohookstorage") and game:GetService("Workspace"):FindFirstChild("avohookstorage"):FindFirstChild("Atmosphere") then
            game:GetService("Workspace"):FindFirstChild("avohookstorage"):FindFirstChild("Atmosphere").Parent = game:GetService("Lighting")
            game:GetService("Workspace"):FindFirstChild("avohookstorage"):Destroy()
        end
        lighting.FogEnd = 10000
    end
end

local function ambient()
    if lighting and Config.Visuals.world.ambient.enabled then
        lighting.Ambient = Config.Visuals.world.ambient.color
    else
        lighting.Ambient = Color3.fromRGB(72, 70, 55)
    end
end

local function outdoor()
    if lighting and Config.Visuals.world.outdoor.enabled then
        lighting.ClockTime = Config.Visuals.world.outdoor.time
    else
        lighting.ClockTime = 12
    end
end

local function fuck()
    for i, Child in pairs(game:GetService("Workspace"):FindFirstChild("Ignore"):GetChildren()) do
        if Child.ClassName == "Model" then
            return Child
        end
    end

    return nil
end

local function fly()
    local cam = game:GetService("Workspace"):FindFirstChildWhichIsA("Camera")
    local Vec3 = Vector3.new
    local UserInputService = game:GetService("UserInputService")
    local PlayerModel = fuck()
    if not PlayerModel then
        return
    end
    local RootPart = PlayerModel:FindFirstChild("HumanoidRootPart")
    if Config.misc.movement.flyhack.master and RootPart and Config.misc.movement.flyhack.flying then
        --[[Config.misc.movement.flyhack.flying = not Config.misc.movement.flyhack.flying
        wait(.4)
        Config.misc.movement.flyhack.flying = not Config.misc.movement.flyhack.flying]]
        local LookVector = cam.CFrame.LookVector
        local Direction = Vec3()

        local Directions = {
            [Enum.KeyCode.W] = LookVector,
            [Enum.KeyCode.A] = Vec3(LookVector.Z, 0, -LookVector.X),
            [Enum.KeyCode.S] = -LookVector,
            [Enum.KeyCode.D] = Vec3(-LookVector.Z, 0, LookVector.X),
            [Enum.KeyCode.LeftControl] = Vec3(0, -5, 0),
            [Enum.KeyCode.Space] = Vec3(0, 5, 0)
        }

        for Key, Dir in pairs(Directions) do
            if UserInputService:IsKeyDown(Key) then
                Direction = Direction + Dir
            end
        end

        if Direction.Magnitude > 0 then
            RootPart.Velocity = Direction.Unit * Config.misc.movement.flyhack.flyingspeed
            RootPart.Anchored = false
        else
            RootPart.Velocity = Vec3()
            RootPart.Anchored = true
        end

        if RootPart.Anchored then
            RootPart.Anchored = false
        end
    end
end

local function speedhack()
    local player = fuck()
    if player then
        local hrp = player:FindFirstChild("HumanoidRootPart")
        local human = player:FindFirstChild("Humanoid")
        if Config.misc.movement.speedhack.master and hrp and human then
            hrp.CFrame = hrp.CFrame + player:FindFirstChild("Humanoid").MoveDirection * (Config.misc.movement.speedhack.amount * 0.05)
            hrp.Anchored = false
        end
    end
end

local function antivk()
    if Players.LocalPlayer:FindFirstChild("PlayerGui") and Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("ChatScreenGui") then
        local csg = Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("ChatScreenGui")
        --local vkui = csg:FindFirstChild("Main"):FindFirstChild("DisplayVoteKick")
        --if vkui and Config.misc.random.antivotekick.enabled then
        local chat = csg:FindFirstChild("Main"):FindFirstChild("ContainerChat")
        if chat and Config.misc.random.antivotekick.enabled then
            for i,v in chat:GetChildren() do
                local chatmsg = v:FindFirstChild("TextContent")
                if chatmsg then
                    local plrname = Players.LocalPlayer.Name
                    local consolecheck = '[Console]'
                    if string.match(string.sub(chatmsg.Text,43,200), plrname) and string.match(string.sub(chatmsg.Text,34,42), consolecheck) then
                        Library:Notify(string.format('[avohook] votekick on player detected, rejoining server.'))
                        local jobid = game.JobId
                        local placeid = game.PlaceId
                        local bypass = [[
                            game:GetService('TeleportService'):TeleportToPlaceInstance(placeid, jobid, game:GetService("Players").LocalPlayer)
                        ]]
                        wait()
                        local gameapi = "https://games.roblox.com/v1/games/"
                        local apiservs = gameapi..placeid.."/servers/Public?sortOrder=Asc&limit=10"
                        function ListServers(cursor)
                            local raw = game:HttpGet(apiservs .. ((cursor and "&cursor="..cursor) or ""))
                            return game:GetService("HttpService"):JSONDecode(raw)
                        end
                        local allservers = ListServers()
                        local server = allservers.data[math.random(1,#allservers.data)]
                        if not server.id == jobid then
                            queue_on_teleport(bypass)
                            game:GetService('TeleportService'):TeleportToPlaceInstance(placeid, server.id, game:GetService("Players").LocalPlayer)
                        end
                    end
                end
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if Config.Visuals.chams.chosenteam == "1" then
        targetteam = t1
    elseif Config.Visuals.chams.chosenteam == '2' then
        targetteam = t2
    end
    arewedeadass()
    sleeveremover()
    viewmodel()
    aimbot()
    fog()
    ambient()
    outdoor()
    fly()
    speedhack()
    gloveremover()
    onehanded()
    antivk()
    tb()
end)

Library:Notify(string.format('[avohook] script loaded. current build is %q.', avohook.Build))
Library:Notify(string.format('[avohook] special thanks to edwin for helping out and giving inspiration'))
