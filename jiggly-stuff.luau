--[[
Subscribe to @eipccats on YouTube
And join our discord server https://suic1.de/discord
]]--

local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local cg = game:GetService("CoreGui")
local ss = game:GetService("SoundService")
local lp = game.Players.LocalPlayer
local du = "https://www.myinstants.com/media/sounds/perfect-fart.mp3"

local ui1 = Instance.new("ScreenGui") ui1.Name="fj" ui1.ResetOnSpawn=false ui1.IgnoreGuiInset=true pcall(function() ui1.Parent=cg end) if not ui1.Parent then ui1.Parent=lp:WaitForChild("PlayerGui") end

local ui2 = Instance.new("Frame") ui2.Size=UDim2.new(0,150,0,138) ui2.Position=UDim2.new(0,20,0,200) ui2.BackgroundColor3=Color3.fromRGB(20,20,20) ui2.BorderSizePixel=0 ui2.Active=true ui2.Draggable=true ui2.Parent=ui1
local ui3 = Instance.new("TextLabel") ui3.Size=UDim2.new(1,-18,0,16) ui3.BackgroundColor3=Color3.fromRGB(40,40,40) ui3.BorderSizePixel=0 ui3.Text="jiggle" ui3.TextColor3=Color3.fromRGB(230,230,230) ui3.Font=Enum.Font.Code ui3.TextSize=11 ui3.TextXAlignment=Enum.TextXAlignment.Left ui3.Parent=ui2
local ui4 = Instance.new("TextButton") ui4.Size=UDim2.new(0,18,0,16) ui4.Position=UDim2.new(1,-18,0,0) ui4.BackgroundColor3=Color3.fromRGB(70,30,30) ui4.BorderSizePixel=0 ui4.Text="x" ui4.TextColor3=Color3.fromRGB(230,230,230) ui4.Font=Enum.Font.Code ui4.TextSize=11 ui4.Parent=ui2
local ui5 = Instance.new("TextButton") ui5.Size=UDim2.new(1,-8,0,16) ui5.Position=UDim2.new(0,4,0,20) ui5.BackgroundColor3=Color3.fromRGB(35,35,35) ui5.BorderSizePixel=0 ui5.Text="jump: on" ui5.TextColor3=Color3.fromRGB(220,220,220) ui5.Font=Enum.Font.Code ui5.TextSize=10 ui5.Parent=ui2
local ui6 = Instance.new("TextButton") ui6.Size=UDim2.new(1,-8,0,16) ui6.Position=UDim2.new(0,4,0,38) ui6.BackgroundColor3=Color3.fromRGB(35,35,35) ui6.BorderSizePixel=0 ui6.Text="land: on" ui6.TextColor3=Color3.fromRGB(220,220,220) ui6.Font=Enum.Font.Code ui6.TextSize=10 ui6.Parent=ui2
local ui7 = Instance.new("TextButton") ui7.Size=UDim2.new(1,-8,0,16) ui7.Position=UDim2.new(0,4,0,56) ui7.BackgroundColor3=Color3.fromRGB(40,80,40) ui7.BorderSizePixel=0 ui7.Text="jiggle: off" ui7.TextColor3=Color3.fromRGB(220,220,220) ui7.Font=Enum.Font.Code ui7.TextSize=10 ui7.Parent=ui2
local ui8 = Instance.new("TextButton") ui8.Size=UDim2.new(1,-8,0,16) ui8.Position=UDim2.new(0,4,0,74) ui8.BackgroundColor3=Color3.fromRGB(35,35,35) ui8.BorderSizePixel=0 ui8.Text="sound: jiggle only" ui8.TextColor3=Color3.fromRGB(220,220,220) ui8.Font=Enum.Font.Code ui8.TextSize=10 ui8.Parent=ui2
local ui9 = Instance.new("TextButton") ui9.Size=UDim2.new(1,-8,0,16) ui9.Position=UDim2.new(0,4,0,92) ui9.BackgroundColor3=Color3.fromRGB(40,40,60) ui9.BorderSizePixel=0 ui9.Text="open settings" ui9.TextColor3=Color3.fromRGB(220,220,220) ui9.Font=Enum.Font.Code ui9.TextSize=10 ui9.Parent=ui2
local ui10 = Instance.new("TextButton") ui10.Size=UDim2.new(1,-8,0,16) ui10.Position=UDim2.new(0,4,0,110) ui10.BackgroundColor3=Color3.fromRGB(60,40,40) ui10.BorderSizePixel=0 ui10.Text="open sound" ui10.TextColor3=Color3.fromRGB(220,220,220) ui10.Font=Enum.Font.Code ui10.TextSize=10 ui10.Parent=ui2

