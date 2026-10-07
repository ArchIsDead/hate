-- suic1.de

local lib = {flags = {}, wins = {}, open = true, pop = nil}

local run = game:GetService("RunService")
local tw = game:GetService("TweenService")
local txt = game:GetService("TextService")
local inp = game:GetService("UserInputService")
local plr = game:GetService("Players")
local cg = game:GetService("CoreGui")
local m1 = Enum.UserInputType.MouseButton1

local drag, dragIn, dragStart, startPos, dragObj

local function rnd(n, b)
    b = b or 1
    local a = math.floor(n / b + (math.sign(n) * 0.5)) * b
    if a < 0 then a = a + b end
    return a
end

local function kCk(x, t)
    for _, v in next, t do
        if v == x then return true end
    end
end

local function upd(i)
    local d = i.Position - dragStart
    local y = (startPos.Y.Offset + d.Y) < -36 and -36 or startPos.Y.Offset + d.Y
    dragObj:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, y), "Out", "Quint", 0.1, true)
end

local chr
local rT = 5
task.spawn(function()
    while task.wait() do
        chr = Color3.fromHSV(tick() % rT / rT, 1, 1)
    end
end)

local TH = {
    bg = Color3.fromRGB(16, 16, 18),
    bgD = Color3.fromRGB(10, 10, 12),
    bgL = Color3.fromRGB(24, 24, 27),
    acc = Color3.fromRGB(255, 65, 65),
    tx = Color3.fromRGB(245, 245, 250),
    txD = Color3.fromRGB(150, 150, 160),
    txM = Color3.fromRGB(90, 90, 100),
    st = Color3.fromRGB(45, 45, 50),
}

function lib:Create(c, p)
    p = typeof(p) == "table" and p or {}
    local o = Instance.new(c)
    for k, v in next, p do
        o[k] = v
    end
    return o
end

local function crn(o, r)
    return lib:Create("UICorner", {CornerRadius = UDim.new(0, r or 8), Parent = o})
end

local function stk(o, c, t, tr)
    return lib:Create("UIStroke", {
        Color = c or TH.st,
        Thickness = t or 1,
        Transparency = tr or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = o,
    })
end

local function pad(o, a)
    return lib:Create("UIPadding", {
        PaddingTop = UDim.new(0, a),
        PaddingBottom = UDim.new(0, a),
        PaddingLeft = UDim.new(0, a),
        PaddingRight = UDim.new(0, a),
        Parent = o,
    })
end

local function hld(title, par, tbl, sub)
    local sz = sub and 34 or 42
    tbl.main = lib:Create("ImageButton", {
        LayoutOrder = sub and tbl.position or 0,
        Position = UDim2.new(0, 20 + (250 * (tbl.position or 0)), 0, 20),
        Size = UDim2.new(0, 230, 0, sz),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bg,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.04,
        ClipsDescendants = true,
        Parent = par,
    })
    crn(tbl.main, 10)
    stk(tbl.main, TH.st, 1, 0.6)

    local rndl
    if not sub then
        rndl = lib:Create("ImageLabel", {
            Size = UDim2.new(1, 0, 0, sz),
            BackgroundTransparency = 1,
            Image = "rbxassetid://3570695787",
            ImageColor3 = tbl.open and TH.bgL or TH.bgD,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.04,
            Parent = tbl.main,
        })
        crn(rndl, 10)
    end

    if tbl.icon then
        tbl.iconLbl = lib:Create("ImageLabel", {
            Position = UDim2.new(0, 12, 0.5, -9),
            Size = UDim2.new(0, 18, 0, 18),
            BackgroundTransparency = 1,
            Image = tbl.icon,
            ImageColor3 = TH.acc,
            ScaleType = Enum.ScaleType.Fit,
            Parent = tbl.main,
        })
    end

    local tOff = tbl.icon and 38 or 14

    local ttl = lib:Create("TextLabel", {
        Position = UDim2.new(0, tOff, 0, 0),
        Size = UDim2.new(1, -tOff - 40, 0, sz),
        BackgroundTransparency = sub and 0 or 1,
        BackgroundColor3 = TH.bgD,
        BorderSizePixel = 0,
        Text = title,
        TextSize = sub and 15 or 16,
        Font = Enum.Font.GothamBold,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tbl.main,
    })

    if sub then
        crn(ttl, 8)
    end

    local cHld = lib:Create("Frame", {
        Position = UDim2.new(1, -40, 0, 0),
        Size = UDim2.new(0, 40, 1, 0),
        BackgroundTransparency = 1,
        Parent = tbl.main,
    })

    local cls = lib:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 14, 0, 14),
        Rotation = tbl.open and 90 or 180,
        BackgroundTransparency = 1,
        Image = "rbxassetid://4918373417",
        ImageColor3 = tbl.open and TH.acc or TH.txM,
        ScaleType = Enum.ScaleType.Fit,
        Parent = cHld,
    })

    tbl.content = lib:Create("Frame", {
        Position = UDim2.new(0, 0, 0, sz),
        Size = UDim2.new(1, 0, 1, -sz),
        BackgroundTransparency = 1,
        Parent = tbl.main,
    })

    local lay = lib:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = tbl.content,
    })

    lay.Changed:Connect(function()
        tbl.content.Size = UDim2.new(1, 0, 0, lay.AbsoluteContentSize.Y)
        tbl.main.Size = #tbl.options > 0 and tbl.open and UDim2.new(0, 230, 0, lay.AbsoluteContentSize.Y + sz + 8) or UDim2.new(0, 230, 0, sz)
    end)

    if not sub then
        ttl.InputBegan:Connect(function(i)
            if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
                dragObj = tbl.main
                drag = true
                dragStart = i.Position
                startPos = dragObj.Position
            end
        end)
        ttl.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                dragIn = i
            end
        end)
        ttl.InputEnded:Connect(function(i)
            if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = false
            end
        end)
    end

    local function tg()
        tbl.open = not tbl.open
        tw:Create(cls, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Rotation = tbl.open and 90 or 180,
            ImageColor3 = tbl.open and TH.acc or TH.txM,
        }):Play()
        if sub then
            tw:Create(ttl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = tbl.open and TH.bgL or TH.bgD,
            }):Play()
        else
            tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageColor3 = tbl.open and TH.bgL or TH.bgD,
            }):Play()
        end
        tbl.main:TweenSize(
            #tbl.options > 0 and tbl.open and UDim2.new(0, 230, 0, lay.AbsoluteContentSize.Y + sz + 8) or UDim2.new(0, 230, 0, sz),
            "Out", "Quad", 0.2, true
        )
    end

    cHld.InputBegan:Connect(function(i)
        if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
            tg()
        end
    end)

    function tbl:SetTitle(n)
        ttl.Text = tostring(n)
    end

    function tbl:SetIcon(i)
        if tbl.iconLbl then
            tbl.iconLbl.Image = i
        end
    end

    return tbl
