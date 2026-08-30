local Beliau = {}
Beliau.__index = Beliau

local LucideIcons = {
	["key"] = "rbxassetid://91606920959253",
	["lock"] = "rbxassetid://91606913926451",
	["x"] = "rbxassetid://91606929706661",
	["copy"] = "rbxassetid://91606921932169",
	["check"] = "rbxassetid://91606909355213",
	["alert-circle"] = "rbxassetid://91606925573411",
	["loader"] = "rbxassetid://91606918277369",
	["link"] = "rbxassetid://91606924114397",
	["discord"] = "rbxassetid://91606914883429",
	["settings"] = "rbxassetid://91606927499707",
	["info"] = "rbxassetid://91606916250107",
	["eye"] = "rbxassetid://91606911567603",
	["eye-off"] = "rbxassetid://91606913070297",
	["package"] = "rbxassetid://91606922652541",
	["arrow-right"] = "rbxassetid://91606908589205",
	["menu"] = "rbxassetid://91606920176903",
	["shield"] = "rbxassetid://91606926332589",
	["zap"] = "rbxassetid://91606930824391",
	["star"] = "rbxassetid://91606928661449",
	["clock"] = "rbxassetid://91606910423571",
	["user"] = "rbxassetid://91606929101493",
	["mail"] = "rbxassetid://91606919482605",
	["bell"] = "rbxassetid://91606908961337",
	["chart"] = "rbxassetid://91606909712349",
	["credit-card"] = "rbxassetid://91606911234567",
}

local ThemePresets = {
	dark = {
		Accent = Color3.fromRGB(110, 60, 255),
		AccentHover = Color3.fromRGB(130, 90, 255),
		Background = Color3.fromRGB(10, 10, 20),
		Header = Color3.fromRGB(15, 15, 30),
		Input = Color3.fromRGB(20, 20, 40),
		Text = Color3.fromRGB(255, 255, 255),
		TextDim = Color3.fromRGB(160, 160, 200),
		Success = Color3.fromRGB(0, 220, 180),
		Error = Color3.fromRGB(255, 70, 90),
		StatusIdle = Color3.fromRGB(120, 100, 200),
	},
	light = {
		Accent = Color3.fromRGB(100, 200, 255),
		AccentHover = Color3.fromRGB(120, 220, 255),
		Background = Color3.fromRGB(245, 245, 250),
		Header = Color3.fromRGB(240, 240, 248),
		Input = Color3.fromRGB(230, 230, 240),
		Text = Color3.fromRGB(20, 20, 30),
		TextDim = Color3.fromRGB(100, 100, 120),
		Success = Color3.fromRGB(0, 200, 150),
		Error = Color3.fromRGB(230, 50, 70),
		StatusIdle = Color3.fromRGB(100, 150, 200),
	},
	midnight = {
		Accent = Color3.fromRGB(0, 150, 255),
		AccentHover = Color3.fromRGB(50, 180, 255),
		Background = Color3.fromRGB(5, 5, 15),
		Header = Color3.fromRGB(10, 10, 25),
		Input = Color3.fromRGB(15, 15, 35),
		Text = Color3.fromRGB(240, 240, 255),
		TextDim = Color3.fromRGB(150, 150, 180),
		Success = Color3.fromRGB(0, 230, 190),
		Error = Color3.fromRGB(255, 80, 100),
		StatusIdle = Color3.fromRGB(0, 100, 180),
	},
}