local ui11 = Instance.new("Frame") ui11.Size=UDim2.new(0,180,0,100) ui11.Position=UDim2.new(0,180,0,200) ui11.BackgroundColor3=Color3.fromRGB(20,20,20) ui11.BorderSizePixel=0 ui11.Active=true ui11.Draggable=true ui11.Visible=false ui11.Parent=ui1
local ui12 = Instance.new("TextLabel") ui12.Size=UDim2.new(1,-18,0,16) ui12.BackgroundColor3=Color3.fromRGB(40,40,40) ui12.BorderSizePixel=0 ui12.Text="settings" ui12.TextColor3=Color3.fromRGB(230,230,230) ui12.Font=Enum.Font.Code ui12.TextSize=11 ui12.TextXAlignment=Enum.TextXAlignment.Left ui12.Parent=ui11
local ui13 = Instance.new("TextButton") ui13.Size=UDim2.new(0,18,0,16) ui13.Position=UDim2.new(1,-18,0,0) ui13.BackgroundColor3=Color3.fromRGB(70,30,30) ui13.BorderSizePixel=0 ui13.Text="x" ui13.TextColor3=Color3.fromRGB(230,230,230) ui13.Font=Enum.Font.Code ui13.TextSize=11 ui13.Parent=ui11
local ui14 = Instance.new("TextBox") ui14.Size=UDim2.new(1,-8,0,16) ui14.Position=UDim2.new(0,4,0,20) ui14.BackgroundColor3=Color3.fromRGB(35,35,35) ui14.BorderSizePixel=0 ui14.Text="tension: 210" ui14.TextColor3=Color3.fromRGB(220,220,220) ui14.Font=Enum.Font.Code ui14.TextSize=10 ui14.ClearTextOnFocus=false ui14.TextXAlignment=Enum.TextXAlignment.Left ui14.Parent=ui11
local ui15 = Instance.new("TextBox") ui15.Size=UDim2.new(1,-8,0,16) ui15.Position=UDim2.new(0,4,0,38) ui15.BackgroundColor3=Color3.fromRGB(35,35,35) ui15.BorderSizePixel=0 ui15.Text="damping: 8" ui15.TextColor3=Color3.fromRGB(220,220,220) ui15.Font=Enum.Font.Code ui15.TextSize=10 ui15.ClearTextOnFocus=false ui15.TextXAlignment=Enum.TextXAlignment.Left ui15.Parent=ui11
local ui16 = Instance.new("TextBox") ui16.Size=UDim2.new(1,-8,0,16) ui16.Position=UDim2.new(0,4,0,56) ui16.BackgroundColor3=Color3.fromRGB(35,35,35) ui16.BorderSizePixel=0 ui16.Text="squish: 0.012" ui16.TextColor3=Color3.fromRGB(220,220,220) ui16.Font=Enum.Font.Code ui16.TextSize=10 ui16.ClearTextOnFocus=false ui16.TextXAlignment=Enum.TextXAlignment.Left ui16.Parent=ui11
local ui17 = Instance.new("TextButton") ui17.Size=UDim2.new(0.5,-6,0,16) ui17.Position=UDim2.new(0,4,0,78) ui17.BackgroundColor3=Color3.fromRGB(40,60,40) ui17.BorderSizePixel=0 ui17.Text="apply" ui17.TextColor3=Color3.fromRGB(220,220,220) ui17.Font=Enum.Font.Code ui17.TextSize=10 ui17.Parent=ui11
local ui18 = Instance.new("TextButton") ui18.Size=UDim2.new(0.5,-6,0,16) ui18.Position=UDim2.new(0.5,2,0,78) ui18.BackgroundColor3=Color3.fromRGB(60,40,40) ui18.BorderSizePixel=0 ui18.Text="reset" ui18.TextColor3=Color3.fromRGB(220,220,220) ui18.Font=Enum.Font.Code ui18.TextSize=10 ui18.Parent=ui11

