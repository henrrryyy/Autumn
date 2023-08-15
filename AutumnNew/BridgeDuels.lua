local GuiLibrary = {Version = "1.0.1",CustomEdition = "",WindowCount = 0, API = {Windows = {},buttons = {}}}
local utilityToggles = {}
local entity = {gui = game.Players.LocalPlayer.PlayerGui,HumanoidRootPart=function() return game.Players.LocalPlayer.Character.PrimaryPart end}
local protectInstance = function(v) v.Name = math.random() end
local gui = Instance.new("ScreenGui",entity.gui)
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
protectInstance(gui)

local canSave = true

local ArrayFrame = Instance.new("Frame",gui)
ArrayFrame.BackgroundTransparency = 1
ArrayFrame.AnchorPoint = Vector2.new(1,0)
ArrayFrame.Position = UDim2.fromScale(1,0.1)
ArrayFrame.Size = UDim2.fromScale(0.2,1)
local arrayFrameSorter = Instance.new("UIListLayout",ArrayFrame)
arrayFrameSorter.SortOrder = Enum.SortOrder.LayoutOrder
arrayFrameSorter.HorizontalAlignment = Enum.HorizontalAlignment.Right

shared.AutumnLoaded = false

local notifyFrame = Instance.new("Frame",gui)
notifyFrame.Position = UDim2.fromScale(0.364,0)
notifyFrame.Size = UDim2.fromScale(0.272,0.47)
notifyFrame.BackgroundTransparency = 1
notifyFrame.ZIndex = 999e999

local notifySorter = Instance.new("UIListLayout",notifyFrame)
notifySorter.Padding = UDim.new(0.02,0)

function CreateNotification(text,removetime,image,barcolor)
	local alert = Instance.new("Frame",notifyFrame)
	alert.BorderSizePixel = 0
	alert.Size = UDim2.fromScale(0.75,0)
	alert.BackgroundTransparency = 0.4
	alert.BackgroundColor3 = Color3.fromRGB(0,0,0)
	alert.ZIndex = 999e999
	local image = Instance.new("ImageLabel",alert)
	image.BorderSizePixel = 0
	image.Size = UDim2.fromScale(0.125,1)
	image.Image = ("http://www.roblox.com/asset/?id=6641087361")
	image.BackgroundTransparency = 1	
	local label = Instance.new("TextLabel",alert)
	label.Size = UDim2.fromScale(0.86,0.83)
	label.Position = UDim2.fromScale(0.123,0.057)
	label.BackgroundTransparency = 1
	label.TextScaled = true
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.RichText = true
	local bar = Instance.new("Frame",alert)
	bar.BorderSizePixel = 0
	bar.Size = UDim2.fromScale(0.875,0.113)
	bar.Position = UDim2.fromScale(0.123,0.887)
	bar.BackgroundColor3 = (barcolor ~= nil and barcolor or Color3.fromRGB(0, 255, 106))

	game:GetService("TweenService"):Create(alert,TweenInfo.new(0.2),{Size = UDim2.fromScale(0.75,0.08)}):Play()
	game:GetService("TweenService"):Create(bar,TweenInfo.new(removetime),{Size = UDim2.fromScale(0,0.113)}):Play()
	task.spawn(function()
		task.wait(removetime)
		game:GetService("TweenService"):Create(alert,TweenInfo.new(0.2),{Size = UDim2.fromScale(0.75,0)}):Play()
		task.wait(0.2)
		alert:Remove()
	end)
end

local config = {
	["Buttons"] = {},
	["Toggles"] = {},
	["Pickers"] = {}
}

local configPath = "Autumn/Configs/"..game.PlaceId..".json"
makefolder("Autumn")
makefolder("Autumn/Configs")
local function saveConfig()
	if canSave then
		if isfile(configPath) then
			delfile(configPath)
		end
		writefile(configPath,game.HttpService:JSONEncode(config))
	end
end

local function loadConfig()
	config = (game.HttpService:JSONDecode(readfile(configPath)))
end

if not isfile(configPath) then
	saveConfig()
	task.wait(1)
end

loadConfig()

task.wait(1)

