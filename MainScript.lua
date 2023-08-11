if not isfile("Autumn") then
	makefolder("Autumn/Config")
end

if shared.AutumnUninject ~= nil then
	shared.AutumnUninject()
	task.wait(1)
end

local config = {Buttons = {}}
local UserInputService = game:GetService("UserInputService")

local keybinds = {}

local canSave = true

local lib = {
	GetScreenGui = function()
		local ui = Instance.new("ScreenGui")
		ui.ResetOnSpawn = false
		ui.Parent = game.Players.LocalPlayer.PlayerGui
		return ui
	end,
	Round = function(item)
		Instance.new("UICorner",item)
	end,
	GetFrame = function(scrolling, content)
		local frame = (not scrolling and Instance.new("Frame") or Instance.new("ScrollingFrame"))
		for i, v in pairs(content) do
			frame[i] = v
		end
		return frame
	end,
	GetImageLabel = function(content)
		local ImageLabel = Instance.new("ImageLabel")
		for i, v in pairs(content) do
			ImageLabel[i] = v
		end
		return ImageLabel
	end,
	GetHighlight = function(content)
		local Highlight = Instance.new("Highlight")
		for i, v in pairs(content) do
			Highlight[i] = v
		end
		return Highlight
	end,
	GetTextLabel = function(content)
		local label = Instance.new("TextLabel")
		for i, v in pairs(content) do
			if i == "BaseText" then
				label:GetPropertyChangedSignal("Text"):Connect(function()
					if label.Text:sub(tostring(v):len(),tostring(v):len()) ~= tostring(v) then
						label.Text = tostring(v).." "..label.Text
					end
				end)
				continue
			end
			label[i] = v
		end
		return label
	end,
	GetBillboardGui = function(content)
		local Billboard = Instance.new("BillboardGui")
		for i, v in pairs(content) do
			Billboard[i] = v
		end
		return Billboard
	end,
	GetTextButton = function(content)
		local Button = Instance.new("TextButton")
		for i, v in pairs(content) do
			Button[i] = v
		end
		return Button
	end,
	BindOnLeftClick = function(obj,func)
		obj.MouseButton1Down:Connect(func)
	end,
	BindOnRightClick = function(obj,func)
		obj.MouseButton2Down:Connect(func)
	end,
	BindOnHover = function(obj : TextButton,func,func2)
		obj.MouseEnter:Connect(func)
		obj.MouseLeave:Connect(func2)
	end,
	BlurImage = function(content)
		local image = Instance.new("ImageLabel")
		image.Image = "rbxassetid://13350795660"
		image.Transparency = 0.5
		for i,v in pairs(content) do
			image[i] = v
		end
		return image
	end,
	AddAutoSort = function(p)
		local i = Instance.new("UIListLayout",p)
		return i
	end,
}

local gui = lib.GetScreenGui()

local windows = {}

local startColor = Color3.fromRGB(255,0,0)

local btns = {}

local themes = {
	Red = {
		Solid = Color3.fromRGB(255,0,0),
		Change = Color3.fromRGB(136, 0, 0)
	},
	Blue = {
		Solid = Color3.fromRGB(2, 82, 255),
		Change = Color3.fromRGB(0, 55, 143)
	},
	Green = {
		Solid = Color3.fromRGB(98, 255, 0),
		Change = Color3.fromRGB(0, 121, 0)
	},
	Purple = {
		Solid = Color3.fromRGB(179, 0, 255),
		Change = Color3.fromRGB(101, 0, 121)
	},
	Yellow = {
		Solid = Color3.fromRGB(251, 255, 0),
		Change = Color3.fromRGB(146, 154, 0)
	},
	Pink = {
		Solid = Color3.fromRGB(255, 0, 255),
		Change = Color3.fromRGB(149, 0, 154)
	},
	White = {
		Solid = Color3.fromRGB(255, 255, 255),
		Change = Color3.fromRGB(154, 154, 154)
	},
	Black = {
		Solid = Color3.fromRGB(0, 0, 0),
		Change = Color3.fromRGB(154, 154, 154)
	},
	Orange = {
		Solid = Color3.fromRGB(255, 157, 0),
		Change = Color3.fromRGB(148, 91, 0)
	},
	["Lemon Lime"] = {
		Solid = Color3.fromRGB(34, 255, 0),
		Change = Color3.fromRGB(255, 238, 0)
	},
}

local currentTheme = themes[1]

local injection = tick()

local arrayObjects = {}
local buttonObjects = {}

local ArrayTweens = {}

task.spawn(function()
	local current = currentTheme
	repeat task.wait()
		pcall(function()
			if currentTheme ~= current then
				if (tick() - injection) < 5 then
					current = themes[readfile("Autumn/Config/GuiTheme.txt")]
					return
				end
				if isfile("Autumn/Config/GuiTheme.txt") then
					delfile("Autumn/Config/GuiTheme.txt")
					local theme
					for i,v in pairs(themes) do
						if v.Solid == currentTheme.Solid then
							theme = i
						end
					end
					writefile("Autumn/Config/GuiTheme.txt",theme)
				else
					local theme
					for i,v in pairs(themes) do
						if v.Solid == currentTheme.Solid then
							theme = i
						end
					end
					writefile("Autumn/Config/GuiTheme.txt",theme)
				end
			end
		end)
	until gui == nil
end)

local windowsObjects = {}

local arrayGui = lib.GetScreenGui()

local arraylistFrame = lib.GetFrame(false, {
	Position = UDim2.fromScale(0.02, 0.36),
	Size = UDim2.fromScale(0.13, 5),
	Name = "ArrayListFrame",
	Parent = arrayGui,
	Transparency = 1
})

lib.AddAutoSort(arraylistFrame)

function lib:GetRemote(name)
	local remote
	for i,v in pairs(game:GetDescendants()) do
		if v.Name == name then
			remote = v
			break
		end
	end
	return remote
end

task.spawn(function()
	local numObjects = #arrayObjects

	repeat
		task.wait()
		pcall(function()
			for i, v in ipairs(arrayObjects) do
				task.spawn(function()
					pcall(function()
						local tween = game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), { TextColor3 = (v.TextColor3 == currentTheme.Solid and currentTheme.Change or currentTheme.Solid) })
						tween:Play()
						task.wait(0.33)
						local tween = game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), { TextColor3 = (v.TextColor3 == currentTheme.Solid and currentTheme.Change or currentTheme.Solid) })
						tween:Play()
					end)
				end)
				task.wait(0.1)
			end
			task.wait(0.02)
			local currentNumObjects = #arrayObjects
			if currentNumObjects == numObjects then
				for i, v in pairs(arrayObjects) do
					for i2, v2 in pairs(arrayObjects) do
						v.TextColor3 = currentTheme.Solid
					end
				end
			else
				numObjects = currentNumObjects
			end
		end)
	until false

end)

function lib:GetWindow(window)
	return windows[window]
end

local wincount = 0
function lib:CreateWindow(name)
	local Window = lib.GetFrame(true, {
		Name = name,
		Size = UDim2.fromScale(0.1, 0.5),
		Position = UDim2.fromScale((0.03 + wincount), 0.18),
		BackgroundColor3 = Color3.fromRGB(35,35,35),
		BorderSizePixel = 0,
		Parent = gui,
		ScrollBarThickness = 0,
		Transparency = 1,
		ZIndex = 9e9
	})
	local WindowName = lib.GetTextLabel({
		Name = name.."_Name",
		Parent = gui,
		TextSize = 18,
		TextColor3 = Color3.fromRGB(255,0,0),
		Size = UDim2.fromScale(0.1, 0.04),
		Position = UDim2.fromScale((0.03 + wincount), 0.14),
		BackgroundColor3 = Color3.fromRGB(17, 17, 17),
		BorderSizePixel = 0,
		Text = "  "..name,
		Font = Enum.Font.Arial,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 9e9
	})
	task.spawn(function()
		repeat task.wait()
			pcall(function()
				if WindowName.TextColor3 ~= currentTheme.Solid then
					WindowName.TextColor3 = currentTheme.Solid
					if currentTheme == themes["Black"] then
						WindowName.TextColor3 = Color3.fromRGB(255,255,255)
					end
				end
			end)
		until false
	end)
	lib.AddAutoSort(Window)
	wincount += 0.17
	windows[name] = Window
	table.insert(windowsObjects,{Obj=Window,Type="Window"})
	table.insert(windowsObjects,{Obj=WindowName,Type="Top"})
