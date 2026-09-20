--[[
Subscribe to @eipccats on YouTube
And join our discord server https://suic1.de/discord
]]--

local rs=game:GetService("RunService")
local uis=game:GetService("UserInputService")
local cg=game:GetService("CoreGui")
local ss=game:GetService("SoundService")
local lp=game.Players.LocalPlayer
local du="https://www.myinstants.com/media/sounds/perfect-fart.mp3"

local g=Instance.new("ScreenGui") g.Name="fj" g.ResetOnSpawn=false g.IgnoreGuiInset=true pcall(function() g.Parent=cg end) if not g.Parent then g.Parent=lp:WaitForChild("PlayerGui") end
local f=Instance.new("Frame") f.Size=UDim2.new(0,150,0,138) f.Position=UDim2.new(0,20,0,200) f.BackgroundColor3=Color3.fromRGB(20,20,20) f.BorderSizePixel=0 f.Active=true f.Draggable=true f.Parent=g
local f1=Instance.new("TextLabel") f1.Size=UDim2.new(1,-18,0,16) f1.BackgroundColor3=Color3.fromRGB(40,40,40) f1.BorderSizePixel=0 f1.Text="jiggle" f1.TextColor3=Color3.fromRGB(230,230,230) f1.Font=Enum.Font.Code f1.TextSize=11 f1.TextXAlignment=Enum.TextXAlignment.Left f1.Parent=f
local f2=Instance.new("TextButton") f2.Size=UDim2.new(0,18,0,16) f2.Position=UDim2.new(1,-18,0,0) f2.BackgroundColor3=Color3.fromRGB(70,30,30) f2.BorderSizePixel=0 f2.Text="x" f2.TextColor3=Color3.fromRGB(230,230,230) f2.Font=Enum.Font.Code f2.TextSize=11 f2.Parent=f
local f3=Instance.new("TextButton") f3.Size=UDim2.new(1,-8,0,16) f3.Position=UDim2.new(0,4,0,20) f3.BackgroundColor3=Color3.fromRGB(35,35,35) f3.BorderSizePixel=0 f3.Text="jump: on" f3.TextColor3=Color3.fromRGB(220,220,220) f3.Font=Enum.Font.Code f3.TextSize=10 f3.Parent=f
local f4=Instance.new("TextButton") f4.Size=UDim2.new(1,-8,0,16) f4.Position=UDim2.new(0,4,0,38) f4.BackgroundColor3=Color3.fromRGB(35,35,35) f4.BorderSizePixel=0 f4.Text="land: on" f4.TextColor3=Color3.fromRGB(220,220,220) f4.Font=Enum.Font.Code f4.TextSize=10 f4.Parent=f
local f5=Instance.new("TextButton") f5.Size=UDim2.new(1,-8,0,16) f5.Position=UDim2.new(0,4,0,56) f5.BackgroundColor3=Color3.fromRGB(40,80,40) f5.BorderSizePixel=0 f5.Text="jiggle: off" f5.TextColor3=Color3.fromRGB(220,220,220) f5.Font=Enum.Font.Code f5.TextSize=10 f5.Parent=f
local f6=Instance.new("TextButton") f6.Size=UDim2.new(1,-8,0,16) f6.Position=UDim2.new(0,4,0,74) f6.BackgroundColor3=Color3.fromRGB(35,35,35) f6.BorderSizePixel=0 f6.Text="sound: jiggle only" f6.TextColor3=Color3.fromRGB(220,220,220) f6.Font=Enum.Font.Code f6.TextSize=10 f6.Parent=f
local f7=Instance.new("TextButton") f7.Size=UDim2.new(1,-8,0,16) f7.Position=UDim2.new(0,4,0,92) f7.BackgroundColor3=Color3.fromRGB(40,40,60) f7.BorderSizePixel=0 f7.Text="open settings" f7.TextColor3=Color3.fromRGB(220,220,220) f7.Font=Enum.Font.Code f7.TextSize=10 f7.Parent=f
local f8=Instance.new("TextButton") f8.Size=UDim2.new(1,-8,0,16) f8.Position=UDim2.new(0,4,0,110) f8.BackgroundColor3=Color3.fromRGB(60,40,40) f8.BorderSizePixel=0 f8.Text="open sound" f8.TextColor3=Color3.fromRGB(220,220,220) f8.Font=Enum.Font.Code f8.TextSize=10 f8.Parent=f