local arrayObjects = {}
local arraylist = function(state,module,extraText)
	if state then
		local label = Instance.new("TextLabel",ArrayFrame)
		label.BackgroundColor3 = Color3.fromRGB(0,0,0)
		label.TextColor3 = Color3.fromRGB(165, 0, 0)
		label.BackgroundTransparency = 0.6
		label.Size = UDim2.new(0,game.TextService:GetTextSize("  "..module.."  ",24,Enum.Font.SourceSans,Vector2.new(0,0)).X,0.032,0)
		label.Text = module.."  "
		label.RichText = true
		label.TextSize = 13
		label.BorderSizePixel = 0
		table.insert(arrayObjects,label)
		table.sort(arrayObjects,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
		for i,v in ipairs(arrayObjects) do
			v.LayoutOrder = i
		end
	else
		for i,v in pairs(arrayObjects) do
			if v.Text == module.."  " then
				table.remove(arrayObjects,i)
				v:Remove()
			end
		end
		table.sort(arrayObjects,function(a,b) return game.TextService:GetTextSize(a.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X > game.TextService:GetTextSize(b.Text.."  ",30,Enum.Font.SourceSans,Vector2.new(0,0)).X end)
		for i,v in ipairs(arrayObjects) do
			v.LayoutOrder = i
		end
	end
end

local AutumnTitle = Instance.new("TextLabel",gui)
AutumnTitle.AnchorPoint = Vector2.new(0.5,0.5)
AutumnTitle.RichText = true
AutumnTitle.Text = '<font color="rgb(255,0,0)">A</font>utumn '..GuiLibrary.Version
if GuiLibrary.CustomEdition ~= "" then
	AutumnTitle.Text = '<font color="rgb(255,0,0)">A</font>utumn '..GuiLibrary.Version..' ('..GuiLibrary.CustomEdition..' Edition)'
end
AutumnTitle.Size = UDim2.fromScale(0.07,0.024)
AutumnTitle.Position = UDim2.fromScale(0.05,0.05)
AutumnTitle.TextColor3 = Color3.fromRGB(255,255,255)
AutumnTitle.BackgroundTransparency = 1
AutumnTitle.TextSize = 16
AutumnTitle.TextXAlignment = Enum.TextXAlignment.Left

local notificationFrame = Instance.new("Frame",gui)
notificationFrame.Size = UDim2.fromScale()

local Notifications = {}
function GuiLibrary.CreateNotification(title,text,time)

end


function GuiLibrary.CreateWindow(name)
	local top = Instance.new("TextLabel",gui)
	GuiLibrary.WindowCount += 1
	top.Position = UDim2.fromScale(0.02 + (0.12 * GuiLibrary.WindowCount),0.07)
	top.Size = UDim2.fromScale(0.1,0.045)
	top.BackgroundColor3 = Color3.fromRGB(26,26,26)
	top.BorderSizePixel = 0
	top.TextColor3 = Color3.fromRGB(255,0,0)
	top.TextXAlignment = Enum.TextXAlignment.Left
	top.TextSize = 10
	top.Text = "  "..name
	game.UserInputService.InputBegan:Connect(function(key, gpe)
		if gpe then return end
		if key.KeyCode == Enum.KeyCode.Delete then
			top.Visible = not top.Visible
		end
	end)
	local moduleFrame = Instance.new("Frame",top)
	moduleFrame.BackgroundTransparency = 1
	moduleFrame.Size = UDim2.fromScale(1,20)
	moduleFrame.Position = UDim2.fromScale(0,1)
	local moduleSorter = Instance.new("UIListLayout",moduleFrame)
	moduleSorter.SortOrder = Enum.SortOrder.LayoutOrder
	GuiLibrary.API.buttons[name] = {}
	moduleFrame.ChildAdded:Connect(function(v) if not v:IsA("TextButton") then return end v.LayoutOrder = #moduleFrame:GetChildren() end)
	GuiLibrary.API.Windows[name] = {
		CreateButton = function(tab)
			if config.Buttons[tab["Name"]] == nil then
				config.Buttons[tab["Name"]] = {Enabled = false,Keybind = "Unknown"}
			end
			local button = Instance.new("TextButton", moduleFrame)
			button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			button.Size = UDim2.fromScale(1, 0.045)
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.TextXAlignment = Enum.TextXAlignment.Left
			button.Text = "  " .. tab["Name"]
			button.TextSize = 10
			button.BorderSizePixel = 0
			table.insert(GuiLibrary.API.buttons[name], button)

			local dropdownFrame = Instance.new("Frame", moduleFrame)
			dropdownFrame.Size = UDim2.fromScale(1, 1)
			dropdownFrame.BackgroundTransparency = 1
			dropdownFrame.Visible = false
			dropdownFrame.LayoutOrder = 900000000
			local dropdownFrameSorter = Instance.new("UIListLayout", dropdownFrame)


			local keybindButton = Instance.new("TextButton", dropdownFrame)
			keybindButton.BackgroundColor3 = Color3.fromRGB(27,27,27)
			keybindButton.Size = UDim2.fromScale(1, 0.045)
			keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			keybindButton.TextXAlignment = Enum.TextXAlignment.Left
			keybindButton.Text = "  Keybind : "
			keybindButton.TextSize = 10
			keybindButton.BorderSizePixel = 0
			local keybind = Enum.KeyCode[tostring(config.Buttons[tab["Name"]].Keybind)]

			local keybindConnection
			keybindButton.MouseButton1Down:Connect(function()
				keybindConnection = game.UserInputService.InputBegan:Connect(function(key, gpe)
					if gpe then return end
					keybindButton.Text = "  Keybind : "..tostring(key.KeyCode):split(".")[3]
					config.Buttons[tab["Name"]].Keybind = tostring(key.KeyCode):split(".")[3]
					task.wait(0.06)
					saveConfig()
					keybind = key.KeyCode
					keybindConnection:Disconnect()
				end)
			end)
			local btn
			btn = {
				Enabled = false,
				ToggleButton = function(t)
					tab["Function"](t)
					btn.Enabled = t
					button.TextColor3 = (t and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255))
					arraylist(t,tab["Name"],tab["Extratext"])
					config.Buttons[tab["Name"]].Enabled = t
					task.wait(0.005)
					saveConfig()
				end,
				CreateToggle = function(tab2)
					if config.Toggles[tab2["Name"]..tab["Name"]] == nil then
						config.Toggles[tab2["Name"]..tab["Name"]] = {Enabled = false}
					end
					local button = Instance.new("TextButton", dropdownFrame)
					button.BackgroundColor3 = Color3.fromRGB(27,27,27)
					button.Size = UDim2.fromScale(1, 0.045)
					button.TextColor3 = Color3.fromRGB(255, 255, 255)
					button.TextXAlignment = Enum.TextXAlignment.Left
					button.Text = "  " .. tab2["Name"]
					button.TextSize = 10
					button.BorderSizePixel = 0
					local state = {Enabled = false}
					button.MouseButton1Down:Connect(function()
						state.Enabled = not state.Enabled
						button.TextColor3 = (state.Enabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255))
						if tab2["Function"] then
							tab2["Function"](state.Enabled)
						end
						config.Toggles[tab2["Name"]..tab["Name"]].Enabled = state.Enabled
						task.wait(0.06)
						saveConfig()
					end)
					task.spawn(function()
						if config.Toggles[tab2["Name"]..tab["Name"]].Enabled then
							repeat task.wait() until shared.AutumnLoaded == true
							state.Enabled = true
							button.TextColor3 = (state.Enabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255))
							if tab2["Function"] then
								tab2["Function"](state.Enabled)
							end
						end
					end)
					return state
				end,
				CreatePicker = function(tab2)
					if config.Pickers[tab2["Name"]..tab["Name"]] == nil then
						config.Pickers[tab2["Name"]..tab["Name"]] = {Value = tab2["Options"][1]}
					end
					local button = Instance.new("TextButton", dropdownFrame)
					button.BackgroundColor3 = Color3.fromRGB(27,27,27)
					button.Size = UDim2.fromScale(1, 0.045)
					button.TextColor3 = Color3.fromRGB(255, 255, 255)
					button.TextXAlignment = Enum.TextXAlignment.Left
					button.Text = "  " .. tab2["Name"]..": "..tab2["Options"][1]
					button.TextSize = 10
					button.BorderSizePixel = 0
					local state = {Value = tab2["Options"][1]}
					local index = 1
					button.MouseButton1Down:Connect(function()
						index = (index + 1)
						if index > #tab2["Options"] then
							index = 1
						end
						if tab2["Function"] then
							tab2["Function"](tab2["Options"][index])
						end
						button.Text = "  " .. tab2["Name"].." : "..tab2["Options"][index]
						state.Value = tab2["Options"][index]
						config.Pickers[tab2["Name"]..tab["Name"]].Value = tab2["Options"][index]
						task.wait(0.06)
						saveConfig()
					end)
					task.spawn(function()
						repeat task.wait()
							index = (index + 1)
							if index > #tab2["Options"] then
								index = 1
							end
							if tab2["Function"] then
								tab2["Function"](tab2["Options"][index])
							end
							button.Text = "  " .. tab2["Name"].." : "..tab2["Options"][index]
							state.Value = tab2["Options"][index]
						until state.Value == config.Pickers[tab2["Name"]..tab["Name"]].Value
					end)
					return state
				end,
			}

			utilityToggles[tab["Name"]] = function(t)
				btn.ToggleButton(t)
			end

			button.MouseButton1Down:Connect(function()
				btn.ToggleButton(not btn.Enabled)
			end)

			if config.Buttons[tab["Name"]].Enabled then
				task.spawn(function()
					repeat task.wait() until shared.AutumnLoaded == true
					btn.ToggleButton(true)
				end)
			end

			game.UserInputService.InputBegan:Connect(function(key, gpe)
				if gpe or not canSave then return end
				if key.KeyCode == Enum.KeyCode.Unknown then return end
				if key.KeyCode == keybind then
					btn.ToggleButton(not btn.Enabled)
				end
			end)

			button.MouseButton2Down:Connect(function()
				dropdownFrame.Visible = not dropdownFrame.Visible
				for i, v in pairs(GuiLibrary.API.buttons[name]) do
					v.Visible = not dropdownFrame.Visible
				end
				button.Visible = true
			end)

			return btn
		end,
	}