function Beliau.new()
	local self = setmetatable({}, Beliau)
	
	self.Appearance = {
		Title = "Beliau",
		Subtitle = "Authentication Required",
		Tagline = "Premium keysystem protection",
		Icon = "",
		IconSize = UDim2.fromOffset(40, 40),
		LogoVisible = true,
	}
	
	self.Links = {
		GetKey = "",
		Discord = "",
		Website = "",
	}
	
	self.Storage = {
		FileName = "Beliau_key",
		Remember = true,
		AutoLoad = true,
		Encrypted = false,
	}
	
	self.Theme = ThemePresets.dark
	
	self.Options = {
		Blur = true,
		Draggable = true,
		TouchFriendly = true,
		ShowLoadingScreen = true,
		AnimationSpeed = 0.35,
		ReducedMotion = false,
		ShowStatusBar = true,
		ParticleEffects = true,
		MaxAttempts = 5,
		AttemptTimeout = 300,
		KeylessMode = nil,
		KeylessUI = true,
	}
	
	self.Shop = {
		Enabled = false,
		Icon = "",
		Title = "Get Premium",
		Subtitle = "Instant delivery",
		ButtonText = "Purchase",
		Link = "",
	}
	
	self.Callbacks = {
		OnSuccess = function() end,
		OnFail = function(msg) end,
		OnClose = function() end,
		OnVerify = function(key) return false end,
		OnAttemptLimitReached = function() end,
	}
	
	self.Changelog = {}
	
	self.Internal = {
		Notifications = {},
		UIElements = {},
		DragState = {},
		Session = {
			Key = nil,
			Valid = false,
			Attempts = 0,
			LastAttemptTime = 0,
		},
		BlurEffect = nil,
		MainGui = nil,
		LoadingGui = nil,
		JunkieSDK = nil,
		IsDestroyed = false,
	}
	
	return self
end

function Beliau:_log(level, msg)
	if level == "error" then
		warn("[Beliau Error] " .. msg)
	elseif level == "warn" then
		warn("[Beliau] " .. msg)
	end
end

function Beliau:_createLoadingScreen()
	if not self.Options.ShowLoadingScreen then return end
	
	local lg = Instance.new("ScreenGui")
	lg.Name = "BliauLoading"
	lg.ResetOnSpawn = false
	lg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	lg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	local bg = Instance.new("Frame")
	bg.BackgroundColor3 = self.Theme.Background
	bg.BackgroundTransparency = 0
	bg.Size = UDim2.fromScale(1, 1)
	bg.BorderSizePixel = 0
	bg.Parent = lg
	
	local center = Instance.new("Frame")
	center.BackgroundTransparency = 1
	center.Size = UDim2.new(0, 200, 0, 200)
	center.Position = UDim2.new(0.5, -100, 0.5, -100)
	center.Parent = bg
	
	local spinner = Instance.new("ImageLabel")
	spinner.BackgroundTransparency = 1
	spinner.Image = LucideIcons["loader"]
	spinner.ImageColor3 = self.Theme.Accent
	spinner.Size = UDim2.new(0, 60, 0, 60)
	spinner.Position = UDim2.new(0.5, -30, 0.5, -30)
	spinner.Parent = center
	
	local rot = Instance.new("BodyGyro")
	rot.Parent = spinner
	
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.TextColor3 = self.Theme.Text
	label.TextSize = 14
	label.Font = Enum.Font.GothamBold
	label.Text = "Loading..."
	label.Size = UDim2.new(1, 0, 0, 30)
	label.Position = UDim2.new(0, 0, 0, 80)
	label.Parent = center
	
	self.Internal.LoadingGui = lg
	
	local angle = 0
	local conn
	conn = game:GetService("RunService").RenderStepped:Connect(function()
		if not lg.Parent then
			conn:Disconnect()
			return
		end
		angle = angle + 5
		spinner.Rotation = angle
	end)
	
	return lg
end

function Beliau:_removeLoadingScreen()
	if self.Internal.LoadingGui then
		self.Internal.LoadingGui:Destroy()
		self.Internal.LoadingGui = nil
	end
end