end
task.spawn(function()
	repeat task.wait()
		pcall(function()
			table.sort(arrayObjects,function(a,b)
				return (game:GetService("TextService"):GetTextSize(a.Text, 23, Enum.Font.Arial, Vector2.new(0, 0)).X + 10) > (game:GetService("TextService"):GetTextSize(b.Text, 23, Enum.Font.Arial, Vector2.new(0, 0)).X + 10)
			end)
			for i,v in ipairs(arrayObjects) do
				v.LayoutOrder = i
			end
		end)
	until false
end)

local notifyUI = lib.GetScreenGui()
local notifyFrame = lib.GetFrame(false,{
	Parent = notifyUI,
	Position = UDim2.fromScale(0.364,0),
	Size = UDim2.fromScale(0.272,0.47),
	BackgroundTransparency = 1,
})

local notifySorter = lib.AddAutoSort(notifyFrame)
notifySorter.Padding = UDim.new(0.02)

function lib:Notify(text,removeTime,image,barColor)
	local alert = lib.GetFrame(false,{
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0.75,0),
		Parent = notifyFrame,
		BackgroundTransparency = 0.4,
		BackgroundColor3 = Color3.fromRGB(0,0,0)
	})
	local image = lib.GetImageLabel({
		BorderSizePixel = 0,
		Parent = alert,
		Size = UDim2.fromScale(0.125,1),
		Image = (image ~= nil and image or "http://www.roblox.com/asset/?id=6641087361"),
		BackgroundTransparency = 1
	})
	local label = lib.GetTextLabel({
		Parent = alert,
		Size = UDim2.fromScale(0.86,0.83),
		Position = UDim2.fromScale(0.123,0.057),
		BackgroundTransparency = 1,
		TextScaled = true,
		Text = text,
		TextColor3 = Color3.fromRGB(255,255,255),
		RichText = true
	})
	local bar = lib.GetFrame(false,{
		BorderSizePixel = 0,
		Parent = alert,
		Size = UDim2.fromScale(0.875,0.113),
		Position = UDim2.fromScale(0.123,0.887),
		BackgroundColor3 = (barColor ~= nil and barColor or Color3.fromRGB(0, 255, 106))
	})
	game:GetService("TweenService"):Create(alert,TweenInfo.new(0.2),{Size = UDim2.fromScale(0.75,0.08)}):Play()
	game:GetService("TweenService"):Create(bar,TweenInfo.new(removeTime),{Size = UDim2.fromScale(0,0.113)}):Play()
	task.spawn(function()
		task.wait(removeTime)
		game:GetService("TweenService"):Create(alert,TweenInfo.new(0.2),{Size = UDim2.fromScale(0.75,0)}):Play()
		task.wait(0.2)
		alert:Remove()
	end)
end

