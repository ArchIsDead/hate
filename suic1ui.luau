-- ignore this UI library
--[[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠛⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠛⢠⡀⠸⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⡁⢰⣋⡇⠀⡿⢢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠁⣏⠉⠛⠳⢤⣟⠀⢧⠀⠀⣀⣤⣠⣤⣄⣀⠀⠀⢷⠀⠀⠈⠙⠢⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡔⠃⣀⠘⢆⣀⠀⠀⠉⠀⠘⠚⠉⠀⠀⢀⡀⠀⢸⠇⣀⢸⡀⠀⠀⠀⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠙⡾⠟⣷⠂⠉⠀⠀⠀⠀⠀⠀⠀⢶⢚⣹⠃⢠⡏⠀⡏⠹⠃⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣼⠇⣰⠀⠀⠀⠠⠶⠳⣦⠀⠀⠀⠘⠲⠃⢠⠟⠁⠀⡏⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠈⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⡟⠷⠟⠁⠀⠀⣴⡆⠀⢸⡇⠀⠀⢠⣄⡴⠏⠀⡀⢰⠇⠀⠀⠀⠀⠀⠀⢠⡾⠚⠋⠉⠉⢳⡀⠀⠀⠀⠀⠀
⠀⢹⡌⠙⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⢧⡐⠶⠄⠀⠀⠻⣃⡀⠸⡷⠀⠀⠀⠹⣆⠀⢀⡿⡏⠀⠀⠀⠀⠀⠀⣠⡾⠀⠀⠀⢀⡴⠟⠁⠀⠀⠀⠀⠀
⠀⠀⢷⠀⠀⠻⣷⣄⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠙⠦⣤⣀⡀⠀⠘⠿⠇⠀⣤⠴⣶⣞⣁⣠⣾⡀⠀⠀⣤⣠⣴⠶⢾⣁⣧⠀⠀⠀⠈⢧⡤⠖⠚⠦⣄⡀⠀
⠀⠀⠘⡇⠀⠀⠈⠻⣷⡀⠀⠀⣠⢾⡉⢉⡍⠙⠳⣶⢟⣯⣭⠿⠷⣤⡀⣠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠚⠻⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠙⣦
⠀⠀⠀⢹⡀⠀⠀⠀⢿⣧⠀⠀⢧⣸⡀⠘⣇⣴⠀⠀⢘⠛⠛⠀⣰⠊⠻⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣤⣄⣄⡓⣶⠏
⠀⠀⠀⠀⣧⠀⠀⠀⠈⣿⣆⣠⣤⣭⡭⠿⣹⣿⡋⠉⠛⠓⠒⠴⠃⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣇⠈⠙⠛⠁⠀
⠀⠀⠀⠀⠈⠳⣄⠀⠀⠸⣿⠉⠀⠈⢻⠞⠙⡾⠁⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣀⣀⣀⣀⣀⣀⣀⣬⠷⠶⠤⢤⣤⣄⣀⣀⣤⣄⡀⣰⠤⢽⠆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠳⣄⠀⢿⣧⠀⠀⠘⠷⠾⠷⣼⣅⣀⣀⠀⠀⠀⠀⠀⠀⠸⡅⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠏⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⢧⡈⡿⣄⣀⣀⣀⣀⣀⣈⣳⣍⠉⠉⠛⢿⡛⢦⡼⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠻⠶⠿⠿⠷⠷⠿⠿⠾⠶⠶⠶⠶⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]--

local lib = {flags = {}, windows = {}, open = true, active = nil, key = Enum.KeyCode.RightControl, base = nil}
local tw = game:GetService("TweenService")
local txt = game:GetService("TextService")
local inp = game:GetService("UserInputService")
local cg = game:GetService("CoreGui")
local hs = game:GetService("HttpService")
local TH = {acc = Color3.fromRGB(255,65,65)}
local crn = {w = 260, p = 8, gh = 28, gap = 6, ogap = 4}
local stk, accs, mem = {}, {}, {}
local flagFns = {}
local dragging, dragStart, startPos, dragWin
local ti = 0

local function cl(v,a,b) return math.max(a,math.min(b,v)) end
local function up4(v) return math.ceil(v / 4) * 4 end
local function c3(h)
    h = tostring(h):gsub("#","")
    if #h == 3 then h = h:gsub("(.)","%1%1") end
    if #h ~= 6 then return nil end
    local r = tonumber(h:sub(1,2),16)
    local g = tonumber(h:sub(3,4),16)
    local b = tonumber(h:sub(5,6),16)
    if not r or not g or not b then return nil end
    return Color3.fromRGB(r,g,b)
end
local function cv(v)
    if typeof(v)=="Color3" then return v end
    if type(v)=="string" then return c3(v) end
    if type(v)=="table" then
        local r,g,b=tonumber(v[1]),tonumber(v[2]),tonumber(v[3])
        if not r or not g or not b then return nil end
        if r<=1 and g<=1 and b<=1 then return Color3.new(r,g,b) end
        return Color3.fromRGB(cl(r,0,255),cl(g,0,255),cl(b,0,255))
    end
    return nil
end
local function hx(c)
    local r = math.floor(c.R * 255 + 0.5)
    local g = math.floor(c.G * 255 + 0.5)
    local b = math.floor(c.B * 255 + 0.5)
    return string.format("%02X%02X%02X",r,g,b)
end
local function mk(class,props)
    local o = Instance.new(class)
    o.Name = ""
    for k,v in pairs(props or {}) do o[k] = v end
    return o
end
local function line(o,color,thick)
    local s = mk("UIStroke",{Color=color or Color3.fromRGB(60,60,65),Thickness=thick or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=o})
    return s
end
local function reg(o,p)
    table.insert(accs,{o=o,p=p})
end
local function at(o,p,v)
    reg(o,p)
    o[p] = v or TH.acc
end
local function twc(o,p,v,t,style)
    if not o or not o.Parent then return end
    tw:Create(o,TweenInfo.new(t or 0.05,style or Enum.EasingStyle.Constant,Enum.EasingDirection.Out),{[p]=v}):Play()
end
local function call(flag,v)
    for _,fn in ipairs(flagFns[flag] or {}) do fn(v) end
end
local function setf(flag,v)
    lib.flags[flag] = v
    call(flag,v)
end
local function tip(text,o)
    if not text or text == "" or not lib.base or not o then return end
    local id = ti + 1
    ti = id
    local pos = inp:GetMouseLocation()
    task.delay(0.4,function()
        if ti ~= id or not o.Parent or not lib.base then return end
        local t = lib._tip
        if not t then
            t = mk("Frame",{Size=UDim2.fromOffset(0,24),Position=UDim2.fromOffset(pos.X+12,pos.Y+12),BackgroundColor3=Color3.fromRGB(15,15,17),BorderSizePixel=0,ZIndex=1000,Parent=lib.base})
            line(t,Color3.fromRGB(60,60,65),1)
            t.l = mk("TextLabel",{Size=UDim2.fromOffset(0,24),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(220,220,220),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=t})
            lib._tip = t
        end
        t.l.Text = tostring(text)
        local x = txt:GetTextSize(tostring(text),12,Enum.Font.Code,Vector2.new(1000,24)).X + 16
        t.Size = UDim2.fromOffset(up4(cl(x,48,240)),24)
        t.Position = UDim2.fromOffset(inp:GetMouseLocation().X+12,inp:GetMouseLocation().Y+12)
        t.Visible = true
    end)
end
local function notip()
    ti = ti + 1
    if lib._tip then lib._tip.Visible = false end
end
local function hookTip(o,d)
    if not d then return end
    o.MouseEnter:Connect(function() tip(d,o) end)
    o.MouseLeave:Connect(notip)
    o.InputChanged:Connect(function() notip() end)
end
local function toast(title,text,dur)
    if not lib.base then return end
    local h = 48
    local fr = mk("Frame",{Size=UDim2.fromOffset(220,h),Position=UDim2.new(1,-228,0,8),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=900,Parent=lib.base})
    line(fr,Color3.fromRGB(60,60,65),1)
    local bar = mk("Frame",{Size=UDim2.fromOffset(2,h),Position=UDim2.fromOffset(0,0),BackgroundColor3=TH.acc,BorderSizePixel=0,ZIndex=901,Parent=fr})
    at(bar,"BackgroundColor3",TH.acc)
    mk("TextLabel",{Size=UDim2.new(1,-16,0,16),Position=UDim2.fromOffset(10,6),BackgroundTransparency=1,Text=tostring(title or "Notification"),TextColor3=Color3.fromRGB(240,240,240),TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=902,Parent=fr})
    mk("TextLabel",{Size=UDim2.new(1,-16,0,20),Position=UDim2.fromOffset(10,23),BackgroundTransparency=1,Text=tostring(text or ""),TextColor3=Color3.fromRGB(140,140,150),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=902,Parent=fr})
    for _,v in ipairs(stk) do if v.Parent then v.Position = UDim2.new(1,-228,0,8 + (#stk - table.find(stk,v) + 1) * 54) end end
    table.insert(stk,fr)
    task.delay(tonumber(dur) or 4,function()
        local i = table.find(stk,fr)
        if i then table.remove(stk,i) end
        if fr.Parent then fr:Destroy() end
        for n,v in ipairs(stk) do if v.Parent then v.Position = UDim2.new(1,-228,0,8 + (n-1)*54) end end
    end)
end
local function styleBase(o)
    o.BackgroundColor3 = Color3.fromRGB(30,30,33)
    o.BorderSizePixel = 0
    line(o,Color3.fromRGB(60,60,65),1)
end
local function fmt(v,prefix,suffix)
    return tostring(prefix or "")..tostring(v)..tostring(suffix or "")
end
local function makeOption(parent,h,order)
    local o = mk("Frame",{Size=UDim2.new(1,-16,0,h),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=order,Parent=parent})
    return o
end

local function makeGroup(title,parent,root)
    local g = {title=tostring(title),options={},parent=parent,open=true,root=root,main=nil,lay=nil,body=nil,head=nil,under=nil,arrow=nil}
    function g:SetTitle(v) self.title=tostring(v); if self.tt then self.tt.Text=self.title end end
    local function add(kind,o)
        o = type(o)=="table" and o or {}
        o.text = tostring(o.text or o.Text or "")
        o.desc = o.desc or o.description or o.Description
        o.kind = kind
        o.position = #g.options + 1
        table.insert(g.options,o)
        return o
    end
    local function mount(o)
        if lib.base and g.body then lib._build(g,o) end
    end
    function g:AddLabel(o) local x=add("label",o); mount(x); return x end
    function g:AddToggle(o) local x=add("toggle",o); x.flag=x.flag or x.text; x.state=type(x.state)=="boolean" and x.state or x.default==true; x.cb=x.callback or function() end; if lib.flags[x.flag]==nil then setf(x.flag,x.state) else x.state=lib.flags[x.flag] end; mount(x); return x end
    function g:AddButton(o) local x=add("button",o); x.flag=x.flag or x.text; x.cb=x.callback or function() end; if lib.flags[x.flag]==nil then setf(x.flag,false) end; mount(x); return x end
    function g:AddBind(o) local x=add("bind",o); x.flag=x.flag or x.text; x.key=(x.key and x.key.Name) or x.key or "F"; x.hold=x.hold==true or x.mode=="Hold"; x.cb=x.callback or function() end; setf(x.flag,x.key); mount(x); return x end
    function g:AddSlider(o) local x=add("slider",o); x.flag=x.flag or x.text; x.min=type(x.min)=="number" and x.min or 0; x.max=type(x.max)=="number" and x.max or 100; x.step=type(x.step)=="number" and x.step or type(x.rounding)=="number" and x.rounding or 1; if x.max<x.min then x.min,x.max=x.max,x.min end; x.prefix=x.prefix or ""; x.suffix=x.suffix or ""; if x.max==x.min then x.max=x.min+1 end; x.value=cl(type(x.value)=="number" and x.value or x.min,x.min,x.max); x.cb=x.callback or function() end; setf(x.flag,x.value); mount(x); return x end
    function g:AddList(o) local x=add("list",o); x.flag=x.flag or x.text; x.values=type(x.values)=="table" and x.values or {}; x.searchable=x.searchable==true or x.Searchable==true; x.multi=x.multi==true or x.Multi==true; x.value=x.value~=nil and x.value or (x.multi and {} or x.values[1] or ""); x.cb=x.callback or function() end; setf(x.flag,x.value); mount(x); return x end
    function g:AddBox(o) local x=add("box",o); x.flag=x.flag or x.text; x.value=tostring(x.value or x.default or ""); x.placeholder=x.placeholder or x.Placeholder or ""; x.numeric=x.numeric==true or x.Numeric==true; x.cb=x.callback or function() end; setf(x.flag,x.value); mount(x); return x end
    function g:AddColor(o) local x=add("color",o); x.flag=x.flag or x.text; x.color=cv(x.color or "FFFFFF") or Color3.fromRGB(255,255,255); x.cb=x.callback or function() end; setf(x.flag,x.color); mount(x); return x end
    function g:AddDropdown(o) return self:AddList(o) end
    function g:AddInput(o) return self:AddBox(o) end
    function g:AddKeybind(o) return self:AddBind(o) end
    function g:AddColorPicker(o) return self:AddColor(o) end
    function g:AddParagraph(o)
        o=type(o)=="table" and o or {text=tostring(o or "")}
        o.text=tostring(o.text or o.title or o.Text or "")
        o.desc=o.desc or o.description or o.Description
        o.kind="label"
        o.position=#g.options+1
        table.insert(g.options,o)
        if lib.base and g.body then lib._build(g,o) end
        return o
    end
    function g:AddSection(o) return self:AddLabel(o) end
    function g:AddDivider(o) return self:AddLabel({text="",desc=type(o)=="table" and (o.desc or o.description) or nil}) end
    function g:AddFolder(v)
        local x=makeGroup(v,g,false)
        x.position=#g.options+1
        x.kind="folder"
        table.insert(g.options,x)
        mount(x)
        return x
    end
    return g
end

local function finish(parent)
    local lay = parent.lay
    local y = up4(lay.AbsoluteContentSize.Y)
    parent.body.CanvasSize = UDim2.fromOffset(0,y+6)
end
local function groupResize(g)
    if not g.lay or not g.main then return end
    local y = up4(g.lay.AbsoluteContentSize.Y + 12)
    if g.open then g.targetH = crn.gh + y else g.targetH = crn.gh end
    if not g.root and g.clip then g.clip.Size = UDim2.new(1,0,0,g.targetH) end
end
local function buildGroup(g,isRoot,p)
    p = p or g.parent
    local main = mk("Frame",{Size=UDim2.new(1,0,0,crn.gh),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,LayoutOrder=g.position or 1,Parent=p})
    styleBase(main)
    g.main=main
    if not isRoot then g.clip=main end
    local hd = mk("TextButton",{AutoButtonColor=false,Text="",Size=UDim2.new(1,0,0,crn.gh),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,Parent=main})
    g.head=hd
    line(hd,Color3.fromRGB(60,60,65),1)
    g.tt=mk("TextLabel",{Size=UDim2.new(1,-52,1,0),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,Text=g.title,TextColor3=Color3.fromRGB(240,240,240),TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=hd})
    g.arrow=mk("TextLabel",{Size=UDim2.fromOffset(28,28),Position=UDim2.new(1,-28,0,0),BackgroundTransparency=1,Text=g.open and "-" or "+",TextColor3=TH.acc,TextSize=16,Font=Enum.Font.Code,Parent=hd})
    at(g.arrow,"TextColor3",TH.acc)
    g.under=mk("Frame",{Size=UDim2.new(1,0,0,g.open and 2 or 1),Position=UDim2.new(0,0,1,-(g.open and 2 or 1)),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=hd})
    at(g.under,"BackgroundColor3",TH.acc)
    g.body=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,-40),Position=UDim2.fromOffset(0,34),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=isRoot and 3 or 0,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.fromOffset(0,0),Parent=main})
    g.lay=mk("UIListLayout",{Padding=UDim.new(0,crn.ogap),SortOrder=Enum.SortOrder.LayoutOrder,Parent=g.body})
    g.lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() finish(g); groupResize(g) end)
    hd.Activated:Connect(function()
        g.open=not g.open
        g.arrow.Text=g.open and "-" or "+"
        twc(g.under,"Size",UDim2.new(1,0,0,g.open and 2 or 1),0.05,Enum.EasingStyle.Constant)
        twc(g.arrow,"TextColor3",TH.acc,0.05,Enum.EasingStyle.Constant)
        if g.open then
            local h=up4(g.lay.AbsoluteContentSize.Y+12)
            g.main.Size=UDim2.new(1,0,0,crn.gh+ h)
            tw:Create(g.body,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,1,-40)}):Play()
        else
            tw:Create(g.body,TweenInfo.new(0.15,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,0,0)}):Play()
            g.main.Size=UDim2.new(1,0,0,crn.gh)
        end
        if g.root then finish(g) end
    end)
    hookTip(hd,g.desc)
    if g.root then
        main.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                if i.Position.Y <= main.AbsolutePosition.Y + crn.gh then
                    dragging=true; dragWin=g; dragStart=i.Position; startPos=main.Position
                end
            end
        end)
    end
    for _,o in ipairs(g.options) do lib._build(g,o) end
    groupResize(g)
    return g