end

local function crLbl(o, par)
    local m = lib:Create("TextLabel", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.txD,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = par.content,
    })
    setmetatable(o, {__newindex = function(t, i, v)
        if i == "Text" then m.Text = " " .. tostring(v) end
    end})
end

local function crTg(o, par)
    local m = lib:Create("TextLabel", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = par.content,
    })

    local out = lib:Create("ImageLabel", {
        Position = UDim2.new(1, -6, 0, 6),
        Size = UDim2.new(-1, 10, 1, -12),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = o.state and TH.acc or TH.txM,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(out, 4)

    local inn = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 2, 0, 2),
        Size = UDim2.new(1, -4, 1, -4),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = o.state and TH.acc or TH.bgD,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = out,
    })
    crn(inn, 3)

    local ckH = lib:Create("Frame", {
        Position = UDim2.new(0, 4, 0, 4),
        Size = o.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = out,
    })

    local ck = lib:Create("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundTransparency = 1,
        Image = "rbxassetid://4919148038",
        ImageColor3 = TH.bgD,
        Parent = ckH,
    })

    local ic
    m.InputBegan:Connect(function(i)
        if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
            o:SetState(not o.state)
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not o.state then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(160, 160, 170)}):Play()
            end
        end
    end)

    m.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not o.state then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
            end
        end
    end)

    function o:SetState(s)
        lib.flags[self.flag] = s
        self.state = s
        ckH:TweenSize(o.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8), "Out", "Quad", 0.2, true)
        tw:Create(inn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = s and TH.acc or TH.bgD}):Play()
        if s then
            tw:Create(out, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
        else
            if ic then
                tw:Create(out, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(160, 160, 170)}):Play()
            else
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
            end
        end
        self.callback(s)
    end

    if o.state then
        task.delay(1, function() o.callback(true) end)
    end

    setmetatable(o, {__newindex = function(t, i, v)
        if i == "Text" then m.Text = " " .. tostring(v) end
    end})
end

local function crBt(o, par)
    local m = lib:Create("TextLabel", {
        ZIndex = 2,
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        Parent = par.content,
    })

    local rndl = lib:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -12, 1, -10),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgL,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(rndl, 6)
    stk(rndl, TH.st, 1, 0.5)

    local ic, clk
    m.InputBegan:Connect(function(i)
        if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
            lib.flags[o.flag] = true
            clk = true
            tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
            o.callback()
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 45)}):Play()
        end
    end)

    m.InputEnded:Connect(function(i)
        if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
            clk = false
            if ic then
                tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 45)}):Play()
            else
                tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.bgL}):Play()
            end
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not clk then
                tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.bgL}):Play()
            end
        end
    end)
end

