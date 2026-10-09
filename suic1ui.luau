local library = {flags = {}, windows = {}, open = true}

--Services
local runService = game:GetService"RunService"
local tweenService = game:GetService"TweenService"
local textService = game:GetService"TextService"
local inputService = game:GetService"UserInputService"
local ui = Enum.UserInputType.MouseButton1
local blacklistedKeys = {}
local whitelistedMouseinputs = {
	Enum.UserInputType.MouseButton1,
	Enum.UserInputType.MouseButton2,
	Enum.UserInputType.MouseButton3,
}
--Locals
local dragging, dragInput, dragStart, startPos, dragObject

--Functions
local function round(num, bracket)
	bracket = bracket or 1
	local a = math.floor(num/bracket + (math.sign(num) * 0.5)) * bracket
	if a < 0 then
		a = a + bracket
	end
	return a
end

local function keyCheck(x,x1)
	for _,v in next, x1 do
		if v == x then
			return true
		end
	end
end

local function update(input)
	local delta = input.Position - dragStart
	local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
	dragObject:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quint", 0.1, true)
end
 
--From: https://devforum.roblox.com/t/how-to-create-a-simple-rainbow-effect-using-tweenService/221849/2
local chromaColor
local rainbowTime = 5
spawn(function()
	while wait() do
		chromaColor = Color3.fromHSV(tick() % rainbowTime / rainbowTime, 1, 1)
	end
end)

function library:Create(class, properties)
	properties = typeof(properties) == "table" and properties or {}
	local inst = Instance.new(class)
	for property, value in next, properties do
		pcall(function() inst[property] = value end)
	end
	if (class == "TextLabel" or class == "TextButton" or class == "TextBox") and self.Font then
		pcall(function() inst.Font = self.Font end)
	end
	return inst
end

local function createOptionHolder(holderTitle, parent, parentTable, subHolder)
	local size = subHolder and 34 or 40
	local windowWidth = 260
	local camera = workspace.CurrentCamera
	local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
	local maxHeight = math.max(240, math.min(560, viewport.Y - 56))
	local visibleHeight = math.max(1, maxHeight - size)
	local xPosition = subHolder and (20 + (250 * (parentTable.position or 0))) or math.max(8, math.floor((viewport.X - windowWidth) * 0.5))
	parentTable.main = library:Create("ImageButton", {
		LayoutOrder = subHolder and parentTable.position or 0,
		Position = UDim2.fromOffset(xPosition, subHolder and 0 or 12),
		Size = UDim2.fromOffset(windowWidth, size),
		BackgroundTransparency = 1,
		Image = "",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Stretch,
		ClipsDescendants = true,
		Parent = parent
	})
	
	local round
	if not subHolder then
		round = library:Create("ImageLabel", {
			Size = UDim2.new(1, 0, 0, size),
			BackgroundTransparency = 1,
			Image = "",
			ImageColor3 = parentTable.open and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6),
			ScaleType = Enum.ScaleType.Stretch,
			Parent = parentTable.main
		})
	end
	
	local title = library:Create("TextLabel", {
		Size = UDim2.new(1, -34, 0, size),
		Position = UDim2.fromOffset(8, 0),
		BackgroundTransparency = subHolder and 0 or 1,
		BackgroundColor3 = Color3.fromRGB(10, 10, 10),
		BorderSizePixel = 0,
		Text = tostring(holderTitle or "Window"),
		TextSize = subHolder and 15 or 17,
		Font = library.Font or Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = parentTable.main
	})
	
	local closeHolder = library:Create("TextButton", {
		Position = UDim2.new(1, -32, 0, 0),
		Size = UDim2.fromOffset(32, size),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = parentTable.main
	})
	
	local close = library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		Rotation = parentTable.open and 90 or 180,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4918373417",
		ImageColor3 = parentTable.open and Color3.fromRGB(120, 120, 120) or Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Fit,
		Parent = closeHolder
	})
	
	local contentClass = subHolder and "Frame" or "ScrollingFrame"
	parentTable.content = library:Create(contentClass, {
		Position = UDim2.new(0, 0, 0, size),
		Size = UDim2.new(1, 0, 0, visibleHeight),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ScrollBarThickness = subHolder and 0 or 3,
		ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = parentTable.main
	})
	
	local layout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2),
		Parent = parentTable.content
	})
	
	local function refreshLayout()
		local contentHeight = layout.AbsoluteContentSize.Y + 8
		if subHolder then
			parentTable.content.Size = UDim2.new(1, 0, 0, contentHeight)
			parentTable.main.Size = #parentTable.options > 0 and parentTable.open and UDim2.fromOffset(windowWidth, contentHeight + size) or UDim2.fromOffset(windowWidth, size)
		else
			local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 600)
			local maxH = math.max(240, math.min(560, vp.Y - 56))
			local bodyH = math.max(1, maxH - size)
			parentTable.content.Size = UDim2.new(1, 0, 0, bodyH)
			parentTable.content.CanvasSize = UDim2.fromOffset(0, contentHeight)
			parentTable.main.Size = #parentTable.options > 0 and parentTable.open and UDim2.fromOffset(windowWidth, math.min(contentHeight + size, maxH)) or UDim2.fromOffset(windowWidth, size)
		end
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshLayout)

	if not subHolder then
		library:Create("UIPadding", {PaddingLeft=UDim.new(0,6), PaddingRight=UDim.new(0,6), PaddingTop=UDim.new(0,4), PaddingBottom=UDim.new(0,4), Parent=parentTable.content})
		title.InputBegan:Connect(function(input)
			if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
				dragObject=parentTable.main; dragging=true; dragStart=input.Position; startPos=dragObject.Position
			end
		end)
		title.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then dragInput=input end
		end)
		title.InputEnded:Connect(function(input)
			if input.UserInputType==ui or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
		end)
	end
	local function toggleHolder()
		parentTable.open=not parentTable.open
		tweenService:Create(close,TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Rotation=parentTable.open and 90 or 180,ImageColor3=parentTable.open and Color3.fromRGB(120,120,120) or Color3.fromRGB(60,60,60)}):Play()
		if round then tweenService:Create(round,TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{ImageColor3=parentTable.open and Color3.fromRGB(10,10,10) or Color3.fromRGB(6,6,6)}):Play() end
		refreshLayout()
	end
	closeHolder.InputBegan:Connect(function(input) if input.UserInputType==ui or input.UserInputType==Enum.UserInputType.Touch then toggleHolder() end end)
	refreshLayout()
	function parentTable:SetTitle(newTitle) title.Text=tostring(newTitle); return self end
	function parentTable:SetVisible(v) if self.main then self.main.Visible=v~=false end; return self end
	function parentTable:IsVisible() return self.main and self.main.Visible or false end
	return parentTable
end

local function createLabel(option, parent)
	local main = library:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	setmetatable(option, {__newindex = function(t, i, v)
		if i == "Text" then
			main.Text = " " .. tostring(v)
		end
	end})
end

function createToggle(option, parent)
	local main = library:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 31),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	local tickboxOutline = library:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(-1, 10, 1, -10),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(100, 100, 100),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local tickboxInner = library:Create("ImageLabel", {
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = tickboxOutline
	})
	
	local checkmarkHolder = library:Create("Frame", {
		Position = UDim2.new(0, 4, 0, 4),
		Size = option.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = tickboxOutline
	})
	
	local checkmark = library:Create("ImageLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4919148038",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		Parent = checkmarkHolder
	})
	
	local inContact
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			option:SetState(not option.state)
		elseif input.UserInputType == Enum.UserInputType.Touch then
			option:SetState(not option.state)
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.state then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			end
		end
	end)
	
	main.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.state then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	function option:SetState(state)
		library.flags[self.flag] = state
		self.state = state
		checkmarkHolder:TweenSize(option.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8), "Out", "Quad", 0.2, true)
		tweenService:Create(tickboxInner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(20, 20, 20)}):Play()
		if state then
			tweenService:Create(tickboxOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		else
			if inContact then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			else
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
		self.callback(state)
	end

	if option.state then
		delay(1, function() option.callback(true) end)
	end
	
	setmetatable(option, {__newindex = function(t, i, v)
		if i == "Text" then
			main.Text = " " .. tostring(v)
		end
	end})
end

function createButton(option, parent)
	local main = library:Create("TextLabel", {
		ZIndex = 2,
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = parent.content
	})
	
	local round = library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local inContact
	local clicking
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			library.flags[option.flag] = true
			clicking = true
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			option.callback()
		elseif input.UserInputType == Enum.UserInputType.Touch then
			library.flags[option.flag] = true
			clicking = true
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			option.callback()
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		end
	end)
	
	main.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			clicking = false
			if inContact then
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			clicking = false
			if inContact then
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not clicking then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
end

local function createBind(option, parent)
	local binding
	local holding
	local loop
	local text = string.match(option.key, "Mouse") and string.sub(option.key, 1, 5) .. string.sub(option.key, 12, 13) or option.key

	local main = library:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 33),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	local round = library:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(0, -textService:GetTextSize(text, 16, Enum.Font.GothamBlack, Vector2.new(9e9, 9e9)).X - 16, 1, -10),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local bindinput = library:Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextSize = 16,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = round
	})
	
	local inContact
	main.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not binding then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)
	 
	main.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			binding = true
			bindinput.Text = "..."
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		elseif input.UserInputType == Enum.UserInputType.Touch then
			binding = true
			bindinput.Text = "..."
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not binding then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
	
	inputService.InputBegan:connect(function(input)
		if inputService:GetFocusedTextBox() then return end
		if (input.KeyCode.Name == option.key or input.UserInputType.Name == option.key) and not binding then
			if option.hold then
				loop = runService.Heartbeat:connect(function()
					if binding then
						option.callback(true)
						loop:Disconnect()
						loop = nil
					else
						option.callback()
					end
				end)
			else
				option.callback()
			end
		elseif binding then
			local key
			pcall(function()
				if not keyCheck(input.KeyCode, blacklistedKeys) then
					key = input.KeyCode
				end
			end)
			pcall(function()
				if keyCheck(input.UserInputType, whitelistedMouseinputs) and not key then
					key = input.UserInputType
				end
			end)
			key = key or option.key
			option:SetKey(key)
		end
	end)
	
	inputService.InputEnded:connect(function(input)
		if input.KeyCode.Name == option.key or input.UserInputType.Name == option.key or input.UserInputType.Name == "MouseMovement" then
			if loop then
				loop:Disconnect()
				loop = nil
				option.callback(true)
			end
		end
	end)
	
	function option:SetKey(key)
		binding = false
		if loop then
			loop:Disconnect()
			loop = nil
		end
		self.key = key or self.key
		self.key = self.key.Name or self.key
		library.flags[self.flag] = self.key
		if string.match(self.key, "Mouse") then
			bindinput.Text = string.sub(self.key, 1, 5) .. string.sub(self.key, 12, 13)
		else
			bindinput.Text = self.key
		end
		tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = inContact and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)}):Play()
		round.Size = UDim2.new(0, -textService:GetTextSize(bindinput.Text, 15, Enum.Font.GothamBlack, Vector2.new(9e9, 9e9)).X - 16, 1, -10)	
	end
end