function Beliau:_createNotification(title, msg, duration, notifType)
	if #self.Internal.Notifications > 5 then
		local old = table.remove(self.Internal.Notifications, 1)
		if old.gui then pcall(function() old.gui:Destroy() end) end
	end
	
	local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	local sg = Instance.new("ScreenGui")
	sg.Name = "BToastNotif" .. math.random(10000, 99999)
	sg.ResetOnSpawn = false
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.Parent = PlayerGui
	
	local toastColor = self.Theme.StatusIdle
	if notifType == "success" then
		toastColor = self.Theme.Success
	elseif notifType == "error" then
		toastColor = self.Theme.Error
	end
	
	local toast = Instance.new("Frame")
	toast.Name = "Toast"
	toast.BackgroundColor3 = self.Theme.Input
	toast.BackgroundTransparency = 0.15
	toast.BorderSizePixel = 0
	toast.Size = UDim2.new(0, 360, 0, 100)
	toast.Position = UDim2.new(1, 30, 1, 30)
	toast.AnchorPoint = Vector2.new(1, 1)
	toast.Parent = sg
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = toast
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = toastColor
	stroke.Thickness = 2
	stroke.Transparency = 0.4
	stroke.Parent = toast
	
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 18)
	pad.PaddingRight = UDim.new(0, 18)
	pad.PaddingTop = UDim.new(0, 14)
	pad.PaddingBottom = UDim.new(0, 14)
	pad.Parent = toast
	
	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Spacing = UDim.new(0, 6)
	layout.Parent = toast
	
	local titleLbl = Instance.new("TextLabel")
	titleLbl.BackgroundTransparency = 1
	titleLbl.TextColor3 = toastColor
	titleLbl.TextSize = 14
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.Text = title
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Size = UDim2.new(1, 0, 0, 20)
	titleLbl.Parent = toast
	
	local msgLbl = Instance.new("TextLabel")
	msgLbl.BackgroundTransparency = 1
	msgLbl.TextColor3 = self.Theme.TextDim
	msgLbl.TextSize = 11
	msgLbl.Font = Enum.Font.Gotham
	msgLbl.Text = msg
	msgLbl.TextWrapped = true
	msgLbl.TextXAlignment = Enum.TextXAlignment.Left
	msgLbl.Size = UDim2.new(1, 0, 0, 50)
	msgLbl.Parent = toast
	
	local ts = game:GetService("TweenService")
	local slideIn = ts:Create(toast, TweenInfo.new(self.Options.AnimationSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 1, -110)})
	slideIn:Play()
	
	if duration then
		task.wait(duration)
		local slideOut = ts:Create(toast, TweenInfo.new(self.Options.AnimationSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 30, 1, 30)})
		slideOut:Play()
		slideOut.Completed:Connect(function()
			pcall(function() sg:Destroy() end)
		end)
	end
	
	table.insert(self.Internal.Notifications, {gui = sg})
	return sg
end

function Beliau:_setupBlur()
	if not self.Options.Blur then return end
	
	local blur = Instance.new("BlurEffect")
	blur.Size = 0
	blur.Parent = game.Lighting
	
	local ts = game:GetService("TweenService")
	local fadeIn = ts:Create(blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24})
	fadeIn:Play()
	
	self.Internal.BlurEffect = blur
end

function Beliau:_removeBlur()
	if not self.Internal.BlurEffect then return end
	
	local ts = game:GetService("TweenService")
	local fadeOut = ts:Create(self.Internal.BlurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = 0})
	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		pcall(function() self.Internal.BlurEffect:Destroy() end)
		self.Internal.BlurEffect = nil
	end)
end

function Beliau:_enableDrag(dragHandle, targetFrame)
	local inp = game:GetService("UserInputService")
	local mouse = game.Players.LocalPlayer:GetMouse()
	
	dragHandle.InputBegan:Connect(function(input, gp)
		if gp or not self.Options.Draggable then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		
		self.Internal.DragState.active = true
		self.Internal.DragState.frame = targetFrame
		self.Internal.DragState.offsetX = mouse.X - targetFrame.AbsolutePosition.X
		self.Internal.DragState.offsetY = mouse.Y - targetFrame.AbsolutePosition.Y
	end)
	
	inp.InputChanged:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
		if not self.Internal.DragState.active or not self.Internal.DragState.frame then return end
		
		local newX = math.max(0, math.min(mouse.X - self.Internal.DragState.offsetX, game:GetService("UserInputService"):GetMouseLocation().X + 500))
		local newY = math.max(0, math.min(mouse.Y - self.Internal.DragState.offsetY, game:GetService("UserInputService"):GetMouseLocation().Y + 500))
		
		self.Internal.DragState.frame.Position = UDim2.new(0, newX, 0, newY)
	end)
	
	inp.InputEnded:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
		self.Internal.DragState.active = false
		self.Internal.DragState.frame = nil
	end)
end

function Beliau:_createButton(parent, text, color, callback, size)
	local btn = Instance.new("TextButton")
	btn.BackgroundColor3 = color
	btn.BackgroundTransparency = 0
	btn.BorderSizePixel = 0
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.Size = size or UDim2.new(0, 120, 0, 42)
	btn.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = btn
	
	local hoverConn
	hoverConn = btn.MouseEnter:Connect(function()
		local lighter = Color3.new(
			math.min(color.R + 0.1, 1),
			math.min(color.G + 0.1, 1),
			math.min(color.B + 0.1, 1)
		)
		local ts = game:GetService("TweenService")
		local hover = ts:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = lighter})
		hover:Play()
	end)
	
	btn.MouseLeave:Connect(function()
		local ts = game:GetService("TweenService")
		local unhover = ts:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = color})
		unhover:Play()
	end)
	
	btn.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
	
	return btn