local ui19 = Instance.new("Frame") ui19.Size=UDim2.new(0,180,0,100) ui19.Position=UDim2.new(0,340,0,200) ui19.BackgroundColor3=Color3.fromRGB(20,20,20) ui19.BorderSizePixel=0 ui19.Active=true ui19.Draggable=true ui19.Visible=false ui19.Parent=ui1
local ui20 = Instance.new("TextLabel") ui20.Size=UDim2.new(1,-18,0,16) ui20.BackgroundColor3=Color3.fromRGB(40,40,40) ui20.BorderSizePixel=0 ui20.Text="sound" ui20.TextColor3=Color3.fromRGB(230,230,230) ui20.Font=Enum.Font.Code ui20.TextSize=11 ui20.TextXAlignment=Enum.TextXAlignment.Left ui20.Parent=ui19
local ui21 = Instance.new("TextButton") ui21.Size=UDim2.new(0,18,0,16) ui21.Position=UDim2.new(1,-18,0,0) ui21.BackgroundColor3=Color3.fromRGB(70,30,30) ui21.BorderSizePixel=0 ui21.Text="x" ui21.TextColor3=Color3.fromRGB(230,230,230) ui21.Font=Enum.Font.Code ui21.TextSize=11 ui21.Parent=ui19
local ui22 = Instance.new("TextBox") ui22.Size=UDim2.new(1,-8,0,16) ui22.Position=UDim2.new(0,4,0,20) ui22.BackgroundColor3=Color3.fromRGB(35,35,35) ui22.BorderSizePixel=0 ui22.Text=du ui22.TextColor3=Color3.fromRGB(220,220,220) ui22.Font=Enum.Font.Code ui22.TextSize=9 ui22.ClearTextOnFocus=false ui22.TextXAlignment=Enum.TextXAlignment.Left ui22.Parent=ui19
local ui23 = Instance.new("TextBox") ui23.Size=UDim2.new(1,-8,0,16) ui23.Position=UDim2.new(0,4,0,38) ui23.BackgroundColor3=Color3.fromRGB(35,35,35) ui23.BorderSizePixel=0 ui23.Text=du ui23.TextColor3=Color3.fromRGB(220,220,220) ui23.Font=Enum.Font.Code ui23.TextSize=9 ui23.ClearTextOnFocus=false ui23.TextXAlignment=Enum.TextXAlignment.Left ui23.Parent=ui19
local ui24 = Instance.new("TextButton") ui24.Size=UDim2.new(0.5,-6,0,16) ui24.Position=UDim2.new(0,4,0,60) ui24.BackgroundColor3=Color3.fromRGB(40,40,60) ui24.BorderSizePixel=0 ui24.Text="set jump" ui24.TextColor3=Color3.fromRGB(220,220,220) ui24.Font=Enum.Font.Code ui24.TextSize=10 ui24.Parent=ui19
local ui25 = Instance.new("TextButton") ui25.Size=UDim2.new(0.5,-6,0,16) ui25.Position=UDim2.new(0.5,2,0,60) ui25.BackgroundColor3=Color3.fromRGB(60,40,40) ui25.BorderSizePixel=0 ui25.Text="set land" ui25.TextColor3=Color3.fromRGB(220,220,220) ui25.Font=Enum.Font.Code ui25.TextSize=10 ui25.Parent=ui19

