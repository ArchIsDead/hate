local suic1de = {}

suic1de.Appearance = {
    Title = "suic1.de",
    Subtitle = "Enter your key",
    KeylessTitle = "suic1.de",
    KeylessSubtitle = "Access granted",
    Icon = "",
}

suic1de.Links = {
    GetKey = "",
    Discord = "",
}

suic1de.Storage = {
    FileName = "suic1de_key",
    Folder = "suic1de",
    Remember = true,
    AutoLoad = true,
}

suic1de.Options = {
    Keyless = "",
    KeylessUi = true,
    Draggable = true,
    Intro = true,
    IntroDuration = 0.7,
    ToastDuration = 3.2,
    Blur = true,
}

suic1de.Shop = {
    Enabled = false,
    Icon = "",
    Title = "Premium",
    Subtitle = "Get access",
    ButtonText = "Buy",
    Link = "",
}

suic1de.Callbacks = {
    OnVerify = "",
    OnSuccess = "",
    OnFail = "",
    OnReady = "",
}

local services = {}
services.Players = game:GetService("Players")
services.Tween = game:GetService("TweenService")
services.Input = game:GetService("UserInputService")
services.Gui = game:GetService("GuiService")
services.CoreGui = game:GetService("CoreGui")
services.Run = game:GetService("RunService")
services.TextService = game:GetService("TextService")
services.Lighting = game:GetService("Lighting")
services.Http = game:GetService("HttpService")

local state = {
    alive = false,
    verifying = false,
    closing = false,
    failures = 0,
    cooldown = 0,
    connections = {},
    objects = {},
    toasts = {},
    toastId = 0,
    activeTab = "main",
    compact = false,
}

local colors = {
    background = Color3.fromRGB(5, 6, 9),
    surface = Color3.fromRGB(12, 14, 19),
    surface2 = Color3.fromRGB(17, 20, 27),
    surface3 = Color3.fromRGB(22, 25, 33),
    border = Color3.fromRGB(55, 59, 70),
    borderSoft = Color3.fromRGB(39, 42, 51),
    text = Color3.fromRGB(244, 245, 248),
    subtext = Color3.fromRGB(148, 153, 165),
    faint = Color3.fromRGB(93, 98, 111),
    accent = Color3.fromRGB(137, 164, 255),
    accentDeep = Color3.fromRGB(87, 112, 201),
    success = Color3.fromRGB(91, 210, 145),
    danger = Color3.fromRGB(238, 91, 111),
    warning = Color3.fromRGB(239, 181, 87),
}

local fonts = {
    title = Enum.Font.GothamBold,
    body = Enum.Font.Gotham,
    medium = Enum.Font.GothamMedium,
    mono = Enum.Font.Code,
}

local function protect(callback, ...)
    if type(callback) ~= "function" then
        return false, nil
    end
    return pcall(callback, ...)
end

local function addConnection(connection)
    if connection then
        state.connections[#state.connections + 1] = connection
    end
    return connection
end

local function track(object)
    if object then
        state.objects[#state.objects + 1] = object
    end
    return object
end

local function disconnectAll()
    for i = #state.connections, 1, -1 do
        local connection = state.connections[i]
        if connection then
            pcall(function()
                connection:Disconnect()
            end)
        end
        state.connections[i] = nil
    end
end

local function destroyObjects()
    for i = #state.objects, 1, -1 do
        local object = state.objects[i]
        if object and object.Parent then
            pcall(function()
                object:Destroy()
            end)
        end
        state.objects[i] = nil
    end
end

local function new(className, properties, parent)
    local object = Instance.new(className)
    if properties then
        for property, value in pairs(properties) do
            pcall(function()
                object[property] = value
            end)
        end
    end
    object.Parent = parent
    return track(object)
end

local function corner(object, radius)
    return new("UICorner", {
        CornerRadius = UDim.new(0, radius),
    }, object)
end

local function outline(object, color, transparency, thickness)
    return new("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = thickness or 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, object)
end

local function gradient(object, first, second, rotation)
    return new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, first),
            ColorSequenceKeypoint.new(1, second),
        }),
        Rotation = rotation or 0,
    }, object)
end

local function tween(object, duration, properties, style, direction)
    if not object or not object.Parent then
        return nil
    end
    local info = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    local animation = services.Tween:Create(object, info, properties)
    animation:Play()
    return animation
end

local function isMobile()
    return services.Input.TouchEnabled and not services.Input.KeyboardEnabled
end

local function getGuiParent()
    local ok, result = pcall(function()
        return services.CoreGui
    end)
    if ok and result then
        return result
    end
    return services.Players.LocalPlayer:WaitForChild("PlayerGui")
end

local function clipboard(value)
    if type(setclipboard) ~= "function" then
        return false
    end
    local ok = pcall(setclipboard, tostring(value))
    return ok
end

local function folderPath()
    return tostring(suic1de.Storage.Folder or "suic1de")
end

local function filePath()
    return folderPath() .. "/" .. tostring(suic1de.Storage.FileName or "suic1de_key") .. ".txt"
end

local function filesystemReady()
    return type(isfile) == "function"
        and type(readfile) == "function"
        and type(writefile) == "function"
end

local function ensureFolder()
    if not filesystemReady() then
        return false
    end
    if type(isfolder) == "function" and type(makefolder) == "function" then
        local folder = folderPath()
        local exists = pcall(isfolder, folder)
        if not exists or not isfolder(folder) then
            pcall(makefolder, folder)
        end
    end
    return true
end

function suic1de:GetSavedKey()
    if not suic1de.Storage.Remember or not filesystemReady() then
        return nil
    end
    local path = filePath()
    local exists = pcall(isfile, path)
    if not exists or not isfile(path) then
        return nil
    end
    local ok, value = pcall(readfile, path)
    if not ok or type(value) ~= "string" or value == "" then
        return nil
    end
    return value
end

function suic1de:ClearSavedKey()
    if type(delfile) ~= "function" or not filesystemReady() then
        return false
    end
    local path = filePath()
    if isfile(path) then
        return pcall(delfile, path)
    end
    return true
end

local function saveKey(value)
    if not suic1de.Storage.Remember or not ensureFolder() then
        return
    end
    pcall(writefile, filePath(), tostring(value))
end

local function safeGetgenv()
    local ok, value = pcall(getgenv)
    if ok and type(value) == "table" then
        return value
    end
    return _G
end

local function getAccepted()
    local env = safeGetgenv()
    local value = env.SCRIPT_KEY
    return type(value) == "string" and value ~= ""
end

local function setAccepted(value)
    local env = safeGetgenv()
    env.SCRIPT_KEY = value
end

local function normalizeResult(value)
    if type(value) == "boolean" then
        return value, value and nil or "KEY_INVALID"
    end
    if type(value) ~= "table" then
        return false, "KEY_INVALID"
    end
    return value.valid == true, value.error or value.code or value.message
end

local errorText = {
    KEY_INVALID = "Invalid key",
    KEY_EXPIRED = "Key expired",
    KEY_INVALIDATED = "Key revoked",
    REVOKED = "Key revoked",
    HWID_MISMATCH = "HWID mismatch",
    ALREADY_USED = "Already used",
    SERVICE_NOT_FOUND = "Service missing",
    SERVICE_MISMATCH = "Wrong service",
    PREMIUM_REQUIRED = "Premium required",
    HWID_BANNED = "Access blocked",
    NETWORK = "Try again",
    ERROR = "Try again",
}

local ui = {
    root = nil,
    backdrop = nil,
    glow = nil,
    card = nil,
    header = nil,
    body = nil,
    title = nil,
    subtitle = nil,
    input = nil,
    verify = nil,
    status = nil,
    statusDot = nil,
    statusText = nil,
    getKey = nil,
    discord = nil,
    shop = nil,
    close = nil,
    intro = nil,
    introText = nil,
    divider = nil,
    keyless = nil,
    footer = nil,
    footerText = nil,
}

local function updateStatus(message, kind)
    if not ui.statusText or not ui.statusDot then
        return
    end

    local color = colors.subtext
    if kind == "success" then
        color = colors.success
    elseif kind == "error" then
        color = colors.danger
    elseif kind == "warning" then
        color = colors.warning
    elseif kind == "info" then
        color = colors.accent
    end

    ui.statusText.Text = tostring(message or "")
    ui.statusText.TextColor3 = color
    ui.statusDot.BackgroundColor3 = color

    tween(ui.statusDot, 0.18, {
        Size = UDim2.fromOffset(9, 9),
    })

    task.delay(0.18, function()
        if ui.statusDot and ui.statusDot.Parent then
            tween(ui.statusDot, 0.18, {
                Size = UDim2.fromOffset(7, 7),
            })
        end
    end)
end

local function buttonState(button, active)
    if not button then
        return
    end
    local target = active and colors.surface3 or colors.surface2
    tween(button, 0.16, {
        BackgroundColor3 = target,
    })
end

local function makeButton(parent, text, height)
    local button = new("TextButton", {
        AutoButtonColor = false,
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Font = fonts.medium,
        Text = text,
        TextColor3 = colors.text,
        TextSize = 12,
        Size = UDim2.new(1, 0, 0, height or 42),
    }, parent)

    corner(button, 11)
    outline(button, colors.border, 0.28, 1)

    addConnection(button.MouseEnter:Connect(function()
        buttonState(button, true)
    end))

    addConnection(button.MouseLeave:Connect(function()
        buttonState(button, false)
    end))

    addConnection(button.MouseButton1Down:Connect(function()
        tween(button, 0.08, {
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 2, button.Size.Y.Scale, button.Size.Y.Offset - 2),
        })
    end))

    addConnection(button.MouseButton1Up:Connect(function()
        tween(button, 0.12, {
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 2, button.Size.Y.Scale, button.Size.Y.Offset + 2),
        })
    end))

    return button
end

local function makeIconButton(parent, text, width)
    local button = makeButton(parent, text, 40)
    button.Size = UDim2.fromOffset(width or 110, 40)
    return button
end

local function makeToast(title, message, kind, duration)
    if not ui.root then
        return
    end

    state.toastId += 1
    local id = state.toastId

    local color = colors.accent
    if kind == "success" then
        color = colors.success
    elseif kind == "error" then
        color = colors.danger
    elseif kind == "warning" then
        color = colors.warning
    end

    local toast = new("Frame", {
        AnchorPoint = Vector2.new(1, 1),
        BackgroundColor3 = colors.surface,
        BackgroundTransparency = 0.03,
        BorderSizePixel = 0,
        Position = UDim2.new(1, 28, 1, -18),
        Size = UDim2.fromOffset(isMobile() and 250 or 310, 68),
        ZIndex = 100,
    }, ui.root)

    corner(toast, 13)
    outline(toast, colors.border, 0.12, 1)

    local bar = new("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 10),
        Size = UDim2.fromOffset(3, 48),
        ZIndex = 101,
    }, toast)

    corner(bar, 3)

    local titleLabel = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Position = UDim2.fromOffset(16, 10),
        Size = UDim2.new(1, -26, 0, 20),
        Text = tostring(title or ""),
        TextColor3 = colors.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
    }, toast)

    local messageLabel = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.body,
        Position = UDim2.fromOffset(16, 31),
        Size = UDim2.new(1, -26, 0, 25),
        Text = tostring(message or ""),
        TextColor3 = colors.subtext,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
    }, toast)

    state.toasts[id] = toast

    tween(toast, 0.35, {
        Position = UDim2.new(1, -18, 1, -18),
    }, Enum.EasingStyle.Quart)

    task.delay(duration or suic1de.Options.ToastDuration or 3.2, function()
        if state.toasts[id] ~= toast or not toast.Parent then
            return
        end
        state.toasts[id] = nil
        local leave = tween(toast, 0.25, {
            Position = UDim2.new(1, 28, 1, -18),
        })
        if leave then
            leave.Completed:Wait()
        end
        if toast.Parent then
            toast:Destroy()
        end
    end)
end

function suic1de:Notify(title, message, duration, kind)
    makeToast(title, message, kind or "info", duration)
end

local function buildBackground(parent)
    ui.backdrop = new("Frame", {
        BackgroundColor3 = colors.background,
        BackgroundTransparency = 0.04,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, parent)

    local shade = new("Frame", {
        BackgroundColor3 = colors.background,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, ui.backdrop)

    ui.glow = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = colors.accentDeep,
        BackgroundTransparency = 0.95,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.47),
        Size = UDim2.fromOffset(500, 500),
    }, ui.backdrop)

    corner(ui.glow, 250)

    local glow2 = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = colors.accent,
        BackgroundTransparency = 0.985,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.36, 0.68),
        Size = UDim2.fromOffset(300, 300),
    }, ui.backdrop)

    corner(glow2, 150)
end

local function buildHeader(parent)
    ui.header = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 60),
    }, parent)

    ui.title = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.title,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -42, 0, 30),
        Text = tostring(suic1de.Appearance.Title or "suic1.de"),
        TextColor3 = colors.text,
        TextSize = 21,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, ui.header)

    ui.subtitle = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.body,
        Position = UDim2.fromOffset(0, 31),
        Size = UDim2.new(1, -42, 0, 20),
        Text = tostring(suic1de.Appearance.Subtitle or "Enter your key"),
        TextColor3 = colors.subtext,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, ui.header)

    ui.close = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0),
        AutoButtonColor = false,
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Font = fonts.body,
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.fromOffset(30, 30),
        Text = "×",
        TextColor3 = colors.subtext,
        TextSize = 19,
    }, ui.header)

    corner(ui.close, 9)
    outline(ui.close, colors.border, 0.3, 1)

    addConnection(ui.close.MouseButton1Click:Connect(function()
        suic1de:Destroy()
    end))
end

local function buildField(parent)
    local field = new("Frame", {
        BackgroundColor3 = Color3.fromRGB(9, 11, 15),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50),
    }, parent)

    corner(field, 11)
    local fieldStroke = outline(field, colors.border, 0.2, 1)

    ui.input = new("TextBox", {
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Font = fonts.mono,
        PlaceholderColor3 = colors.faint,
        PlaceholderText = "",
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -28, 1, 0),
        Text = "",
        TextColor3 = colors.text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, field)

    addConnection(ui.input.Focused:Connect(function()
        tween(fieldStroke, 0.16, {
            Color = colors.accent,
            Transparency = 0,
        })
        tween(field, 0.16, {
            BackgroundColor3 = Color3.fromRGB(12, 15, 21),
        })
    end))

    addConnection(ui.input.FocusLost:Connect(function(enter)
        tween(fieldStroke, 0.16, {
            Color = colors.border,
            Transparency = 0.2,
        })
        tween(field, 0.16, {
            BackgroundColor3 = Color3.fromRGB(9, 11, 15),
        })
        if enter then
            local value = ui.input.Text
            task.spawn(function()
                local callback = suic1de._verify
                if callback then
                    callback(value)
                end
            end)
        end
    end))
end

local function buildStatus(parent)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
    }, parent)

    ui.statusDot = new("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = colors.subtext,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 1, 0.5, 0),
        Size = UDim2.fromOffset(7, 7),
    }, row)

    corner(ui.statusDot, 7)

    ui.statusText = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.body,
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -16, 1, 0),
        Text = "Ready",
        TextColor3 = colors.subtext,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
end

local function buildActions(parent)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
    }, parent)

    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, row)

    ui.getKey = makeIconButton(row, "Get Key", 112)
    ui.discord = makeIconButton(row, "Discord", 112)

    ui.getKey.MouseButton1Click:Connect(function()
        local link = tostring(suic1de.Links.GetKey or "")
        if link == "" then
            makeToast("Get Key", "Link not set", "warning")
            return
        end
        local opened = false
        local ok, web = pcall(function()
            return cloneref(game:GetService("WebViewService"))
        end)
        if ok and web then
            opened = pcall(function()
                web:OpenWindowV2(link)
            end)
        end
        if not opened and clipboard(link) then
            makeToast("Get Key", "Copied", "success")
        elseif not opened then
            makeToast("Get Key", "Unavailable", "error")
        end
    end)

    ui.discord.MouseButton1Click:Connect(function()
        local link = tostring(suic1de.Links.Discord or "")
        if link == "" then
            makeToast("Discord", "Link not set", "warning")
            return
        end
        if clipboard(link) then
            makeToast("Discord", "Copied", "success")
        else
            makeToast("Discord", "Unavailable", "error")
        end
    end)

    ui.getKey.Visible = tostring(suic1de.Links.GetKey or "") ~= ""
    ui.discord.Visible = tostring(suic1de.Links.Discord or "") ~= ""
end

local function buildShop(parent)
    if not suic1de.Shop.Enabled or tostring(suic1de.Shop.Link or "") == "" then
        return
    end

    local box = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 60),
    }, parent)

    corner(box, 11)
    outline(box, colors.borderSoft, 0.2, 1)

    local title = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Position = UDim2.fromOffset(13, 9),
        Size = UDim2.new(1, -102, 0, 19),
        Text = tostring(suic1de.Shop.Title or "Premium"),
        TextColor3 = colors.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, box)

    local subtitle = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.body,
        Position = UDim2.fromOffset(13, 30),
        Size = UDim2.new(1, -102, 0, 18),
        Text = tostring(suic1de.Shop.Subtitle or "Get access"),
        TextColor3 = colors.subtext,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, box)

    ui.shop = makeButton(box, tostring(suic1de.Shop.ButtonText or "Buy"), 36)
    ui.shop.AnchorPoint = Vector2.new(1, 0.5)
    ui.shop.Position = UDim2.new(1, -10, 0.5, 0)
    ui.shop.Size = UDim2.fromOffset(72, 36)

    addConnection(ui.shop.MouseButton1Click:Connect(function()
        local link = tostring(suic1de.Shop.Link or "")
        local opened = false
        local ok, web = pcall(function()
            return cloneref(game:GetService("WebViewService"))
        end)
        if ok and web then
            opened = pcall(function()
                web:OpenWindowV2(link)
            end)
        end
        if not opened and clipboard(link) then
            makeToast("Premium", "Copied", "success")
        end
    end))
end

local function buildFooter(parent)
    ui.footer = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
    }, parent)

    ui.footerText = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.mono,
        Size = UDim2.fromScale(1, 1),
        Text = "SECURE ACCESS",
        TextColor3 = colors.faint,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, ui.footer)
end

local function buildMain()
    local parent = getGuiParent()

    local existing = parent:FindFirstChild("suic1de")
    if existing then
        existing:Destroy()
    end

    ui.root = new("ScreenGui", {
        Name = "suic1de",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 999999,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, parent)

    buildBackground(ui.root)

    local width = isMobile() and 330 or 420

    ui.card = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = colors.surface,
        BackgroundTransparency = 0.025,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(width, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, ui.root)

    corner(ui.card, 17)
    outline(ui.card, colors.border, 0.12, 1)

    local topHighlight = new("Frame", {
        BackgroundColor3 = colors.accent,
        BackgroundTransparency = 0.86,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(18, 0),
        Size = UDim2.new(1, -36, 0, 1),
    }, ui.card)

    corner(topHighlight, 2)

    local content = new("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(20, 19),
        Size = UDim2.new(1, -40, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, ui.card)

    local list = new("UIListLayout", {
        Padding = UDim.new(0, 12),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, content)

    buildHeader(content)
    buildField(content)

    ui.verify = makeButton(content, "Verify", 44)
    ui.verify.BackgroundColor3 = colors.accentDeep
    outline(ui.verify, colors.accent, 0.58, 1)

    buildStatus(content)
    buildActions(content)
    buildShop(content)
    buildFooter(content)

    local bottom = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 19),
    }, content)

    local version = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.body,
        Size = UDim2.fromScale(1, 1),
        Text = "suic1.de",
        TextColor3 = colors.faint,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, bottom)

    local verify = function(value)
        value = tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if state.verifying then
            return
        end
        if os.clock() < state.cooldown then
            updateStatus("Wait a moment", "warning")
            return
        end
        if value == "" then
            updateStatus("Enter a key", "error")
            return
        end

        state.verifying = true
        ui.verify.Text = "Checking"
        updateStatus("Checking", "info")

        local callback = suic1de.Callbacks.OnVerify
        if type(callback) ~= "function" then
            state.verifying = false
            ui.verify.Text = "Verify"
            updateStatus("Verifier not set", "error")
            return
        end

        local ok, raw = pcall(callback, value)
        local valid, reason

        if ok then
            valid, reason = normalizeResult(raw)
        else
            valid, reason = false, "ERROR"
        end

        if valid then
            state.failures = 0
            updateStatus("Verified", "success")
            ui.verify.Text = "Verified"
            setAccepted(value)
            saveKey(value)

            local success = suic1de.Callbacks.OnSuccess
            if type(success) == "function" then
                task.spawn(function()
                    pcall(success, value)
                end)
            end

            makeToast("Access", "Verified", "success")
            task.delay(0.35, function()
                if state.alive then
                    suic1de:Destroy()
                end
            end)
            return
        end

        state.verifying = false
        ui.verify.Text = "Verify"

        if reason ~= "NETWORK" and reason ~= "ERROR" then
            state.failures += 1
            if state.failures >= 5 then
                state.cooldown = os.clock() + 15
            elseif state.failures >= 3 then
                state.cooldown = os.clock() + 5
            end
        end

        local message = errorText[reason] or "Invalid key"
        updateStatus(message, reason == "NETWORK" or reason == "ERROR" and "warning" or "error")
        makeToast("Access", message, "error")

        local fail = suic1de.Callbacks.OnFail
        if type(fail) == "function" then
            task.spawn(function()
                pcall(fail, reason, value)
            end)
        end

        if reason == "HWID_BANNED" then
            task.delay(2, function()
                local localPlayer = services.Players.LocalPlayer
                if localPlayer then
                    pcall(function()
                        localPlayer:Kick("Access blocked")
                    end)
                end
            end)
        end
    end

    suic1de._verify = verify

    addConnection(ui.verify.MouseButton1Click:Connect(function()
        verify(ui.input.Text)
    end))

    addConnection(services.Input.InputBegan:Connect(function(inputObject, processed)
        if processed or not state.alive then
            return
        end
        if inputObject.KeyCode == Enum.KeyCode.Return and ui.input and ui.input:IsFocused() then
            verify(ui.input.Text)
        end
    end))

    if suic1de.Options.Draggable then
        local dragging = false
        local startPosition
        local startInput
        local startCard

        addConnection(ui.card.InputBegan:Connect(function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1
                or inputObject.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                startInput = inputObject.Position
                startCard = ui.card.Position
            end
        end))

        addConnection(ui.card.InputEnded:Connect(function(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseButton1
                or inputObject.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end))

        addConnection(services.Input.InputChanged:Connect(function(inputObject)
            if not dragging then
                return
            end
            if inputObject.UserInputType ~= Enum.UserInputType.MouseMovement
                and inputObject.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            local delta = inputObject.Position - startInput
            ui.card.Position = UDim2.new(
                startCard.X.Scale,
                startCard.X.Offset + delta.X,
                startCard.Y.Scale,
                startCard.Y.Offset + delta.Y
            )
        end))
    end

    ui.card.Position = UDim2.new(0.5, 0, 0.5, 18)
    ui.card.BackgroundTransparency = 1

    tween(ui.card, 0.48, {
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundTransparency = 0.025,
    }, Enum.EasingStyle.Quart)

    if ui.glow then
        ui.glow.Size = UDim2.fromOffset(440, 440)
        tween(ui.glow, 1.1, {
            Size = UDim2.fromOffset(520, 520),
            BackgroundTransparency = 0.965,
        }, Enum.EasingStyle.Sine)
    end

    if suic1de.Options.Intro then
        local intro = new("Frame", {
            BackgroundColor3 = colors.background,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 200,
        }, ui.root)

        ui.intro = intro

        local mark = new("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Font = fonts.title,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(300, 55),
            Text = tostring(suic1de.Appearance.Title or "suic1.de"),
            TextColor3 = colors.text,
            TextSize = 28,
            TextTransparency = 1,
            ZIndex = 201,
        }, intro)

        ui.introText = mark

        tween(mark, 0.28, {
            TextTransparency = 0,
        }, Enum.EasingStyle.Quart)

        task.delay(math.max(0.1, suic1de.Options.IntroDuration or 0.7), function()
            if not intro.Parent then
                return
            end
            local out = tween(mark, 0.2, {
                TextTransparency = 1,
            })
            if out then
                out.Completed:Wait()
            end
            tween(intro, 0.28, {
                BackgroundTransparency = 1,
            })
            task.delay(0.3, function()
                if intro.Parent then
                    intro:Destroy()
                end
            end)
        end)
    end

    state.alive = true
end

local function keylessScreen()
    buildMain()

    if ui.input then
        ui.input.Visible = false
    end
    if ui.verify then
        ui.verify.Visible = false
    end

    if ui.getKey then
        ui.getKey.Visible = tostring(suic1de.Links.GetKey or "") ~= ""
    end

    updateStatus(tostring(suic1de.Appearance.KeylessSubtitle or "Access granted"), "success")

    local label = ui.subtitle
    if label then
        label.Text = tostring(suic1de.Appearance.KeylessSubtitle or "Access granted")
    end

    makeToast("Access", "Verified", "success")

    task.delay(0.4, function()
        if not state.alive then
            return
        end
        setAccepted("KEYLESS")
        local callback = suic1de.Callbacks.OnSuccess
        if type(callback) == "function" then
            task.spawn(function()
                pcall(callback, "KEYLESS")
            end)
        end
        if not suic1de.Options.KeylessUi then
            suic1de:Destroy()
        end
    end)
end

local function validateSaved()
    if not suic1de.Storage.AutoLoad then
        return false
    end

    local saved = suic1de:GetSavedKey()
    if not saved then
        return false
    end

    local callback = suic1de.Callbacks.OnVerify
    if type(callback) ~= "function" then
        return false
    end

    local ok, raw = pcall(callback, saved)
    if not ok then
        return false
    end

    local valid = normalizeResult(raw)
    if valid then
        setAccepted(saved)
        task.spawn(function()
            local success = suic1de.Callbacks.OnSuccess
            if type(success) == "function" then
                pcall(success, saved)
            end
        end)
        return true
    end

    return false
end

function suic1de:Destroy()
    if state.closing then
        return
    end
    state.closing = true
    state.alive = false

    for _, toast in pairs(state.toasts) do
        if toast and toast.Parent then
            pcall(function()
                toast:Destroy()
            end)
        end
    end
    state.toasts = {}

    disconnectAll()
    destroyObjects()

    ui = {
        root = nil,
        backdrop = nil,
        glow = nil,
        card = nil,
        header = nil,
        body = nil,
        title = nil,
        subtitle = nil,
        input = nil,
        verify = nil,
        status = nil,
        statusDot = nil,
        statusText = nil,
        getKey = nil,
        discord = nil,
        shop = nil,
        close = nil,
        intro = nil,
        introText = nil,
        divider = nil,
        keyless = nil,
        footer = nil,
        footerText = nil,
    }

    state.closing = false
end

function suic1de:Launch()
    if state.alive then
        self:Destroy()
    end

    local env = safeGetgenv()
    if type(env.SCRIPT_KEY) == "string" and env.SCRIPT_KEY ~= "" then
        local callback = self.Callbacks.OnSuccess
        if type(callback) == "function" then
            task.spawn(function()
                pcall(callback, env.SCRIPT_KEY)
            end)
        end
        return
    end

    if self.Options.Keyless == true then
        if self.Options.KeylessUi then
            keylessScreen()
        else
            setAccepted("KEYLESS")
            local callback = self.Callbacks.OnSuccess
            if type(callback) == "function" then
                task.spawn(function()
                    pcall(callback, "KEYLESS")
                end)
            end
        end
        return
    end

    if validateSaved() then
        return
    end

    buildMain()

    local ready = self.Callbacks.OnReady
    if type(ready) == "function" then
        task.spawn(function()
            pcall(ready)
        end)
    end
end