local function crBnd(o, par)
    local bnd, hld2, lp
    local t = string.match(o.key, "Mouse") and string.sub(o.key, 1, 5) .. string.sub(o.key, 12, 13) or o.key

    local m = lib:Create("TextLabel", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 33),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = par.content,
    })

    local rndl = lib:Create("ImageLabel", {
        Position = UDim2.new(1, -6, 0, 4),
        Size = UDim2.new(0, -txt:GetTextSize(t, 14, Enum.Font.Gotham, Vector2.new(9e9, 9e9)).X - 20, 1, -10),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgL,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(rndl, 6)
    stk(rndl, TH.st, 1, 0.5)

    local bIn = lib:Create("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = t,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        Parent = rndl,
    })

    local ic
    m.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not bnd then
                tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 45)}):Play()
            end
        end
    end)

    m.InputEnded:Connect(function(i)
        if i.UserInputType == m1 then
            bnd = true
            bIn.Text = "..."
            tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
        elseif i.UserInputType == Enum.UserInputType.Touch then
            bnd = true
            bIn.Text = "..."
            tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not bnd then
                tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.bgL}):Play()
            end
        end
    end)

    inp.InputBegan:Connect(function(i)
        if inp:GetFocusedTextBox() then return end
        if (i.KeyCode.Name == o.key or i.UserInputType.Name == o.key) and not bnd then
            if o.hold then
                lp = run.Heartbeat:Connect(function()
                    if bnd then
                        o.callback(true)
                        lp:Disconnect()
                        lp = nil
                    else
                        o.callback()
                    end
                end)
            else
                o.callback()
            end
        elseif bnd then
            local k
            pcall(function()
                if not kCk(i.KeyCode, blkKeys) then
                    k = i.KeyCode
                end
            end)
            pcall(function()
                if kCk(i.UserInputType, wlMouse) and not k then
                    k = i.UserInputType
                end
            end)
            k = k or o.key
            o:SetKey(k)
        end
    end)

    inp.InputEnded:Connect(function(i)
        if i.KeyCode.Name == o.key or i.UserInputType.Name == o.key or i.UserInputType.Name == "MouseMovement" then
            if lp then
                lp:Disconnect()
                lp = nil
                o.callback(true)
            end
        end
    end)

    function o:SetKey(k)
        bnd = false
        if lp then
            lp:Disconnect()
            lp = nil
        end
        self.key = k or self.key
        self.key = self.key.Name or self.key
        lib.flags[self.flag] = self.key
        if string.match(self.key, "Mouse") then
            bIn.Text = string.sub(self.key, 1, 5) .. string.sub(self.key, 12, 13)
        else
            bIn.Text = self.key
        end
        tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = ic and Color3.fromRGB(40, 40, 45) or TH.bgL}):Play()
        rndl.Size = UDim2.new(0, -txt:GetTextSize(bIn.Text, 13, Enum.Font.Gotham, Vector2.new(9e9, 9e9)).X - 20, 1, -10)
    end
end