local s1 = Instance.new("Sound") s1.Volume=1 s1.Parent=ss
local s2 = Instance.new("Sound") s2.Volume=1 s2.Parent=ss

local ui26 = Instance.new("Frame") ui26.Size=UDim2.new(0,240,0,80) ui26.Position=UDim2.new(0.5,-120,0.5,-40) ui26.BackgroundColor3=Color3.fromRGB(15,15,15) ui26.BorderSizePixel=0 ui26.Parent=ui1
local ui27 = Instance.new("TextLabel") ui27.Size=UDim2.new(1,-8,0,16) ui27.Position=UDim2.new(0,4,0,2) ui27.BackgroundTransparency=1 ui27.Text="Subscribe to @eipccats on YouTube" ui27.TextColor3=Color3.fromRGB(220,220,220) ui27.Font=Enum.Font.Code ui27.TextSize=11 ui27.TextXAlignment=Enum.TextXAlignment.Left ui27.Parent=ui26
local ui28 = Instance.new("TextLabel") ui28.Size=UDim2.new(1,-8,0,16) ui28.Position=UDim2.new(0,4,0,20) ui28.BackgroundTransparency=1 ui28.Text="Modified by R4" ui28.TextColor3=Color3.fromRGB(150,220,150) ui28.Font=Enum.Font.Code ui28.TextSize=11 ui28.TextXAlignment=Enum.TextXAlignment.Left ui28.Parent=ui26
local ui29 = Instance.new("TextLabel") ui29.Size=UDim2.new(1,-8,0,16) ui29.Position=UDim2.new(0,4,0,38) ui29.BackgroundTransparency=1 ui29.Text="join our discord https://suic1.de/discord" ui29.TextColor3=Color3.fromRGB(140,180,255) ui29.Font=Enum.Font.Code ui29.TextSize=11 ui29.TextXAlignment=Enum.TextXAlignment.Left ui29.Parent=ui26
local ui30 = Instance.new("TextButton") ui30.Size=UDim2.new(1,-8,0,16) ui30.Position=UDim2.new(0,4,0,58) ui30.BackgroundColor3=Color3.fromRGB(40,60,40) ui30.BorderSizePixel=0 ui30.Text="ok" ui30.TextColor3=Color3.fromRGB(220,220,220) ui30.Font=Enum.Font.Code ui30.TextSize=11 ui30.Parent=ui26

local jOn = true
local lOn = true
local gOn = false
local sm = "jiggle"
local tn = 210
local dp = 8
local sq = 0.012

local function loadSnd(u, path, s)
    local req = http_request or (syn and syn.request) or request
    if not req then return false end
    local ok, res = pcall(function() return req({Url=u, Method="GET"}) end)
    if not ok or not res or not res.Body then return false end
    pcall(function() if writefile then writefile(path, res.Body) end end)
    local ok2, out = pcall(function() return getcustomasset(path) end)
    if not ok2 then return false end
    s.SoundId = out
    return true
end

local function pJump()
    if not jOn then return end
    if sm == "jiggle" and not gOn then return end
    pcall(function() s1.TimePosition = 0 s1:Play() end)
end

local function pLand()
    if not lOn then return end
    if sm == "jiggle" and not gOn then return end
    pcall(function() s2.TimePosition = 0 s2:Play() end)
end

local function sText()
    ui8.Text = "sound: " .. (sm == "jiggle" and "jiggle only" or "always")
end

ui5.MouseButton1Click:Connect(function() jOn = not jOn ui5.Text = "jump: " .. (jOn and "on" or "off") end)
ui6.MouseButton1Click:Connect(function() lOn = not lOn ui6.Text = "land: " .. (lOn and "on" or "off") end)
ui7.MouseButton1Click:Connect(function() gOn = not gOn ui7.Text = "jiggle: " .. (gOn and "on" or "off") ui7.BackgroundColor3 = gOn and Color3.fromRGB(40,100,40) or Color3.fromRGB(40,80,40) end)
ui8.MouseButton1Click:Connect(function() sm = sm == "jiggle" and "always" or "jiggle" sText() end)
sText()