function lib:MakeButton(tab)
	local window = lib:GetWindow(tab["Window"])
	local btn
	local dropdownCount = 0
	config["Buttons"][tab["Name"]] = false
	if window then
		local button = lib.GetTextButton({
			Text = "  "..tab["Name"],
			Name = tab["Name"],
			Parent = window,
			TextSize = 18,
			TextColor3 = Color3.fromRGB(95, 95, 95),
			Size = UDim2.fromScale(1, 0.018),
			BackgroundColor3 = Color3.fromRGB(31, 31, 31),
			BorderSizePixel = 0,
			Font = Enum.Font.Arial,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		task.spawn(function()
			repeat task.wait()
				pcall(function()
					if button.TextColor3 ~= currentTheme.Solid and btn.Enabled then
						button.TextColor3 = currentTheme.Solid
						if currentTheme == themes["Black"] then
							button.TextColor3 = Color3.fromRGB(255,255,255)
						end
					end
				end)
			until false
		end)
		table.insert(buttonObjects,button)
		lib.AddAutoSort(button)
		local function arrayFunction(adding,m) -- m = module
			if adding then
				if m:lower():find("theme") then return end
				local currentColor = startColor
				local label = lib.GetTextLabel({
					Parent = arraylistFrame,
					Text = m.."  ",
					TextSize = 23,
					Font = Enum.Font.Arial,
					TextColor3 = startColor,
					BackgroundTransparency = 0.4,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					TextXAlignment = Enum.TextXAlignment.Right,
					Size = UDim2.fromOffset(0,30),
					BorderSizePixel = 0,
				})
				game:GetService("TweenService"):Create(label,TweenInfo.new(0.8),{Size = UDim2.fromOffset(game:GetService("TextService"):GetTextSize(m.."  ", 23, Enum.Font.Arial, Vector2.new(0, 0)).X + 10 + math.random(-0.0003,0.0003), 30)}):Play()
				table.insert(arrayObjects,label)
				arrayObjects[m] = label
			else
				local index = 0
				for i,v in pairs(arrayObjects) do
					pcall(function()
						index += 1
						if v.Text == m.."  " then
							table.remove(arrayObjects,index)
							v:Remove()
						end
					end)
					if v.Name == m.."  " then
						table.remove(arrayObjects,index)
						v:Remove()
					end
				end
			end
		end
		btn = {
			Enabled = false,
			Name = tab["Name"],
			ToggleButton = function(t)
				print(t)
				btn.Enabled = t
				arrayFunction(t,tab["Name"])
				if btn.Enabled then
					button.TextColor3 = Color3.fromRGB(255,0,0)
					button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
					tab["Function"](true)
					lib:Notify(tab["Name"].." Has Been Enabled",1)
					if not canSave then return end
					config["Buttons"][tab["Name"]] = true
					writefile("Autumn/Config/"..tab["Name"]..".txt","")
				else
					button.TextColor3 = Color3.fromRGB(95, 95, 95)
					button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
					tab["Function"](false)
					lib:Notify(tab["Name"].." Has Been Disabled",1,"http://www.roblox.com/asset/?id=5100484851",Color3.fromRGB(255,0,0))
					if not canSave then return end
					config["Buttons"][tab["Name"]] = false
					if isfile("Autumn/Config/"..tab["Name"]..".txt") then
						delfile("Autumn/Config/"..tab["Name"]..".txt")
					end
				end
			end,
		}
		btns[tab["Name"]] = {["Name"]=tab["Name"],func=btn.ToggleButton}
		lib.BindOnLeftClick(button,function()
			btn.Enabled = not btn.Enabled
			if btn.Enabled then
				button.TextColor3 = Color3.fromRGB(255,0,0)
				button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				tab["Function"](true)
				lib:Notify(tab["Name"].." Has Been Enabled",1)
				arrayFunction(true,tab["Name"])
				if not canSave then return end
				config["Buttons"][tab["Name"]] = true
				writefile("Autumn/Config/"..tab["Name"]..".txt","")
			else
				arrayFunction(false,tab["Name"])
				button.TextColor3 = Color3.fromRGB(95, 95, 95)
				button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				tab["Function"](false)
				lib:Notify(tab["Name"].." Has Been Disabled",1,"http://www.roblox.com/asset/?id=5100484851",Color3.fromRGB(255,0,0))
				if not canSave then return end
				config["Buttons"][tab["Name"]] = false
				if isfile("Autumn/Config/"..tab["Name"]..".txt") then
					delfile("Autumn/Config/"..tab["Name"]..".txt")
				end
			end
		end)
		UserInputService.InputBegan:Connect(function(key,gpe)
			if gpe then return end
			if not canSave then return end
			if key.UserInputType == Enum.UserInputType.MouseButton2 then return end
			if key.KeyCode == Enum.KeyCode.Delete then return end
			if key.KeyCode == keybinds[tab["Name"].."_keybind"] then
				btn.ToggleButton(not btn.Enabled)
			end
		end)
		local bindConnect
		lib.BindOnRightClick(button,function()
			local tempUI = lib.GetScreenGui()
			local alert = lib.GetTextLabel({
				Size = UDim2.fromScale(0.12, 0.06),
				Text = "Press Any Key...",
				TextScaled = true,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0.4, 0.05),
				Parent = tempUI
			})
			bindConnect = UserInputService.InputBegan:Connect(function(key,gpe)
				if key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.MouseButton2 or key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.A or key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.D or key.KeyCode == Enum.KeyCode.Space or gpe then return end
				tempUI:Destroy()
				if not canSave then return end
				keybinds[tab["Name"].."_keybind"] = key.KeyCode
				for i,v in pairs(keybinds) do
					pcall(function()
						if not isfile("Autumn/Config/"..i..".txt") then
							writefile("Autumn/Config/"..i..".txt",tostring(v):sub(tostring(v):len(),tostring(v):len()):upper())
						else
							delfile("Autumn/Config/"..i..".txt")
							writefile("Autumn/Config/"..i..".txt",tostring(v):sub(tostring(v):len(),tostring(v):len()):upper())
						end
					end)
				end
				pcall(function()
					bindConnect:Disconnect()
				end)
			end)
		end)
		lib.BindOnHover(button,function()
			if not btn.Enabled then
				button.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end, function()
			if not btn.Enabled then
				button.TextColor3 = Color3.fromRGB(95, 95, 95)
			end
		end)
	end
	return btn
end

local modules = {}

local windowHeight = 0.04

UserInputService.InputBegan:Connect(function(key, gpe)
	if gpe then return end
	if key.KeyCode == Enum.KeyCode.Delete then
		for i, v in pairs(windowsObjects) do
			v.Obj.Visible = not v.Obj.Visible
		end
	end
end)


lib:CreateWindow("Combat")
lib:CreateWindow("Player")
lib:CreateWindow("Movement")
lib:CreateWindow("Visuals")
lib:CreateWindow("Exploit")
lib:CreateWindow("Gui")

local lplr = game.Players.LocalPlayer

local function getInv()
	for i,v in pairs(game.ReplicatedStorage.Inventories:GetChildren()) do
		if v.Name == lplr.Name then
			for i2,v2 in pairs(v:GetChildren()) do
				if tostring(v2.Name):find("pickaxe") then
					return v
				end
			end
		end
	end
	return Instance.new("Folder")
end

local function hasItem(item)
	if getInv():FindFirstChild(item) then
		return true, 1
	end
	return false
end

local weaponMeta = {
	{"rageblade", 100},
	{"emerald_sword", 99},
	{"deathbloom", 99},
	{"glitch_void_sword", 98},
	{"sky_scythe", 98},
	{"diamond_sword", 97},
	{"iron_sword", 96},
	{"stone_sword", 95},
	{"wood_sword", 94},
	{"emerald_dao", 93},
	{"diamond_dao", 99},
	{"diamond_dagger", 99},
	{"diamond_great_hammer", 99},
	{"diamond_scythe", 99},
	{"iron_dao", 97},
	{"iron_scythe", 97},
	{"iron_dagger", 97},
	{"iron_great_hammer", 97},
	{"stone_dao", 96},
	{"stone_dagger", 96},
	{"stone_great_hammer", 96},
	{"stone_scythe", 96},
	{"wood_dao", 95},
	{"woodscythe", 95},
	{"wood_great_hammer", 95},
	{"wood_dagger", 95},
	{"frosty_hammer", 1},
}

local function getBestWeapon()
	local bestSword
	local bestSwordMeta = 0
	for i, sword in ipairs(weaponMeta) do
		local name = sword[1]
		local meta = sword[2]
		if meta > bestSwordMeta and hasItem(name) then
			bestSword = name
			bestSwordMeta = meta
		end
	end
	return getInv():FindFirstChild(bestSword)
end
local setInvItem = lib:GetRemote("SetInvItem")
local function spoofHand(item)
	if hasItem(item) then
		setInvItem:InvokeServer({
			["hand"] = getInv()[item]
		})
	end
end

local function GetNearestPlr(max)
	max = (max ~= nil and max or 9e9)
	local pos = lplr.Character.PrimaryPart.Position
	local closestDistance = math.huge
	local closestPlayer = nil
	for i,v in pairs(game.Players:GetPlayers()) do
		if v ~= lplr and not v:FindFirstChildOfClass("ForceField") and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (v.Character.HumanoidRootPart.Position - pos).Magnitude
			if distance < closestDistance and distance < max and v.Character.Humanoid.Health > 0.1 and v.Team ~= lplr.Team then
				closestDistance = distance
				closestPlayer = v
			end
		end
	end
	return closestPlayer
end

local knitRecieved, knit
knitRecieved, knit = pcall(function()
	repeat task.wait()
		return debug.getupvalue(require(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerScripts.TS.knit).setup, 6)
	until knitRecieved
end)

local events = {
	Client = require(game.ReplicatedStorage.TS.remotes).default.Client,
	HangGliderController = knit.Controllers["HangGliderController"],
	SprintController = knit.Controllers["SprintController"],
	JadeHammerController = knit.Controllers["JadeHammerController"],
	PictureModeController = knit.Controllers["PictureModeController"],
	SwordController = knit.Controllers["SwordController"],
	GroundHit = game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.GroundHit,
	Reach = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]),
	Knockback = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),  -- this took me forever for to figure out :(
	report = knit.Controllers["report-controller"],
	PlacementCPS = require(game.ReplicatedStorage.TS["shared-constants"]).CpsConstants,
	SwordHit = lib:GetRemote("SwordHit"),
}

local ProjectileFire = lib:GetRemote("ProjectileFire")

function lib:GetItem(item)
	return getInv():FindFirstChild(item)
end

local TweenService = game:GetService("TweenService")

local animrunning = false
local anim = {
	val1 = CFrame.new(0.69, -0.7, 0.1) * CFrame.Angles(math.rad(-65), math.rad(55), math.rad(-51)),
	val2 = CFrame.new(0.16, -1.16, 0.5) * CFrame.Angles(math.rad(-179), math.rad(54), math.rad(33))
}
local viewmodel = workspace.Camera.Viewmodel.RightHand.RightWrist
local weld = viewmodel.C0
local oldweld = viewmodel.C0
local function CFrameAnimate(cframe,time)
	for i,v in pairs(cframe) do
		local tween = TweenService:Create(viewmodel,TweenInfo.new(time),{C0 = oldweld * v})
		tween:Play()
		tween.Completed:Wait()
	end
end
local function CFrameAnimate2()
	TweenService:Create(viewmodel,TweenInfo.new(0.3),{C0 = oldweld}):Play()
end
local aurabeat
local HammerCharge = 0.1
local lastHit = tick()

local function getPartialA(pos)
	local p = RaycastParams.new()
	p.FilterType = Enum.RaycastFilterType.Exclude
	p.FilterDescendantsInstances = {lplr.Character,workspace.Viewmodel}
	return workspace:Raycast(lplr.Character.PrimaryPart.Position,(lplr.Character.PrimaryPart.Position - pos).Unit * 3,p)
