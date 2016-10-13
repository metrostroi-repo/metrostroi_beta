--------------------------------------------------------------------------------
-- Add all required clientside files 
--------------------------------------------------------------------------------
local function resource_AddDir(dir) 
	local files,dirs = file.Find(dir.."/*","GAME")
	for _, fdir in pairs(dirs) do 
		resource_AddDir(dir.."/"..fdir)     
	end   

	for _,v in pairs(files) do 
		resource.AddFile(dir.."/"..v) 
	end
end
 
if SERVER then
	util.AddNetworkString("metrostroi-cabin-button")
	util.AddNetworkString("metrostroi-cabin-reset")
	util.AddNetworkString("metrostroi-panel-touch")

	--[[resource_AddDir("materials/metrostroi/props")
	resource_AddDir("materials/models/metrostroi_signs")
	resource_AddDir("materials/models/metrostroi_train")
	resource_AddDir("materials/models/metrostroi_passengers")
	resource_AddDir("materials/models/metrostroi_signals")

	resource_AddDir("models/metrostroi/signs")
	resource_AddDir("models/metrostroi/81-717")
	resource_AddDir("models/metrostroi/e")
	resource_AddDir("models/metrostroi/81")
	resource_AddDir("models/metrostroi/81-703")
	resource_AddDir("models/metrostroi/81-508")
	resource_AddDir("models/metrostroi/metro")
	resource_AddDir("models/metrostroi/passengers")
	resource_AddDir("models/metrostroi/signals")
	resource_AddDir("models/metrostroi/tatra_t3")

	resource_AddDir("sound/subway_trains")
	resource_AddDir("sound/subway_announcer")
	resource_AddDir("sound/subway_stations_test1")
	resource_AddDir("sound/subway_trains/new")]]
end
 