local s=Instance.new("Frame") s.Size=UDim2.new(0,180,0,100) s.Position=UDim2.new(0,180,0,200) s.BackgroundColor3=Color3.fromRGB(20,20,20) s.BorderSizePixel=0 s.Active=true s.Draggable=true s.Visible=false s.Parent=g
local s1=Instance.new("TextLabel") s1.Size=UDim2.new(1,-18,0,16) s1.BackgroundColor3=Color3.fromRGB(40,40,40) s1.BorderSizePixel=0 s1.Text="settings" s1.TextColor3=Color3.fromRGB(230,230,230) s1.Font=Enum.Font.Code s1.TextSize=11 s1.TextXAlignment=Enum.TextXAlignment.Left s1.Parent=s
local s2=Instance.new("TextButton") s2.Size=UDim2.new(0,18,0,16) s2.Position=UDim2.new(1,-18,0,0) s2.BackgroundColor3=Color3.fromRGB(70,30,30) s2.BorderSizePixel=0 s2.Text="x" s2.TextColor3=Color3.fromRGB(230,230,230) s2.Font=Enum.Font.Code s2.TextSize=11 s2.Parent=s
local s3=Instance.new("TextBox") s3.Size=UDim2.new(1,-8,0,16) s3.Position=UDim2.new(0,4,0,20) s3.BackgroundColor3=Color3.fromRGB(35,35,35) s3.BorderSizePixel=0 s3.Text="tension: 210" s3.TextColor3=Color3.fromRGB(220,220,220) s3.Font=Enum.Font.Code s3.TextSize=10 s3.ClearTextOnFocus=false s3.TextXAlignment=Enum.TextXAlignment.Left s3.Parent=s
local s4=Instance.new("TextBox") s4.Size=UDim2.new(1,-8,0,16) s4.Position=UDim2.new(0,4,0,38) s4.BackgroundColor3=Color3.fromRGB(35,35,35) s4.BorderSizePixel=0 s4.Text="damping: 8" s4.TextColor3=Color3.fromRGB(220,220,220) s4.Font=Enum.Font.Code s4.TextSize=10 s4.ClearTextOnFocus=false s4.TextXAlignment=Enum.TextXAlignment.Left s4.Parent=s
local s5=Instance.new("TextBox") s5.Size=UDim2.new(1,-8,0,16) s5.Position=UDim2.new(0,4,0,56) s5.BackgroundColor3=Color3.fromRGB(35,35,35) s5.BorderSizePixel=0 s5.Text="squish: 0.012" s5.TextColor3=Color3.fromRGB(220,220,220) s5.Font=Enum.Font.Code s5.TextSize=10 s5.ClearTextOnFocus=false s5.TextXAlignment=Enum.TextXAlignment.Left s5.Parent=s
local s6=Instance.new("TextButton") s6.Size=UDim2.new(0.5,-6,0,16) s6.Position=UDim2.new(0,4,0,78) s6.BackgroundColor3=Color3.fromRGB(40,60,40) s6.BorderSizePixel=0 s6.Text="apply" s6.TextColor3=Color3.fromRGB(220,220,220) s6.Font=Enum.Font.Code s6.TextSize=10 s6.Parent=s
local s7=Instance.new("TextButton") s7.Size=UDim2.new(0.5,-6,0,16) s7.Position=UDim2.new(0.5,2,0,78) s7.BackgroundColor3=Color3.fromRGB(60,40,40) s7.BorderSizePixel=0 s7.Text="reset" s7.TextColor3=Color3.fromRGB(220,220,220) s7.Font=Enum.Font.Code s7.TextSize=10 s7.Parent=s