end
local tpTick = tick()
local targetHud = lib.GetScreenGui()
modules.Aura = lib:MakeButton({
	["Name"] = "Aura",
	["Window"] = "Combat",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				aurabeat = game["Run Service"].Heartbeat:Connect(function()
					if (tick() - lastHit) < 0.0197 then return end
					pcall(function()
						local entity = GetNearestPlr(18)
						local inMaxRange = GetNearestPlr(21)
						if entity == nil then return end
						HammerCharge = (tick() - lastHit) > 0.4 and 1 or (tick() - lastHit) / 2
						lastHit = tick()
						spoofHand(getBestWeapon().Name)
						if modules.Rotations.Enabled then
							lplr.Character.PrimaryPart.CFrame = CFrame.lookAt(lplr.Character.PrimaryPart.Position,Vector3.new(entity.Character.PrimaryPart.Position.X,lplr.Character.PrimaryPart.Position.Y,entity.Character.PrimaryPart.Position.Z))
						end
						events.SwordHit:FireServer({
							["chargedAttack"] = {
								["chargeRatio"] = (getBestWeapon().Name:lower():find("hammer") and HammerCharge or 0.8)
							},
							["entityInstance"] = entity.Character,
							["validate"] = {
								["targetPosition"] = {
									["value"] = entity.Character.PrimaryPart.Position
								},
								["selfPosition"] = {
									["value"] = lplr.Character.PrimaryPart.Position
								}
							},
							["weapon"] = getBestWeapon()
						})
						task.spawn(function()
							if not animrunning then
								animrunning = true
								local animtime = 0.15
								CFrameAnimate(anim,animtime)
								task.wait(animtime * #anim + 0.01)
								animrunning = false
								CFrameAnimate2()
							end
						end)
					end)
				end)
			end)
		else
			aurabeat:Disconnect()
		end
	end,
})

modules.Sprint = lib:MakeButton({
	["Name"] = "Sprint",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						if not modules.Sprint.Enabled then return end
						if lplr.Character == nil then return end
						if not events.SprintController.sprinting then
							events.SprintController:startSprinting()
						end
					end)
				until not modules.Sprint.Enabled
			end)
		else
			pcall(function()
				events.SprintController:stopSprinting()
			end)
		end
	end,
})

modules.Step = lib:MakeButton({
	["Name"] = "Step",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						if not modules.Step.Enabled then return end
						local p = RaycastParams.new()
						p.FilterType = Enum.RaycastFilterType.Exclude
						p.FilterDescendantsInstances = {lplr.Character,workspace.CurrentCamera}
						local collide = workspace:Raycast(lplr.Character.PrimaryPart.Position - Vector3.new(0,2,0), lplr.Character.PrimaryPart.CFrame.LookVector * 1, p)
						if collide then
							local primaryPart = lplr.Character.PrimaryPart
							if primaryPart and UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D) then
								primaryPart.Velocity = Vector3.new(0,0,0)
								primaryPart.CFrame += Vector3.new(0,0.4,0)
							end
						end
					end)
				until not modules.Step.Enabled
			end)
		end
	end,
})
local PhaseDebounce = false
modules.Phase = lib:MakeButton({
	["Name"] = "Phase",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						local p = RaycastParams.new()
						p.FilterType = Enum.RaycastFilterType.Exclude
						p.FilterDescendantsInstances = {lplr.Character,workspace.CurrentCamera}
						local collide = workspace:Raycast(lplr.Character.PrimaryPart.Position - Vector3.new(0,2,0), lplr.Character.PrimaryPart.CFrame.LookVector * 1, p)
						if collide then
							local primaryPart = lplr.Character.PrimaryPart
							if primaryPart and UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D) then
								if PhaseDebounce or not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then return end
								lplr.Character.PrimaryPart.CFrame += lplr.Character.PrimaryPart.CFrame.LookVector * 3
								PhaseDebounce = true
								task.wait(1)
								PhaseDebounce = false
							end
						end
					end)
				until not modules.Phase.Enabled
			end)
		end
	end,
})
local themeBTNS = {}
for i,v in pairs(themes) do
	modules[tostring(i)] = lib:MakeButton({
		["Name"] = tostring(i).." Theme",
		["Window"] = "Gui",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					currentTheme = themes[tostring(i)]
				end)
				modules[tostring(i)].ToggleButton(false)
			end
		end,
	})
	table.insert(themeBTNS, modules[tostring(i)])
end
local netmanaged = game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged
local SmallItemsConnection

local viewModelController = lib:GetRemote("viewmodel-controller")

modules.SmallItems = lib:MakeButton({
	["Name"] = "SmallItems",
	["Window"] = "Visuals",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				SmallItemsConnection = workspace.CurrentCamera.Viewmodel.ChildAdded:Connect(function(child)
					if child:IsA("Accessory") then
						task.spawn(function()
							repeat task.wait() until child:FindFirstChild("Handle")
							for i,v in pairs(child:GetChildren()) do
								v.Size /= 3.5
							end
						end)
					end
				end)
			end)
		else
			pcall(function()
				SmallItemsConnection:Disconnect()
			end)
		end
	end,
})

modules.Rotations = lib:MakeButton({
	["Name"] = "Rotations",
	["Window"] = "Visuals",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()

			end)
		end
	end,
})

local function placeBlock(pos,block)
	local blockenginemanaged = game.ReplicatedStorage.rbxts_include.node_modules:WaitForChild("@easy-games"):WaitForChild("block-engine").node_modules:WaitForChild("@rbxts").net.out:WaitForChild("_NetManaged")
	local args = { [1] = { ['blockType'] = block, ['position'] = Vector3.new(pos.X / 3,pos.Y / 3,pos.Z / 3), ['blockData'] = 0 } }
	blockenginemanaged.PlaceBlock:InvokeServer(unpack(args))
end

modules.DamageLongjump = lib:MakeButton({
	["Name"] = "DamageLongjump",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				if hasItem("fireball") then
					local pos = lplr.Character.PrimaryPart.Position
					spoofHand("fireball")
					local data = {
						[1] = lib:GetItem("fireball"),
						[2] = "fireball",
						[3] = "fireball",
						[4] = pos,
						[5] = pos - Vector3.new(0,2,0),
						[6] = Vector3.new(0,-5,0),
						[7] = tostring(game:GetService("HttpService"):GenerateGUID(true)),
						[8] = {
							["drawDurationSeconds"] = 1,
							["shotId"] = tostring(game:GetService("HttpService"):GenerateGUID(false))
						},
						[9] = workspace:GetServerTimeNow() - 0.045
					}
					ProjectileFire:InvokeServer(unpack(data))
					lplr.Character.PrimaryPart.Anchored = true
					task.wait(0.4)
					lplr.Character.PrimaryPart.Anchored = false
					for i = 1, 70 do task.wait()
						if not modules.DamageLongjump.Enabled then return end
						lplr.Character.PrimaryPart.CFrame += lplr.Character.PrimaryPart.CFrame.LookVector * 1.5
						lplr.Character.PrimaryPart.Velocity = Vector3.new(0,.6,0)
					end
					modules.DamageLongjump.ToggleButton(false)
					return
				end
				if hasItem("tnt") or hasItem("TNT") or hasItem("Tnt") then
					placeBlock(lplr.Character.PrimaryPart.Position - Vector3.new(0,2,0),"Tnt")
					placeBlock(lplr.Character.PrimaryPart.Position - Vector3.new(0,2,0),"TNT")
					placeBlock(lplr.Character.PrimaryPart.Position - Vector3.new(0,2,0),"tnt")
					local oldHP = lplr.Character.Humanoid.Health
					lplr.Character.PrimaryPart.Anchored = true
					local old = lplr.Character.PrimaryPart.CFrame
					task.spawn(function()
						for i = 1,30 do task.wait(0.1) do
								lplr.Character.PrimaryPart.CFrame = old
							end
						end
					end)
					task.wait(3.088)
					lplr.Character.PrimaryPart.Anchored = false
					for i = 1, 160 do task.wait()
						if not modules.DamageLongjump.Enabled then return end
						lplr.Character.PrimaryPart.CFrame += lplr.Character.PrimaryPart.CFrame.LookVector * 0.725
						lplr.Character.PrimaryPart.Velocity = Vector3.new(0,0,0)
					end
					if modules.DamageLongjump.Enabled then
						modules.DamageLongjump.ToggleButton(false)
					end
				else
					modules.DamageLongjump.ToggleButton(false)
				end
			end)
		end
	end,
})