end

function Beliau:_createMainUI()
	local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
	local mainGui = Instance.new("ScreenGui")
	mainGui.Name = "BliauMainUI"
	mainGui.ResetOnSpawn = false
	mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	mainGui.Parent = PlayerGui
	
	self:_setupBlur()
	
	local backdrop = Instance.new("Frame")
	backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	backdrop.BackgroundTransparency = 0.5
	backdrop.Size = UDim2.fromScale(1, 1)
	backdrop.BorderSizePixel = 0
	backdrop.Parent = mainGui
	
	local card = Instance.new("Frame")
	card.BackgroundColor3 = self.Theme.Background
	card.BackgroundTransparency = 0.05
	card.BorderSizePixel = 0
	card.Size = UDim2.new(0, 450, 0, 580)
	card.Position = UDim2.new(0.5, -225, 0.5, -290)
	card.Parent = mainGui
	
	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 20)
	cardCorner.Parent = card
	
	local cardStroke = Instance.new("UIStroke")
	cardStroke.Color = self.Theme.Accent
	cardStroke.Thickness = 1.5
	cardStroke.Transparency = 0.35
	cardStroke.Parent = card
	
	local cardPad = Instance.new("UIPadding")
	cardPad.PaddingLeft = UDim.new(0, 32)
	cardPad.PaddingRight = UDim.new(0, 32)
	cardPad.PaddingTop = UDim.new(0, 30)
	cardPad.PaddingBottom = UDim.new(0, 30)
	cardPad.Parent = card
	
	local cardLayout = Instance.new("UIListLayout")
	cardLayout.FillDirection = Enum.FillDirection.Vertical
	cardLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	cardLayout.Spacing = UDim.new(0, 22)
	cardLayout.Parent = card
	
	local headerFrame = Instance.new("Frame")
	headerFrame.BackgroundTransparency = 1
	headerFrame.Size = UDim2.new(1, 0, 0, 70)
	headerFrame.Parent = card
	
	local headerLayout = Instance.new("UIListLayout")
	headerLayout.FillDirection = Enum.FillDirection.Vertical
	headerLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	headerLayout.Spacing = UDim.new(0, 12)
	headerLayout.Parent = headerFrame
	
	local titleLbl = Instance.new("TextLabel")
	titleLbl.BackgroundTransparency = 1
	titleLbl.TextColor3 = self.Theme.Text
	titleLbl.TextSize = 32
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.Text = self.Appearance.Title
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Size = UDim2.new(1, 0, 0, 36)
	titleLbl.Parent = headerFrame
	
	local subtitleLbl = Instance.new("TextLabel")
	subtitleLbl.BackgroundTransparency = 1
	subtitleLbl.TextColor3 = self.Theme.TextDim
	subtitleLbl.TextSize = 12
	subtitleLbl.Font = Enum.Font.Gotham
	subtitleLbl.Text = self.Appearance.Subtitle
	subtitleLbl.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLbl.Size = UDim2.new(1, 0, 0, 16)
	subtitleLbl.Parent = headerFrame
	
	local inputBgFrame = Instance.new("Frame")
	inputBgFrame.BackgroundColor3 = self.Theme.Input
	inputBgFrame.BackgroundTransparency = 0.3
	inputBgFrame.BorderSizePixel = 0
	inputBgFrame.Size = UDim2.new(1, 0, 0, 56)
	inputBgFrame.Parent = card
	
	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 12)
	inputCorner.Parent = inputBgFrame
	
	local inputStroke = Instance.new("UIStroke")
	inputStroke.Color = self.Theme.Accent
	inputStroke.Thickness = 1
	inputStroke.Transparency = 0.65
	inputStroke.Parent = inputBgFrame
	
	local inputPad = Instance.new("UIPadding")
	inputPad.PaddingLeft = UDim.new(0, 16)
	inputPad.PaddingRight = UDim.new(0, 16)
	inputPad.Parent = inputBgFrame
	
	local keyInput = Instance.new("TextBox")
	keyInput.BackgroundTransparency = 1
	keyInput.TextColor3 = self.Theme.Text
	keyInput.PlaceholderColor3 = self.Theme.TextDim
	keyInput.PlaceholderText = "Enter your key..."
	keyInput.TextSize = 14
	keyInput.Font = Enum.Font.Gotham
	keyInput.Size = UDim2.new(1, 0, 1, 0)
	keyInput.Parent = inputBgFrame
	
	local buttonFrame = Instance.new("Frame")
	buttonFrame.BackgroundTransparency = 1
	buttonFrame.Size = UDim2.new(1, 0, 0, 50)
	buttonFrame.Parent = card
	
	local btnLayout = Instance.new("UIListLayout")
	btnLayout.FillDirection = Enum.FillDirection.Horizontal
	btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	btnLayout.Spacing = UDim.new(0, 12)
	btnLayout.Parent = buttonFrame
	
	local verifyBtn = self:_createButton(buttonFrame, "Verify", self.Theme.Accent, nil, UDim2.new(0.65, -6, 1, 0))
	local getKeyBtn = self:_createButton(buttonFrame, "Get Key", self.Theme.StatusIdle, nil, UDim2.new(0.35, -6, 1, 0))
	
	local statusFrame = Instance.new("Frame")
	statusFrame.BackgroundColor3 = self.Theme.Header
	statusFrame.BackgroundTransparency = 0.4
	statusFrame.BorderSizePixel = 0
	statusFrame.Size = UDim2.new(1, 0, 0, 48)
	statusFrame.Parent = card
	
	local statusCorner = Instance.new("UICorner")
	statusCorner.CornerRadius = UDim.new(0, 10)
	statusCorner.Parent = statusFrame
	
	local statusPad = Instance.new("UIPadding")
	statusPad.PaddingLeft = UDim.new(0, 12)
	statusPad.PaddingRight = UDim.new(0, 12)
	statusPad.Parent = statusFrame
	
	local statusLabel = Instance.new("TextLabel")
	statusLabel.BackgroundTransparency = 1
	statusLabel.TextColor3 = self.Theme.TextDim
	statusLabel.TextSize = 11
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.Text = "Ready"
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.Size = UDim2.new(1, 0, 1, 0)
	statusLabel.Parent = statusFrame
	
	local footerLbl = Instance.new("TextLabel")
	footerLbl.BackgroundTransparency = 1
	footerLbl.TextColor3 = self.Theme.TextDim
	footerLbl.TextSize = 11
	footerLbl.Font = Enum.Font.Gotham
	footerLbl.Text = self.Appearance.Tagline
	footerLbl.TextWrapped = true
	footerLbl.Size = UDim2.new(1, 0, 0, 40)
	footerLbl.Parent = card
	
	self.Internal.UIElements = {
		mainGui = mainGui,
		card = card,
		keyInput = keyInput,
		verifyBtn = verifyBtn,
		getKeyBtn = getKeyBtn,
		statusLabel = statusLabel,
	}
	
	self.Internal.MainGui = mainGui
	
	self:_enableDrag(card, card)
	
	return {
		gui = mainGui,
		keyInput = keyInput,
		verifyBtn = verifyBtn,
		getKeyBtn = getKeyBtn,
		statusLabel = statusLabel,
	}
