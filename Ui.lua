local VLib = {RainbowColorValue = 0, HueSelectionPosition = 0}
function zigzag(X)
	return math.acos(math.cos(X * math.pi)) / math.pi
end
counter = 0
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

coroutine.wrap(
	function()
		while wait() do
			counter = counter + 0.002
		end
	end
)()

coroutine.wrap(
	function()
		while wait() do
			VLib.RainbowColorValue = VLib.RainbowColorValue + 1 / 255
			VLib.HueSelectionPosition = VLib.HueSelectionPosition + 1

			if VLib.RainbowColorValue >= 1 then
				VLib.RainbowColorValue = 0
			end

			if VLib.HueSelectionPosition == 80 then
				VLib.HueSelectionPosition = 0
			end
		end
	end
)()

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local Library = Instance.new("ScreenGui")
Library.Name = "Library"
Library.Parent = game.CoreGui
Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local uitoggled = false
UserInputService.InputBegan:Connect(
	function(io, p)
		if io.KeyCode == Enum.KeyCode.RightControl then
			if uitoggled == false then
				Library.Enabled = false
				uitoggled = true
			else
				Library.Enabled = true
				uitoggled = false
			end
		end
	end
)

function VLib:Window(textgame)
	local FirstTab = false
	local MainFrame = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local LeftFrame = Instance.new("Frame")
	local LeftFrameCorner = Instance.new("UICorner")
	local MainTitle = Instance.new("TextLabel")
	local Circle = Instance.new("Frame")
	local CircleCorner = Instance.new("UICorner")
	local CircleName = Instance.new("TextLabel")
	local GameTitle = Instance.new("TextLabel")
	local TabHolder = Instance.new("Frame")
	local TabHoldLayout = Instance.new("UIListLayout")
	local RainbowLine = Instance.new("Frame")
	local RainbowLineCorner = Instance.new("UICorner")
	local ContainerHold = Instance.new("Folder")
	local DragFrame = Instance.new("Frame")

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = Library
	MainFrame.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
	MainFrame.Position = UDim2.new(0.340104192, 0, 0.297149122, 0)
	MainFrame.Size = UDim2.new(0, 614, 0, 395)

	MainCorner.CornerRadius = UDim.new(0, 7)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainFrame

	LeftFrame.Name = "LeftFrame"
	LeftFrame.Parent = MainFrame
	LeftFrame.BackgroundColor3 = Color3.fromRGB(32, 33, 37)
	LeftFrame.Position = UDim2.new(-0.000674468291, 0, -0.000149806539, 0)
	LeftFrame.Size = UDim2.new(0, 186, 0, 395)

	LeftFrameCorner.CornerRadius = UDim.new(0, 7)
	LeftFrameCorner.Name = "LeftFrameCorner"
	LeftFrameCorner.Parent = LeftFrame

	MainTitle.Name = "MainTitle"
	MainTitle.Parent = LeftFrame
	MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainTitle.BackgroundTransparency = 1.000
	MainTitle.Position = UDim2.new(0.324129045, 0, 0.0512162149, 0)
	MainTitle.Size = UDim2.new(0, 71, 0, 20)
	MainTitle.Font = Enum.Font.Gotham
	MainTitle.Text = MAINTTL
	MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	MainTitle.TextSize = 14.000
	MainTitle.TextXAlignment = Enum.TextXAlignment.Left

	Circle.Name = "Circle"
	Circle.Parent = LeftFrame
	Circle.BackgroundColor3 = Color3.fromRGB(118, 106, 255)
	Circle.Position = UDim2.new(0.0834304541, 0, 0.0474189818, 0)
	Circle.Size = UDim2.new(0, 38, 0, 38)

	CircleCorner.CornerRadius = UDim.new(2, 0)
	CircleCorner.Name = "CircleCorner"
	CircleCorner.Parent = Circle

	CircleName.Name = "CircleName"
	CircleName.Parent = Circle
	CircleName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CircleName.BackgroundTransparency = 1.000
	CircleName.Size = UDim2.new(0, 38, 0, 37)
	CircleName.Font = Enum.Font.Gotham
	CircleName.Text = "Ability"
	CircleName.TextColor3 = Color3.fromRGB(255, 255, 255)
	CircleName.TextSize = 16.000

	GameTitle.Name = "GameTitle"
	GameTitle.Parent = LeftFrame
	GameTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GameTitle.BackgroundTransparency = 1.000
	GameTitle.Position = UDim2.new(0.324129164, 0, 0.0892162398, 0)
	GameTitle.Size = UDim2.new(0, 71, 0, 20)
	GameTitle.Font = Enum.Font.Gotham
	GameTitle.Text = textgame
	GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	GameTitle.TextSize = 14.000
	GameTitle.TextTransparency = 0.400
	GameTitle.TextXAlignment = Enum.TextXAlignment.Left

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = LeftFrame
	TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.Position = UDim2.new(0.0806451589, 0, 0.189360261, 0)
	TabHolder.Size = UDim2.new(0, 159, 0, 309)

	TabHoldLayout.Name = "TabHoldLayout"
	TabHoldLayout.Parent = TabHolder
	TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabHoldLayout.Padding = UDim.new(0, 3)

	RainbowLine.Name = "RainbowLine"
	RainbowLine.Parent = MainFrame
	RainbowLine.BackgroundColor3 = Color3.fromRGB(118, 106, 255)
	RainbowLine.Position = UDim2.new(-0.000674468291, 0, -0.000149783576, 0)
	RainbowLine.Size = UDim2.new(0, 614, 0, 2)

	RainbowLineCorner.CornerRadius = UDim.new(0, 7)
	RainbowLineCorner.Name = "RainbowLineCorner"
	RainbowLineCorner.Parent = RainbowLine

	ContainerHold.Name = "ContainerHold"
	ContainerHold.Parent = MainFrame

	DragFrame.Name = "DragFrame"
	DragFrame.Parent = MainFrame
	DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragFrame.BackgroundTransparency = 1.000
	DragFrame.Position = UDim2.new(0.30130294, 0, 0.00253164559, 0)
	DragFrame.Size = UDim2.new(0, 428, 0, 21)
	MakeDraggable(DragFrame, MainFrame)

	coroutine.wrap(
		function()
			while wait() do
				RainbowLine.BackgroundColor3 = Color3.fromHSV(zigzag(counter), .8, 1)
				Circle.BackgroundColor3 = Color3.fromHSV(zigzag(counter), .8, 1)
			end
		end
	)()
	local Tabs = {}
	function Tabs:Tab(text)
		local Tab = Instance.new("TextButton")
		local TabCorner = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")

		Tab.Name = "Tab"
		Tab.Parent = TabHolder
		Tab.BackgroundColor3 = Color3.fromRGB(118, 106, 255)
		Tab.Size = UDim2.new(0, 159, 0, 29)
		Tab.AutoButtonColor = false
		Tab.Font = Enum.Font.SourceSans
		Tab.Text = ""
		Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
		Tab.TextSize = 14.000
		Tab.BackgroundTransparency = 1

		TabCorner.CornerRadius = UDim.new(0, 6)
		TabCorner.Name = "TabCorner"
		TabCorner.Parent = Tab

		Title.Name = "Title"
		Title.Parent = Tab
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0.0566037744, 0, 0, 0)
		Title.Size = UDim2.new(0, 150, 0, 29)
		Title.Font = Enum.Font.Gotham
		Title.Text = text
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 14.000
		Title.TextXAlignment = Enum.TextXAlignment.Left

		local Container = Instance.new("ScrollingFrame")
		local ContainerLayout = Instance.new("UIListLayout")

		Container.Name = "Container"
		Container.Parent = ContainerHold
		Container.Active = true
		Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Container.BackgroundTransparency = 1.000
		Container.BorderSizePixel = 0
		Container.Position = UDim2.new(0.322475582, 0, 0.0506329127, 0)
		Container.Size = UDim2.new(0, 411, 0, 359)
		Container.ScrollBarThickness = 3
		Container.CanvasSize = UDim2.new(0, 0, 0, 0)
		Container.Visible = false
		Container.ScrollBarImageColor3 = Color3.fromRGB(42, 44, 50)

		ContainerLayout.Name = "ContainerLayout"
		ContainerLayout.Parent = Container
		ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContainerLayout.Padding = UDim.new(0, 6)

		if FirstTab == false then
			FirstTab = true
			Tab.BackgroundTransparency = 0
			Container.Visible = true
		end
		Tab.MouseButton1Click:Connect(
			function()
				for i, v in next, ContainerHold:GetChildren() do
					if v.Name == "Container" then
						v.Visible = false
					end
				end

				for i, v in next, TabHolder:GetChildren() do
					if v.ClassName == "TextButton" then
						TweenService:Create(
							v,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 1}
						):Play()
						TweenService:Create(
							Tab,
							TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 0}
						):Play()
					end
				end
				Container.Visible = true
			end
		)
		coroutine.wrap(
			function()
				while wait() do
					Tab.BackgroundColor3 = Color3.fromHSV(zigzag(counter), .8, 1)
				end
			end
		)()
		local ContainerItems = {}
		function ContainerItems:Button(text, callback)
			local Button = Instance.new("TextButton")
			local ButtonCorner = Instance.new("UICorner")

			Button.Name = "Button"
			Button.Parent = Container
			Button.BackgroundColor3 =…