local function getBestBow()
	for i,v in pairs(getInv():GetChildren()) do
		if v.Name:lower():find("tac") then
			return v
		end
		if v.Name:lower():find("cross") then
			return v
		end
		if v.Name:lower():find("bow") then
			return v
		end
	end
end

modules.NoFallDamage = lib:MakeButton({
	["Name"] = "NoFallDamage",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.2)
					events["GroundHit"]:FireServer()
				until not modules.NoFallDamage.Enabled
			end)
		end
	end,
})

modules.TexturePack = lib:MakeButton({
	["Name"] = "TexturePack",
	["Window"] = "Visuals",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				lib:Notify("Pack + renderer by snoopy",10)
				local Players = game:GetService("Players")
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local Workspace = game:GetService("Workspace")
				local objs = game:GetObjects("rbxassetid://14033898270")
				local import = objs[1]
				import.Parent = ReplicatedStorage
				local index = {
					{
						name = "wood_sword",
						offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
						model = import:WaitForChild("Wood_Sword"),
					},	
					{
						name = "stone_sword",
						offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
						model = import:WaitForChild("Stone_Sword"),
					},
					{
						name = "iron_sword",
						offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
						model = import:WaitForChild("Iron_Sword"),
					},
					{
						name = "diamond_sword",
						offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
						model = import:WaitForChild("Diamond_Sword"),
					},
					{
						name = "emerald_sword",
						offset = CFrame.Angles(math.rad(0), math.rad(-100), math.rad(-90)),
						model = import:WaitForChild("Emerald_Sword"),
					},
					{
						name = "wood_pickaxe",
						offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
						model = import:WaitForChild("Wood_Pickaxe"),
					},
					{
						name = "stone_pickaxe",
						offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
						model = import:WaitForChild("Stone_Pickaxe"),
					},
					{
						name = "iron_pickaxe",
						offset = CFrame.Angles(math.rad(0), math.rad(-190), math.rad(-95)),
						model = import:WaitForChild("Iron_Pickaxe"),
					},
					{
						name = "diamond_pickaxe",
						offset = CFrame.Angles(math.rad(0), math.rad(80), math.rad(-95)),
						model = import:WaitForChild("Diamond_Pickaxe"),
					},	
					{
						name = "wood_axe",
						offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
						model = import:WaitForChild("Wood_Axe"),
					},	
					{
						name = "stone_axe",
						offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
						model = import:WaitForChild("Stone_Axe"),
					},	
					{
						name = "iron_axe",
						offset = CFrame.Angles(math.rad(0), math.rad(-10), math.rad(-95)),
						model = import:WaitForChild("Iron_Axe"),
					},	
					{
						name = "diamond_axe",
						offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(-95)),
						model = import:WaitForChild("Diamond_Axe"),
					},	
					{
						name = "fireball",
						offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90)),
						model = import:WaitForChild("Fireball"),
					},	
					{
						name = "telepearl",
						offset = CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90)),
						model = import:WaitForChild("Telepearl"),
					},
				}
				local func = Workspace.Camera.Viewmodel.ChildAdded:Connect(function(tool)	
					if not tool:IsA("Accessory") then return end	
					for _, v in ipairs(index) do	
						if v.name == tool.Name then		
							for _, part in ipairs(tool:GetDescendants()) do
								if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation") then				
									part.Transparency = 1
								end			
							end		
							local model = v.model:Clone()
							model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
							model.CFrame *= CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0))
							model.Parent = tool			
							local weld = Instance.new("WeldConstraint", model)
							weld.Part0 = model
							weld.Part1 = tool:WaitForChild("Handle")			
							local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)			
							for _, part in ipairs(tool2:GetDescendants()) do
								if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation") then				
									part.Transparency = 1				
								end			
							end			
							local model2 = v.model:Clone()
							model2.Anchored = false
							model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
							model2.CFrame *= CFrame.Angles(math.rad(0), math.rad(-50), math.rad(0))
							if v.name:match("sword") or v.name:match("blade") then
								model2.CFrame *= CFrame.new(.5, 0, -1.1) - Vector3.new(0, 0, -.3)
							elseif v.name:match("axe") and not v.name:match("pickaxe") and v.name:match("diamond") then
								model2.CFrame *= CFrame.new(.08, 0, -1.1) - Vector3.new(0, 0, -.9)
							elseif v.name:match("axe") and not v.name:match("pickaxe") and not v.name:match("diamond") then
								model2.CFrame *= CFrame.new(-.2, 0, -2.4) + Vector3.new(0, 0, 2.12)
							else
								model2.CFrame *= CFrame.new(.2, 0, -.09)
							end
							model2.Parent = tool2
							local weld2 = Instance.new("WeldConstraint", model)
							weld2.Part0 = model2
							weld2.Part1 = tool2:WaitForChild("Handle")
						end
					end
				end)
			end)
		else
			pcall(function()
				func:Disconnect()
			end)
		end
	end,
})



local consumeRemote = lib:GetRemote("ConsumeItem")
modules.AutoConsume = lib:MakeButton({
	["Name"] = "AutoConsume",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					if hasItem("speed_potion") then
						consumeRemote:InvokeServer({
							["item"] = lib:GetItem("speed_potion")
						})
					end
					if hasItem("pie") then
						consumeRemote:InvokeServer({
							["item"] = lib:GetItem("pie")
						})
					end
				until not modules.AutoConsume.Enabled
			end)
		end
	end,
})

modules.NoSlowDown = lib:MakeButton({
	["Name"] = "NoSlowDown",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						lplr.Character.Humanoid.WalkSpeed = ((modules.Sprint.Enabled or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) and 20 or 16)
					end)
				until not modules.NoSlowDown.Enabled
			end)
		end
	end,
})

local function isMoving()
	return (UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.D))
end

local speedBind
modules.Speed = lib:MakeButton({
	["Name"] = "Speed",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			local lastSpeed = lplr.Character.Humanoid.WalkSpeed
			task.spawn(function()
				speedBind = game:GetService("RunService").Heartbeat:Connect(function(a)
					pcall(function()
						local speed = lplr.Character:GetAttribute("SpeedBoost") and 34 or 22.8
						lplr.Character.PrimaryPart.CFrame += (lplr.Character.Humanoid.MoveDirection * (speed - 20) * a)
					end)
				end)
			end)
		else
			pcall(function()
				speedBind:Disconnect()
			end)
		end
	end,
})

local statsUI = lib.GetScreenGui()

local statsFrame = lib.GetFrame(false,{
	Parent = statsUI,
	Size = UDim2.fromScale(0.1,0.2),
	Position = UDim2.fromScale(0.9,0.8),
	BackgroundTransparency = 1,
})

lib.AddAutoSort(statsFrame)

local statsObjects = {}

task.spawn(function()
	repeat task.wait()
		pcall(function()
			for i,v in pairs(statsObjects) do
				if currentTheme.Solid ~= nil then
					v.TextColor3 = (currentTheme ~= themes["Black"] and currentTheme.Solid or Color3.fromRGB(255,255,255))
				else
					v.TextColor3 = (themes["Red"].Solid)
				end
			end
		end)
	until false
end)