end

function Beliau:_updateStatus(text, isError)
	if self.Internal.UIElements.statusLabel then
		local color = isError and self.Theme.Error or self.Theme.Success
		self.Internal.UIElements.statusLabel.TextColor3 = color
		self.Internal.UIElements.statusLabel.Text = text
	end
end

function Beliau:_storeKey(key)
	if not isfolder("BliauUI") then
		makefolder("BliauUI")
	end
	
	local fname = "BliauUI/" .. self.Storage.FileName .. ".txt"
	writefile(fname, key)
end

function Beliau:_retrieveKey()
	local fname = "BliauUI/" .. self.Storage.FileName .. ".txt"
	if isfile(fname) then
		return readfile(fname)
	end
	return nil
end

function Beliau:_handleKeyVerification(keyText)
	if not keyText or keyText == "" then
		self:_updateStatus("Key required", true)
		self:_createNotification("Input Error", "Please enter a key", 3, "error")
		return
	end
	
	if self.Internal.Session.Attempts >= self.Options.MaxAttempts then
		self:_updateStatus("Max attempts exceeded", true)
		self:_createNotification("Locked", "Too many failed attempts", 5, "error")
		self.Callbacks.OnAttemptLimitReached()
		return
	end
	
	self:_updateStatus("Verifying key...", false)
	self.Internal.UIElements.verifyBtn.Enabled = false
	
	local isValid = self.Callbacks.OnVerify(keyText)
	
	if isValid then
		self.Internal.Session.Key = keyText
		self.Internal.Session.Valid = true
		
		if self.Storage.Remember then
			self:_storeKey(keyText)
		end
		
		self:_updateStatus("Verified successfully", false)
		self:_createNotification("Success", "Key verified successfully", 2, "success")
		
		task.wait(1.5)
		
		self:_removeLoadingScreen()
		self:_removeBlur()
		
		if self.Internal.MainGui then
			self.Internal.MainGui:Destroy()
			self.Internal.MainGui = nil
		end
		
		self.Callbacks.OnSuccess()
	else
		self.Internal.Session.Attempts = self.Internal.Session.Attempts + 1
		local remaining = self.Options.MaxAttempts - self.Internal.Session.Attempts
		
		if remaining > 0 then
			self:_updateStatus("Invalid key - Attempts: " .. remaining, true)
			self:_createNotification("Failed", "Invalid key provided", 3, "error")
		else
			self:_updateStatus("Maximum attempts reached", true)
			self:_createNotification("Locked", "Too many failed attempts", 5, "error")
			self.Callbacks.OnAttemptLimitReached()
		end
	end
	
	self.Internal.UIElements.verifyBtn.Enabled = true