function suic1de:LaunchJunkie(config)
    config = type(config) == "table" and config or {}

    local serviceName = tostring(config.Service or "")
    local identifier = tostring(config.Identifier or "")
    local provider = tostring(config.Provider or "")
    local sdkUrl = tostring(config.Url or "")

    if serviceName == "" or identifier == "" then
        self:Launch()
        return
    end

    if sdkUrl == "" then
        sdkUrl = "https://jnkie.com/sdk.lua"
    end

    local requestOk, source = pcall(function()
        return game:HttpGet(sdkUrl)
    end)

    if not requestOk or type(source) ~= "string" or source == "" then
        self:Launch()
        return
    end

    local loadOk, sdk = pcall(function()
        return loadstring(source)()
    end)

    if not loadOk or type(sdk) ~= "table" then
        self:Launch()
        return
    end

    local function checkKey(value)
        if type(sdk.check_key) ~= "function" then
            return false
        end
        local ok, result = pcall(function()
            return sdk.check_key(value, serviceName, identifier, provider)
        end)
        if not ok then
            return {
                valid = false,
                error = "NETWORK",
            }
        end
        return result
    end

    self.Callbacks.OnVerify = checkKey

    if self.Links.GetKey == "" and type(sdk.get_key_link) == "function" then
        local ok, link = pcall(function()
            return sdk.get_key_link(serviceName, identifier)
        end)
        if ok and type(link) == "string" then
            self.Links.GetKey = link
        end
    end

    if self.Options.Keyless == nil then
        local ok, result = pcall(checkKey, "KEYLESS")
        if ok then
            local valid = normalizeResult(result)
            self.Options.Keyless = valid == true
        else
            self.Options.Keyless = false
        end
    end

    self:Launch()
end



suic1de.Theme = colors

function suic1de:SetTheme(values)
    if type(values) ~= "table" then
        return false
    end
    for key, value in pairs(values) do
        if colors[key] ~= nil and typeof(value) == "Color3" then
            colors[key] = value
        end
    end
    return true
end

function suic1de:SetLinks(values)
    if type(values) ~= "table" then
        return false
    end
    if values.GetKey ~= nil then
        self.Links.GetKey = tostring(values.GetKey)
    end
    if values.Discord ~= nil then
        self.Links.Discord = tostring(values.Discord)
    end
    return true
end

function suic1de:SetAppearance(values)
    if type(values) ~= "table" then
        return false
    end
    for key, value in pairs(values) do
        if self.Appearance[key] ~= nil then
            self.Appearance[key] = tostring(value)
        end
    end
    return true
end

function suic1de:SetStorage(values)
    if type(values) ~= "table" then
        return false
    end
    if values.FileName ~= nil then
        self.Storage.FileName = tostring(values.FileName)
    end
    if values.Folder ~= nil then
        self.Storage.Folder = tostring(values.Folder)
    end
    if values.Remember ~= nil then
        self.Storage.Remember = values.Remember == true
    end
    if values.AutoLoad ~= nil then
        self.Storage.AutoLoad = values.AutoLoad == true
    end
    return true
end

function suic1de:SetOptions(values)
    if type(values) ~= "table" then
        return false
    end
    for key, value in pairs(values) do
        if self.Options[key] ~= nil then
            self.Options[key] = value
        end
    end
    return true
end

function suic1de:SetShop(values)
    if type(values) ~= "table" then
        return false
    end
    for key, value in pairs(values) do
        if self.Shop[key] ~= nil then
            self.Shop[key] = value
        end
    end
    return true
end

function suic1de:IsAlive()
    return state.alive == true
end

function suic1de:IsVerifying()
    return state.verifying == true
end

function suic1de:GetCooldown()
    local remaining = state.cooldown - os.clock()
    return remaining > 0 and remaining or 0
end

function suic1de:GetFailures()
    return state.failures
end

function suic1de:ResetFailures()
    state.failures = 0
    state.cooldown = 0
end

function suic1de:Copy(value)
    return clipboard(value)
end

function suic1de:OpenLink(value)
    local link = tostring(value or "")
    if link == "" then
        return false
    end

    local opened = false
    local ok, web = pcall(function()
        return cloneref(game:GetService("WebViewService"))
    end)

    if ok and web then
        opened = pcall(function()
            web:OpenWindowV2(link)
        end)
    end

    if not opened then
        opened = clipboard(link)
    end

    return opened
end

function suic1de:GetEnvironment()
    return {
        Clipboard = type(setclipboard) == "function",
        Filesystem = filesystemReady(),
        Folder = type(isfolder) == "function",
        WebView = pcall(function()
            return game:GetService("WebViewService")
        end),
        Touch = services.Input.TouchEnabled == true,
        Keyboard = services.Input.KeyboardEnabled == true,
    }
end

function suic1de:Validate()
    local problems = {}

    if type(self.Appearance) ~= "table" then
        problems[#problems + 1] = "Appearance"
    end

    if type(self.Links) ~= "table" then
        problems[#problems + 1] = "Links"
    end

    if type(self.Storage) ~= "table" then
        problems[#problems + 1] = "Storage"
    end

    if type(self.Options) ~= "table" then
        problems[#problems + 1] = "Options"
    end

    if type(self.Callbacks) ~= "table" then
        problems[#problems + 1] = "Callbacks"
    end

    return #problems == 0, problems
end

function suic1de:Configure(values)
    if type(values) ~= "table" then
        return false
    end

    if values.Appearance then
        self:SetAppearance(values.Appearance)
    end

    if values.Links then
        self:SetLinks(values.Links)
    end

    if values.Storage then
        self:SetStorage(values.Storage)
    end

    if values.Options then
        self:SetOptions(values.Options)
    end

    if values.Shop then
        self:SetShop(values.Shop)
    end

    if values.Callbacks and type(values.Callbacks) == "table" then
        for key, value in pairs(values.Callbacks) do
            if self.Callbacks[key] ~= nil then
                self.Callbacks[key] = value
            end
        end
    end

    return true
end

function suic1de:Reset()
    self:Destroy()
    state.failures = 0
    state.cooldown = 0
    state.verifying = false
    state.closing = false
    self._verify = nil
end

local function sanitizeString(value, fallback)
    if type(value) ~= "string" then
        return fallback
    end
    value = value:gsub("[%c]", "")
    if #value > 512 then
        value = value:sub(1, 512)
    end
    return value
end

local function sanitizeConfig()
    suic1de.Appearance.Title = sanitizeString(suic1de.Appearance.Title, "suic1.de")
    suic1de.Appearance.Subtitle = sanitizeString(suic1de.Appearance.Subtitle, "Enter your key")
    suic1de.Appearance.KeylessTitle = sanitizeString(suic1de.Appearance.KeylessTitle, "suic1.de")
    suic1de.Appearance.KeylessSubtitle = sanitizeString(suic1de.Appearance.KeylessSubtitle, "Access granted")
    suic1de.Links.GetKey = sanitizeString(suic1de.Links.GetKey, "")
    suic1de.Links.Discord = sanitizeString(suic1de.Links.Discord, "")
    suic1de.Storage.FileName = sanitizeString(suic1de.Storage.FileName, "suic1de_key")
    suic1de.Storage.Folder = sanitizeString(suic1de.Storage.Folder, "suic1de")
    suic1de.Shop.Title = sanitizeString(suic1de.Shop.Title, "Premium")
    suic1de.Shop.Subtitle = sanitizeString(suic1de.Shop.Subtitle, "Get access")
    suic1de.Shop.ButtonText = sanitizeString(suic1de.Shop.ButtonText, "Buy")
    suic1de.Shop.Link = sanitizeString(suic1de.Shop.Link, "")
end

sanitizeConfig()


local animationPresets = {
    ["quick"] = { Duration = 0.12, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["fast"] = { Duration = 0.18, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["normal"] = { Duration = 0.28, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["smooth"] = { Duration = 0.42, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["soft"] = { Duration = 0.55, Style = Enum.EasingStyle.Sine, Direction = Enum.EasingDirection.Out },
    ["intro"] = { Duration = 0.7, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["toastIn"] = { Duration = 0.35, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["toastOut"] = { Duration = 0.25, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["focus"] = { Duration = 0.16, Style = Enum.EasingStyle.Quart, Direction = Enum.EasingDirection.Out },
    ["press"] = { Duration = 0.08, Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.Out },
    ["release"] = { Duration = 0.12, Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.Out },
    ["glow"] = { Duration = 1.1, Style = Enum.EasingStyle.Sine, Direction = Enum.EasingDirection.Out },
}

suic1de.Animation = animationPresets


local components = {}

function components.createDivider(parent, transparency)
    local line = new("Frame", {
        BackgroundColor3 = colors.borderSoft,
        BackgroundTransparency = transparency or 0.25,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
    }, parent)
    return line
end

function components.createLabel(parent, text, size, color, font)
    return new("TextLabel", {
        BackgroundTransparency = 1,
        Font = font or fonts.body,
        Size = size or UDim2.new(1, 0, 0, 20),
        Text = tostring(text or ""),
        TextColor3 = color or colors.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, parent)
end

function components.createBadge(parent, text, color)
    local badge = new("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = color or colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(0, 25),
    }, parent)
    corner(badge, 8)
    outline(badge, color or colors.border, 0.25, 1)

    local label = components.createLabel(
        badge,
        text,
        UDim2.fromOffset(0, 25),
        colors.text,
        fonts.medium
    )
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.fromOffset(0, 25)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Center

    local pad = new("UIPadding", {
        PaddingLeft = UDim.new(0, 9),
        PaddingRight = UDim.new(0, 9),
    }, badge)

    return badge
end

function components.createProgress(parent, value, height)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 5),
    }, parent)
    corner(holder, 6)

    local fill = new("Frame", {
        BackgroundColor3 = colors.accent,
        BorderSizePixel = 0,
        Size = UDim2.new(math.clamp(tonumber(value) or 0, 0, 1), 0, 1, 0),
    }, holder)
    corner(fill, 6)

    return holder, fill
end

function components.setProgress(fill, value, duration)
    if not fill then
        return
    end
    local amount = math.clamp(tonumber(value) or 0, 0, 1)
    tween(fill, duration or 0.25, {
        Size = UDim2.new(amount, 0, 1, 0),
    })
end

function components.createSpinner(parent, size)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(size or 18, size or 18),
    }, parent)

    local ring = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, holder)

    corner(ring, 100)

    local inner = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = colors.surface,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.62, 0.62),
    }, ring)
    corner(inner, 100)

    local accent = new("Frame", {
        BackgroundColor3 = colors.accent,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromOffset(3, size or 18),
    }, ring)
    corner(accent, 2)

    local running = true
    task.spawn(function()
        while running and holder.Parent do
            tween(ring, 0.8, {
                Rotation = ring.Rotation + 360,
            }, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            task.wait(0.8)
        end
    end)

    holder.AncestryChanged:Connect(function(_, parent)
        if not parent then
            running = false
        end
    end)

    return holder
end

function components.createPulse(parent, size, color)
    local pulse = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = color or colors.accent,
        BackgroundTransparency = 0.72,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(size or 8, size or 8),
    }, parent)
    corner(pulse, size or 8)

    task.spawn(function()
        while pulse.Parent do
            tween(pulse, 0.75, {
                Size = UDim2.fromOffset((size or 8) + 10, (size or 8) + 10),
                BackgroundTransparency = 0.96,
            }, Enum.EasingStyle.Sine)
            task.wait(0.75)
            if not pulse.Parent then
                break
            end
            tween(pulse, 0.75, {
                Size = UDim2.fromOffset(size or 8, size or 8),
                BackgroundTransparency = 0.72,
            }, Enum.EasingStyle.Sine)
            task.wait(0.75)
        end
    end)

    return pulse
end

function components.createTooltip(parent, text)
    local tooltip = new("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = colors.surface,
        BorderSizePixel = 0,
        Font = fonts.body,
        Text = tostring(text or ""),
        TextColor3 = colors.text,
        TextSize = 10,
        Visible = false,
        ZIndex = 300,
    }, parent)
    corner(tooltip, 7)
    outline(tooltip, colors.border, 0.1, 1)
    new("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5),
    }, tooltip)
    return tooltip
end

function components.bindTooltip(target, tooltip)
    if not target or not tooltip then
        return
    end

    addConnection(target.MouseEnter:Connect(function()
        tooltip.Visible = true
        tooltip.BackgroundTransparency = 1
        tween(tooltip, 0.15, {
            BackgroundTransparency = 0.03,
        })
    end))

    addConnection(target.MouseLeave:Connect(function()
        tooltip.Visible = false
    end))
end

function components.createNotice(parent, title, message, kind)
    local color = colors.accent
    if kind == "success" then
        color = colors.success
    elseif kind == "error" then
        color = colors.danger
    elseif kind == "warning" then
        color = colors.warning
    end

    local frame = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 66),
    }, parent)
    corner(frame, 11)
    outline(frame, color, 0.5, 1)

    local accent = new("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, -20),
        Position = UDim2.fromOffset(0, 10),
    }, frame)
    corner(accent, 2)

    components.createLabel(
        frame,
        title,
        UDim2.new(1, -30, 0, 19),
        colors.text,
        fonts.medium
    ).Position = UDim2.fromOffset(14, 9)

    components.createLabel(
        frame,
        message,
        UDim2.new(1, -30, 0, 30),
        colors.subtext,
        fonts.body
    ).Position = UDim2.fromOffset(14, 29)

    return frame
end

function components.createCodeField(parent, value)
    local frame = new("Frame", {
        BackgroundColor3 = Color3.fromRGB(8, 10, 14),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 82),
    }, parent)
    corner(frame, 10)
    outline(frame, colors.borderSoft, 0.15, 1)

    local text = new("TextBox", {
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Font = fonts.mono,
        MultiLine = true,
        Position = UDim2.fromOffset(12, 10),
        Size = UDim2.new(1, -24, 1, -20),
        Text = tostring(value or ""),
        TextColor3 = colors.subtext,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    }, frame)

    return frame, text
end

function components.createSwitch(parent, text, value, callback)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 38),
    }, parent)

    components.createLabel(
        row,
        text,
        UDim2.new(1, -62, 1, 0),
        colors.text,
        fonts.medium
    )

    local toggle = new("TextButton", {
        AutoButtonColor = false,
        BackgroundColor3 = value and colors.accentDeep or colors.surface3,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -48, 0.5, -11),
        Size = UDim2.fromOffset(48, 22),
        Text = "",
    }, row)
    corner(toggle, 11)
    outline(toggle, colors.border, 0.2, 1)

    local knob = new("Frame", {
        BackgroundColor3 = colors.text,
        BorderSizePixel = 0,
        Position = value and UDim2.new(1, -21, 0.5, -8) or UDim2.fromOffset(5, 3),
        Size = UDim2.fromOffset(16, 16),
    }, toggle)
    corner(knob, 8)

    local current = value == true
    addConnection(toggle.MouseButton1Click:Connect(function()
        current = not current
        tween(toggle, 0.16, {
            BackgroundColor3 = current and colors.accentDeep or colors.surface3,
        })
        tween(knob, 0.18, {
            Position = current and UDim2.new(1, -21, 0.5, -8) or UDim2.fromOffset(5, 3),
        })
        if type(callback) == "function" then
            task.spawn(function()
                pcall(callback, current)
            end)
        end
    end))

    return row, toggle
end

function components.createSegment(parent, options, selected, callback)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
    }, parent)
    corner(holder, 10)
    outline(holder, colors.borderSoft, 0.2, 1)

    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, holder)

    local buttons = {}
    local active = tostring(selected or options[1] or "")

    for _, option in ipairs(options or {}) do
        local button = new("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = tostring(option) == active and colors.surface3 or colors.surface2,
            BorderSizePixel = 0,
            Font = fonts.medium,
            Text = tostring(option),
            TextColor3 = tostring(option) == active and colors.text or colors.subtext,
            TextSize = 10,
            Size = UDim2.new(1 / math.max(#options, 1), -3, 1, -6),
        }, holder)
        corner(button, 8)
        buttons[#buttons + 1] = button

        addConnection(button.MouseButton1Click:Connect(function()
            active = tostring(option)
            for _, other in ipairs(buttons) do
                local selectedNow = other == button
                tween(other, 0.12, {
                    BackgroundColor3 = selectedNow and colors.surface3 or colors.surface2,
                })
                other.TextColor3 = selectedNow and colors.text or colors.subtext
            end
            if type(callback) == "function" then
                task.spawn(function()
                    pcall(callback, active)
                end)
            end
        end))
    end

    return holder
end

function components.createSpinnerButton(parent, text)
    local button = makeButton(parent, text, 42)
    local spinner
    local original = text

    local function start()
        if spinner then
            return
        end
        button.Text = ""
        spinner = components.createSpinner(button, 16)
        spinner.AnchorPoint = Vector2.new(0.5, 0.5)
        spinner.Position = UDim2.fromScale(0.5, 0.5)
    end

    local function stop()
        if spinner then
            spinner:Destroy()
            spinner = nil
        end
        button.Text = original
    end

    return button, start, stop
end

function components.createModal(parent, title, message)
    local shade = new("Frame", {
        BackgroundColor3 = colors.background,
        BackgroundTransparency = 0.35,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 500,
    }, parent)

    local modal = new("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = colors.surface,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(isMobile() and 300 or 360, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 501,
    }, shade)
    corner(modal, 15)
    outline(modal, colors.border, 0.1, 1)

    local content = new("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(20, 18),
        Size = UDim2.new(1, -40, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, modal)

    local list = new("UIListLayout", {
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, content)

    components.createLabel(
        content,
        title,
        UDim2.new(1, 0, 0, 25),
        colors.text,
        fonts.title
    )

    local body = components.createLabel(
        content,
        message,
        UDim2.new(1, 0, 0, 42),
        colors.subtext,
        fonts.body
    )
    body.TextWrapped = true

    local closeButton = makeButton(content, "Close", 40)
    closeButton.MouseButton1Click:Connect(function()
        shade:Destroy()
    end)

    return shade, modal
end

function components.createSkeleton(parent, height)
    local skeleton = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 42),
        ClipsDescendants = true,
    }, parent)
    corner(skeleton, 9)

    local shine = new("Frame", {
        BackgroundColor3 = colors.text,
        BackgroundTransparency = 0.95,
        BorderSizePixel = 0,
        Position = UDim2.new(-1, 0, 0, 0),
        Size = UDim2.new(0.45, 0, 1, 0),
    }, skeleton)

    task.spawn(function()
        while skeleton.Parent do
            shine.Position = UDim2.new(-0.45, 0, 0, 0)
            tween(shine, 0.9, {
                Position = UDim2.new(1, 0, 0, 0),
            }, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            task.wait(1.1)
        end
    end)

    return skeleton
end

function components.createStepper(parent, steps, current)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 32),
    }, parent)

    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 5),
    }, holder)

    local nodes = {}

    for index, step in ipairs(steps or {}) do
        local node = new("Frame", {
            BackgroundColor3 = index <= (current or 1) and colors.accent or colors.surface3,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(8, 8),
        }, holder)
        corner(node, 8)
        nodes[index] = node

        if index < #steps then
            local connector = new("Frame", {
                BackgroundColor3 = index < (current or 1) and colors.accent or colors.borderSoft,
                BorderSizePixel = 0,
                Size = UDim2.fromOffset(30, 2),
            }, holder)
            connector.LayoutOrder = index
        end
    end

    return holder, nodes
end

function components.createKeyStrength(parent)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 25),
    }, parent)

    local label = components.createLabel(
        holder,
        "Key",
        UDim2.fromOffset(70, 20),
        colors.faint,
        fonts.body
    )
    label.TextSize = 9

    local track = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(70, 8),
        Size = UDim2.new(1, -70, 0, 5),
    }, holder)
    corner(track, 5)

    local fill = new("Frame", {
        BackgroundColor3 = colors.accent,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
    }, track)
    corner(fill, 5)

    return holder, function(value)
        components.setProgress(fill, value, 0.2)
    end
end

function components.createActionRow(parent)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 42),
    }, parent)
    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 8),
    }, row)
    return row, layout
end

function components.createCard(parent, height)
    local frame = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 80),
    }, parent)
    corner(frame, 12)
    outline(frame, colors.borderSoft, 0.18, 1)
    return frame
end

function components.createSoftButton(parent, text)
    local button = makeButton(parent, text, 38)
    button.BackgroundColor3 = colors.surface3
    return button
end

function components.createAccentButton(parent, text)
    local button = makeButton(parent, text, 42)
    button.BackgroundColor3 = colors.accentDeep
    outline(button, colors.accent, 0.58, 1)
    return button
end

function components.createDangerButton(parent, text)
    local button = makeButton(parent, text, 42)
    button.BackgroundColor3 = Color3.fromRGB(92, 32, 43)
    outline(button, colors.danger, 0.6, 1)
    return button
end

function components.createInput(parent, placeholder, mono)
    local frame = new("Frame", {
        BackgroundColor3 = Color3.fromRGB(9, 11, 15),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 44),
    }, parent)
    corner(frame, 10)
    local line = outline(frame, colors.borderSoft, 0.15, 1)

    local box = new("TextBox", {
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Font = mono and fonts.mono or fonts.body,
        PlaceholderColor3 = colors.faint,
        PlaceholderText = tostring(placeholder or ""),
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.new(1, -24, 1, 0),
        Text = "",
        TextColor3 = colors.text,
        TextSize = 12,
    }, frame)

    addConnection(box.Focused:Connect(function()
        tween(line, 0.15, {
            Color = colors.accent,
            Transparency = 0,
        })
    end))

    addConnection(box.FocusLost:Connect(function()
        tween(line, 0.15, {
            Color = colors.borderSoft,
            Transparency = 0.15,
        })
    end))

    return frame, box
end

function components.createTextArea(parent, placeholder)
    local frame = new("Frame", {
        BackgroundColor3 = Color3.fromRGB(9, 11, 15),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 92),
    }, parent)
    corner(frame, 10)
    outline(frame, colors.borderSoft, 0.15, 1)

    local box = new("TextBox", {
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Font = fonts.body,
        MultiLine = true,
        PlaceholderColor3 = colors.faint,
        PlaceholderText = tostring(placeholder or ""),
        Position = UDim2.fromOffset(12, 10),
        Size = UDim2.new(1, -24, 1, -20),
        Text = "",
        TextColor3 = colors.text,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    }, frame)

    return frame, box
end

function components.createCounter(parent, value)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(90, 34),
    }, parent)
    corner(holder, 9)

    local minus = new("TextButton", {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Size = UDim2.fromOffset(28, 34),
        Text = "−",
        TextColor3 = colors.subtext,
        TextSize = 15,
    }, holder)

    local label = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.mono,
        Position = UDim2.fromOffset(28, 0),
        Size = UDim2.fromOffset(34, 34),
        Text = tostring(value or 0),
        TextColor3 = colors.text,
        TextSize = 11,
    }, holder)

    local plus = new("TextButton", {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Position = UDim2.fromOffset(62, 0),
        Size = UDim2.fromOffset(28, 34),
        Text = "+",
        TextColor3 = colors.subtext,
        TextSize = 15,
    }, holder)

    local current = tonumber(value) or 0
    local changed = function()
        label.Text = tostring(current)
    end

    addConnection(minus.MouseButton1Click:Connect(function()
        current -= 1
        changed()
    end))

    addConnection(plus.MouseButton1Click:Connect(function()
        current += 1
        changed()
    end))

    return holder, function()
        return current
    end
end

function components.createList(parent)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, parent)
    new("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, holder)
    return holder
end

function components.addListItem(parent, title, description)
    local item = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50),
    }, parent)
    corner(item, 9)

    components.createLabel(
        item,
        title,
        UDim2.new(1, -24, 0, 18),
        colors.text,
        fonts.medium
    ).Position = UDim2.fromOffset(12, 6)

    components.createLabel(
        item,
        description,
        UDim2.new(1, -24, 0, 17),
        colors.subtext,
        fonts.body
    ).Position = UDim2.fromOffset(12, 26)

    return item
end

function components.createEmpty(parent, title, description)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 100),
    }, parent)

    local titleLabel = components.createLabel(
        holder,
        title,
        UDim2.new(1, 0, 0, 22),
        colors.text,
        fonts.medium
    )
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Position = UDim2.fromOffset(0, 17)

    local descriptionLabel = components.createLabel(
        holder,
        description,
        UDim2.new(1, 0, 0, 35),
        colors.subtext,
        fonts.body
    )
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Center
    descriptionLabel.TextWrapped = true
    descriptionLabel.Position = UDim2.fromOffset(0, 42)

    return holder
end

function components.createHeader(parent, title, description)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 54),
    }, parent)

    components.createLabel(
        holder,
        title,
        UDim2.new(1, 0, 0, 27),
        colors.text,
        fonts.title
    ).TextSize = 17

    local sub = components.createLabel(
        holder,
        description,
        UDim2.new(1, 0, 0, 20),
        colors.subtext,
        fonts.body
    )
    sub.Position = UDim2.fromOffset(0, 29)
    sub.TextSize = 10

    return holder
end

function components.createCloseButton(parent, callback)
    local button = new("TextButton", {
        AutoButtonColor = false,
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Font = fonts.body,
        Size = UDim2.fromOffset(30, 30),
        Text = "×",
        TextColor3 = colors.subtext,
        TextSize = 18,
    }, parent)
    corner(button, 9)
    outline(button, colors.border, 0.25, 1)
    addConnection(button.MouseButton1Click:Connect(function()
        if type(callback) == "function" then
            callback()
        end
    end))
    return button
end

function components.createLinkButton(parent, text, link, fallback)
    local button = makeButton(parent, text, 40)
    addConnection(button.MouseButton1Click:Connect(function()
        local target = tostring(link or "")
        if target == "" then
            if type(fallback) == "function" then
                fallback()
            end
            return
        end

        local opened = false
        local ok, web = pcall(function()
            return cloneref(game:GetService("WebViewService"))
        end)

        if ok and web then
            opened = pcall(function()
                web:OpenWindowV2(target)
            end)
        end

        if not opened then
            clipboard(target)
        end
    end))
    return button
end

function components.createStatusChip(parent, text, kind)
    local color = colors.subtext
    if kind == "success" then
        color = colors.success
    elseif kind == "error" then
        color = colors.danger
    elseif kind == "warning" then
        color = colors.warning
    elseif kind == "info" then
        color = colors.accent
    end

    local chip = new("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(0, 28),
    }, parent)
    corner(chip, 9)
    outline(chip, color, 0.45, 1)

    local dot = new("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(9, 10),
        Size = UDim2.fromOffset(7, 7),
    }, chip)
    corner(dot, 7)

    local label = components.createLabel(
        chip,
        text,
        UDim2.fromOffset(0, 28),
        colors.text,
        fonts.medium
    )
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.fromOffset(0, 28)
    label.Position = UDim2.fromOffset(22, 0)
    label.TextSize = 9

    new("UIPadding", {
        PaddingRight = UDim.new(0, 10),
    }, chip)

    return chip
end

function components.createSpacer(parent, height)
    return new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, height or 8),
    }, parent)
end