local n=Instance.new("Frame") n.Size=UDim2.new(0,180,0,100) n.Position=UDim2.new(0,340,0,200) n.BackgroundColor3=Color3.fromRGB(20,20,20) n.BorderSizePixel=0 n.Active=true n.Draggable=true n.Visible=false n.Parent=g
local n1=Instance.new("TextLabel") n1.Size=UDim2.new(1,-18,0,16) n1.BackgroundColor3=Color3.fromRGB(40,40,40) n1.BorderSizePixel=0 n1.Text="sound" n1.TextColor3=Color3.fromRGB(230,230,230) n1.Font=Enum.Font.Code n1.TextSize=11 n1.TextXAlignment=Enum.TextXAlignment.Left n1.Parent=n
local n2=Instance.new("TextButton") n2.Size=UDim2.new(0,18,0,16) n2.Position=UDim2.new(1,-18,0,0) n2.BackgroundColor3=Color3.fromRGB(70,30,30) n2.BorderSizePixel=0 n2.Text="x" n2.TextColor3=Color3.fromRGB(230,230,230) n2.Font=Enum.Font.Code n2.TextSize=11 n2.Parent=n
local n3=Instance.new("TextBox") n3.Size=UDim2.new(1,-8,0,16) n3.Position=UDim2.new(0,4,0,20) n3.BackgroundColor3=Color3.fromRGB(35,35,35) n3.BorderSizePixel=0 n3.Text=du n3.TextColor3=Color3.fromRGB(220,220,220) n3.Font=Enum.Font.Code n3.TextSize=9 n3.ClearTextOnFocus=false n3.TextXAlignment=Enum.TextXAlignment.Left n3.Parent=n
local n4=Instance.new("TextBox") n4.Size=UDim2.new(1,-8,0,16) n4.Position=UDim2.new(0,4,0,38) n4.BackgroundColor3=Color3.fromRGB(35,35,35) n4.BorderSizePixel=0 n4.Text=du n4.TextColor3=Color3.fromRGB(220,220,220) n4.Font=Enum.Font.Code n4.TextSize=9 n4.ClearTextOnFocus=false n4.TextXAlignment=Enum.TextXAlignment.Left n4.Parent=n
local n5=Instance.new("TextButton") n5.Size=UDim2.new(0.5,-6,0,16) n5.Position=UDim2.new(0,4,0,60) n5.BackgroundColor3=Color3.fromRGB(40,40,60) n5.BorderSizePixel=0 n5.Text="set jump" n5.TextColor3=Color3.fromRGB(220,220,220) n5.Font=Enum.Font.Code n5.TextSize=10 n5.Parent=n
local n6=Instance.new("TextButton") n6.Size=UDim2.new(0.5,-6,0,16) n6.Position=UDim2.new(0.5,2,0,60) n6.BackgroundColor3=Color3.fromRGB(60,40,40) n6.BorderSizePixel=0 n6.Text="set land" n6.TextColor3=Color3.fromRGB(220,220,220) n6.Font=Enum.Font.Code n6.TextSize=10 n6.Parent=n

local js=Instance.new("Sound") js.Volume=1 js.Parent=ss
local ls=Instance.new("Sound") ls.Volume=1 ls.Parent=ss

local cf=Instance.new("Frame") cf.Size=UDim2.new(0,240,0,80) cf.Position=UDim2.new(0.5,-120,0.5,-40) cf.BackgroundColor3=Color3.fromRGB(15,15,15) cf.BorderSizePixel=0 cf.Parent=g
local c1=Instance.new("TextLabel") c1.Size=UDim2.new(1,-8,0,16) c1.Position=UDim2.new(0,4,0,2) c1.BackgroundTransparency=1 c1.Text="Subscribe to @eipccats on YouTube" c1.TextColor3=Color3.fromRGB(220,220,220) c1.Font=Enum.Font.Code c1.TextSize=11 c1.TextXAlignment=Enum.TextXAlignment.Left c1.Parent=cf
local c2=Instance.new("TextLabel") c2.Size=UDim2.new(1,-8,0,16) c2.Position=UDim2.new(0,4,0,20) c2.BackgroundTransparency=1 c2.Text="Modified by R4" c2.TextColor3=Color3.fromRGB(150,220,150) c2.Font=Enum.Font.Code c2.TextSize=11 c2.TextXAlignment=Enum.TextXAlignment.Left c2.Parent=cf
local c3=Instance.new("TextLabel") c3.Size=UDim2.new(1,-8,0,16) c3.Position=UDim2.new(0,4,0,38) c3.BackgroundTransparency=1 c3.Text="join our discord https://suic1.de/discord" c3.TextColor3=Color3.fromRGB(140,180,255) c3.Font=Enum.Font.Code c3.TextSize=11 c3.TextXAlignment=Enum.TextXAlignment.Left c3.Parent=cf
local c4=Instance.new("TextButton") c4.Size=UDim2.new(1,-8,0,16) c4.Position=UDim2.new(0,4,0,58) c4.BackgroundColor3=Color3.fromRGB(40,60,40) c4.BorderSizePixel=0 c4.Text="ok" c4.TextColor3=Color3.fromRGB(220,220,220) c4.Font=Enum.Font.Code c4.TextSize=11 c4.Parent=cf

