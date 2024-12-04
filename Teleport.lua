-- Variables for player and mouse 
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Variable to track teleport mode across resets
local teleportMode = false

-- GUI persistence handling
local function createTeleportGUI()
    -- Check if the GUI already exists
    if player:FindFirstChild("PlayerGui"):FindFirstChild("FancyTeleportGUI") then
        return -- Don't recreate if already present
    end

    -- Create the GUI elements
    local screenGui = Instance.new("ScreenGui")
    local teleportButton = Instance.new("TextButton")
    local uiCorner = Instance.new("UICorner")
    local uiStroke = Instance.new("UIStroke")

    -- Configure the ScreenGui
    screenGui.Name = "FancyTeleportGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Configure the Teleport Button
    teleportButton.Name = "TeleportButton"
    teleportButton.Parent = screenGui
    teleportButton.Size = UDim2.new(0, 200, 0, 50)
    teleportButton.Position = UDim2.new(0.5, -100, 0.9, -50)
    teleportButton.Text = "Activate Teleport Mode"
    teleportButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.TextSize = 20

    -- Add rounded corners and stroke
    uiCorner.Parent = teleportButton
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiStroke.Parent = teleportButton
    uiStroke.Thickness = 2
    uiStroke.Color = Color3.fromRGB(0, 0, 0)
    uiStroke.Transparency = 0.3

    -- Reset teleport mode
    teleportMode = false
    teleportButton.Text = "Activate Teleport Mode"
    teleportButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)

    -- Activate/Deactivate Teleport Mode
    teleportButton.MouseButton1Click:Connect(function()
        teleportMode = not teleportMode
        if teleportMode then
            teleportButton.Text = "Teleport Mode: ON"
            teleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        else
            teleportButton.Text = "Activate Teleport Mode"
            teleportButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
        end
    end)

    -- Handle mouse clicks for teleportation
    mouse.Button1Down:Connect(function()
        if teleportMode then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local targetPosition = mouse.Hit.Position
            humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
        end
    end)
end

-- Create the GUI initially
createTeleportGUI()

-- Recreate GUI and reset teleport mode on character reset
player.CharacterAdded:Connect(function()
    wait(1)
    createTeleportGUI()
end)