local function crSld(o, par)
    local m = lib:Create("Frame", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Parent = par.content,
    })

    local ttl = lib:Create("TextLabel", {
        Position = UDim2.new(0, 0, 0, 4),
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = m,
    })

    local sld = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 10, 0, 34),
        Size = UDim2.new(1, -20, 0, 5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgL,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(sld, 3)

    local fl = lib:Create("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.txM,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = sld,
    })
    crn(fl, 3)

    local ccl = lib:Create("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new((o.value - o.min) / (o.max - o.min), 0, 0.5, 0),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.txM,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 1,
        Parent = sld,
    })
    crn(ccl, 100)

    local vRnd = lib:Create("ImageLabel", {
        Position = UDim2.new(1, -6, 0, 4),
        Size = UDim2.new(0, -60, 0, 18),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgL,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(vRnd, 4)

    local vIn = lib:Create("TextBox", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = o.value,
        TextColor3 = TH.tx,
        TextSize = 13,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        Parent = vRnd,
    })

    if o.min >= 0 then
        fl.Size = UDim2.new((o.value - o.min) / (o.max - o.min), 0, 1, 0)
    else
        fl.Position = UDim2.new((0 - o.min) / (o.max - o.min), 0, 0, 0)
        fl.Size = UDim2.new(o.value / (o.max - o.min), 0, 1, 0)
    end

    local sldg, ic
    m.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
            tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(3.5, 0, 3.5, 0), ImageColor3 = TH.acc}):Play()
            sldg = true
            o:SetValue(o.min + ((i.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X) * (o.max - o.min))
        elseif i.UserInputType == Enum.UserInputType.Touch then
            tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
            tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(3.5, 0, 3.5, 0), ImageColor3 = TH.acc}):Play()
            sldg = true
            o:SetValue(o.min + ((i.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X) * (o.max - o.min))
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not sldg then
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
            end
        end
    end)

    inp.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and sldg then
            o:SetValue(o.min + ((i.Position.X - sld.AbsolutePosition.X) / sld.AbsoluteSize.X) * (o.max - o.min))
        end
    end)

    m.InputEnded:Connect(function(i)
        if i.UserInputType == m1 then
            sldg = false
            if ic then
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
            else
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = TH.txM}):Play()
            end
        elseif i.UserInputType == Enum.UserInputType.Touch then
            sldg = false
            if ic then
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
            else
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = TH.txM}):Play()
            end
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            vIn:ReleaseFocus()
            if not sldg then
                tw:Create(fl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
                tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = TH.txM}):Play()
            end
        end
    end)

    vIn.FocusLost:Connect(function()
        tw:Create(ccl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = TH.txM}):Play()
        o:SetValue(tonumber(vIn.Text) or o.value)
    end)

    function o:SetValue(v)
        v = rnd(v, o.float)
        v = math.clamp(v, self.min, self.max)
        ccl:TweenPosition(UDim2.new((v - self.min) / (self.max - self.min), 0, 0.5, 0), "Out", "Quad", 0.1, true)
        if self.min >= 0 then
            fl:TweenSize(UDim2.new((v - self.min) / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
        else
            fl:TweenPosition(UDim2.new((0 - self.min) / (self.max - self.min), 0, 0, 0), "Out", "Quad", 0.1, true)
            fl:TweenSize(UDim2.new(v / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
        end
        lib.flags[self.flag] = v
        self.value = v
        vIn.Text = v
        self.callback(v)
    end
end

local function crLst(o, par)
    local vc = 0

    local m = lib:Create("Frame", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundTransparency = 1,
        Parent = par.content,
    })

    local rndl = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 6, 0, 4),
        Size = UDim2.new(1, -12, 1, -10),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgL,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(rndl, 6)
    stk(rndl, TH.st, 1, 0.5)

    local ttl = lib:Create("TextLabel", {
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 14),
        BackgroundTransparency = 1,
        Text = o.text,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.txD,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = m,
    })

    local lv = lib:Create("TextLabel", {
        Position = UDim2.new(0, 12, 0, 20),
        Size = UDim2.new(1, -24, 0, 24),
        BackgroundTransparency = 1,
        Text = o.value,
        TextSize = 16,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = m,
    })

    lib:Create("ImageLabel", {
        Position = UDim2.new(1, -16, 0, 16),
        Size = UDim2.new(-1, 32, 1, -32),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Rotation = 90,
        BackgroundTransparency = 1,
        Image = "rbxassetid://4918373417",
        ImageColor3 = TH.txD,
        ScaleType = Enum.ScaleType.Fit,
        Parent = rndl,
    })

    o.mainHolder = lib:Create("ImageButton", {
        ZIndex = 3,
        Size = UDim2.new(0, 240, 0, 52),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageTransparency = 1,
        ImageColor3 = TH.bgD,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Visible = false,
        Parent = lib.base,
    })
    crn(o.mainHolder, 8)
    stk(o.mainHolder, TH.st, 1, 0.5)

    local content = lib:Create("ScrollingFrame", {
        ZIndex = 3,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarImageColor3 = TH.txM,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = o.mainHolder,
    })

    pad(content, 6)

    local lay = lib:Create("UIListLayout", {
        Parent = content,
    })

    lay.Changed:Connect(function()
        o.mainHolder.Size = UDim2.new(0, 240, 0, (vc > 4 and (4 * 40) or lay.AbsoluteContentSize.Y) + 12)
        content.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 12)
    end)

    local ic
    rndl.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            if lib.pop then lib.pop:Close() end
            local p = m.AbsolutePosition
            o.mainHolder.Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)
            o.open = true
            o.mainHolder.Visible = true
            lib.pop = o
            content.ScrollBarThickness = 6
            tw:Create(o.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, p.X - 5, 0, p.Y - 4)}):Play()
            tw:Create(o.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, p.X - 5, 0, p.Y + 1)}):Play()
        elseif i.UserInputType == Enum.UserInputType.Touch then
            if lib.pop then lib.pop:Close() end
            local p = m.AbsolutePosition
            o.mainHolder.Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)
            o.open = true
            o.mainHolder.Visible = true
            lib.pop = o
            content.ScrollBarThickness = 6
            tw:Create(o.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, p.X - 5, 0, p.Y - 4)}):Play()
            tw:Create(o.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, p.X - 5, 0, p.Y + 1)}):Play()
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not o.open then
                tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 45)}):Play()
            end
        end
    end)

    rndl.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not o.open then
                tw:Create(rndl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.bgL}):Play()
            end
        end
    end)

    function o:AddValue(v)
        vc = vc + 1
        local lbl = lib:Create("TextLabel", {
            ZIndex = 3,
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = TH.bgL,
            BorderSizePixel = 0,
            Text = "    " .. v,
            TextSize = 14,
            TextTransparency = self.open and 0 or 1,
            Font = Enum.Font.Gotham,
            TextColor3 = TH.tx,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = content,
        })
        crn(lbl, 6)

        local ic2, clk
        lbl.InputBegan:Connect(function(i)
            if i.UserInputType == m1 then
                clk = true
                tw:Create(lbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = TH.bgD}):Play()
                self:SetValue(v)
            elseif i.UserInputType == Enum.UserInputType.Touch then
                clk = true
                tw:Create(lbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = TH.bgD}):Play()
                self:SetValue(v)
            end
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                ic2 = true
                if not clk then
                    tw:Create(lbl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play()
                end
            end
        end)

        lbl.InputEnded:Connect(function(i)
            if i.UserInputType == m1 then
                clk = false
                tw:Create(lbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = ic2 and Color3.fromRGB(30, 30, 35) or TH.bgL}):Play()
            elseif i.UserInputType == Enum.UserInputType.Touch then
                clk = false
                tw:Create(lbl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = ic2 and Color3.fromRGB(30, 30, 35) or TH.bgL}):Play()
            end
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                ic2 = false
                if not clk then
                    tw:Create(lbl, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = TH.bgL}):Play()
                end
            end
        end)
    end

    if not table.find(o.values, o.value) then
        o:AddValue(o.value)
    end

    for _, v in next, o.values do
        o:AddValue(tostring(v))
    end

    function o:RemoveValue(v)
        for _, lbl in next, content:GetChildren() do
            if lbl:IsA"TextLabel" and lbl.Text == "	" .. v then
                lbl:Destroy()
                vc = vc - 1
                break
            end
        end
        if self.value == v then
            self:SetValue("")
        end
    end

    function o:SetValue(v)
        lib.flags[self.flag] = tostring(v)
        self.value = tostring(v)
        lv.Text = self.value
        self.callback(v)
    end

    function o:Close()
        lib.pop = nil
        self.open = false
        content.ScrollBarThickness = 0
        local p = m.AbsolutePosition
        tw:Create(rndl, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = ic and Color3.fromRGB(40, 40, 45) or TH.bgL}):Play()
        tw:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)}):Play()
        for _, lbl in next, content:GetChildren() do
            if lbl:IsA"TextLabel" then
                tw:Create(lbl, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            end
        end
        task.wait(0.3)
        if not self.open then
            self.mainHolder.Visible = false
        end
    end

    return o
end

local function crBox(o, par)
    local m = lib:Create("Frame", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundTransparency = 1,
        Parent = par.content,
    })

    local out = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 6, 0, 4),
        Size = UDim2.new(1, -12, 1, -10),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.st,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = m,
    })
    crn(out, 6)

    local rndl = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 8, 0, 6),
        Size = UDim2.new(1, -16, 1, -14),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.bgD,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.01,
        Parent = m,
    })
    crn(rndl, 4)

    local ttl = lib:Create("TextLabel", {
        Position = UDim2.new(0, 12, 0, 8),
        Size = UDim2.new(1, -24, 0, 14),
        BackgroundTransparency = 1,
        Text = o.text,
        TextSize = 13,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.txM,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = m,
    })

    local vIn = lib:Create("TextBox", {
        Position = UDim2.new(0, 12, 0, 20),
        Size = UDim2.new(1, -24, 0, 24),
        BackgroundTransparency = 1,
        Text = o.value,
        TextSize = 16,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = m,
    })

    local ic, foc
    m.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            if not foc then vIn:CaptureFocus() end
        elseif i.UserInputType == Enum.UserInputType.Touch then
            if not foc then vIn:CaptureFocus() end
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not foc then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 110)}):Play()
            end
        end
    end)

    m.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not foc then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.st}):Play()
            end
        end
    end)

    vIn.Focused:Connect(function()
        foc = true
        tw:Create(out, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.acc}):Play()
    end)

    vIn.FocusLost:Connect(function(en)
        foc = false
        tw:Create(out, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.st}):Play()
        o:SetValue(vIn.Text, en)
    end)

    function o:SetValue(v, en)
        lib.flags[self.flag] = tostring(v)
        self.value = tostring(v)
        vIn.Text = self.value
        self.callback(v, en)
    end
