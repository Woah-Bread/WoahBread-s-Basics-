--Key--
--asd32sdjad7Hhsabdw8asdHBfd4--

-- Key for verification
local correctKey = "asd32sdjad7Hhsabdw8asdHBfd4"

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService") -- For smooth opening of the dropdown

-- Create the ScreenGui for the key verification
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Create the main frame for key verification
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.3, 0)
frame.Position = UDim2.new(0.25, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui

-- Create a label asking for the key
local keyLabel = Instance.new("TextLabel")
keyLabel.Text = "Enter the key to continue:"
keyLabel.Size = UDim2.new(1, 0, 0.2, 0)
keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
keyLabel.BackgroundTransparency = 1
keyLabel.TextScaled = true
keyLabel.Parent = frame

-- Create the input box for the key
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0.2, 0)
keyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
keyInput.TextScaled = true
keyInput.Parent = frame

-- Create a submit button
local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.5, 0, 0.2, 0)
submitButton.Position = UDim2.new(0.25, 0, 0.6, 0)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextScaled = true
submitButton.Parent = frame

-- Function to check the entered key
local function checkKey()
    local enteredKey = keyInput.Text
    if enteredKey == correctKey then
        -- Successful entry, hide the key frame and load the rest of the GUI
        keyLabel.Text = "Access granted! Welcome!"
        submitButton.Text = "Close"
        
        -- Hide the key verification frame
        frame.Visible = false

        -- Proceed with the rest of the script (GUI setup)
        -- Now, we can initialize the rest of the GUI as you provided

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
            titleLabel.Text = "WoahBread's Basics V1.1"
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

        -- Noclip Feature (Stay active after being toggled)
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
                walkSpeed = math.floor(position / walkSpeedSlider.AbsoluteSize.X * 200)
                walkSpeedButton.Text = "WalkSpeed: " .. walkSpeed
                player.Character.Humanoid.WalkSpeed = walkSpeed
            end
        end)

        -- Teleportation Feature
        local teleportButton = Instance.new("TextButton")
        teleportButton.Parent = mainFrame
        teleportButton.Size = UDim2.new(0, 150, 0, 50)
        teleportButton.Position = UDim2.new(0.5, -75, 0, 250)
        teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        teleportButton.Text = "Teleport to Target"
        teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        teleportButton.Font = Enum.Font.SourceSans
        teleportButton.TextSize = 20

        teleportButton.MouseButton1Click:Connect(function()
            local target = workspace:FindFirstChild("Target")
            if target then
                player.Character:MoveTo(target.Position)
            end
        end)

    else
        -- Failed entry, inform the player
        keyLabel.Text = "Invalid key! Try again."
    end
end

-- Bind submit button to the checkKey function
submitButton.MouseButton1Click:Connect(checkKey)

-- Prevent any further part of the GUI from showing until the correct key is entered
screenGui.Enabled = true
