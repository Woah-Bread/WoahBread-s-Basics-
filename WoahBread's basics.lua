-- LocalScript for GUI
local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService") -- For smooth opening of the dropdown

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

-- Main Frame (GUI Container)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Centered on screen
mainFrame.Size = UDim2.new(0, 500, 0, 500)  -- Increased size for more space
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
    titleLabel.Text = "WoahBread's LUA"
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
    
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end)

-- WalkSpeed Feature
local walkSpeed = 16
local walkSpeedButton = Instance.new("TextButton")
walkSpeedButton.Parent = mainFrame
walkSpeedButton.Size = UDim2.new(0, 150, 0, 50)
walkSpeedButton.Position = UDim2.new(0.5, -75, 0, 150)
walkSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
walkSpeedButton.Text = "WalkSpeed: 16"
walkSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedButton.Font = Enum.Font.SourceSans
walkSpeedButton.TextSize = 20

local walkSpeedSlider = Instance.new("Frame")
walkSpeedSlider.Parent = mainFrame
walkSpeedSlider.Size = UDim2.new(0, 200, 0, 10)
walkSpeedSlider.Position = UDim2.new(0.5, -100, 0, 220)
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
        walkSpeed = math.floor(position / walkSpeedSlider.AbsoluteSize.X * 50) + 16 -- Speed range: 16-66
        walkSpeedButton.Text = "WalkSpeed: " .. walkSpeed
        player.Character.Humanoid.WalkSpeed = walkSpeed
    end
end)

-- Teleport Feature
local teleportButton = Instance.new("TextButton")
teleportButton.Parent = mainFrame
teleportButton.Size = UDim2.new(0, 150, 0, 50)
teleportButton.Position = UDim2.new(0.5, -75, 0, 300) -- Positioned at the bottom of the frame
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
teleportButton.Text = "Select Player"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.SourceSans
teleportButton.TextSize = 20

-- Teleport Action Button (Separate)
local teleportActionButton = Instance.new("TextButton")
teleportActionButton.Parent = mainFrame
teleportActionButton.Size = UDim2.new(0, 150, 0, 50)
teleportActionButton.Position = UDim2.new(0.5, -75, 0, 360) -- Positioned below the "Select Player" button
teleportActionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
teleportActionButton.Text = "Teleport"
teleportActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportActionButton.Font = Enum.Font.SourceSans
teleportActionButton.TextSize = 20
teleportActionButton.Visible = false -- Initially hidden

-- Dropdown for player selection (separate from the teleport button)
local playerDropdown = Instance.new("Frame")
playerDropdown.Parent = mainFrame
playerDropdown.Size = UDim2.new(0, 150, 0, 200)
playerDropdown.Position = UDim2.new(0.5, 80, 0, 300) -- Positioned to the right of the "Select Player" button
playerDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
playerDropdown.Visible = false

local playerList = Instance.new("UIListLayout")
playerList.Parent = playerDropdown
playerList.SortOrder = Enum.SortOrder.LayoutOrder
playerList.FillDirection = Enum.FillDirection.Vertical

-- Create buttons for each player to teleport to
local selectedPlayer = nil

local function updatePlayerList()
    -- Clear existing player buttons
    for _, child in pairs(playerDropdown:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Add player buttons for each player
    for _, targetPlayer in pairs(game.Players:GetPlayers()) do
        if targetPlayer ~= player then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 40)
            playerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            playerButton.Text = targetPlayer.Name
            playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.Font = Enum.Font.SourceSans
            playerButton.TextSize = 18
            playerButton.Parent = playerDropdown
            
            playerButton.MouseButton1Click:Connect(function()
                selectedPlayer = targetPlayer
                teleportButton.Text = "Teleport to " .. selectedPlayer.Name
                -- Hide dropdown and show the teleport action button
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                local goal = {Size = UDim2.new(0, 0, 0, 200)}
                local tween = tweenService:Create(playerDropdown, tweenInfo, goal)
                tween:Play()
                tween.Completed:Connect(function()
                    playerDropdown.Visible = false
                    teleportActionButton.Visible = true
                end)
            end)
        end
    end
end

teleportButton.MouseButton1Click:Connect(function()
    -- Show the dropdown with smooth transition
    playerDropdown.Visible = true
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local goal = {Size = UDim2.new(0, 150, 0, 200)}
    local tween = tweenService:Create(playerDropdown, tweenInfo, goal)
    tween:Play()
    updatePlayerList()
end)

teleportActionButton.MouseButton1Click:Connect(function()
    if selectedPlayer then
        -- Teleport to the selected player
        player.Character:SetPrimaryPartCFrame(selectedPlayer.Character.HumanoidRootPart.CFrame)
        
        -- Reset dropdown and teleport button after teleporting
        playerDropdown.Visible = false
        teleportActionButton.Visible = false
        teleportButton.Text = "Select Player" -- Revert teleport button text
        selectedPlayer = nil -- Clear selected player
    end
end)

-- Toggle GUI visibility with Right Shift
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        -- Toggle the GUI's visibility
        screenGui.Enabled = not screenGui.Enabled
    end
end)
