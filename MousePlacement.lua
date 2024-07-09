local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local highlightColor = Color3.fromRGB(255, 255, 255)
local fillTransparency = 0.1

local function addHighlightToCharacter(character)
    if not character:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.Adornee = character
        highlight.Parent = character
        highlight.FillColor = highlightColor
        highlight.FillTransparency = fillTransparency
    end
end


local function removeHighlightFromCharacter(character)
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end


local Window = Rayfield:CreateWindow({
    Name = "MousePlacements UI",
    LoadingTitle = "Basic Aim Script",
    LoadingSubtitle = "made possible by Rayfield",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Silly Key System",
       Subtitle = "get key at .gg/invitehere",
       Note = ".gg/invitehere",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"MP112"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local AimTab = Window:CreateTab("MousePlacements Aim-Lock", 4483362458) -- Title, Image

 local Lock = AimTab:CreateButton({
    Name = "MousePlacements Lock",
    Callback = function()
        Rayfield:Notify({
            Title = "Edited script",
            Content = "Original script by Exonys",
            Duration = 6.5,
            Image = 4483362458,
            Actions = { -- Notification Buttons
               Ignore = {
                  Name = "Proceed",
                  Callback = function()
                  print("The user tapped Okay!")
               end
            },
         },
         })

         loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()()
    end,
 })

 local Toggle = AimTab:CreateToggle({
    Name = "ESP Toggle",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
     -- Function to add or remove highlight effect based on toggle value
     local function toggleHighlight(value)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    if value then
                        addHighlightToCharacter(player.Character)
                    else
                        removeHighlightFromCharacter(player.Character)
                    end
                end
                player.CharacterAdded:Connect(function(character)
                    if value then
                        addHighlightToCharacter(character)
                    else
                        removeHighlightFromCharacter(character)
                    end
                end)
            end
        end
    end

    -- Toggle highlight based on the Value
    toggleHighlight(Value)
end,
 })


 local ColorPicker = AimTab:CreateColorPicker({
    Name = "ESP Highlight Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "ColorPicker1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
      -- Update highlight color based on the ColorPicker value
      highlightColor = Value

      -- Update highlight color for all characters if the toggle is on
      for _, player in ipairs(Players:GetPlayers()) do
          if player ~= LocalPlayer then
              if player.Character then
                  local highlight = player.Character:FindFirstChild("Highlight")
                  if highlight then
                      highlight.FillColor = highlightColor
                  end
              end
          end
      end
  end,
})

local Slider = AimTab:CreateSlider({
    Name = "Highlight Fill Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "Transparency",
    CurrentValue = 10,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        -- Update fill transparency based on the Slider value
        fillTransparency = Value / 1

        -- Update fill transparency for all characters if the toggle is on
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if player.Character then
                    local highlight = player.Character:FindFirstChild("Highlight")
                    if highlight then
                        highlight.FillTransparency = fillTransparency
                    end
                end
            end
        end
    end,
 })
