repeat task.wait() until game:IsLoaded()

local PlayerService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TextChat = game:GetService("TextChatService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Config = {}
Config.Buttons = {}
Config.Keybinds = {}
Config.Toggles = {}
Config.Pickers = {}

local CurFile = "AutumnV3/Configs/"..game.PlaceId..".json"
local canSave = true

local getgenv = getgenv() or function() return {} end
local isfile = getgenv.isfile or function(e) print(e.." failed : NIL (isfile)") end
local delfile = getgenv.delfile or function(e) print(e.." failed : NIL (delfile)") end
local readfile = getgenv.readfile or function(e) print(e.." failed : NIL (readfile)") end
local writefile = getgenv.writefile or function(e) print(e.." failed : NIL (writefile)") end
local makefolder = getgenv.makefolder or function(e) print(e.." failed : NIL (makefolder)") end

if not isfile("AutumnV3") then
	makefolder("AutumnV3")
	makefolder("AutumnV3/Configs")
	makefolder("AutumnV3/Games")
end

local saveConfig = function()
	if canSave then
		if isfile(CurFile) then
			delfile(CurFile)
		end
		writefile(CurFile, HttpService:JSONEncode(Config))
	end
end
local loadConfig = function()
	if isfile(CurFile) then
		Config = HttpService:JSONDecode(readfile(CurFile))
	end
end

loadConfig()
task.wait(0.1)

local assets = {
	["NOTIFICATION_SUCCESS"] = "rbxassetid://11419719540",
	["NOTIFICATION_INFO"] = "rbxassetid://11422155687",
	["NOTIFICATION_FAIL"] = "rbxassetid://11419709766",
	["ICON_SWORD"] = "rbxassetid://16095745392",
	["ICON_WIND"] = "rbxassetid://11422144105",
	["ICON_PAINTBRUSH"] = "rbxassetid://12967676465",
	["ICON_UTILITY"] = "rbxassetid://11432855214",
	["ICON_PLUS"] = "rbxassetid://11295291707",
	["ICON_CLIPBOARD"] = "rbxassetid://11432858485",
	["ICON_LOADING"] = "rbxassetid://12967596415",
	["ICON_VERTICALARROW"] = "rbxassetid://11422143201",
	["ICON_HORIZONTALARROW"] = "rbxassetid://11422142913",
	["ICON_BADWIFI"] = "rbxassetid://11963348339",
	["ICON_USER"] = "rbxassetid://11295273292",
	["ICON_VERIFIEDUSER"] = "rbxassetid://11422145434",
	["UTIL_GLOW"] = "http://www.roblox.com/asset/?id=7498352732",
}

local GuiLibrary = {}
GuiLibrary.Assets = assets
GuiLibrary.WindowCount = 0
GuiLibrary.Scale = 1.3

local lplr = PlayerService.LocalPlayer

local coreGui = function()
	local s, p = pcall(function()
		local temp = Instance.new("ScreenGui", CoreGui)
	end)
	if s then
		return CoreGui
	else
		return lplr.PlayerGui
	end
end

local ScreenGui = Instance.new("ScreenGui", coreGui())
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local ArrayFrame = Instance.new("Frame", ScreenGui)
ArrayFrame.Size = UDim2.fromScale(0.2, 0.6)
ArrayFrame.Position = UDim2.fromScale(0.8, 0.1)
ArrayFrame.BorderSizePixel = 0
ArrayFrame.BackgroundTransparency = 1
ArrayFrame.Visible = false
local ArrayFrameSort = Instance.new("UIListLayout", ArrayFrame)
ArrayFrameSort.SortOrder = Enum.SortOrder.LayoutOrder
ArrayFrameSort.HorizontalAlignment = Enum.HorizontalAlignment.Right

local NotificationFrame = Instance.new("Frame", ScreenGui)
NotificationFrame.Size = UDim2.fromScale(0.2, 0.35)
NotificationFrame.Position = UDim2.fromScale(0.5, 0)
NotificationFrame.BorderSizePixel = 0
NotificationFrame.BackgroundTransparency = 1
local NotificationFrameSort = Instance.new("UIListLayout", NotificationFrame)
NotificationFrameSort.SortOrder = Enum.SortOrder.LayoutOrder

ArrayListManager = {
	List = {},
	BackgroundTransparency = 0.3,
	CreateNewArray = function(Name)
		local Temp = Instance.new("TextLabel", ArrayFrame)
		Temp.BackgroundTransparency = 0.3
		Temp.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Temp.BorderSizePixel = 0
		Temp.TextColor3 = Color3.fromRGB(255,255,255)
		Temp.Text = Name
		Temp.Name = Name
		Temp.TextSize = 25
		Temp.Font = Enum.Font.SourceSans
		Temp.Size = UDim2.new(0.01, TextService:GetTextSize(Temp.Text, Temp.TextSize, Temp.Font, Vector2.new(0,0)).X,0.05,0)
		
		table.insert(ArrayListManager.List, Temp)
		table.sort(ArrayListManager.List, function(A, B)
			return TextService:GetTextSize(A.Text, A.TextSize, A.Font, Vector2.new(0,0)).X > TextService:GetTextSize(B.Text, B.TextSize, B.Font, Vector2.new(0,0)).X
		end)
		for i,v in ipairs(ArrayListManager.List) do v.LayoutOrder = i end
	end,
	DeleteOldArray = function(Name)
		if ArrayFrame:FindFirstChild(Name) then
			ArrayFrame:FindFirstChild(Name):Remove()
		end
	end,
}

task.spawn(function()
	repeat
		for _, Label in ArrayListManager.List do
			if Label:IsA("TextLabel") then
				Label.BackgroundTransparency = GuiLibrary.ArraylistManager.BackgroundTransparency
			end
		end
		task.wait()
	until false
end)

--[[function GuiLibrary:SendNotification(Title, Description, Image, Time)
	
end]]
GuiLibrary.ArraylistManager = ArrayListManager
function GuiLibrary:CreateWindow(Name)
	local top = Instance.new("TextLabel", ScreenGui)
	top.Size = UDim2.fromScale(0.1 * GuiLibrary.Scale, 0.038 * GuiLibrary.Scale)
	top.Position = UDim2.fromScale(0.1 + (0.12 * GuiLibrary.WindowCount * GuiLibrary.Scale - 0.08), 0.2)
	top.BorderSizePixel = 0
	top.BackgroundColor3 = Color3.fromRGB(20,20,20)
	top.Text = "  "..Name
	top.TextColor3 = Color3.fromRGB(255,0,0)
	top.TextXAlignment = Enum.TextXAlignment.Left
	top.TextSize = 10
	
	local moduleFrame = Instance.new("Frame", top)
	moduleFrame.Size = UDim2.fromScale(1,20)
	moduleFrame.Position = UDim2.fromScale(0,1)
	moduleFrame.BackgroundTransparency = 1
	
	local sortModules = Instance.new("UIListLayout", moduleFrame)
	sortModules.SortOrder = Enum.SortOrder.LayoutOrder
	
	UserInputService.InputBegan:Connect(function(Key, GPE)
		if GPE then return end
		if Key.KeyCode == Enum.KeyCode.RightShift then
			top.Visible = not top.Visible
		end
	end)
	
	GuiLibrary.WindowCount += 1
	
	return {
		CreateOptionsButton = function(tab)
			local Keybind = nil
			
			if Config.Buttons[tab.Name] == nil then
				Config.Buttons[tab.Name] = {Enabled = false}
			end
			if Config.Keybinds[tab.Name] == nil then
				Config.Keybinds[tab.Name] = "nil"
			end
			
			local Button = Instance.new("TextButton", moduleFrame)
			Button.Size = UDim2.fromScale(1,0.05)
			Button.BorderSizePixel = 0
			Button.Text = "  "..tab.Name
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Button.TextColor3 = Color3.fromRGB(150, 150, 150)
			Button.TextSize = 10
			Button.BackgroundColor3 = Color3.fromRGB(25,25,25)
			Button.LayoutOrder = #moduleFrame:GetChildren() + 1
			Button.AutoButtonColor = false
			
			local dropdownFrame = Instance.new("ScrollingFrame", moduleFrame)
			dropdownFrame.LayoutOrder = #moduleFrame:GetChildren() + 1
			dropdownFrame.Visible = false
			dropdownFrame.Size = UDim2.fromScale(1,0.25)
			dropdownFrame.BorderSizePixel = 0
			dropdownFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
			dropdownFrame.ScrollBarThickness = 0
			dropdownFrame.BackgroundTransparency = 0
			local dropdownSorter = Instance.new("UIListLayout", dropdownFrame)
			
			local KeybindTXTBOX = Instance.new("TextBox", dropdownFrame)
			KeybindTXTBOX.Size = UDim2.fromScale(1,0.025)
			KeybindTXTBOX.BorderSizePixel = 0
			KeybindTXTBOX.Text = "Keybind: "..tostring(Keybind)
			KeybindTXTBOX.TextXAlignment = Enum.TextXAlignment.Left
			KeybindTXTBOX.TextColor3 = Color3.fromRGB(150, 150, 150)
			KeybindTXTBOX.TextSize = 10
			KeybindTXTBOX.BackgroundColor3 = Color3.fromRGB(35,35,35)
			
			KeybindTXTBOX.FocusLost:Connect(function()
				local temp = KeybindTXTBOX.Text:upper()
				Keybind = Enum.KeyCode[temp]
				KeybindTXTBOX.Text = "  Keybind: "..temp
				Config.Keybinds[tab.Name] = tostring(Keybind):split(".")[3]

				saveConfig()
			end)
			
			local ButtonOptions
			local oldColor = Color3.fromRGB(150,150,150)
			ButtonOptions = {
				Enabled = false,
				ToggleButton = function(state)
					ButtonOptions.Enabled = state and state or not ButtonOptions.Enabled
					if Button.TextColor3 ~= Color3.fromRGB(255,0,0) then oldColor = Button.TextColor3 end
					Button.TextColor3 = ButtonOptions.Enabled and Color3.fromRGB(255, 0, 0) or oldColor
					task.spawn(function()
						local s, p = pcall(function()
							tab.Function(ButtonOptions.Enabled)
						end)
						if not s then
							print(tab.Name .. " FAILED "..p)
						end
					end)
					
					if ButtonOptions.Enabled then ArrayListManager.CreateNewArray(tab.Name) else ArrayListManager.DeleteOldArray(tab.Name) end
					Config.Buttons[tab.Name].Enabled = ButtonOptions.Enabled
					task.delay(0.1, function() saveConfig() end)
				end,
				CreateToggleButton = function(tab2)
					if Config.Toggles[tab2.Name..tab.Name] == nil then
						Config.Toggles[tab2.Name..tab.Name] = {Enabled = false}
					end
					
					local Toggle = Instance.new("TextButton", dropdownFrame)
					Toggle.Size = UDim2.fromScale(1,0.025)
					Toggle.BorderSizePixel = 0
					Toggle.Text = "  "..tab2.Name
					Toggle.TextXAlignment = Enum.TextXAlignment.Left
					Toggle.TextColor3 = Color3.fromRGB(150, 150, 150)
					Toggle.TextSize = 10
					Toggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
					Toggle.AutoButtonColor = false

					local ToggleOptions
					ToggleOptions = {
						Enabled = false,
						ToggleButton = function(state)
							ToggleOptions.Enabled = state and state or not ToggleOptions.Enabled
							Toggle.TextColor3 = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(150, 150, 150)
							if tab2.Function then tab2.Function(state) end
							Config.Toggles[tab2.Name..tab.Name].Enabled = ButtonOptions.Enabled
							task.delay(0.1, function() saveConfig() end)
						end,
						SetVisible = function(Visibility)
							Toggle.Visible = Visibility
						end,
					}

					Toggle.MouseButton1Down:Connect(function()
						ToggleOptions.ToggleButton(not ToggleOptions.Enabled)
					end)
					
					task.delay(0.1, function()
						if Config.Toggles[tab2.Name..tab.Name].Enabled then
							ToggleOptions.ToggleButton(true)
						end
					end)
					Toggle.Visible = tab2.Visible == nil and true or tab2.Visible
					
					return ToggleOptions
				end,
				CreatePickerObject = function(tab2)
					if Config.Pickers[tab2.Name..tab.Name] == nil then
						Config.Pickers[tab2.Name..tab.Name] = {Option = tab2.Options[1]}
					end
					
					local Picker = Instance.new("TextButton", dropdownFrame)
					Picker.Size = UDim2.fromScale(1,0.025)
					Picker.BorderSizePixel = 0
					Picker.Text = "  "..tab2.Name..": "..tab2.Options[1]
					Picker.TextXAlignment = Enum.TextXAlignment.Left
					Picker.TextColor3 = Color3.fromRGB(150, 150, 150)
					Picker.TextSize = 10
					Picker.BackgroundColor3 = Color3.fromRGB(35,35,35)
					Picker.AutoButtonColor = false
					
					local Function = tab2.Function

					local index = 1

					local PickerOptions
					PickerOptions = {
						Option = tab2.Options[1],
						SwitchObjectForward = function(state)
							index = index + 1
							if (index > #tab2.Options) then index = 1 end
							PickerOptions.Option = tab2.Options[index]
							Picker.Text = "  "..tab2.Name..": "..PickerOptions.Option

							if Function then Function(PickerOptions.Option) end
							Config.Pickers[tab2.Name..tab.Name].Option = PickerOptions.Option
							task.delay(0.1, function() saveConfig() end)
						end,
						SwitchObjectBackwards = function(state)
							index = index - 1
							if (index > #tab2.Options) then index = 1 end
							PickerOptions.Option = tab2.Options[index]
							Picker.Text = "  "..tab2.Name..": "..PickerOptions.Option

							if Function then Function(PickerOptions.Option) end
							Config.Pickers[tab2.Name..tab.Name].Option = PickerOptions.Option
							task.delay(0.1, function() saveConfig() end)
						end,
						SetVisible = function(Visibility)
							Picker.Visible = Visibility
						end,
						SetOption = function(Option)
							index = 1
							PickerOptions.Option = Option
							Picker.Text = "  "..tab2.Name..": "..PickerOptions.Option
						end,
					}

					Picker.MouseButton1Down:Connect(function()
						PickerOptions.SwitchObjectForward()
					end)

					Picker.MouseButton2Down:Connect(function()
						PickerOptions.SwitchObjectBackwards()
					end)
					
					task.delay(0.1, function()
						if Config.Pickers[tab2.Name..tab.Name].Option then
							PickerOptions.SetOption(Config.Pickers[tab2.Name..tab.Name].Option)
						end
					end)
					
					Picker.Visible = tab2.Visible == nil and true or tab2.Visible
					
					return PickerOptions
				end,
				--[[CreateTextBoxInstance = function(tab2)
					return "Not Yet"
				end,]]
			}
			
			Button.MouseButton1Down:Connect(function()
				ButtonOptions.ToggleButton()
			end)
			
			Button.MouseButton2Down:Connect(function()
				dropdownFrame.Visible = not dropdownFrame.Visible
			end)
			
			Button.MouseEnter:Connect(function()
				if ButtonOptions.Enabled then
					return
				end
				Button.TextColor3 = Color3.fromRGB(255,255,255)
			end)
			
			Button.MouseLeave:Connect(function()
				if ButtonOptions.Enabled then
					return
				end
				Button.TextColor3 = Color3.fromRGB(150, 150, 150)
			end)
			
			task.delay(0.01, function()
				Keybind = Config.Keybinds[tab.Name]
				KeybindTXTBOX.Text = "  Keybind: "..tostring(Keybind:gsub("Enum.KeyCode.", ""))
				if Config.Buttons[tab.Name].Enabled then
					ButtonOptions.ToggleButton()
				end
			end)
			
			return ButtonOptions
		end,
	}
end

return GuiLibrary