end

GuiLibrary.CreateWindow("Combat")
GuiLibrary.CreateWindow("Player")
GuiLibrary.CreateWindow("Movement")
GuiLibrary.CreateWindow("Visuals")
GuiLibrary.CreateWindow("World")
GuiLibrary.CreateWindow("Exploit")

getlplr = function()
    return game.Players.LocalPlayer
end

local rs = game.ReplicatedStorage
local knit = rs.Packages.Knit
local Rf = knit.Services.ToolService.RF
--local Rf2 = knit.Services.ClutchService.RF

local auraconnection
Aura = GuiLibrary.API.Windows.Combat.CreateButton({
	["Name"] = "Aura",
	["Function"] = function(callback)
		if callback then
			auraconnection = game.RunService.Heartbeat:Connect(function()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if v.Name ~= getlplr().Name then
                        if v.Team == getlplr().Team then
							local args = {
								[1] = workspace:WaitForChild(v.Name),
								[2] = true,
								[3] = "WoodenSword"
							}
							Rf.AttackPlayerWithSword:InvokeServer(unpack(args))
							args = {
								[1] = workspace:WaitForChild(v.Name),
								[2] = true,
								[3] = "Sword"
							}
							Rf.AttackPlayerWithSword:InvokeServer(unpack(args))
                        end
                    end
                end
            end)
        else
            pcall(function()
                auraconnection:Disconnect()
            end)
		end
	end,
})