function components.createBlurProxy(parent)
    local frame = new("Frame", {
        BackgroundColor3 = colors.surface,
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, parent)
    corner(frame, 15)
    outline(frame, colors.border, 0.25, 1)
    return frame
end

function components.createShine(parent)
    local shine = new("Frame", {
        BackgroundColor3 = colors.text,
        BackgroundTransparency = 0.96,
        BorderSizePixel = 0,
        Position = UDim2.new(-0.4, 0, 0, 0),
        Size = UDim2.new(0.18, 0, 1, 0),
        Rotation = 8,
        ZIndex = 5,
    }, parent)

    task.spawn(function()
        while shine.Parent do
            shine.Position = UDim2.new(-0.4, 0, 0, 0)
            local animation = tween(shine, 1.4, {
                Position = UDim2.new(1.2, 0, 0, 0),
            }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            if animation then
                animation.Completed:Wait()
            end
            task.wait(1.8)
        end
    end)

    return shine
end

function components.createAnimatedBorder(parent)
    local frame = new("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, parent)
    corner(frame, 16)

    local stroke = outline(frame, colors.accent, 0.72, 1)
    task.spawn(function()
        local phase = 0.72
        while stroke.Parent do
            phase = phase == 0.72 and 0.42 or 0.72
            tween(stroke, 0.8, {
                Transparency = phase,
            }, Enum.EasingStyle.Sine)
            task.wait(0.85)
        end
    end)

    return frame
end

function components.createPasswordField(parent, placeholder)
    local frame, box = components.createInput(parent, placeholder or "Key", true)
    box.TextEditable = true

    local reveal = new("TextButton", {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Position = UDim2.new(1, -46, 0, 0),
        Size = UDim2.fromOffset(34, 44),
        Text = "Show",
        TextColor3 = colors.subtext,
        TextSize = 9,
    }, frame)

    local visible = false
    addConnection(reveal.MouseButton1Click:Connect(function()
        visible = not visible
        box.TextTransparency = visible and 0 or 0
        reveal.Text = visible and "Hide" or "Show"
    end))

    return frame, box, reveal
end

function components.createLoadingLine(parent)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, 2),
    }, parent)

    local line = new("Frame", {
        BackgroundColor3 = colors.accent,
        BorderSizePixel = 0,
        Position = UDim2.new(-0.25, 0, 0, 0),
        Size = UDim2.new(0.25, 0, 1, 0),
    }, holder)

    task.spawn(function()
        while holder.Parent do
            line.Position = UDim2.new(-0.25, 0, 0, 0)
            local animation = tween(line, 0.95, {
                Position = UDim2.new(1, 0, 0, 0),
            }, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            if animation then
                animation.Completed:Wait()
            end
            task.wait(0.08)
        end
    end)

    return holder
end

function components.createCountdown(parent, seconds, callback)
    local label = components.createLabel(
        parent,
        tostring(seconds),
        UDim2.new(1, 0, 0, 20),
        colors.subtext,
        fonts.mono
    )
    label.TextXAlignment = Enum.TextXAlignment.Center

    task.spawn(function()
        local remaining = math.max(0, math.floor(tonumber(seconds) or 0))
        while remaining > 0 and label.Parent do
            label.Text = tostring(remaining)
            task.wait(1)
            remaining -= 1
        end
        if label.Parent then
            label.Text = "Ready"
        end
        if type(callback) == "function" then
            pcall(callback)
        end
    end)

    return label
end

function components.createConfirm(parent, title, message, yesText, noText, callback)
    local shade, modal = components.createModal(parent, title, message)

    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 40),
    }, modal)

    local yes = makeButton(row, yesText or "Confirm", 40)
    yes.Size = UDim2.new(0.5, -4, 1, 0)
    yes.BackgroundColor3 = colors.accentDeep

    local no = makeButton(row, noText or "Cancel", 40)
    no.Size = UDim2.new(0.5, -4, 1, 0)
    no.Position = UDim2.new(0.5, 4, 0, 0)

    addConnection(yes.MouseButton1Click:Connect(function()
        shade:Destroy()
        if type(callback) == "function" then
            pcall(callback, true)
        end
    end))

    addConnection(no.MouseButton1Click:Connect(function()
        shade:Destroy()
        if type(callback) == "function" then
            pcall(callback, false)
        end
    end))

    return shade
end

function components.createTagList(parent, values)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, parent)

    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Wraps = true,
    }, holder)

    for _, value in ipairs(values or {}) do
        components.createBadge(holder, tostring(value), colors.borderSoft)
    end

    return holder
end

function components.createRadio(parent, options, selected, callback)
    local holder = components.createList(parent)
    local active = tostring(selected or "")

    for _, option in ipairs(options or {}) do
        local row = new("TextButton", {
            AutoButtonColor = false,
            BackgroundColor3 = colors.surface2,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 42),
            Text = "",
        }, holder)
        corner(row, 9)

        local dot = new("Frame", {
            BackgroundColor3 = tostring(option) == active and colors.accent or colors.surface3,
            BorderSizePixel = 0,
            Position = UDim2.fromOffset(12, 13),
            Size = UDim2.fromOffset(16, 16),
        }, row)
        corner(dot, 8)
        outline(dot, colors.border, 0.1, 1)

        local label = components.createLabel(
            row,
            tostring(option),
            UDim2.new(1, -52, 1, 0),
            colors.text,
            fonts.medium
        )
        label.Position = UDim2.fromOffset(40, 0)

        addConnection(row.MouseButton1Click:Connect(function()
            active = tostring(option)
            for _, child in ipairs(holder:GetChildren()) do
                if child:IsA("TextButton") then
                    local indicator = child:FindFirstChildOfClass("Frame")
                    if indicator then
                        tween(indicator, 0.14, {
                            BackgroundColor3 = child == row and colors.accent or colors.surface3,
                        })
                    end
                end
            end
            if type(callback) == "function" then
                pcall(callback, active)
            end
        end))
    end

    return holder
end

function components.createIconSlot(parent, glyph)
    local slot = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(34, 34),
    }, parent)
    corner(slot, 9)
    outline(slot, colors.borderSoft, 0.15, 1)

    local label = new("TextLabel", {
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Size = UDim2.fromScale(1, 1),
        Text = tostring(glyph or "•"),
        TextColor3 = colors.subtext,
        TextSize = 12,
    }, slot)

    return slot, label
end

function components.createInfoPair(parent, key, value)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 22),
    }, parent)

    components.createLabel(
        row,
        key,
        UDim2.new(0.45, 0, 1, 0),
        colors.faint,
        fonts.body
    )

    local valueLabel = components.createLabel(
        row,
        value,
        UDim2.new(0.55, 0, 1, 0),
        colors.text,
        fonts.mono
    )
    valueLabel.Position = UDim2.new(0.45, 0, 0, 0)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    return row, valueLabel
end

function components.createKeyDots(parent, count, active)
    local holder = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 12),
    }, parent)

    local layout = new("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 5),
    }, holder)

    for index = 1, math.max(0, tonumber(count) or 0) do
        local dot = new("Frame", {
            BackgroundColor3 = index <= (active or 0) and colors.accent or colors.surface3,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(6, 6),
        }, holder)
        corner(dot, 6)
    end

    return holder
end

function components.createCopyButton(parent, value)
    local button = makeButton(parent, "Copy", 36)
    addConnection(button.MouseButton1Click:Connect(function()
        if clipboard(value) then
            makeToast("Copied", "Done", "success")
        else
            makeToast("Copy", "Unavailable", "error")
        end
    end))
    return button
end

function components.createReveal(parent, text)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 50),
    }, parent)
    corner(holder, 10)
    outline(holder, colors.borderSoft, 0.15, 1)

    local label = components.createLabel(
        holder,
        "••••••••••••",
        UDim2.new(1, -70, 1, 0),
        colors.text,
        fonts.mono
    )
    label.Position = UDim2.fromOffset(12, 0)

    local reveal = new("TextButton", {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Font = fonts.medium,
        Position = UDim2.new(1, -58, 0, 0),
        Size = UDim2.fromOffset(50, 50),
        Text = "Show",
        TextColor3 = colors.subtext,
        TextSize = 9,
    }, holder)

    local visible = false
    addConnection(reveal.MouseButton1Click:Connect(function()
        visible = not visible
        label.Text = visible and tostring(text or "") or "••••••••••••"
        reveal.Text = visible and "Hide" or "Show"
    end))

    return holder
end

function components.createTimerBar(parent, duration)
    local holder = new("Frame", {
        BackgroundColor3 = colors.surface3,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 4),
    }, parent)
    corner(holder, 4)

    local fill = new("Frame", {
        BackgroundColor3 = colors.warning,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, holder)
    corner(fill, 4)

    local total = math.max(0.05, tonumber(duration) or 1)
    tween(fill, total, {
        Size = UDim2.fromScale(0, 1),
    }, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

    return holder
end

function components.createSearch(parent, placeholder)
    local frame, box = components.createInput(parent, placeholder or "Search", false)
    box.TextSize = 11
    return frame, box
end

function components.createDividerLabel(parent, text)
    local row = new("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 22),
    }, parent)

    local left = new("Frame", {
        BackgroundColor3 = colors.borderSoft,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 10),
        Size = UDim2.new(0.35, -8, 0, 1),
    }, row)

    local label = components.createLabel(
        row,
        text,
        UDim2.new(0.3, 0, 1, 0),
        colors.faint,
        fonts.medium
    )
    label.Position = UDim2.new(0.35, 0, 0, 0)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextSize = 9

    local right = new("Frame", {
        BackgroundColor3 = colors.borderSoft,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Position = UDim2.new(0.65, 8, 0, 10),
        Size = UDim2.new(0.35, -8, 0, 1),
    }, row)

    return row
end

function components.createToastPreview(parent, kind)
    local preview = new("Frame", {
        BackgroundColor3 = colors.surface,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 58),
    }, parent)
    corner(preview, 10)
    outline(preview, colors.borderSoft, 0.15, 1)

    local color = colors.accent
    if kind == "success" then
        color = colors.success
    elseif kind == "error" then
        color = colors.danger
    elseif kind == "warning" then
        color = colors.warning
    end

    local dot = new("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(12, 24),
        Size = UDim2.fromOffset(8, 8),
    }, preview)
    corner(dot, 8)

    return preview
end

function components.createWindowShadow(parent)
    local shadow = new("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.65,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(7, 9),
        Size = UDim2.new(1, -14, 1, -14),
        ZIndex = math.max(0, parent.ZIndex - 1),
    }, parent.Parent or parent)
    corner(shadow, 17)
    return shadow
end

suic1de.Components = components

local copyableStates = {
    info = true,
    success = true,
    warning = true,
    error = true,
    copy = true,
}

local function validToastKind(kind)
    kind = tostring(kind or "info")
    return copyableStates[kind] and kind or "info"
end

local oldNotify = suic1de.Notify
function suic1de:Notify(title, message, duration, kind)
    return oldNotify(self, title, message, duration, validToastKind(kind))
end

local function trim(value)
    if type(value) ~= "string" then
        return ""
    end
    return value:gsub("^%s+", ""):gsub("%s+$", "")
end

function suic1de:Verify(value)
    if type(self._verify) == "function" then
        return self._verify(trim(value))
    end
    return false
end

function suic1de:GetState()
    return {
        Alive = state.alive,
        Verifying = state.verifying,
        Failures = state.failures,
        Cooldown = math.max(0, state.cooldown - os.clock()),
    }
end

function suic1de:GetTheme()
    local result = {}
    for key, value in pairs(colors) do
        result[key] = value
    end
    return result
end

function suic1de:UseTheme(theme)
    return self:SetTheme(theme)
end

function suic1de:CopyLink(name)
    local link = self.Links[tostring(name)]
    if type(link) ~= "string" or link == "" then
        return false
    end
    return clipboard(link)
end

function suic1de:OpenGetKey()
    return self:OpenLink(self.Links.GetKey)
end

function suic1de:OpenDiscord()
    return self:OpenLink(self.Links.Discord)
end

function suic1de:OpenShop()
    return self:OpenLink(self.Shop.Link)
end

function suic1de:HasSavedKey()
    return self:GetSavedKey() ~= nil
end

function suic1de:SetKey(value)
    local key = trim(value)
    if key == "" then
        return false
    end
    saveKey(key)
    setAccepted(key)
    return true
end

function suic1de:Forget()
    self:ClearSavedKey()
    local env = safeGetgenv()
    env.SCRIPT_KEY = nil
    return true
end

function suic1de:Lock()
    local env = safeGetgenv()
    env.SCRIPT_KEY = nil
    return true
end

function suic1de:IsLocked()
    return not getAccepted()
end

function suic1de:CanVerify()
    return not state.verifying and os.clock() >= state.cooldown
end

function suic1de:GetCooldownText()
    local remaining = self:GetCooldown()
    if remaining <= 0 then
        return "Ready"
    end
    return string.format("%.1fs", remaining)
end

function suic1de:SetCallbacks(values)
    if type(values) ~= "table" then
        return false
    end
    for key, callback in pairs(values) do
        if self.Callbacks[key] ~= nil and type(callback) == "function" then
            self.Callbacks[key] = callback
        end
    end
    return true
end

function suic1de:SetLinksAndAppearance(values)
    if type(values) ~= "table" then
        return false
    end
    if values.Links then
        self:SetLinks(values.Links)
    end
    if values.Appearance then
        self:SetAppearance(values.Appearance)
    end
    return true
end

local componentCatalog = {
    "Card",
    "Label",
    "Badge",
    "Progress",
    "Spinner",
    "Pulse",
    "Tooltip",
    "Notice",
    "CodeField",
    "Switch",
    "Segment",
    "SpinnerButton",
    "Modal",
    "Skeleton",
    "Stepper",
    "KeyStrength",
    "ActionRow",
    "SoftButton",
    "AccentButton",
    "DangerButton",
    "Input",
    "TextArea",
    "Counter",
    "List",
    "Empty",
    "Header",
    "CloseButton",
    "LinkButton",
    "StatusChip",
    "Spacer",
    "BlurProxy",
    "Shine",
    "AnimatedBorder",
    "PasswordField",
    "LoadingLine",
    "Countdown",
    "Confirm",
    "TagList",
    "Radio",
    "IconSlot",
    "InfoPair",
    "KeyDots",
    "CopyButton",
    "Reveal",
    "TimerBar",
    "Search",
    "DividerLabel",
    "ToastPreview",
    "WindowShadow",
}

suic1de.ComponentNames = componentCatalog

local themeProfiles = {
    Dark = {
        background = Color3.fromRGB(5, 6, 9),
        surface = Color3.fromRGB(12, 14, 19),
        surface2 = Color3.fromRGB(17, 20, 27),
        surface3 = Color3.fromRGB(22, 25, 33),
        border = Color3.fromRGB(55, 59, 70),
        borderSoft = Color3.fromRGB(39, 42, 51),
        text = Color3.fromRGB(244, 245, 248),
        subtext = Color3.fromRGB(148, 153, 165),
        faint = Color3.fromRGB(93, 98, 111),
        accent = Color3.fromRGB(137, 164, 255),
        accentDeep = Color3.fromRGB(87, 112, 201),
        success = Color3.fromRGB(91, 210, 145),
        danger = Color3.fromRGB(238, 91, 111),
        warning = Color3.fromRGB(239, 181, 87),
    },
    Slate = {
        background = Color3.fromRGB(7, 9, 13),
        surface = Color3.fromRGB(14, 17, 23),
        surface2 = Color3.fromRGB(20, 24, 31),
        surface3 = Color3.fromRGB(27, 31, 40),
        border = Color3.fromRGB(62, 68, 79),
        borderSoft = Color3.fromRGB(44, 49, 59),
        text = Color3.fromRGB(241, 244, 248),
        subtext = Color3.fromRGB(151, 158, 171),
        faint = Color3.fromRGB(94, 101, 114),
        accent = Color3.fromRGB(125, 184, 255),
        accentDeep = Color3.fromRGB(75, 129, 194),
        success = Color3.fromRGB(96, 210, 151),
        danger = Color3.fromRGB(239, 98, 119),
        warning = Color3.fromRGB(237, 181, 88),
    },
    Mono = {
        background = Color3.fromRGB(6, 6, 6),
        surface = Color3.fromRGB(13, 13, 13),
        surface2 = Color3.fromRGB(19, 19, 19),
        surface3 = Color3.fromRGB(26, 26, 26),
        border = Color3.fromRGB(54, 54, 54),
        borderSoft = Color3.fromRGB(38, 38, 38),
        text = Color3.fromRGB(244, 244, 244),
        subtext = Color3.fromRGB(151, 151, 151),
        faint = Color3.fromRGB(91, 91, 91),
        accent = Color3.fromRGB(220, 220, 220),
        accentDeep = Color3.fromRGB(118, 118, 118),
        success = Color3.fromRGB(157, 211, 170),
        danger = Color3.fromRGB(220, 130, 130),
        warning = Color3.fromRGB(218, 188, 125),
    },
}

suic1de.ThemeProfiles = themeProfiles

function suic1de:ApplyProfile(name)
    local profile = themeProfiles[tostring(name)]
    if type(profile) ~= "table" then
        return false
    end
    return self:SetTheme(profile)
end

local easingProfiles = {
    Linear = Enum.EasingStyle.Linear,
    Sine = Enum.EasingStyle.Sine,
    Quad = Enum.EasingStyle.Quad,
    Cubic = Enum.EasingStyle.Cubic,
    Quart = Enum.EasingStyle.Quart,
    Quint = Enum.EasingStyle.Quint,
    Back = Enum.EasingStyle.Back,
    Elastic = Enum.EasingStyle.Elastic,
    Bounce = Enum.EasingStyle.Bounce,
    Exponential = Enum.EasingStyle.Exponential,
}

suic1de.Easing = easingProfiles

function suic1de:Animate(object, duration, properties, style, direction)
    local easing = easingProfiles[tostring(style or "Quart")] or Enum.EasingStyle.Quart
    local dir = Enum.EasingDirection[tostring(direction or "Out")] or Enum.EasingDirection.Out
    return tween(object, duration, properties, easing, dir)
end

local layoutProfiles = {
    Desktop = {
        Width = 420,
        Padding = 20,
        Radius = 17,
        ButtonHeight = 42,
        FieldHeight = 50,
    },
    Mobile = {
        Width = 330,
        Padding = 18,
        Radius = 15,
        ButtonHeight = 44,
        FieldHeight = 50,
    },
}

suic1de.LayoutProfiles = layoutProfiles

function suic1de:GetLayout()
    return isMobile() and layoutProfiles.Mobile or layoutProfiles.Desktop
end

function suic1de:IsMobile()
    return isMobile()
end

function suic1de:SetIntro(enabled, duration)
    self.Options.Intro = enabled == true
    if duration ~= nil then
        self.Options.IntroDuration = math.max(0.1, tonumber(duration) or 0.7)
    end
end

function suic1de:SetToastDuration(duration)
    self.Options.ToastDuration = math.max(0.5, tonumber(duration) or 3.2)
end

function suic1de:SetDraggable(enabled)
    self.Options.Draggable = enabled == true
end

function suic1de:SetKeyless(enabled, showUi)
    self.Options.Keyless = enabled
    if showUi ~= nil then
        self.Options.KeylessUi = showUi == true
    end
end

function suic1de:UseJunkie(service, identifier, provider, url)
    return self:LaunchJunkie({
        Service = service,
        Identifier = identifier,
        Provider = provider,
        Url = url,
    })
end

local statusCatalog = {
    Ready = "Ready",
    Checking = "Checking",
    Verified = "Verified",
    Invalid = "Invalid key",
    Expired = "Key expired",
    Revoked = "Key revoked",
    Blocked = "Access blocked",
    Waiting = "Wait a moment",
    Copied = "Copied",
    Unavailable = "Unavailable",
    Missing = "Link not set",
}

suic1de.StatusText = statusCatalog

local notificationCatalog = {
    info = {
        Title = "Info",
        Color = colors.accent,
    },
    success = {
        Title = "Done",
        Color = colors.success,
    },
    warning = {
        Title = "Wait",
        Color = colors.warning,
    },
    error = {
        Title = "Error",
        Color = colors.danger,
    },
    copy = {
        Title = "Copied",
        Color = colors.accent,
    },
}

suic1de.NotificationTypes = notificationCatalog

function suic1de:Toast(message, kind, duration)
    local info = notificationCatalog[validToastKind(kind)]
    return self:Notify(info.Title, message, duration, validToastKind(kind))
end

function suic1de:Success(message, duration)
    return self:Toast(message, "success", duration)
end

function suic1de:Error(message, duration)
    return self:Toast(message, "error", duration)
end

function suic1de:Warning(message, duration)
    return self:Toast(message, "warning", duration)
end

function suic1de:Info(message, duration)
    return self:Toast(message, "info", duration)
end

function suic1de:Copied(message, duration)
    return self:Toast(message or "Copied", "copy", duration)
end



local locale = {
    en = {
        title = "suic1.de",
        enter = "Enter your key",
        key = "Enter key",
        verify = "Verify",
        checking = "Checking",
        verified = "Verified",
        invalid = "Invalid key",
        expired = "Key expired",
        revoked = "Key revoked",
        blocked = "Access blocked",
        wait = "Wait a moment",
        copied = "Copied",
        unavailable = "Unavailable",
        getKey = "Get Key",
        discord = "Discord",
        premium = "Premium",
        buy = "Buy",
        ready = "Ready",
        access = "Access",
        secure = "SECURE ACCESS",
        close = "Close",
        cancel = "Cancel",
        confirm = "Confirm",
        show = "Show",
        hide = "Hide",
        info = "Info",
        done = "Done",
        error = "Error",
        warning = "Wait",
        network = "Try again",
        serviceMissing = "Service missing",
        wrongService = "Wrong service",
        hwid = "HWID mismatch",
        used = "Already used",
        premiumRequired = "Premium required",
        accessGranted = "Access granted",
        linkMissing = "Link not set",
        copyUnavailable = "Unavailable",
    },
    compact = {
        title = "suic1.de",
        enter = "Enter key",
        key = "Key",
        verify = "Verify",
        checking = "Checking",
        verified = "Verified",
        invalid = "Invalid",
        expired = "Expired",
        revoked = "Revoked",
        blocked = "Blocked",
        wait = "Wait",
        copied = "Copied",
        unavailable = "Unavailable",
        getKey = "Key",
        discord = "Discord",
        premium = "Premium",
        buy = "Buy",
        ready = "Ready",
        access = "Access",
        secure = "SECURE",
        close = "Close",
        cancel = "Cancel",
        confirm = "Confirm",
        show = "Show",
        hide = "Hide",
        info = "Info",
        done = "Done",
        error = "Error",
        warning = "Wait",
        network = "Retry",
        serviceMissing = "Missing",
        wrongService = "Wrong",
        hwid = "HWID",
        used = "Used",
        premiumRequired = "Premium",
        accessGranted = "Granted",
        linkMissing = "Missing",
        copyUnavailable = "Unavailable",
    },
}

suic1de.Locale = locale

function suic1de:SetLocale(name)
    local selected = locale[tostring(name)]
    if type(selected) ~= "table" then
        return false
    end
    self.Language = tostring(name)
    return true
end

function suic1de:GetLocale()
    return locale[self.Language or "en"] or locale.en
end

function suic1de:T(key, fallback)
    local selected = self:GetLocale()
    return selected[tostring(key)] or fallback or tostring(key)
end

local metrics = {
    launched = 0,
    verified = 0,
    failed = 0,
    copied = 0,
    notifications = 0,
    savedLoads = 0,
    keyless = 0,
}

suic1de.Metrics = metrics

function suic1de:GetMetrics()
    local copy = {}
    for key, value in pairs(metrics) do
        copy[key] = value
    end
    return copy
end

function suic1de:ResetMetrics()
    for key in pairs(metrics) do
        metrics[key] = 0
    end
end

local originalLaunch = suic1de.Launch
function suic1de:Launch(...)
    metrics.launched += 1
    return originalLaunch(self, ...)
end

local originalNotify = suic1de.Notify
function suic1de:Notify(title, message, duration, kind)
    metrics.notifications += 1
    return originalNotify(self, title, message, duration, kind)
end

function suic1de:CheckFilesystem()
    return {
        Read = type(readfile) == "function",
        Write = type(writefile) == "function",
        Exists = type(isfile) == "function",
        Delete = type(delfile) == "function",
        Folder = type(isfolder) == "function",
        MakeFolder = type(makefolder) == "function",
    }
end

function suic1de:CheckClipboard()
    return type(setclipboard) == "function"
end

function suic1de:CheckWebView()
    local ok, service = pcall(function()
        return game:GetService("WebViewService")
    end)
    return ok and service ~= nil
end

function suic1de:CheckHttp()
    return type(game.HttpGet) == "function"
end

function suic1de:CheckLoadstring()
    return type(loadstring) == "function"
end

function suic1de:Compatibility()
    return {
        Filesystem = self:CheckFilesystem(),
        Clipboard = self:CheckClipboard(),
        WebView = self:CheckWebView(),
        Http = self:CheckHttp(),
        Loadstring = self:CheckLoadstring(),
        Mobile = self:IsMobile(),
    }
end

local function finiteNumber(value, fallback)
    value = tonumber(value)
    if not value then
        return fallback
    end
    if value ~= value or value == math.huge or value == -math.huge then
        return fallback
    end
    return value
end

