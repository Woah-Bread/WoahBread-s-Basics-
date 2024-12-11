-- LocalScript for GUI
local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

-- Main Frame (GUI Container)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Centered on screen
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.3

-- Add rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = mainFrame

-- Title Label with RGB Gradient
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0, 40) -- Full width, height of 40
titleLabel.Position = UDim2.new(0, 0, 0, 0) -- Top of the frame
titleLabel.BackgroundTransparency = 1 -- Transparent background
titleLabel.Font = Enum.Font.SourceSansBold -- Bold font
titleLabel.TextSize = 24 -- Text size
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- RGB Text Effect
local function updateTitleColor()
    local hue = tick() % 5 / 5 -- Cycle through hues
    titleLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    titleLabel.Text = "WoahBread's Basics"
end
runService.RenderStepped:Connect(updateTitleColor)

-- Draggable functionality
local dragging = false
local dragStart, startPos
local isSliderDragging = false

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not isSliderDragging then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Noclip Feature
local noclipEnabled = false
local noclipButton = Instance.new("TextButton")
noclipButton.Parent = mainFrame
noclipButton.Size = UDim2.new(0, 150, 0, 50)
noclipButton.Position = UDim2.new(0.5, -75, 0, 50)
noclipButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
noclipButton.Text = "Noclip: OFF"
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Font = Enum.Font.SourceSans
noclipButton.TextSize = 20

noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
end)

runService.Stepped:Connect(function()
    if noclipEnabled then
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- WalkSpeed Feature
local walkSpeed = 16
local walkSpeedButton = Instance.new("TextButton")
walkSpeedButton.Parent = mainFrame
walkSpeedButton.Size = UDim2.new(0, 150, 0, 50)
walkSpeedButton.Position = UDim2.new(0.5, -75, 0, 200)
walkSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedButton.Text = "WalkSpeed: 16"
walkSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedButton.Font = Enum.Font.SourceSans
walkSpeedButton.TextSize = 20

local walkSpeedSlider = Instance.new("Frame")
walkSpeedSlider.Parent = mainFrame
walkSpeedSlider.Size = UDim2.new(0, 200, 0, 10)
walkSpeedSlider.Position = UDim2.new(0.5, -100, 0, 270)
walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local walkSpeedSliderHandle = Instance.new("Frame")
walkSpeedSliderHandle.Parent = walkSpeedSlider
walkSpeedSliderHandle.Size = UDim2.new(0, 10, 1, 0)
walkSpeedSliderHandle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

walkSpeedSliderHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliderDragging = true
    end
end)

walkSpeedSliderHandle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliderDragging = false
    end
end)

userInputService.InputChanged:Connect(function(input)
    if isSliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local position = math.clamp(input.Position.X - walkSpeedSlider.AbsolutePosition.X, 0, walkSpeedSlider.AbsoluteSize.X)
        walkSpeedSliderHandle.Position = UDim2.new(0, position, 0, 0)
        walkSpeed = math.floor(position / walkSpeedSlider.AbsoluteSize.X * 84) + 16 -- Speed range: 16-100
        walkSpeedButton.Text = "WalkSpeed: " .. walkSpeed
        player.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)

-- Color Customization Feature
local colorWheelVisible = false

local dropdownButton = Instance.new("TextButton")
dropdownButton.Parent = mainFrame
dropdownButton.Size = UDim2.new(0, 150, 0, 50)
dropdownButton.Position = UDim2.new(0.5, -75, 0, 130)
dropdownButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
dropdownButton.Text = "Customize Colors"
dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownButton.Font = Enum.Font.SourceSans
dropdownButton.TextSize = 20

local colorWheelFrame = Instance.new("Frame")
colorWheelFrame.Parent = mainFrame
colorWheelFrame.Size = UDim2.new(0, 200, 0, 200)
colorWheelFrame.Position = UDim2.new(0.5, -100, 0, 190)
colorWheelFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
colorWheelFrame.Visible = false

local colorWheel = Instance.new("ImageButton")
colorWheel.Parent = colorWheelFrame
colorWheel.Size = UDim2.new(1, 0, 1, 0)
colorWheel.Image = "rbxassetid://698052001"
colorWheel.BackgroundTransparency = 1

dropdownButton.MouseButton1Click:Connect(function()
    colorWheelVisible = not colorWheelVisible
    colorWheelFrame.Visible = colorWheelVisible

    -- Change button text based on visibility
    dropdownButton.Text = colorWheelVisible and "Hide Colors" or "Customize Colors"
end)

colorWheel.MouseButton1Click:Connect(function(input)
    local mousePos = userInputService:GetMouseLocation()
    local relPos = Vector2.new(mousePos.X - colorWheel.AbsolutePosition.X, mousePos.Y - colorWheel.AbsolutePosition.Y)
    local x = math.clamp(relPos.X / colorWheel.AbsoluteSize.X, 0, 1)
    local y = math.clamp(relPos.Y / colorWheel.AbsoluteSize.Y, 0, 1)
    local color = Color3.fromHSV(x, 1 - y, 1)
    mainFrame.BackgroundColor3 = color
    dropdownButton.BackgroundColor3 = color
    noclipButton.BackgroundColor3 = color
    walkSpeedButton.BackgroundColor3 = color

end)

-- Toggle GUI visibility with Right Shift
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        -- Toggle the GUI's visibility
        screenGui.Enabled = not screenGui.Enabled
    end
end)