local blockconnection
Autoblock = GuiLibrary.API.Windows.Combat.CreateButton({
	["Name"] = "Auto Block",
	["Function"] = function(callback)
		if callback then
			blockconnection = game.RunService.Heartbeat:Connect(function()
                local args = {
                    [1] = true,
                    [2] = "WoodenSword"
                }
                Rf.ToggleBlockSword:InvokeServer(unpack(args))
            end)
        else
            pcall(function()
                blockconnection:Disconnect()
            end)
		end
	end,
})

local godmodeconnection
Autoblock = GuiLibrary.API.Windows.Exploit.CreateButton({
	["Name"] = "Godmode",
	["Function"] = function(callback)
		if callback then
			godmodeconnection = game.RunService.Heartbeat:Connect(function()
                Rf.EatGoldApple:InvokeServer()
            end)
        else
            pcall(function()
                godmodeconnection:Disconnect()
            end)
		end
	end,
})

--[[local charRf = game.Players.LocalPlayer.Character.DefaultBow.__comm__.RF
function shootbow()
	pcall(function()
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then 
				if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
					pcall(function()
						local args = {
							[1] = v.Character.PrimaryPart.Position,
							[2] = 1.44
						}
						charRf.Fire:InvokeServer(unpack(args))
					end)
				end
			end
		end
	end)
end
pcall(function()
	local bowauraenabled = false
	Bowaura = GuiLibrary.API.Windows.Combat.CreateButton({
		["Name"] = "Bow Aura",
		["Function"] = function(callback)
			if callback then
				repeat
					pcall(shootbow())
					task.wait(5)
				until (not bowauraenabled)
			else
				pcall(function()
					bowauraconnection:Disconnect()
				end)
			end
		end,
	})
end)]]