end

local function crClrWind(o)
    o.mainHolder = lib:Create("ImageButton", {
        ZIndex = 3,
        Size = UDim2.new(0, 240, 0, 180),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageTransparency = 1,
        ImageColor3 = TH.bgD,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = lib.base,
    })
    crn(o.mainHolder, 8)
    stk(o.mainHolder, TH.st, 1, 0.5)

    local hu, sa, va = Color3.toHSV(o.color)
    hu, sa, va = hu == 0 and 1 or hu, sa + 0.005, va - 0.005
    local edHu
    local edSa
    local curClr = o.color
    local prvClr = {[1] = o.color}
    local orgClr = o.color
    local rbOn
    local rbLp

    function o:updateVisuals(Color)
        curClr = Color
        self.visualize2.ImageColor3 = Color
        hu, sa, va = Color3.toHSV(Color)
        hu = hu == 0 and 1 or hu
        self.satval.BackgroundColor3 = Color3.fromHSV(hu, 1, 1)
        self.hueSlider.Position = UDim2.new(1 - hu, 0, 0, 0)
        self.satvalSlider.Position = UDim2.new(sa, 0, 1 - va, 0)
    end

    o.hue = lib:Create("ImageLabel", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 8, 1, -8),
        Size = UDim2.new(1, -100, 0, 22),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = o.mainHolder,
    })
    crn(o.hue, 4)

    local grd = lib:Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.157, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(0.323, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.488, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.817, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
        }),
        Parent = o.hue,
    })

    o.hueSlider = lib:Create("Frame", {
        ZIndex = 3,
        Position = UDim2.new(1 - hu, 0, 0, 0),
        Size = UDim2.new(0, 2, 1, 0),
        BackgroundTransparency = 1,
        BackgroundColor3 = TH.bgD,
        BorderColor3 = Color3.fromRGB(255, 255, 255),
        Parent = o.hue,
    })

    o.hue.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            edHu = true
            local X = (o.hue.AbsolutePosition.X + o.hue.AbsoluteSize.X) - o.hue.AbsolutePosition.X
            X = (i.Position.X - o.hue.AbsolutePosition.X) / X
            X = X < 0 and 0 or X > 0.995 and 0.995 or X
            o:updateVisuals(Color3.fromHSV(1 - X, sa, va))
        elseif i.UserInputType == Enum.UserInputType.Touch then
            edHu = true
            local X = (o.hue.AbsolutePosition.X + o.hue.AbsoluteSize.X) - o.hue.AbsolutePosition.X
            X = (i.Position.X - o.hue.AbsolutePosition.X) / X
            X = X < 0 and 0 or X > 0.995 and 0.995 or X
            o:updateVisuals(Color3.fromHSV(1 - X, sa, va))
        end
    end)

    inp.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and edHu then
            local X = (o.hue.AbsolutePosition.X + o.hue.AbsoluteSize.X) - o.hue.AbsolutePosition.X
            X = (i.Position.X - o.hue.AbsolutePosition.X) / X
            X = X <= 0 and 0 or X >= 0.995 and 0.995 or X
            o:updateVisuals(Color3.fromHSV(1 - X, sa, va))
        end
    end)

    o.hue.InputEnded:Connect(function(i)
        if i.UserInputType == m1 then
            edHu = false
        elseif i.UserInputType == Enum.UserInputType.Touch then
            edHu = false
        end
    end)

    o.satval = lib:Create("ImageLabel", {
        ZIndex = 3,
        Position = UDim2.new(0, 8, 0, 8),
        Size = UDim2.new(1, -100, 1, -42),
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromHSV(hu, 1, 1),
        BorderSizePixel = 0,
        Image = "rbxassetid://4155801252",
        ImageTransparency = 1,
        ClipsDescendants = true,
        Parent = o.mainHolder,
    })
    crn(o.satval, 4)

    o.satvalSlider = lib:Create("Frame", {
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(sa, 0, 1 - va, 0),
        Size = UDim2.new(0, 4, 0, 4),
        Rotation = 45,
        BackgroundTransparency = 1,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = o.satval,
    })

    o.satval.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            edSa = true
            local X = (o.satval.AbsolutePosition.X + o.satval.AbsoluteSize.X) - o.satval.AbsolutePosition.X
            local Y = (o.satval.AbsolutePosition.Y + o.satval.AbsoluteSize.Y) - o.satval.AbsolutePosition.Y
            X = (i.Position.X - o.satval.AbsolutePosition.X) / X
            Y = (i.Position.Y - o.satval.AbsolutePosition.Y) / Y
            X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
            Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
            o:updateVisuals(Color3.fromHSV(hu, X, 1 - Y))
        elseif i.UserInputType == Enum.UserInputType.Touch then
            edSa = true
            local X = (o.satval.AbsolutePosition.X + o.satval.AbsoluteSize.X) - o.satval.AbsolutePosition.X
            local Y = (o.satval.AbsolutePosition.Y + o.satval.AbsoluteSize.Y) - o.satval.AbsolutePosition.Y
            X = (i.Position.X - o.satval.AbsolutePosition.X) / X
            Y = (i.Position.Y - o.satval.AbsolutePosition.Y) / Y
            X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
            Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
            o:updateVisuals(Color3.fromHSV(hu, X, 1 - Y))
        end
    end)

    inp.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement and edSa then
            local X = (o.satval.AbsolutePosition.X + o.satval.AbsoluteSize.X) - o.satval.AbsolutePosition.X
            local Y = (o.satval.AbsolutePosition.Y + o.satval.AbsoluteSize.Y) - o.satval.AbsolutePosition.Y
            X = (i.Position.X - o.satval.AbsolutePosition.X) / X
            Y = (i.Position.Y - o.satval.AbsolutePosition.Y) / Y
            X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
            Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
            o:updateVisuals(Color3.fromHSV(hu, X, 1 - Y))
        end
    end)

    o.satval.InputEnded:Connect(function(i)
        if i.UserInputType == m1 then
            edSa = false
        elseif i.UserInputType == Enum.UserInputType.Touch then
            edSa = false
        end
    end)

    o.visualize2 = lib:Create("ImageLabel", {
        ZIndex = 3,
        Position = UDim2.new(1, -8, 0, 8),
        Size = UDim2.new(0, -80, 0, 80),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = curClr,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = o.mainHolder,
    })
    crn(o.visualize2, 6)

    local btns = {
        {name = "Reset", y = 92},
        {name = "Undo", y = 112},
        {name = "Set", y = 132},
        {name = "Rainbow", y = 152},
    }

    for _, b in ipairs(btns) do
        local btn = lib:Create("ImageLabel", {
            ZIndex = 3,
            Position = UDim2.new(1, -8, 0, b.y),
            Size = UDim2.new(0, -80, 0, 18),
            BackgroundTransparency = 1,
            Image = "rbxassetid://3570695787",
            ImageTransparency = 1,
            ImageColor3 = TH.bgL,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.02,
            Parent = o.mainHolder,
        })
        crn(btn, 4)

        local lbl = lib:Create("TextLabel", {
            ZIndex = 3,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = b.name,
            TextTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            TextColor3 = TH.tx,
            Parent = btn,
        })

        btn.InputBegan:Connect(function(i)
            if i.UserInputType == m1 and not rbOn then
                if b.name == "Reset" then
                    prvClr = {orgClr}
                    o:SetColor(orgClr)
                elseif b.name == "Undo" then
                    local n = #prvClr == 1 and 0 or 1
                    o:SetColor(prvClr[#prvClr - n])
                    if #prvClr ~= 1 then
                        table.remove(prvClr, #prvClr)
                    end
                elseif b.name == "Set" then
                    table.insert(prvClr, curClr)
                    o:SetColor(curClr)
                elseif b.name == "Rainbow" then
                    rbOn = not rbOn
                    if rbOn then
                        rbLp = run.Heartbeat:Connect(function()
                            o:SetColor(chr)
                            lbl.TextColor3 = chr
                        end)
                    else
                        rbLp:Disconnect()
                        o:SetColor(prvClr[#prvClr])
                        lbl.TextColor3 = TH.tx
                    end
                end
            elseif i.UserInputType == Enum.UserInputType.Touch and not rbOn then
                if b.name == "Reset" then
                    prvClr = {orgClr}
                    o:SetColor(orgClr)
                elseif b.name == "Undo" then
                    local n = #prvClr == 1 and 0 or 1
                    o:SetColor(prvClr[#prvClr - n])
                    if #prvClr ~= 1 then
                        table.remove(prvClr, #prvClr)
                    end
                elseif b.name == "Set" then
                    table.insert(prvClr, curClr)
                    o:SetColor(curClr)
                elseif b.name == "Rainbow" then
                    rbOn = not rbOn
                    if rbOn then
                        rbLp = run.Heartbeat:Connect(function()
                            o:SetColor(chr)
                            lbl.TextColor3 = chr
                        end)
                    else
                        rbLp:Disconnect()
                        o:SetColor(prvClr[#prvClr])
                        lbl.TextColor3 = TH.tx
                    end
                end
            end
            if i.UserInputType == Enum.UserInputType.MouseMovement and not drag then
                tw:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(30, 30, 35)}):Play()
            end
        end)

        btn.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement and not drag then
                tw:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.bgL}):Play()
            end
        end)
    end

    return o
end

local function crClr(o, par)
    o.main = lib:Create("TextLabel", {
        LayoutOrder = o.position,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        Text = " " .. o.text,
        TextSize = 15,
        Font = Enum.Font.Gotham,
        TextColor3 = TH.tx,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = par.content,
    })

    local out = lib:Create("ImageLabel", {
        Position = UDim2.new(1, -6, 0, 6),
        Size = UDim2.new(-1, 10, 1, -12),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = TH.txM,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = o.main,
    })
    crn(out, 4)

    o.visualize = lib:Create("ImageLabel", {
        Position = UDim2.new(0, 2, 0, 2),
        Size = UDim2.new(1, -4, 1, -4),
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = o.color,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(100, 100, 100, 100),
        SliceScale = 0.02,
        Parent = out,
    })
    crn(o.visualize, 3)

    local ic
    o.main.InputBegan:Connect(function(i)
        if i.UserInputType == m1 then
            if not o.mainHolder then crClrWind(o) end
            if lib.pop then lib.pop:Close() end
            local p = o.main.AbsolutePosition
            o.mainHolder.Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)
            o.open = true
            o.mainHolder.Visible = true
            lib.pop = o
            tw:Create(o.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, p.X - 5, 0, p.Y - 4)}):Play()
            tw:Create(o.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, p.X - 5, 0, p.Y + 1)}):Play()
            tw:Create(o.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
            for _, ob in next, o.mainHolder:GetDescendants() do
                if ob:IsA"TextLabel" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                elseif ob:IsA"ImageLabel" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                elseif ob:IsA"Frame" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end
            end
        elseif i.UserInputType == Enum.UserInputType.Touch then
            if not o.mainHolder then crClrWind(o) end
            if lib.pop then lib.pop:Close() end
            local p = o.main.AbsolutePosition
            o.mainHolder.Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)
            o.open = true
            o.mainHolder.Visible = true
            lib.pop = o
            tw:Create(o.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, p.X - 5, 0, p.Y - 4)}):Play()
            tw:Create(o.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, p.X - 5, 0, p.Y + 1)}):Play()
            tw:Create(o.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
            for _, ob in next, o.mainHolder:GetDescendants() do
                if ob:IsA"TextLabel" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                elseif ob:IsA"ImageLabel" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                elseif ob:IsA"Frame" then
                    tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end
            end
        end
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = true
            if not o.open then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 150)}):Play()
            end
        end
    end)

    o.main.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            ic = false
            if not o.open then
                tw:Create(out, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = TH.txM}):Play()
            end
        end
    end)

    function o:SetColor(c)
        if self.mainHolder then
            self:updateVisuals(c)
        end
        self.visualize.ImageColor3 = c
        lib.flags[self.flag] = c
        self.color = c
        self.callback(c)
    end

    function o:Close()
        lib.pop = nil
        self.open = false
        local p = self.main.AbsolutePosition
        tw:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, p.X - 5, 0, p.Y - 10)}):Play()
        tw:Create(self.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        for _, ob in next, self.mainHolder:GetDescendants() do
            if ob:IsA"TextLabel" then
                tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
            elseif ob:IsA"ImageLabel" then
                tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
            elseif ob:IsA"Frame" then
                tw:Create(ob, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            end
        end
        task.delay(0.3, function()
            if not self.open then
                self.mainHolder.Visible = false
            end
        end)
    end
end

local function ldOpt(o, hld)
    for _, nO in next, o.options do
        if nO.type == "label" then
            crLbl(nO, o)
        elseif nO.type == "toggle" then
            crTg(nO, o)
        elseif nO.type == "button" then
            crBt(nO, o)
        elseif nO.type == "list" then
            crLst(nO, o)
        elseif nO.type == "box" then
            crBox(nO, o)
        elseif nO.type == "bind" then
            crBnd(nO, o)
        elseif nO.type == "slider" then
            crSld(nO, o)
        elseif nO.type == "color" then
            crClr(nO, o, hld)
        elseif nO.type == "folder" then
            nO:init()
        end
    end
end

local function gFn(p)
    function p:AddLabel(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.type = "label"
        o.position = #self.options
        table.insert(self.options, o)
        return o
    end

    function p:AddToggle(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.state = typeof(o.state) == "boolean" and o.state or false
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.type = "toggle"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.state
        table.insert(self.options, o)
        return o
    end

    function p:AddButton(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.type = "button"
        o.position = #self.options
        o.flag = o.flag or o.text
        table.insert(self.options, o)
        return o
    end

    function p:AddBind(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.key = (o.key and o.key.Name) or o.key or "F"
        o.hold = typeof(o.hold) == "boolean" and o.hold or false
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.type = "bind"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.key
        table.insert(self.options, o)
        return o
    end

    function p:AddSlider(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.min = typeof(o.min) == "number" and o.min or 0
        o.max = typeof(o.max) == "number" and o.max or 0
        o.value = math.clamp(typeof(o.value) == "number" and o.value or o.min, o.min, o.max)
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.float = typeof(o.value) == "number" and o.float or 1
        o.type = "slider"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.value
        table.insert(self.options, o)
        return o
    end

    function p:AddList(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.values = typeof(o.values) == "table" and o.values or {}
        o.value = tostring(o.value or o.values[1] or "")
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.open = false
        o.type = "list"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.value
        table.insert(self.options, o)
        return o
    end

    function p:AddBox(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.value = tostring(o.value or "")
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.type = "box"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.value
        table.insert(self.options, o)
        return o
    end

    function p:AddColor(o)
        o = typeof(o) == "table" and o or {}
        o.text = tostring(o.text)
        o.color = typeof(o.color) == "table" and Color3.new(tonumber(o.color[1]), tonumber(o.color[2]), tonumber(o.color[3])) or o.color or Color3.new(1, 1, 1)
        o.callback = typeof(o.callback) == "function" and o.callback or function() end
        o.open = false
        o.type = "color"
        o.position = #self.options
        o.flag = o.flag or o.text
        lib.flags[o.flag] = o.color
        table.insert(self.options, o)
        return o
    end

    function p:AddFolder(t)
        local o = {}
        o.title = tostring(t)
        o.options = {}
        o.open = false
        o.type = "folder"
        o.position = #self.options
        table.insert(self.options, o)
        gFn(o)
        function o:init()
            hld(self.title, p.content, self, true)
            ldOpt(self, p)
        end
        return o
    end
end

function lib:CreateWindow(t)
    local w = {title = tostring(t), options = {}, open = true, canInit = true, init = false, position = #self.wins}
    gFn(w)
    table.insert(self.wins, w)
    return w
end

function lib:Init()
    self.base = self.base or self:Create("ScreenGui")
    if syn and syn.protect_gui then
        syn.protect_gui(self.base)
    elseif gethui then
        gethui(self.base)
    else
        plr.LocalPlayer:Kick("no gui protection")
        return
    end
    self.base.Parent = cg
    self.base.ResetOnSpawn = true
    self.base.Name = "suic1UI"

    for _, w in next, self.wins do
        if w.canInit and not w.init then
            w.init = true
            hld(w.title, self.base, w)
            ldOpt(w, self.base)
        end
    end
    return self.base
end

function lib:Close()
    if typeof(self.base) ~= "Instance" then end
    self.open = not self.open
    if self.activePopup then
        self.activePopup:Close()
    end
    for _, w in next, self.wins do
        if w.main then
            w.main.Visible = self.open
        end
    end
end

inp.InputBegan:Connect(function(i)
    if i.UserInputType == m1 or i.UserInputType == Enum.UserInputType.Touch then
        if lib.pop then
            local p = lib.pop.mainHolder
            if i.Position.X < p.AbsolutePosition.X or i.Position.Y < p.AbsolutePosition.Y or i.Position.X > p.AbsolutePosition.X + p.AbsoluteSize.X or i.Position.Y > p.AbsolutePosition.Y + p.AbsoluteSize.Y then
                lib.pop:Close()
            end
        end
    end
end)

inp.InputChanged:Connect(function(i)
    if i == dragIn and drag then
        upd(i)
    end
end)

task.wait(1)
local vU = game:GetService("VirtualUser")
plr.LocalPlayer.Idled:Connect(function()
    vU:CaptureController()
    vU:ClickButton2(Vector2.new())
end)

return lib