end

function Beliau:Launch()
	self:_removeLoadingScreen()
	
	local ui = self:_createMainUI()
	
	if self.Storage.AutoLoad then
		local saved = self:_retrieveKey()
		if saved and saved ~= "" then
			ui.keyInput.Text = saved
			task.wait(0.4)
			self:_handleKeyVerification(saved)
			return
		end
	end
	
	ui.verifyBtn.MouseButton1Click:Connect(function()
		self:_handleKeyVerification(ui.keyInput.Text)
	end)
	
	ui.getKeyBtn.MouseButton1Click:Connect(function()
		if self.Links.GetKey ~= "" then
			setclipboard(self.Links.GetKey)
			self:_createNotification("Copied", "Get key link copied to clipboard", 2, "success")
		else
			self:_createNotification("Error", "No key link configured", 2, "error")
		end
	end)
	
	ui.keyInput.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			self:_handleKeyVerification(ui.keyInput.Text)
		end
	end)
end

function Beliau:LaunchJunkie(cfg)
	self:_createLoadingScreen()
	
	task.spawn(function()
		local jnk = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
		self.Internal.JunkieSDK = jnk
		
		jnk.service = cfg.Service
		jnk.identifier = cfg.Identifier
		jnk.provider = cfg.Provider
		
		self.Callbacks.OnVerify = function(key)
			if not jnk or not jnk.check_key then
				return false
			end
			local res = jnk.check_key(key)
			return res and res.valid == true
		end
		
		task.wait(0.5)
		self:Launch()
	end)
end

function Beliau:GetSavedKey()
	return self:_retrieveKey()
end

function Beliau:ClearSavedKey()
	local fname = "BliauUI/" .. self.Storage.FileName .. ".txt"
	if isfile(fname) then
		delfile(fname)
	end
end

function Beliau:Notify(title, message, duration, notifType)
	self:_createNotification(title, message, duration, notifType)
end

function Beliau:SetTheme(themeName)
	if ThemePresets[themeName] then
		self.Theme = ThemePresets[themeName]
	end
end

function Beliau:Destroy()
	if self.Internal.IsDestroyed then return end
	self.Internal.IsDestroyed = true
	
	self:_removeLoadingScreen()
	self:_removeBlur()
	
	if self.Internal.MainGui then
		pcall(function() self.Internal.MainGui:Destroy() end)
		self.Internal.MainGui = nil
	end
	
	for _, notif in ipairs(self.Internal.Notifications) do
		if notif.gui then
			pcall(function() notif.gui:Destroy() end)
		end
	end
	
	self.Internal.Notifications = {}
	self.Callbacks.OnClose()
end

if not getgenv().BliauUI then
	getgenv().BliauUI = Beliau.new()
end

return Beliau.new()