local jo=true lo=true go=false sm="jiggle"
local tn=210 dp=8 sq=0.012

local function dsc(u,fi,sn)
    local rq=http_request or (syn and syn.request) or request
    if not rq then return false end
    local ok,res=pcall(function() return rq({Url=u,Method="GET"}) end)
    if not ok or not res or not res.Body then return false end
    pcall(function() if writefile then writefile(fi,res.Body) end end)
    local ok2,pth=pcall(function() return getcustomasset(fi) end)
    if not ok2 then return false end
    sn.SoundId=pth
    return true
end

local function pj()
    if not jo then return end
    if sm=="jiggle" and not go then return end
    pcall(function() js.TimePosition=0 js:Play() end)
end

local function pl()
    if not lo then return end
    if sm=="jiggle" and not go then return end
    pcall(function() ls.TimePosition=0 ls:Play() end)
end

local function ust()
    f6.Text="sound: "..(sm=="jiggle" and "jiggle only" or "always")
end

f3.MouseButton1Click:Connect(function() jo=not jo f3.Text="jump: "..(jo and "on" or "off") end)
f4.MouseButton1Click:Connect(function() lo=not lo f4.Text="land: "..(lo and "on" or "off") end)
f5.MouseButton1Click:Connect(function() go=not go f5.Text="jiggle: "..(go and "on" or "off") f5.BackgroundColor3=go and Color3.fromRGB(40,100,40) or Color3.fromRGB(40,80,40) end)
f6.MouseButton1Click:Connect(function() sm=sm=="jiggle" and "always" or "jiggle" ust() end)
ust()
f7.MouseButton1Click:Connect(function() s.Visible=not s.Visible end)
f8.MouseButton1Click:Connect(function() n.Visible=not n.Visible end)
f2.MouseButton1Click:Connect(function() f.Visible=false end)
s2.MouseButton1Click:Connect(function() s.Visible=false end)
n2.MouseButton1Click:Connect(function() n.Visible=false end)
c4.MouseButton1Click:Connect(function() cf:Destroy() end)

s6.MouseButton1Click:Connect(function()
    local a1=tonumber(s3.Text:match("([%d%.]+)"))
    local a2=tonumber(s4.Text:match("([%d%.]+)"))
    local a3=tonumber(s5.Text:match("([%d%.]+)"))
    if a1 then tn=math.clamp(a1,20,800) end
    if a2 then dp=math.clamp(a2,1,40) end
    if a3 then sq=math.clamp(a3,0.001,0.05) end
    s3.Text="tension: "..tn
    s4.Text="damping: "..dp
    s5.Text="squish: "..sq
end)

s7.MouseButton1Click:Connect(function()
    tn=210 dp=8 sq=0.012
    s3.Text="tension: 210"
    s4.Text="damping: 8"
    s5.Text="squish: 0.012"
end)

n5.MouseButton1Click:Connect(function() dsc(n3.Text,"jump.mp3",js) end)
n6.MouseButton1Click:Connect(function() dsc(n4.Text,"land.mp3",ls) end)

local en=true
uis.InputBegan:Connect(function(i,gp) if gp then return end if i.KeyCode==Enum.KeyCode.RightShift then en=not en g.Enabled=en end end)

local cs=1
local vs=0
local lv=0
local ob={}
local rt
local tr
local rj
local hm
local oc1
local st=tick()
local cn={}
local ch

local function cc() for _,c in ipairs(cn) do pcall(function() c:Disconnect() end) end cn={} end
local function gt(c) return c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChild("LowerTorso") end

local function gr(c,rp)
    local r=rp:FindFirstChild("RootJoint")
    if r then return r end
    local t=gt(c)
    if t then
        for _,m in ipairs(rp:GetChildren()) do if m:IsA("Motor6D") and m.Part1==t then return m end end
        for _,m in ipairs(t:GetChildren()) do if m:IsA("Motor6D") and m.Part0==rp then return m end end
    end
end