local speedconnection
Speed = GuiLibrary.API.Windows.Movement.CreateButton({
	["Name"] = "Speed",
	["Function"] = function(callback)
		if callback then
			speedconnection = game:GetService("RunService").Heartbeat:Connect(function(a)
                pcall(function()
                    local speed = 50
                    getlplr().Character.PrimaryPart.CFrame += (getlplr().Character.Humanoid.MoveDirection * (speed - 20) * a)
                end)
            end)
        else
            pcall(function()
                speedconnection:Disconnect()
            end)
		end
	end,
})

local flightenabled = false
Flight = GuiLibrary.API.Windows.Movement.CreateButton({
	["Name"] = "Flight",
	["Function"] = function(callback)
		if callback then
            flightenabled = true
            workspace.Gravity = 0
            spawn(function()
                repeat task.wait()
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        getlplr().Character.PrimaryPart.CFrame += Vector3.new(0,.3,0)
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                        getlplr().Character.PrimaryPart.CFrame += Vector3.new(0,-.3,0)
                    end
                until (not flightenabled)
            end)
        else
            flightenabled = false
            workspace.Gravity = 192.6
		end
	end,
})

--[[local kbspeedconenction
KbSpeed = GuiLibrary.API.Windows.Combat.CreateButton({
	["Name"] = "KbSpeed ",
	["Function"] = function(callback)
		if callback then
			kbspeedconenction = game.RunService.Heartbeat:Connect(function()
                Rf2.TakeKnockBack:InvokeServer()
            end)
        else
            pcall(function()
                kbspeedconenction:Disconnect()
            end)
		end
	end,
})]]


--[[CombatSection:NewButton("Bow Aura", "ffff", function()
    _G.BowAuraEnabled = not _G.BowAuraEnabled
    while _G.BowAuraEnabled do
        for i,v in pair(game.Players:GetPlayers()) do
            if (v.Character.HumanoidRootPart.Position - getplr().Character.HumanoidRootPart.Position).Magnitude < 15 then
                local args = {
                    [1] = v.Character.PrimaryPart.Position,
                    [2] = 1
                }
                getplr().Character.DefaultBow.__comm__.RF.Fire:InvokeServer(unpack(args))
            end
        end
        wait()
    end
end)

CombatSection:NewButton("Scaffold", "ffff", function()
    _G.ScaffoldEnabled = not _G.ScaffoldEnabled
    while _G.ScaffoldEnabled do
        local args = {
            [1] = game.Players.LocalPlayer.Character.PrimaryPart.Position - Vector3.new(0,3,0)
        }
        Rf.PlaceBlock:InvokeServer(unpack(args))
        wait()
    end
end)

CombatSection:NewButton("ClearAllBlockSpam", "fffff", function()
    _G.ClearAllBlockSpamEnabled = not _G.ClearAllBlockSpamEnabled
    while _G.ClearAllBlockSpamEnabled do
        Rf.ClearBlocks:InvokeServer()
        wait()
    end
end)]]