function suic1de:ValidateOptions()
    local errors = {}

    self.Options.IntroDuration = finiteNumber(self.Options.IntroDuration, 0.7)
    self.Options.ToastDuration = finiteNumber(self.Options.ToastDuration, 3.2)

    if self.Options.IntroDuration < 0.1 then
        self.Options.IntroDuration = 0.1
    end

    if self.Options.ToastDuration < 0.5 then
        self.Options.ToastDuration = 0.5
    end

    if self.Options.Keyless ~= "" and self.Options.Keyless ~= nil and type(self.Options.Keyless) ~= "boolean" then
        errors[#errors + 1] = "Options.Keyless"
        self.Options.Keyless = ""
    end

    if type(self.Options.KeylessUi) ~= "boolean" then
        errors[#errors + 1] = "Options.KeylessUi"
        self.Options.KeylessUi = true
    end

    if type(self.Options.Draggable) ~= "boolean" then
        errors[#errors + 1] = "Options.Draggable"
        self.Options.Draggable = true
    end

    if type(self.Options.Intro) ~= "boolean" then
        errors[#errors + 1] = "Options.Intro"
        self.Options.Intro = true
    end

    return #errors == 0, errors
end

function suic1de:ValidateCallbacks()
    local invalid = {}
    for key in pairs(self.Callbacks) do
        local value = self.Callbacks[key]
        if value ~= "" and value ~= nil and type(value) ~= "function" then
            invalid[#invalid + 1] = key
        end
    end
    return #invalid == 0, invalid
end

function suic1de:ValidateAll()
    local validA, errorsA = self:Validate()
    local validB, errorsB = self:ValidateOptions()
    local validC, errorsC = self:ValidateCallbacks()

    local all = {}
    for _, value in ipairs(errorsA) do
        all[#all + 1] = value
    end
    for _, value in ipairs(errorsB) do
        all[#all + 1] = value
    end
    for _, value in ipairs(errorsC) do
        all[#all + 1] = value
    end

    return validA and validB and validC, all
end

local accessibility = {
    minimumButton = 36,
    minimumTouch = 42,
    compactButton = 40,
    field = 44,
    largeField = 50,
    close = 30,
    toast = 68,
}

suic1de.Accessibility = accessibility

function suic1de:GetMinimumTouchSize()
    return accessibility.minimumTouch
end

function suic1de:IsTouch()
    return services.Input.TouchEnabled == true
end

function suic1de:IsKeyboard()
    return services.Input.KeyboardEnabled == true
end

local eventNames = {
    Ready = "OnReady",
    Verify = "OnVerify",
    Success = "OnSuccess",
    Fail = "OnFail",
}

suic1de.Events = eventNames

function suic1de:Fire(name, ...)
    local callbackName = eventNames[tostring(name)] or tostring(name)
    local callback = self.Callbacks[callbackName]
    if type(callback) ~= "function" then
        return false
    end
    local ok, result = pcall(callback, ...)
    return ok, result
end

local keyRules = {
    min = 1,
    max = 512,
    trim = true,
    control = false,
}

suic1de.KeyRules = keyRules

function suic1de:NormalizeKey(value)
    value = tostring(value or "")
    if keyRules.trim then
        value = trim(value)
    end
    if #value < keyRules.min then
        return ""
    end
    if #value > keyRules.max then
        value = value:sub(1, keyRules.max)
    end
    if not keyRules.control and value:find("[%c]") then
        return ""
    end
    return value
end

function suic1de:IsKeyShapeValid(value)
    return self:NormalizeKey(value) ~= ""
end

function suic1de:Prepare()
    self:ValidateAll()
    sanitizeConfig()
    return true
end

local release = {
    Name = "suic1.de",
    Channel = "stable",
    Major = 1,
    Minor = 0,
    Patch = 0,
}

suic1de.Release = release

function suic1de:GetVersion()
    return string.format(
        "%d.%d.%d",
        release.Major,
        release.Minor,
        release.Patch
    )
end

function suic1de:GetBuild()
    return release.Name .. " " .. self:GetVersion()
end

local animationDurations = {
    micro = 0.08,
    quick = 0.12,
    focus = 0.16,
    fast = 0.18,
    normal = 0.28,
    toastOut = 0.25,
    toastIn = 0.35,
    smooth = 0.42,
    intro = 0.7,
    glow = 1.1,
}

suic1de.AnimationDurations = animationDurations

function suic1de:GetAnimationDuration(name)
    return animationDurations[tostring(name)] or animationDurations.normal
end

local notificationDurations = {
    short = 1.8,
    normal = 3.2,
    long = 5,
    persistent = 60,
}

suic1de.NotificationDurations = notificationDurations

function suic1de:GetNotificationDuration(name)
    return notificationDurations[tostring(name)] or notificationDurations.normal
end

local actionCatalog = {
    Verify = {
        Text = "Verify",
        Kind = "accent",
    },
    GetKey = {
        Text = "Get Key",
        Kind = "link",
    },
    Discord = {
        Text = "Discord",
        Kind = "link",
    },
    Buy = {
        Text = "Buy",
        Kind = "accent",
    },
    Close = {
        Text = "Close",
        Kind = "neutral",
    },
    Cancel = {
        Text = "Cancel",
        Kind = "neutral",
    },
    Confirm = {
        Text = "Confirm",
        Kind = "accent",
    },
    Copy = {
        Text = "Copy",
        Kind = "neutral",
    },
    Show = {
        Text = "Show",
        Kind = "neutral",
    },
    Hide = {
        Text = "Hide",
        Kind = "neutral",
    },
}

suic1de.Actions = actionCatalog

function suic1de:GetAction(name)
    return actionCatalog[tostring(name)]
end

local statusKinds = {
    Ready = "info",
    Checking = "info",
    Verified = "success",
    Invalid = "error",
    Expired = "error",
    Revoked = "error",
    Blocked = "error",
    Waiting = "warning",
    Copied = "copy",
    Unavailable = "error",
}

suic1de.StatusKinds = statusKinds

function suic1de:GetStatusKind(name)
    return statusKinds[tostring(name)] or "info"
end

local uiMetrics = {
    desktop = {
        minWidth = 360,
        maxWidth = 460,
        cardRadius = 17,
        fieldRadius = 11,
        buttonRadius = 11,
        toastRadius = 13,
        spacing = 12,
    },
    mobile = {
        minWidth = 300,
        maxWidth = 350,
        cardRadius = 15,
        fieldRadius = 10,
        buttonRadius = 10,
        toastRadius = 12,
        spacing = 10,
    },
}

suic1de.UIMetrics = uiMetrics

function suic1de:GetUIMetrics()
    return isMobile() and uiMetrics.mobile or uiMetrics.desktop
end

local safeMethods = {
    "Launch",
    "LaunchJunkie",
    "Destroy",
    "Notify",
    "Toast",
    "Success",
    "Error",
    "Warning",
    "Info",
    "Copied",
    "GetSavedKey",
    "ClearSavedKey",
    "OpenGetKey",
    "OpenDiscord",
    "OpenShop",
    "CopyLink",
    "Verify",
    "SetKey",
    "Forget",
    "Lock",
}

suic1de.SafeMethods = safeMethods

function suic1de:HasMethod(name)
    return type(self[tostring(name)]) == "function"
end

function suic1de:MethodList()
    local list = {}
    for _, name in ipairs(safeMethods) do
        list[#list + 1] = name
    end
    return list
end

local supportedErrors = {}
for code in pairs(errorText) do
    supportedErrors[#supportedErrors + 1] = code
end
table.sort(supportedErrors)

suic1de.ErrorCodes = supportedErrors

function suic1de:IsTransientError(code)
    code = tostring(code or "")
    return code == "NETWORK" or code == "ERROR"
end

function suic1de:IsBlockingError(code)
    return tostring(code or "") == "HWID_BANNED"
end

function suic1de:GetErrorText(code)
    return errorText[tostring(code or "")] or "Invalid key"
end

function suic1de:CountFailure(code)
    if self:IsTransientError(code) then
        return
    end
    state.failures += 1
    if state.failures >= 5 then
        state.cooldown = os.clock() + 15
    elseif state.failures >= 3 then
        state.cooldown = os.clock() + 5
    end
end

function suic1de:ClearCooldown()
    state.cooldown = 0
end

function suic1de:ClearNotifications()
    for id, toast in pairs(state.toasts) do
        if toast and toast.Parent then
            pcall(function()
                toast:Destroy()
            end)
        end
        state.toasts[id] = nil
    end
end

function suic1de:Refresh()
    if not state.alive then
        return self:Launch()
    end
    self:Destroy()
    return self:Launch()
end

local runtime = {
    StartedAt = os.clock(),
    LastLaunch = 0,
    LastVerify = 0,
}

suic1de.Runtime = runtime

function suic1de:GetUptime()
    return math.max(0, os.clock() - runtime.StartedAt)
end

function suic1de:GetRuntime()
    return {
        StartedAt = runtime.StartedAt,
        LastLaunch = runtime.LastLaunch,
        LastVerify = runtime.LastVerify,
        Uptime = self:GetUptime(),
    }
end

local function touchRuntimeLaunch()
    runtime.LastLaunch = os.clock()
end

local originalLaunchTracked = suic1de.Launch
function suic1de:Launch(...)
    touchRuntimeLaunch()
    return originalLaunchTracked(self, ...)
end

local originalVerify = suic1de.Verify
function suic1de:Verify(value)
    runtime.LastVerify = os.clock()
    return originalVerify(self, value)
end

local configurationDefaults = {
    Appearance = {
        Title = "suic1.de",
        Subtitle = "Enter your key",
        KeylessTitle = "suic1.de",
        KeylessSubtitle = "Access granted",
        Icon = "",
    },
    Links = {
        GetKey = "",
        Discord = "",
    },
    Storage = {
        FileName = "suic1de_key",
        Folder = "suic1de",
        Remember = true,
        AutoLoad = true,
    },
    Options = {
        Keyless = "",
        KeylessUi = true,
        Draggable = true,
        Intro = true,
        IntroDuration = 0.7,
        ToastDuration = 3.2,
    },
    Shop = {
        Enabled = false,
        Icon = "",
        Title = "Premium",
        Subtitle = "Get access",
        ButtonText = "Buy",
        Link = "",
    },
}

suic1de.Defaults = configurationDefaults

function suic1de:GetDefaults()
    local function clone(value)
        if type(value) ~= "table" then
            return value
        end
        local result = {}
        for key, item in pairs(value) do
            result[key] = clone(item)
        end
        return result
    end
    return clone(configurationDefaults)
end

function suic1de:ResetConfiguration()
    local defaults = self:GetDefaults()
    self.Appearance = defaults.Appearance
    self.Links = defaults.Links
    self.Storage = defaults.Storage
    self.Options = defaults.Options
    self.Shop = defaults.Shop
    return true
end

local featureFlags = {
    Intro = true,
    Toasts = true,
    WebView = true,
    Clipboard = true,
    Filesystem = true,
    Keyless = true,
    Junkie = true,
    Drag = true,
    Touch = true,
    Desktop = true,
}

suic1de.Features = featureFlags

function suic1de:IsFeatureAvailable(name)
    local key = tostring(name)
    if featureFlags[key] == nil then
        return false
    end
    if key == "Clipboard" then
        return self:CheckClipboard()
    end
    if key == "Filesystem" then
        return filesystemReady()
    end
    if key == "WebView" then
        return self:CheckWebView()
    end
    if key == "Touch" then
        return self:IsTouch()
    end
    if key == "Desktop" then
        return self:IsKeyboard()
    end
    return featureFlags[key] == true
end

function suic1de:GetFeatures()
    local result = {}
    for key in pairs(featureFlags) do
        result[key] = self:IsFeatureAvailable(key)
    end
    return result
end

local themeKeys = {
    "background",
    "surface",
    "surface2",
    "surface3",
    "border",
    "borderSoft",
    "text",
    "subtext",
    "faint",
    "accent",
    "accentDeep",
    "success",
    "danger",
    "warning",
}

suic1de.ThemeKeys = themeKeys

function suic1de:IsThemeKey(name)
    return colors[tostring(name)] ~= nil
end

function suic1de:SetColor(name, value)
    name = tostring(name)
    if not self:IsThemeKey(name) or typeof(value) ~= "Color3" then
        return false
    end
    colors[name] = value
    return true
end

function suic1de:GetColor(name)
    return colors[tostring(name)]
end

local uiStateNames = {
    "Idle",
    "Focused",
    "Checking",
    "Success",
    "Error",
    "Cooldown",
    "Keyless",
    "Closed",
}

suic1de.UIStates = uiStateNames

function suic1de:GetUIState()
    if not state.alive then
        return "Closed"
    end
    if self.Options.Keyless == true then
        return "Keyless"
    end
    if state.verifying then
        return "Checking"
    end
    if os.clock() < state.cooldown then
        return "Cooldown"
    end
    return "Idle"
end

local callbackNames = {
    "OnVerify",
    "OnSuccess",
    "OnFail",
    "OnReady",
}

suic1de.CallbackNames = callbackNames

function suic1de:GetCallback(name)
    return self.Callbacks[tostring(name)]
end

function suic1de:HasCallback(name)
    return type(self:GetCallback(name)) == "function"
end

local storageCapabilities = {
    read = "readfile",
    write = "writefile",
    exists = "isfile",
    delete = "delfile",
    folder = "isfolder",
    createFolder = "makefolder",
}

suic1de.StorageCapabilities = storageCapabilities

function suic1de:StorageAvailable()
    local info = self:CheckFilesystem()
    return info.Read and info.Write and info.Exists
end

function suic1de:CanRemember()
    return self.Storage.Remember == true and self:StorageAvailable()
end

function suic1de:Save(value)
    value = self:NormalizeKey(value)
    if value == "" then
        return false
    end
    saveKey(value)
    return true
end

function suic1de:Load()
    return self:GetSavedKey()
end

local linkNames = {
    GetKey = "GetKey",
    Discord = "Discord",
    Shop = "Shop",
}

suic1de.LinkNames = linkNames

function suic1de:GetLink(name)
    local key = tostring(name)
    if key == "Shop" then
        return tostring(self.Shop.Link or "")
    end
    return tostring(self.Links[key] or "")
end

function suic1de:HasLink(name)
    return self:GetLink(name) ~= ""
end

function suic1de:Copy(name)
    local link = self:GetLink(name)
    if link == "" then
        return false
    end
    return clipboard(link)
end

function suic1de:Open(name)
    local link = self:GetLink(name)
    if link == "" then
        return false
    end
    return self:OpenLink(link)
end

local toastQueue = {
    max = 4,
    gap = 8,
}

suic1de.ToastQueue = toastQueue

function suic1de:SetToastLimit(value)
    toastQueue.max = math.clamp(math.floor(tonumber(value) or 4), 1, 10)
end

function suic1de:GetToastLimit()
    return toastQueue.max
end

local inputRules = {
    trim = true,
    stripControl = true,
    maximum = 512,
}

suic1de.InputRules = inputRules

function suic1de:Sanitize(value)
    value = tostring(value or "")
    if inputRules.trim then
        value = trim(value)
    end
    if inputRules.stripControl then
        value = value:gsub("[%c]", "")
    end
    if #value > inputRules.maximum then
        value = value:sub(1, inputRules.maximum)
    end
    return value
end

function suic1de:ResetRuntime()
    state.failures = 0
    state.cooldown = 0
    state.verifying = false
    runtime.LastVerify = 0
    return true
end

function suic1de:Shutdown()
    self:Destroy()
    self:ClearNotifications()
    self:ResetRuntime()
    return true
end

local health = {
    UI = true,
    Storage = true,
    Clipboard = true,
    Verification = true,
}

suic1de.Health = health

function suic1de:HealthCheck()
    local valid = true

    health.UI = type(Instance) == "table" or type(Instance) == "userdata"
    health.Storage = self:StorageAvailable() or not self.Storage.Remember
    health.Clipboard = self:CheckClipboard() or (not self:HasLink("Discord") and not self:HasLink("GetKey"))
    health.Verification = type(self.Callbacks.OnVerify) == "function" or self.Options.Keyless == true

    for _, value in pairs(health) do
        if not value then
            valid = false
        end
    end

    return valid, health
end


local ICON_LUCIDE_URL="https://raw.githubusercontent.com/ArchIsDead/Arch-Vault/refs/heads/main/lucide-icons.lua"
local ICON_SOLAR_URL="https://raw.githubusercontent.com/ArchIsDead/Arch-Vault/refs/heads/main/solar-icons.lua"
local embeddedLucide = {
	["a-arrow-down"] = "rbxassetid://92867583610071",
	["a-arrow-up"] = "rbxassetid://132318504999733",
	["a-large-small"] = "rbxassetid://111491496660216",
	["accessibility"] = "rbxassetid://114029945302017",
	["activity"] = "rbxassetid://94212016861936",
	["air-vent"] = "rbxassetid://81517226012329",
	["airplay"] = "rbxassetid://115020759309179",
	["alarm-clock-check"] = "rbxassetid://76437352099157",
	["alarm-clock-minus"] = "rbxassetid://77364179863205",
	["alarm-clock-off"] = "rbxassetid://97904885874823",
	["alarm-clock-plus"] = "rbxassetid://80468822979214",
	["alarm-clock"] = "rbxassetid://126259032907535",
	["alarm-smoke"] = "rbxassetid://96965448419685",
	["album"] = "rbxassetid://127358331163602",
	["align-center-horizontal"] = "rbxassetid://81570549209434",
	["align-center-vertical"] = "rbxassetid://118470463752466",
	["align-end-horizontal"] = "rbxassetid://139502909745427",
	["align-end-vertical"] = "rbxassetid://96528869059554",
	["align-horizontal-distribute-center"] = "rbxassetid://97220086126656",
	["align-horizontal-distribute-end"] = "rbxassetid://106128590702022",
	["align-horizontal-distribute-start"] = "rbxassetid://76074660002997",
	["align-horizontal-justify-center"] = "rbxassetid://75732302772427",
	["align-horizontal-justify-end"] = "rbxassetid://129167626402283",
	["align-horizontal-justify-start"] = "rbxassetid://130161830325281",
	["align-horizontal-space-around"] = "rbxassetid://91646106782950",
	["align-horizontal-space-between"] = "rbxassetid://103886093046990",
	["align-start-horizontal"] = "rbxassetid://125674804697729",
	["align-start-vertical"] = "rbxassetid://105020230154823",
	["align-vertical-distribute-center"] = "rbxassetid://93791183635525",
	["align-vertical-distribute-end"] = "rbxassetid://139354223511433",
	["align-vertical-distribute-start"] = "rbxassetid://74961997822126",
	["align-vertical-justify-center"] = "rbxassetid://134754696166569",
	["align-vertical-justify-end"] = "rbxassetid://92569381441969",
	["align-vertical-justify-start"] = "rbxassetid://99692844572718",
	["align-vertical-space-around"] = "rbxassetid://96206012459190",
	["align-vertical-space-between"] = "rbxassetid://124998077349706",
	["ambulance"] = "rbxassetid://78599995190651",
	["ampersand"] = "rbxassetid://75272915739209",
	["ampersands"] = "rbxassetid://126947193455996",
	["amphora"] = "rbxassetid://137370389604364",
	["anchor"] = "rbxassetid://92181172123618",
	["angry"] = "rbxassetid://74237056000103",
	["annoyed"] = "rbxassetid://80064369052011",
	["antenna"] = "rbxassetid://99628923540956",
	["anvil"] = "rbxassetid://100203029845919",
	["aperture"] = "rbxassetid://83396154449972",
	["app-window-mac"] = "rbxassetid://79587216113811",
	["app-window"] = "rbxassetid://93142176757189",
	["apple"] = "rbxassetid://104349242902442",
	["archive-restore"] = "rbxassetid://78956681942188",
	["archive-x"] = "rbxassetid://75830115088395",
	["archive"] = "rbxassetid://122180020814574",
	["armchair"] = "rbxassetid://105384358373973",
	["arrow-big-down-dash"] = "rbxassetid://137987229582002",
	["arrow-big-down"] = "rbxassetid://81081164158885",
	["arrow-big-left-dash"] = "rbxassetid://97827621354677",
	["arrow-big-left"] = "rbxassetid://85973092492641",
	["arrow-big-right-dash"] = "rbxassetid://117825834972403",
	["arrow-big-right"] = "rbxassetid://82960676755590",
	["arrow-big-up-dash"] = "rbxassetid://99260194327483",
	["arrow-big-up"] = "rbxassetid://93136954756149",
	["arrow-down-0-1"] = "rbxassetid://120961896217875",
	["arrow-down-1-0"] = "rbxassetid://93474255891850",
	["arrow-down-a-z"] = "rbxassetid://99554596207900",
	["arrow-down-from-line"] = "rbxassetid://132045845807798",
	["arrow-down-left"] = "rbxassetid://102899325237364",
	["arrow-down-narrow-wide"] = "rbxassetid://129105261655061",
	["arrow-down-right"] = "rbxassetid://123109928624974",
	["arrow-down-to-dot"] = "rbxassetid://101675355931221",
	["arrow-down-to-line"] = "rbxassetid://87050478931254",
	["arrow-down-up"] = "rbxassetid://85780258549577",
	["arrow-down-wide-narrow"] = "rbxassetid://88461733425991",
	["arrow-down-z-a"] = "rbxassetid://76115279362232",
	["arrow-down"] = "rbxassetid://98764963621439",
	["arrow-left-from-line"] = "rbxassetid://87857914437603",
	["arrow-left-right"] = "rbxassetid://131324733048447",
	["arrow-left-to-line"] = "rbxassetid://118645136026970",
	["arrow-left"] = "rbxassetid://102531941843733",
	["arrow-right-from-line"] = "rbxassetid://74073639809355",
	["arrow-right-left"] = "rbxassetid://77015754304300",
	["arrow-right-to-line"] = "rbxassetid://78632510329852",
	["arrow-right"] = "rbxassetid://113692007244654",
	["arrow-up-0-1"] = "rbxassetid://105257823943016",
	["arrow-up-1-0"] = "rbxassetid://134175521693798",
	["arrow-up-a-z"] = "rbxassetid://77763416595160",
	["arrow-up-down"] = "rbxassetid://81019887641527",
	["arrow-up-from-dot"] = "rbxassetid://124408496673275",
	["arrow-up-from-line"] = "rbxassetid://95777664626453",
	["arrow-up-left"] = "rbxassetid://123490598231261",
	["arrow-up-narrow-wide"] = "rbxassetid://73006024672636",
	["arrow-up-right"] = "rbxassetid://129280608535523",
	["arrow-up-to-line"] = "rbxassetid://108818207813537",
	["arrow-up-wide-narrow"] = "rbxassetid://87437426951568",
	["arrow-up-z-a"] = "rbxassetid://107546173611884",
	["arrow-up"] = "rbxassetid://89282378235317",
	["arrows-up-from-line"] = "rbxassetid://133710016938621",
	["asterisk"] = "rbxassetid://88552752106723",
	["at-sign"] = "rbxassetid://79059152889146",
	["atom"] = "rbxassetid://73167696981648",
	["audio-lines"] = "rbxassetid://70930641819242",
	["audio-waveform"] = "rbxassetid://86462036665209",
	["award"] = "rbxassetid://132740088158419",
	["axe"] = "rbxassetid://132405197863294",
	["axis-3d"] = "rbxassetid://122438676546804",
	["baby"] = "rbxassetid://93472926933440",
	["backpack"] = "rbxassetid://140420225386018",
	["badge-alert"] = "rbxassetid://101829200081951",
	["badge-cent"] = "rbxassetid://133345018873154",
	["badge-check"] = "rbxassetid://76078495178149",
	["badge-dollar-sign"] = "rbxassetid://127139803581141",
	["badge-euro"] = "rbxassetid://120016477674659",
	["badge-indian-rupee"] = "rbxassetid://75659682309981",
	["badge-info"] = "rbxassetid://131995373201472",
	["badge-japanese-yen"] = "rbxassetid://99081574588615",
	["badge-minus"] = "rbxassetid://140321561183881",
	["badge-percent"] = "rbxassetid://121359224294885",
	["badge-plus"] = "rbxassetid://100325578561866",
	["badge-pound-sterling"] = "rbxassetid://119688217279444",
	["badge-question-mark"] = "rbxassetid://121464963737502",
	["badge-russian-ruble"] = "rbxassetid://108839463659864",
	["badge-swiss-franc"] = "rbxassetid://91447608372740",
	["badge-turkish-lira"] = "rbxassetid://137839965873529",
	["badge-x"] = "rbxassetid://122931434733842",
	["badge"] = "rbxassetid://116620312917084",
	["baggage-claim"] = "rbxassetid://86922213051957",
	["ban"] = "rbxassetid://90767043015246",
	["banana"] = "rbxassetid://140713420056179",
	["bandage"] = "rbxassetid://129660129590770",
	["banknote-arrow-down"] = "rbxassetid://139366449345199",
	["banknote-arrow-up"] = "rbxassetid://133758343082529",
	["banknote-x"] = "rbxassetid://95348701438065",
	["banknote"] = "rbxassetid://104840231536668",
	["barcode"] = "rbxassetid://118473018143689",
	["barrel"] = "rbxassetid://130647115622774",
	["baseline"] = "rbxassetid://124677132511270",
	["bath"] = "rbxassetid://76031400297942",
	["battery-charging"] = "rbxassetid://80139357470047",
	["battery-full"] = "rbxassetid://70906718268972",
	["battery-low"] = "rbxassetid://139659256984314",
	["battery-medium"] = "rbxassetid://105934079398915",
	["battery-plus"] = "rbxassetid://91931341486966",
	["battery-warning"] = "rbxassetid://115230083817257",
	["battery"] = "rbxassetid://70765800346189",
	["beaker"] = "rbxassetid://80902539995520",
	["bean-off"] = "rbxassetid://98164436608714",
	["bean"] = "rbxassetid://89491967076869",
	["bed-double"] = "rbxassetid://73820193212911",
	["bed-single"] = "rbxassetid://113423940880634",
	["bed"] = "rbxassetid://97726529032925",
	["beef"] = "rbxassetid://105850162318915",
	["beer-off"] = "rbxassetid://120333134736361",
	["beer"] = "rbxassetid://116404978807744",
	["bell-dot"] = "rbxassetid://93161277118810",
	["bell-electric"] = "rbxassetid://100277767266983",
	["bell-minus"] = "rbxassetid://126334890449727",
	["bell-off"] = "rbxassetid://78560046118930",
	["bell-plus"] = "rbxassetid://77014333795836",
	["bell-ring"] = "rbxassetid://94612128913941",
	["bell"] = "rbxassetid://97392696311902",
	["between-horizontal-end"] = "rbxassetid://81602774794322",
	["between-horizontal-start"] = "rbxassetid://76112384929846",
	["between-vertical-end"] = "rbxassetid://72817612571631",
	["between-vertical-start"] = "rbxassetid://85278312190301",
	["biceps-flexed"] = "rbxassetid://82004462003936",
	["bike"] = "rbxassetid://102930322246035",
	["binary"] = "rbxassetid://91751953950088",
	["binoculars"] = "rbxassetid://101460003267896",
	["biohazard"] = "rbxassetid://95956532900432",
	["bird"] = "rbxassetid://132284145117371",
	["birdhouse"] = "rbxassetid://83999157401433",
	["bitcoin"] = "rbxassetid://95459240442938",
	["blend"] = "rbxassetid://111679612185257",
	["blinds"] = "rbxassetid://71164165283925",
	["blocks"] = "rbxassetid://72212693357737",
	["bluetooth-connected"] = "rbxassetid://96315134002985",
	["bluetooth-off"] = "rbxassetid://80600044218117",
	["bluetooth-searching"] = "rbxassetid://100673019606426",
	["bluetooth"] = "rbxassetid://90506573139443",
	["bold"] = "rbxassetid://116141470019166",
	["bolt"] = "rbxassetid://102881251417484",
	["bomb"] = "rbxassetid://139223800924636",
	["bone"] = "rbxassetid://111242153474115",
	["book-a"] = "rbxassetid://104067275658465",
	["book-alert"] = "rbxassetid://124159928044853",
	["book-audio"] = "rbxassetid://109208148317037",
	["book-check"] = "rbxassetid://115999656081696",
	["book-copy"] = "rbxassetid://108543407492005",
	["book-dashed"] = "rbxassetid://127430784795958",
	["book-down"] = "rbxassetid://101011730128222",
	["book-headphones"] = "rbxassetid://108670200799574",
	["book-heart"] = "rbxassetid://112788845135284",
	["book-image"] = "rbxassetid://80808285757226",
	["book-key"] = "rbxassetid://116024426170705",
	["book-lock"] = "rbxassetid://118765061220571",
	["book-marked"] = "rbxassetid://73211024251780",
	["book-minus"] = "rbxassetid://112724962046282",
	["book-open-check"] = "rbxassetid://130848362492667",
	["book-open-text"] = "rbxassetid://100629528672195",
	["book-open"] = "rbxassetid://129845326810392",
	["book-plus"] = "rbxassetid://140267785051233",
	["book-text"] = "rbxassetid://94011772484232",
	["book-type"] = "rbxassetid://97817304725443",
	["book-up-2"] = "rbxassetid://130161620853665",
	["book-up"] = "rbxassetid://98640174079190",
	["book-user"] = "rbxassetid://128489189240523",
	["book-x"] = "rbxassetid://118754548186537",
	["book"] = "rbxassetid://125383279695672",
	["bookmark-check"] = "rbxassetid://93940443347986",
	["bookmark-minus"] = "rbxassetid://96807096039910",
	["bookmark-plus"] = "rbxassetid://121469724491615",
	["bookmark-x"] = "rbxassetid://112272342584706",
	["bookmark"] = "rbxassetid://121093149326239",
	["boom-box"] = "rbxassetid://99901322535868",
	["bot-message-square"] = "rbxassetid://96145330292478",
	["bot-off"] = "rbxassetid://140417690560013",
	["bot"] = "rbxassetid://80451686744860",
	["bottle-wine"] = "rbxassetid://131675403196921",
	["bow-arrow"] = "rbxassetid://124089655150375",
	["box"] = "rbxassetid://101768155599700",
	["boxes"] = "rbxassetid://136372617578355",
	["braces"] = "rbxassetid://117761094704041",
	["brackets"] = "rbxassetid://74368995728099",
	["brain-circuit"] = "rbxassetid://70547962410202",
	["brain-cog"] = "rbxassetid://132039205501538",
	["brain"] = "rbxassetid://92424107303177",
	["brick-wall-fire"] = "rbxassetid://92980588705520",
	["brick-wall-shield"] = "rbxassetid://75954432775071",
	["brick-wall"] = "rbxassetid://112878522258821",
	["briefcase-business"] = "rbxassetid://129135125207283",
	["briefcase-conveyor-belt"] = "rbxassetid://108665725653714",
	["briefcase-medical"] = "rbxassetid://119917756334087",
	["briefcase"] = "rbxassetid://96754188164225",
	["bring-to-front"] = "rbxassetid://132975903553748",
	["brush-cleaning"] = "rbxassetid://71728977448805",
	["brush"] = "rbxassetid://127035535799640",
	["bubbles"] = "rbxassetid://106183424168227",
	["bug-off"] = "rbxassetid://88020025049245",
	["bug-play"] = "rbxassetid://80107955888092",
	["bug"] = "rbxassetid://83626408925438",
	["building-2"] = "rbxassetid://77873775611951",
	["building"] = "rbxassetid://110616258983082",
	["bus-front"] = "rbxassetid://89863432456045",
	["bus"] = "rbxassetid://133798469717463",
	["cable-car"] = "rbxassetid://128643682205596",
	["cable"] = "rbxassetid://128449944504901",
	["cake-slice"] = "rbxassetid://136769828413242",
	["cake"] = "rbxassetid://103131590503275",
	["calculator"] = "rbxassetid://74915716529646",
	["calendar-1"] = "rbxassetid://98458364171044",
	["calendar-arrow-down"] = "rbxassetid://108415736543437",
	["calendar-arrow-up"] = "rbxassetid://70574654109118",
	["calendar-check-2"] = "rbxassetid://120231170248276",
	["calendar-check"] = "rbxassetid://71551019465748",
	["calendar-clock"] = "rbxassetid://119132152594595",
	["calendar-cog"] = "rbxassetid://122402172360287",
	["calendar-days"] = "rbxassetid://99072017568595",
	["calendar-fold"] = "rbxassetid://117368871270394",
	["calendar-heart"] = "rbxassetid://88839008103676",
	["calendar-minus-2"] = "rbxassetid://98846170279891",
	["calendar-minus"] = "rbxassetid://137354318924383",
	["calendar-off"] = "rbxassetid://109726151749217",
	["calendar-plus-2"] = "rbxassetid://112264562093883",
	["calendar-plus"] = "rbxassetid://125266115249843",
	["calendar-range"] = "rbxassetid://103641849247576",
	["calendar-search"] = "rbxassetid://92010083223634",
	["calendar-sync"] = "rbxassetid://78082218499697",
	["calendar-x-2"] = "rbxassetid://107518051061147",
	["calendar-x"] = "rbxassetid://106703374806500",
	["calendar"] = "rbxassetid://114792700814035",
	["camera-off"] = "rbxassetid://81057636835256",
	["camera"] = "rbxassetid://79950339943067",
	["candy-cane"] = "rbxassetid://71689468772492",
	["candy-off"] = "rbxassetid://110232752314832",
	["candy"] = "rbxassetid://107812129154678",
	["cannabis"] = "rbxassetid://98792006538601",
	["captions-off"] = "rbxassetid://105223545364193",
	["captions"] = "rbxassetid://104960225031445",
	["car-front"] = "rbxassetid://87380942739063",
	["car-taxi-front"] = "rbxassetid://122455403384057",
	["car"] = "rbxassetid://121065933462582",
	["caravan"] = "rbxassetid://120070979471783",
	["card-sim"] = "rbxassetid://134490550095771",
	["carrot"] = "rbxassetid://119118221444304",
	["case-lower"] = "rbxassetid://129303130603241",
	["case-sensitive"] = "rbxassetid://125410273293056",
	["case-upper"] = "rbxassetid://111633433531325",
	["cassette-tape"] = "rbxassetid://137065788934157",
	["cast"] = "rbxassetid://98202245922071",
	["castle"] = "rbxassetid://119275077187784",
	["cat"] = "rbxassetid://124252153404931",
	["cctv"] = "rbxassetid://99979894766624",
	["chart-area"] = "rbxassetid://123446436762366",
	["chart-bar-big"] = "rbxassetid://72336824986044",
	["chart-bar-decreasing"] = "rbxassetid://107217459044963",
	["chart-bar-increasing"] = "rbxassetid://88268905998571",
	["chart-bar-stacked"] = "rbxassetid://98478751113024",
	["chart-bar"] = "rbxassetid://105389816384108",
	["chart-candlestick"] = "rbxassetid://125676898615697",
	["chart-column-big"] = "rbxassetid://98598733210787",
	["chart-column-decreasing"] = "rbxassetid://73586137373563",
	["chart-column-increasing"] = "rbxassetid://120421615068601",
	["chart-column-stacked"] = "rbxassetid://86031449675105",
	["chart-column"] = "rbxassetid://97915995538580",
	["chart-gantt"] = "rbxassetid://88811660555940",
	["chart-line"] = "rbxassetid://101833156055618",
	["chart-network"] = "rbxassetid://104027882693561",
	["chart-no-axes-column-decreasing"] = "rbxassetid://123371717192542",
	["chart-no-axes-column-increasing"] = "rbxassetid://140383830943049",
	["chart-no-axes-column"] = "rbxassetid://94078751170351",
	["chart-no-axes-combined"] = "rbxassetid://121424233161912",
	["chart-no-axes-gantt"] = "rbxassetid://131936541106368",
	["chart-pie"] = "rbxassetid://113412261630136",
	["chart-scatter"] = "rbxassetid://108217585014571",
	["chart-spline"] = "rbxassetid://90307460742494",
	["check-check"] = "rbxassetid://95183312173858",
	["check-line"] = "rbxassetid://115122343485290",
	["check"] = "rbxassetid://93898873302694",
	["chef-hat"] = "rbxassetid://121744015002573",
	["cherry"] = "rbxassetid://139519182403183",
	["chess-bishop"] = "rbxassetid://121701705580238",
	["chess-king"] = "rbxassetid://90885687223462",
	["chess-knight"] = "rbxassetid://96467707042169",
	["chess-pawn"] = "rbxassetid://111318574652751",
	["chess-queen"] = "rbxassetid://98304702099749",
	["chess-rook"] = "rbxassetid://76223925830262",
	["chevron-down"] = "rbxassetid://134243273101015",
	["chevron-first"] = "rbxassetid://105243363790238",
	["chevron-last"] = "rbxassetid://89268452603731",
	["chevron-left"] = "rbxassetid://73780377692148",
	["chevron-right"] = "rbxassetid://92473583511724",
	["chevron-up"] = "rbxassetid://122444883127455",
	["chevrons-down-up"] = "rbxassetid://139404716013205",
	["chevrons-down"] = "rbxassetid://100524612205956",
	["chevrons-left-right-ellipsis"] = "rbxassetid://125035817741526",
	["chevrons-left-right"] = "rbxassetid://87910685945204",
	["chevrons-left"] = "rbxassetid://82617201744347",
	["chevrons-right-left"] = "rbxassetid://87149546686569",
	["chevrons-right"] = "rbxassetid://139121276490483",
	["chevrons-up-down"] = "rbxassetid://131833120209646",
	["chevrons-up"] = "rbxassetid://100467452364672",
	["chromium"] = "rbxassetid://128165143739006",
	["church"] = "rbxassetid://113714744350666",
	["cigarette-off"] = "rbxassetid://77797883078452",
	["circle-alert"] = "rbxassetid://83898160590116",
	["circle-arrow-down"] = "rbxassetid://95901860261344",
	["circle-arrow-left"] = "rbxassetid://102148876968988",
	["circle-arrow-out-down-left"] = "rbxassetid://140598097856694",
	["circle-arrow-out-down-right"] = "rbxassetid://119952801379305",
	["circle-arrow-out-up-left"] = "rbxassetid://132858212688303",
	["circle-arrow-out-up-right"] = "rbxassetid://81783743753173",
	["circle-arrow-right"] = "rbxassetid://70786767999559",
	["circle-arrow-up"] = "rbxassetid://84395128546494",
	["circle-check-big"] = "rbxassetid://93202927221730",
	["circle-check"] = "rbxassetid://85262178816537",
	["circle-chevron-down"] = "rbxassetid://137069490345718",
	["circle-chevron-left"] = "rbxassetid://130250009740827",
	["circle-chevron-right"] = "rbxassetid://125943696958495",
	["circle-chevron-up"] = "rbxassetid://111223574026321",
	["circle-dashed"] = "rbxassetid://126799443883746",
	["circle-divide"] = "rbxassetid://106398997754208",
	["circle-dollar-sign"] = "rbxassetid://91106238890387",
	["circle-dot-dashed"] = "rbxassetid://111451232827180",
	["circle-dot"] = "rbxassetid://82947033619201",
	["circle-ellipsis"] = "rbxassetid://91687150884779",
	["circle-equal"] = "rbxassetid://95133963751438",
	["circle-fading-arrow-up"] = "rbxassetid://104648212910336",
	["circle-fading-plus"] = "rbxassetid://91847890443490",
	["circle-gauge"] = "rbxassetid://108157549473765",
	["circle-minus"] = "rbxassetid://133556159576809",
	["circle-off"] = "rbxassetid://97923456918886",
	["circle-parking-off"] = "rbxassetid://128369410981252",
	["circle-parking"] = "rbxassetid://124034962915196",
	["circle-pause"] = "rbxassetid://139337739700879",
	["circle-percent"] = "rbxassetid://133311912860256",
	["circle-play"] = "rbxassetid://120408917249739",
	["circle-plus"] = "rbxassetid://113157136350384",
	["circle-pound-sterling"] = "rbxassetid://105476153083828",
	["circle-power"] = "rbxassetid://140676030155098",
	["circle-question-mark"] = "rbxassetid://97516698664325",
	["circle-slash-2"] = "rbxassetid://136766902186549",
	["circle-slash"] = "rbxassetid://125206439913049",
	["circle-small"] = "rbxassetid://73685402843600",
	["circle-star"] = "rbxassetid://120318414957104",
	["circle-stop"] = "rbxassetid://87400503942659",
	["circle-user-round"] = "rbxassetid://95489465399880",
	["circle-user"] = "rbxassetid://136220511671311",
	["circle-x"] = "rbxassetid://76821953846248",
	["circle"] = "rbxassetid://130359823580534",
	["circuit-board"] = "rbxassetid://107695264369312",
	["citrus"] = "rbxassetid://139018222976433",
	["clapperboard"] = "rbxassetid://132660667070200",
	["clipboard-check"] = "rbxassetid://92649798577170",
	["clipboard-clock"] = "rbxassetid://123957515687745",
	["clipboard-copy"] = "rbxassetid://125851897718493",
	["clipboard-list"] = "rbxassetid://96460215958908",
	["clipboard-minus"] = "rbxassetid://107968008485671",
	["clipboard-paste"] = "rbxassetid://74382068849983",
	["clipboard-pen-line"] = "rbxassetid://77711589791615",
	["clipboard-pen"] = "rbxassetid://75290966822953",
	["clipboard-plus"] = "rbxassetid://134285318675662",
	["clipboard-type"] = "rbxassetid://89949374318028",
	["clipboard-x"] = "rbxassetid://102222456890103",
	["clipboard"] = "rbxassetid://89601995828423",
	["clock-1"] = "rbxassetid://129363225422045",
	["clock-10"] = "rbxassetid://104332695855541",
	["clock-11"] = "rbxassetid://119023205186105",
	["clock-12"] = "rbxassetid://117789618723068",
	["clock-2"] = "rbxassetid://134710777209413",
	["clock-3"] = "rbxassetid://136385631189327",
	["clock-4"] = "rbxassetid://121808839832144",
	["clock-5"] = "rbxassetid://85082019959457",
	["clock-6"] = "rbxassetid://71009733505593",
	["clock-7"] = "rbxassetid://103111188546225",
	["clock-8"] = "rbxassetid://110059272125337",
	["clock-9"] = "rbxassetid://77610027126437",
	["clock-alert"] = "rbxassetid://97157344465162",
	["clock-arrow-down"] = "rbxassetid://92349314416042",
	["clock-arrow-up"] = "rbxassetid://111484286332629",
	["clock-check"] = "rbxassetid://85231630218857",
	["clock-fading"] = "rbxassetid://93205297285245",
	["clock-plus"] = "rbxassetid://93367709263150",
	["clock"] = "rbxassetid://121808839832144",
	["closed-caption"] = "rbxassetid://99832644030788",
	["cloud-alert"] = "rbxassetid://91967273658626",
	["cloud-check"] = "rbxassetid://97318598202432",
	["cloud-cog"] = "rbxassetid://96497764065749",
	["cloud-download"] = "rbxassetid://121435581993566",
	["cloud-drizzle"] = "rbxassetid://139525315752605",
	["cloud-fog"] = "rbxassetid://76650233148776",
	["cloud-hail"] = "rbxassetid://72320462748242",
	["cloud-lightning"] = "rbxassetid://133517088924849",
	["cloud-moon-rain"] = "rbxassetid://127667837827018",
	["cloud-moon"] = "rbxassetid://71938114737914",
	["cloud-off"] = "rbxassetid://131907154501444",
	["cloud-rain-wind"] = "rbxassetid://107414583736721",
	["cloud-rain"] = "rbxassetid://105547081967408",
	["cloud-snow"] = "rbxassetid://72307126270226",
	["cloud-sun-rain"] = "rbxassetid://99041604425705",
	["cloud-sun"] = "rbxassetid://86114208148727",
	["cloud-upload"] = "rbxassetid://93307473217005",
	["cloud"] = "rbxassetid://121226497050352",
	["cloudy"] = "rbxassetid://105360479023346",
	["clover"] = "rbxassetid://74925550436750",
	["club"] = "rbxassetid://108490365816628",
	["code-xml"] = "rbxassetid://130150477351734",
	["code"] = "rbxassetid://107380207681249",
	["codepen"] = "rbxassetid://135643965971885",
	["codesandbox"] = "rbxassetid://106911852964823",
	["coffee"] = "rbxassetid://106864403231093",
	["cog"] = "rbxassetid://116544501716299",
	["coins"] = "rbxassetid://116510979641930",
	["columns-2"] = "rbxassetid://113004100221850",
	["columns-3-cog"] = "rbxassetid://121589691981064",
	["columns-3"] = "rbxassetid://115223357399375",
	["columns-4"] = "rbxassetid://130807991968419",
	["combine"] = "rbxassetid://79908476334048",
	["command"] = "rbxassetid://93648221906330",
	["compass"] = "rbxassetid://115123411028382",
	["component"] = "rbxassetid://110027788875080",
	["computer"] = "rbxassetid://77480056459407",
	["concierge-bell"] = "rbxassetid://140384259310436",
	["cone"] = "rbxassetid://97759550688437",
	["construction"] = "rbxassetid://106539489968173",
	["contact-round"] = "rbxassetid://71907624112229",
	["contact"] = "rbxassetid://75868297719012",
	["container"] = "rbxassetid://91507237573499",
	["contrast"] = "rbxassetid://112796643981497",
	["cookie"] = "rbxassetid://73159504540002",
	["cooking-pot"] = "rbxassetid://94959783129799",
	["copy-check"] = "rbxassetid://91177247988892",
	["copy-minus"] = "rbxassetid://109524509933035",
	["copy-plus"] = "rbxassetid://113618379616952",
	["copy-slash"] = "rbxassetid://93805787810390",
	["copy-x"] = "rbxassetid://106557557978061",
	["copy"] = "rbxassetid://78979572434545",
	["copyleft"] = "rbxassetid://78559055698593",
	["copyright"] = "rbxassetid://129433635747111",
	["corner-down-left"] = "rbxassetid://90473561177832",
	["corner-down-right"] = "rbxassetid://86512767702085",
	["corner-left-down"] = "rbxassetid://139876989150630",
	["corner-left-up"] = "rbxassetid://126228268096099",
	["corner-right-down"] = "rbxassetid://89237035551302",
	["corner-right-up"] = "rbxassetid://112851237026705",
	["corner-up-left"] = "rbxassetid://84669279763024",
	["corner-up-right"] = "rbxassetid://115099889693145",
	["cpu"] = "rbxassetid://77549309870247",
	["creative-commons"] = "rbxassetid://90408210735312",
	["credit-card"] = "rbxassetid://99163352872346",
	["croissant"] = "rbxassetid://130710485559420",
	["crop"] = "rbxassetid://116344601101413",
	["cross"] = "rbxassetid://101833377863588",
	["crosshair"] = "rbxassetid://134242818164054",
	["crown"] = "rbxassetid://127843403295538",
	["cuboid"] = "rbxassetid://75618807946111",
	["cup-soda"] = "rbxassetid://121098640829562",
	["currency"] = "rbxassetid://90551250119972",
	["cylinder"] = "rbxassetid://90569677179169",
	["dam"] = "rbxassetid://76874486231393",
	["database-backup"] = "rbxassetid://103403210984699",
	["database-zap"] = "rbxassetid://131199921258418",
	["database"] = "rbxassetid://126791525623846",
	["decimals-arrow-left"] = "rbxassetid://120198500638749",
	["decimals-arrow-right"] = "rbxassetid://118263047146797",
	["delete"] = "rbxassetid://126279426372342",
	["dessert"] = "rbxassetid://71508133278830",
	["diameter"] = "rbxassetid://97429051503783",
	["diamond-minus"] = "rbxassetid://128989071438290",
	["diamond-percent"] = "rbxassetid://107717860105959",
	["diamond-plus"] = "rbxassetid://134701163723675",
	["diamond"] = "rbxassetid://105846996304890",
	["dice-1"] = "rbxassetid://112650149591038",
	["dice-2"] = "rbxassetid://112278274566793",
	["dice-3"] = "rbxassetid://118526270626312",
	["dice-4"] = "rbxassetid://113365650364004",
	["dice-5"] = "rbxassetid://72768312430593",
	["dice-6"] = "rbxassetid://85376239182543",
	["dices"] = "rbxassetid://81268120302865",
	["diff"] = "rbxassetid://135052708609715",
	["disc-2"] = "rbxassetid://91419420404185",
	["disc-3"] = "rbxassetid://135470554736048",
	["disc-album"] = "rbxassetid://74693460404344",
	["disc"] = "rbxassetid://101908120120777",
	["divide"] = "rbxassetid://136678191878278",
	["dna-off"] = "rbxassetid://89612426361540",
	["dna"] = "rbxassetid://74007982981741",
	["dock"] = "rbxassetid://121997427160252",
	["dog"] = "rbxassetid://71920105558570",
	["dollar-sign"] = "rbxassetid://127320961224019",
	["donut"] = "rbxassetid://72204922742657",
	["door-closed-locked"] = "rbxassetid://74027613267551",
	["door-closed"] = "rbxassetid://136249099949073",
	["door-open"] = "rbxassetid://91306356501736",
	["dot"] = "rbxassetid://137321056643916",
	["download"] = "rbxassetid://134814648082393",
	["drafting-compass"] = "rbxassetid://99701976182841",
	["drama"] = "rbxassetid://110297795801577",
	["dribbble"] = "rbxassetid://80231809663849",
	["drill"] = "rbxassetid://108644821412796",
	["drone"] = "rbxassetid://117299095794783",
	["droplet-off"] = "rbxassetid://119365002225172",
	["droplet"] = "rbxassetid://100597455015098",
	["droplets"] = "rbxassetid://140111846025180",
	["drum"] = "rbxassetid://136979060344890",
	["drumstick"] = "rbxassetid://104662462521709",
	["dumbbell"] = "rbxassetid://80277236776212",
	["ear-off"] = "rbxassetid://87421916192807",
	["ear"] = "rbxassetid://121894949934209",
	["earth-lock"] = "rbxassetid://88814147073745",
	["earth"] = "rbxassetid://76231597751076",
	["eclipse"] = "rbxassetid://114829622118222",
	["egg-fried"] = "rbxassetid://90622538210545",
	["egg-off"] = "rbxassetid://92288321309285",
	["egg"] = "rbxassetid://117851493400222",
	["ellipsis-vertical"] = "rbxassetid://117978708573781",
	["ellipsis"] = "rbxassetid://140019550645825",
	["equal-approximately"] = "rbxassetid://105382689698323",
	["equal-not"] = "rbxassetid://76864449458032",
	["equal"] = "rbxassetid://123467780715624",
	["eraser"] = "rbxassetid://133957773112410",
	["ethernet-port"] = "rbxassetid://75391715149314",
	["euro"] = "rbxassetid://72229646524456",
	["ev-charger"] = "rbxassetid://97906158859623",
	["expand"] = "rbxassetid://137492887754537",
	["external-link"] = "rbxassetid://129331830773832",
	["eye-closed"] = "rbxassetid://111063268625789",
	["eye-off"] = "rbxassetid://135928786788378",
	["eye"] = "rbxassetid://100033680381365",
	["facebook"] = "rbxassetid://72098528632192",
	["factory"] = "rbxassetid://102170024318039",
	["fan"] = "rbxassetid://78391400440696",
	["fast-forward"] = "rbxassetid://121615540167909",
	["feather"] = "rbxassetid://91872927606406",
	["fence"] = "rbxassetid://123451565578029",
	["ferris-wheel"] = "rbxassetid://79729205796176",
	["figma"] = "rbxassetid://134182122852301",
	["file-archive"] = "rbxassetid://77018106869967",
	["file-axis-3d"] = "rbxassetid://133912328009885",
	["file-badge"] = "rbxassetid://74564895394477",
	["file-box"] = "rbxassetid://119264004071690",
	["file-braces-corner"] = "rbxassetid://77253337986109",
	["file-braces"] = "rbxassetid://95314128621234",
	["file-chart-column-increasing"] = "rbxassetid://134449481172067",
	["file-chart-column"] = "rbxassetid://82048481252560",
	["file-chart-line"] = "rbxassetid://71954360551345",
	["file-chart-pie"] = "rbxassetid://81072193564497",
	["file-check-corner"] = "rbxassetid://76295552859171",
	["file-check"] = "rbxassetid://82604001452455",
	["file-clock"] = "rbxassetid://102325208830990",
	["file-code-corner"] = "rbxassetid://78293841184371",
	["file-code"] = "rbxassetid://130978036895504",
	["file-cog"] = "rbxassetid://101385347151368",
	["file-diff"] = "rbxassetid://96147216772241",
	["file-digit"] = "rbxassetid://89220220354580",
	["file-down"] = "rbxassetid://120650154178290",
	["file-exclamation-point"] = "rbxassetid://102821865889635",
	["file-headphone"] = "rbxassetid://100533735901986",
	["file-heart"] = "rbxassetid://132214916401696",
	["file-image"] = "rbxassetid://123334057511782",
	["file-input"] = "rbxassetid://124728604166044",
	["file-key"] = "rbxassetid://118790255921100",
	["file-lock"] = "rbxassetid://72170228691242",
	["file-minus-corner"] = "rbxassetid://119263271735124",
	["file-minus"] = "rbxassetid://111014798459222",
	["file-music"] = "rbxassetid://134948051536671",
	["file-output"] = "rbxassetid://92146832572911",
	["file-pen-line"] = "rbxassetid://104622936345006",
	["file-pen"] = "rbxassetid://79556179730240",
	["file-play"] = "rbxassetid://89006821567838",
	["file-plus-corner"] = "rbxassetid://76544604043974",
	["file-plus"] = "rbxassetid://78881710800060",
	["file-question-mark"] = "rbxassetid://127617422859576",
	["file-scan"] = "rbxassetid://129480105228213",
	["file-search-corner"] = "rbxassetid://90974165234008",
	["file-search"] = "rbxassetid://97780235974933",
	["file-signal"] = "rbxassetid://122070252538165",
	["file-sliders"] = "rbxassetid://85787771732439",
	["file-spreadsheet"] = "rbxassetid://134501869359270",
	["file-stack"] = "rbxassetid://138929929862605",
	["file-symlink"] = "rbxassetid://91865722036510",
	["file-terminal"] = "rbxassetid://116757454755476",
	["file-text"] = "rbxassetid://90496405707281",
	["file-type-corner"] = "rbxassetid://124902230275209",
	["file-type"] = "rbxassetid://115272552799361",
	["file-up"] = "rbxassetid://131173039312748",
	["file-user"] = "rbxassetid://99552018455009",
	["file-video-camera"] = "rbxassetid://81719056173960",
	["file-volume"] = "rbxassetid://111264764438958",
	["file-x-corner"] = "rbxassetid://87554136773609",
	["file-x"] = "rbxassetid://107333775515154",
	["file"] = "rbxassetid://74748492079329",
	["files"] = "rbxassetid://102806336233202",
	["film"] = "rbxassetid://120978945609706",
	["fingerprint"] = "rbxassetid://112173305232811",
	["fire-extinguisher"] = "rbxassetid://111643493006960",
	["fish-off"] = "rbxassetid://89756724887508",
	["fish-symbol"] = "rbxassetid://118475177681618",
	["fish"] = "rbxassetid://124360663785796",
	["flag-off"] = "rbxassetid://112944528856799",
	["flag-triangle-left"] = "rbxassetid://88045221285272",
	["flag-triangle-right"] = "rbxassetid://108292480304566",
	["flag"] = "rbxassetid://78183383236196",
	["flame-kindling"] = "rbxassetid://139728976917928",
	["flame"] = "rbxassetid://98218034436456",
	["flashlight-off"] = "rbxassetid://79780362871740",
	["flashlight"] = "rbxassetid://100286985600444",
	["flask-conical-off"] = "rbxassetid://112597970025298",
	["flask-conical"] = "rbxassetid://128406680901165",
	["flask-round"] = "rbxassetid://127508287324940",
	["flip-horizontal-2"] = "rbxassetid://103726993598186",
	["flip-horizontal"] = "rbxassetid://122937530107837",
	["flip-vertical-2"] = "rbxassetid://103836358956328",
	["flip-vertical"] = "rbxassetid://108003917346888",
	["flower-2"] = "rbxassetid://72934574245145",
	["flower"] = "rbxassetid://86129438272762",
	["focus"] = "rbxassetid://87493973153317",
	["fold-horizontal"] = "rbxassetid://92835712442240",
	["fold-vertical"] = "rbxassetid://108873727253656",
	["folder-archive"] = "rbxassetid://97312009460206",
	["folder-check"] = "rbxassetid://128492920904557",
	["folder-clock"] = "rbxassetid://111964836738545",
	["folder-closed"] = "rbxassetid://118286209350843",
	["folder-code"] = "rbxassetid://70624096349370",
	["folder-cog"] = "rbxassetid://85299519462846",
	["folder-dot"] = "rbxassetid://138687772725278",
	["folder-down"] = "rbxassetid://118044108459225",
	["folder-git-2"] = "rbxassetid://101394054141166",
	["folder-git"] = "rbxassetid://121885778095158",
	["folder-heart"] = "rbxassetid://79104747211105",
	["folder-input"] = "rbxassetid://90699920697871",
	["folder-kanban"] = "rbxassetid://78313285104072",
	["folder-key"] = "rbxassetid://85270407596791",
	["folder-lock"] = "rbxassetid://119201572260567",
	["folder-minus"] = "rbxassetid://85648718999010",
	["folder-open-dot"] = "rbxassetid://74741494767354",
	["folder-open"] = "rbxassetid://76018996254888",
	["folder-output"] = "rbxassetid://101532447937612",
	["folder-pen"] = "rbxassetid://112770491173911",
	["folder-plus"] = "rbxassetid://91865663406119",
	["folder-root"] = "rbxassetid://103333751154693",
	["folder-search-2"] = "rbxassetid://71276453442655",
	["folder-search"] = "rbxassetid://110568075123861",
	["folder-symlink"] = "rbxassetid://127485747227189",
	["folder-sync"] = "rbxassetid://91544602659796",
	["folder-tree"] = "rbxassetid://85577554337861",
	["folder-up"] = "rbxassetid://72008269765857",
	["folder-x"] = "rbxassetid://91699618247635",
	["folder"] = "rbxassetid://80846616596607",
	["folders"] = "rbxassetid://110351216219061",
	["footprints"] = "rbxassetid://139192589041315",
	["forklift"] = "rbxassetid://72030930983101",
	["forward"] = "rbxassetid://97545944739523",
	["frame"] = "rbxassetid://109080612832751",
	["framer"] = "rbxassetid://108384807262391",
	["frown"] = "rbxassetid://124407301067982",
	["fuel"] = "rbxassetid://106447647274511",
	["fullscreen"] = "rbxassetid://77793665526178",
	["funnel-plus"] = "rbxassetid://100780233821928",
	["funnel-x"] = "rbxassetid://70984385812555",
	["funnel"] = "rbxassetid://108829540827529",
	["gallery-horizontal-end"] = "rbxassetid://74672430161161",
	["gallery-horizontal"] = "rbxassetid://80004001442122",
	["gallery-thumbnails"] = "rbxassetid://136219289862706",
	["gallery-vertical-end"] = "rbxassetid://106461402088317",
	["gallery-vertical"] = "rbxassetid://119299431466725",
	["gamepad-2"] = "rbxassetid://92483947987410",
	["gamepad-directional"] = "rbxassetid://84342305212226",
	["gamepad"] = "rbxassetid://121607283959010",
	["gauge"] = "rbxassetid://110273524101447",
	["gavel"] = "rbxassetid://78952298198456",
	["gem"] = "rbxassetid://112904952151156",
	["georgian-lari"] = "rbxassetid://98084432591687",
	["ghost"] = "rbxassetid://113822048130017",
	["gift"] = "rbxassetid://109855212076373",
	["git-branch-minus"] = "rbxassetid://97385010649411",
	["git-branch-plus"] = "rbxassetid://125944221134316",
	["git-branch"] = "rbxassetid://90490195516649",
	["git-commit-horizontal"] = "rbxassetid://133646041800147",
	["git-commit-vertical"] = "rbxassetid://122098032990350",
	["git-compare-arrows"] = "rbxassetid://84874426520216",
	["git-compare"] = "rbxassetid://91945124438792",
	["git-fork"] = "rbxassetid://89954992404765",
	["git-graph"] = "rbxassetid://86166832019304",
	["git-merge"] = "rbxassetid://131833355158059",
	["git-pull-request-arrow"] = "rbxassetid://94507974577439",
	["git-pull-request-closed"] = "rbxassetid://78070600389091",
	["git-pull-request-create-arrow"] = "rbxassetid://127422677061091",
	["git-pull-request-create"] = "rbxassetid://105929577383926",
	["git-pull-request-draft"] = "rbxassetid://76173459869943",
	["git-pull-request"] = "rbxassetid://138463010991471",
	["github"] = "rbxassetid://120349554354380",
	["gitlab"] = "rbxassetid://114054627192933",
	["glass-water"] = "rbxassetid://115526102400988",
	["glasses"] = "rbxassetid://87936407455373",
	["globe-lock"] = "rbxassetid://134065526704402",
	["globe"] = "rbxassetid://114238209622913",
	["goal"] = "rbxassetid://120517954878160",
	["gpu"] = "rbxassetid://95577823614219",
	["graduation-cap"] = "rbxassetid://93771896340220",
	["grape"] = "rbxassetid://134760640415561",
	["grid-2x2-check"] = "rbxassetid://138468840220821",
	["grid-2x2-plus"] = "rbxassetid://91811610580247",
	["grid-2x2-x"] = "rbxassetid://72407303981388",
	["grid-2x2"] = "rbxassetid://99050491897640",
	["grid-3x2"] = "rbxassetid://95528684210010",
	["grid-3x3"] = "rbxassetid://70419024781206",
	["grip-horizontal"] = "rbxassetid://136255899715930",
	["grip-vertical"] = "rbxassetid://137183678565296",
	["grip"] = "rbxassetid://109058783556768",
	["group"] = "rbxassetid://107643418926671",
	["guitar"] = "rbxassetid://75915531867926",
	["ham"] = "rbxassetid://74465607934635",
	["hamburger"] = "rbxassetid://93086916815495",
	["hammer"] = "rbxassetid://83545120140895",
	["hand-coins"] = "rbxassetid://126990543175462",
	["hand-fist"] = "rbxassetid://83341608917591",
	["hand-grab"] = "rbxassetid://88867162163985",
	["hand-heart"] = "rbxassetid://117507367668412",
	["hand-helping"] = "rbxassetid://89897738419446",
	["hand-metal"] = "rbxassetid://113619498548713",
	["hand-platter"] = "rbxassetid://88594727743168",
	["hand"] = "rbxassetid://130703864968637",
	["handbag"] = "rbxassetid://135675846264061",
	["handshake"] = "rbxassetid://78442115255814",
	["hard-drive-download"] = "rbxassetid://73913801230614",
	["hard-drive-upload"] = "rbxassetid://85762133615118",
	["hard-drive"] = "rbxassetid://88183305858463",
	["hard-hat"] = "rbxassetid://128050846767382",
	["hash"] = "rbxassetid://82890331678520",
	["hat-glasses"] = "rbxassetid://101165538224815",
	["haze"] = "rbxassetid://108857561768901",
	["hdmi-port"] = "rbxassetid://103693661037020",
	["heading-1"] = "rbxassetid://118129315662110",
	["heading-2"] = "rbxassetid://110209069670094",
	["heading-3"] = "rbxassetid://90267885237062",
	["heading-4"] = "rbxassetid://129625620307602",
	["heading-5"] = "rbxassetid://120386663181267",
	["heading-6"] = "rbxassetid://90959079775093",
	["heading"] = "rbxassetid://129254312067735",
	["headphone-off"] = "rbxassetid://85038251615641",
	["headphones"] = "rbxassetid://118833729589183",
	["headset"] = "rbxassetid://129269236787694",
	["heart-crack"] = "rbxassetid://110987638564119",
	["heart-handshake"] = "rbxassetid://111483078692002",
	["heart-minus"] = "rbxassetid://96827380163326",
	["heart-off"] = "rbxassetid://89748414415617",
	["heart-plus"] = "rbxassetid://94877796283249",
	["heart-pulse"] = "rbxassetid://129352925579546",
	["heart"] = "rbxassetid://116559368303288",
	["heater"] = "rbxassetid://140478466880916",
	["helicopter"] = "rbxassetid://111557171735930",
	["hexagon"] = "rbxassetid://127592089339199",
	["highlighter"] = "rbxassetid://77411555641113",
	["history"] = "rbxassetid://123980022019922",
	["hop-off"] = "rbxassetid://103386036934034",
	["hop"] = "rbxassetid://82778923997672",
	["hospital"] = "rbxassetid://105868763850707",
	["hotel"] = "rbxassetid://132283390859718",
	["hourglass"] = "rbxassetid://86160434939203",
	["house-heart"] = "rbxassetid://136054771868597",
	["house-plug"] = "rbxassetid://71438263712075",
	["house-plus"] = "rbxassetid://118495165208309",
	["house-wifi"] = "rbxassetid://126495519725698",
	["house"] = "rbxassetid://98755624629571",
	["ice-cream-bowl"] = "rbxassetid://124867218454386",
	["ice-cream-cone"] = "rbxassetid://90751397288639",
	["id-card-lanyard"] = "rbxassetid://90761480469224",
	["id-card"] = "rbxassetid://75354294622640",
	["image-down"] = "rbxassetid://78972295741235",
	["image-minus"] = "rbxassetid://101066016918565",
	["image-off"] = "rbxassetid://81934811700938",
	["image-play"] = "rbxassetid://129501806784210",
	["image-plus"] = "rbxassetid://70391970623917",
	["image-up"] = "rbxassetid://126610009605241",
	["image-upscale"] = "rbxassetid://106963545024679",
	["images"] = "rbxassetid://79350649395557",
	["import"] = "rbxassetid://116545008906029",
	["inbox"] = "rbxassetid://112591360302868",
	["indian-rupee"] = "rbxassetid://113038778381805",
	["infinity"] = "rbxassetid://98083086936965",
	["info"] = "rbxassetid://124560466474914",
	["inspection-panel"] = "rbxassetid://70905313146088",
	["instagram"] = "rbxassetid://119864798614855",
	["italic"] = "rbxassetid://96220378864282",
	["iteration-ccw"] = "rbxassetid://140221832794083",
	["iteration-cw"] = "rbxassetid://95534489554662",
	["japanese-yen"] = "rbxassetid://106362863465813",
	["joystick"] = "rbxassetid://99416790224739",
	["kanban"] = "rbxassetid://125934100055431",
	["kayak"] = "rbxassetid://136107544609389",
	["key-round"] = "rbxassetid://83619031955390",
	["key-square"] = "rbxassetid://94621420033649",
	["key"] = "rbxassetid://96510194465420",
	["keyboard-music"] = "rbxassetid://121058541758636",
	["keyboard-off"] = "rbxassetid://92466375369772",
	["keyboard"] = "rbxassetid://121474456068237",
	["lamp-ceiling"] = "rbxassetid://80032758469141",
	["lamp-desk"] = "rbxassetid://85290686983238",
	["lamp-floor"] = "rbxassetid://104585881375892",
	["lamp-wall-down"] = "rbxassetid://91271394132073",
	["lamp-wall-up"] = "rbxassetid://132141464337445",
	["lamp"] = "rbxassetid://110730830653382",
	["land-plot"] = "rbxassetid://96449039620294",
	["landmark"] = "rbxassetid://76885079756393",
	["languages"] = "rbxassetid://90816903776498",
	["laptop-minimal-check"] = "rbxassetid://114352019833865",
	["laptop-minimal"] = "rbxassetid://136705765566068",
	["laptop"] = "rbxassetid://111387063244975",
	["lasso-select"] = "rbxassetid://105609719912753",
	["lasso"] = "rbxassetid://121072936884007",
	["laugh"] = "rbxassetid://104491311361166",
	["layers-2"] = "rbxassetid://70536710516357",
	["layers"] = "rbxassetid://81973586053257",
	["layout-dashboard"] = "rbxassetid://139929981863901",
	["layout-grid"] = "rbxassetid://81344910161871",
	["layout-list"] = "rbxassetid://87462136296578",
	["layout-panel-left"] = "rbxassetid://125092469751491",
	["layout-panel-top"] = "rbxassetid://91943941515944",
	["layout-template"] = "rbxassetid://115564446417985",
	["leaf"] = "rbxassetid://119951075637174",
	["leafy-green"] = "rbxassetid://105146290493154",
	["lectern"] = "rbxassetid://106166425183862",
	["library-big"] = "rbxassetid://106794530191412",
	["library"] = "rbxassetid://114334671982047",
	["life-buoy"] = "rbxassetid://81168450671956",
	["ligature"] = "rbxassetid://111397873269411",
	["lightbulb-off"] = "rbxassetid://83795722296178",
	["lightbulb"] = "rbxassetid://103871245626488",
	["line-squiggle"] = "rbxassetid://109555164424447",
	["link-2-off"] = "rbxassetid://76885956296867",
	["link-2"] = "rbxassetid://86072351557466",
	["link"] = "rbxassetid://131607023382430",
	["linkedin"] = "rbxassetid://132842789255788",
	["list-check"] = "rbxassetid://72374358471156",
	["list-checks"] = "rbxassetid://99809353635593",
	["list-chevrons-down-up"] = "rbxassetid://137409641500711",
	["list-chevrons-up-down"] = "rbxassetid://81825351389084",
	["list-collapse"] = "rbxassetid://124505247702401",
	["list-end"] = "rbxassetid://77650610048119",
	["list-filter-plus"] = "rbxassetid://96385120752336",
	["list-filter"] = "rbxassetid://103321376129527",
	["list-indent-decrease"] = "rbxassetid://137879979228193",
	["list-indent-increase"] = "rbxassetid://79051053161201",
	["list-minus"] = "rbxassetid://138507965142671",
	["list-music"] = "rbxassetid://126380635781840",
	["list-ordered"] = "rbxassetid://83212528113913",
	["list-plus"] = "rbxassetid://112384738137814",
	["list-restart"] = "rbxassetid://91703153577421",
	["list-start"] = "rbxassetid://84828348299727",
	["list-todo"] = "rbxassetid://132980603752108",
	["list-tree"] = "rbxassetid://97685396239010",
	["list-video"] = "rbxassetid://93648525452489",
	["list-x"] = "rbxassetid://113025303988861",
	["list"] = "rbxassetid://113179976918783",
	["loader-circle"] = "rbxassetid://116535712789945",
	["loader-pinwheel"] = "rbxassetid://108513357940900",
	["loader"] = "rbxassetid://78408734580845",
	["locate-fixed"] = "rbxassetid://137367361548433",
	["locate-off"] = "rbxassetid://73729216338137",
	["locate"] = "rbxassetid://84467676590391",
	["lock-keyhole-open"] = "rbxassetid://110863509313073",
	["lock-keyhole"] = "rbxassetid://78672912777756",
	["lock-open"] = "rbxassetid://93597915325122",
	["lock"] = "rbxassetid://134724289526879",
	["log-in"] = "rbxassetid://103768533135201",
	["log-out"] = "rbxassetid://84895399304975",
	["logs"] = "rbxassetid://89772091251787",
	["lollipop"] = "rbxassetid://84681611583044",
	["luggage"] = "rbxassetid://76619236486400",
	["magnet"] = "rbxassetid://135162361226972",
	["mail-check"] = "rbxassetid://86921536259917",
	["mail-minus"] = "rbxassetid://81989813236553",
	["mail-open"] = "rbxassetid://122785416858638",
	["mail-plus"] = "rbxassetid://104886401588341",
	["mail-question-mark"] = "rbxassetid://126540170949819",
	["mail-search"] = "rbxassetid://135616173775287",
	["mail-warning"] = "rbxassetid://81495303676089",
	["mail-x"] = "rbxassetid://74607841705644",
	["mail"] = "rbxassetid://103945161245599",
	["mailbox"] = "rbxassetid://82765503320335",
	["mails"] = "rbxassetid://90673453450080",
	["map-minus"] = "rbxassetid://129525760577747",
	["map-pin-check-inside"] = "rbxassetid://107130529843809",
	["map-pin-check"] = "rbxassetid://118110914690154",
	["map-pin-house"] = "rbxassetid://80546885029816",
	["map-pin-minus-inside"] = "rbxassetid://79005529692964",
	["map-pin-minus"] = "rbxassetid://74518762643623",
	["map-pin-off"] = "rbxassetid://82474689391020",
	["map-pin-pen"] = "rbxassetid://113515395277504",
	["map-pin-plus-inside"] = "rbxassetid://134639656514430",
	["map-pin-plus"] = "rbxassetid://91875228967029",
	["map-pin-x-inside"] = "rbxassetid://126235934252379",
	["map-pin-x"] = "rbxassetid://101085273547316",
	["map-pin"] = "rbxassetid://84279202219901",
	["map-pinned"] = "rbxassetid://103963788475034",
	["map-plus"] = "rbxassetid://129388826743495",
	["map"] = "rbxassetid://95107167260947",
	["mars-stroke"] = "rbxassetid://131973193186828",
	["mars"] = "rbxassetid://111287112372511",
	["martini"] = "rbxassetid://82977695401058",
	["maximize-2"] = "rbxassetid://73085922906397",
	["maximize"] = "rbxassetid://76045941763188",
	["medal"] = "rbxassetid://79016002264450",
	["megaphone-off"] = "rbxassetid://124280774193935",
	["megaphone"] = "rbxassetid://118759541854879",
	["meh"] = "rbxassetid://132197867028557",
	["memory-stick"] = "rbxassetid://93212591343119",
	["menu"] = "rbxassetid://77021539815611",
	["merge"] = "rbxassetid://126201866476775",
	["message-circle-code"] = "rbxassetid://112865244991651",
	["message-circle-dashed"] = "rbxassetid://81525157881897",
	["message-circle-heart"] = "rbxassetid://101990756073677",
	["message-circle-more"] = "rbxassetid://92856823884663",
	["message-circle-off"] = "rbxassetid://134955643890328",
	["message-circle-plus"] = "rbxassetid://106562979649273",
	["message-circle-question-mark"] = "rbxassetid://107700302759934",
	["message-circle-reply"] = "rbxassetid://137071749508334",
	["message-circle-warning"] = "rbxassetid://119020096067894",
	["message-circle-x"] = "rbxassetid://126843387725536",
	["message-circle"] = "rbxassetid://127255077587058",
	["message-square-code"] = "rbxassetid://110968863152123",
	["message-square-dashed"] = "rbxassetid://107653455516238",
	["message-square-diff"] = "rbxassetid://75472190472625",
	["message-square-dot"] = "rbxassetid://127806382463916",
	["message-square-heart"] = "rbxassetid://75612811742074",
	["message-square-lock"] = "rbxassetid://81268215619563",
	["message-square-more"] = "rbxassetid://120139782405970",
	["message-square-off"] = "rbxassetid://99961019005789",
	["message-square-plus"] = "rbxassetid://76934450256199",
	["message-square-quote"] = "rbxassetid://116670768629340",
	["message-square-reply"] = "rbxassetid://130985622754637",
	["message-square-share"] = "rbxassetid://131017005324026",
	["message-square-text"] = "rbxassetid://94899503194205",
	["message-square-warning"] = "rbxassetid://138432903962261",
	["message-square-x"] = "rbxassetid://137285463279462",
	["message-square"] = "rbxassetid://83881670383280",
	["messages-square"] = "rbxassetid://97532166733358",
	["mic-off"] = "rbxassetid://82123034444822",
	["mic-vocal"] = "rbxassetid://99082286164362",
	["mic"] = "rbxassetid://89640799126523",
	["microchip"] = "rbxassetid://73937907669903",
	["microscope"] = "rbxassetid://116875530102782",
	["microwave"] = "rbxassetid://108411735353008",
	["milestone"] = "rbxassetid://101618292325920",
	["milk-off"] = "rbxassetid://72388480962742",
	["milk"] = "rbxassetid://96221903896918",
	["minimize-2"] = "rbxassetid://116269596042539",
	["minimize"] = "rbxassetid://121304296213645",
	["minus"] = "rbxassetid://118026365011536",
	["monitor-check"] = "rbxassetid://86651948439229",
	["monitor-cloud"] = "rbxassetid://85931096038318",
	["monitor-cog"] = "rbxassetid://94345128715799",
	["monitor-dot"] = "rbxassetid://130394010063680",
	["monitor-down"] = "rbxassetid://97466933743423",
	["monitor-off"] = "rbxassetid://74395526657953",
	["monitor-pause"] = "rbxassetid://76002184067562",
	["monitor-play"] = "rbxassetid://133018824306217",
	["monitor-smartphone"] = "rbxassetid://84335680433378",
	["monitor-speaker"] = "rbxassetid://81744810060380",
	["monitor-stop"] = "rbxassetid://98708958984757",
	["monitor-up"] = "rbxassetid://96035360858377",
	["monitor-x"] = "rbxassetid://126265210441423",
	["monitor"] = "rbxassetid://72664649203050",
	["moon-star"] = "rbxassetid://82782200506348",
	["moon"] = "rbxassetid://83380517901735",
	["motorbike"] = "rbxassetid://94580787368233",
	["mountain-snow"] = "rbxassetid://105315495740588",
	["mountain"] = "rbxassetid://73269957566415",
	["mouse-off"] = "rbxassetid://75267871697595",
	["mouse-pointer-2-off"] = "rbxassetid://104701076865632",
	["mouse-pointer-2"] = "rbxassetid://117093892862228",
	["mouse-pointer-ban"] = "rbxassetid://106849413057133",
	["mouse-pointer-click"] = "rbxassetid://107150227368485",
	["mouse-pointer"] = "rbxassetid://72322454962935",
	["mouse"] = "rbxassetid://73096068864710",
	["move-3d"] = "rbxassetid://103365982054003",
	["move-diagonal-2"] = "rbxassetid://117298577948096",
	["move-diagonal"] = "rbxassetid://101433481954184",
	["move-down-left"] = "rbxassetid://102819433534567",
	["move-down-right"] = "rbxassetid://101479760041877",
	["move-down"] = "rbxassetid://70510115135583",
	["move-horizontal"] = "rbxassetid://88513523439149",
	["move-left"] = "rbxassetid://137614740247980",
	["move-right"] = "rbxassetid://132455779472989",
	["move-up-left"] = "rbxassetid://139079815540148",
	["move-up-right"] = "rbxassetid://105885140592646",
	["move-up"] = "rbxassetid://84505444262658",
	["move-vertical"] = "rbxassetid://86234730730899",
	["move"] = "rbxassetid://116138709011735",
	["music-2"] = "rbxassetid://134397426600888",
	["music-3"] = "rbxassetid://94466120066498",
	["music-4"] = "rbxassetid://132459323665838",
	["music"] = "rbxassetid://113343203848535",
	["navigation-2-off"] = "rbxassetid://116569611780763",
	["navigation-2"] = "rbxassetid://81889066747907",
	["navigation-off"] = "rbxassetid://87003270290777",
	["navigation"] = "rbxassetid://79308213542922",
	["network"] = "rbxassetid://127410729922644",
	["newspaper"] = "rbxassetid://123479530460544",
	["nfc"] = "rbxassetid://76822396542242",
	["non-binary"] = "rbxassetid://78442360386235",
	["notebook-pen"] = "rbxassetid://140380614761023",
	["notebook-tabs"] = "rbxassetid://127371085570083",
	["notebook-text"] = "rbxassetid://93061585217270",
	["notebook"] = "rbxassetid://136132108664987",
	["notepad-text-dashed"] = "rbxassetid://135793446376219",
	["notepad-text"] = "rbxassetid://93404682958966",
	["nut-off"] = "rbxassetid://78795397311573",
	["nut"] = "rbxassetid://127146410705656",
	["octagon-alert"] = "rbxassetid://140438367956051",
	["octagon-minus"] = "rbxassetid://74720436795421",
	["octagon-pause"] = "rbxassetid://103161463909039",
	["octagon-x"] = "rbxassetid://90498161006311",
	["octagon"] = "rbxassetid://120803515514852",
	["omega"] = "rbxassetid://70414080018786",
	["option"] = "rbxassetid://100776883894054",
	["orbit"] = "rbxassetid://108926136860562",
	["origami"] = "rbxassetid://136020626667101",
	["package-2"] = "rbxassetid://70394974762575",
	["package-check"] = "rbxassetid://102374216055130",
	["package-minus"] = "rbxassetid://114492858789692",
	["package-open"] = "rbxassetid://132890233237818",
	["package-plus"] = "rbxassetid://129261988138366",
	["package-search"] = "rbxassetid://95465120894145",
	["package-x"] = "rbxassetid://70818501607442",
	["package"] = "rbxassetid://97261141732706",
	["paint-bucket"] = "rbxassetid://124275586663284",
	["paint-roller"] = "rbxassetid://115248074358348",
	["paintbrush-vertical"] = "rbxassetid://105151296591292",
	["paintbrush"] = "rbxassetid://125572663700289",
	["palette"] = "rbxassetid://86350350950064",
	["panda"] = "rbxassetid://132509022802512",
	["panel-bottom-close"] = "rbxassetid://74287004071159",
	["panel-bottom-dashed"] = "rbxassetid://131084651621603",
	["panel-bottom-open"] = "rbxassetid://107768659586540",
	["panel-bottom"] = "rbxassetid://132127145048511",
	["panel-left-close"] = "rbxassetid://126579818823552",
	["panel-left-dashed"] = "rbxassetid://75536606374585",
	["panel-left-open"] = "rbxassetid://111075816195767",
	["panel-left-right-dashed"] = "rbxassetid://110100707973959",
	["panel-left"] = "rbxassetid://97419752870313",
	["panel-right-close"] = "rbxassetid://139528655524132",
	["panel-right-dashed"] = "rbxassetid://94959793877311",
	["panel-right-open"] = "rbxassetid://118114419142794",
	["panel-right"] = "rbxassetid://116365035443156",
	["panel-top-bottom-dashed"] = "rbxassetid://134737235653344",
	["panel-top-close"] = "rbxassetid://83578325777808",
	["panel-top-dashed"] = "rbxassetid://70522913169237",
	["panel-top-open"] = "rbxassetid://137959875507454",
	["panel-top"] = "rbxassetid://75838479462875",
	["panels-left-bottom"] = "rbxassetid://72996856149149",
	["panels-right-bottom"] = "rbxassetid://90659068960726",
	["panels-top-left"] = "rbxassetid://79858853850600",
	["paperclip"] = "rbxassetid://92088291163453",
	["parentheses"] = "rbxassetid://78950955173096",
	["parking-meter"] = "rbxassetid://84652733960568",
	["party-popper"] = "rbxassetid://111626795712193",
	["pause"] = "rbxassetid://74873705394436",
	["paw-print"] = "rbxassetid://112218825427601",
	["pc-case"] = "rbxassetid://122978648019101",
	["pen-line"] = "rbxassetid://109108135755303",
	["pen-off"] = "rbxassetid://84807123119438",
	["pen-tool"] = "rbxassetid://106145404953445",
	["pen"] = "rbxassetid://72037878096321",
	["pencil-line"] = "rbxassetid://88392917053533",
	["pencil-off"] = "rbxassetid://103330927652832",
	["pencil-ruler"] = "rbxassetid://110120288284597",
	["pencil"] = "rbxassetid://137986121120732",
	["pentagon"] = "rbxassetid://79184802179890",
	["percent"] = "rbxassetid://130155041032013",
	["person-standing"] = "rbxassetid://125020872044147",
	["philippine-peso"] = "rbxassetid://91173798254675",
	["phone-call"] = "rbxassetid://70555587592860",
	["phone-forwarded"] = "rbxassetid://113269614319737",
	["phone-incoming"] = "rbxassetid://82863576359288",
	["phone-missed"] = "rbxassetid://130156165198376",
	["phone-off"] = "rbxassetid://133318623553383",
	["phone-outgoing"] = "rbxassetid://104576478735825",
	["phone"] = "rbxassetid://128804946640049",
	["pi"] = "rbxassetid://74936036243146",
	["piano"] = "rbxassetid://85008880789520",
	["pickaxe"] = "rbxassetid://105888023317688",
	["picture-in-picture-2"] = "rbxassetid://112803319544468",
	["picture-in-picture"] = "rbxassetid://80579597835123",
	["piggy-bank"] = "rbxassetid://79498575790721",
	["pilcrow-left"] = "rbxassetid://103803000849583",
	["pilcrow-right"] = "rbxassetid://104881733911870",
	["pilcrow"] = "rbxassetid://139512780392871",
	["pill-bottle"] = "rbxassetid://118394692404597",
	["pill"] = "rbxassetid://73280534813448",
	["pin-off"] = "rbxassetid://127696372451750",
	["pin"] = "rbxassetid://120978111007514",
	["pipette"] = "rbxassetid://133167932934404",
	["pizza"] = "rbxassetid://126964453193501",
	["plane-landing"] = "rbxassetid://122555692211889",
	["plane-takeoff"] = "rbxassetid://117179478829575",
	["plane"] = "rbxassetid://126985561580989",
	["play"] = "rbxassetid://135609604299893",
	["plug-2"] = "rbxassetid://97912386476366",
	["plug-zap"] = "rbxassetid://74506269884055",
	["plug"] = "rbxassetid://99782373064495",
	["plus"] = "rbxassetid://111774323017047",
	["pocket-knife"] = "rbxassetid://134075428063965",
	["pocket"] = "rbxassetid://136686762542964",
	["podcast"] = "rbxassetid://109577075549215",
	["pointer-off"] = "rbxassetid://95488389312794",
	["pointer"] = "rbxassetid://92615117311099",
	["popcorn"] = "rbxassetid://139446511232750",
	["popsicle"] = "rbxassetid://112696318077073",
	["pound-sterling"] = "rbxassetid://127482649469130",
	["power-off"] = "rbxassetid://118768311012214",
	["power"] = "rbxassetid://96479131758775",
	["presentation"] = "rbxassetid://106134583757890",
	["printer-check"] = "rbxassetid://130273549443689",
	["printer"] = "rbxassetid://76080649734247",
	["projector"] = "rbxassetid://103281856385283",
	["proportions"] = "rbxassetid://130046855997237",
	["puzzle"] = "rbxassetid://136837798892463",
	["pyramid"] = "rbxassetid://107811442374127",
	["qr-code"] = "rbxassetid://105329945723350",
	["quote"] = "rbxassetid://103271711590001",
	["rabbit"] = "rbxassetid://98580518804206",
	["radar"] = "rbxassetid://138528222906635",
	["radiation"] = "rbxassetid://104499586848433",
	["radical"] = "rbxassetid://132758286926047",
	["radio-receiver"] = "rbxassetid://129598303378835",
	["radio-tower"] = "rbxassetid://93958663130054",
	["radio"] = "rbxassetid://85611589536956",
	["radius"] = "rbxassetid://89814505307129",
	["rail-symbol"] = "rbxassetid://134295386306962",
	["rainbow"] = "rbxassetid://132488862841895",
	["rat"] = "rbxassetid://127400975953159",
	["ratio"] = "rbxassetid://126369423897295",
	["receipt-cent"] = "rbxassetid://91557573925201",
	["receipt-euro"] = "rbxassetid://94015722210295",
	["receipt-indian-rupee"] = "rbxassetid://89718170439990",
	["receipt-japanese-yen"] = "rbxassetid://132472560758851",
	["receipt-pound-sterling"] = "rbxassetid://73934967569625",
	["receipt-russian-ruble"] = "rbxassetid://105164576936853",
	["receipt-swiss-franc"] = "rbxassetid://72503668620116",
	["receipt-text"] = "rbxassetid://138483536013737",
	["receipt-turkish-lira"] = "rbxassetid://91950765836342",
	["receipt"] = "rbxassetid://77877895901792",
	["rectangle-circle"] = "rbxassetid://100642423153903",
	["rectangle-ellipsis"] = "rbxassetid://112919953980965",
	["rectangle-goggles"] = "rbxassetid://98605436666727",
	["rectangle-horizontal"] = "rbxassetid://90224199814966",
	["rectangle-vertical"] = "rbxassetid://117277050590967",
	["recycle"] = "rbxassetid://140417023381961",
	["redo-2"] = "rbxassetid://70451039017914",
	["redo-dot"] = "rbxassetid://94252981719732",
	["redo"] = "rbxassetid://116150342119054",
	["refresh-ccw-dot"] = "rbxassetid://106702246753270",
	["refresh-ccw"] = "rbxassetid://117913330389477",
	["refresh-cw-off"] = "rbxassetid://140179498843054",
	["refresh-cw"] = "rbxassetid://138133190015277",
	["refrigerator"] = "rbxassetid://102614042652753",
	["regex"] = "rbxassetid://100727200791841",
	["remove-formatting"] = "rbxassetid://112833162022628",
	["repeat-1"] = "rbxassetid://130144534857095",
	["repeat-2"] = "rbxassetid://85927537182704",
	["repeat"] = "rbxassetid://121886242955173",
	["replace-all"] = "rbxassetid://127862728198635",
	["replace"] = "rbxassetid://128404082279430",
	["reply-all"] = "rbxassetid://71723137343562",
	["reply"] = "rbxassetid://109788633497028",
	["rewind"] = "rbxassetid://95205297521988",
	["ribbon"] = "rbxassetid://94265331526851",
	["rocket"] = "rbxassetid://87412317685854",
	["rocking-chair"] = "rbxassetid://110420269495360",
	["roller-coaster"] = "rbxassetid://112426178972099",
	["rose"] = "rbxassetid://126336840238769",
	["rotate-3d"] = "rbxassetid://76300551576392",
	["rotate-ccw-key"] = "rbxassetid://74976035240976",
	["rotate-ccw-square"] = "rbxassetid://90515853170424",
	["rotate-ccw"] = "rbxassetid://110116685948665",
	["rotate-cw-square"] = "rbxassetid://77095448159303",
	["rotate-cw"] = "rbxassetid://84183336178654",
	["route-off"] = "rbxassetid://106350402024079",
	["route"] = "rbxassetid://89968303228953",
	["router"] = "rbxassetid://102130331994471",
	["rows-2"] = "rbxassetid://112556185960101",
	["rows-3"] = "rbxassetid://117215586961375",
	["rows-4"] = "rbxassetid://125646021959055",
	["rss"] = "rbxassetid://131789058984793",
	["ruler-dimension-line"] = "rbxassetid://70673861371412",
	["ruler"] = "rbxassetid://81432445547423",
	["russian-ruble"] = "rbxassetid://126357936542156",
	["sailboat"] = "rbxassetid://87110567187540",
	["salad"] = "rbxassetid://128864507821603",
	["sandwich"] = "rbxassetid://104573187458917",
	["satellite-dish"] = "rbxassetid://136742443888305",
	["satellite"] = "rbxassetid://134967053164645",
	["saudi-riyal"] = "rbxassetid://102282769104635",
	["save-all"] = "rbxassetid://116946975799440",
	["save-off"] = "rbxassetid://87085435778560",
	["save"] = "rbxassetid://126116963775616",
	["scale-3d"] = "rbxassetid://72414199620352",
	["scale"] = "rbxassetid://108203682317477",
	["scaling"] = "rbxassetid://122360365318466",
	["scan-barcode"] = "rbxassetid://96889457154761",
	["scan-eye"] = "rbxassetid://99244790601968",
	["scan-face"] = "rbxassetid://109959345069668",
	["scan-heart"] = "rbxassetid://106280819776142",
	["scan-line"] = "rbxassetid://126544908146540",
	["scan-qr-code"] = "rbxassetid://105409149549927",
	["scan-search"] = "rbxassetid://80009010551347",
	["scan-text"] = "rbxassetid://73702396787766",
	["scan"] = "rbxassetid://123104789658180",
	["school"] = "rbxassetid://76351530290068",
	["scissors-line-dashed"] = "rbxassetid://122237447974173",
	["scissors"] = "rbxassetid://118665510911274",
	["screen-share-off"] = "rbxassetid://107677572669805",
	["screen-share"] = "rbxassetid://85137895705653",
	["scroll-text"] = "rbxassetid://97321022666868",
	["scroll"] = "rbxassetid://74072101474951",
	["search-check"] = "rbxassetid://75442076191356",
	["search-code"] = "rbxassetid://117114794592802",
	["search-slash"] = "rbxassetid://96483932261041",
	["search-x"] = "rbxassetid://137319957522951",
	["search"] = "rbxassetid://121018724060431",
	["section"] = "rbxassetid://91732188298948",
	["send-horizontal"] = "rbxassetid://111734392411664",
	["send-to-back"] = "rbxassetid://75340312862253",
	["send"] = "rbxassetid://127751956873796",
	["separator-horizontal"] = "rbxassetid://84864453699927",
	["separator-vertical"] = "rbxassetid://84031801478581",
	["server-cog"] = "rbxassetid://138470287250966",
	["server-crash"] = "rbxassetid://132810618000212",
	["server-off"] = "rbxassetid://114048751507723",
	["server"] = "rbxassetid://92188766517878",
	["settings-2"] = "rbxassetid://135684703553372",
	["settings"] = "rbxassetid://80758916183665",
	["shapes"] = "rbxassetid://129989433311409",
	["share-2"] = "rbxassetid://71210767962065",
	["share"] = "rbxassetid://87340985053299",
	["sheet"] = "rbxassetid://134902122480171",
	["shell"] = "rbxassetid://140212943563599",
	["shield-alert"] = "rbxassetid://114995877719925",
	["shield-ban"] = "rbxassetid://108765041044649",
	["shield-check"] = "rbxassetid://87354736164608",
	["shield-ellipsis"] = "rbxassetid://114794739892123",
	["shield-half"] = "rbxassetid://117842634172647",
	["shield-minus"] = "rbxassetid://89965059528921",
	["shield-off"] = "rbxassetid://133426959132690",
	["shield-plus"] = "rbxassetid://100664857995498",
	["shield-question-mark"] = "rbxassetid://135722075265150",
	["shield-user"] = "rbxassetid://124832775645347",
	["shield-x"] = "rbxassetid://73370117343811",
	["shield"] = "rbxassetid://110987169760162",
	["ship-wheel"] = "rbxassetid://130797795829448",
	["ship"] = "rbxassetid://83995100553930",
	["shirt"] = "rbxassetid://106579555405966",
	["shopping-bag"] = "rbxassetid://71885477293226",
	["shopping-basket"] = "rbxassetid://138646411956433",
	["shopping-cart"] = "rbxassetid://128420521375441",
	["shovel"] = "rbxassetid://102465000512056",
	["shower-head"] = "rbxassetid://75884944024117",
	["shredder"] = "rbxassetid://122125164414463",
	["shrimp"] = "rbxassetid://102625900815307",
	["shrink"] = "rbxassetid://90953687918880",
	["shrub"] = "rbxassetid://127326280714343",
	["shuffle"] = "rbxassetid://132382786975101",
	["sigma"] = "rbxassetid://126884244870899",
	["signal-high"] = "rbxassetid://130436670012270",
	["signal-low"] = "rbxassetid://73674683500458",
	["signal-medium"] = "rbxassetid://125003021367019",
	["signal-zero"] = "rbxassetid://130045332414754",
	["signal"] = "rbxassetid://78424889355261",
	["signature"] = "rbxassetid://114402748013000",
	["signpost-big"] = "rbxassetid://115780185675001",
	["signpost"] = "rbxassetid://106584743791433",
	["siren"] = "rbxassetid://134210267818039",
	["skip-back"] = "rbxassetid://70466132711334",
	["skip-forward"] = "rbxassetid://124844823753990",
	["skull"] = "rbxassetid://137726256442333",
	["slack"] = "rbxassetid://96089719516736",
	["slash"] = "rbxassetid://117792185664263",
	["slice"] = "rbxassetid://95810504278179",
	["sliders-horizontal"] = "rbxassetid://85538382643347",
	["sliders-vertical"] = "rbxassetid://101190569086853",
	["smartphone-charging"] = "rbxassetid://102837532613995",
	["smartphone-nfc"] = "rbxassetid://82326425754446",
	["smartphone"] = "rbxassetid://96623008834511",
	["smile-plus"] = "rbxassetid://131981881472144",
	["smile"] = "rbxassetid://105880397565283",
	["snail"] = "rbxassetid://70904536548363",
	["snowflake"] = "rbxassetid://101235206534566",
	["soap-dispenser-droplet"] = "rbxassetid://77258480479465",
	["sofa"] = "rbxassetid://114427687218324",
	["solar-panel"] = "rbxassetid://132448188047921",
	["soup"] = "rbxassetid://115092551871618",
	["space"] = "rbxassetid://87072088914178",
	["spade"] = "rbxassetid://131444449466462",
	["sparkle"] = "rbxassetid://111044800239623",
	["sparkles"] = "rbxassetid://138635884129147",
	["speaker"] = "rbxassetid://96227183003618",
	["speech"] = "rbxassetid://87013139446349",
	["spell-check-2"] = "rbxassetid://81556731785534",
	["spell-check"] = "rbxassetid://91913483031334",
	["spline-pointer"] = "rbxassetid://84842840956804",
	["spline"] = "rbxassetid://129406685807412",
	["split"] = "rbxassetid://105112438805988",
	["spool"] = "rbxassetid://124541981347743",
	["spotlight"] = "rbxassetid://77571742539344",
	["spray-can"] = "rbxassetid://128372039366326",
	["sprout"] = "rbxassetid://100091687832508",
	["square-activity"] = "rbxassetid://89496630185293",
	["square-arrow-down-left"] = "rbxassetid://108194680296901",
	["square-arrow-down-right"] = "rbxassetid://99403846801050",
	["square-arrow-down"] = "rbxassetid://135962519626588",
	["square-arrow-left"] = "rbxassetid://111671474549238",
	["square-arrow-out-down-left"] = "rbxassetid://125714881756353",
	["square-arrow-out-down-right"] = "rbxassetid://89971003001390",
	["square-arrow-out-up-left"] = "rbxassetid://103759986579087",
	["square-arrow-out-up-right"] = "rbxassetid://91221896066807",
	["square-arrow-right"] = "rbxassetid://113920471701361",
	["square-arrow-up-left"] = "rbxassetid://112424670290693",
	["square-arrow-up-right"] = "rbxassetid://76602291406940",
	["square-arrow-up"] = "rbxassetid://106998604646718",
	["square-asterisk"] = "rbxassetid://89186832353625",
	["square-bottom-dashed-scissors"] = "rbxassetid://79076980104803",
	["square-chart-gantt"] = "rbxassetid://104034017316411",
	["square-check-big"] = "rbxassetid://115320390907184",
	["square-check"] = "rbxassetid://134682053539509",
	["square-chevron-down"] = "rbxassetid://91032307924592",
	["square-chevron-left"] = "rbxassetid://73143404829510",
	["square-chevron-right"] = "rbxassetid://90612077729930",
	["square-chevron-up"] = "rbxassetid://85565910197337",
	["square-code"] = "rbxassetid://81604576616881",
	["square-dashed-bottom-code"] = "rbxassetid://100354801563230",
	["square-dashed-bottom"] = "rbxassetid://101102319625624",
	["square-dashed-kanban"] = "rbxassetid://90388067649847",
	["square-dashed-mouse-pointer"] = "rbxassetid://121016142178467",
	["square-dashed-top-solid"] = "rbxassetid://117157577548540",
	["square-dashed"] = "rbxassetid://136905537847606",
	["square-divide"] = "rbxassetid://99894657101970",
	["square-dot"] = "rbxassetid://116613421354866",
	["square-equal"] = "rbxassetid://110283363706707",
	["square-function"] = "rbxassetid://86075219551088",
	["square-kanban"] = "rbxassetid://114537101260131",
	["square-library"] = "rbxassetid://73810931222081",
	["square-m"] = "rbxassetid://117662700410577",
	["square-menu"] = "rbxassetid://104067089444415",
	["square-minus"] = "rbxassetid://116764432015770",
	["square-mouse-pointer"] = "rbxassetid://76141850603920",
	["square-parking-off"] = "rbxassetid://100857293535141",
	["square-parking"] = "rbxassetid://133116656122387",
	["square-pause"] = "rbxassetid://86608552787615",
	["square-pen"] = "rbxassetid://120239476110475",
	["square-percent"] = "rbxassetid://87111930314567",
	["square-pi"] = "rbxassetid://75383328781618",
	["square-pilcrow"] = "rbxassetid://131854284699367",
	["square-play"] = "rbxassetid://108186325238481",
	["square-plus"] = "rbxassetid://114713264461873",
	["square-power"] = "rbxassetid://129240437805187",
	["square-radical"] = "rbxassetid://132645931868292",
	["square-round-corner"] = "rbxassetid://104592745113567",
	["square-scissors"] = "rbxassetid://110601255612411",
	["square-sigma"] = "rbxassetid://113231244246816",
	["square-slash"] = "rbxassetid://105477013908757",
	["square-split-horizontal"] = "rbxassetid://76095370148660",
	["square-split-vertical"] = "rbxassetid://88589192032058",
	["square-square"] = "rbxassetid://136555087357875",
	["square-stack"] = "rbxassetid://100463396619394",
	["square-star"] = "rbxassetid://94506958703720",
	["square-stop"] = "rbxassetid://80018708472943",
	["square-terminal"] = "rbxassetid://83969264476798",
	["square-user-round"] = "rbxassetid://86484997229302",
	["square-user"] = "rbxassetid://70771214183445",
	["square-x"] = "rbxassetid://125136183850190",
	["square"] = "rbxassetid://86304921356806",
	["squares-exclude"] = "rbxassetid://102345385822324",
	["squares-intersect"] = "rbxassetid://120869602570119",
	["squares-subtract"] = "rbxassetid://131484650948795",
	["squares-unite"] = "rbxassetid://96673080107843",
	["squircle-dashed"] = "rbxassetid://129936702532522",
	["squircle"] = "rbxassetid://82426632573807",
	["squirrel"] = "rbxassetid://112864252085343",
	["stamp"] = "rbxassetid://92370779813368",
	["star-half"] = "rbxassetid://117449275562979",
	["star-off"] = "rbxassetid://75742832732503",
	["star"] = "rbxassetid://136141469398409",
	["step-back"] = "rbxassetid://108672750005121",
	["step-forward"] = "rbxassetid://126131872136145",
	["stethoscope"] = "rbxassetid://122331031702148",
	["sticker"] = "rbxassetid://79938203791608",
	["sticky-note"] = "rbxassetid://111894074643919",
	["store"] = "rbxassetid://90338129673705",
	["stretch-horizontal"] = "rbxassetid://87665042192343",
	["stretch-vertical"] = "rbxassetid://95265463417122",
	["strikethrough"] = "rbxassetid://103417324549613",
	["subscript"] = "rbxassetid://74553514785183",
	["sun-dim"] = "rbxassetid://129141645592715",
	["sun-medium"] = "rbxassetid://130278807964710",
	["sun-moon"] = "rbxassetid://75752898854559",
	["sun-snow"] = "rbxassetid://112791898014579",
	["sun"] = "rbxassetid://110150589884127",
	["sunrise"] = "rbxassetid://134705665494098",
	["sunset"] = "rbxassetid://75904872203588",
	["superscript"] = "rbxassetid://96887696590118",
	["swatch-book"] = "rbxassetid://126786244872453",
	["swiss-franc"] = "rbxassetid://113497920041625",
	["switch-camera"] = "rbxassetid://76841154349737",
	["sword"] = "rbxassetid://124448418211665",
	["swords"] = "rbxassetid://81872698913435",
	["syringe"] = "rbxassetid://123891270479254",
	["table-2"] = "rbxassetid://95751552281545",
	["table-cells-merge"] = "rbxassetid://95363715175258",
	["table-cells-split"] = "rbxassetid://114799086088649",
	["table-columns-split"] = "rbxassetid://111011625447949",
	["table-of-contents"] = "rbxassetid://135044763275414",
	["table-properties"] = "rbxassetid://125062886015372",
	["table-rows-split"] = "rbxassetid://96443733673997",
	["table"] = "rbxassetid://109109148250737",
	["tablet-smartphone"] = "rbxassetid://133680859813404",
	["tablet"] = "rbxassetid://128403991264386",
	["tablets"] = "rbxassetid://80835787970735",
	["tag"] = "rbxassetid://129104970103940",
	["tags"] = "rbxassetid://107179263080798",
	["tally-1"] = "rbxassetid://115301298241643",
	["tally-2"] = "rbxassetid://110363186864027",
	["tally-3"] = "rbxassetid://97655344572540",
	["tally-4"] = "rbxassetid://102633494371890",
	["tally-5"] = "rbxassetid://88031817475886",
	["tangent"] = "rbxassetid://123263132981724",
	["target"] = "rbxassetid://87563802520297",
	["telescope"] = "rbxassetid://91755049143647",
	["tent-tree"] = "rbxassetid://76698322463977",
	["tent"] = "rbxassetid://109779587826330",
	["terminal"] = "rbxassetid://106783148545356",
	["test-tube-diagonal"] = "rbxassetid://75662704378840",
	["test-tube"] = "rbxassetid://98801015650164",
	["test-tubes"] = "rbxassetid://92555361447433",
	["text-align-center"] = "rbxassetid://84051028246390",
	["text-align-end"] = "rbxassetid://130041738343555",
	["text-align-justify"] = "rbxassetid://80279880143030",
	["text-align-start"] = "rbxassetid://134489585487649",
	["text-cursor-input"] = "rbxassetid://107551944047171",
	["text-cursor"] = "rbxassetid://115984654447300",
	["text-initial"] = "rbxassetid://129458097472087",
	["text-quote"] = "rbxassetid://139278366448736",
	["text-search"] = "rbxassetid://92345384671606",
	["text-select"] = "rbxassetid://117087320884956",
	["text-wrap"] = "rbxassetid://114804318314018",
	["theater"] = "rbxassetid://108558145549163",
	["thermometer-snowflake"] = "rbxassetid://121876188028425",
	["thermometer-sun"] = "rbxassetid://106693240074310",
	["thermometer"] = "rbxassetid://106546011492311",
	["thumbs-down"] = "rbxassetid://87794009914015",
	["thumbs-up"] = "rbxassetid://111137070767020",
	["ticket-check"] = "rbxassetid://105428777212507",
	["ticket-minus"] = "rbxassetid://78966299769328",
	["ticket-percent"] = "rbxassetid://80834774406405",
	["ticket-plus"] = "rbxassetid://110086734392189",
	["ticket-slash"] = "rbxassetid://89045681172265",
	["ticket-x"] = "rbxassetid://88674114109926",
	["ticket"] = "rbxassetid://126527071492145",
	["tickets-plane"] = "rbxassetid://100367018248695",
	["tickets"] = "rbxassetid://135268612687833",
	["timer-off"] = "rbxassetid://110916370767271",
	["timer-reset"] = "rbxassetid://110052125369932",
	["timer"] = "rbxassetid://85473888890506",
	["toggle-left"] = "rbxassetid://85887872573050",
	["toggle-right"] = "rbxassetid://90411952142550",
	["toilet"] = "rbxassetid://80930782432931",
	["tool-case"] = "rbxassetid://87533537832522",
	["tornado"] = "rbxassetid://88358291515768",
	["torus"] = "rbxassetid://70855707283051",
	["touchpad-off"] = "rbxassetid://78784008075456",
	["touchpad"] = "rbxassetid://74882354908014",
	["tower-control"] = "rbxassetid://95937619060532",
	["toy-brick"] = "rbxassetid://86293483924633",
	["tractor"] = "rbxassetid://103376704722051",
	["traffic-cone"] = "rbxassetid://74110220470369",
	["train-front-tunnel"] = "rbxassetid://105194827005114",
	["train-front"] = "rbxassetid://125237934215370",
	["train-track"] = "rbxassetid://77451032453723",
	["tram-front"] = "rbxassetid://93315182364998",
	["transgender"] = "rbxassetid://135530817673639",
	["trash-2"] = "rbxassetid://109843431391323",
	["trash"] = "rbxassetid://106723740584310",
	["tree-deciduous"] = "rbxassetid://123124389219004",
	["tree-palm"] = "rbxassetid://103846705893963",
	["tree-pine"] = "rbxassetid://124662547202594",
	["trees"] = "rbxassetid://121203841375919",
	["trello"] = "rbxassetid://130987241149527",
	["trending-down"] = "rbxassetid://139309232226438",
	["trending-up-down"] = "rbxassetid://85083293981691",
	["trending-up"] = "rbxassetid://81819858538839",
	["triangle-alert"] = "rbxassetid://125920361880643",
	["triangle-dashed"] = "rbxassetid://124324079103935",
	["triangle-right"] = "rbxassetid://116930791412791",
	["triangle"] = "rbxassetid://126330486745540",
	["trophy"] = "rbxassetid://131545003268773",
	["truck-electric"] = "rbxassetid://111873446387359",
	["truck"] = "rbxassetid://86662707764771",
	["turkish-lira"] = "rbxassetid://114589876174070",
	["turntable"] = "rbxassetid://129870346487856",
	["turtle"] = "rbxassetid://118295081560334",
	["tv-minimal-play"] = "rbxassetid://99201833426972",
	["tv-minimal"] = "rbxassetid://100382201729427",
	["tv"] = "rbxassetid://135687724791776",
	["twitch"] = "rbxassetid://71383308134888",
	["twitter"] = "rbxassetid://88791703276842",
	["type-outline"] = "rbxassetid://80108627791690",
	["type"] = "rbxassetid://133543553793564",
	["umbrella-off"] = "rbxassetid://72395143739955",
	["umbrella"] = "rbxassetid://127502210274589",
	["underline"] = "rbxassetid://123709229216544",
	["undo-2"] = "rbxassetid://113885292059932",
	["undo-dot"] = "rbxassetid://132055277744844",
	["undo"] = "rbxassetid://111258459077271",
	["unfold-horizontal"] = "rbxassetid://117128358526398",
	["unfold-vertical"] = "rbxassetid://116593025265499",
	["ungroup"] = "rbxassetid://106674800451003",
	["university"] = "rbxassetid://84652528263642",
	["unlink-2"] = "rbxassetid://128131898892572",
	["unlink"] = "rbxassetid://139835795227752",
	["unplug"] = "rbxassetid://90171381619874",
	["upload"] = "rbxassetid://138212042425501",
	["usb"] = "rbxassetid://117230058949613",
	["user-check"] = "rbxassetid://81775205032725",
	["user-cog"] = "rbxassetid://92795491530865",
	["user-lock"] = "rbxassetid://78892639693821",
	["user-minus"] = "rbxassetid://126976941957511",
	["user-pen"] = "rbxassetid://87445472574836",
	["user-plus"] = "rbxassetid://118514469915884",
	["user-round-check"] = "rbxassetid://118794737621941",
	["user-round-cog"] = "rbxassetid://78239503290053",
	["user-round-minus"] = "rbxassetid://98944176636447",
	["user-round-pen"] = "rbxassetid://108155244324878",
	["user-round-plus"] = "rbxassetid://113301899567470",
	["user-round-search"] = "rbxassetid://71565774381870",
	["user-round-x"] = "rbxassetid://122367980560930",
	["user-round"] = "rbxassetid://136485052187963",
	["user-search"] = "rbxassetid://101335649828115",
	["user-star"] = "rbxassetid://98777846316000",
	["user-x"] = "rbxassetid://139748155894754",
	["user"] = "rbxassetid://81589895647169",
	["users-round"] = "rbxassetid://103005444008339",
	["users"] = "rbxassetid://115398113982385",
	["utensils-crossed"] = "rbxassetid://109520762270383",
	["utensils"] = "rbxassetid://139952569804235",
	["utility-pole"] = "rbxassetid://101965541238242",
	["variable"] = "rbxassetid://104743088438151",
	["vault"] = "rbxassetid://108049164599845",
	["vector-square"] = "rbxassetid://86713728565344",
	["vegan"] = "rbxassetid://119489190688082",
	["venetian-mask"] = "rbxassetid://102636443033920",
	["venus-and-mars"] = "rbxassetid://120227752103771",
	["venus"] = "rbxassetid://82891342220859",
	["vibrate-off"] = "rbxassetid://113446447326246",
	["vibrate"] = "rbxassetid://108330910738733",
	["video-off"] = "rbxassetid://132239189859305",
	["video"] = "rbxassetid://107587444636945",
	["videotape"] = "rbxassetid://114816894323398",
	["view"] = "rbxassetid://118717253976805",
	["voicemail"] = "rbxassetid://134313454010227",
	["volleyball"] = "rbxassetid://83889351124153",
	["volume-1"] = "rbxassetid://98514588731639",
	["volume-2"] = "rbxassetid://89344380902620",
	["volume-off"] = "rbxassetid://103047478058767",
	["volume-x"] = "rbxassetid://139252359189540",
	["volume"] = "rbxassetid://103236289817396",
	["vote"] = "rbxassetid://89409762851246",
	["wallet-cards"] = "rbxassetid://129728715308337",
	["wallet-minimal"] = "rbxassetid://137800448816116",
	["wallet"] = "rbxassetid://132331555762628",
	["wallpaper"] = "rbxassetid://74682121235494",
	["wand-sparkles"] = "rbxassetid://82546429942392",
	["wand"] = "rbxassetid://114580617777835",
	["warehouse"] = "rbxassetid://78388887451080",
	["washing-machine"] = "rbxassetid://104194127573858",
	["watch"] = "rbxassetid://130544621618405",
	["waves-ladder"] = "rbxassetid://101808619355514",
	["waves"] = "rbxassetid://96340135183647",
	["waypoints"] = "rbxassetid://102450133666017",
	["webcam"] = "rbxassetid://104148487911129",
	["webhook-off"] = "rbxassetid://96370548093471",
	["webhook"] = "rbxassetid://112812457747322",
	["weight"] = "rbxassetid://103860559844854",
	["wheat-off"] = "rbxassetid://133294844612307",
	["wheat"] = "rbxassetid://85261952080359",
	["whole-word"] = "rbxassetid://90111083954485",
	["wifi-cog"] = "rbxassetid://110500263326209",
	["wifi-high"] = "rbxassetid://81954601342139",
	["wifi-low"] = "rbxassetid://138217335635913",
	["wifi-off"] = "rbxassetid://74113634330106",
	["wifi-pen"] = "rbxassetid://91290205064712",
	["wifi-sync"] = "rbxassetid://84043971055177",
	["wifi-zero"] = "rbxassetid://124286465246123",
	["wifi"] = "rbxassetid://104669375183960",
	["wind-arrow-down"] = "rbxassetid://127753987414870",
	["wind"] = "rbxassetid://114551690399915",
	["wine-off"] = "rbxassetid://108294164302317",
	["wine"] = "rbxassetid://115743721332829",
	["workflow"] = "rbxassetid://99186544029189",
	["worm"] = "rbxassetid://115752311548091",
	["wrench"] = "rbxassetid://112148279212860",
	["x"] = "rbxassetid://110786993356448",
	["youtube"] = "rbxassetid://123663668456341",
	["zap-off"] = "rbxassetid://81385483183652",
	["zap"] = "rbxassetid://130551565616516",
	["zoom-in"] = "rbxassetid://127956924984803",
	["zoom-out"] = "rbxassetid://108334162607319",
    ["discord"] = "rbxassetid://88082592882886",
}
local iconPacks={lucide=embeddedLucide,solar={}}
local iconRuntime={ready=false,busy=false}
local iconNames={
    key={"key", "key-linear"},
    lock={"lock", "lock-linear"},
    shield={"shield", "shield-linear"},
    check={"check", "circle-check", "check-circle"},
    x={"x", "close"},
    link={"link", "external-link"},
    discord={"discord", "message-circle"},
    copy={"copy", "clipboard"},
    loader={"loader", "loader-circle"},
    info={"info", "circle-help"},
    alert={"triangle-alert", "alert-triangle", "circle-alert"},
    sparkle={"sparkles", "sparkles"},
    cart={"shopping-cart", "shopping-bag", "cart"},
    eye={"eye", "eye-off"},
    refresh={"refresh-cw", "refresh"},
    arrow={"arrow-right", "chevron-right"},
    move={"move", "mouse-pointer"},
    fingerprint={"fingerprint"},
}
local solarNames={
    key="key-linear",lock="lock-keyhole-linear",shield="shield-check-linear",
    check="check-circle-linear",x="close-circle-linear",link="link-linear",
    discord="chat-round-linear",copy="clipboard-linear",loader="refresh-circle-linear",
    info="info-circle-linear",alert="danger-circle-linear",sparkle="star-shine-linear",
    cart="cart-large-minimalistic-linear",eye="eye-linear",refresh="refresh-circle-linear",
    arrow="alt-arrow-right-linear",move="cursor-linear",fingerprint="fingerprint-linear",
}
local function iconAssetFrom(pack,name)
    local set=iconPacks[pack]
    if type(set)~="table" then return "" end
    local candidates=iconNames[name] or {name}
    for _,k in ipairs(candidates) do
        local v=set[k]
        if type(v)=="string" and v~="" then return v end
        if type(v)=="table" then
            local id=v.id or v.Id or v[1]
            if id then return "rbxassetid://"..tostring(id) end
        end
    end
    return ""
end
local function iconAsset(name)
    local solar=solarNames[name]
    if solar then
        local v=iconPacks.solar[solar]
        if type(v)=="string" and v~="" then return v end
        if type(v)=="table" then
            local id=v.id or v.Id or v[1]
            if id then return "rbxassetid://"..tostring(id) end
        end
    end
    local a=iconAssetFrom("lucide",name)
    return a
end
local function putIcon(parent,name,size,color)
    local image=new("ImageLabel",{BackgroundTransparency=1,Size=UDim2.fromOffset(size or 16,size or 16),ImageColor3=color or colors.subtext,ScaleType=Enum.ScaleType.Fit},parent)
    local asset=iconAsset(name)
    if asset=="" then
        image.Visible=false
    else
        image.Image=asset
    end
    return image
end
local function loadIconRemote(url)
    local ok,src=pcall(function() return game:HttpGet(url) end)
    if not ok or type(src)~="string" or src=="" then return nil end
    local loaded,pack=pcall(function() return loadstring(src)() end)
    if loaded and type(pack)=="table" then return pack end
    return nil
end
local function loadIconPacks()
    if iconRuntime.busy then return end
    iconRuntime.busy=true
    task.spawn(function()
        local solar=loadIconRemote(ICON_SOLAR_URL)
        if type(solar)=="table" then iconPacks.solar=solar end
        local remoteLucide=loadIconRemote(ICON_LUCIDE_URL)
        if type(remoteLucide)=="table" then iconPacks.lucide=remoteLucide end
        iconRuntime.ready=true
        iconRuntime.busy=false
    end)
end
local function refreshIcons(root)
    if not root or not root.Parent then return end
    for _,v in ipairs(root:GetDescendants()) do
        if v:IsA("ImageLabel") then
            local key=v:GetAttribute("suic1de_icon")
            if key then
                local a=iconAsset(key)
                if a~="" then v.Image=a v.Visible=true end
            end
        end
    end
end
local function markIcon(image,name)
    if image then image:SetAttribute("suic1de_icon",name) end
    return image
end
local function newStatusRow(parent)
    local row=new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,26)},parent)
    local box=new("Frame",{BackgroundColor3=colors.surface2,BorderSizePixel=0,Position=UDim2.fromOffset(0,2),Size=UDim2.fromOffset(28,22)},row)
    corner(box,8)
    outline(box,colors.borderSoft,0.18,1)
    local mark=markIcon and markIcon(putIcon(box,"shield",13,colors.subtext),"shield") or putIcon(box,"shield",13,colors.subtext)
    mark.AnchorPoint=Vector2.new(0.5,0.5)
    mark.Position=UDim2.fromScale(0.5,0.5)
    ui.statusIcon=mark
    ui.statusText=new("TextLabel",{BackgroundTransparency=1,Font=fonts.body,Position=UDim2.fromOffset(38,0),Size=UDim2.new(1,-38,1,0),Text="Ready",TextColor3=colors.subtext,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left},row)
    return row
end
local function addInputRipple(button)
    if not button then return end
    addConnection(button.InputBegan:Connect(function(obj)
        if obj.UserInputType~=Enum.UserInputType.MouseButton1 and obj.UserInputType~=Enum.UserInputType.Touch then return end
        local r=new("Frame",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=colors.text,BackgroundTransparency=0.86,BorderSizePixel=0,Position=UDim2.new(0,obj.Position and 0 or 0,0,0),Size=UDim2.fromOffset(12,12),ZIndex=button.ZIndex+2},button)
        corner(r,12)
        r.Position=UDim2.fromOffset(button.AbsoluteSize.X/2,button.AbsoluteSize.Y/2)
        tween(r,0.28,{Size=UDim2.fromOffset(button.AbsoluteSize.X*1.5,button.AbsoluteSize.Y*1.5),BackgroundTransparency=1},Enum.EasingStyle.Quart)
        task.delay(0.3,function() if r.Parent then r:Destroy() end end)
    end))
end
local function iconButton(parent,label,iconName,width,primary)
    local button=new("TextButton",{AutoButtonColor=false,BackgroundColor3=primary and colors.accentDeep or colors.surface2,BorderSizePixel=0,Font=fonts.medium,Text="",TextColor3=colors.text,Size=UDim2.fromOffset(width or 120,42)},parent)
    corner(button,11)
    outline(button,primary and colors.accent or colors.borderSoft,primary and 0.55 or 0.12,1)
    local row=new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,1,0)},button)
    local layout=new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Center,VerticalAlignment=Enum.VerticalAlignment.Center,Padding=UDim.new(0,7)},row)
    local img=markIcon(putIcon(row,iconName,14,primary and colors.text or colors.subtext),iconName)
    local txt=new("TextLabel",{AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Font=fonts.medium,Size=UDim2.fromOffset(0,22),Text=tostring(label or ""),TextColor3=colors.text,TextSize=10},row)
    addConnection(button.MouseEnter:Connect(function() tween(button,0.14,{BackgroundColor3=primary and colors.accent or colors.surface3}) tween(img,0.14,{ImageColor3=colors.text}) end))
    addConnection(button.MouseLeave:Connect(function() tween(button,0.14,{BackgroundColor3=primary and colors.accentDeep or colors.surface2}) tween(img,0.14,{ImageColor3=primary and colors.text or colors.subtext}) end))
    addInputRipple(button)
    return button
end
local function setButtonBusy(button,busy,label,iconName)
    if not button then return end
    button.Active=not busy
    local row=button:FindFirstChildOfClass("Frame")
    if not row then return end
    local img=row:FindFirstChildOfClass("ImageLabel")
    local txt=row:FindFirstChildOfClass("TextLabel")
    if busy then
        if txt then txt.Text="Checking" end
        if img then
            local asset=iconAsset("loader")
            if asset~="" then img.Image=asset img.Visible=true end
            task.spawn(function()
                while busy and img.Parent do
                    tween(img,0.55,{Rotation=img.Rotation+360},Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
                    task.wait(0.55)
                end
            end)
        end
    else
        if txt then txt.Text=label or "Verify" end
        if img then
            local asset=iconAsset(iconName or "shield")
            if asset~="" then img.Image=asset img.Rotation=0 end
        end
    end
end
local function createIntro(root,width)
    if suic1de.Options.Intro==false then return end
    local cover=new("Frame",{BackgroundColor3=colors.background,BorderSizePixel=0,Size=UDim2.fromScale(1,1),ZIndex=1000},root)
    local left=new("Frame",{BackgroundColor3=colors.surface,BorderSizePixel=0,Size=UDim2.new(0.5,0,1,0),ZIndex=1001},cover)
    local right=new("Frame",{BackgroundColor3=colors.surface,BorderSizePixel=0,Size=UDim2.new(0.5,0,1,0),Position=UDim2.new(0.5,0,0,0),ZIndex=1001},cover)
    local cap=new("Frame",{BackgroundColor3=colors.accent,BackgroundTransparency=0.55,BorderSizePixel=0,Position=UDim2.new(0.5,-1,0.5,-100),Size=UDim2.fromOffset(2,200),ZIndex=1002},cover)
    corner(cap,2)
    local holder=new("Frame",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=colors.surface2,BorderSizePixel=0,Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(48,48),ZIndex=1003},cover)
    corner(holder,14)
    outline(holder,colors.border,0.1,1)
    local glyph=markIcon(putIcon(holder,"key",21,colors.accent),"key")
    glyph.AnchorPoint=Vector2.new(0.5,0.5) glyph.Position=UDim2.fromScale(0.5,0.5)
    local label=new("TextLabel",{AnchorPoint=Vector2.new(0.5,0),BackgroundTransparency=1,Font=fonts.title,Position=UDim2.new(0.5,0,0.5,34),Size=UDim2.fromOffset(math.min(width,280),30),Text=tostring(suic1de.Appearance.Title or "suic1.de"),TextColor3=colors.text,TextSize=isMobile() and 19 or 23,TextTransparency=1,ZIndex=1003},cover)
    tween(holder,0.34,{Size=UDim2.fromOffset(56,56)},Enum.EasingStyle.Back)
    tween(glyph,0.25,{ImageTransparency=0})
    tween(label,0.24,{TextTransparency=0})
    task.delay(math.max(0.2,tonumber(suic1de.Options.IntroDuration) or 0.7),function()
        if not cover.Parent then return end
        tween(label,0.16,{TextTransparency=1})
        tween(glyph,0.16,{ImageTransparency=1})
        tween(holder,0.24,{BackgroundTransparency=1})
        tween(left,0.4,{Position=UDim2.new(-0.5,0,0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        tween(right,0.4,{Position=UDim2.new(1,0,0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        tween(cap,0.3,{BackgroundTransparency=1})
        task.delay(0.43,function() if cover.Parent then cover:Destroy() end end)
    end)
end
local function enableSuicBlur()
    if suic1de.Options.Blur==false then return end
    local old=services.Lighting:FindFirstChild("suic1de_blur")
    if old then old:Destroy() end
    local blur=new("BlurEffect",{Name="suic1de_blur",Size=0},services.Lighting)
    tween(blur,0.38,{Size=16},Enum.EasingStyle.Quart)
end
local function disableSuicBlur()
    local blur=services.Lighting:FindFirstChild("suic1de_blur")
    if blur then
        tween(blur,0.22,{Size=0},Enum.EasingStyle.Quart)
        task.delay(0.24,function() if blur.Parent then blur:Destroy() end end)
    end
end
local function toastKindColor(kind)
    if kind=="success" then return colors.success end
    if kind=="error" then return colors.danger end
    if kind=="warning" then return colors.warning end
    return colors.accent
end
local function toastKindIcon(kind)
    if kind=="success" then return "check" end
    if kind=="error" then return "alert" end
    if kind=="warning" then return "alert" end
    if kind=="copy" then return "copy" end
    return "info"
end
local toastSerial=0
local function richToast(title,message,kind,duration)
    if not ui.root or not ui.root.Parent then return end
    if not state.toastHolder or not state.toastHolder.Parent then
        state.toastHolder=new("Frame",{AnchorPoint=Vector2.new(1,1),BackgroundTransparency=1,Position=UDim2.new(1,-16,1,-14),Size=UDim2.fromOffset(isMobile() and 270 or 320,260),ZIndex=800},ui.root)
        new("UIListLayout",{HorizontalAlignment=Enum.HorizontalAlignment.Right,Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom},state.toastHolder)
    end
    toastSerial+=1
    local id=toastSerial
    local color=toastKindColor(kind)
    local wrap=new("Frame",{BackgroundTransparency=1,LayoutOrder=id,Size=UDim2.new(1,0,0,68),ZIndex=800},state.toastHolder)
    local card=new("Frame",{BackgroundColor3=colors.surface,BackgroundTransparency=1,BorderSizePixel=0,Position=UDim2.fromOffset(28,0),Size=UDim2.new(1,-28,0,62),ZIndex=801},wrap)
    corner(card,12)
    outline(card,colors.border,0.1,1)
    local edge=new("Frame",{BackgroundColor3=color,BackgroundTransparency=0.12,BorderSizePixel=0,Position=UDim2.fromOffset(0,10),Size=UDim2.fromOffset(3,42),ZIndex=802},card)
    corner(edge,2)
    local badge=new("Frame",{BackgroundColor3=color,BackgroundTransparency=0.78,BorderSizePixel=0,Position=UDim2.fromOffset(12,13),Size=UDim2.fromOffset(34,34),ZIndex=802},card)
    corner(badge,10)
    local glyph=markIcon(putIcon(badge,toastKindIcon(kind),16,color),toastKindIcon(kind))
    glyph.AnchorPoint=Vector2.new(0.5,0.5) glyph.Position=UDim2.fromScale(0.5,0.5)
    local a=new("TextLabel",{BackgroundTransparency=1,Font=fonts.medium,Position=UDim2.fromOffset(56,10),Size=UDim2.new(1,-68,0,18),Text=tostring(title or ""),TextColor3=colors.text,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=802},card)
    local b=new("TextLabel",{BackgroundTransparency=1,Font=fonts.body,Position=UDim2.fromOffset(56,29),Size=UDim2.new(1,-68,0,22),Text=tostring(message or ""),TextColor3=colors.subtext,TextSize=10,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=802},card)
    local track=new("Frame",{BackgroundColor3=colors.surface3,BorderSizePixel=0,Position=UDim2.fromOffset(56,55),Size=UDim2.new(1,-68,0,2),ZIndex=802},card)
    corner(track,2)
    local fill=new("Frame",{BackgroundColor3=color,BorderSizePixel=0,Size=UDim2.fromScale(1,1),ZIndex=803},track)
    corner(fill,2)
    wrap.Parent=state.toastHolder
    card.Position=UDim2.fromOffset(34,0)
    tween(card,0.32,{Position=UDim2.fromOffset(0,0),BackgroundTransparency=0.035},Enum.EasingStyle.Quart)
    tween(glyph,0.2,{ImageTransparency=0})
    local d=math.max(0.7,tonumber(duration) or suic1de.Options.ToastDuration or 3.2)
    tween(fill,d,{Size=UDim2.fromScale(0,1)},Enum.EasingStyle.Linear,Enum.EasingDirection.In)
    task.delay(d,function()
        if not wrap.Parent then return end
        tween(card,0.2,{Position=UDim2.fromOffset(34,0),BackgroundTransparency=1},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
        tween(glyph,0.16,{ImageTransparency=1})
        task.delay(0.23,function() if wrap.Parent then wrap:Destroy() end end)
    end)
end
makeToast=richToast

local function setStatusVisual(message,kind)
    if not ui.statusText then return end
    local color=colors.subtext
    local iconName="info"
    if kind=="success" then color=colors.success iconName="check"
    elseif kind=="error" then color=colors.danger iconName="alert"
    elseif kind=="warning" then color=colors.warning iconName="alert"
    elseif kind=="info" then color=colors.accent iconName="shield" end
    ui.statusText.Text=tostring(message or "")
    ui.statusText.TextColor3=color
    if ui.statusIcon then
        local asset=iconAsset(iconName)
        if asset~="" then ui.statusIcon.Image=asset ui.statusIcon.Visible=true end
        tween(ui.statusIcon,0.13,{ImageColor3=color,Rotation=ui.statusIcon.Rotation+10},Enum.EasingStyle.Quart)
        task.delay(0.13,function() if ui.statusIcon and ui.statusIcon.Parent then tween(ui.statusIcon,0.13,{Rotation=0},Enum.EasingStyle.Quart) end end)
    end
end
updateStatus=setStatusVisual

local originalDestroy=suic1de.Destroy
local originalBuildMain=buildMain
buildMain=function()
    suic1de:ValidateAll()
    loadIconPacks()
    state.alive=false
    local parent=getGuiParent()
    local old=parent:FindFirstChild("suic1de")
    if old then old:Destroy() end
    ui.root=new("ScreenGui",{Name="suic1de",IgnoreGuiInset=true,ResetOnSpawn=false,DisplayOrder=999999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},parent)
    local scale=new("UIScale",{Scale=1},ui.root)
    local camera=workspace.CurrentCamera
    local function fit()
        if not camera or not scale.Parent then return end
        local v=camera.ViewportSize
        local target=math.min(v.X/900,v.Y/650)
        if v.X<600 then target=math.min(v.X/370,v.Y/620) end
        scale.Scale=math.clamp(target,0.72,1.06)
    end
    fit()
    if camera then addConnection(camera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)) end
    enableSuicBlur()
    buildBackground(ui.root)
    local w=isMobile() and math.max(300,math.min(344,(camera and camera.ViewportSize.X or 360)-26)) or 430
    ui.card=new("Frame",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=colors.surface,BackgroundTransparency=0.02,BorderSizePixel=0,Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(w,0),AutomaticSize=Enum.AutomaticSize.Y,ZIndex=10},ui.root)
    corner(ui.card,isMobile() and 15 or 17)
    outline(ui.card,colors.border,0.08,1)
    local topGlow=new("Frame",{BackgroundColor3=colors.accent,BackgroundTransparency=0.88,BorderSizePixel=0,Position=UDim2.fromOffset(18,0),Size=UDim2.new(1,-36,0,1),ZIndex=11},ui.card)
    corner(topGlow,2)
    local shell=new("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(isMobile() and 16 or 20,18),Size=UDim2.new(1,-(isMobile() and 32 or 40),0),AutomaticSize=Enum.AutomaticSize.Y,ZIndex=12},ui.card)
    new("UIListLayout",{Padding=UDim.new(0,isMobile() and 9 or 11),FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder},shell)
    local header=new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,56)},shell)
    local iconWrap=new("Frame",{BackgroundColor3=colors.surface2,BorderSizePixel=0,Position=UDim2.fromOffset(0,3),Size=UDim2.fromOffset(36,36)},header)
    corner(iconWrap,10) outline(iconWrap,colors.borderSoft,0.12,1)
    local logo=markIcon(putIcon(iconWrap,"key",18,colors.accent),"key") logo.AnchorPoint=Vector2.new(0.5,0.5) logo.Position=UDim2.fromScale(0.5,0.5)
    local title=new("TextLabel",{BackgroundTransparency=1,Font=fonts.title,Position=UDim2.fromOffset(47,0),Size=UDim2.new(1,-90,0,27),Text=tostring(suic1de.Appearance.Title or ""),TextColor3=colors.text,TextSize=isMobile() and 19 or 21,TextXAlignment=Enum.TextXAlignment.Left},header)
    local subtitle=new("TextLabel",{BackgroundTransparency=1,Font=fonts.body,Position=UDim2.fromOffset(47,29),Size=UDim2.new(1,-52,0,18),Text=tostring(suic1de.Appearance.Subtitle or ""),TextColor3=colors.subtext,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left},header)
    ui.title=title ui.subtitle=subtitle
    local close=components.createCloseButton(header,function() suic1de:Destroy() end)
    close.Position=UDim2.new(1,-1,0,3) close.AnchorPoint=Vector2.new(1,0) ui.close=close
    local rule=new("Frame",{BackgroundColor3=colors.borderSoft,BackgroundTransparency=0.32,BorderSizePixel=0,Size=UDim2.new(1,0,0,1)},shell)
    ui.divider=rule
    local label=new("TextLabel",{BackgroundTransparency=1,Font=fonts.medium,Size=UDim2.new(1,0,0,15),Text="Key",TextColor3=colors.faint,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left},shell)
    local field=new("Frame",{BackgroundColor3=Color3.fromRGB(8,10,14),BorderSizePixel=0,Size=UDim2.new(1,0,0,isMobile() and 49 or 52)},shell)
    corner(field,11) local fs=outline(field,colors.borderSoft,0.1,1)
    local keySlot=new("Frame",{BackgroundTransparency=1,Position=UDim2.fromOffset(10,0),Size=UDim2.fromOffset(24,49)},field)
    local keyGlyph=markIcon(putIcon(keySlot,"key",15,colors.faint),"key") keyGlyph.AnchorPoint=Vector2.new(0.5,0.5) keyGlyph.Position=UDim2.fromScale(0.5,0.5)
    ui.input=new("TextBox",{BackgroundTransparency=1,ClearTextOnFocus=false,Font=fonts.mono,PlaceholderText="",Position=UDim2.fromOffset(42,0),Size=UDim2.new(1,-84,1,0),Text="",TextColor3=colors.text,TextSize=13,TextXAlignment=Enum.TextXAlignment.Left},field)
    local erase=new("TextButton",{AutoButtonColor=false,BackgroundTransparency=1,Font=fonts.medium,Position=UDim2.new(1,-36,0,0),Size=UDim2.fromOffset(32,49),Text="×",TextColor3=colors.faint,TextSize=17},field)
    addConnection(erase.MouseButton1Click:Connect(function() ui.input.Text="" ui.input:CaptureFocus() end))
    addConnection(ui.input.Focused:Connect(function() tween(fs,0.16,{Color=colors.accent,Transparency=0}) tween(keyGlyph,0.16,{ImageColor3=colors.accent}) end))
    addConnection(ui.input.FocusLost:Connect(function() tween(fs,0.16,{Color=colors.borderSoft,Transparency=0.1}) tween(keyGlyph,0.16,{ImageColor3=colors.faint}) end))
    ui.verify=iconButton(shell,"Verify","shield",isMobile() and 300 or 390,true)
    newStatusRow(shell)
    local actions=new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,40)},shell)
    local al=new("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Center,Padding=UDim.new(0,8),SortOrder=Enum.SortOrder.LayoutOrder},actions)
    ui.getKey=iconButton(actions,"Get Key","link",isMobile() and 145 or 188,false)
    ui.discord=iconButton(actions,"Discord","discord",isMobile() and 145 or 188,false)
    ui.getKey.Visible=tostring(suic1de.Links.GetKey or "")~=""
    ui.discord.Visible=tostring(suic1de.Links.Discord or "")~=""
    actions.Visible=ui.getKey.Visible or ui.discord.Visible
    local shopLink=tostring(suic1de.Shop.Link or "")
    if suic1de.Shop.Enabled and shopLink~="" then
        ui.shop=iconButton(shell,tostring(suic1de.Shop.ButtonText or "Buy"),"cart",isMobile() and 300 or 390,false)
    end
    local footer=new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,19)},shell)
    new("TextLabel",{BackgroundTransparency=1,Font=fonts.mono,Size=UDim2.fromScale(1,1),Text="suic1.de",TextColor3=colors.faint,TextSize=9,TextXAlignment=Enum.TextXAlignment.Center},footer)
    local verify=function(value)
        value=suic1de:NormalizeKey(value)
        if state.verifying then return end
        if os.clock()<state.cooldown then updateStatus("Wait a moment","warning") makeToast("Access",suic1de:GetCooldownText(),"warning") return end
        if value=="" then updateStatus("Enter a key","error") makeToast("Access","Enter a key","error") return end
        local cb=suic1de.Callbacks.OnVerify
        if type(cb)~="function" then updateStatus("Verifier not set","error") makeToast("Access","Verifier not set","error") return end
        state.verifying=true
        setButtonBusy(ui.verify,true,"Verify","shield")
        updateStatus("Checking","info")
        local ok,raw=pcall(cb,value)
        local valid,reason=false,"KEY_INVALID"
        if ok then valid,reason=normalizeResult(raw) else reason="ERROR" end
        if valid then
            state.failures=0
            setAccepted(value) saveKey(value)
            updateStatus("Verified","success") makeToast("Access","Verified","success")
            setButtonBusy(ui.verify,false,"Verified","check")
            local cb2=suic1de.Callbacks.OnSuccess
            if type(cb2)=="function" then task.spawn(function() pcall(cb2,value) end) end
            task.delay(0.4,function() if state.alive then suic1de:Destroy() end end)
            return
        end
        state.verifying=false
        setButtonBusy(ui.verify,false,"Verify","shield")
        if not suic1de:IsTransientError(reason) then suic1de:CountFailure(reason) end
        local message=suic1de:GetErrorText(reason)
        updateStatus(message,suic1de:IsTransientError(reason) and "warning" or "error")
        makeToast("Access",message,suic1de:IsTransientError(reason) and "warning" or "error")
        local cb3=suic1de.Callbacks.OnFail
        if type(cb3)=="function" then task.spawn(function() pcall(cb3,reason,value) end) end
        if reason=="HWID_BANNED" then task.delay(2,function() local lp=services.Players.LocalPlayer if lp then pcall(function() lp:Kick("Access blocked") end) end end) end
    end
    suic1de._verify=verify
    addConnection(ui.verify.MouseButton1Click:Connect(function() verify(ui.input.Text) end))
    addConnection(ui.input.FocusLost:Connect(function(enter) if enter then verify(ui.input.Text) end end))
    addConnection(services.Input.InputBegan:Connect(function(inp,processed) if processed or not state.alive then return end if inp.KeyCode==Enum.KeyCode.Return and ui.input and ui.input:IsFocused() then verify(ui.input.Text) end end))
    addConnection(ui.getKey.MouseButton1Click:Connect(function()
        local link=tostring(suic1de.Links.GetKey or "")
        if link=="" then makeToast("Get Key","Link not set","warning") return end
        local opened=false
        if type(cloneref)=="function" then
            local ok,web=pcall(function() return cloneref(game:GetService("WebViewService")) end)
            if ok and web then opened=pcall(function() web:OpenWindowV2(link) end) end
        end
        if not opened then
            if clipboard(link) then metrics.copied=(metrics.copied or 0)+1 makeToast("Get Key","Copied","success") else makeToast("Get Key","Unavailable","error") end
        end
    end))
    addConnection(ui.discord.MouseButton1Click:Connect(function()
        local link=tostring(suic1de.Links.Discord or "")
        if link=="" then makeToast("Discord","Link not set","warning") return end
        if clipboard(link) then metrics.copied=(metrics.copied or 0)+1 makeToast("Discord","Copied","success") else makeToast("Discord","Unavailable","error") end
    end))
    if ui.shop then addConnection(ui.shop.MouseButton1Click:Connect(function()
        local link=tostring(suic1de.Shop.Link or "")
        local opened=false
        local ok,web=pcall(function() return cloneref(game:GetService("WebViewService")) end)
        if ok and web then opened=pcall(function() web:OpenWindowV2(link) end) end
        if not opened and clipboard(link) then metrics.copied=(metrics.copied or 0)+1 makeToast("Premium","Copied","success") end
    end)) end
    if suic1de.Options.Draggable then
        local dragging=false local startPos local startInput
        addConnection(ui.card.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=true startInput=inp.Position startPos=ui.card.Position end end))
        addConnection(ui.card.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end end))
        addConnection(services.Input.InputChanged:Connect(function(inp) if not dragging then return end if inp.UserInputType~=Enum.UserInputType.MouseMovement and inp.UserInputType~=Enum.UserInputType.Touch then return end local d=inp.Position-startInput ui.card.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end))
    end
    ui.card.Position=UDim2.new(0.5,0,0.5,15) ui.card.BackgroundTransparency=1
    tween(ui.card,0.44,{Position=UDim2.fromScale(0.5,0.5),BackgroundTransparency=0.02},Enum.EasingStyle.Quart)
    tween(topGlow,0.65,{BackgroundTransparency=0.72},Enum.EasingStyle.Sine)
    state.alive=true
    if camera then addConnection(camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() ui.card.Size=UDim2.fromOffset(getResponsiveWidth(),ui.card.AbsoluteSize.Y) end)) end
    task.delay(0.05,function() refreshIcons(ui.root) end)
    task.delay(0.8,function() refreshIcons(ui.root) end)
    createIntro(ui.root,w)
end
local oldDestroy2=suic1de.Destroy
suic1de.Destroy=function(self)
    disableSuicBlur()
    local ok,res=pcall(oldDestroy2,self)
    state.toastHolder=nil
    return ok,res
end
suic1de.IconUrls={Lucide=ICON_LUCIDE_URL,Solar=ICON_SOLAR_URL}
suic1de.IconPacks=iconPacks
suic1de.GetIcon=function(_,name) return iconAsset(name) end
suic1de:ValidateAll()

return suic1de