ui9.MouseButton1Click:Connect(function() ui11.Visible = not ui11.Visible end)
ui10.MouseButton1Click:Connect(function() ui19.Visible = not ui19.Visible end)
ui4.MouseButton1Click:Connect(function() ui2.Visible = false end)
ui13.MouseButton1Click:Connect(function() ui11.Visible = false end)
ui21.MouseButton1Click:Connect(function() ui19.Visible = false end)
ui30.MouseButton1Click:Connect(function() ui26:Destroy() end)

ui17.MouseButton1Click:Connect(function()
    local t1 = tonumber(ui14.Text:match("([%d%.]+)"))
    local t2 = tonumber(ui15.Text:match("([%d%.]+)"))
    local t3 = tonumber(ui16.Text:match("([%d%.]+)"))
    if t1 then tn = math.clamp(t1, 20, 800) end
    if t2 then dp = math.clamp(t2, 1, 40) end
    if t3 then sq = math.clamp(t3, 0.001, 0.05) end
    ui14.Text = "tension: " .. tn
    ui15.Text = "damping: " .. dp
    ui16.Text = "squish: " .. sq
end)

ui18.MouseButton1Click:Connect(function()
    tn = 210 dp = 8 sq = 0.012
    ui14.Text = "tension: 210"
    ui15.Text = "damping: 8"
    ui16.Text = "squish: 0.012"
end)

ui24.MouseButton1Click:Connect(function() loadSnd(ui22.Text, "jump.mp3", s1) end)
ui25.MouseButton1Click:Connect(function() loadSnd(ui23.Text, "land.mp3", s2) end)

local tog = true
uis.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        tog = not tog
        ui1.Enabled = tog
    end
end)

local sc = 1
local vl = 0
local ly = 0
local pt = {}
local rt
local tr
local rj
local hm
local oc
local st = tick()
local cn = {}
local ch

local function wipe()
    for _, c in ipairs(cn) do pcall(function() c:Disconnect() end) end
    cn = {}
end

local function getTr(c) return c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("LowerTorso") end

local function getRj(c, rp)
    local r = rp:FindFirstChild("RootJoint")
    if r then return r end
    local t = getTr(c)
    if t then
        for _, m in ipairs(rp:GetChildren()) do if m:IsA("Motor6D") and m.Part1 == t then return m end end
        for _, m in ipairs(t:GetChildren()) do if m:IsA("Motor6D") and m.Part0 == rp then return m end end
    end
end

local function scan()
    pt = {}
    if not ch or not tr or not tr.Parent then return end
    for _, v in ipairs(ch:GetDescendants()) do
        local isBody = v:IsA("BasePart") and v.Parent == ch and v.Name ~= "HumanoidRootPart"
        local isAcc = v:IsA("BasePart") and v.Name == "Handle" and v.Parent and v.Parent:IsA("Accessory")
        if isBody or isAcc then
            local j
            pcall(function()
                j = v:FindFirstChildOfClass("Motor6D") or v:FindFirstChildOfClass("Weld")
                if not j and isBody then
                    for _, m in ipairs(tr:GetChildren()) do if m:IsA("Motor6D") and m.Part1 == v then j = m break end end
                end
            end)
            local me = v:FindFirstChildOfClass("SpecialMesh")
            local ms = me and me.Scale or Vector3.new(1,1,1)
            pt[v] = { Size=v.Size, Joint=j, C0=j and j.C0 or nil, Mesh=me, MeshScale=ms, Name=v.Name }
        end
    end
end