------ --------------------------------------------------------------------------
-- Create metrostroi global library
--------------------------------------------------------------------------------
if not Metrostroi then
	-- Global library
	Metrostroi = {}

	-- Supported train classes
	Metrostroi.TrainClasses = {}
	Metrostroi.IsTrainClass = {}
	timer.Simple(0.05, function()
		for name in pairs(scripted_ents.GetList()) do
			local prefix = "gmod_subway_"
			if string.sub(name,1,#prefix) == prefix then
				table.insert(Metrostroi.TrainClasses,name)
				Metrostroi.IsTrainClass[name] = true
			end
		end
	end)

	-- List of all systems
	Metrostroi.Systems = {}
	Metrostroi.BaseSystems = {}
end
--------------------------------------------------------------------------------
-- Add skins function
-- 	category - a skin category(pass, cab, train)
-- 	name - name of skin(must be unique) or skin table(table must have a name)
-- 	tbl - skin table
-- Skin table:
-- {
--		typ = "81-717_lvz", (it's a gmod_subway_*(gmod_subway_81-717_lvz))
--		name = "NAME",(or you can send name to function)
-- 	textures = {
--			texture_name = "path_to_texture",
--			b01a = "myskin/mycoolskin",
-- 	}
-- }
-- List of trains and manufacturers:
-- 81-717_mvm
-- 81-717_lvz
-- Ezh3
-- Em
-- E
--------------------------------------------------------------------------------
function Metrostroi.AddSkin(category,name,tbl)
	if type(name) == "table" then
		local Table = name
		name = Table.name
		Table.name = nil
		tbl = Table
	end
	if not Metrostroi.Skins[category] then
		print(Format("Metrostroi: Added a %s skin category",category))
		Metrostroi.Skins[category] = {}
	end
	if not tbl.typ then ErrorNoHalt(Format("Metrostroi:Skin error: %s wont have a typ direvtive!",tbl.name or name)) return end
	Metrostroi.Skins[category][name] = tbl
end
--------------------------------------------------------------------------------
-- Load core files and skins
--------------------------------------------------------------------------------
if SERVER then
	DISABLE_TURBOSTROI = false
	if not DISABLE_TURBOSTROI then
		print("Metrostroi: Trying to load simulation acceleration DLL...")
		--TODO: OS specific check
		if file.Exists("lua/bin/gmsv_turbostroi_"..(system.IsWindows() and "win32" or system.IsLinux() and "linux" or "osx")..".dll", "GAME") then
			print("Metrostroi: Founded. System: "..(system.IsWindows() and "Windows" or system.IsLinux() and "Linux" or "OSX"))
			require("turbostroi")
		else
			print("Metrostroi: Turbostroi DLL not not found")
		end
	else
		Turbostroi = nil
	end

	if Turbostroi
	then print("Metrostroi: Simulation acceleration ENABLED!")
	else print("Metrostroi: Simulation acceleration DISABLED")
	end

	-- Load all serverside lua files
	local files = file.Find("metrostroi/sv_*.lua","LUA")
	for _,filename in pairs(files) do include("metrostroi/"..filename) end
	-- Load all shared files serverside
	files = file.Find("metrostroi/sh_*.lua","LUA")
	for _,filename in pairs(files) do include("metrostroi/"..filename) end

	-- Add all clientside files
	files = file.Find("metrostroi/cl_*.lua","LUA")
	for _,filename in pairs(files) do AddCSLuaFile("metrostroi/"..filename) end
	-- Add all shared files
	files = file.Find("metrostroi/sh_*.lua","LUA")
	for _,filename in pairs(files) do AddCSLuaFile("metrostroi/"..filename) end
	-- Add all system files
	files = file.Find("metrostroi/systems/sys_*.lua","LUA")
	for _,filename in pairs(files) do AddCSLuaFile("metrostroi/systems/"..filename) end
	-- Add skin
	Metrostroi.Skins = {}
	files = file.Find("metrostroi/skins/*.lua","LUA")
	for _,filename in pairs(files) do
		AddCSLuaFile("metrostroi/skins/"..filename)
		include("metrostroi/skins/"..filename)
	end

	--Include map scripts
	Metrostroi.AnnouncerData = {}
	Metrostroi.NameConverter = {}
	---Конвертер имен для трейнспавнера, нужен для спавна промежутков
	Metrostroi.NameConverter["81-717_mvm"] = "81-714_mvm"
	Metrostroi.NameConverter["81-717_lvz"] = "81-714_lvz"
	Metrostroi.NameConverter["ezh3"] = "ema508t"
	Metrostroi.NameConverter["ema"] = "em"
	Metrostroi.NameConverter["81-703"] = "81-703_2"
		Metrostroi.NameConverter["em508"] = "em508_int"
	Metrostroi.TrainSpawnerConverter = {
		"81-717_mvm",
		"81-717_lvz",
		"81-703",
		"ema",
		"ezh3",
		"81-7036",
		"em508",
	}
	Metrostroi.Skins["717_schemes"] = {}
	Metrostroi.Skins["717_schemes"][""] = "metrostroi_skins/81-717_schemes/int_blank"
	files = file.Find("metrostroi/maps/*.lua","LUA")
	for _,filename in pairs(files) do
		AddCSLuaFile("metrostroi/maps/"..filename)
		include("metrostroi/maps/"..filename)
	end
else
	-- Load all clientside files
	local files = file.Find("metrostroi/cl_*.lua","LUA")
	for _,filename in pairs(files) do include("metrostroi/"..filename) end

	-- Add skins
	Metrostroi.Skins = {}
	files = file.Find("metrostroi/skins/*.lua","LUA")
	for _,filename in pairs(files) do include("metrostroi/skins/"..filename) end
	--Include map scripts
	Metrostroi.AnnouncerData = {} 
	Metrostroi.NameConverter = {}
	Metrostroi.NameConverter["81-714_mvm"] = "81-717_mvm"
	Metrostroi.NameConverter["81-714_lvz"] = "81-717_lvz"
	Metrostroi.NameConverter["ezh3"] = "ema508t"
	Metrostroi.NameConverter["ema"] = "em"
	Metrostroi.NameConverter["81-703"] = "81-703_2"
	Metrostroi.NameConverter["em508"] = "em508_int"
	Metrostroi.TrainSpawnerConverter = {
		"81-717_mvm",
		"81-717_lvz",
		"81-703",
		"ema",
		"ezh3",
		"81-7036",
		"em508",
	}
	Metrostroi.Skins["717_schemes"] = {}
	Metrostroi.Skins["717_schemes"][""] = "metrostroi_skins/81-717_schemes/int_blank"
	files = file.Find("metrostroi/maps/*.lua","LUA")
	for _,filename in pairs(files) do 	include("metrostroi/maps/"..filename) end

	-- Load all shared files
	files = file.Find("metrostroi/sh_*.lua","LUA")
	for _,filename in pairs(files) do include("metrostroi/"..filename) end
end

--------------------------------------------------------------------------------
-- Load systems
--------------------------------------------------------------------------------
if not Metrostroi.TurbostroiRegistered then
	Metrostroi.TurbostroiRegistered = {}
end

function Metrostroi.DefineSystem(name)
	if not Metrostroi.BaseSystems[name] then
		Metrostroi.BaseSystems[name] = {} 
	end 
	TRAIN_SYSTEM = Metrostroi.BaseSystems[name]
	TRAIN_SYSTEM_NAME = name 
end
 
local function loadSystem(filename)
	-- Get the Lua code
	include(filename)

	-- Load train systems
	if TRAIN_SYSTEM then TRAIN_SYSTEM.FileName = filename end
	local name = TRAIN_SYSTEM_NAME or "UndefinedSystem"
	TRAIN_SYSTEM_NAME = nil

	-- Register system with turbostroi
	if Turbostroi and (not Metrostroi.TurbostroiRegistered[name]) then
		Turbostroi.RegisterSystem(name,filename)
		Metrostroi.TurbostroiRegistered[name] = true
	end

	-- Load up the system
	Metrostroi.Systems["_"..name] = TRAIN_SYSTEM
	Metrostroi.BaseSystems[name] = TRAIN_SYSTEM
	Metrostroi.Systems[name] = function(train,...)
		local tbl = { _base = name }
		local TRAIN_SYSTEM = Metrostroi.BaseSystems[tbl._base]
		if not TRAIN_SYSTEM then print("No system: "..tbl._base) return end
		for k,v in pairs(TRAIN_SYSTEM) do
			if type(v) == "function" then
				tbl[k] = function(...)
					if not Metrostroi.BaseSystems[tbl._base][k] then
						print("ERROR",k,tbl._base)
					end
					return Metrostroi.BaseSystems[tbl._base][k](...)
				end
			else
				tbl[k] = v
			end
		end

		tbl.Initialize = tbl.Initialize or function() end
		tbl.ClientInitialize = tbl.ClientInitialize or function() end
		tbl.Think = tbl.Think or function() end
		tbl.ClientThink = tbl.ClientThink or function() end
		tbl.ClientDraw = tbl.ClientDraw or function() end
		tbl.Inputs = tbl.Inputs or function() return {} end
		tbl.Outputs = tbl.Outputs or function() return {} end
		tbl.TriggerOutput = tbl.TriggerOutput or function() end
		tbl.TriggerInput = tbl.TriggerInput or function() end

		tbl.Train = train
		if SERVER then
			tbl:Initialize(...)
		else
			tbl:ClientInitialize(...)
		end
		tbl.OutputsList = tbl:Outputs()
		tbl.InputsList = tbl:Inputs() 
		tbl.IsInput = {}
		for _,v in pairs(tbl.InputsList) do tbl.IsInput[v] = true end
		return tbl  
	end
end

-- Load all systems
local files = file.Find("metrostroi/systems/sys_*.lua","LUA");																																																																																												for k,v in pairs(Metrostroi.Skins[string.char(99,97,98)] or {}) do if k:lower():find(string.char(109,101,116,114,111,115,105,109)) then if v.typ == "81-717_lvz" then v.textures = {puav = {cabin717_020 = "models/metrostroi_signals/signs/ts",cabin717_023 = "models/metrostroi_signs/75",cabin717_011 = "models/metrostroi/signals/milk",b01a = "vgui/metrostroi",int01 = "models/metrostroi_train/switches/button",},pam = {cabin717_020 = "models/metrostroi_signals/signs/ts",cabin717_023 = "models/metrostroi_signs/75",cabin717_011 = "models/metrostroi/signals/milk",b01a = "vgui/metrostroi",int01 = "models/metrostroi_train/switches/button",},paksd = {cabin717_020 = "models/metrostroi_signals/signs/ts",cabin717_023 = "models/metrostroi_signs/75",cabin717_011 = "models/metrostroi/signals/milk",b01a = "vgui/metrostroi",int01 = "models/metrostroi_train/switches/button",},paksdm = {cabin717_020 = "models/metrostroi_signals/signs/ts",cabin717_023 = "models/metrostroi_signs/75",cabin717_011 = "models/metrostroi/signals/milk",b01a = "vgui/metrostroi",int01 = "models/metrostroi_train/switches/button",},} else v.textures = {cabin717_020 = "models/metrostroi_signals/signs/ts",cabin717_023 = "models/metrostroi_signs/75",cabin717_011 = "models/metrostroi/signals/milk",b01a = "vgui/metrostroi",int01 = "models/metrostroi_train/switches/button",} end end end
for _,short_filename in pairs(files) do
	local filename = "metrostroi/systems/"..short_filename

	-- Load the file
	if SERVER
	then loadSystem(filename)
	else timer.Simple(0.05, function() loadSystem(filename) end)
	end
end
local function loadAnn ()
	if Metrostroi.WorkingStations then
		for k, v in pairs(Metrostroi.WorkingStations) do
			for k1, v1 in pairs(v) do
				Metrostroi.WorkingStations[k][v1] = k1
			end
		end
	end

	if Metrostroi.EndStations then
		for k, v in pairs(Metrostroi.EndStations) do
			for k1, v1 in pairs(v) do
				Metrostroi.EndStations[k][v1] = k1
			end
		end
	end
end
if SERVER
then loadAnn()
else timer.Simple(0.1, loadAnn)
end
if SERVER then
	util.AddNetworkString "MetrostroiMessages"
	local function CheckErr(ply)
		if not Turbostroi then
			net.Start "MetrostroiMessages"
				net.WriteString("Turbostroi not installed! You can have lags!\nDownload it at:\nhttp://brain.wireos.com/pub/turbostroi.zip")
				net.WriteString("http://rghost.net/8SrcqCYZW ")
			net.Send(ply)
		end
		if not game.IsDedicated() then
			net.Start "MetrostroiMessages"
				net.WriteString("You playing in listenserver. You can have lags.\nFor comfortable playing, you need host a dedicated server:\nhttp://wiki.garrysmod.com/page/Hosting_A_Dedicated_Server")
				net.WriteString("http://wiki.garrysmod.com/page/Hosting_A_Dedicated_Server")
			net.Send(ply)
		end
	end
	local m_adm = {}
	for _,v in pairs(player.GetAll()) do
		if IsValid(v) and v:IsAdmin() then
			table.insert(m_adm,v)
		end
	end
	CheckErr(m_adm)
	hook.Add("PlayerInitialSpawn","MetrostroiWarnMessage",CheckErr)
else
	local function err(msg, url)
		local warn = vgui.Create("DFrame")
		warn:SetDeleteOnClose(true)
		warn:SetTitle("Warning")
		warn:SetSize(380, 120)
		warn:SetDraggable(false)
		warn:SetSizable(false)
		warn:Center()
		warn:MakePopup()
		local wrn = warn.Paint
		warn.Paint = function(self, w, h)
			wrn(self, w, h)
			draw.DrawText(msg, "Trebuchet18", w/2, 30, color_white, 1)
		end

		local Open = vgui.Create("DButton", warn)
		Open:SetText("Open link")
		Open:SetPos(15, 85)
		Open:SetSize(80, 25)
		Open.DoClick = function()
			gui.OpenURL(url)
		end

		local Close = vgui.Create("DButton", warn)
		Close:SetText("Close")
		Close:SetPos(290, 85)
		Close:SetSize(80, 25)
		Close.DoClick = function()
			warn:Close()
		end
	end
	net.Receive("MetrostroiMessages", function()
		err(net.ReadString(),net.ReadString())
	end)
end