modules.Stats = lib:MakeButton({
	["Name"] = "Stats",
	["Window"] = "Visuals",
	["Function"] = function(callback)
		if callback then
			local X = lib.GetTextLabel({
				Parent = statsFrame,
				Size = UDim2.fromScale(1,0.11),
				BackgroundTransparency = 1,
				TextScaled = true,
			})
			local Y = lib.GetTextLabel({
				Parent = statsFrame,
				Size = UDim2.fromScale(1,0.11),
				BackgroundTransparency = 1,
				TextScaled = true,
			})
			local Z = lib.GetTextLabel({
				Parent = statsFrame,
				Size = UDim2.fromScale(1,0.11),
				BackgroundTransparency = 1,
				TextScaled = true,
			})
			local sps = lib.GetTextLabel({
				Parent = statsFrame,
				Size = UDim2.fromScale(1,0.11),
				BackgroundTransparency = 1,
				TextScaled = true,
			})
			table.insert(statsObjects,X)
			table.insert(statsObjects,Y)
			table.insert(statsObjects,Z)
			table.insert(statsObjects,sps)
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						sps.Text = "Sps : "..tostring(lplr.Character.PrimaryPart.Velocity.Magnitude):sub(0,4)
						X.Text = "X : "..tostring(lplr.Character.PrimaryPart.Position.X):sub(0,6)
						Y.Text = "Y : "..tostring(lplr.Character.PrimaryPart.Position.Y):sub(0,6)
						Z.Text = "Z : "..tostring(lplr.Character.PrimaryPart.Position.Z):sub(0,6)
					end)
				until not modules.Stats.Enabled
			end)
		else
			pcall(function()
				for i,v in pairs(statsObjects) do
					pcall(function()
						v:Remove()
					end)	
				end
			end)
		end
	end,
})

modules.Highjump = lib:MakeButton({
	["Name"] = "Highjump",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait(0.1)
					local i = 0
					lplr.Character.PrimaryPart.Velocity += Vector3.new(0,80 + (i < 400 and i or 400),0)
				until not modules.Highjump.Enabled
			end)
		end
	end,
})

local cameraSpoofPart
modules.BetterFly = lib:MakeButton({
	["Name"] = "BetterFly",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				local camera = Instance.new("Part",workspace)
				camera.Transparency = 1
				camera.CanCollide = false
				camera.CFrame = lplr.Character.Head.CFrame
				camera.Anchored = true
				cameraSpoofPart = camera
				workspace.CurrentCamera.CameraSubject = camera
				lplr.Character.PrimaryPart.CFrame += Vector3.new(0,25000,0)
				task.wait(0.2)
				repeat task.wait()
					if not modules.BetterFly.Enabled then return end
					if lplr.Character.PrimaryPart.Position.Y <= 5000 then
						lplr.Character.PrimaryPart.CFrame += Vector3.new(0,20000,0)
					end
					camera.CFrame = CFrame.new(lplr.Character.PrimaryPart.Position.X,camera.Position.Y,lplr.Character.PrimaryPart.Position.Z)
				until not modules.BetterFly.Enabled
			end)
		else
			task.spawn(function()
				for i = 1,3 do task.wait()
					lplr.Character.PrimaryPart.CFrame = cameraSpoofPart.CFrame + Vector3.new(0,1,0)
					lplr.Character.PrimaryPart.Velocity = Vector3.new(0,0,0)
				end
				repeat task.wait() until lplr.Character.Humanoid.FloorMaterial ~= Enum.Material.Air
				lplr.Character.PrimaryPart.Velocity = Vector3.new(0,2,0)
				workspace.CurrentCamera.CameraSubject = lplr.Character
				pcall(function()
					cameraSpoofPart:Remove()
				end)
			end)
		end
	end,
})

local chamsAdded = {}
local chams = {}
modules.Chams = lib:MakeButton({
	["Name"] = "Chams",
	["Window"] = "Visuals",
	["Function"] = function(callback)
		if callback then
			for i,v in pairs(game.Players:GetPlayers()) do
				chamsAdded[v.Name] = v.CharacterAdded:Connect(function(char)
					if not v.Character:FindFirstChild("Chams") then
						local cham = lib.GetHighlight({
							Parent = char,
							Name = "Chams",
							DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
							FillTransparency = 0.5,
							FillColor = currentTheme.Solid,
							OutlineColor = currentTheme.Change
						})
						table.insert(chams,cham)
					end
					chamsAdded[v.Name.."_2"] = char.Humanoid:GetPropertyChangedState("Health"):Connect(function()
						pcall(function()
							char.Chams:Remove()
						end)
						local cham = lib.GetHighlight({
							Parent = char,
							Name = "Chams",
							DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
							FillTransparency = 0.5,
							FillColor = currentTheme.Solid,
							OutlineColor = currentTheme.Change
						})
						table.insert(chams,cham)
					end)
				end)
			end
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						for i,v in pairs(game.Players:GetPlayers()) do
							if not v.Character:FindFirstChild("Chams") then
								local cham = lib.GetHighlight({
									Parent = v.Character,
									Name = "Chams",
									DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
									FillTransparency = 0.5,
									FillColor = currentTheme.Solid,
									OutlineColor = currentTheme.Change
								})
								table.insert(chams,cham)
							end
						end
					end)
				until not modules.Chams.Enabled
			end)
		else
			for i,v in pairs(chamsAdded) do
				v:Disconnect()
			end
			table.clear(chamsAdded)
			task.wait(1)
			for i,v in pairs(chams) do
				pcall(function()
					v:Remove()
				end)
				table.remove(chams,i)
			end
		end
	end,
})
local InfiniteJumpConnection
modules.InfiniteJump = lib:MakeButton({
	["Name"] = "InfiniteJump",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			InfiniteJumpConnection = UserInputService.InputBegan:Connect(function(key,gpe)
				if gpe or key.KeyCode ~= Enum.KeyCode.Space or modules.BetterFly.Enabled then return end
				pcall(function()
					lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end)
			end)
		else
			pcall(function()
				InfiniteJumpConnection:Disconnect()
			end)
		end
	end,
})

modules.Velocity = lib:MakeButton({
	["Name"] = "Velocity",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			events.Knockback.kbUpwardStrength = 0
			events.Knockback.kbDirectionStrength = 0
		else
			events.Knockback.kbUpwardStrength = 11000
			events.Knockback.kbDirectionStrength = 11000
		end
	end,
})
modules.Fly = lib:MakeButton({
	["Name"] = "Fly",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					lplr.Character.PrimaryPart.Velocity = Vector3.new(lplr.Character.PrimaryPart.Velocity.X,2,lplr.Character.PrimaryPart.Velocity.Z)
					if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
						lplr.Character.PrimaryPart.Velocity = Vector3.new(lplr.Character.PrimaryPart.Velocity.X,75,lplr.Character.PrimaryPart.Velocity.Z)
					end
					if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
						lplr.Character.PrimaryPart.Velocity = Vector3.new(lplr.Character.PrimaryPart.Velocity.X,-75,lplr.Character.PrimaryPart.Velocity.Z)
					end
				until not modules.Fly.Enabled
			end)
		end
	end,
})

function lib:Uninject()
	canSave = false
	task.wait(1)
	for i,v in pairs(modules) do
		if not v.Enabled then continue end
		v.ToggleButton(false)
	end
	for i,v in pairs(windowsObjects) do
		v.Obj:Remove()
	end
	arrayGui:Destroy()
	shared.AutumnUninject = nil
end

shared.AutumnUninject = function() lib:Uninject() end