local function hookChar(nc)
    wipe()
    pt = {}
    sc = 1
    vl = 0
    ly = 0
    st = tick()
    ch = nc
    rt = ch:WaitForChild("HumanoidRootPart", 10)
    hm = ch:WaitForChild("Humanoid", 10)
    tr = getTr(ch)
    if not rt or not hm then return end
    tr = tr or ch:WaitForChild("UpperTorso", 5) or ch:WaitForChild("Torso", 5)
    rj = getRj(ch, tr)
    oc = rj and rj.C1 or nil
    scan()
    if tr then
        cn[#cn+1] = tr.Touched:Connect(function(h)
            pcall(function()
                if tick() - st < 1.5 then return end
                if h:IsDescendantOf(ch) then return end
                local rel = h.AssemblyLinearVelocity - rt.AssemblyLinearVelocity
                if rel.Y < -14 then vl = vl - math.abs(rel.Y) * 1.35 pLand() end
            end)
        end)
    end
    local hd = ch:FindFirstChild("Head")
    if hd then
        cn[#cn+1] = hd.Touched:Connect(function(h)
            pcall(function()
                if tick() - st < 1.5 then return end
                if h:IsDescendantOf(ch) then return end
                vl = vl - 15
                pLand()
            end)
        end)
    end
    cn[#cn+1] = hm.StateChanged:Connect(function(_, s)
        pcall(function()
            if s == Enum.HumanoidStateType.Jumping then vl = vl - 3 pJump() end
            if s == Enum.HumanoidStateType.Landed then vl = vl - 12 pLand() end
        end)
    end)
    cn[#cn+1] = ch.DescendantAdded:Connect(function() task.wait(0.1) scan() end)
end

lp.CharacterAdded:Connect(hookChar)
if lp.Character then hookChar(lp.Character) end

rs.RenderStepped:Connect(function(dt)
    pcall(function()
        dt = math.min(dt, 0.033)
        if not gOn then return end
        if not rt or not rt.Parent then return end
        local v = rt.AssemblyLinearVelocity
        local tgt = 1 + v.Y * sq
        tgt = math.clamp(tgt, 0.84, 1.5)
        if ly < -10 and v.Y >= -1 then vl = vl - math.abs(ly) * 0.35 pLand() end
        ly = v.Y
        local ds = sc - tgt
        local f = -tn * ds - dp * vl
        f = math.clamp(f, -500, 500)
        if sc < 0.88 then f = f * 2 end
        vl = math.clamp(vl + f * dt, -40, 40)
        sc = math.clamp(sc + vl * dt, 0.7, 1.5)
        local xz = sc < 1 and (1 + (1 - sc) * 0.45) or (1 - (sc - 1) * 0.2)
        local th = tr and pt[tr] and pt[tr].Size.Y or 2
        for p, d in pairs(pt) do
            if p and p.Parent then
                if p.Size then
                    local ns = Vector3.new(d.Size.X * xz, d.Size.Y * sc, d.Size.Z * xz)
                    if ns.X > 0 and ns.Y > 0 and ns.Z > 0 then p.Size = ns end
                end
                if d.Mesh and d.Mesh.Parent then d.Mesh.Scale = Vector3.new(d.MeshScale.X * xz, d.MeshScale.Y * sc, d.MeshScale.Z * xz) end
                if d.Joint and p ~= tr and d.Joint.Parent then
                    local o = d.C0
                    if o then
                        local y = o.Y * sc
                        if d.Name and d.Name:find("Leg") then y = o.Y * sc + th * 0.5 * (1 - sc) end
                        if d.Name and d.Name:find("Arm") then y = o.Y * sc + th * 0.35 * (1 - sc) end
                        pcall(function() d.Joint.C0 = CFrame.new(o.X, y, o.Z) * o.Rotation end)
                    end
                end
            end
        end
        if tr and pt[tr] and rj and oc then
            local vo = (1 - sc) * pt[tr].Size.Y * 0.5
            pcall(function() rj.C1 = oc * CFrame.new(0, vo, 0) end)
        end
    end)
end)