end

function lib._build(g,o)
    if o.kind=="folder" then
        buildGroup(o,false,g.body)
        return
    end
    if o.kind=="label" then
        local m=makeOption(g.body,24,o.position)
        mk("TextLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        hookTip(m,o.desc)
        o.main=m
    elseif o.kind=="toggle" then
        local m=makeOption(g.body,24,o.position)
        local bg=mk("Frame",{Size=UDim2.fromOffset(34,16),Position=UDim2.new(1,-34,0,4),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(bg,Color3.fromRGB(60,60,65),1)
        local fill=mk("Frame",{Size=UDim2.fromOffset(o.state and 30 or 0,12),Position=UDim2.fromOffset(2,2),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=bg})
        at(fill,"BackgroundColor3",TH.acc)
        local knob=mk("Frame",{Size=UDim2.fromOffset(10,10),Position=UDim2.fromOffset(o.state and 21 or 3,3),BackgroundColor3=o.state and Color3.fromRGB(255,255,255) or Color3.fromRGB(140,140,150),BorderSizePixel=0,Parent=bg})
        mk("TextLabel",{Size=UDim2.new(1,-44,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local bt=mk("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text="",Parent=m})
        o.SetState=function(s,v) o.state=v==true; setf(o.flag,o.state); twc(fill,"Size",UDim2.fromOffset(o.state and 30 or 0,12),0.1,Enum.EasingStyle.Linear); twc(knob,"Position",UDim2.fromOffset(o.state and 21 or 3,3),0.1,Enum.EasingStyle.Linear); twc(fill,"BackgroundColor3",TH.acc,0.05,Enum.EasingStyle.Constant); o.cb(o.state) end
        bt.Activated:Connect(function() o.SetState(o,not o.state) end)
        hookTip(m,o.desc)
        o.main=m
    elseif o.kind=="button" then
        local m=makeOption(g.body,28,o.position)
        local bg=mk("TextButton",{AutoButtonColor=false,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(bg,Color3.fromRGB(60,60,65),1)
        bg.MouseEnter:Connect(function() twc(bg,"BackgroundColor3",TH.acc,0.05,Enum.EasingStyle.Constant) end)
        bg.MouseLeave:Connect(function() twc(bg,"BackgroundColor3",Color3.fromRGB(20,20,22),0.05,Enum.EasingStyle.Constant) end)
        bg.Activated:Connect(function() setf(o.flag,true); o.cb() end)
        hookTip(bg,o.desc)
        o.main=m; o.button=bg
    elseif o.kind=="bind" then
        local m=makeOption(g.body,24,o.position)
        mk("TextLabel",{Size=UDim2.new(1,-84,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local bg=mk("TextButton",{AutoButtonColor=false,Text=o.key,TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(68,20),Position=UDim2.new(1,-68,0,2),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=m})
        at(bg,"BackgroundColor3",TH.acc)
        local cap=false
        o.SetKey=function(s,k) s.key=(typeof(k)=="EnumItem" and k.Name) or tostring(k or s.key); setf(s.flag,s.key); bg.Text=s.key end
        bg.Activated:Connect(function() cap=true; bg.Text="..." end)
        inp.InputBegan:Connect(function(i,gp)
            if gp or inp:GetFocusedTextBox() then return end
            local nm=i.KeyCode~=Enum.KeyCode.Unknown and i.KeyCode.Name or i.UserInputType.Name
            if cap then if nm~="Unknown" and nm~="MouseMovement" then cap=false; o.SetKey(o,nm) end return end
            if nm==o.key then if o.hold then o.cb(true) else o.cb() end end
        end)
        inp.InputEnded:Connect(function(i)
            local nm=i.KeyCode~=Enum.KeyCode.Unknown and i.KeyCode.Name or i.UserInputType.Name
            if nm==o.key and o.hold then o.cb(false) end
        end)
        hookTip(bg,o.desc)
        o.main=m; o.bind=bg
    elseif o.kind=="slider" then
        local m=makeOption(g.body,32,o.position)
        local lb=mk("TextLabel",{Size=UDim2.new(0.6,0,0,16),Position=UDim2.fromOffset(0,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local vb=mk("TextLabel",{Size=UDim2.new(0.4,0,0,16),Position=UDim2.new(0.6,0,0,0),BackgroundTransparency=1,Text=fmt(o.value,o.prefix,o.suffix),TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Right,Parent=m})
        local tr=mk("Frame",{Size=UDim2.new(1,0,0,4),Position=UDim2.fromOffset(0,22),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(tr,Color3.fromRGB(60,60,65),1)
        local fi=mk("Frame",{Size=UDim2.new((o.value-o.min)/(o.max-o.min),0,1,0),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=tr})
        at(fi,"BackgroundColor3",TH.acc)
        local ha=mk("Frame",{Size=UDim2.fromOffset(8,8),AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new((o.value-o.min)/(o.max-o.min),0,0.5,0),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=tr})
        local hold=false
        o.SetValue=function(s,v)
            v=tonumber(v) or s.value
            v=cl(v,s.min,s.max)
            v=math.floor(v/s.step+0.5)*s.step
            v=cl(v,s.min,s.max)
            s.value=v; setf(s.flag,v); vb.Text=fmt(v,s.prefix,s.suffix)
            fi.Size=UDim2.new((v-s.min)/(s.max-s.min),0,1,0)
            ha.Position=UDim2.new((v-s.min)/(s.max-s.min),0,0.5,0)
            s.cb(v)
        end
        local hit=mk("TextButton",{AutoButtonColor=false,Text="",BackgroundTransparency=1,Size=UDim2.new(1,0,0,16),Position=UDim2.fromOffset(0,16),Parent=m})
        local function setp(x) local a=cl((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1); o.SetValue(o,o.min+a*(o.max-o.min)) end
        hit.Activated:Connect(function(i) hold=true; setp(i.Position.X) end)
        inp.InputChanged:Connect(function(i) if hold and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then setp(i.Position.X) end end)
        inp.InputEnded:Connect(function(i) if hold and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then hold=false end end)
        hookTip(m,o.desc)
        o.main=m; o.slider=tr
    elseif o.kind=="list" then
        local m=makeOption(g.body,40,o.position)
        local lb=mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.fromOffset(0,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local bg=mk("TextButton",{AutoButtonColor=false,Text="",Size=UDim2.new(1,0,0,24),Position=UDim2.fromOffset(0,16),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(bg,Color3.fromRGB(60,60,65),1)
        local vl=mk("TextLabel",{Size=UDim2.new(1,-20,1,0),Position=UDim2.fromOffset(8,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Parent=bg})
        local pop,search
        local function disp(v)
            if o.multi and type(v)=="table" then
                local q={}
                for _,x in ipairs(v) do table.insert(q,tostring(x)) end
                return table.concat(q,", ")
            end
            return tostring(v)
        end
        vl.Text=disp(o.value)
        o.SetValue=function(s,v)
            s.value=v; setf(s.flag,v); vl.Text=disp(v); s.cb(v)
        end
        local function closep() if pop then pop.Visible=false end; if o.shadow then o.shadow.Visible=false end; if lib.active==o then lib.active=nil end end
        local function openp()
            if lib.active and lib.active~=o and lib.active.Close then lib.active.Close(lib.active) end
            if not lib.base then return end
            if not pop then
                local sh=mk("Frame",{Size=UDim2.fromOffset(bg.AbsoluteSize.X+1,1),Position=UDim2.fromOffset(bg.AbsolutePosition.X+1,bg.AbsolutePosition.Y+44+1),BackgroundColor3=Color3.fromRGB(10,10,10),BorderSizePixel=0,ZIndex=950,Parent=lib.base})
                pop=mk("Frame",{Size=UDim2.fromOffset(bg.AbsoluteSize.X,24),Position=UDim2.fromOffset(bg.AbsolutePosition.X,bg.AbsolutePosition.Y+44),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,ZIndex=951,Parent=lib.base})
                o.shadow=sh; o.pop=pop
                line(pop,Color3.fromRGB(60,60,65),1)
                if o.searchable then
                    search=mk("TextBox",{Size=UDim2.new(1,-8,0,24),Position=UDim2.fromOffset(4,4),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text="",PlaceholderText="Search",TextColor3=Color3.fromRGB(240,240,240),PlaceholderColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,ZIndex=953,Parent=pop})
                    line(search,Color3.fromRGB(60,60,65),1)
                    search:GetPropertyChangedSignal("Text"):Connect(function() openp() end)
                end
                o.Close=closep
            end
            pop.Visible=true; pop.Position=UDim2.fromOffset(bg.AbsolutePosition.X,bg.AbsolutePosition.Y+44); pop.Size=UDim2.fromOffset(bg.AbsoluteSize.X,24); if o.shadow then o.shadow.Visible=true end; lib.active=o
            local top=o.searchable and 28 or 4
            for _,v in ipairs(pop:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
            local list= {}
            for _,v in ipairs(o.values) do table.insert(list,v) end
            local n=0
            for _,v in ipairs(list) do
                local s=disp(o.value)
                local t=tostring(v)
                local show=true
                if o.searchable and search and search.Text~="" then show=t:lower():find(search.Text:lower(),1,true)~=nil end
                if show then
                    n=n+1
                    local b=mk("TextButton",{AutoButtonColor=false,Text=t,TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,-8,0,24),Position=UDim2.fromOffset(4,top),BackgroundColor3=table.find(type(o.value)=="table" and o.value or {},v) and TH.acc or Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=954,Parent=pop})
                    if not o.multi and tostring(o.value)==t then b.BackgroundColor3=TH.acc end
                    b.Activated:Connect(function()
                        if o.multi then
                            local q=type(o.value)=="table" and table.clone(o.value) or {}
                            local i=table.find(q,v)
                            if i then table.remove(q,i) else table.insert(q,v) end
                            o.SetValue(o,q)
                        else o.SetValue(o,v); closep() end
                        openp()
                    end)
                end
                if n>=6 then break end
            end
            local ph=cl(top+n*24+4,28,180)
            pop.Size=UDim2.fromOffset(bg.AbsoluteSize.X,ph)
            if o.shadow then o.shadow.Size=UDim2.fromOffset(bg.AbsoluteSize.X+1,ph+1); o.shadow.Position=UDim2.fromOffset(bg.AbsolutePosition.X+1,bg.AbsolutePosition.Y+45) end
        end
        bg.Activated:Connect(openp)
        hookTip(m,o.desc)
        o.main=m; o.list=bg; o.Refresh=openp
    elseif o.kind=="box" then
        local m=makeOption(g.body,40,o.position)
        mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.fromOffset(0,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local ip=mk("TextBox",{Size=UDim2.new(1,0,0,24),Position=UDim2.fromOffset(0,16),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text=o.value,PlaceholderText=o.placeholder,TextColor3=Color3.fromRGB(240,240,240),PlaceholderColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=m})
        line(ip,Color3.fromRGB(60,60,65),1)
        o.SetValue=function(s,v,enter) v=tostring(v or ""); if s.numeric and not tonumber(v) then v=s.value end; s.value=v; ip.Text=v; setf(s.flag,v); s.cb(v,enter) end
        ip.FocusLost:Connect(function(e) o.SetValue(o,ip.Text,e) end)
        hookTip(ip,o.desc)
        o.main=m; o.input=ip
    elseif o.kind=="color" then
        local m=makeOption(g.body,24,o.position)
        mk("TextLabel",{Size=UDim2.new(1,-36,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local sw=mk("TextButton",{AutoButtonColor=false,Text="",Size=UDim2.fromOffset(16,16),Position=UDim2.new(1,-16,0,4),BackgroundColor3=o.color,BorderSizePixel=0,Parent=m})
        at(sw,"BorderColor3",TH.acc)
        local s=line(sw,TH.acc,1); reg(s,"Color")
        local pop
        local hue=0
        o.SetColor=function(s,c) c=cv(c); if not c then return end; s.color=c; sw.BackgroundColor3=c; setf(s.flag,c); if s.pv then s.pv.BackgroundColor3=c end; if s.hx then s.hx.Text="#"..hx(c) end; s.cb(c) end
        local function closep() if pop then pop.Visible=false end; if lib.active==o then lib.active=nil end end
        local function openp()
            if lib.active and lib.active~=o and lib.active.Close then lib.active.Close(lib.active) end
            if not pop then
                pop=mk("Frame",{Size=UDim2.fromOffset(228,196),Position=UDim2.fromOffset(sw.AbsolutePosition.X-212,sw.AbsolutePosition.Y+28),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,ZIndex=960,Parent=lib.base}); line(pop,Color3.fromRGB(60,60,65),1)
                local sv=mk("Frame",{Size=UDim2.fromOffset(170,118),Position=UDim2.fromOffset(8,8),BackgroundColor3=Color3.fromRGB(255,0,0),BorderSizePixel=0,ZIndex=961,Parent=pop})
                local grid=mk("Frame",{Size=UDim2.fromOffset(170,120),Position=UDim2.fromOffset(0,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=962,Parent=sv})
                local gl=mk("UIGridLayout",{CellSize=UDim2.fromOffset(10,10),CellPadding=UDim2.fromOffset(0,0),FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Parent=grid})
                local tiles={}
                for ry=0,11 do
                    for cx=0,16 do
                        local tile=mk("Frame",{Size=UDim2.fromOffset(10,10),BackgroundColor3=Color3.fromHSV(0,cx/16,1-ry/11),BorderSizePixel=0,ZIndex=963,LayoutOrder=ry*17+cx,Parent=grid})
                        table.insert(tiles,tile)
                    end
                end
                local sat=mk("TextButton",{AutoButtonColor=false,Text="",BackgroundTransparency=1,Size=UDim2.fromScale(1,1),ZIndex=964,Parent=sv})
                local hb=mk("Frame",{Size=UDim2.fromOffset(18,118),Position=UDim2.fromOffset(186,8),BorderSizePixel=0,ZIndex=962,Parent=pop})
                mk("UIGradient",{Rotation=90,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(0.17,Color3.fromRGB(255,255,0)),ColorSequenceKeypoint.new(0.33,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,255,255)),ColorSequenceKeypoint.new(0.67,Color3.fromRGB(0,0,255)),ColorSequenceKeypoint.new(0.83,Color3.fromRGB(255,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))}),Parent=hb})
                local hndl=mk("Frame",{Size=UDim2.fromOffset(20,2),Position=UDim2.fromOffset(-1,58),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=964,Parent=hb})
                local pv=mk("Frame",{Size=UDim2.fromOffset(40,40),Position=UDim2.fromOffset(8,134),BackgroundColor3=o.color,BorderSizePixel=0,ZIndex=962,Parent=pop}); line(pv,TH.acc,1); local ps=pv:FindFirstChildOfClass("UIStroke"); reg(ps,"Color")
                local hxbox=mk("TextBox",{Size=UDim2.fromOffset(154,24),Position=UDim2.fromOffset(58,134),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text="#"..hx(o.color),TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=963,Parent=pop}); line(hxbox,Color3.fromRGB(60,60,65),1)
                o.pv=pv; o.hx=hxbox; o.pop=pop
                local h,s,v=o.color:ToHSV(); hue=h
                local function paintGrid(hh)
                    for ry=0,11 do for cx=0,16 do tiles[ry*17+cx+1].BackgroundColor3=Color3.fromHSV(hh,cx/16,1-ry/11) end end
                end
                local function upd(c)
                    o.SetColor(o,c)
                    local hh,satv,val=c:ToHSV(); hue=hh; s=satv; v=val; paintGrid(hh); local hp=cl(math.floor((1-hh)*116),0,116); hndl.Position=UDim2.fromOffset(-1,hp)
                end
                sv.BackgroundColor3=Color3.fromRGB(30,30,33)
                paintGrid(h)
                sat.Activated:Connect(function(i) local ax=cl((i.Position.X-sv.AbsolutePosition.X)/sv.AbsoluteSize.X,0,1); local ay=cl((i.Position.Y-sv.AbsolutePosition.Y)/sv.AbsoluteSize.Y,0,1); upd(Color3.fromHSV(hue,ax,1-ay)) end)
                hb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then local ay=cl((i.Position.Y-hb.AbsolutePosition.Y)/hb.AbsoluteSize.Y,0,1); upd(Color3.fromHSV(1-ay,s, v)) end end)
                hxbox.FocusLost:Connect(function() local c=c3(hxbox.Text); if c then upd(c) else hxbox.Text="#"..hx(o.color) end end)
                o.Close=closep
            end
            pop.Visible=true; pop.Position=UDim2.fromOffset(cl(sw.AbsolutePosition.X-212,0,100000),sw.AbsolutePosition.Y+28); lib.active=o
        end
        sw.Activated:Connect(openp)
        hookTip(m,o.desc)
        o.main=m; o.sw=sw
    end
end

function lib:CreateWindow(title)
    local w=makeGroup(title,nil,true)
    w.win=self
    w.open=true
    w.SetIcon=function(s,v)
        s.icon=v
        if s.ic then s.ic.Image=v or ""; s.ic.Visible=v~=nil end
    end
    table.insert(self.windows,w)
    lib._bindAliases(w)
    if self.base then lib._mountWindow(w) end
    return w
end
function lib._bindAliases(w)
    w.AddDropdown=w.AddDropdown or function(s,o) return s:AddList(o) end
    w.AddInput=w.AddInput or function(s,o) return s:AddBox(o) end
    w.AddKeybind=w.AddKeybind or function(s,o) return s:AddBind(o) end
    w.AddColorPicker=w.AddColorPicker or function(s,o) return s:AddColor(o) end
    w.AddParagraph=w.AddParagraph or function(s,o) return s:AddLabel(o) end
    return w
end
function lib._mountWindow(w)
    local cam=workspace.CurrentCamera
    local vh=cam and cam.ViewportSize.Y or 720
    local wh=up4(cl(vh*0.7,280,560))
    local main=mk("Frame",{Name="",Size=UDim2.fromOffset(crn.w,wh),Position=UDim2.fromOffset(cl((cam and cam.ViewportSize.X or 800)/2-crn.w/2,8,(cam and cam.ViewportSize.X or 800)-crn.w-8),cl((vh-wh)/2,-28,vh-12)),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,Parent=lib.base})
    styleBase(main)
    w.main=main
    w.body=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,-40),Position=UDim2.fromOffset(0,34),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.fromOffset(0,0),Parent=main})
    w.lay=mk("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder,Parent=w.body})
    w.under=mk("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.fromOffset(0,26),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=main}); at(w.under,"BackgroundColor3",TH.acc)
    w.head=mk("Frame",{Size=UDim2.new(1,0,0,28),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=main}); line(w.head,Color3.fromRGB(60,60,65),1)
    w.ic=mk("ImageLabel",{Size=UDim2.fromOffset(16,16),Position=UDim2.fromOffset(6,6),BackgroundTransparency=1,Visible=w.icon~=nil,Image=w.icon or "",Parent=w.head})
    w.tt=mk("TextLabel",{Size=UDim2.new(1,-82,1,0),Position=UDim2.fromOffset(w.icon and 28 or 8,0),BackgroundTransparency=1,Text=w.title,TextColor3=Color3.fromRGB(240,240,240),TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=w.head})
    local set=mk("TextButton",{AutoButtonColor=false,Text="=",TextColor3=TH.acc,TextSize=13,Font=Enum.Font.Code,Size=UDim2.fromOffset(20,20),Position=UDim2.fromOffset(190,4),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=w.head})
    local min=mk("TextButton",{AutoButtonColor=false,Text="-",TextColor3=Color3.fromRGB(240,240,240),TextSize=14,Font=Enum.Font.Code,Size=UDim2.fromOffset(20,20),Position=UDim2.fromOffset(212,4),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=w.head})
    local cls=mk("TextButton",{AutoButtonColor=false,Text="x",TextColor3=Color3.fromRGB(240,240,240),TextSize=13,Font=Enum.Font.Code,Size=UDim2.fromOffset(20,20),Position=UDim2.fromOffset(234,4),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=w.head})
    at(set,"TextColor3",TH.acc)
    local sp=mk("Frame",{Visible=false,Size=UDim2.fromOffset(154,52),Position=UDim2.fromOffset(100,30),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,ZIndex=970,Parent=main}); line(sp,Color3.fromRGB(60,60,65),1)
    local sk=mk("TextLabel",{Size=UDim2.new(1,-8,0,20),Position=UDim2.fromOffset(4,4),BackgroundTransparency=1,Text="Key: "..w.win.key.Name,TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=971,Parent=sp}); lib._keyLabels=lib._keyLabels or {}; table.insert(lib._keyLabels,sk)
    local rc=mk("TextButton",{AutoButtonColor=false,Text="Center",TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(68,22),Position=UDim2.fromOffset(4,26),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=971,Parent=sp}); line(rc,Color3.fromRGB(60,60,65),1)
    local ss=mk("TextButton",{AutoButtonColor=false,Text="Close",TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(68,22),Position=UDim2.fromOffset(80,26),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=971,Parent=sp}); line(ss,Color3.fromRGB(60,60,65),1)
    set.Activated:Connect(function() sp.Visible=not sp.Visible end)
    rc.Activated:Connect(function() local c=workspace.CurrentCamera; if c then main.Position=UDim2.fromOffset(c.ViewportSize.X/2-crn.w/2,cl(c.ViewportSize.Y/2-main.AbsoluteSize.Y/2,-28,c.ViewportSize.Y-12)) end end)
    ss.Activated:Connect(function() sp.Visible=false end)
    min.Activated:Connect(function() w.open=not w.open; w.body.Visible=w.open; w.body.Size=w.open and UDim2.new(1,0,1,-40) or UDim2.new(1,0,0,0) end)
    cls.Activated:Connect(function() lib:Close() end)
    w.head.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then if i.Position.X<188 then dragging=true; dragWin=w; dragStart=i.Position; startPos=main.Position end end end)
    hookTip(set,"Settings")
    w.lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() w.body.CanvasSize=UDim2.fromOffset(0,up4(w.lay.AbsoluteContentSize.Y)+6) end)
    for _,o in ipairs(w.options) do lib._build(w,o) end
    w.init=true
end
function lib:Search(text)
    text=tostring(text or ""):lower()
    for _,w in ipairs(self.windows) do
        for _,o in ipairs(w.options or {}) do
            local t=tostring(o.text or o.title or ""):lower()
            if o.main then o.main.Visible=(text=="" or t:find(text,1,true)~=nil) end
        end
    end
end
function lib:Init()
    if self.base and self.base.Parent then return self.base end
    self.base=mk("ScreenGui",{Name="",ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=cg})
    if syn and typeof(syn.protect_gui)=="function" then pcall(function() syn.protect_gui(self.base) end) end
    if typeof(gethui)=="function" then self.base.Parent=gethui() else self.base.Parent=cg end
    for _,w in ipairs(self.windows) do if not w.init then lib._mountWindow(w) end end
    return self.base
end
function lib:Close()
    self.open=not self.open
    if self.active and self.active.Close then self.active.Close(self.active) end
    for _,w in ipairs(self.windows) do if w.main then w.main.Visible=self.open end end
end
function lib:Notify(title,text,duration) toast(title,text,duration) end
function lib:OnFlagChange(flag,fn)
    if type(fn)~="function" then return {Disconnect=function() end} end
    flagFns[flag]=flagFns[flag] or {}
    table.insert(flagFns[flag],fn)
    local dead=false
    return {Disconnect=function() if dead then return end; dead=true; local t=flagFns[flag]; local i=table.find(t,fn); if i then table.remove(t,i) end end}
end
function lib:SetAccent(c)
    if typeof(c)~="Color3" then return end
    TH.acc=c
    for _,x in ipairs(accs) do if x.o and x.o.Parent then twc(x.o,x.p,c,0.05,Enum.EasingStyle.Constant) end end
end
function lib:SetKeybind(k)
    if typeof(k)=="EnumItem" then
        self.key=k
        for _,v in ipairs(self._keyLabels or {}) do if v.Parent then v.Text="Key: "..k.Name end end
    end
end
local function ser(v)
    local t=typeof(v)
    if t=="Color3" then return {__c=hx(v)} end
    if t=="table" then local q={}; for k,x in pairs(v) do q[k]=ser(x) end; return q end
    return v
end
local function des(v)
    if type(v)~="table" then return v end
    if v.__c then return c3(v.__c) end
    local q={}; for k,x in pairs(v) do q[k]=des(x) end; return q
end
local function each(o)
    for _,x in ipairs(o.options or {}) do
        if x.flag and x.SetValue then coroutine.yield(x) end
        if x.kind=="toggle" and x.SetState then coroutine.yield(x) end
        if x.kind=="bind" and x.SetKey then coroutine.yield(x) end
        if x.kind=="color" and x.SetColor then coroutine.yield(x) end
        if x.kind=="folder" then each(x) end
    end
end
local function findflag(flag)
    for _,w in ipairs(lib.windows) do
        for x in coroutine.wrap(function() each(w) end) do if x.flag==flag then return x end end
    end
end
local function write(path,data)
    if typeof(writefile)=="function" then local ok=pcall(function() writefile(path,data) end); if ok then mem[path]=data end; return ok end
    mem[path]=data
    return false
end
local function read(path)
    if typeof(isfile)=="function" and isfile(path) and typeof(readfile)=="function" then local ok,v; ok,v=pcall(function() return readfile(path) end); if ok then return v end end
    return mem[path]
end
function lib:SaveConfig(name)
    name=tostring(name or "default")
    local ok,data=pcall(function() return hs:JSONEncode(ser(self.flags)) end)
    if not ok then return false end
    if typeof(makefolder)=="function" and typeof(isfolder)=="function" and not isfolder("suic1UI") then makefolder("suic1UI") end
    local path="suic1UI/"..name..".json"
    local ok=write(path,data)
    return ok or mem[path]~=nil
end
function lib:LoadConfig(name)
    name=tostring(name or "default")
    local path="suic1UI/"..name..".json"
    local data=read(path)
    if not data then return false end
    local ok,q=pcall(function() return hs:JSONDecode(data) end)
    if not ok or type(q)~="table" then return false end
    q=des(q)
    for k,v in pairs(q) do
        local o=findflag(k)
        if o then
            if o.SetState and type(v)=="boolean" then o:SetState(v)
            elseif o.SetValue then o:SetValue(v)
            elseif o.SetKey then o:SetKey(v)
            elseif o.SetColor then o:SetColor(v) end
        end
    end
    return true
end
function lib:DeleteConfig(name)
    name=tostring(name or "default")
    local path="suic1UI/"..name..".json"
    mem[path]=nil
    if typeof(isfile)=="function" and isfile(path) and typeof(delfile)=="function" then delfile(path); return true end
    return false
end
function lib:ListConfigs()
    local q={}
    for p in pairs(mem) do local n=p:match("^suic1UI/(.+)%.json$"); if n then table.insert(q,n) end end
    table.sort(q)
    return q
end
inp.InputChanged:Connect(function(i)
    if not dragging or not dragWin or not dragWin.main then return end
    if i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch then return end
    local d=i.Position-dragStart
    local cam=workspace.CurrentCamera
    if not cam then return end
    local x=cl(startPos.X.Offset+d.X,0,cam.ViewportSize.X-crn.w)
    local y=cl(startPos.Y.Offset+d.Y,-28,cam.ViewportSize.Y-12)
    dragWin.main.Position=UDim2.fromOffset(x,y)
end)
inp.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false; dragWin=nil end
end)
inp.InputBegan:Connect(function(i,gp)
    if gp or inp:GetFocusedTextBox() then return end
    local nm=i.KeyCode~=Enum.KeyCode.Unknown and i.KeyCode or i.UserInputType
    if nm==lib.key then lib:Close() end
    if lib.active and (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) then
        local p=lib.active.pop or lib.active.main
        if p and (i.Position.X<p.AbsolutePosition.X or i.Position.X>p.AbsolutePosition.X+p.AbsoluteSize.X or i.Position.Y<p.AbsolutePosition.Y or i.Position.Y>p.AbsolutePosition.Y+p.AbsoluteSize.Y) then lib.active:Close() end
    end
end)

return lib