local function sp()
    ob={}
    if not ch or not tr or not tr.Parent then return end
    for _,v in ipairs(ch:GetDescendants()) do
        local ib=v:IsA("BasePart") and v.Parent==ch and v.Name~="HumanoidRootPart"
        local ia=v:IsA("BasePart") and v.Name=="Handle" and v.Parent and v.Parent:IsA("Accessory")
        if ib or ia then
            local j
            pcall(function()
                j=v:FindFirstChildOfClass("Motor6D") or v:FindFirstChildOfClass("Weld")
                if not j and ib then
                    for _,m in ipairs(tr:GetChildren()) do if m:IsA("Motor6D") and m.Part1==v then j=m break end end
                end
            end)
            local me=v:FindFirstChildOfClass("SpecialMesh")
            local ms=me and me.Scale or Vector3.new(1,1,1)
            ob[v]={Size=v.Size,Joint=j,C0=j and j.C0 or nil,Mesh=me,MeshScale=ms,Name=v.Name}
        end
    end
end

local function hc(nc)
    cc()
    ob={}
    cs=1
    vs=0
    lv=0
    st=tick()
    ch=nc
    rt=ch:WaitForChild("HumanoidRootPart",10)
    hm=ch:WaitForChild("Humanoid",10)
    tr=gt(ch)
    if not rt or not hm then return end
    tr=tr or ch:WaitForChild("UpperTorso",5) or ch:WaitForChild("Torso",5)
    rj=gr(ch,rt)
    oc1=rj and rj.C1 or nil
    sp()
    if tr then
        cn[#cn+1]=tr.Touched:Connect(function(h)
            pcall(function()
                if tick()-st<1.5 then return end
                if h:IsDescendantOf(ch) then return end
                local rv=h.AssemblyLinearVelocity-rt.AssemblyLinearVelocity
                if rv.Y<-14 then vs=vs-math.abs(rv.Y)*1.35 pl() end
            end)
        end)
    end
    local hd=ch:FindFirstChild("Head")
    if hd then
        cn[#cn+1]=hd.Touched:Connect(function(h)
            pcall(function()
                if tick()-st<1.5 then return end
                if h:IsDescendantOf(ch) then return end
                vs=vs-15
                pl()
            end)
        end)
    end
    cn[#cn+1]=hm.StateChanged:Connect(function(_,s)
        pcall(function()
            if s==Enum.HumanoidStateType.Jumping then vs=vs-3 pj() end
            if s==Enum.HumanoidStateType.Landed then vs=vs-12 pl() end
        end)
    end)
    cn[#cn+1]=ch.DescendantAdded:Connect(function() task.wait(0.1) sp() end)
end

lp.CharacterAdded:Connect(hc)
if lp.Character then hc(lp.Character) end

rs.RenderStepped:Connect(function(dt)
    pcall(function()
        dt=math.min(dt,0.033)
        if not go then return end
        if not rt or not rt.Parent then return end
        local v=rt.AssemblyLinearVelocity
        local tg=1+v.Y*sq
        tg=math.clamp(tg,0.84,1.5)
        if lv<-10 and v.Y>=-1 then vs=vs-math.abs(lv)*0.35 pl() end
        lv=v.Y
        local ds=cs-tg
        local fr=-tn*ds-dp*vs
        fr=math.clamp(fr,-500,500)
        if cs<0.88 then fr=fr*2 end
        vs=math.clamp(vs+fr*dt,-40,40)
        cs=math.clamp(cs+vs*dt,0.7,1.5)
        local xz=cs<1 and 1+(1-cs)*0.45 or 1-(cs-1)*0.2
        local th=tr and ob[tr] and ob[tr].Size.Y or 2
        for p,d in pairs(ob) do
            if p and p.Parent then
                if p.Size then
                    local ns=Vector3.new(d.Size.X*xz,d.Size.Y*cs,d.Size.Z*xz)
                    if ns.X>0 and ns.Y>0 and ns.Z>0 then p.Size=ns end
                end
                if d.Mesh and d.Mesh.Parent then d.Mesh.Scale=Vector3.new(d.MeshScale.X*xz,d.MeshScale.Y*cs,d.MeshScale.Z*xz) end
                if d.Joint and p~=tr and d.Joint.Parent then
                    local o=d.C0
                    if o then
                        local y=o.Y*cs
                        if d.Name and d.Name:find("Leg") then y=o.Y*cs+th*0.5*(1-cs) end
                        if d.Name and d.Name:find("Arm") then y=o.Y*cs+th*0.35*(1-cs) end
                        pcall(function() d.Joint.C0=CFrame.new(o.X,y,o.Z)*o.Rotation end)
                    end
                end
            end
        end
        if tr and ob[tr] and rj and oc1 then
            local vo=(1-cs)*ob[tr].Size.Y*0.5
            pcall(function() rj.C1=oc1*CFrame.new(0,vo,0) end)
        end
    end)
end)