modules.Uninject = lib:MakeButton({
	["Name"] = "Uninject",
	["Window"] = "Exploit",
	["Function"] = function(callback)
		if callback then
			lib:Uninject()
		end
	end,
})

local function getPick()
	for i,v in pairs(getInv():GetChildren()) do
		if v.Name:lower():find("pickaxe") then
			return v
		end
	end
end
local function breakBlock(v)
	local args = {
		[1] = {
			["blockRef"] = {
				["blockPosition"] = Vector3.new(v.Position.X / 3, v.Position.Y / 3, v.Position.Z / 3)
			},
			["hitPosition"] = v.Position,
			["hitNormal"] = Vector3.new(-1, 0, 0)
		}
	}

	game.ReplicatedStorage.rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock:InvokeServer(unpack(args))
end
local function getBeds()
	local beds = {}
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name == "bed" then
			table.insert(beds,v)
		end
	end
	return beds
end
local beds = getBeds()
modules.BedNuker = lib:MakeButton({
	["Name"] = "BedNuker",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				repeat task.wait()
					pcall(function()
						for i, v in pairs(beds) do
							if (v.Position - lplr.Character.PrimaryPart.Position).Magnitude <= 30 then
								local origin = lplr.Character.PrimaryPart.Position
								local p = RaycastParams.new()
								p.FilterType = Enum.RaycastFilterType.Exclude
								p.FilterDescendantsInstances = {lplr.Character,workspace.CurrentCamera}
								local ray = workspace:Raycast(origin,(origin - v.Position).Unit * 30,p)
								if ray then
									if ray.Instance.Name ~= "bed" then
										local i = Instance.new("Frame",ray.Instance)
										local itemExist = true
										repeat task.wait()
											local tempFound = false
											for i,v in pairs(workspace:GetChildren()) do
												if v:FindFirstChild("Frame") then
													tempFound = true
												end
											end
											if not tempFound then
												itemExist = false
											end
										until not itemExist
									end
								end
								breakBlock(v)
								for i2,v2 in pairs(v:GetDescendants()) do
									pcall(function()
										task.spawn(function()
											pcall(function()
												local highlight = lib.GetHighlight({
													Parent = v2,
													DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
													FillTransparency = 0,
													OutlineTransparency = 1,
													FillColor = Color3.fromRGB(255, 0, 0),
													Name = "Highlight"
												})
												task.wait(0.3)
												highlight:Remove()
											end)
										end)
									end)
								end
							end
						end
					end)
				until not modules.BedNuker.Enabled
			end)
		end
	end,
})

local function getWool()
	for i,v in pairs(getInv():GetChildren()) do
		if v.Name:lower():find("wool") then
			return v.Name
		end
	end
end


local scaffoldRun
modules.Scaffold = lib:MakeButton({
	["Name"] = "Scaffold",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				scaffoldRun = game["Run Service"].Heartbeat:Connect(function()
					if getWool() ~= nil then
						local block = getWool()
						if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
							lplr.Character.PrimaryPart.Velocity = Vector3.new(0,24,0)
							placeBlock((lplr.Character.PrimaryPart.CFrame) - Vector3.new(0,4.5,0),block)
							placeBlock((lplr.Character.PrimaryPart.CFrame) - Vector3.new(0,4,0),block)
							placeBlock((lplr.Character.PrimaryPart.CFrame) - Vector3.new(0,5,0),block)
							placeBlock((lplr.Character.PrimaryPart.CFrame) - Vector3.new(0,5.5,0),block)
						else
							placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 1) - Vector3.new(0,4.5,0),block)
							if not modules.Scaffold.Enabled then return end
							placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 2) - Vector3.new(0,4.5,0),block)
							if not modules.Scaffold.Enabled then return end
							placeBlock((lplr.Character.PrimaryPart.CFrame + lplr.Character.PrimaryPart.CFrame.LookVector * 3) - Vector3.new(0,4.5,0),block)
						end
					end
				end)
			end)
		else
			pcall(function()
				scaffoldRun:Disconnect()
			end)
		end
	end,
})

Utilities = {
	GetChests = function()
		local chests = {}
		for i,v in pairs(workspace:GetChildren()) do
			if v.Name == "chest" then
				table.insert(chests,v)
			end
		end
		return chests
	end,
	GetCharacter = function()
		return game.Players.LocalPlayer.Character
	end,
}

local Chests = Utilities.GetChests()
local chestservice

modules.ChestStealer = lib:MakeButton({
	["Name"] = "ChestStealer",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				chestservice = game["Run Service"].Heartbeat:Connect(function()
					task.wait(0.15)
					task.spawn(function()
						for i, v in pairs(Chests) do
							local Magnitude = (v.Position - Utilities.GetCharacter().PrimaryPart.Position).Magnitude
							if Magnitude <= 30 then
								for _, item in pairs(v.ChestFolderValue.Value:GetChildren()) do
									if item:IsA("Accessory") then
										task.wait()
										game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("Inventory/ChestGetItem"):InvokeServer(v.ChestFolderValue.Value, item)
									end
								end
							end
						end
					end)
				end)
			end)
		else
			pcall(function()
				chestservice:Disconnect()
			end)
		end
	end,
})

local function getLowestPartOverZero()
	local lowest = 9e9
	local part
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("Part") or v:IsA("BasePart") then
			if v.Position.Y < lowest and v.Name ~= "HumanoidRootPart" then
				part = v
			end
		end
	end
	return part
end
local lowestPoint = getLowestPartOverZero().Position.Y < 20 and getLowestPartOverZero().Position or Vector3.new(0,20,0)
local AntiFallPart

modules.AntiFall = lib:MakeButton({
	["Name"] = "Antifall",
	["Window"] = "Player",
	["Function"] = function(callback)
		if callback then
			AntiFallPart = Instance.new("Part", workspace)
			AntiFallPart.Anchored = true
			AntiFallPart.CFrame = CFrame.new(lplr.Character.PrimaryPart.Position.X, lowestPoint.Y, lplr.Character.PrimaryPart.Position.Z) - Vector3.new(0, 10, 0)
			AntiFallPart.Size = Vector3.new(100000, 1, 100000)
			AntiFallPart.Material = Enum.Material.Neon
			AntiFallPart.Transparency = 0.8
			AntiFallPart.CanCollide = false
			AntiFallPart.Rotation = Vector3.new(0, 0, 0)
			spawn(function()
				pcall(function()
					AntiFallPart.Touched:Connect(function(obj)
						if obj:FindFirstAncestorOfClass("Model").Name == lplr.Name then
							local velo = lplr.Character.PrimaryPart.Velocity
							for i = 1,6 do task.wait(0.2)
								lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
							end
						end
					end)
				end)
			end)
		else
			pcall(function()
				AntiFallPart:Remove()
			end)
		end
	end,
})