local function createSlider(option, parent)
	local main = library:Create("Frame", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1,
		Parent = parent.content
	})
	
	local title = library:Create("TextLabel", {
		Position = UDim2.new(0, 0, 0, 4),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	local slider = library:Create("ImageLabel", {
		Position = UDim2.new(0, 10, 0, 34),
		Size = UDim2.new(1, -20, 0, 5),
		Active = true,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local fill = library:Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = slider
	})
	
	local circle = library:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 0.5, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 1,
		Parent = slider
	})
	
	local valueRound = library:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(0, -60, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local inputvalue = library:Create("TextBox", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = option.value,
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextSize = 15,
		TextWrapped = true,
		Font = Enum.Font.GothamBlack,
		Parent = valueRound
	})
	
	if option.min >= 0 then
		fill.Size = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 1, 0)
	else
		fill.Position = UDim2.new((0 - option.min) / (option.max - option.min), 0, 0, 0)
		fill.Size = UDim2.new(option.value / (option.max - option.min), 0, 1, 0)
	end
	
	local sliding = false
	local slideTouch = nil
	local inContact = false
	slider.MouseEnter:Connect(function()
		inContact = true
	end)
	slider.MouseLeave:Connect(function()
		inContact = false
		if not sliding then
			tweenService:Create(fill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			tweenService:Create(circle, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		end
	end)
	local function setSliderFromX(x)
		local width = slider.AbsoluteSize.X
		if width <= 0 or option.max <= option.min then return end
		local alpha = math.clamp((x - slider.AbsolutePosition.X) / width, 0, 1)
		option:SetValue(option.min + alpha * (option.max - option.min))
	end
	slider.InputBegan:Connect(function(input)
		if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			slideTouch = input.UserInputType == Enum.UserInputType.Touch and input or nil
			tweenService:Create(fill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			tweenService:Create(circle, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = UDim2.new(3.5, 0, 3.5, 0), ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			setSliderFromX(input.Position.X)
		elseif input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not sliding then
				tweenService:Create(fill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	inputService.InputChanged:Connect(function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or (input.UserInputType == Enum.UserInputType.Touch and input == slideTouch)) then
			setSliderFromX(input.Position.X)
		end
	end)
	inputService.InputEnded:Connect(function(input)
		if sliding and (input.UserInputType == ui or (input.UserInputType == Enum.UserInputType.Touch and input == slideTouch)) then
			sliding = false
			slideTouch = nil
			local color = inContact and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(60, 60, 60)
			tweenService:Create(fill, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {ImageColor3 = color}):Play()
			tweenService:Create(circle, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = inContact and UDim2.new(2.8, 0, 2.8, 0) or UDim2.new(0, 0, 0, 0), ImageColor3 = color}):Play()
		end
	end)

	inputvalue.FocusLost:connect(function()
		tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		option:SetValue(tonumber(inputvalue.Text) or option.value)
	end)

	function option:SetValue(value)
		value = round(value, option.float)
		value = math.clamp(value, self.min, self.max)
		circle:TweenPosition(UDim2.new((value - self.min) / (self.max - self.min), 0, 0.5, 0), "Out", "Quad", 0.1, true)
		if self.min >= 0 then
			fill:TweenSize(UDim2.new((value - self.min) / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
		else
			fill:TweenPosition(UDim2.new((0 - self.min) / (self.max - self.min), 0, 0, 0), "Out", "Quad", 0.1, true)
			fill:TweenSize(UDim2.new(value / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
		end
		library.flags[self.flag] = value
		self.value = value
		inputvalue.Text = tostring(value)
		self.callback(value)
	end
end

local function createList(option, parent, holder)
	local valueCount = 0
	
	local main = library:Create("Frame", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		Parent = parent.content
	})
	
	local round = library:Create("ImageLabel", {
		Position = UDim2.new(0, 6, 0, 4),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local title = library:Create("TextLabel", {
		Position = UDim2.new(0, 12, 0, 8),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = option.text,
		TextSize = 14,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(140, 140, 140),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	local listvalue = library:Create("TextLabel", {
		Position = UDim2.new(0, 12, 0, 20),
		Size = UDim2.new(1, -24, 0, 24),
		BackgroundTransparency = 1,
		Text = option.value,
		TextSize = 18,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	library:Create("ImageLabel", {
		Position = UDim2.new(1, -16, 0, 16),
		Size = UDim2.new(-1, 32, 1, -32),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Rotation = 90,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4918373417",
		ImageColor3 = Color3.fromRGB(140, 140, 140),
		ScaleType = Enum.ScaleType.Fit,
		Parent = round
	})
	
	option.mainHolder = library:Create("ImageButton", {
		ZIndex = 3,
		Size = UDim2.new(0, 240, 0, 52),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Visible = false,
		Parent = library.base
	})
	
	local content = library:Create("ScrollingFrame", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarImageColor3 = Color3.fromRGB(),
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = option.mainHolder
	})
	
	library:Create("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		Parent = content
	})
	
	local layout = library:Create("UIListLayout", {
		Parent = content
	})
	
	layout.Changed:connect(function()
		option.mainHolder.Size = UDim2.new(0, 240, 0, (valueCount > 4 and (4 * 40) or layout.AbsoluteContentSize.Y) + 12)
		content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
	end)
	
	local inContact
	round.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			content.ScrollBarThickness = 6
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			for _,label in next, content:GetChildren() do
				if label:IsA"TextLabel" then
					tweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
				end
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			content.ScrollBarThickness = 6
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			for _,label in next, content:GetChildren() do
				if label:IsA"TextLabel" then
					tweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
				end
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.open then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)
	
	round.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not option.open then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
	
	function option:AddValue(value)
		valueCount = valueCount + 1
		local label = library:Create("TextLabel", {
			ZIndex = 3,
			Size = UDim2.new(1, 0, 0, 40),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Text = "    " .. value,
			TextSize = 14,
			TextTransparency = self.open and 0 or 1,
			Font = Enum.Font.GothamBlack,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = content
		})
		
		local inContact
		local clicking
		label.InputBegan:connect(function(input)
			if input.UserInputType == ui then
				clicking = true
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
				self:SetValue(value)
			elseif input.UserInputType == Enum.UserInputType.Touch then
				clicking = true
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
				self:SetValue(value)
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				inContact = true
				if not clicking then
					tweenService:Create(label, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
				end
			end
		end)
		
		label.InputEnded:connect(function(input)
			if input.UserInputType == ui then
				clicking = false
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = inContact and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(30, 30, 30)}):Play()
			elseif input.UserInputType == Enum.UserInputType.Touch then
				clicking = false
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = inContact and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(30, 30, 30)}):Play()
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				inContact = false
				if not clicking then
					tweenService:Create(label, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
				end
			end
		end)
	end

	if not table.find(option.values, option.value) then
		option:AddValue(option.value)
	end
	
	for _, value in next, option.values do
		option:AddValue(tostring(value))
	end
	
	function option:RemoveValue(value)
		for _,label in next, content:GetChildren() do
			if label:IsA"TextLabel" and label.Text == "	" .. value then
				label:Destroy()
				valueCount = valueCount - 1
				break
			end
		end
		if self.value == value then
			self:SetValue("")
		end
	end
	
	function option:SetValue(value)
		library.flags[self.flag] = tostring(value)
		self.value = tostring(value)
		listvalue.Text = self.value
		self.callback(value)
	end
	
	function option:Close()
		library.activePopup = nil
		self.open = false
		content.ScrollBarThickness = 0
		local position = main.AbsolutePosition
		tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = inContact and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)}):Play()
		tweenService:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, position.X - 5, 0, position.Y -10)}):Play()
		for _,label in next, content:GetChildren() do
			if label:IsA"TextLabel" then
				tweenService:Create(label, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
			end
		end
		wait(0.3)
		--delay(0.3, function()
			if not self.open then
				self.mainHolder.Visible = false
			end
		--end)
	end

	return option
end

local function createBox(option, parent)
	local main = library:Create("Frame", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		Parent = parent.content
	})
	
	local outline = library:Create("ImageLabel", {
		Position = UDim2.new(0, 6, 0, 4),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local round = library:Create("ImageLabel", {
		Position = UDim2.new(0, 8, 0, 6),
		Size = UDim2.new(1, -16, 1, -14),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.01,
		Parent = main
	})
	
	local title = library:Create("TextLabel", {
		Position = UDim2.new(0, 12, 0, 8),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = option.text,
		TextSize = 14,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(100, 100, 100),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	local inputvalue = library:Create("TextBox", {
		Position = UDim2.new(0, 12, 0, 20),
		Size = UDim2.new(1, -24, 0, 24),
		BackgroundTransparency = 1,
		Text = option.value,
		TextSize = 18,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = main
	})
	
	local inContact
	local focused
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			if not focused then inputvalue:CaptureFocus() end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if not focused then inputvalue:CaptureFocus() end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not focused then
				tweenService:Create(outline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	main.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not focused then
				tweenService:Create(outline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)
	
	inputvalue.Focused:connect(function()
		focused = true
		tweenService:Create(outline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
	end)
	
	inputvalue.FocusLost:connect(function(enter)
		focused = false
		tweenService:Create(outline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		option:SetValue(inputvalue.Text, enter)
	end)
	
	function option:SetValue(value, enter)
		library.flags[self.flag] = tostring(value)
		self.value = tostring(value)
		inputvalue.Text = self.value
		self.callback(value, enter)
	end
end

local function createColorPickerWindow(option)
	option.mainHolder = library:Create("ImageButton", {
		ZIndex = 3,
		Size = UDim2.new(0, 240, 0, 180),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = library.base
	})
		
	local hue, sat, val = Color3.toHSV(option.color)
	hue, sat, val = hue == 0 and 1 or hue, sat + 0.005, val - 0.005
	local editinghue
	local editingsatval
	local currentColor = option.color
	local previousColors = {[1] = option.color}
	local originalColor = option.color
	local rainbowEnabled
	local rainbowLoop
	
	function option:updateVisuals(Color)
		currentColor = Color
		self.visualize2.ImageColor3 = Color
		hue, sat, val = Color3.toHSV(Color)
		hue = hue == 0 and 1 or hue
		self.satval.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
		self.hueSlider.Position = UDim2.new(1 - hue, 0, 0, 0)
		self.satvalSlider.Position = UDim2.new(sat, 0, 1 - val, 0)
	end
	
	option.hue = library:Create("ImageLabel", {
		ZIndex = 3,
		Active = true,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 8, 1, -8),
		Size = UDim2.new(1, -100, 0, 22),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	local Gradient = library:Create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.157, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(0.323, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.488, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.817, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
		}),
		Parent = option.hue
	})
	
	option.hueSlider = library:Create("Frame", {
		ZIndex = 3,
		Position = UDim2.new(1 - hue, 0, 0, 0),
		Size = UDim2.new(0, 2, 1, 0),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.hue
	})
	
	option.hue.InputBegan:connect(function(Input)
		if Input.UserInputType == ui then
			editinghue = true
			X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (Input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X < 0 and 0 or X > 0.995 and 0.995 or X
			option:SetColor(Color3.fromHSV(1 - X, sat, val))
		elseif Input.UserInputType == Enum.UserInputType.Touch then
			editinghue = true
			X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (Input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X < 0 and 0 or X > 0.995 and 0.995 or X
			option:SetColor(Color3.fromHSV(1 - X, sat, val))
		end
	end)
	
	inputService.InputChanged:connect(function(Input)
		if editinghue and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (Input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X <= 0 and 0 or X >= 0.995 and 0.995 or X
			option:SetColor(Color3.fromHSV(1 - X, sat, val))
		end
	end)
	
	option.hue.InputEnded:connect(function(Input)
		if Input.UserInputType == ui then
			editinghue = false
		elseif Input.UserInputType == Enum.UserInputType.Touch then
			editinghue = false
		end
	end)
	
	option.dragHandle = library:Create("TextButton", {
		ZIndex = 4,
		Position = UDim2.fromOffset(8, 3),
		Size = UDim2.new(1, -16, 0, 18),
		BackgroundTransparency = 1,
		Text = "COLOR PICKER",
		TextColor3 = Color3.fromRGB(220, 220, 220),
		TextSize = 11,
		Font = Enum.Font.Code,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		Parent = option.mainHolder
	})
	if library.MakeDraggable then library:MakeDraggable(option.mainHolder, option.dragHandle) end

	option.satval = library:Create("ImageLabel", {
		ZIndex = 3,
		Active = true,
		Position = UDim2.new(0, 8, 0, 26),
		Size = UDim2.new(1, -100, 1, -68),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
		BorderSizePixel = 0,
		Image = "rbxassetid://4155801252",
		ImageTransparency = 1,
		ClipsDescendants = true,
		Parent = option.mainHolder
	})
	
	option.satvalSlider = library:Create("Frame", {
		ZIndex = 3,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(sat, 0, 1 - val, 0),
		Size = UDim2.new(0, 4, 0, 4),
		Rotation = 45,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.satval
	})
	
	option.satval.InputBegan:connect(function(Input)
		if Input.UserInputType == ui then
			editingsatval = true
			X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (Input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (Input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:SetColor(Color3.fromHSV(hue, X, 1 - Y))
		elseif Input.UserInputType == Enum.UserInputType.Touch then
			editingsatval = true
			X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (Input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (Input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:SetColor(Color3.fromHSV(hue, X, 1 - Y))
		end
	end)
	
	inputService.InputChanged:connect(function(Input)
		if editingsatval and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (Input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (Input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:SetColor(Color3.fromHSV(hue, X, 1 - Y))
		end
	end)
	
	option.satval.InputEnded:Connect(function(Input)
		if Input.UserInputType == ui or Input.UserInputType == Enum.UserInputType.Touch then
			editingsatval = false
		end
	end)

	inputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == ui or Input.UserInputType == Enum.UserInputType.Touch then
			editinghue = false
			editingsatval = false
		end
	end)

	option.visualize2 = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -80, 0, 26),
		Size = UDim2.new(0, 72, 0, 60),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = currentColor,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	option.resetColor = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -80, 0, 92),
		Size = UDim2.new(0, 72, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	option.resetText = library:Create("TextLabel", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Reset",
		TextTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.resetColor
	})
	
	option.resetColor.InputBegan:connect(function(Input)
		if Input.UserInputType == ui and not rainbowEnabled then
			previousColors = {originalColor}
			option:SetColor(originalColor)
		elseif Input.UserInputType == Enum.UserInputType.Touch and not rainbowEnabled then
			previousColors = {originalColor}
			option:SetColor(originalColor)
		end
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.resetColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		end
	end)
	
	option.resetColor.InputEnded:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.resetColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
		end
	end)
	
	option.undoColor = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -80, 0, 112),
		Size = UDim2.new(0, 72, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	option.undoText = library:Create("TextLabel", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Undo",
		TextTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.undoColor
	})
	
	option.undoColor.InputBegan:connect(function(Input)
		if Input.UserInputType == ui and not rainbowEnabled then
			local Num = #previousColors == 1 and 0 or 1
			option:SetColor(previousColors[#previousColors - Num])
			if #previousColors ~= 1 then
				table.remove(previousColors, #previousColors)
			end
		elseif Input.UserInputType == Enum.UserInputType.Touch and not rainbowEnabled then
			local Num = #previousColors == 1 and 0 or 1
			option:SetColor(previousColors[#previousColors - Num])
			if #previousColors ~= 1 then
				table.remove(previousColors, #previousColors)
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.undoColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		end
	end)
	
	option.undoColor.InputEnded:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.undoColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
		end
	end)
	
	option.setColor = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -80, 0, 132),
		Size = UDim2.new(0, 72, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	option.setText = library:Create("TextLabel", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Set",
		TextTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.setColor
	})
	
	option.setColor.InputBegan:connect(function(Input)
		if Input.UserInputType == ui and not rainbowEnabled then
			table.insert(previousColors, currentColor)
			option:SetColor(currentColor)
		elseif Input.UserInputType == Enum.UserInputType.Touch and not rainbowEnabled then
			table.insert(previousColors, currentColor)
			option:SetColor(currentColor)
		end
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.setColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		end
	end)
	
	option.setColor.InputEnded:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.setColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
		end
	end)
	
	option.rainbow = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -80, 0, 152),
		Size = UDim2.new(0, 72, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	option.rainbowText = library:Create("TextLabel", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Rainbow",
		TextTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = option.rainbow
	})
	
	option.rainbow.InputBegan:connect(function(Input)
		if Input.UserInputType == ui then
			rainbowEnabled = not rainbowEnabled
			if rainbowEnabled then
				rainbowLoop = runService.Heartbeat:connect(function()
					option:SetColor(chromaColor)
					option.rainbowText.TextColor3 = chromaColor
				end)
			else
				rainbowLoop:Disconnect()
				option:SetColor(previousColors[#previousColors])
				option.rainbowText.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		elseif Input.UserInputType == Enum.UserInputType.Touch then
			rainbowEnabled = not rainbowEnabled
			if rainbowEnabled then
				rainbowLoop = runService.Heartbeat:connect(function()
					option:SetColor(chromaColor)
					option.rainbowText.TextColor3 = chromaColor
				end)
			else
				rainbowLoop:Disconnect()
				option:SetColor(previousColors[#previousColors])
				option.rainbowText.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.rainbow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		end
	end)
	
	option.rainbow.InputEnded:connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement and not dragging then
			tweenService:Create(option.rainbow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
		end
	end)
	
	return option
end

local function createColor(option, parent, holder)
	option.main = library:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 31),
		Active = true,
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.GothamBlack,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	local colorBoxOutline = library:Create("ImageLabel", {
		Position = UDim2.new(1, -28, 0, 4),
		Size = UDim2.new(0, 22, 0, 22),
		Active = true,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(100, 100, 100),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.main
	})
	
	option.visualize = library:Create("ImageLabel", {
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.color,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = colorBoxOutline
	})
	
	local inContact
	option.main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			if not option.mainHolder then createColorPickerWindow(option) end
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = option.main.AbsolutePosition
			local camera = workspace.CurrentCamera
			local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
			local popupX = math.clamp(position.X - 5, 8, math.max(8, viewport.X - 248))
			local popupY = position.Y + option.main.AbsoluteSize.Y + 4
			if popupY + 188 > viewport.Y then popupY = math.max(8, position.Y - 184) end
			option.mainHolder.Position = UDim2.new(0, popupX, 0, popupY - 6)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
			for _,object in next, option.mainHolder:GetDescendants() do
				if object:IsA"TextLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				elseif object:IsA"ImageLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				elseif object:IsA"Frame" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				end
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if not option.mainHolder then createColorPickerWindow(option) end
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = option.main.AbsolutePosition
			local camera = workspace.CurrentCamera
			local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
			local popupX = math.clamp(position.X - 5, 8, math.max(8, viewport.X - 248))
			local popupY = position.Y + option.main.AbsoluteSize.Y + 4
			if popupY + 188 > viewport.Y then popupY = math.max(8, position.Y - 184) end
			option.mainHolder.Position = UDim2.new(0, popupX, 0, popupY - 6)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, popupX, 0, popupY)}):Play()
			tweenService:Create(option.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
			for _,object in next, option.mainHolder:GetDescendants() do
				if object:IsA"TextLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				elseif object:IsA"ImageLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				elseif object:IsA"Frame" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				end
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.open then
				tweenService:Create(colorBoxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			end
		end
	end)
	
	option.main.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.open then
				tweenService:Create(colorBoxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	function option:SetColor(newColor)
		if self.mainHolder then
			self:updateVisuals(newColor)
		end
		self.visualize.ImageColor3 = newColor
		library.flags[self.flag] = newColor
		self.color = newColor
		self.callback(newColor)
	end
	
	function option:Close()
		library.activePopup = nil
		self.open = false
		local position = self.main.AbsolutePosition
		tweenService:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)}):Play()
		tweenService:Create(self.satval, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		for _,object in next, self.mainHolder:GetDescendants() do
			if object:IsA"TextLabel" then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			elseif object:IsA"ImageLabel" then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
			elseif object:IsA"Frame" then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
			end
		end
		delay(0.3, function()
			if not self.open then
				self.mainHolder.Visible = false
			end 
		end)
	end
end

local function loadOptions(option, holder)
	for _,newOption in next, option.options do
		if newOption.type == "label" then
			createLabel(newOption, option)
		elseif newOption.type == "toggle" then
			createToggle(newOption, option)
		elseif newOption.type == "button" then
			createButton(newOption, option)
		elseif newOption.type == "list" then
			createList(newOption, option, holder)
		elseif newOption.type == "box" then
			createBox(newOption, option)
		elseif newOption.type == "bind" then
			createBind(newOption, option)
		elseif newOption.type == "slider" then
			createSlider(newOption, option)
		elseif newOption.type == "color" then
			createColor(newOption, option, holder)
		elseif newOption.type == "folder" then
			newOption:init()
		end
	end
end

local function getFnctions(parent)
	function parent:AddLabel(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.type = "label"
		option.position = #self.options
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddToggle(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.state = typeof(option.state) == "boolean" and option.state or false
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "toggle"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.state
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddButton(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "button"
		option.position = #self.options
		option.flag = option.flag or option.text
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddBind(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.key = (option.key and option.key.Name) or option.key or "F"
		option.hold = typeof(option.hold) == "boolean" and option.hold or false
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "bind"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.key
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddSlider(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.min = typeof(option.min) == "number" and option.min or 0
		option.max = typeof(option.max) == "number" and option.max or 0
		if option.max <= option.min then option.max = option.min + 1 end
		option.dual = typeof(option.dual) == "boolean" and option.dual or false
		option.value = math.clamp(typeof(option.value) == "number" and option.value or option.min, option.min, option.max)
		option.value2 = typeof(option.value2) == "number" and option.value2 or option.max
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.float = typeof(option.value) == "number" and option.float or 1
		option.type = "slider"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddList(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.values = typeof(option.values) == "table" and option.values or {}
		option.value = tostring(option.value or option.values[1] or "")
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.open = false
		option.type = "list"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddBox(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.value = tostring(option.value or "")
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "box"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddColor(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.color = typeof(option.color) == "table" and Color3.new(tonumber(option.color[1]), tonumber(option.color[2]), tonumber(option.color[3])) or option.color or Color3.new(255, 255, 255)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.open = false
		option.type = "color"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.color
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddImage(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text or option.Text or "")
		local image = option.Image or option.image or option.value or option.Value or option.Default or ""
		if typeof(image) == "number" then image = "rbxassetid://" .. tostring(image) end
		option.Image = tostring(image)
		option.type = "label"
		option.__extendedKind = "image"
		option.position = #self.options
		table.insert(self.options, option)
		function option:SetImage(value)
			if typeof(value) == "number" then value = "rbxassetid://" .. tostring(value) end
			self.Image = tostring(value or "")
			if self._media then self._media.Image = self.Image end
			if self._placeholderGui then
				self._placeholderGui.Visible = self.Image ~= "" and not (self._media and self._media.IsLoaded)
				self._placeholderGui.Text = self.Image == "" and "" or ""
			end
			return self
		end
		option.SetValue = option.SetImage
		return option
	end

	function parent:AddViewport(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text or option.Text or "")
		option.Model = option.Model or option.model
		option.type = "label"
		option.__extendedKind = "viewport"
		option.position = #self.options
		table.insert(self.options, option)
		function option:SetModel(model)
			self.Model = model
			if self._applyModel then return self:_applyModel(model) end
			return self
		end
		return option
	end

	function parent:AddFolder(title)
		local option = {}
		option.title = tostring(title)
		option.options = {}
		option.open = false
		option.type = "folder"
		option.position = #self.options
		table.insert(self.options, option)
		
		getFnctions(option)
		
		function option:init()
			createOptionHolder(self.title, parent.content, self, true)
			loadOptions(self, parent)
		end
		
		return option
	end
end

function library:CreateWindow(title)
	local window = {title = tostring(title), options = {}, open = true, canInit = true, init = false, position = #self.windows}
	getFnctions(window)
	
	table.insert(library.windows, window)
	
	return window
end

local UIToggle
function library:Init()
	self.base = self.base or self:Create("ScreenGui")
	local parentTarget
	pcall(function()
		if syn and type(syn.protect_gui) == "function" then
			syn.protect_gui(self.base)
			parentTarget = game:GetService("CoreGui")
		elseif type(gethui) == "function" then
			local ok, hidden = pcall(gethui)
			if ok and typeof(hidden) == "Instance" then
				parentTarget = hidden
			end
		elseif type(get_hidden_gui) == "function" then
			local ok, hidden = pcall(get_hidden_gui)
			if ok and typeof(hidden) == "Instance" then
				parentTarget = hidden
			end
		end
	end)
	if not parentTarget then
		parentTarget = game:GetService("CoreGui")
	end
	self.base.Parent = parentTarget
	self.base.ResetOnSpawn = false
	self.base.Enabled = true
	self.base.Name = "ToraScript"
	
	
	for _, window in next, self.windows do
		if window.canInit and not window.init then
			window.init = true
			createOptionHolder(window.title, self.base, window)
			loadOptions(window)
		end
	end
	return self.base
end

function library:Close()
	if typeof(self.base) ~= "Instance" then end
	self.open = not self.open
	if self.activePopup then
		self.activePopup:Close()
	end
	for _, window in next, self.windows do
		if window.main then
			window.main.Visible = self.open
		end
	end
end

inputService.InputBegan:connect(function(input)
	if input.UserInputType == ui then
		if library.activePopup then
			if input.Position.X < library.activePopup.mainHolder.AbsolutePosition.X or input.Position.Y < library.activePopup.mainHolder.AbsolutePosition.Y then
				library.activePopup:Close()
			end
		end
		if library.activePopup then
			if input.Position.X > library.activePopup.mainHolder.AbsolutePosition.X + library.activePopup.mainHolder.AbsoluteSize.X or input.Position.Y > library.activePopup.mainHolder.AbsolutePosition.Y + library.activePopup.mainHolder.AbsoluteSize.Y then
				library.activePopup:Close()
			end
		end
	elseif input.UserInputType == Enum.UserInputType.Touch then
		if library.activePopup then
			if input.Position.X < library.activePopup.mainHolder.AbsolutePosition.X or input.Position.Y < library.activePopup.mainHolder.AbsolutePosition.Y then
				library.activePopup:Close()
			end
		end
		if library.activePopup then
			if input.Position.X > library.activePopup.mainHolder.AbsolutePosition.X + library.activePopup.mainHolder.AbsoluteSize.X or input.Position.Y > library.activePopup.mainHolder.AbsolutePosition.Y + library.activePopup.mainHolder.AbsoluteSize.Y then
				library.activePopup:Close()
			end
		end
	end
end)

inputService.InputChanged:connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local EXT = {}

library.Options = library.Options or {}
library.Toggles = library.Toggles or {}

local extHttp = game:GetService("HttpService")
local extPlayers = game:GetService("Players")
local extLocalPlayer = extPlayers.LocalPlayer
local extConnections = {}
local extUnloadCallbacks = {}
local extSearchQuery = ""
local extTheme = {
	Accent = Color3.fromRGB(255, 65, 65),
	Background = Color3.fromRGB(10, 10, 10),
	Panel = Color3.fromRGB(20, 20, 20),
	Text = Color3.fromRGB(255, 255, 255),
	Dim = Color3.fromRGB(140, 140, 140)
}

local function extConnect(signal, fn)
	if not signal then return nil end
	local c = signal:Connect(fn)
	table.insert(extConnections, c)
	return c
end

local function extCreate(class, props)
	local ok, obj = pcall(function()
		local x = Instance.new(class)
		for k, v in pairs(props or {}) do
			x[k] = v
		end
		return x
	end)
	return ok and obj or nil
end

local function extLine(parent, color, thickness, position)
	return extCreate("Frame", {
		Size = UDim2.new(1, 0, 0, thickness or 1),
		Position = position or UDim2.new(0, 0, 1, -(thickness or 1)),
		BackgroundColor3 = color or Color3.fromRGB(60, 60, 60),
		BorderSizePixel = 0,
		Parent = parent
	})
end

local function extNormalize(name, info)
	local o
	if typeof(name) == "table" then
		o = table.clone(name)
	else
		o = typeof(info) == "table" and table.clone(info) or {}
		o.Text = o.Text or o.text or tostring(name)
	end
	o.Text = tostring(o.Text or o.text or "")
	o.text = o.Text
	o.Flag = o.Flag or o.flag or o.Text
	o.flag = o.Flag
	o.Callback = o.Callback or o.callback or o.Func or o.func
	o.callback = o.Callback
	o.ChangedCallback = o.ChangedCallback or o.OnChanged or o.changedCallback
	o.Tooltip = o.Tooltip or o.tooltip or o.desc
	o.desc = o.Tooltip
	o.Default = o.Default ~= nil and o.Default or o.default
	return o
end

local function extCall(fn, ...)
	if type(fn) == "function" then
		return fn(...)
	end
end

local function extOptions(parent)
	return type(parent) == "table" and parent.options or nil
end

local extFireChanged

local function extDecorateOption(lib, o)
	if type(o) ~= "table" then return o end
	if o.__extendedDecorated then return o end
	o.__extendedDecorated = true
	if o.flag then
		if o.type == "toggle" then library.Toggles[o.flag] = o else library.Options[o.flag] = o end
	end
	if o.callback and not o.__callbackWrapped then
		local baseCallback = o.callback
		o.__callbackWrapped = true
		o.callback = function(...)
			local result = baseCallback(...)
			if extFireChanged then extFireChanged(o, ...) end
			return result
		end
	end
	o.Name = o.Name or o.flag or o.text
	o.Text = o.text or o.Text or o.Name
	o.Tooltip = o.desc or o.Tooltip
	o.Disabled = o.Disabled == true or o.disabled == true
	o.Visible = o.Visible ~= false and o.visible ~= false
	o.Get = function(self) return lib.flags[self.flag] end
	o.GetValue = o.GetValue or function(self) return lib.flags[self.flag] end
	o.SetFlag = function(self, flag) self.flag = tostring(flag); return self end
	o.SetVisible = function(self, v)
		self.Visible = v ~= false
		if self._gui then self._gui.Visible = self.Visible end
		return self
	end
	o.IsVisible = function(self) return self.Visible ~= false end
	o.Lock = function(self, v) self.Locked = v ~= false; return self end
	o.Unlock = function(self) self.Locked = false; return self end
	o.IsLocked = function(self) return self.Locked == true end
	o.SetText = function(self, v)
		self.Text = tostring(v or "")
		self.text = self.Text
		if self._titleGui then self._titleGui.Text = self.Text end
		if self._gui and self._gui:IsA("TextLabel") then self._gui.Text = " " .. self.Text end
		return self
	end
	o.SetDisabled = function(self, v) self.Disabled = v == true; return self end
	o.OnChanged = function(self, fn)
		self.__changed = self.__changed or {}
		if type(fn) == "function" then table.insert(self.__changed, fn) end
		return self
	end
	if type(o.ChangedCallback)=="function" then
		o.__changed = o.__changed or {}
		table.insert(o.__changed,o.ChangedCallback)
	end
	o.AddDependency = function(self, flag, value)
		self.__dependencies = self.__dependencies or {}
		table.insert(self.__dependencies, {flag = flag, value = value})
		return self
	end
	o.Destroy = function(self)
		if self._gui then self._gui:Destroy() end
		self.Destroyed = true
		return self
	end
	return o
end

extFireChanged = function(o, value)
	if type(o.__changed) == "table" then
		for _, fn in ipairs(o.__changed) do
			extCall(fn, value)
		end
	end
end

local function extSetOptionValue(lib, o, value, ...)
	if type(o) ~= "table" then return end
	if o.type == "toggle" and o.SetState then return o:SetState(value == true) end
	if o.type == "slider" and o.__baseSetValue then return o.__baseSetValue(o,value) end
	if o.type == "list" and o.__baseSetValue then return o.__baseSetValue(o,value) end
	if o.type == "box" and o.__baseSetValue then return o.__baseSetValue(o,value, ...) end
	if o.type == "bind" and o.SetKey then return o:SetKey(value) end
	if o.type == "color" and o.SetColor then return o:SetColor(value) end
	if o.__extendedKind == "progress" and o.Set then return o:Set(value) end
	if o.__extendedKind == "stat" and o.Set then return o:Set(value) end
	if o.__extendedKind == "image" and o.SetImage then return o:SetImage(value) end
	if o.__extendedKind == "viewport" and o.SetModel then return o:SetModel(value) end
	lib.flags[o.flag] = value
	o.value = value
	if o._valueGui then o._valueGui.Text=tostring(value) end
	return o
end

local function extFindGui(parent, option)
	if not parent or not parent.content then return nil end
	local wanted = option.position
	for _, child in ipairs(parent.content:GetChildren()) do
		if child:IsA("GuiObject") and child.LayoutOrder == wanted then
			return child
		end
	end
end

local function extRenderOption(lib, option, parent)
	if option.__extendedRendered or not option.__extendedKind then return end
	local gui = extFindGui(parent, option)
	if gui then gui:Destroy() end
	local kind = option.__extendedKind
	if kind == "paragraph" then
		local bodyText = tostring(option.description or option.Description or option.Content or "")
		local bodyWidth = math.max(120, (parent.content.AbsoluteSize.X > 0 and parent.content.AbsoluteSize.X or 248) - 18)
		local bodyBounds = textService:GetTextSize(bodyText, 11, Enum.Font.Code, Vector2.new(bodyWidth, 10000))
		local bodyHeight = math.max(20, bodyBounds.Y + 4)
		local frame = extCreate("Frame", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,24 + bodyHeight), BackgroundTransparency=1, Parent=parent.content})
		extCreate("TextLabel", {Size=UDim2.new(1,-12,0,20), Position=UDim2.fromOffset(6,2), BackgroundTransparency=1, Text=tostring(option.title or option.Title or option.Text or ""), TextColor3=extTheme.Text, TextSize=14, Font=Enum.Font.GothamBold, TextWrapped=true, AutomaticSize=Enum.AutomaticSize.Y, TextXAlignment=Enum.TextXAlignment.Left, Parent=frame})
		extCreate("TextLabel", {Size=UDim2.new(1,-12,0,bodyHeight), Position=UDim2.fromOffset(6,22), BackgroundTransparency=1, Text=bodyText, TextColor3=extTheme.Dim, TextSize=11, Font=Enum.Font.Code, TextWrapped=true, TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top, Parent=frame})
		option._gui = frame
	elseif kind == "divider" then
		local frame = extCreate("Frame", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, Parent=parent.content})
		extLine(frame, extTheme.Panel, 1, UDim2.new(0,6,0.5,0))
		option._gui = frame
	elseif kind == "text" then
		local frame = extCreate("TextLabel", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, Text=" "..tostring(option.Text), TextColor3=extTheme.Text, TextSize=16, Font=Enum.Font.GothamBlack, TextXAlignment=Enum.TextXAlignment.Left, Parent=parent.content})
		option._gui = frame
	elseif kind == "stat" then
		local frame = extCreate("Frame", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,28), BackgroundTransparency=1, Parent=parent.content})
		extCreate("TextLabel", {Size=UDim2.new(0.7,0,1,0), BackgroundTransparency=1, Text=" "..tostring(option.Text), TextColor3=extTheme.Text, TextSize=14, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left, Parent=frame})
		local val = extCreate("TextLabel", {Name="Value", Size=UDim2.new(0.3,-4,1,0), Position=UDim2.new(0.7,0,0,0), BackgroundTransparency=1, Text=tostring(option.value), TextColor3=extTheme.Accent, TextSize=14, Font=Enum.Font.Code, TextXAlignment=Enum.TextXAlignment.Right, Parent=frame})
		option._gui = frame
		option._valueGui = val
		option.Set = function(self, v) self.value=v; lib.flags[self.flag]=v; if self._valueGui then self._valueGui.Text=tostring(v) end; extFireChanged(self,v); return self end
		option.GetValue = function(self) return self.value end
	elseif kind == "progress" then
		local frame = extCreate("Frame", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,32), BackgroundTransparency=1, Parent=parent.content})
		extCreate("TextLabel", {Size=UDim2.new(0.65,0,0,18), Position=UDim2.fromOffset(6,0), BackgroundTransparency=1, Text=" "..tostring(option.Text), TextColor3=extTheme.Text, TextSize=13, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left, Parent=frame})
		local valueLabel = extCreate("TextLabel", {Size=UDim2.new(0.35,-6,0,18), Position=UDim2.new(0.65,0,0,0), BackgroundTransparency=1, TextColor3=extTheme.Dim, TextSize=12, Font=Enum.Font.Code, TextXAlignment=Enum.TextXAlignment.Right, Parent=frame})
		local back = extCreate("Frame", {Size=UDim2.new(1,-12,0,5), Position=UDim2.fromOffset(6,23), BackgroundColor3=Color3.fromRGB(35,35,35), BorderSizePixel=0, Parent=frame})
		local fill = extCreate("Frame", {Size=UDim2.new(0,0,1,0), BackgroundColor3=extTheme.Accent, BorderSizePixel=0, Parent=back})
		option._gui=frame; option._valueGui=valueLabel; option._fillGui=fill
		option.GetPercentage=function(self) local a=tonumber(self.min) or 0; local b=tonumber(self.max) or 100; if b==a then return 0 end; return ((tonumber(self.value) or a)-a)/(b-a)*100 end
		option.GetValue=function(self) return self.value end
		option.Set=function(self,v) self.value=math.clamp(tonumber(v) or self.min,self.min,self.max); lib.flags[self.flag]=self.value; local p=self:GetPercentage()/100; if self._fillGui then self._fillGui.Size=UDim2.new(p,0,1,0) end; if self._valueGui then self._valueGui.Text=tostring(round(self.value,self.rounding or 1)) end; extFireChanged(self,self.value); return self end
		option:Set(option.value)
	elseif kind == "image" then
		local h = math.max(76, tonumber(option.Height or option.height) or 128)
		local frame = extCreate("Frame", {LayoutOrder = option.position, Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = parent.content})
		local imageTitle = tostring(option.text or option.Text or "")
		local titleLabel = extCreate("TextLabel", {Size = UDim2.new(1, -12, 0, 18), Position = UDim2.fromOffset(6, 0), BackgroundTransparency = 1, Text = imageTitle, Visible = imageTitle ~= "", TextColor3 = extTheme.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, Parent = frame})
		local image = extCreate("ImageLabel", {Size = UDim2.new(1, -12, 1, -26), Position = UDim2.fromOffset(6, 22), BackgroundColor3 = Color3.fromRGB(15, 15, 17), BorderSizePixel = 0, Image = "", ImageTransparency = tonumber(option.Transparency or option.transparency) or 0, ScaleType = option.ScaleType or Enum.ScaleType.Fit, Parent = frame})
		local placeholder = extCreate("TextLabel", {Size = UDim2.new(1, -16, 1, -8), Position = UDim2.fromOffset(8, 4), BackgroundTransparency = 1, Text = "", Visible = false, TextColor3 = extTheme.Dim, TextSize = 11, Font = Enum.Font.Code, TextWrapped = true, Parent = image})
		extLine(image, Color3.fromRGB(60, 60, 65), 1)
		option._gui = frame
		option._titleGui = titleLabel
		option._media = image
		option._placeholderGui = placeholder
		image:GetPropertyChangedSignal("IsLoaded"):Connect(function()
			if option._placeholderGui and option.Image ~= "" then
				option._placeholderGui.Visible = not image.IsLoaded
				option._placeholderGui.Text = image.IsLoaded and "" or "IMAGE PREVIEW UNAVAILABLE"
			end
		end)
		function option:SetImage(v)
			if typeof(v) == "number" then v = "rbxassetid://" .. tostring(v) end
			self.Image = tostring(v or "")
			if self._media then self._media.Image = self.Image end
			if self._placeholderGui then
				self._placeholderGui.Visible = self.Image ~= "" and not (self._media and self._media.IsLoaded)
				self._placeholderGui.Text = self.Image == "" and "" or ""
			end
			return self
		end
		option.SetValue = option.SetImage
		option:SetImage(option.Image or option.image or option.Value or option.value or option.Default or "")
		if image.IsLoaded and placeholder then placeholder.Visible = false end
	elseif kind == "viewport" then
		local h = math.max(76, tonumber(option.Height or option.height) or 150)
		local frame = extCreate("Frame", {LayoutOrder = option.position, Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, Parent = parent.content})
		local viewportTitle = tostring(option.text or option.Text or "")
		local titleLabel = extCreate("TextLabel", {Size = UDim2.new(1, -12, 0, 18), Position = UDim2.fromOffset(6, 0), BackgroundTransparency = 1, Text = viewportTitle, Visible = viewportTitle ~= "", TextColor3 = extTheme.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, Parent = frame})
		local view = extCreate("ViewportFrame", {Size = UDim2.new(1, -12, 1, -26), Position = UDim2.fromOffset(6, 22), BackgroundColor3 = Color3.fromRGB(15, 15, 17), BorderSizePixel = 0, Ambient = Color3.fromRGB(180, 180, 180), LightColor = Color3.fromRGB(255, 255, 255), Parent = frame})
		extLine(view, Color3.fromRGB(60, 60, 65), 1)
		local cam = extCreate("Camera", {FieldOfView = 35, Parent = view})
		if cam then view.CurrentCamera = cam end
		local world = extCreate("WorldModel", {Parent = view})
		local placeholder = extCreate("TextLabel", {Size = UDim2.new(1, -24, 1, -30), Position = UDim2.fromOffset(12, 26), BackgroundTransparency = 1, Text = "", Visible = false, TextColor3 = extTheme.Dim, TextSize = 11, Font = Enum.Font.Code, TextWrapped = true, Parent = view})
		option._gui = frame
		option._titleGui = titleLabel
		option._media = view
		option._world = world
		option._camera = cam
		option._placeholderGui = placeholder
		function option:_applyModel(model)
			if not self._world then return self end
			for _, child in ipairs(self._world:GetChildren()) do child:Destroy() end
			if not model then
				if self._placeholderGui then self._placeholderGui.Visible = false; self._placeholderGui.Text = "" end
				return self
			end
			if typeof(model) ~= "Instance" or not (model:IsA("Model") or model:IsA("BasePart")) then
				if self._placeholderGui then self._placeholderGui.Visible = false; self._placeholderGui.Text = "" end
				return self
			end
			local okClone, clone = pcall(function() return model:Clone() end)
			if not okClone or not clone then
				if self._placeholderGui then self._placeholderGui.Visible = false; self._placeholderGui.Text = "" end
				return self
			end
			clone.Parent = self._world
			local boxCFrame, boxSize
			if clone:IsA("Model") then
				local okBox, cf, size = pcall(function() return clone:GetBoundingBox() end)
				if okBox then boxCFrame, boxSize = cf, size end
			elseif clone:IsA("BasePart") then
				boxCFrame, boxSize = clone.CFrame, clone.Size
			end
			if boxCFrame and boxSize and self._camera then
				local radius = math.max(boxSize.X, boxSize.Y, boxSize.Z, 1)
				local distance = radius * 2.4
				local center = boxCFrame.Position
				self._camera.CFrame = CFrame.lookAt(center + Vector3.new(0, radius * 0.15, distance), center)
				self._camera.Focus = CFrame.new(center)
			end
			if self._placeholderGui then self._placeholderGui.Visible = false end
			return self
		end
		if option.Model then option:_applyModel(option.Model) end
	elseif kind == "console" then
		local frame = extCreate("Frame", {LayoutOrder=option.position, Size=UDim2.new(1,0,0,tonumber(option.height) or 88), BackgroundColor3=Color3.fromRGB(15,15,17), BorderSizePixel=0, Parent=parent.content})
		extLine(frame,Color3.fromRGB(60,60,65),1)
		local scroll = extCreate("ScrollingFrame", {Size=UDim2.new(1,-8,1,-8), Position=UDim2.fromOffset(4,4), BackgroundTransparency=1, BorderSizePixel=0, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollBarThickness=3, Parent=frame})
		local layout=extCreate("UIListLayout", {Padding=UDim.new(0,2), Parent=scroll})
		option._gui=frame; option._console=scroll
		option.Append=function(self,text) local lineGui=extCreate("TextLabel", {Size=UDim2.new(1,-4,0,16), BackgroundTransparency=1, Text=tostring(text), TextColor3=extTheme.Dim, TextSize=11, Font=Enum.Font.Code, TextXAlignment=Enum.TextXAlignment.Left, Parent=self._console}); return lineGui end
		option.Clear=function(self) if self._console then for _,c in ipairs(self._console:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end end; return self end
		if option.Text ~= "" then option:Append(option.Text) end
	end
	option.__extendedRendered=true
end

local function extRenderAll(lib)
	local function walk(parent)
		if type(parent) ~= "table" then return end
		if parent.content then
			for _,o in ipairs(parent.options or {}) do
				extDecorateOption(lib,o)
				if o.__extendedKind then extRenderOption(lib,o,parent) end
				if o.type=="folder" then walk(o) end
			end
		end
	end
	for _,w in ipairs(lib.windows or {}) do walk(w) end
end

local function extPostInitOptions(lib)
	local function walk(p)
		for _,o in ipairs(p.options or {}) do
			o.__parent=p
			if o.type=="toggle" then
				o.Value=o.state
			o.State=o.state
			local baseSet=o.SetState
			o.SetValue=function(self,v) return baseSet(self,v==true) end
		elseif o.type=="slider" then
			o.Value=o.value
			o.Min=o.min
			o.Max=o.max
			o.Rounding=o.float
		elseif o.type=="bind" then
			o.Key=o.key
			o.Mode=o.Mode or (o.hold and "Hold" or "Toggle")
			local baseKey=o.SetKey
			o.SetValue=function(self,v) if baseKey then return baseKey(self,v) end return self end
			o.SetMode=function(self,v) self.Mode=tostring(v or "Toggle"); self.hold=self.Mode:lower()=="hold"; return self end
		elseif o.type=="box" then
			o.Value=o.value
		elseif o.type=="color" then
			o.Value=o.color
			o.SetValue=o.SetValue or function(self,v) return self:SetColor(v) end
		elseif o.type=="list" then
			o.Values=o.values
			o.Multi=o.Multi==true or o.multi==true
			o.Searchable=o.Searchable==true or o.searchable==true
			o.RefreshPool=function(self,values) self.values=type(values)=="table" and values or {}; self.Values=self.values; return self end
			o.SetValues=o.RefreshPool
			o.Add=function(self,v) table.insert(self.values,tostring(v)); return self end
			o.Remove=function(self,v) for i,x in ipairs(self.values) do if tostring(x)==tostring(v) then table.remove(self.values,i); break end end; return self end
			o.SetValueImages=function(self,v) self.ValueImages=v; return self end
			if o.Multi then
				o.Selected=type(o.Default)=="table" and table.clone(o.Default) or {}
				local selected=o.Selected
				o.SetValue=function(self,v)
					local key=tostring(v)
					local found=false
					for i,x in ipairs(selected) do
						if tostring(x)==key then table.remove(selected,i); found=true; break end
					end
					if not found then table.insert(selected,v) end
					lib.flags[self.flag]=selected
					extFireChanged(self,selected)
					return self
				end
			end
			end
			if o.type=="folder" then walk(o) end
		end
	end
	for _,w in ipairs(lib.windows or {}) do walk(w) end
end

local oldCreateWindow = library.CreateWindow
local oldInit = library.Init
local oldClose = library.Close

local function decorateParent(lib, parent)
	if not parent or parent.__extendedParent then return parent end
	parent.__extendedParent=true
	local oldToggle=parent.AddToggle
	local oldButton=parent.AddButton
	local oldBind=parent.AddBind
	local oldSlider=parent.AddSlider
	local oldList=parent.AddList
	local oldBox=parent.AddBox
	local oldColor=parent.AddColor
	local oldLabel=parent.AddLabel
	local oldFolder=parent.AddFolder
	local oldImage=parent.AddImage
	local oldViewport=parent.AddViewport

	local function wrapResult(o)
		o.__parent = parent
		extDecorateOption(lib,o)
		o.AddColorPicker=function(self,a,b) local x=self.__parent:AddColor(a,b); return x end
		o.AddKeyPicker=function(self,a,b) local x=self.__parent:AddBind(a,b); return x end
		o.AddButton=function(self,a,b) local x=self.__parent:AddButton(a,b); return x end
		o.__baseSetValue=o.SetValue
		o.SetValue=function(self,v,...) return extSetOptionValue(lib,self,v,...) end
		return o
	end
	parent.AddToggle=function(self,a,b)
		local o=extNormalize(a,b); o.state=o.Default==true; o.callback=o.Callback; o.flag=o.Flag; local r=oldToggle(self,o); r=wrapResult(r); return r
	end
	parent.AddCheckbox=parent.AddToggle
	parent.AddButton=function(self,a,b) local o=extNormalize(a,b); o.callback=o.Callback; o.flag=o.Flag; return wrapResult(oldButton(self,o)) end
	parent.AddBind=function(self,a,b) local o=extNormalize(a,b); o.key=o.Default or o.Key or o.key or "F"; o.hold=o.Hold==true or o.hold==true; o.callback=o.Callback; return wrapResult(oldBind(self,o)) end
	parent.AddKeybind=parent.AddBind
	parent.AddKeyPicker=parent.AddBind
	parent.AddSlider=function(self,a,b) local o=extNormalize(a,b); o.min=tonumber(o.Min or o.min) or 0; o.max=tonumber(o.Max or o.max) or 100; o.value=tonumber(o.Default ~= nil and o.Default or o.Value or o.value) or o.min; o.float=tonumber(o.Rounding or o.rounding or o.float) or 1; o.callback=o.Callback; return wrapResult(oldSlider(self,o)) end
	parent.AddList=function(self,a,b) local o=extNormalize(a,b); o.values=o.Values or o.values or {}; o.value=o.Default ~= nil and o.Default or o.value or o.values[1] or ""; o.callback=o.Callback; return wrapResult(oldList(self,o)) end
	parent.AddDropdown=parent.AddList
	parent.AddMultiDropdown=parent.AddList
	parent.AddBox=function(self,a,b) local o=extNormalize(a,b); o.value=o.Default ~= nil and o.Default or o.value or ""; o.callback=o.Callback; return wrapResult(oldBox(self,o)) end
	parent.AddInput=parent.AddBox
	parent.AddColor=function(self,a,b) local o=extNormalize(a,b); o.color=o.Default or o.Color or o.color or Color3.new(1,1,1); o.callback=o.Callback; return wrapResult(oldColor(self,o)) end
	parent.AddColorPicker=parent.AddColor
	parent.AddLabel=function(self,a,b) local o=extNormalize(a,b); o.text=o.Text; local r=oldLabel(self,o); return wrapResult(r) end
	parent.AddFolder=function(self,a)
		local name=type(a)=="table" and (a.Name or a.Text or a.Title) or a
		local r=oldFolder(self,name)
		decorateParent(lib,r)
		return r
	end
	parent.AddSection=parent.AddFolder
	parent.AddGroup=parent.AddFolder
	parent.CreateGroup=parent.AddFolder
	parent.AddGroupbox=parent.AddFolder
	parent.AddLeftGroupbox=parent.AddFolder
	parent.AddRightGroupbox=parent.AddFolder
	parent.CreateSection=parent.AddFolder
	parent.CreateButton=parent.AddButton
	parent.CreateToggle=parent.AddToggle
	parent.CreateSwitch=parent.AddToggle
	parent.CreateSlider=parent.AddSlider
	parent.CreateDropdown=parent.AddDropdown
	parent.CreateInput=parent.AddInput
	parent.CreateKeybind=parent.AddBind
	parent.CreateColorPicker=parent.AddColor
	parent.CreateText=parent.AddLabel
	parent.CreateDivider=function(self,a) return self:AddDivider(a) end
	parent.CreateStat=function(self,a,b) return self:AddStat(a,b) end
	parent.CreateProgress=function(self,a,b) return self:AddProgress(a,b) end
	parent.CreateConsole=function(self,a,b) return self:AddConsole(a,b) end

	function parent:AddParagraph(a,b)
		local o=extNormalize(a,b); o.__extendedKind="paragraph"; o.title=o.Title or o.Text; o.description=o.Description or o.desc or o.DescriptionText or ""; o.text=o.title; o.type="label"; o.position=#self.options; o.flag=o.Flag or o.Text; table.insert(self.options,o); extDecorateOption(lib,o); return o
	end
	function parent:AddDivider()
		local o={__extendedKind="divider",type="label",text="",position=#self.options,flag="__divider_"..tostring(#self.options)}; table.insert(self.options,o); return extDecorateOption(lib,o)
	end
	function parent:AddText(a,b)
		local o=extNormalize(a,b); o.__extendedKind="text"; o.type="label"; o.position=#self.options; table.insert(self.options,o); return extDecorateOption(lib,o)
	end
	function parent:AddStat(a,b)
		local o=extNormalize(a,b); o.__extendedKind="stat"; o.type="label"; o.value=o.Default~=nil and o.Default or o.Value or 0; o.position=#self.options; o.flag=o.Flag or o.Text; table.insert(self.options,o); lib.flags[o.flag]=o.value; extDecorateOption(lib,o); o.Set=function(self,v) self.value=v; lib.flags[self.flag]=v; extFireChanged(self,v); return self end; o.GetValue=function(self) return self.value end; return o
	end
	function parent:AddProgress(a,b)
		local o=extNormalize(a,b); o.__extendedKind="progress"; o.type="label"; o.min=tonumber(o.Min or o.min) or 0; o.max=tonumber(o.Max or o.max) or 100; o.value=math.clamp(tonumber(o.Default~=nil and o.Default or o.Value or o.value) or o.min,o.min,o.max); o.rounding=tonumber(o.Rounding or 1) or 1; o.position=#self.options; o.flag=o.Flag or o.Text; table.insert(self.options,o); lib.flags[o.flag]=o.value; extDecorateOption(lib,o); o.GetPercentage=function(self) local a=tonumber(self.min) or 0; local z=tonumber(self.max) or 100; if z==a then return 0 end; return ((tonumber(self.value) or a)-a)/(z-a)*100 end; o.GetValue=function(self) return self.value end; o.Set=function(self,v) self.value=math.clamp(tonumber(v) or self.min,self.min,self.max); lib.flags[self.flag]=self.value; extFireChanged(self,self.value); if self._fillGui then self._fillGui.Size=UDim2.new(self:GetPercentage()/100,0,1,0) end; if self._valueGui then self._valueGui.Text=tostring(round(self.value,self.rounding)) end; return self end; return o
	end
	function parent:AddConsole(a,b)
		local o=extNormalize(a,b); o.__extendedKind="console"; o.type="label"; o.height=tonumber(o.Height or o.height) or 88; o.position=#self.options; o.flag=o.Flag or o.Text; table.insert(self.options,o); extDecorateOption(lib,o); o.Append=function(self,text) if not self._console then self.__pending=self.__pending or {}; table.insert(self.__pending,tostring(text)); return self end; local g=extCreate("TextLabel",{Size=UDim2.new(1,-4,0,16),BackgroundTransparency=1,Text=tostring(text),TextColor3=extTheme.Dim,TextSize=11,Font=Enum.Font.Code,TextXAlignment=Enum.TextXAlignment.Left,Parent=self._console}); return g end; o.Clear=function(self) if self._console then for _,c in ipairs(self._console:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end end; return self end; return o
	end
	parent.AddImage=function(self,a,b)
		local o=extNormalize(a,b); o.Image=o.Image or o.image or o.Value or o.value or o.Default or ""; if typeof(o.Image)=="number" then o.Image="rbxassetid://"..tostring(o.Image) end; o.__extendedKind="image"; o.type="label"
		local r=oldImage(self,o); extDecorateOption(lib,r); return r
	end
	parent.AddViewport=function(self,a,b)
		local o=extNormalize(a,b); o.Model=o.Model or o.model; o.__extendedKind="viewport"; o.type="label"
		local r=oldViewport(self,o); extDecorateOption(lib,r); return r
	end
	parent.CreateImage=parent.AddImage
	parent.CreateViewport=parent.AddViewport

	parent.AddParagraph=parent.AddParagraph
	parent.AddSeparator=parent.AddDivider
	parent.AddDividerLine=parent.AddDivider
	return parent
end

function library:OnFlagChange(flag, fn)
	self._flagListeners=self._flagListeners or {}
	self._flagListeners[flag]=self._flagListeners[flag] or {}
	if type(fn)=="function" then table.insert(self._flagListeners[flag],fn) end
	return self
end

function library:SetFlag(flag,value)
	self.flags[flag]=value
	local listeners=self._flagListeners and self._flagListeners[flag]
	if listeners then for _,fn in ipairs(listeners) do extCall(fn,value) end end
	for _,w in ipairs(self.windows or {}) do
		local function walk(p)
			for _,o in ipairs(p.options or {}) do
				if o.flag==flag then
					extSetOptionValue(self,o,value)
					extFireChanged(o,value)
				end
				if o.type=="folder" then walk(o) end
			end
		end
		walk(w)
	end
	return self
end

function library:GetFlag(flag) return self.flags[flag] end
library.Get=library.GetFlag
library.Set=library.SetFlag

function library:SetAccent(color)
	if typeof(color)~="Color3" then return self end
	extTheme.Accent=color
	for _,w in ipairs(self.windows or {}) do
		local function walk(p)
			for _,o in ipairs(p.options or {}) do
				if o._valueGui then o._valueGui.TextColor3=color end
				if o._fillGui then o._fillGui.BackgroundColor3=color end
				if o.type=="folder" then walk(o) end
			end
		end
		walk(w)
	end
	return self
end

function library:SetKeybind(key)
	self.ToggleKeybind=key
	return self
end
library.SetToggleKey=library.SetKeybind

function library:Notify(a,b,c)
	if not self.base then
		self._pendingNotifications=self._pendingNotifications or {}
		table.insert(self._pendingNotifications,{a,b,c})
		return nil
	end
	local info=type(a)=="table" and a or {Title=a,Description=b,Duration=c}
	local title=tostring(info.Title or info.title or "Notification")
	local text=tostring(info.Description or info.Content or info.Text or info.text or "")
	local duration=tonumber(info.Duration or info.Time or info.time) or 3
	local side=tostring(info.Side or self.NotifySide or "Right"):lower()
	self._notifications=self._notifications or {}
	local camera=workspace.CurrentCamera
	local vp=camera and camera.ViewportSize or Vector2.new(800,600)
	local width=math.max(180,math.min(250,vp.X-16))
	local textWidth=math.max(140,width-22)
	local titleBounds=textService:GetTextSize(title,12,self.Font or Enum.Font.GothamBold,Vector2.new(textWidth,1000))
	local bodyBounds=textService:GetTextSize(text,11,Enum.Font.Code,Vector2.new(textWidth,1000))
	local titleHeight=math.max(16,titleBounds.Y)
	local bodyHeight=text=="" and 0 or math.max(14,bodyBounds.Y)
	local height=8+titleHeight+(text=="" and 0 or 4+bodyHeight)+8
	local n=extCreate("Frame",{Size=UDim2.fromOffset(width,height),AnchorPoint=Vector2.new(side=="left" and 0 or 1,0),BackgroundColor3=Color3.fromRGB(15,15,17),BorderSizePixel=0,ZIndex=900,Parent=self.base})
	if not n then return nil end
	local index=#self._notifications
	local x=side=="left" and 8 or -8
	n.Position=UDim2.new(side=="left" and 0 or 1,x,0,12+index*(height+6))
	extLine(n,Color3.fromRGB(60,60,65),1)
	extCreate("Frame",{Size=UDim2.new(0,2,1,0),BackgroundColor3=extTheme.Accent,BorderSizePixel=0,ZIndex=901,Parent=n})
	extCreate("TextLabel",{Size=UDim2.new(1,-22,0,titleHeight),Position=UDim2.fromOffset(10,6),BackgroundTransparency=1,Text=title,TextColor3=extTheme.Text,TextSize=12,Font=self.Font or Enum.Font.GothamBold,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,ZIndex=901,Parent=n})
	if text~="" then
		extCreate("TextLabel",{Size=UDim2.new(1,-22,0,bodyHeight),Position=UDim2.fromOffset(10,6+titleHeight+4),BackgroundTransparency=1,Text=text,TextColor3=extTheme.Dim,TextSize=11,Font=Enum.Font.Code,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,ZIndex=901,Parent=n})
	end
	table.insert(self._notifications,n)
	task.delay(math.max(0.5,duration),function()
		if n and n.Parent then n:Destroy() end
		for i,v in ipairs(self._notifications) do if v==n then table.remove(self._notifications,i) break end end
		local y=12
		for _,v in ipairs(self._notifications) do
			if v and v.Parent then
				v.Position=UDim2.new(side=="left" and 0 or 1,side=="left" and 8 or -8,0,y)
				y=y+v.AbsoluteSize.Y+6
			end
		end
	end)
	return n
end

library.CreateNotification=library.Notify
library.ShowNotification=library.Notify

function library:Search(query)
	extSearchQuery=tostring(query or ""):lower()
	self.LastSearch=extSearchQuery
	local function walk(p)
		for _,o in ipairs(p.options or {}) do
			local match=extSearchQuery=="" or tostring(o.text or o.Text or o.title or ""):lower():find(extSearchQuery,1,true)~=nil
			o.SearchVisible=match
			if o._gui then o._gui.Visible=match and o.Visible~=false end
			if o.type=="folder" then walk(o) end
		end
	end
	for _,w in ipairs(self.windows or {}) do walk(w) end
	return self
end
library.UpdateSearch=library.Search

function library:OnUnload(fn)
	if type(fn)=="function" then table.insert(extUnloadCallbacks,fn) end
	return self
end

function library:Unload()
	if self.Unloaded then return end
	self.Unloaded=true
	if self.activePopup and self.activePopup.Close then self.activePopup:Close() end
	for _,fn in ipairs(extUnloadCallbacks) do extCall(fn) end
	for _,c in ipairs(extConnections) do if c and c.Disconnect then c:Disconnect() end end
	extConnections={}
	if self.base then self.base:Destroy(); self.base=nil end
end

function library:GiveSignal(signal)
	if signal then table.insert(extConnections,signal) end
	return signal
end

function library:SafeCallback(fn,...)
	return extCall(fn,...)
end

function library:SetConfigFolder(path)
	path = tostring(path or "suic1UI"):gsub("[\\/]+$", "")
	if path == "" then path = "suic1UI" end
	self.ConfigFolder = path
	return self
end

function library:InitConfigStore()
	self.ConfigFolder=self.ConfigFolder or "suic1UI"
	if type(makefolder)=="function" and type(isfolder)=="function" then pcall(function() if not isfolder(self.ConfigFolder) then makefolder(self.ConfigFolder) end end) end
	return self
end

function library:SaveConfig(name)
	self:InitConfigStore()
	local data={flags={}}
	for k,v in pairs(self.flags or {}) do
		if typeof(v)=="Color3" then data.flags[k]={__type="Color3",r=v.R,g=v.G,b=v.B}
		elseif typeof(v)=="EnumItem" then data.flags[k]={__type="EnumItem",enum=tostring(v.EnumType),name=v.Name}
		elseif type(v)~="function" and type(v)~="userdata" then data.flags[k]=v end
	end
	local ok,json=pcall(function() return extHttp:JSONEncode(data) end)
	if ok and type(writefile)=="function" then pcall(function() writefile(self.ConfigFolder.."/"..tostring(name)..".json",json) end) end
	return ok
end

function library:LoadConfig(name)
	self:InitConfigStore()
	if type(readfile)~="function" or type(isfile)~="function" then return false end
	local ok,raw=pcall(function() return isfile(self.ConfigFolder.."/"..tostring(name)..".json") and readfile(self.ConfigFolder.."/"..tostring(name)..".json") end)
	if not ok or not raw then return false end
	local dok,data=pcall(function() return extHttp:JSONDecode(raw) end)
	if not dok or type(data)~="table" then return false end
	for k,v in pairs(data.flags or {}) do
		if type(v)=="table" and v.__type=="Color3" then v=Color3.new(v.r or 0,v.g or 0,v.b or 0) end
		self:SetFlag(k,v)
	end
	return true
end

function library:DeleteConfig(name)
	self:InitConfigStore()
	if type(delfile)=="function" then pcall(function() delfile(self.ConfigFolder.."/"..tostring(name)..".json") end) end
	return self
end

function library:ListConfigs()
	self:InitConfigStore()
	if type(listfiles)~="function" then return {} end
	local out={}
	local ok,files=pcall(function() return listfiles(self.ConfigFolder) end)
	if ok and type(files)=="table" then for _,f in ipairs(files) do local n=f:match("([^/\\]+)%.json$"); if n then table.insert(out,n) end end end
	return out
end
library.SaveConfiguration=library.SaveConfig
library.LoadConfiguration=library.LoadConfig
library.DeleteConfiguration=library.DeleteConfig
library.GetConfigs=library.ListConfigs

function library:CreateLoading(title,text)
	return self:Notify(title or "Loading",text or "Please wait...",999999)
end

function library:ChangeTheme(theme)
	if type(theme)=="table" then for k,v in pairs(theme) do if extTheme[k]~=nil and typeof(v)=="Color3" then extTheme[k]=v end end; if theme.Accent then self:SetAccent(theme.Accent) end end
	return self
end

function library:SetDPIScale(scale)
	self.DPIScale=tonumber(scale) or 1
	if self.base then
		local uiScale=self.base:FindFirstChild("LibraryScale")
		if not uiScale then uiScale=extCreate("UIScale",{Name="LibraryScale",Parent=self.base}) end
		if uiScale then uiScale.Scale=self.DPIScale end
	end
	return self
end

function library:SetNotifySide(side) self.NotifySide=side; return self end
function library:SetFont(font)
	local resolved=font
	if type(font)=="string" and Enum.Font[font] then resolved=Enum.Font[font] end
	if typeof(resolved)~="EnumItem" then return self end
	self.Font=resolved
	if self.base then
		for _,obj in ipairs(self.base:GetDescendants()) do
			if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then pcall(function() obj.Font=resolved end) end
		end
	end
	return self
end
function library:SetTheme(theme) return self:ChangeTheme(theme) end
function library:Configure(options)
	if type(options)~="table" then return self end
	if options.Theme then self:ChangeTheme(options.Theme) end
	if options.Accent then self:SetAccent(options.Accent) end
	if options.Font then self:SetFont(options.Font) end
	if options.NotifySide then self:SetNotifySide(options.NotifySide) end
	if options.DPIScale then self:SetDPIScale(options.DPIScale) end
	if options.BackgroundImage then self:SetBackgroundImage(options.BackgroundImage,options.BackgroundTransparency) end
	if options.ToggleKeybind then self:SetKeybind(options.ToggleKeybind) end
	return self
end

function library:Toggle(value)
	local state=value
	if state==nil then state=not self.open end
	self.open=state==true
	for _,w in ipairs(self.windows or {}) do if w.main then w.main.Visible=self.open and w.open~=false end end
	return self
end

function library:SetToggleKeybind(key) return self:SetKeybind(key) end
library.SetMenuKeybind=library.SetKeybind

function library:UpdateColorsUsingRegistry()
	return self:ChangeTheme({Accent=extTheme.Accent,Background=extTheme.Background,Panel=extTheme.Panel,Text=extTheme.Text,Dim=extTheme.Dim})
end

function library:AddTooltip(tooltip,disabledTooltip,element)
	if not element then return nil end
	local target=element._gui or element
	if not target or not target:IsA("GuiObject") then return nil end
	local tip=extCreate("TextLabel",{Size=UDim2.fromOffset(180,24),BackgroundColor3=Color3.fromRGB(15,15,17),BorderSizePixel=0,Text="",TextColor3=Color3.fromRGB(220,220,220),TextSize=12,Font=Enum.Font.Code,Visible=false,ZIndex=1000,Parent=self.base})
	if not tip then return nil end
	extLine(tip,Color3.fromRGB(60,60,65),1)
	extConnect(target.MouseEnter,function() tip.Text=element.Disabled and tostring(disabledTooltip or tooltip or "") or tostring(tooltip or ""); tip.Size=UDim2.fromOffset(math.min(240,math.max(80,textService:GetTextSize(tip.Text,12,Enum.Font.Code,Vector2.new(220,100)).X+12)),24); tip.Position=UDim2.fromOffset(target.AbsolutePosition.X,target.AbsolutePosition.Y+target.AbsoluteSize.Y+4); tip.Visible=true end)
	extConnect(target.MouseLeave,function() tip.Visible=false end)
	return tip
end

function library:SetBackgroundImage(image,transparency)
	self.BackgroundImage=image
	if self.base and image then
		local bg=extCreate("ImageLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Image=tostring(image),ImageTransparency=transparency or 0,Parent=self.base})
		bg.ZIndex=-100
	end
	return self
end
function library:GetTextBounds(text,size,font,bounds) return textService:GetTextSize(tostring(text),size or 14,font or Enum.Font.GothamBlack,bounds or Vector2.new(9e9,9e9)) end
function library:GetKeyString(key) return typeof(key)=="EnumItem" and key.Name or tostring(key or "") end
function library:GetBetterColor(a,b) return a:Lerp(b or Color3.new(1,1,1),0.5) end
function library:GetLighterColor(a) return a:Lerp(Color3.new(1,1,1),0.2) end
function library:GetDarkerColor(a) return a:Lerp(Color3.new(0,0,0),0.2) end
function library:MouseIsOverFrame(frame) local m=inputService:GetMouseLocation(); local p=frame.AbsolutePosition; local s=frame.AbsoluteSize; return m.X>=p.X and m.X<=p.X+s.X and m.Y>=p.Y and m.Y<=p.Y+s.Y end
library.IsInsideFrame=library.MouseIsOverFrame
function library:AddToRegistry(obj,props) self._registry=self._registry or {}; table.insert(self._registry,{obj=obj,props=props or {}}); return obj end
function library:RemoveFromRegistry(obj) if self._registry then for i,v in ipairs(self._registry) do if v.obj==obj then table.remove(self._registry,i) break end end end return self end
function library:UpdateColorsUsingRegistry() if self._registry then for _,v in ipairs(self._registry) do if v.obj and v.obj.Parent then for p,c in pairs(v.props) do if p=="BackgroundColor3" and c=="Accent" then v.obj[p]=extTheme.Accent end end end end end return self end
function library:MakeLine(frame,info) return extLine(frame,type(info)=="table" and info.Color or extTheme.Panel,1,type(info)=="table" and info.Position or nil) end
function library:AddBlank(frame,size) return extCreate("Frame",{Size=size or UDim2.fromOffset(1,4),BackgroundTransparency=1,Parent=frame}) end
function library:AddOutline(frame) return extLine(frame,Color3.fromRGB(60,60,60),1) end
library.MakeOutline=library.AddOutline
function library:ApplyLucideIcon(gui,icon,rotation) if gui and (gui:IsA("ImageLabel") or gui:IsA("ImageButton")) then gui.Image=typeof(icon)=="number" and "rbxassetid://"..icon or tostring(icon or ""); gui.Rotation=rotation or 0 end return gui end
function library:GetIcon(name) return self.Icons and self.Icons[name] end
function library:GetCustomIcon(name) return self.CustomIcons and self.CustomIcons[name] end
function library:SetIconModule(m) self.IconModule=m; return self end
function library:SetCustomIcon(name,image) self.CustomIcons=self.CustomIcons or {}; self.CustomIcons[name]=image; return self end
function library:MakeDraggable(object,handle)
	if not object or not handle then return object end
	local active=false; local start; local pos
	extConnect(handle.InputBegan,function(i) if i.UserInputType==ui or i.UserInputType==Enum.UserInputType.Touch then active=true; start=i.Position; pos=object.Position end end)
	extConnect(inputService.InputChanged,function(i) if active and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-start; object.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y) end end)
	extConnect(inputService.InputEnded,function(i) if i.UserInputType==ui or i.UserInputType==Enum.UserInputType.Touch then active=false end end)
	return object
end
function library:AddDraggableLabel(text) if not self.base then return nil end; local x=extCreate("TextLabel",{Size=UDim2.fromOffset(220,24),Position=UDim2.fromOffset(8,8),BackgroundColor3=Color3.fromRGB(20,20,20),Text=tostring(text),TextColor3=extTheme.Text,TextSize=11,Font=Enum.Font.Code,Parent=self.base}); extLine(x,Color3.fromRGB(60,60,60),1); self:MakeDraggable(x,x); return x end
function library:AddDraggableButton(text,callback) local x=self:AddDraggableLabel(text); if x then x.InputBegan:Connect(function(i) if i.UserInputType==ui or i.UserInputType==Enum.UserInputType.Touch then extCall(callback) end end) end return x end
function library:AddDraggableImageButton(text,image,callback) local x=self:AddDraggableButton(text,callback); if x then x.Text=""; extCreate("ImageLabel",{Size=UDim2.fromOffset(18,18),Position=UDim2.fromOffset(3,3),BackgroundTransparency=1,Image=tostring(image or ""),Parent=x}) end return x end
function library:AddDraggableMenu(name) return self:AddDraggableLabel(name) end
function library:Validate(template,shape) local o=type(template)=="table" and table.clone(template) or {}; if type(shape)=="table" then for k,v in pairs(shape) do if o[k]==nil then o[k]=v end end end return o end

local oldCreateWindow2=library.CreateWindow
library.CreateWindow=function(self,title)
	local w=oldCreateWindow2(self,type(title)=="table" and (title.Title or title.Name or "Window") or title)
	decorateParent(self,w)
	if type(title)=="table" then w.Footer=title.Footer; w.NotifySide=title.NotifySide; w.Icon=title.Icon; w.AutoShow=title.AutoShow~=false; w.ToggleKeybind=title.ToggleKeybind or title.ToggleKey end
	function w:Toggle() self.open=not self.open; if self.main then self.main.Visible=self.open end; return self end
	function w:Minimize() self.open=false; if self.main then self.main.Visible=false end; return self end
	function w:Show() self.open=true; if self.main then self.main.Visible=true end; return self end
	function w:Destroy() self.open=false; if self.main then self.main:Destroy() end; return self end
	function w:SetTitle(v) self.title=tostring(v); if self.main and self.main:FindFirstChildOfClass("TextLabel") then self.main:FindFirstChildOfClass("TextLabel").Text=self.title end; return self end
	function w:SetIcon(v) self.Icon=v; return self end
	function w:Center() if self.main then local vp=workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800,600); self.main.Position=UDim2.fromOffset(math.max(8,math.floor((vp.X-self.main.AbsoluteSize.X)*0.5)),12) end return self end
	function w:SetWidth(v) self.Width=math.clamp(tonumber(v) or 260,220,420); if self.main then self.main.Size=UDim2.fromOffset(self.Width,self.main.AbsoluteSize.Y) end; return self end
	function w:SetMaxHeight(v) self.MaxHeight=math.max(200,tonumber(v) or 560); return self end
	function w:GetOptions() local out={}; local function walk(p) for _,o in ipairs(p.options or {}) do table.insert(out,o); if o.type=="folder" then walk(o) end end end; walk(self); return out end
	function w:Refresh() extRenderAll(self); return self end
	function w:AddDependency(flag,value) self.__windowDependencies=self.__windowDependencies or {}; table.insert(self.__windowDependencies,{flag=flag,value=value}); return self end
	function w:AddTab(name) local n=type(name)=="table" and (name.Name or name.Text or name.Title) or name; local tab=self:AddFolder(n or "Tab"); tab.Name=n; return tab end
	w.CreateTab=w.AddTab
	function w:AddKeyTab(name) return self:AddTab(name or "Key System") end
	function w:AddLeftTabbox(info) local box=self:AddFolder(type(info)=="table" and (info.Name or "Tabs") or tostring(info or "Tabs")); function box:AddTab(a) local n=type(a)=="table" and (a.Name or a.Text or a.Title) or a; local t=self:AddFolder(n or "Tab"); t.Name=n; return t end; box.CreateTab=box.AddTab; return box end
	w.AddRightTabbox=w.AddLeftTabbox
	function w:AddDialog(a,b) return self._library and self._library:AddDialog(self,a,b) or self:AddFolder(type(a)=="table" and (a.Title or "Dialog") or a) end
	w._library=self
	return w
end

function library:AddDialog(window,a,b)
	if not self.base then return nil end
	local info=type(a)=="table" and a or (type(b)=="table" and b or {Title=tostring(a or "Dialog"),Description=tostring(b or "")})
	local f=extCreate("Frame",{Size=UDim2.fromOffset(224,120),Position=UDim2.fromOffset(8,8),BackgroundColor3=Color3.fromRGB(20,20,20),BorderSizePixel=0,ZIndex=950,Parent=self.base}); extLine(f,Color3.fromRGB(60,60,60),1)
	extCreate("TextLabel",{Size=UDim2.new(1,-16,0,20),Position=UDim2.fromOffset(8,6),BackgroundTransparency=1,Text=tostring(info.Title or "Dialog"),TextColor3=extTheme.Text,TextSize=13,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=951,Parent=f})
	extCreate("TextLabel",{Size=UDim2.new(1,-16,0,48),Position=UDim2.fromOffset(8,28),BackgroundTransparency=1,Text=tostring(info.Description or info.Text or ""),TextColor3=extTheme.Dim,TextSize=11,Font=Enum.Font.Code,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=951,Parent=f})
	local obj={Frame=f,Buttons={}}
	function obj:Dismiss() if self.Frame then self.Frame:Destroy() end end
	function obj:SetTitle(v) local x=self.Frame and self.Frame:FindFirstChildOfClass("TextLabel"); if x then x.Text=tostring(v) end; return self end
	function obj:AddFooterButton(k,button) local bi=type(button)=="table" and button or {Text=tostring(button or k)}; local bt=extCreate("TextButton",{Size=UDim2.fromOffset(64,22),Position=UDim2.fromOffset(8+(#self.Buttons*70),88),BackgroundColor3=Color3.fromRGB(30,30,30),Text=tostring(bi.Text or k),TextColor3=extTheme.Text,TextSize=11,Font=Enum.Font.Code,AutoButtonColor=false,Parent=self.Frame}); self.Buttons[k]=bt; bt.Activated:Connect(function() extCall(bi.Func or bi.Callback,self) end); return self end
	return obj
end

local function patchBaseMethods(parent)
	if not parent then return end
	if parent.__basePatched then return end
	parent.__basePatched=true
end

local oldInit2=library.Init
library.Init=function(self)
	local r=oldInit2(self)
	extRenderAll(self)
	extPostInitOptions(self)
	if self._pendingNotifications then
		local pending=self._pendingNotifications
		self._pendingNotifications=nil
		for _,n in ipairs(pending) do self:Notify(n[1],n[2],n[3]) end
	end
	return r
end

local oldClose2=library.Close
library.Close=function(self) local r=oldClose2(self); return r end

function library:UpdateDependencies()
	local function matches(v,target)
		if type(target)=="function" then return target(v) end
		return target==nil and v or v==target
	end
	local function walk(p)
		for _,o in ipairs(p.options or {}) do
			if o.__dependencies then
				local visible=true
				for _,d in ipairs(o.__dependencies) do if not matches(self.flags[d.flag],d.value) then visible=false break end end
				o.Visible=visible
				if o._gui then o._gui.Visible=visible end
			end
			if o.type=="folder" then walk(o) end
		end
	end
	for _,w in ipairs(self.windows or {}) do walk(w) end
	return self
end


function library:SetFolderVisible(folder, visible)
	if type(folder) ~= "table" then return false end
	for _, option in ipairs(folder.options or {}) do
		option._hidden = not visible
		if option._gui then option._gui.Visible = visible end
		if option.type == "folder" then self:SetFolderVisible(option, visible) end
	end
	return self
end

function library:HideElement(option, hidden)
	if type(option) ~= "table" then return false end
	option._hidden = hidden ~= false
	if option._gui then option._gui.Visible = not option._hidden end
	return self
end

function library:DeleteElement(parent, option)
	if type(parent) ~= "table" or type(option) ~= "table" then return false end
	for i, item in ipairs(parent.options or {}) do
		if item == option then
			table.remove(parent.options, i)
			if option._gui then option._gui:Destroy() end
			if option.flag then self.flags[option.flag] = nil end
			return true
		end
	end
	return false
end

function library:RunExample()
	if self.Unloaded then return nil end
	local window = self:CreateWindow("suic1.de | RunExample")
	local main = window:AddFolder("Main Elements")
	local advanced = window:AddFolder("Advanced Elements")
	local media = window:AddFolder("Media")
	local configuration = window:AddFolder("Configuration")
	local management = window:AddFolder("Element Management")
	local diagnostics = window:AddFolder("Diagnostics")

	main:AddLabel({text = "Core controls"})
	main:AddToggle({text = "Toggle", flag = "ExampleToggle", state = false, callback = function(v) self:Notify("Toggle", tostring(v), 2) end})
	main:AddButton({text = "Button", callback = function() self:Notify("Button", "Callback fired", 2) end})
	main:AddSlider({text = "Slider", flag = "ExampleSlider", min = 0, max = 100, value = 50, float = 1, callback = function(v) self.flags.ExampleSlider = v end})
	main:AddList({text = "Dropdown", flag = "ExampleDropdown", values = {"Red", "Green", "Blue"}, value = "Red", callback = function(v) self.flags.ExampleDropdown = v end})
	main:AddBox({text = "Input", flag = "ExampleInput", value = "Type here", callback = function(v) self.flags.ExampleInput = v end})
	main:AddBind({text = "Keybind", flag = "ExampleKeybind", key = "X", hold = false, callback = function() self:Notify("Keybind", "Activated", 2) end})
	local colorOption = main:AddColor({text = "Color Picker", flag = "ExampleColor", color = Color3.fromRGB(255, 65, 65), callback = function(v) self.flags.ExampleColor = v end})

	advanced:AddParagraph({Title = "Paragraph", Description = "Long descriptions wrap inside the available width instead of running outside the window."})
	advanced:AddDivider()
	advanced:AddText({Text = "Wrapped text label example with a longer description that should wrap across multiple lines."})
	advanced:AddCheckbox({text = "Checkbox", flag = "ExampleCheckbox", state = false, callback = function(v) self.flags.ExampleCheckbox = v end})
	advanced:AddDropdown({text = "Compatibility Dropdown", flag = "ExampleAliasDropdown", values = {"Option A", "Option B", "Option C"}, value = "Option A", callback = function(v) self.flags.ExampleAliasDropdown = v end})
	advanced:AddInput({text = "Compatibility Input", flag = "ExampleAliasInput", value = "Editable", callback = function(v) self.flags.ExampleAliasInput = v end})
	advanced:AddKeybind({text = "Compatibility Keybind", flag = "ExampleAliasKeybind", key = "Z", callback = function() self:Notify("Keybind", "Compatibility keybind activated", 2) end})
	advanced:AddColorPicker({text = "Compatibility Color", flag = "ExampleAliasColor", color = Color3.fromRGB(80, 200, 100), callback = function(v) self.flags.ExampleAliasColor = v end})
	advanced:AddStat({Text = "Example Stat", Flag = "ExampleStat", Default = 42})
	local nested = advanced:AddFolder("Nested Folder")
	nested:AddLabel({text = "Nested folder content"})
	nested:AddToggle({text = "Nested Toggle", flag = "ExampleNestedToggle", state = false})

	local image = media:AddImage({text = "", Image = "", Height = 128})
	local viewport = media:AddViewport({text = "", Height = 150})
	media:AddBox({text = "Image Asset ID", value = "", callback = function(value)
		local assetId = tostring(value or ""):match("%d+")
		if assetId and image and image.SetImage then image:SetImage(assetId) end
	end})
	media:AddLabel({text = "Paste a valid Roblox image asset ID to update the preview."})
	local previewModel = Instance.new("Model")
	previewModel.Name = "RunExamplePreviewModel"
	local part = Instance.new("Part")
	part.Name = "PreviewPart"
	part.Size = Vector3.new(3, 3, 3)
	part.Anchored = true
	part.Color = Color3.fromRGB(255, 65, 65)
	part.Parent = previewModel
	previewModel.PrimaryPart = part
	if viewport and viewport.SetModel then viewport:SetModel(previewModel) end
	media:AddButton({text = "Set Viewport Model", callback = function() if viewport and viewport.SetModel then viewport:SetModel(previewModel) end end})

	configuration:AddBox({text = "Config Folder", value = self.ConfigFolder or "suic1UI", callback = function(path) self:SetConfigFolder(path) end})
	configuration:AddBox({text = "Config Name", value = "default", callback = function(value) self._exampleConfigName = tostring(value ~= "" and value or "default") end})
	configuration:AddButton({text = "Save Config", callback = function() self:SaveConfig(self._exampleConfigName or "default"); self:Notify("Config", "Save requested", 2) end})
	configuration:AddButton({text = "Load Config", callback = function() local ok = self:LoadConfig(self._exampleConfigName or "default"); self:Notify("Config", ok and "Loaded" or "Could not load config", 2) end})
	configuration:AddButton({text = "List Configs", callback = function() local t = self:ListConfigs(); self:Notify("Configs", #t > 0 and table.concat(t, ", ") or "No configs found", 3) end})
	configuration:AddButton({text = "Delete Config", callback = function() self:DeleteConfig(self._exampleConfigName or "default"); self:Notify("Config", "Delete requested", 2) end})

	management:AddLabel({text = "Use the buttons to hide or remove example elements."})
	management:AddButton({text = "Hide Color Picker", callback = function() if colorOption and colorOption.SetVisible then colorOption:SetVisible(false) elseif colorOption and colorOption._gui then colorOption._gui.Visible = false end end})
	management:AddButton({text = "Show Color Picker", callback = function() if colorOption and colorOption.SetVisible then colorOption:SetVisible(true) elseif colorOption and colorOption._gui then colorOption._gui.Visible = true end end})
	management:AddButton({text = "Delete Color Picker", callback = function() if colorOption and colorOption.Remove then colorOption:Remove() elseif colorOption then if colorOption._gui then colorOption._gui:Destroy() end; for i, item in ipairs(main.options) do if item == colorOption then table.remove(main.options, i); break end end end end})
	management:AddButton({text = "Show Main Elements", callback = function() self:SetFolderVisible(main, true) end})
	management:AddButton({text = "Hide Main Elements", callback = function() self:SetFolderVisible(main, false) end})

	diagnostics:AddButton({text = "Check Library Methods", callback = function()
		local names = {"Init", "Close", "Notify", "OnFlagChange", "SetFlag", "GetFlag", "SetAccent", "SetKeybind", "SaveConfig", "LoadConfig", "DeleteConfig", "ListConfigs", "SetConfigFolder", "SetDPIScale", "SetNotifySide", "SetFont", "AddDialog", "CreateLoading", "Unload", "RunExample"}
		local count = 0
		for _, name in ipairs(names) do if type(self[name]) == "function" then count += 1 end end
		self:Notify("API Check", tostring(count) .. "/" .. tostring(#names) .. " methods available", 3)
	end})
	diagnostics:AddButton({text = "Test Flag Event", callback = function() self:OnFlagChange("ExampleToggle", function(v) self:Notify("Flag Changed", tostring(v), 2) end); self:SetFlag("ExampleToggle", not self:GetFlag("ExampleToggle")) end})
	diagnostics:AddButton({text = "Test Dialog", callback = function() local dialog = self:AddDialog(window, {Title = "Dialog Test", Description = "Dialog callbacks are available."}); if dialog then dialog:AddFooterButton("ok", {Text = "OK", Callback = function() dialog:Dismiss() end}) end end})

	self:SetAccent(Color3.fromRGB(255, 65, 65))
	self:SetKeybind(Enum.KeyCode.RightControl)
	self:SetNotifySide("Right")
	self:Init()
	self:Notify("RunExample", "Example initialized", 3)
	return window
end

library.Options=library.Options or {}
library.Toggles=library.Toggles or {}

return library
