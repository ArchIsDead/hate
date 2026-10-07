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

local lib = {flags = {}, windows = {}, open = true, active = nil, key = Enum.KeyCode.RightControl, base = nil, version = "librarynew-plus", Options = {}, Toggles = {}, Signals = {}, Unloaded = false, ShowToggleFrameInKeybinds = true, ForceCheckbox = false, CornerRadius = 0}
local tw = game:GetService("TweenService")
local txt = game:GetService("TextService")
local inp = game:GetService("UserInputService")
local cg = game:GetService("CoreGui")
local hs = game:GetService("HttpService")
local pl = game:GetService("Players")
local tm = game:GetService("Teams")
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
    for k,v in pairs(props or {}) do o[k] = v end
    o.Name = ""
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
    for _,fn in ipairs(flagFns[flag] or {}) do pcall(fn,v) end
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
    local left=lib.NotifySide=="Left"
    local px=left and 8 or -228
    local fr = mk("Frame",{Size=UDim2.fromOffset(220,h),Position=UDim2.new(left and 0 or 1,px,0,8),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=900,Parent=lib.base})
    line(fr,Color3.fromRGB(60,60,65),1)
    local bar = mk("Frame",{Size=UDim2.fromOffset(2,h),Position=UDim2.fromOffset(0,0),BackgroundColor3=TH.acc,BorderSizePixel=0,ZIndex=901,Parent=fr})
    at(bar,"BackgroundColor3",TH.acc)
    mk("TextLabel",{Size=UDim2.new(1,-16,0,16),Position=UDim2.fromOffset(10,6),BackgroundTransparency=1,Text=tostring(title or "Notification"),TextColor3=Color3.fromRGB(240,240,240),TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=902,Parent=fr})
    mk("TextLabel",{Size=UDim2.new(1,-16,0,20),Position=UDim2.fromOffset(10,23),BackgroundTransparency=1,Text=tostring(text or ""),TextColor3=Color3.fromRGB(140,140,150),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,ZIndex=902,Parent=fr})
    for _,v in ipairs(stk) do if v.Parent then v.Position = UDim2.new(left and 0 or 1,left and 8 or -228,0,8 + (#stk - table.find(stk,v) + 1) * 54) end end
    table.insert(stk,fr)
    task.delay(tonumber(dur) or 4,function()
        local i = table.find(stk,fr)
        if i then table.remove(stk,i) end
        if fr.Parent then fr:Destroy() end
        for n,v in ipairs(stk) do if v.Parent then v.Position = UDim2.new(lib.NotifySide=="Left" and 0 or 1,lib.NotifySide=="Left" and 8 or -228,0,8 + (n-1)*54) end end
    end)
    local obj={Frame=fr}
    function obj:Destroy() local i=table.find(stk,fr); if i then table.remove(stk,i) end; if fr.Parent then fr:Destroy() end; return self end
    function obj:Close() return self:Destroy() end
    function obj:SetTitle(v) local z=fr:FindFirstChildWhichIsA("TextLabel",true); if z then z.Text=tostring(v or "") end; return self end
    function obj:SetText(v) local q=fr:GetChildren(); local n=0; for _,z in ipairs(q) do if z:IsA("TextLabel") then n=n+1; if n==2 then z.Text=tostring(v or "") end end end; return self end
    return obj
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
        o.desc = o.desc or o.description or o.Description or o.Tooltip or o.tooltip or o.Desc
        o.disabledDesc = o.disabledDesc or o.DisabledTooltip or o.disabledTooltip
        o.visible = o.Visible ~= false and o.visible ~= false
        o.disabled = o.Disabled == true or o.disabled == true
        o.risky = o.Risky == true or o.risky == true
        o.kind = kind
        o.parent = g
        o.position = #g.options + 1
        table.insert(g.options,o)
        return o
    end
    local function props(a,b)
        if type(a)=="table" then return a end
        local o=type(b)=="table" and table.clone(b) or {}
        o.Name=o.Name or a
        o.text=o.text or o.Text or a
        return o
    end
    local function mount(o)
        if lib.base and g.body then lib._build(g,o) end
        lib:_enhanceOption(o)
    end
    function g:AddLabel(a,b,c)
        local o
        if type(a)=="table" then o=table.clone(a)
        else
            o={Text=tostring(a or ""), text=tostring(a or "")}
            if type(b)=="boolean" then o.DoesWrap=b elseif type(b)=="table" then for k,v in pairs(b) do o[k]=v end end
            if type(c)=="string" then o.Name=c; o.flag=c end
        end
        o.text=o.text or o.Text or ""
        local x=add("label",o); x.wrap=x.DoesWrap==true or x.wrap==true; x.flag=x.flag or x.Name; mount(x); return x
    end
    function g:AddToggle(a,b) local o=props(a,b); o.text=o.text or o.Text or "Toggle"; o.state=o.state~=nil and o.state or o.Default; o.callback=o.callback or o.Callback; local x=add("toggle",o); x.flag=x.flag or x.Name or x.text; x.state=type(x.state)=="boolean" and x.state or x.default==true; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; if lib.flags[x.flag]==nil then setf(x.flag,x.state) else x.state=lib.flags[x.flag] end; mount(x); return x end
    function g:AddButton(a,b) local o=props(a,b); o.text=o.text or o.Text or "Button"; o.callback=o.callback or o.Callback or o.Func; o.doubleClick=o.doubleClick~=nil and o.doubleClick or o.DoubleClick; local x=add("button",o); x.flag=x.flag or x.Name or x.text; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; if lib.flags[x.flag]==nil then setf(x.flag,false) end; mount(x); return x end
    function g:AddBind(a,b)
        local o=props(a,b); o.text=o.text or o.Text or "Keybind"; o.key=o.key or o.Default; o.mode=o.mode or o.Mode or "Toggle"; o.callback=o.callback or o.Callback; o.changed=o.changed or o.ChangedCallback; o.sync=o.sync~=nil and o.sync or o.SyncToggleState; o.wait=o.wait~=nil and o.wait or o.WaitForCallback; o.noUI=o.noUI~=nil and o.noUI or o.NoUI; local x=add("bind",o); x.flag=x.flag or x.Name or x.text; x.key=(x.key and x.key.Name) or x.key or "F"; x.mode=tostring(x.mode or "Toggle"); x.hold=x.mode=="Hold"; x.state=x.mode=="Always"; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; x.cc=function(...) if type(x.changed)=="function" then pcall(x.changed,...) end end; setf(x.flag,x.key); mount(x); return x
    end
    function g:AddSlider(a,b)
        local o=props(a,b); o.text=o.text or o.Text or "Slider"; o.value=o.value~=nil and o.value or o.Default; o.min=o.min~=nil and o.min or o.Min; o.max=o.max~=nil and o.max or o.Max; o.step=o.step~=nil and o.step or o.Rounding; o.prefix=o.prefix or o.Prefix; o.suffix=o.suffix or o.Suffix; o.callback=o.callback or o.Callback; local x=add("slider",o); x.flag=x.flag or x.Name or x.text; x.min=type(x.min)=="number" and x.min or 0; x.max=type(x.max)=="number" and x.max or 100; x.step=type(x.step)=="number" and math.abs(x.step)>0 and math.abs(x.step) or 1; if x.max<x.min then x.min,x.max=x.max,x.min end; x.prefix=x.prefix or ""; x.suffix=x.suffix or ""; if x.max==x.min then x.max=x.min+1 end; x.value=cl(type(x.value)=="number" and x.value or x.min,x.min,x.max); x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; setf(x.flag,x.value); mount(x); return x
    end
    function g:AddList(a,b)
        local o=props(a,b); o.text=o.text or o.Text or "Dropdown"; o.values=o.values or o.Values; o.value=o.value~=nil and o.value or o.Default; o.multi=o.multi~=nil and o.multi or o.Multi; o.searchable=o.searchable~=nil and o.searchable or o.Searchable; o.callback=o.callback or o.Callback; o.format=o.format or o.FormatDisplayValue; o.disabledValues=o.disabledValues or o.DisabledValues; o.maxItems=o.maxItems or o.MaxVisibleDropdownItems; o.specialType=o.specialType or o.SpecialType; o.excludeLocal=o.excludeLocal~=nil and o.excludeLocal or o.ExcludeLocalPlayer; local x=add("list",o); x.flag=x.flag or x.Name or x.text; x.values=type(x.values)=="table" and x.values or {}; x.searchable=x.searchable==true or x.Searchable==true; x.multi=x.multi==true or x.Multi==true; x.format=x.format or x.FormatDisplayValue; x.disabledValues=type(x.disabledValues)=="table" and x.disabledValues or {}; x.maxItems=cl(tonumber(x.maxItems) or 6,1,12); x.specialType=x.specialType or x.SpecialType; if x.specialType=="Player" or x.specialType=="player" then x.values={}; for _,v in ipairs(pl:GetPlayers()) do if not x.excludeLocal or v~=pl.LocalPlayer then table.insert(x.values,v) end end elseif x.specialType=="Team" or x.specialType=="team" then x.values={}; for _,v in ipairs(tm:GetChildren()) do if v:IsA("Team") then table.insert(x.values,v) end end end; local function one(v) if type(v)=="number" then return x.values[v] end return v end; if x.multi then local q=type(x.value)=="table" and x.value or (x.value~=nil and {x.value} or {}); local z={}; for _,v in ipairs(q) do local vv=one(v); if vv~=nil and table.find(x.values,vv) and not table.find(z,vv) then table.insert(z,vv) end end; x.value=z else x.value=one(x.value); if x.value==nil or not table.find(x.values,x.value) then x.value=x.values[1] or "" end end; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; setf(x.flag,x.value); mount(x); return x
    end
    
    function g:AddBox(a,b)
        local o=props(a,b); o.text=o.text or o.Text or "Input"; o.value=o.value~=nil and o.value or o.Default; o.placeholder=o.placeholder or o.Placeholder; o.numeric=o.numeric~=nil and o.numeric or o.Numeric; o.callback=o.callback or o.Callback; local x=add("box",o); x.flag=x.flag or x.Name or x.text; x.value=tostring(x.value or ""); x.placeholder=x.placeholder or x.Placeholder or ""; x.numeric=x.numeric==true or x.Numeric==true; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; setf(x.flag,x.value); mount(x); return x
    end
    function g:AddColor(a,b)
        local o=props(a,b); o.text=o.text or o.Text or "Color"; o.color=o.color or o.Default; o.transparency=o.transparency~=nil and o.transparency or o.Transparency; o.callback=o.callback or o.Callback; local x=add("color",o); x.flag=x.flag or x.Name or x.text; x.color=cv(x.color or "FFFFFF") or Color3.fromRGB(255,255,255); x.transparency=tonumber(x.transparency) or 0; x.alpha=1-x.transparency; x.title=o.Title; x.cb=function(...) if type(x.callback)=="function" then pcall(x.callback,...) end end; setf(x.flag,x.color); mount(x); return x
    end
    function g:AddFolder(v)
        local info=type(v)=="table" and v or {Name=v}
        local name=info.Name or info.name or info.Title or info.title or "Section"
        local x=makeGroup(name,g,false)
        x.position=#g.options+1
        x.kind="folder"
        x.desc=info.Description or info.description or info.Tooltip or info.desc
        x.icon=info.IconName or info.Icon or info.icon
        x.open=info.Collapsed~=true and info.collapsed~=true
        x.visible=info.Visible~=false
        x.disabled=info.Disabled==true
        x.canCollapse=info.DisableCollapsing~=true and info.disableCollapsing~=true
        table.insert(g.options,x)
        mount(x)
        if x.visible==false and x.main then x.main.Visible=false end
        return x
    end
    function g:AddDropdown(a,b) return self:AddList(a,b) end
    function g:AddInput(a,b) return self:AddBox(a,b) end
    function g:AddKeybind(a,b) return self:AddBind(a,b) end
    function g:AddColorPicker(a,b) return self:AddColor(a,b) end
    function g:AddSection(o)
        if type(o)=="table" then
            return self:AddLabel({text=o.title or o.text or o.Text or "",desc=o.content or o.desc or o.description or o.Description})
        end
        return self:AddLabel(o)
    end
    function g:AddParagraph(a,b) local o=props(a,b); o.text=o.text or o.Text or o.Title or ""; o.desc=o.desc or o.Description or o.Content or o.content or ""; local x=add("paragraph",o); mount(x); return x end
    function g:AddDivider(a) local o=type(a)=="table" and table.clone(a) or {text=tostring(a or "")}; local x=add("divider",o); mount(x); return x end
    function g:AddText(a,b,c) return self:AddLabel(a,b,c) end
    function g:AddStat(a,b) local o=props(a,b); local x=add("stat",o); x.value=x.value==nil and 0 or x.value; x.flag=x.flag or x.Name or x.text; setf(x.flag,x.value); mount(x); return x end
    function g:AddProgress(a,b) local o=props(a,b); local x=add("progress",o); x.value=x.value==nil and (x.min or 0) or x.value; mount(x); return x end
    function g:AddConsole(a,b) local o=props(a,b); local x=add("console",o); x.value=tostring(x.value or o.Text or ""); mount(x); return x end
    function g:AddGroup(o) return self:AddFolder(o) end
    function g:CreateGroup(o) return self:AddGroup(o) end
    function g:CreateButton(o) return self:AddButton(o) end
    function g:CreateToggle(o) return self:AddToggle(o) end
    function g:CreateSwitch(o) return self:AddToggle(o) end
    function g:CreateSlider(o) return self:AddSlider(o) end
    function g:CreateDropdown(o) return self:AddList(o) end
    function g:CreateInput(o) return self:AddBox(o) end
    function g:CreateKeybind(o) return self:AddBind(o) end
    function g:CreateColorPicker(o) return self:AddColor(o) end
    function g:CreateSection(o) return self:AddSection(o) end
    function g:CreateText(o) return self:AddText(o) end
    function g:CreateDivider(o) return self:AddDivider(o) end
    function g:CreateStat(o) return self:AddStat(o) end
    function g:CreateProgress(o) return self:AddProgress(o) end
    function g:CreateConsole(o) return self:AddConsole(o) end
    function g:AddCheckbox(a,b) return self:AddToggle(a,b) end
    function g:AddGroupbox(o) return self:AddFolder(o or "Section") end
    function g:AddLeftGroupbox(a,b,c,d,e) local o=type(a)=="table" and a or {Name=a,IconName=b,Visible=c,Collapsed=d,DisableCollapsing=e}; return self:AddGroupbox(o) end
    function g:AddRightGroupbox(a,b,c,d,e) local o=type(a)=="table" and a or {Name=a,IconName=b,Visible=c,Collapsed=d,DisableCollapsing=e}; return self:AddGroupbox(o) end
    function g:AddLeftTabbox(o) return lib:CreateTabbox(self,o) end
    function g:AddRightTabbox(o) return lib:CreateTabbox(self,o) end
    function g:AddKeyTab(o) return self:AddFolder(type(o)=="table" and (o.Name or o.name or o.Title or o.title) or o or "Key") end
    function g:GetOptions() return self.options end
    function g:SetOpen(v)
        v=v~=false
        self.open=v
        if self.main and self.body then self.body.Visible=v end
        if self.main then self.main.Size=UDim2.new(1,0,0,self.open and (crn.gh+up4((self.lay and self.lay.AbsoluteContentSize.Y or 0)+12) or crn.gh) or crn.gh) end
        return self
    end
    function g:SetDescription(v) self.desc=v; return self end
    function g:SetCollapsed(v) return self:SetOpen(v~=true) end
    function g:ToggleCollapsed() return self:SetOpen(not self.open) end
    function g:Show() self.visible=true; if self.main then self.main.Visible=true end; return self end
    function g:Hide() self.visible=false; if self.main then self.main.Visible=false end; return self end
    function g:SetVisible(v) if v then return self:Show() else return self:Hide() end end
    function g:Resize() if self.lay and self.main then local h=up4(self.lay.AbsoluteContentSize.Y+12); self.main.Size=UDim2.new(1,0,0,self.open and crn.gh+h or crn.gh) end; return self end
    function g:Destroy()
        if self.main then self.main:Destroy(); self.main=nil end
        if self.parent and self.parent.options then local i=table.find(self.parent.options,self); if i then table.remove(self.parent.options,i) end end
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
        if g.canCollapse==false then return end
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
        if o.main then o.main.Visible=o.visible~=false end
        return
    end
    if o.kind=="label" then
        local h=24
        if o.wrap then
            local b=txt:GetTextSize(o.text,12,Enum.Font.Code,Vector2.new(228,1000))
            h=cl(up4(math.max(24,b.Y+4)),24,120)
        end
        local m=makeOption(g.body,h,o.position)
        local l=mk("TextLabel",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=o.risky and TH.acc or Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextWrapped=o.wrap,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,Parent=m})
        if o.disabled then l.TextTransparency=0.45 end
        hookTip(m,o.disabled and o.disabledDesc or o.desc)
        o.main=m; o.label=l
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
        bt.Activated:Connect(function() if o.disabled or o.locked then return end; o.SetState(o,not o.state) end)
        hookTip(m,o.desc)
        o.main=m
    elseif o.kind=="button" then
        local m=makeOption(g.body,28,o.position)
        local bg=mk("TextButton",{AutoButtonColor=false,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(bg,Color3.fromRGB(60,60,65),1)
        bg.MouseEnter:Connect(function() twc(bg,"BackgroundColor3",TH.acc,0.05,Enum.EasingStyle.Constant) end)
        bg.MouseLeave:Connect(function() twc(bg,"BackgroundColor3",Color3.fromRGB(20,20,22),0.05,Enum.EasingStyle.Constant) end)
        local lastClick=0
        bg.Activated:Connect(function()
            if o.disabled or o.locked then return end
            if o.doubleClick then
                local n=os.clock()
                if n-lastClick<=0.35 then lastClick=0; setf(o.flag,true); o.cb() else lastClick=n end
            else setf(o.flag,true); o.cb() end
        end)
        hookTip(bg,o.desc)
        o.main=m; o.button=bg
    elseif o.kind=="bind" then
        local m=makeOption(g.body,24,o.position)
        mk("TextLabel",{Size=UDim2.new(1,-84,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local bg=mk("TextButton",{AutoButtonColor=false,Text=o.key,TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(68,20),Position=UDim2.new(1,-68,0,2),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=m})
        at(bg,"BackgroundColor3",TH.acc)
        local cap=false
        o.SetKey=function(s,k) s.key=(typeof(k)=="EnumItem" and k.Name) or tostring(k or s.key); setf(s.flag,s.key); bg.Text=s.key end
        bg.Activated:Connect(function() if o.disabled or o.locked then return end; cap=true; bg.Text="..." end)
        inp.InputBegan:Connect(function(i,gp)
            if gp or inp:GetFocusedTextBox() then return end
            local nm=i.KeyCode~=Enum.KeyCode.Unknown and i.KeyCode.Name or i.UserInputType.Name
            if cap then if nm~="Unknown" and nm~="MouseMovement" then cap=false; o.SetKey(o,nm) end return end
            if nm==o.key and not o.disabled and not o.locked then
                if o.mode=="Always" then o.state=true; o.Value=true; o.cb(true)
                elseif o.hold then o.state=true; o.Value=true; o.cb(true)
                elseif o.mode=="Press" then if not o.wait then o.cb(true) end
                else o.state=not o.state; o.Value=o.state; o.cb(o.state) end
                if o.syncToggle then o.syncToggle:SetValue(o.state) end
                for _,fn in ipairs(o._click or {}) do pcall(fn,o.state) end
            end
        end)
        inp.InputEnded:Connect(function(i)
            local nm=i.KeyCode~=Enum.KeyCode.Unknown and i.KeyCode.Name or i.UserInputType.Name
            if nm==o.key and not o.disabled and not o.locked then
                if o.hold or o.mode=="Always" then o.state=false; o.Value=false; o.cb(false); if o.syncToggle then o.syncToggle:SetValue(false) end end
            end
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
        hit.Activated:Connect(function(i) if o.disabled or o.locked then return end; hold=true; setp(i.Position.X) end)
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
                for _,x in ipairs(v) do table.insert(q,disp(x)) end
                return table.concat(q,", ")
            end
            if type(o.format)=="function" then
                local ok,r=pcall(o.format,v)
                if ok and r~=nil then return tostring(r) end
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
                    local dis=table.find(o.disabledValues,v)~=nil
                    local b=mk("TextButton",{AutoButtonColor=false,Text=disp(v),TextColor3=dis and Color3.fromRGB(105,105,110) or (Color3.fromRGB(240,240,240)),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,-8,0,24),Position=UDim2.fromOffset(4,top),BackgroundColor3=table.find(type(o.value)=="table" and o.value or {},v) and TH.acc or Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=954,Parent=pop})
                    if not o.multi and tostring(o.value)==t then b.BackgroundColor3=TH.acc end
                    b.Activated:Connect(function()
                        if dis or o.disabled or o.locked then return end
                        if o.multi then
                            local q=type(o.value)=="table" and table.clone(o.value) or {}
                            local i=table.find(q,v)
                            if i then table.remove(q,i) else table.insert(q,v) end
                            o.SetValue(o,q)
                        else o.SetValue(o,v); closep() end
                        openp()
                    end)
                end
                if n>=o.maxItems then break end
            end
            local ph=cl(top+n*24+4,28,180)
            pop.Size=UDim2.fromOffset(bg.AbsoluteSize.X,ph)
            if o.shadow then o.shadow.Size=UDim2.fromOffset(bg.AbsoluteSize.X+1,ph+1); o.shadow.Position=UDim2.fromOffset(bg.AbsolutePosition.X+1,bg.AbsolutePosition.Y+45) end
        end
        bg.Activated:Connect(function() if o.disabled or o.locked then return end; openp() end)
        hookTip(m,o.desc)
        o.main=m; o.list=bg; o.Refresh=openp
    elseif o.kind=="box" then
        local m=makeOption(g.body,40,o.position)
        mk("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.fromOffset(0,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local ip=mk("TextBox",{Size=UDim2.new(1,0,0,24),Position=UDim2.fromOffset(0,16),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text=o.value,PlaceholderText=o.placeholder,TextColor3=Color3.fromRGB(240,240,240),PlaceholderColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=m})
        line(ip,Color3.fromRGB(60,60,65),1)
        o.SetValue=function(s,v,enter) v=tostring(v or ""); if s.numeric and not tonumber(v) then v=s.value end; s.value=v; ip.Text=v; setf(s.flag,v); s.cb(v,enter) end
        ip.FocusLost:Connect(function(e) if o.disabled or o.locked then return end; o.SetValue(o,ip.Text,e) end)
        hookTip(ip,o.desc)
        o.main=m; o.input=ip
    elseif o.kind=="paragraph" then
        local m=makeOption(g.body,44,o.position)
        local title=mk("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local d=mk("TextLabel",{Size=UDim2.new(1,0,0,24),Position=UDim2.fromOffset(0,17),BackgroundTransparency=1,Text=tostring(o.desc or o.content or ""),TextColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        o.SetText=function(s,v) s.text=tostring(v or ""); title.Text=s.text end
        o.SetDescription=function(s,v) s.desc=tostring(v or ""); d.Text=s.desc end
        o.main=m
        hookTip(m,o.desc)
    elseif o.kind=="divider" then
        local m=makeOption(g.body,20,o.position)
        local txtv=tostring(o.text or "")
        if txtv=="" then
            mk("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.fromOffset(0,10),BackgroundColor3=Color3.fromRGB(60,60,65),BorderSizePixel=0,Parent=m})
        else
            local l=mk("Frame",{Size=UDim2.new(0.35,0,0,1),Position=UDim2.fromOffset(0,10),BackgroundColor3=Color3.fromRGB(60,60,65),BorderSizePixel=0,Parent=m})
            local r=mk("Frame",{Size=UDim2.new(0.35,0,0,1),Position=UDim2.new(0.65,0,0,10),BackgroundColor3=Color3.fromRGB(60,60,65),BorderSizePixel=0,Parent=m})
            mk("TextLabel",{Size=UDim2.new(0.3,0,1,0),Position=UDim2.new(0.35,0,0,0),BackgroundTransparency=1,Text=txtv,TextColor3=Color3.fromRGB(140,140,150),TextSize=10,Font=Enum.Font.Code,Parent=m})
        end
        o.SetText=function(s,v) s.text=tostring(v or "") end
        o.main=m
    elseif o.kind=="stat" then
        local m=makeOption(g.body,28,o.position)
        local lb=mk("TextLabel",{Size=UDim2.new(0.62,0,1,0),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local vb=mk("TextLabel",{Size=UDim2.new(0.38,0,1,0),Position=UDim2.new(0.62,0,0,0),BackgroundTransparency=1,Text=tostring(o.value),TextColor3=TH.acc,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right,Parent=m})
        at(vb,"TextColor3",TH.acc)
        o.baseline=o.baseline==nil and o.value or o.baseline
        o.Set=function(s,v) s.value=v; vb.Text=tostring(v); return s end
        o.SetValue=o.Set
        o.ResetBaseline=function(s,v) s.baseline=v==nil and s.value or v; return s end
        o.Get=function(s) return s.value end
        o.main=m
    elseif o.kind=="progress" then
        local m=makeOption(g.body,32,o.position)
        local lb=mk("TextLabel",{Size=UDim2.new(0.6,0,0,14),BackgroundTransparency=1,Text=o.text,TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=m})
        local vb=mk("TextLabel",{Size=UDim2.new(0.4,0,0,14),Position=UDim2.new(0.6,0,0,0),BackgroundTransparency=1,Text=tostring(o.value),TextColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Right,Parent=m})
        local tr=mk("Frame",{Size=UDim2.new(1,0,0,5),Position=UDim2.fromOffset(0,21),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Parent=m})
        line(tr,Color3.fromRGB(60,60,65),1)
        local fi=mk("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=TH.acc,BorderSizePixel=0,Parent=tr})
        at(fi,"BackgroundColor3",TH.acc)
        o.min=tonumber(o.min) or 0; o.max=tonumber(o.max) or 100; if o.max<=o.min then o.max=o.min+1 end
        o.value=cl(tonumber(o.value) or o.min,o.min,o.max)
        local function refresh()
            local pct=(o.value-o.min)/(o.max-o.min)
            fi.Size=UDim2.new(o.indeterminate and 0.35 or pct,0,1,0)
            vb.Text=o.textValue~=nil and tostring(o.textValue) or tostring(o.value)
        end
        o.Set=function(s,v) s.value=cl(tonumber(v) or s.value,s.min,s.max); refresh(); return s end
        o.SetValue=o.Set
        o.Get=function(s) return s.value end
        o.GetPercentage=function(s) return (s.value-s.min)/(s.max-s.min)*100 end
        o.SetRange=function(s,a,b) a=tonumber(a) or s.min; b=tonumber(b) or s.max; if b<=a then b=a+1 end; s.min,s.max=a,b; s.value=cl(s.value,a,b); refresh(); return s end
        o.SetText=function(s,v) s.textValue=v; vb.Text=v==nil and tostring(s.value) or tostring(v); return s end
        o.SetIndeterminate=function(s,v) s.indeterminate=v==true; refresh(); return s end
        refresh()
        o.main=m
    elseif o.kind=="console" then
        local h=cl(tonumber(o.height) or 88,48,180)
        local m=makeOption(g.body,h,o.position)
        local box=mk("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ScrollBarThickness=3,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.fromOffset(0,0),Parent=m})
        line(box,Color3.fromRGB(60,60,65),1)
        local tx=mk("TextLabel",{Size=UDim2.new(1,-8,0,0),Position=UDim2.fromOffset(4,4),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Text=tostring(o.value or ""),TextColor3=Color3.fromRGB(220,220,220),TextSize=10,Font=Enum.Font.Code,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,Parent=box})
        local function sync() box.CanvasSize=UDim2.fromOffset(0,tx.AbsoluteSize.Y+8); box.CanvasPosition=Vector2.new(0,math.max(0,tx.AbsoluteSize.Y-box.AbsoluteSize.Y+8)) end
        tx:GetPropertyChangedSignal("AbsoluteSize"):Connect(sync)
        o.Set=function(s,v) s.value=tostring(v or ""); tx.Text=s.value; task.defer(sync); return s end
        o.Append=function(s,v) s.value=(s.value=="" and "" or s.value.."\n")..tostring(v or ""); tx.Text=s.value; task.defer(sync); return s end
        o.Clear=function(s) return s:Set("") end
        o.Get=function(s) return s.value end
        o.Copy=function(s) if typeof(setclipboard)=="function" then local ok=pcall(function() setclipboard(s.value) end); return ok end return false end
        o.SetHeight=function(s,v) v=cl(tonumber(v) or h,48,180); s.height=v; m.Size=UDim2.new(1,-16,0,v); return s end
        o.main=m; task.defer(sync)
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
        sw.Activated:Connect(function() if o.disabled or o.locked then return end; openp() end)
        hookTip(m,o.desc)
        o.main=m; o.sw=sw
    end
    if o.main then o.main.Visible=o.visible~=false end
end

function lib:_enhanceOption(o)
    if not o then return o end
    o.visible=o.visible~=false
    o.disabled=o.disabled==true
    o.locked=o.locked==true
    if o.flag then
        if o.kind=="toggle" then self.Toggles[o.flag]=o else self.Options[o.flag]=o end
    end
    if o.kind=="toggle" then
        o.Value=o.state==true; o.State=o.Value
        local old=o.SetState
        if old then o.SetState=function(s,v) local r=old(s,v); s.Value=s.state==true; s.State=s.Value; return r end end
        o.SetValue=function(s,v) return s:SetState(v) end
        o.GetState=function(s) return s.state==true end
    elseif o.kind=="slider" then
        o.Value=o.value
        local old=o.SetValue
        if old then o.SetValue=function(s,v) local r=old(s,v); s.Value=s.value; return r end end
    elseif o.kind=="list" then
        o.Value=o.value
        local old=o.SetValue
        if old then o.SetValue=function(s,v) local r=old(s,v); s.Value=s.value; return r end end
    elseif o.kind=="box" then
        o.Value=o.value
        local old=o.SetValue
        if old then o.SetValue=function(s,v,e) local r=old(s,v,e); s.Value=s.value; return r end end
    elseif o.kind=="bind" then
        o.Value=o.key
        local old=o.SetKey
        if old then o.SetKey=function(s,v) local k=(typeof(v)=="EnumItem" and v or tostring(v or s.key)); local r=old(s,k); s.Value=s.key; s.Key=s.key; pcall(s.cc,k,nil); return r end end
        o.GetState=function(s) return s.state==true end
        o.OnClick=function(s,fn) s._click=s._click or {}; if type(fn)=="function" then table.insert(s._click,fn) end; return s end
    elseif o.kind=="color" then
        o.Value=o.color; o.Transparency=o.transparency or 0
        local old=o.SetColor
        if old then o.SetColor=function(s,v) local r=old(s,v); s.Value=s.color; return r end end
        o.SetValueRGB=function(s,v,t) s:SetColor(v); if t~=nil then s:SetAlpha(1-tonumber(t)); end; return s end
    end
    o.Get=function(s)
        if s.kind=="toggle" then return s.state end
        if s.kind=="slider" then return s.value end
        if s.kind=="bind" then return s.key end
        if s.kind=="box" then return s.value end
        if s.kind=="list" then return s.value end
        if s.kind=="color" then return s.color end
        return s.text
    end
    o.GetValue=o.Get
    o.Set=function(s,v)
        if s.kind=="toggle" and s.SetState then s:SetState(v)
        elseif s.SetValue then s:SetValue(v)
        elseif s.kind=="bind" and s.SetKey then s:SetKey(v)
        elseif s.kind=="color" and s.SetColor then s:SetColor(v) end
        return s
    end
    o.SetFlag=function(s,f)
        if not f then return s end
        local old=s.flag
        if old then self.Options[old]=nil; self.Toggles[old]=nil; lib.flags[old]=nil end
        s.flag=tostring(f)
        if s.kind=="toggle" then self.Toggles[s.flag]=s else self.Options[s.flag]=s end
        setf(s.flag,s:Get())
        return s
    end
    o.OnChanged=function(s,fn)
        if type(fn)~="function" or not s.flag then return {Disconnect=function() end} end
        return lib:OnFlagChange(s.flag,function(v)
            s.Value=s:Get();
            if s.kind=="toggle" then s.State=s.Value end
            for _,f in ipairs(s._click or {}) do pcall(f,v) end
            pcall(fn,v)
        end)
    end
    o.AddColorPicker=function(s,a,b)
        if not s.parent then return s end
        local x=s.parent:AddColor(type(a)=="table" and a or {text=a,Default=type(b)=="table" and b.Default or b})
        x.ParentElement=s
        return x
    end
    o.AddKeyPicker=function(s,a,b)
        if not s.parent then return s end
        local x=s.parent:AddBind(type(a)=="table" and a or {text=a,Default=type(b)=="table" and b.Default or b})
        x.ParentElement=s
        if s.kind=="toggle" then x.syncToggle=s end
        return x
    end
    o.AddButton=function(s,a,b) if not s.parent then return s end; return s.parent:AddButton(a,b) end
    o.SetVisible=function(s,v) s.visible=v~=false; if s.main then s.main.Visible=s.visible end; if s.parent then groupResize(s.parent) end; return s end
    o.SetDisabled=function(s,v) s.disabled=v==true; if s.main then s.main:SetAttribute("Disabled",s.disabled) end; return s end
    o.SetTooltip=function(s,v) s.desc=v; return s end
    o.SetLocked=function(s,v) s.locked=v==true; return s end
    o.AddDependency=function(s,flag,expected) lib:_bindDependency(s.parent or s,flag,expected,s); return s end
    o.IsVisible=function(s) return s.visible~=false end
    o.Lock=function(s) s.locked=true; return s end
    o.Unlock=function(s) s.locked=false; return s end
    o.IsLocked=function(s) return s.locked==true end
    o.SetText=function(s,v) s.text=tostring(v or ""); if s.main then local l=s.main:FindFirstChildWhichIsA("TextLabel",true); if l then l.Text=s.text end end; return s end
    if o.kind=="list" then
        o.SetValues=function(s,v) s.values=type(v)=="table" and v or {}; if type(s.value)=="table" then local q={}; for _,x in ipairs(s.value) do if table.find(s.values,x) then table.insert(q,x) end end; s.value=q elseif not table.find(s.values,s.value) then s.value=s.values[1] or "" end; s.Values=s.values; setf(s.flag,s.value); if s.list and s.list.Parent then local function dv(x) if s.multi and type(x)=="table" then local z={}; for _,y in ipairs(x) do table.insert(z,tostring(y)) end; return table.concat(z,", ") end; if type(s.format)=="function" then local ok,r=pcall(s.format,x); if ok and r~=nil then return tostring(r) end end; return tostring(x) end; s.list:FindFirstChildWhichIsA("TextLabel",true).Text=dv(s.value) end; return s end
        o.RefreshPool=o.Refresh
        o.SetValueImages=function(s,v) s.ValueImages=v; return s end
        o.Add=function(s,v) if v==nil then return s end; if not table.find(s.values,v) then table.insert(s.values,v) end; if s.Refresh then s:Refresh() end; return s end
        o.Remove=function(s,v) local i=table.find(s.values,v); if i then table.remove(s.values,i) end; if type(s.value)=="table" then local j=table.find(s.value,v); if j then table.remove(s.value,j) end elseif s.value==v then s.value=s.values[1] or ""; setf(s.flag,s.value) end; if s.Refresh then s:Refresh() end; return s end
    elseif o.kind=="box" then
        o.SetText=function(s,v) return s:SetValue(v) end
    elseif o.kind=="bind" then
        o.SetMode=function(s,v) s.hold=tostring(v or "Toggle"):lower()=="hold"; s.mode=s.hold and "Hold" or "Toggle"; return s end
    elseif o.kind=="color" then
        o.SetAlpha=function(s,v) s.alpha=cl(tonumber(v) or 1,0,1); s.transparency=1-s.alpha; s.Transparency=s.transparency; if s.flag then setf(s.flag,s.color) end; if s.cb then s.cb(s.color,s.transparency) end; return s end
    end
    if o.kind=="color" then
        local ac=o.SetAlpha
        if ac then o.SetAlpha=function(s,v) local r=ac(s,v); s.Transparency=s.transparency; s.Value=s.color; return r end end
        local sc=o.SetColor
        if sc then o.SetColor=function(s,v) local r=sc(s,v); s.Value=s.color; return r end end
        o.SetValue=function(s,v,t)
            if typeof(v)=="Color3" then s:SetColor(v)
            elseif type(v)=="table" and v[1] and v[2] and v[3] then s:SetColor(Color3.fromHSV(cl(tonumber(v[1]) or 0,0,1),cl(tonumber(v[2]) or 0,0,1),cl(tonumber(v[3]) or 0,0,1))) end
            if t~=nil then s:SetAlpha(1-cl(tonumber(t) or 0,0,1)) end
            return s
        end
    end
    if o.kind=="folder" then
        o.UpdateWarningBox=function(s,v) s.WarningBox=v; return s end
        o.RefreshSides=function(s) return s end
        o.Hover=function(s,v) s.Hovered=v==true; return s end
        o.SetOrder=function(s,v) s.position=tonumber(v) or s.position; if s.main then s.main.LayoutOrder=s.position end; return s end
        o.SetTooltip=function(s,v) s.desc=v; return s end
        o.AddLeftGroupbox=function(s,a,b,c,d,e) local x=type(a)=="table" and a or {Name=a,IconName=b,Visible=c,Collapsed=d,DisableCollapsing=e}; return s:AddGroupbox(x) end
        o.AddRightGroupbox=o.AddLeftGroupbox
        o.AddLeftTabbox=function(s,a) return lib:CreateTabbox(s,a) end
        o.AddRightTabbox=o.AddLeftTabbox
    end
    if o.kind=="bind" then
        o.SetValue=function(s,v)
            if type(v)=="table" then
                local key=v[1] or v.Key or v.key
                local mode=v[2] or v.Mode or v.mode
                if mode then s:SetMode(mode) end
                if key then s:SetKey(key) end
            else s:SetKey(v) end
            return s
        end
    end
    if o.kind=="button" then
        local ob=o.AddButton
        o.AddButton=function(s,a,b)
            local x=ob(s,a,b); return x
        end
    end
    local st=o.SetText
    o.SetText=function(s,v)
        local t=tostring(v or "")
        s.text=t; s.Text=t
        if s.button then s.button.Text=t end
        if s.label then s.label.Text=t end
        if s.input then s.input.Text=t; s.value=t; s.Value=t; setf(s.flag,t) end
        if s.main and not s.button and not s.input and not s.label then
            local z=s.main:FindFirstChildWhichIsA("TextLabel",true)
            if z then z.Text=t end
        end
        if st and s.kind~="button" and s.kind~="box" and s.kind~="label" then pcall(st,s,v) end
        return s
    end
    o.GetName=function(s) return s.flag or s.Name or s.text end
    o.GetText=function(s) return s.text end
    o.SetName=function(s,v) s.Name=tostring(v or ""); return s end
    o.Destroy=function(s)
        if s.main then s.main:Destroy(); s.main=nil end
        if s.pop then s.pop:Destroy(); s.pop=nil end
        if s.shadow then s.shadow:Destroy(); s.shadow=nil end
        if s.flag then self.Options[s.flag]=nil; self.Toggles[s.flag]=nil; flagFns[s.flag]={} end
        if s.parent and s.parent.options then
            local i=table.find(s.parent.options,s)
            if i then table.remove(s.parent.options,i) end
        end
    end
    return o
end

function lib:_bindDependency(owner,flag,expected,element)
    if type(flag)~="string" then return end
    owner._deps=owner._deps or {}
    table.insert(owner._deps,{flag=flag,expected=expected,element=element})
    local function update(v)
        local ok=type(expected)=="function" and expected(v) or v==expected
        if element and element.SetVisible then element:SetVisible(ok) end
    end
    self:OnFlagChange(flag,update)
    update(self.flags[flag])
end

function lib:UpdateDependencies()
    for _,w in ipairs(self.windows) do
        local function walk(g)
            for _,d in ipairs(g._deps or {}) do
                local v=self.flags[d.flag]
                local ok=type(d.expected)=="function" and d.expected(v) or v==d.expected
                if d.element and d.element.SetVisible then d.element:SetVisible(ok) end
            end
            for _,o in ipairs(g.options or {}) do if o.kind=="folder" then walk(o) end end
        end
        walk(w)
    end
end

function lib:CreateLoading(data)
    data=type(data)=="table" and data or {Title=tostring(data or "Loading"),Content=""}
    local done=false
    local obj={}
    function obj:Update(v) if lib.Notify then lib:Notify(data.Title or "Loading",tostring(v or data.Content or ""),1) end; return self end
    function obj:Close() done=true; return self end
    function obj:IsOpen() return not done end
    obj:Update(data.Content or "")
    return obj
end

function lib:CreateWindow(title)
    local cfg=type(title)=="table" and title or {Title=title}
    title=cfg.Name or cfg.Title or cfg.name or cfg.title or "Window"
    local w=makeGroup(title,nil,true)
    w.config=cfg
    if typeof(cfg.ToggleKeybind)=="EnumItem" then self.key=cfg.ToggleKeybind end
    if typeof(cfg.ToggleKey)=="EnumItem" then self.key=cfg.ToggleKey end
    if cfg.AutoShow==false then self.open=false end
    w.win=self
    w.open=true
    w.SetIcon=function(s,v)
        s.icon=v
        if s.ic then s.ic.Image=typeof(v)=="number" and "rbxassetid://"..tostring(v) or tostring(v or ""); s.ic.Visible=v~=nil end
        return s
    end
    w.Toggle=function(s,v) s.open=v==nil and not s.open or v==true; if s.body then s.body.Visible=s.open end; return s end
    w.Minimize=function(s,v) if v==nil then s:Toggle() else s.open=v~=false; if s.body then s.body.Visible=s.open end end end
    w.Destroy=function(s)
        if s.main then s.main:Destroy(); s.main=nil end
        local i=table.find(lib.windows,s)
        if i then table.remove(lib.windows,i) end
    end
    w.GetOptions=function(s) return s.options end
    w.AddTab=function(s,o)
        local title=type(o)=="table" and (o.Name or o.name or o.Title or o.title) or o
        return s:AddFolder(title or "Tab")
    end
    w.CreateTab=w.AddTab
    w.CreateSection=function(s,o) return s:AddFolder(type(o)=="table" and (o.Name or o.name or o.Title or o.title) or o or "Section") end
    w.AddGroupbox=function(s,o) return s:AddFolder(o or "Section") end
    w.AddLeftGroupbox=w.AddGroupbox
    w.AddRightGroupbox=w.AddGroupbox
    w.AddLeftTabbox=function(s,o) return lib:CreateTabbox(s,o) end
    w.AddRightTabbox=function(s,o) return lib:CreateTabbox(s,o) end
    w.AddKeyTab=function(s,o) return s:AddFolder(type(o)=="table" and (o.Name or o.name or o.Title or o.title) or o or "Key") end
    w.AddDependency=function(s,flag,expected,element) lib:_bindDependency(s,flag,expected,element); return element end
    w.Refresh=function(s) if s.main then for _,o in ipairs(s.options) do if not o.main then lib._build(s,o) end end end; return s end
    table.insert(self.windows,w)
    if self.base then lib._mountWindow(w) end
    return w
end
function lib._mountWindow(w)
    local cam=workspace.CurrentCamera
    local vh=cam and cam.ViewportSize.Y or 720
    local wh=up4(cl(vh*0.7,280,560))
    local main=mk("Frame",{Size=UDim2.fromOffset(crn.w,wh),Position=UDim2.fromOffset(cl((cam and cam.ViewportSize.X or 800)/2-crn.w/2,8,(cam and cam.ViewportSize.X or 800)-crn.w-8),cl((vh-wh)/2,-28,vh-12)),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,Parent=lib.base})
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
function lib:CreateTab(title) return self:CreateWindow(title) end
function lib:CreateSection(title) return self:CreateWindow(title) end
function lib:CreateNotification(data,text,duration)
    if type(data)=="table" then
        return self:Notify(data.Title or data.title or "Notification",data.Content or data.content or data.Text or data.text or "",data.Duration or data.duration or 4)
    end
    return self:Notify(data,text,duration)
end
function lib:ShowNotification(data) return self:CreateNotification(data) end
function lib:SaveConfiguration(name) return self:SaveConfig(name) end
function lib:LoadConfiguration(name) return self:LoadConfig(name) end
function lib:DeleteConfiguration(name) return self:DeleteConfig(name) end
function lib:GetConfigs() return self:ListConfigs() end
function lib:SetToggleKey(k) return self:SetKeybind(k) end
function lib:GetFlag(flag) return self.flags[flag] end
function lib:SetFlag(flag,value)
    local o=findflag(flag)
    if o then o:Set(value); return true end
    setf(flag,value)
    return false
end
function lib:GetWindow(title)
    for _,w in ipairs(self.windows) do if w.title==tostring(title) then return w end end
end
function lib:Search(query)
    query=tostring(query or ""):lower()
    local out={}
    local function walk(g)
        for _,o in ipairs(g.options or {}) do
            if o.kind=="folder" then walk(o)
            elseif query=="" or tostring(o.text):lower():find(query,1,true) then table.insert(out,o) end
        end
    end
    for _,w in ipairs(self.windows) do walk(w) end
    return out
end

function lib:CreateTabbox(parent,info)
    info=type(info)=="table" and info or {Name=tostring(info or "Tabs")}
    local box={Name=info.Name or info.name or "Tabs",Tabs={},ActiveTab=nil,Parent=parent}
    function box:AddTab(o)
        local title=type(o)=="table" and (o.Name or o.name or o.Title or o.title) or o
        local tab=parent:AddFolder(title or ("Tab "..tostring(#self.Tabs+1)))
        table.insert(self.Tabs,tab)
        if not self.ActiveTab then self.ActiveTab=tab else tab:SetOpen(false) end
        function tab:Select() for _,x in ipairs(box.Tabs) do x:SetOpen(x==tab) end; box.ActiveTab=tab; return tab end
        function tab:Deselect() tab:SetOpen(false); return tab end
        return tab
    end
    box.CreateTab=box.AddTab
    function box:Select(tab)
        if type(tab)=="string" then for _,x in ipairs(self.Tabs) do if tostring(x.title)==tab or tostring(x.Name)==tab then return x:Select() end end end
        if tab and tab.Select then return tab:Select() end
    end
    function box:Remove(tab) local i=table.find(self.Tabs,tab); if i then table.remove(self.Tabs,i); tab:Destroy() end; if self.ActiveTab==tab then self.ActiveTab=self.Tabs[1]; if self.ActiveTab then self.ActiveTab:SetOpen(true) end end; return self end
    function box:Resize() for _,x in ipairs(self.Tabs) do x:Resize() end; return self end
    function box:UpdateCorners() return self end
    function box:Show() for _,x in ipairs(self.Tabs) do x:Show() end; return self end
    function box:Hide() for _,x in ipairs(self.Tabs) do x:Hide() end; return self end
    function box:Destroy() for _,x in ipairs(self.Tabs) do x:Destroy() end; self.Tabs={}; self.ActiveTab=nil; return self end
    return box
end



function lib:Init()
    if self.Unloaded then return nil end
    self.KeybindFrame=self.KeybindFrame or {Visible=false}
    self.Scheme=self.Scheme or {Red=TH.acc,Accent=TH.acc}
    if self.base and self.base.Parent then return self.base end
    self.base=mk("ScreenGui",{ResetOnSpawn=false,IgnoreGuiInset=true,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,Parent=cg})
    self._scale=mk("UIScale",{Scale=self.DPIScale/100,Parent=self.base})
    if syn and typeof(syn.protect_gui)=="function" then pcall(function() syn.protect_gui(self.base) end) end
    if typeof(gethui)=="function" then self.base.Parent=gethui() else self.base.Parent=cg end
    for _,w in ipairs(self.windows) do if not w.init then lib._mountWindow(w) end end
    self:UpdateDependencies()
    return self.base
end
function lib:Notify(title,text,duration) return toast(title,text,duration) end
function lib:OnFlagChange(flag,fn)
    if type(fn)~="function" then return {Disconnect=function() end} end
    flagFns[flag]=flagFns[flag] or {}
    table.insert(flagFns[flag],fn)
    local dead=false
    return {Disconnect=function() if dead then return end; dead=true; local t=flagFns[flag]; local i=table.find(t,fn); if i then table.remove(t,i) end end}
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
    if typeof(isfile)=="function" and typeof(readfile)=="function" then
        local ok,yes=pcall(function() return isfile(path) end)
        if ok and yes then local ok2,v=pcall(function() return readfile(path) end); if ok2 then return v end end
    end
    return mem[path]
end
function lib:SaveConfig(name)
    name=tostring(name or "default")
    local ok,data=pcall(function() return hs:JSONEncode(ser(self.flags)) end)
    if not ok then return false end
    if typeof(makefolder)=="function" and typeof(isfolder)=="function" then
        local ok=pcall(function() if not isfolder("suic1UI") then makefolder("suic1UI") end end)
    end
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
    if typeof(isfile)=="function" and typeof(delfile)=="function" then local ok,yes=pcall(function() return isfile(path) end); if ok and yes then local ok2=pcall(function() delfile(path) end); if ok2 then return true end end end
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


local unloadFns={}
lib.NotifySide=lib.NotifySide or "Right"
lib.DPIScale=lib.DPIScale or 100

function lib:SafeCallback(fn,...)
    if type(fn)~="function" then return false end
    local args={...}
    local ok,a,b,c,d=pcall(function() return fn(table.unpack(args)) end)
    return ok,a,b,c,d
end
function lib:GiveSignal(signal)
    if signal then table.insert(self.Signals,signal) end
    return signal
end
function lib:OnUnload(fn)
    if type(fn)=="function" then table.insert(unloadFns,fn) end
    return self
end
function lib:SetDPIScale(v)
    v=tonumber(v) or 100
    self.DPIScale=cl(v,50,200)
    if self.base then
        self._scale=self._scale or mk("UIScale",{Parent=self.base})
        self._scale.Scale=self.DPIScale/100
    end
    return self
end
function lib:SetNotifySide(v)
    v=tostring(v or "Right"):lower()
    self.NotifySide=v=="left" and "Left" or "Right"
    return self
end
function lib:GetTextBounds(text,size,font,width)
    local z=txt:GetTextSize(tostring(text or ""),tonumber(size) or 12,font or Enum.Font.Code,Vector2.new(tonumber(width) or 1000,1000))
    return z.X,z.Y
end
function lib:GetKeyString(k)
    if typeof(k)=="EnumItem" then return k.Name end
    return tostring(k or "None")
end
function lib:GetBetterColor(c,n)
    if typeof(c)~="Color3" then return c end
    local h,s,v=c:ToHSV()
    return Color3.fromHSV(h,s,cl(v+(tonumber(n) or 0)/255,0,1))
end
function lib:GetLighterColor(c) return self:GetBetterColor(c,28) end
function lib:GetDarkerColor(c) return self:GetBetterColor(c,-28) end
function lib:MouseIsOverFrame(fr,pos)
    if not fr then return false end
    pos=pos or inp:GetMouseLocation()
    local p=fr.AbsolutePosition
    local z=fr.AbsoluteSize
    return pos.X>=p.X and pos.X<=p.X+z.X and pos.Y>=p.Y and pos.Y<=p.Y+z.Y
end
function lib:IsInsideFrame(parent,fr)
    if not parent or not fr then return false end
    local a=parent.AbsolutePosition
    local b=fr.AbsolutePosition
    local s=parent.AbsoluteSize
    return b.X>=a.X and b.Y>=a.Y and b.X+fr.AbsoluteSize.X<=a.X+s.X and b.Y+fr.AbsoluteSize.Y<=a.Y+s.Y
end
function lib:AddToRegistry(instance,properties)
    if not instance or type(properties)~="table" then return instance end
    for property,value in pairs(properties) do
        table.insert(accs,{o=instance,p=property,v=value})
    end
    return instance
end
function lib:RemoveFromRegistry(instance)
    for i=#accs,1,-1 do if accs[i].o==instance then table.remove(accs,i) end end
    return self
end
function lib:UpdateColorsUsingRegistry()
    for _,x in ipairs(accs) do
        if x.o and x.o.Parent and type(x.p)=="string" then
            if x.v==true or x.v==nil then pcall(function() x.o[x.p]=TH.acc end) elseif typeof(x.v)=="Color3" then x.o[x.p]=x.v end
        end
    end
    return self
end
function lib:SetFont(font)
    if typeof(font)~="EnumItem" and type(font)~="string" then return self end
    local f=font
    if type(f)=="string" then f=Enum.Font[f] or Enum.Font.Code end
    for _,w in ipairs(self.windows) do
        if w.main then for _,x in ipairs(w.main:GetDescendants()) do if x:IsA("TextLabel") or x:IsA("TextButton") or x:IsA("TextBox") then x.Font=f end end end
    end
    return self
end
function lib:SetBackgroundImage(image)
    self.BackgroundImage=image
    return self
end
function lib:SetWatermark(text)
    if not self.base then return self end
    if self._watermark then self._watermark:Destroy() end
    local m=mk("TextLabel",{Size=UDim2.fromOffset(220,20),Position=UDim2.fromOffset(8,8),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text=tostring(text or ""),TextColor3=Color3.fromRGB(220,220,220),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=880,Parent=self.base})
    line(m,Color3.fromRGB(60,60,65),1)
    self._watermark=m
    return self
end
function lib:SetWatermarkVisibility(v)
    if self._watermark then self._watermark.Visible=v~=false end
    return self
end
function lib:ChangeTheme(theme)
    if type(theme)~="table" then return self end
    local c=theme.Accent or theme.accent
    if c then self:SetAccent(c) end
    return self
end
function lib:SetAccent(c)
    if typeof(c)~="Color3" then c=cv(c) end
    if not c then return self end
    TH.acc=c
    self.Scheme=self.Scheme or {}
    self.Scheme.Red=c
    self.Scheme.Accent=c
    for _,x in ipairs(accs) do if x.o and x.o.Parent then local v=x.v; if v==true or v==nil then twc(x.o,x.p,c,0.05,Enum.EasingStyle.Constant) end end end
    return self
end
function lib:Toggle(v)
    if v==nil then return self:Close() end
    self.open=v==true
    for _,w in ipairs(self.windows) do if w.main then w.main.Visible=self.open end end
    return self
end
function lib:Destroy()
    if self.Unloaded then return self end
    self.Unloaded=true
    for _,fn in ipairs(unloadFns) do pcall(fn) end
    for _,sig in ipairs(self.Signals) do pcall(function() if sig.Disconnect then sig:Disconnect() end end) end
    self.Signals={}
    for _,w in ipairs(self.windows) do if w.main then w.main:Destroy(); w.main=nil end end
    if self.base then self.base:Destroy(); self.base=nil end
    self.active=nil
    return self
end
function lib:Unload() return self:Destroy() end
function lib:Close(v)
    if v~=nil then self.open=v==true else self.open=not self.open end
    if self.active and self.active.Close then pcall(self.active.Close,self.active) end
    for _,w in ipairs(self.windows) do if w.main then w.main.Visible=self.open end end
    return self.open
end

local oldCreateWindow=lib.CreateWindow
lib.CreateWindow=function(self,title)
    local w=oldCreateWindow(self,title)
    w.Tabs=w.Tabs or {}
    w.Title=w.title
    local rawAddTab=w.AddTab
    w.AddTab=function(s,name,icon)
        local info=type(name)=="table" and name or {Name=name,IconName=icon}
        local tab=rawAddTab(s,info)
        tab.Name=info.Name or info.name or info.Title or info.title or tostring(name or "Tab")
        tab.Title=tab.title
        tab.IconName=info.IconName or info.Icon or icon
        tab.Side=info.Side
        s.Tabs[tab.Name]=tab
        if not s.ActiveTab then s.ActiveTab=tab else tab:Hide() end
        function tab:Select()
            for _,x in pairs(s.Tabs) do if x.Hide then x:Hide() end end
            tab:Show(); s.ActiveTab=tab; return tab
        end
        function tab:Deselect() tab:Hide(); if s.ActiveTab==tab then s.ActiveTab=nil end; return tab end
        return tab
    end
    w.CreateTab=w.AddTab
    local rawKey=w.AddKeyTab
    w.AddKeyTab=function(s,name)
        local tab=rawKey(s,name)
        tab.Name=type(name)=="table" and (name.Name or name.name or name.Title or name.title) or tostring(name or "Key")
        s.Tabs[tab.Name]=tab
        if s.ActiveTab then s.ActiveTab:Hide() end
        s.ActiveTab=tab
        function tab:Select() for _,x in pairs(s.Tabs) do if x.Hide then x:Hide() end end; tab:Show(); s.ActiveTab=tab; return tab end
        function tab:Deselect() tab:Hide(); if s.ActiveTab==tab then s.ActiveTab=nil end; return tab end
        function tab:AddKeyBox(callback)
            local x=self:AddButton({Text="Enter Key",Func=function()
                if type(callback)=="function" then
                    local v=self._keyInput or ""
                    pcall(callback,v)
                end
            end})
            local input=self:AddInput({Text="Key",Placeholder="Enter key",Callback=function(v) self._keyInput=v end})
            return x,input
        end
        return tab
    end
    w.SetTitle=function(s,v) s.title=tostring(v or s.title); s.Title=s.title; if s.tt then s.tt.Text=s.title end; return s end
    w.ChangeTitle=w.SetTitle
    w.SetFooter=function(s,v) s.Footer=v; return s end
    w.SetBackgroundImage=function(s,v) s.BackgroundImage=v; return s end
    w.SetAlwaysOnTop=function(s,v) s.AlwaysOnTop=v==true; if s.main then s.main.ZIndex=s.AlwaysOnTop and 50 or 1 end; return s end
    w.SetSnapping=function(s,v,d,m) s.Snapping=v==true; s.SnapDistance=d or s.SnapDistance or 16; s.SnapMargin=m or s.SnapMargin or 8; return s end
    w.SetCornerRadius=function(s,v) s.CornerRadius=tonumber(v) or 0; return s end
    w.SetAnimations=function(s,v,t,off,dir) s.Animations=v or {}; s.TabTransitionTime=t or 0.15; return s end
    w.IsSidebarCompacted=function(s) return s.compact==true end
    w.SetCompact=function(s,v) s.compact=v==true; return s end
    w.GetSidebarWidth=function(s) return crn.w end
    w.SetSidebarWidth=function(s,v) crn.w=cl(tonumber(v) or 260,220,360); return s end
    w.ShowTabInfo=function(s,n,d) s.TabInfo={Name=n,Description=d}; return s end
    w.HideTabInfo=function(s) s.TabInfo=nil; return s end
    w.SelectTab=function(s,name) local t=type(name)=="table" and name or s.Tabs[name]; if t and t.Select then return t:Select() end end
    w.AddDialog=function(s,idx,info)
        if type(idx)=="table" and info==nil then info=idx; idx=nil end
        info=type(info)=="table" and info or {Title=tostring(info or "Dialog"),Description=""}
        if not self.base or not s.main then return nil end
        local fr=mk("Frame",{Size=UDim2.fromOffset(224,120),Position=UDim2.fromOffset(18,crn.gh+44),BackgroundColor3=Color3.fromRGB(30,30,33),BorderSizePixel=0,ZIndex=990,Parent=self.base})
        line(fr,Color3.fromRGB(60,60,65),1)
        local t=mk("TextLabel",{Size=UDim2.new(1,-16,0,20),Position=UDim2.fromOffset(8,6),BackgroundTransparency=1,Text=tostring(info.Title or "Dialog"),TextColor3=Color3.fromRGB(240,240,240),TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=991,Parent=fr})
        local d=mk("TextLabel",{Size=UDim2.new(1,-16,0,50),Position=UDim2.fromOffset(8,28),BackgroundTransparency=1,Text=tostring(info.Description or info.Text or ""),TextColor3=Color3.fromRGB(140,140,150),TextSize=11,Font=Enum.Font.Code,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=991,Parent=fr})
        local obj={Frame=fr,Buttons={}}
        function obj:SetTitle(v) t.Text=tostring(v or ""); return self end
        function obj:SetDescription(v) d.Text=tostring(v or ""); return self end
        function obj:Resize() return self end
        function obj:Dismiss() if fr.Parent then fr:Destroy() end; return self end
        function obj:RemoveFooterButton(k) local b=self.Buttons[k]; if b then b:Destroy(); self.Buttons[k]=nil end; return self end
        function obj:SetButtonDisabled(k,v) local b=self.Buttons[k]; if b then b.Active=v~=true; b.TextTransparency=v and 0.45 or 0 end; return self end
        function obj:SetButtonOrder(k,order) local b=self.Buttons[k]; if b then b.LayoutOrder=tonumber(order) or b.LayoutOrder end; return self end
        function obj:AddFooterButton(k,b)
            local bi=type(b)=="table" and b or {Text=tostring(b or "OK")}
            local bt=mk("TextButton",{AutoButtonColor=false,Text=tostring(bi.Text or "OK"),TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(64,22),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=992,Parent=fr})
            line(bt,Color3.fromRGB(60,60,65),1); bt.Activated:Connect(function() if bt.Active and type(bi.Func)=="function" then pcall(bi.Func,self) end end); self.Buttons[k]=bt; return self
        end
        local buttons=info.Buttons or info.FooterButtons or {}
        local n=0
        for k,b in pairs(buttons) do n=n+1; local bi=type(b)=="table" and b or {Text=tostring(b)}; local bt=mk("TextButton",{AutoButtonColor=false,Text=tostring(bi.Text or "OK"),TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,Size=UDim2.fromOffset(64,22),Position=UDim2.fromOffset(8+(n-1)*70,88),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,ZIndex=992,Parent=fr}); line(bt,Color3.fromRGB(60,60,65),1); bt.Activated:Connect(function() if type(bi.Func)=="function" then pcall(bi.Func,obj) end end); obj.Buttons[k]=bt end
        return obj
    end
    w.AddLeftGroupbox=function(s,a,b,c,d,e) local o=type(a)=="table" and a or {Name=a,IconName=b,Visible=c,Collapsed=d,DisableCollapsing=e}; return s:AddGroupbox(o) end
    w.AddRightGroupbox=function(s,a,b,c,d,e) local o=type(a)=="table" and a or {Name=a,IconName=b,Visible=c,Collapsed=d,DisableCollapsing=e}; return s:AddGroupbox(o) end
    if title and type(title)=="table" then w.Footer=title.Footer; w.NotifySide=title.NotifySide; if title.Icon then w:SetIcon(title.Icon) end end
    return w
end

local oldAddOptionEnhance=lib._enhanceOption
lib._enhanceOption=function(self,o)
    oldAddOptionEnhance(self,o)
    if not o then return o end
    o.Name=o.Name or o.flag or o.text
    o.Text=o.text
    o.Tooltip=o.desc
    o.DisabledTooltip=o.disabledDesc
    o.Visible=o.visible~=false
    o.Disabled=o.disabled==true
    if o.flag then
        if o.kind=="toggle" then self.Toggles[o.flag]=o else self.Options[o.flag]=o end
    end
    local oldVisible=o.SetVisible
    o.SetVisible=function(s,v) s.Visible=v~=false; return oldVisible(s,v) end
    local oldDisabled=o.SetDisabled
    o.SetDisabled=function(s,v) s.Disabled=v==true; return oldDisabled(s,v) end
    if o.kind=="bind" then
        local oldSetMode=o.SetMode
        o.SetMode=function(s,v) s.Mode=tostring(v or "Toggle"); return oldSetMode(s,v) end
        local oldGetState=o.GetState
        o.GetState=function(s) return oldGetState(s) end
        local oldSetValue=o.SetValue
        o.SetValue=function(s,v) local r=oldSetValue(s,v); s.Value=s.key; return r end
    elseif o.kind=="color" then
        o.SetValueRGB=o.SetValueRGB
        o.SetValue=o.SetValue or function(s,v,t) s:SetColor(v); if t~=nil then s:SetAlpha(1-tonumber(t)) end; return s end
    elseif o.kind=="list" then
        o.SetValues=o.SetValues or function(s,v) s.values=type(v)=="table" and v or {}; return s end
        o.SetValueImages=o.SetValueImages or function(s,v) s.ValueImages=v; return s end
    end
    if o._click and o.cb then local baseCb=o.cb; o.cb=function(...) local r=baseCb(...); for _,fn in ipairs(o._click) do pcall(fn,...) end; return r end end
    if o.kind=="toggle" then o.Value=o.state; o.State=o.state end
    if o.kind=="slider" then o.Value=o.value; o.Min=o.min; o.Max=o.max; o.Rounding=o.step; o.Prefix=o.prefix; o.Suffix=o.suffix end
    if o.kind=="progress" then
        o.Value=o.value
        o.Min=o.min
        o.Max=o.max
        o.GetPercentage=o.GetPercentage or function(s)
            local a=tonumber(s.min) or 0
            local b=tonumber(s.max) or 100
            if b==a then return 0 end
            return ((tonumber(s.value) or a)-a)/(b-a)*100
        end
        o.GetValue=o.GetValue or function(s) return s.value end
        local oldSet=o.SetValue
        if oldSet then
            o.SetValue=function(s,v) local r=oldSet(s,v); s.Value=s.value; return r end
        end
    end
    if o.kind=="box" then o.Value=o.value; o.Text=o.text; o.Placeholder=o.placeholder end
    if o.kind=="list" then o.Value=o.value; o.Values=o.values; o.Multi=o.multi; o.Searchable=o.searchable end
    if o.kind=="bind" then o.Key=o.key; o.Mode=o.mode; o.Modifiers=o.modifiers or {} end
    if o.kind=="color" then o.Value=o.color; o.Transparency=o.transparency end
    return o
end

local oldNotify=lib.Notify
lib.Notify=function(self,title,text,duration)
    if type(title)=="table" then
        local d=title
        return oldNotify(self,d.Title or d.title or "Notification",d.Description or d.Content or d.Text or d.text or "",d.Time or d.Duration or d.duration or 4)
    end
    return oldNotify(self,title,text,duration)
end
lib.CreateNotification=function(self,data,text,duration) return self:Notify(data,text,duration) end
lib.ShowNotification=function(self,data) return self:Notify(data) end
lib.SaveConfiguration=function(self,n) return self:SaveConfig(n) end
lib.LoadConfiguration=function(self,n) return self:LoadConfig(n) end
lib.DeleteConfiguration=function(self,n) return self:DeleteConfig(n) end
lib.GetConfigs=function(self) return self:ListConfigs() end
lib.SetToggleKey=function(self,k) return self:SetKeybind(k) end
lib.Get=function(self,k) return self.flags[k] end
lib.Set=function(self,k,v) return self:SetFlag(k,v) end
lib.UpdateSearch=function(self,q) self.LastSearch=tostring(q or ""); return self:Search(self.LastSearch) end
lib.UpdateDependencyBoxes=function(self) return self:UpdateDependencies() end
lib.GetIcon=function(self,name) return self.Icons and self.Icons[name] end
lib.GetCustomIcon=function(self,name) return self.CustomIcons and self.CustomIcons[name] end
lib.SetIconModule=function(self,module) self.IconModule=module; return self end
lib.Validate=function(self,tpl,shape)
    local out=type(tpl)=="table" and table.clone(tpl) or {}
    if type(shape)=="table" then for k,v in pairs(shape) do if out[k]==nil then out[k]=v end end end
    return out
end
lib.ApplyLucideIcon=function(self,gui,icon,rotation)
    if gui and gui:IsA("ImageLabel") or gui and gui:IsA("ImageButton") then gui.Image=typeof(icon)=="number" and "rbxassetid://"..tostring(icon) or tostring(icon or ""); gui.Rotation=rotation or 0 end
    return gui
end
lib.MakeLine=function(self,frame,info) if not frame then return nil end; local z=mk("Frame",{Size=type(info)=="table" and info.Size or UDim2.new(1,0,0,1),Position=type(info)=="table" and info.Position or UDim2.new(0,0,1,-1),BackgroundColor3=(type(info)=="table" and info.Color) or Color3.fromRGB(60,60,65),BorderSizePixel=0,Parent=frame}); return z end
lib.AddBlank=function(self,frame,size) return mk("Frame",{Size=size or UDim2.fromOffset(1,4),BackgroundTransparency=1,BorderSizePixel=0,Parent=frame}) end
lib.AddOutline=function(self,frame) if frame then return line(frame,Color3.fromRGB(60,60,65),1) end end
lib.MakeOutline=function(self,frame) return self:AddOutline(frame) end
lib.MakeDraggable=function(self,object,handle,callback)
    if not object or not handle then return object end
    local active=false; local start; local pos
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then active=true; start=i.Position; pos=object.Position end
    end)
    local c=inp.InputChanged:Connect(function(i)
        if not active or (i.UserInputType~=Enum.UserInputType.MouseMovement and i.UserInputType~=Enum.UserInputType.Touch) then return end
        local d=i.Position-start; object.Position=UDim2.fromOffset(pos.X.Offset+d.X,pos.Y.Offset+d.Y); if type(callback)=="function" then pcall(callback) end
    end)
    self:GiveSignal(c)
    inp.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then active=false end end)
    return object
end
local function dragWidget(self,kind,text,func)
    if not self.base then return nil end
    local m=mk(kind=="button" and "TextButton" or "TextLabel",{AutoButtonColor=false,Size=UDim2.fromOffset(220,24),Position=UDim2.fromOffset(8,8),BackgroundColor3=Color3.fromRGB(20,20,22),BorderSizePixel=0,Text=tostring(text or ""),TextColor3=Color3.fromRGB(240,240,240),TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=880,Parent=self.base})
    line(m,Color3.fromRGB(60,60,65),1)
    self:MakeDraggable(m,m)
    if kind=="button" and type(func)=="function" then m.Activated:Connect(function() pcall(func) end) end
    return m
end
lib.AddDraggableLabel=function(self,text) return dragWidget(self,"label",text) end
lib.AddDraggableButton=function(self,text,callback) return dragWidget(self,"button",text,callback) end
lib.AddDraggableImageButton=function(self,text,image,callback) local m=dragWidget(self,"button",text,callback); if m then m.Text=""; m.AutoButtonColor=false; local i=mk("ImageLabel",{Size=UDim2.fromOffset(16,16),Position=UDim2.fromOffset(4,4),BackgroundTransparency=1,Image=typeof(image)=="number" and "rbxassetid://"..tostring(image) or tostring(image or ""),Parent=m}) end; return m end
lib.AddDraggableMenu=function(self,name) return self:AddDraggableLabel(name) end

function lib:RunExample()
    if self.Unloaded then return nil end
    self:SetAccent(Color3.fromRGB(255,65,65))
    self:SetToggleKey(Enum.KeyCode.RightControl)
    local w=self:CreateWindow({Title="LibraryNew Example",AutoShow=true,ToggleKeybind=Enum.KeyCode.RightControl})
    local main=w:AddFolder("Main")
    local t=main:AddToggle("ExampleToggle",{Text="Example Toggle",Default=true,Tooltip="Toggle with callbacks and picker chaining.",Callback=function(v) self:Notify("Toggle",tostring(v),1.5) end})
    t:OnChanged(function(v) self.flags.ExampleToggle=v end)
    t:AddColorPicker("ExampleColor",{Text="Accent Color",Default=Color3.fromRGB(255,65,65)})
    t:AddKeyPicker("ExampleKey",{Text="Toggle Key",Default=Enum.KeyCode.F,Mode="Toggle"})
    main:AddButton("Example Button",{Tooltip="Button callback example.",Callback=function() self:Notify("Button","Clicked",2) end})
    main:AddSlider("ExampleSlider",{Text="Slider",Min=0,Max=100,Default=50,Rounding=1,Prefix="",Suffix="%",Callback=function(v) end})
    main:AddDropdown("ExampleDropdown",{Text="Dropdown",Values={"One","Two","Three"},Default="One",Searchable=true,Callback=function(v) end})
    main:AddDropdown("ExampleMulti",{Text="Multi Select",Values={"A","B","C","D"},Default={"A","C"},Multi=true,Searchable=true,Callback=function(v) end})
    main:AddInput("ExampleInput",{Text="Input",Default="Hello",Placeholder="Type here...",Callback=function(v) end})
    main:AddInput("ExampleNumber",{Text="Number",Default="25",Numeric=true,Callback=function(v) end})
    main:AddKeybind("ExampleBind",{Text="Keybind",Default=Enum.KeyCode.G,Mode="Toggle",ChangedCallback=function(k) end,Callback=function(v) end})
    main:AddColorPicker("ExampleColorPicker",{Text="Color Picker",Default=Color3.fromRGB(80,200,100),Transparency=0})
    main:AddLabel("LibraryNew compact example")
    main:AddParagraph({Title="Paragraph",Description="This demonstrates the paragraph element without changing the compact renderer."})
    main:AddDivider()
    local stat=main:AddStat("ExampleStat",{Default=42}); stat:Set(84)
    local prog=main:AddProgress("ExampleProgress",{Min=0,Max=100,Default=65}); prog:Set(75)
    main:AddConsole("ExampleConsole",{Text="Console ready."}):Append("Example line")
    local nested=main:AddFolder({Name="Nested",Tooltip="Nested compact section."})
    local dep=nested:AddToggle("ShowDependent",{Text="Show dependent",Default=true})
    local dependent=nested:AddLabel("Dependent element")
    dependent:AddDependency("ShowDependent",true)
    local misc=w:AddFolder("Functions")
    misc:AddButton("Notify",{Callback=function() self:Notify("Example","Notification API",2) end})
    misc:AddButton("Search",{Callback=function() self:Search("Example") end})
    misc:AddButton("Save Config",{Callback=function() self:SaveConfig("example") end})
    misc:AddButton("Load Config",{Callback=function() self:LoadConfig("example") end})
    misc:AddButton("Change Accent",{Callback=function() self:SetAccent(Color3.fromRGB(80,200,100)) end})
    misc:AddButton("Center",{Callback=function() if w.Center then w:Center() end end})
    misc:AddButton("Minimize",{Callback=function() w:Minimize() end})
    misc:AddButton("Unload",{Callback=function() self:Unload() end})
    local tabbox=w:AddLeftTabbox({Name="ExampleTabs"})
    local tab1=tabbox:AddTab({Name="Tab 1"})
    tab1:AddLabel("Tabbox API example")
    tab1:AddButton("Tab Button",{Callback=function() self:Notify("Tab","Works",1.5) end})
    local tab2=tabbox:AddTab({Name="Tab 2"})
    tab2:AddSlider("TabSlider",{Min=0,Max=10,Default=5})
    self:OnUnload(function() end)
    self:Notify("LibraryNew","Example loaded",3)
    self:Init()
    return w
end


lib.KeybindFrame=lib.KeybindFrame or {Visible=false}
lib.Scheme=lib.Scheme or {Red=TH.acc,Text=Color3.fromRGB(240,240,240),Dim=Color3.fromRGB(140,140,150),Accent=TH.acc}

if type(getgenv)=="function" then
    local env=getgenv()
    if env.LibraryNewRunExample==true then
        task.defer(function() lib:RunExample() end)
    end
end

return lib