--[[modules.Duper = lib:MakeButton({
	["Name"] = "Duper",
	["Window"] = "Exploit",
	["Function"] = function(callback)
		if callback then
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "stone_sword",        ["price"] = 15,        ["prevTier"] = "wood_sword",        ["customDisplayName"] = "Stone Sword",        ["currency"] = "iron",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "iron_sword",        ["price"] = 25,        ["prevTier"] = "stone_sword",        ["customDisplayName"] = "Iron Sword",        ["currency"] = "gold",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})

			--Call #80:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "diamond_sword",        ["price"] = 40,        ["prevTier"] = "iron_sword",        ["customDisplayName"] = "Diamond Sword",        ["currency"] = "emerald",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "leather_chestplate",        ["price"] = 50,        ["customDisplayName"] = "Leather Armor",        ["currency"] = "iron",        ["amount"] = 1,        ["nextTier"] = "iron_chestplate",        ["ignoredByKit"] = {            [1] = "bigman",        },        ["spawnWithItems"] = {            [1] = "leather_helmet",            [2] = "leather_chestplate",            [3] = "leather_boots",        },        ["category"] = "Combat",    },})

			--Call #82:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "iron_chestplate",        ["price"] = 120,        ["prevTier"] = "leather_chestplate",        ["nextTier"] = "diamond_chestplate",        ["currency"] = "iron",        ["category"] = "Combat",        ["amount"] = 1,        ["tiered"] = true,        ["ignoredByKit"] = {            [1] = "bigman",        },        ["spawnWithItems"] = {            [1] = "iron_helmet",            [2] = "iron_chestplate",            [3] = "iron_boots",        },        ["customDisplayName"] = "Iron Armor",    },})

			--Call #83:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "diamond_chestplate",        ["price"] = 8,        ["prevTier"] = "iron_chestplate",        ["nextTier"] = "emerald_chestplate",        ["currency"] = "emerald",        ["category"] = "Combat",        ["amount"] = 1,        ["tiered"] = true,        ["ignoredByKit"] = {            [1] = "bigman",        },        ["spawnWithItems"] = {            [1] = "diamond_helmet",            [2] = "diamond_chestplate",            [3] = "diamond_boots",        },        ["customDisplayName"] = "Diamond Armor",    },})

			--Call #84:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "emerald_chestplate",        ["price"] = 40,        ["prevTier"] = "diamond_chestplate",        ["customDisplayName"] = "Emerald Armor",        ["currency"] = "emerald",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["spawnWithItems"] = {            [1] = "emerald_helmet",            [2] = "emerald_chestplate",            [3] = "emerald_boots",        },        ["ignoredByKit"] = {            [1] = "bigman",        },    },})

			--Call #85:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["currency"] = "iron",        ["ignoredByKit"] = {            [1] = "bigman",        },        ["itemType"] = "wood_sword",        ["category"] = "Combat",        ["price"] = 10,        ["amount"] = 1,        ["customDisplayName"] = "Wood Sword",        ["lockAfterPurchase"] = true,    },})

			--Call #86:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "stone_sword",        ["price"] = 15,        ["prevTier"] = "wood_sword",        ["customDisplayName"] = "Stone Sword",        ["currency"] = "iron",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})

			--Call #87:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "iron_sword",        ["price"] = 25,        ["prevTier"] = "stone_sword",        ["customDisplayName"] = "Iron Sword",        ["currency"] = "gold",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})

			--Call #88:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "diamond_sword",        ["price"] = 40,        ["prevTier"] = "iron_sword",        ["customDisplayName"] = "Diamond Sword",        ["currency"] = "emerald",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})

			--Call #89:
			game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:InvokeServer({    ["shopItem"] = {        ["lockAfterPurchase"] = true,        ["itemType"] = "emerald_sword",        ["price"] = 40,        ["prevTier"] = "diamond_sword",        ["customDisplayName"] = "Emerald Sword",        ["currency"] = "emerald",        ["amount"] = 1,        ["tiered"] = true,        ["category"] = "Combat",        ["ignoredByKit"] = {            [1] = "bigman",        },    },})
			modules.Duper.ToggleButton(false)
		end
	end,
})]]

modules.Bypasser = lib:MakeButton({
	["Name"] = "Bypasser",
	["Window"] = "Exploit",
	["Function"] = function(callback)
		if callback then
			repeat

				task.wait()
			until (not modules.Bypasser.Enabled)
		end
	end,
})

modules.TargetStrafe = lib:MakeButton({
	["Name"] = "TargetStrafe",
	["Window"] = "Movement",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					local entity = GetNearestPlr(18)
					if entity == nil then return end
					lplr.Character.PrimaryPart.CFrame = CFrame.lookAt(lplr.Character.PrimaryPart.Position,Vector3.new(entity.Character.PrimaryPart.Position.X,lplr.Character.PrimaryPart.Position.Y,entity.Character.PrimaryPart.Position.Z))
					lplr.Character.PrimaryPart.CFrame += lplr.Character.PrimaryPart.CFrame.LookVector * .5
					task.wait()
				until (not modules.TargetStrafe.Enabled)
			end)
		end
	end,
})

modules.Disabler = lib:MakeButton({
	["Name"] = "Disabler",
	["Window"] = "Exploit",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then
						lplr.Character.PrimaryPart.CFrame += lplr.Character.PrimaryPart.CFrame.LookVector * .8
					end
					local args = {
						[1] = {
							["direction"] = lplr.Character.PrimaryPart.CFrame.LookVector
						}
					}
					netmanaged.ScytheDash:FireServer(unpack(args))
					task.wait()
				until (not modules.Disabler.Enabled)
			end)
		end
	end,
})

modules.Hostpanel = lib:MakeButton({
	["Name"] = "Hostpanel",
	["Window"] = "Exploit",
	["Function"] = function(callback)
		if callback then
			repeat task.wait() until game:GetService("Players")
			local v2 = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out)
			local OfflinePlayerUtil = v2.OfflinePlayerUtil
			local v6 = OfflinePlayerUtil.getPlayer(game.Players.LocalPlayer);
			v6:SetAttribute("Cohost", true)
			local players = game:GetService("Players")
			repeat task.wait() until players.LocalPlayer
			if game.GameId ~= 2619619496 then return end
			local tpdata = game:GetService("TeleportService"):GetLocalPlayerTeleportData()
			local suc,res
			repeat  
				task.wait()
				suc, res = pcall(function()
					local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
					return Client:Get("PlayerConnect")
				end)
			until suc and res

			local clientstore = require(players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
			if game.PlaceId ~= 6872265039 then
				local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
				local ConnectController = require(players.LocalPlayer.PlayerScripts.TS.controllers.global.connect["connect-controller"]).ConnectController
				local old = ConnectController.KnitStart
				clientstore:dispatch({
					type = "GameSetQueueType", 
					queueType = tpdata.match.queueType
				})
				local Flamework = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
				repeat task.wait() until Flamework.isInitialized
				local ConnectController = require(players.LocalPlayer.PlayerScripts.TS.controllers.global.connect["connect-controller"]).ConnectController
				local NotificationController =  Flamework.resolveDependency("@easy-games/game-core:client/controllers/notification-controller@NotificationController")
				local old = ConnectController.KnitStart
				ConnectController.KnitStart = function()
					task.wait(1)
					for i,v in pairs(game.Players:GetPlayers()) do
						NotificationController:sendInfoNotification({
							image = "rbxassetid://6830860982",
							message = '<font color="#AAAAAA"><b>'..(v.DisplayName)..'</b></font> Has been placed on'..v.Team.Name
						})
					end
					old()
				end
			end
		else
			lib:Notify("Hostpanel will turn off next game.", 7.5)
		end
	end,
})

task.wait(1)

for i,v in pairs(modules) do
	pcall(function()
		if isfile("Autumn/Config/"..v.Name..".txt") then
			v.ToggleButton(true)
		end
	end)
end

for i,v in pairs(modules) do
	if isfile("Autumn/Config/"..v.Name.."_keybind.txt") then
		pcall(function()
			keybinds[v.Name.."_keybind"] = Enum.KeyCode[readfile("Autumn/Config/"..v.Name.."_keybind.txt")]
		end)
	end
end
if isfile("Autumn/Config/GuiTheme.txt") then
	for i,v in pairs(themeBTNS) do
		v.ToggleButton(false)
	end
	for i = 1,25 do task.wait()
		currentTheme = themes[readfile("Autumn/Config/GuiTheme.txt")]
	end
	for i,v in pairs(themeBTNS) do
		v.ToggleButton(false)
	end
	for i = 1,25 do task.wait()
		currentTheme = themes[readfile("Autumn/Config/GuiTheme.txt")]
	end
end

lib:Notify("Autumn (Build 1.0.0) Loaded!",10)
