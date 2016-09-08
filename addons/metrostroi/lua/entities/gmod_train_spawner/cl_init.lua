include("shared.lua")
local MaxHorisontal = 14
local frame = nil
local MaxWagons = 0
local MaxWagonsOnPlayer = 0
local Settings = {
	Train = 1,
	Adv = 1,
	WagNum = 3,
	Texture = "",
	Lighter = 1,
	PassTexture = "",
	CabTexture = "",
	ARS = 1,
	Cran = 1,
	Prom = 1,
	Mask = 1,
	PiterMsk = 1,
	LED = 0,
	BPSN = 1,
	KVSnd = 1,
	OldKVPos = 0,
	Horn = 0,
	NM = 8.2,
	Battery = 0,
	Switches = 1,
	SwitchesR = 0,
	DoorsL = 0,
	DoorsR = 0,
	GV = 1,
	PB = 0,
	Bort = 1,
	MVM = 0,
	Hand = 1,
	Lamp = 1,
	Seat = 1,
	Breakers = 0,
	Blok = 1,
	PNM = 0,
}
---Массив строчек, необходимых для таблиц тренспавнера, строчка соответствует номеру состава в массиве которая прописана в trainspawner stools
local Types = {
	"Train,WagNum,PassTexture,CabTexture,Texture,Lighter,ARS,Cran,Mask,LED,BPSN,KVSnd,Horn,NM,Battery,Switches,SwitchesR,DoorsL,DoorsR,GV,PB,Bort,MVM,Hand,Seat,Lamp,Breakers,Adv,PNM",
	"Train,WagNum,PassTexture,CabTexture,Texture,Lighter,Blok,Cran,PiterMsk,LED,BPSN,KVSnd,Horn,NM,Battery,Switches,SwitchesR,DoorsL,DoorsR,GV,PB,Bort,Hand,Seat,Lamp,Breakers,Adv,PNM",
	"Train,WagNum,PassTexture,CabTexture,Texture,NM,Battery,DoorsL,DoorsR,GV,PB,Adv",
	"Train,WagNum,PassTexture,CabTexture,Texture,NM,Battery,DoorsL,DoorsR,GV,PB,Adv",
	"Train,WagNum,Texture,Prom,Horn,NM,Battery,Switches,SwitchesR,DoorsL,DoorsR,GV,PB,PNM",
	"Train,WagNum",
	"Train,WagNum,PassTexture,CabTexture,Texture,NM,Battery,DoorsL,DoorsR,GV,PB,Adv", 
}
local function UpdateConCMD()
	for k,v in pairs(Settings) do
		RunConsoleCommand("train_spawner_"..k:lower(), v)
	end
end

local function LoadConCMD()
	for k in pairs(Settings) do
		if type(Settings[k]) == "string" then
			Settings[k] = GetConVarString("train_spawner_"..k:lower())	
		else
			Settings[k] = GetConVarNumber("train_spawner_"..k:lower())
		end
	end
end
local Pos = 0
local VGUI = {}
local function CreateList(name,text,tbl,OnSelect)
	tbl = tbl or {}
	local ListLabel = vgui.Create("DLabel", frame)
	ListLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 24+24*(Pos%MaxHorisontal))
	ListLabel:SetSize(500,28)
	ListLabel:SetText(text)

	local List = vgui.Create("DComboBox", frame)--
	List:SetPos(130 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal)) 
	List:SetWide(80)
	if #tbl > 0 then
		for i=1,#tbl do
			List:AddChoice(tbl[i], i, Settings[name] == i)
		end
	else
		for k,v in pairs(tbl) do
			local name = k
			if type(v) == "table" and v.name then name = v.name end
			List:AddChoice(name, v, Settings[name] == v)
		end
	end
	List.OnSelect = function(self,_, _, index)
		Settings[name] = index
		UpdateConCMD()
		if OnSelect then OnSelect(List,ListLabel) end
	end
	table.insert(VGUI,function()
		local on = Types[Settings.Train]:find(name) and tbl 
		List:SetVisible(on)
		ListLabel:SetVisible(on)
		if on then
			ListLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal),24+24*(Pos%MaxHorisontal))
			List:SetPos(130 + 300*math.floor(Pos/MaxHorisontal),28+24*(Pos%MaxHorisontal))
			Pos = Pos + 1 
		end
	end)
	VGUI[name] = List
	if Types[Settings.Train]:find(name) and #tbl > 0  then Pos = Pos + 1 end
end
	
local function CreateSlider(name,decimals,min,max,text,OnSelect)
	local Slider = vgui.Create("DNumSlider", frame)
	Slider:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal)-7)
	Slider:SetWide(290)
	Slider:SetMinMax(min, max)
	Slider:SetDecimals(decimals)
	Slider:SetText(text..":")
	if Settings[name]  > max then Settings[name] = max end
	Slider:SetValue(Settings[name])

	local _old = Slider.ValueChanged
	function Slider:ValueChanged(...)
		_old(self, ...)
		Settings[name] = math.Round(self:GetValue(),decimals)
		UpdateConCMD()
		if OnSelect then OnSelect(Slider) end
	end
	table.insert(VGUI,function()
		local on = Types[Settings.Train]:find(name)
		Slider:SetVisible(on)
		if on then
			Slider:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal)-7)
			Pos = Pos + 1 
		end
	end)
	VGUI[name] = Slider
	if Types[Settings.Train]:find(name) then Pos = Pos + 1 end
end

local function CreateCheckBox(name,text,OnSelect)
	--if not Types[Settings.Train]:find(name) then return end
	local CBLabel = vgui.Create("DLabel", frame)--
	CBLabel:SetPos(5 + 300*math.floor(Pos/MaxHorisontal), 25+24*(Pos%MaxHorisontal))
	CBLabel:SetText(text)
	CBLabel:SetWide(130)
	local CB = vgui.Create("DCheckBox", frame)
	CB:SetPos(130 + 300*math.floor(Pos/MaxHorisontal), 28+24*(Pos%MaxHorisontal))
	CB:SetValue(Settings[name])
	function CB:OnChange()
		Settings[name] = CB:GetChecked() and 1 or 0
		UpdateConCMD()
		if OnSelect then OnSelect(CB,CBLabel) end
	end
	table.insert(VGUI,function()
		local on = Types[Settings.Train]:find(name)
		CBLabel:SetVisible(on)
		CB:SetVisible(on)
		if on then
			CBLabel:SetPos(5  + 300*math.floor(Pos/MaxHorisontal),25+24*(Pos%MaxHorisontal))
			CB:SetPos(130 + 300*math.floor(Pos/MaxHorisontal),28+24*(Pos%MaxHorisontal))
			Pos = Pos + 1 
		end
	end)
	VGUI[name] = CB
	if Types[Settings.Train]:find(name) then Pos = Pos + 1 end
end

local function UpdateTrainList()
	Pos = 0
	if (Metrostroi.Skins["train"][Settings.Texture] or {}).typ ~= Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then Settings.Texture = nil end
	VGUI.Texture:Clear()
	if (Metrostroi.Skins["pass"][Settings.PassTexture] or {}).typ ~= Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then Settings.PassTexture = nil end
	VGUI.PassTexture:Clear()
	if (Metrostroi.Skins["cab"][Settings.CabTexture] or {}).typ ~= Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then Settings.CabTexture = nil end
	VGUI.CabTexture:Clear()
	
	for typ,skins in pairs(Metrostroi.Skins) do
		for k,v in pairs(skins) do
			if type(v) ~= "table" then continue end
			local id = "Texture"
			if typ == "pass" then id = "PassTexture" end
			if typ == "cab" then id = "CabTexture" end
			if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then
				if not Settings[id] then
					Settings[id] = k
				end
				VGUI[id]:AddChoice(v.name or k, k, k == Settings[id])
			end	
		end
	end
	--[[
	end
	for k,v in pairs(Metrostroi.Skins["pass"] or {} ) do
		if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then
			if not Settings.PassTexture then
				Settings.PassTexture = k
			end
			VGUI.PassTexture:AddChoice(v.name or v, k, k == Settings.PassTexture)
		end
	end
	for k,v in pairs(Metrostroi.Skins["cab"] or {} ) do
		if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then
			if not Settings.CabTexture then
				Settings.CabTexture = k
			end
			VGUI.CabTexture:AddChoice(v.name or v, k, k == Settings.CabTexture)
		end
	end
	]]
	for k,v in ipairs(VGUI) do
		v()
	end
	frame:SetSize(275 + 275*math.floor((Pos-1)/MaxHorisontal), 58+24*math.min(MaxHorisontal,Pos))
	frame:Center()
	if VGUI.Close then VGUI.Close() end
	if VGUI.spawn then VGUI.spawn() end
end
local function Draw()
	local Texture = {}
	for k,v in pairs(Metrostroi.Skins["train"] or {}) do
		if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then Texture[v.name or k] = v.name or k end
		--end
	end
	local PassTexture = {}
	for k,v in pairs(Metrostroi.Skins["pass"] or {}) do
		if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then PassTexture[v.name or k] = v.name or k end
	end
	local CabTexture = {}
	for k,v in pairs(Metrostroi.Skins["cab"] or {}) do
		if v.typ == Metrostroi.TrainSpawnerConverter[Settings.Train or 1] then CabTexture[v.name or k] = v.name or k end
	end
	CreateList("Train","Train("..GetGlobalInt("metrostroi_train_count").."/"..MaxWagons.."):\nMax for you:"..MaxWagonsOnPlayer,{"81-71x MVM","81-71x LVZ","Тип E (81-703)","EmA","Ezh","81-703x","Тип Em (81-508)"},UpdateTrainList)
	CreateSlider("WagNum",0,1, GetGlobalInt("metrostroi_maxwagons"),"Wagons")
	CreateList("Texture","Texture",Texture)
	CreateList("PassTexture","Passenger texture",PassTexture)
	CreateList("CabTexture","Cabin texture",CabTexture)
	CreateList("Adv","Adverts",{"Type1","Type2","Type3","No adverts"})
	CreateList("Cran","Cran type",{"334","013"})
	CreateSlider("NM",1,0.1,9,"Train Line Pressure")
	CreateList("ARS","ARS Type",{"Standart(square lamps)","Standart(round lamps)","Kiev/St.Petersburg","Old ARS"})
	CreateList("Blok","Autodrive panel",{"PUAV","PA-KSD","PA-M","PA-KSD-M"})
	CreateList("Mask","Mask",{"2-2","2-2-2","1-4-1 bumper 1","1-4-1 bumper 2","1-1","Retro"})
	CreateList("PiterMsk","PiterMsk",{"1-4-1","2-2 Down-2","2-2","2-2-2","1-3-1"})
	CreateList("BPSN","BPSN type",{"Old high tone","Old medium tone","Normal(from St.Petersburg)","Normal(TKL)","Normal","Old tone","No sound(BPN-115)"})
	CreateList("Seat","Seat type",{"Old","New"})
	CreateList("Hand","Hand rail type",{"Old","New"})
	CreateList("Bort","Bort",{"Horisontal","Vertical"})
	CreateList("Lamp","Lamp type",{"Type1","Type2","Type3"})
	CreateCheckBox("PNM","PNM Informer")
	CreateCheckBox("Lighter","Lighter")
	CreateCheckBox("MVM","MVM icon")
	CreateCheckBox("GV","Main Switch")
	CreateCheckBox("Battery","Battery")
	CreateCheckBox("PB","Parking brake")
	CreateCheckBox("Switches","AutoBreakers",function()
		if Settings.Switches == 0 then VGUI.SwitchesR:OnChange() end
	end)
	CreateCheckBox("SwitchesR","Random",function(self)
		if Settings.Switches == 0 and self:GetChecked() then
			self:SetValue(Settings.Switches)
		end
	end)
	CreateCheckBox("DoorsL","Left doors")
	CreateCheckBox("DoorsR","Right doors")
	CreateCheckBox("Prom","Interim wags")
	CreateCheckBox("Breakers","Right-syde breakers")
	CreateCheckBox("LED","LED")
	CreateList("KVSnd","KV snd",{"Dildo","Type2","Type3"})
	CreateCheckBox("OldKVPos","Old KV pos")
	CreateCheckBox("Horn","Piter horn")
	
	UpdateTrainList()
end
local function createFrame()
	MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
	MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")
	if GetConVarString("gmod_toolmode") == "train_spawner" then RunConsoleCommand("gmod_toolmode", "weld") end
	if !frame or !frame:IsValid() then
		Pos = 0
		VGUI = {}
		frame = vgui.Create("DFrame")
			frame:SetDeleteOnClose(true)
			frame:SetTitle("Train Spawner")
			--frame:SetSize(275, 34+24*17)
			frame:SetDraggable(false)
			frame:SetSizable(false)
			frame:MakePopup()

		LoadConCMD()
		Draw()
		
		frame:SetSize(275 + 275*math.floor((Pos-1)/MaxHorisontal), 58+24*math.min(MaxHorisontal,Pos))
		frame:Center()
		local Close = vgui.Create("DButton", frame)
		Close:SetWide(80)
		Close:SetPos(5, frame:GetTall() - Close:GetTall() - 5)
		Close:SetText("Close")
		
		Close.DoClick = function()
			frame:Close()
		end
		VGUI["Close"] = function()
			if IsValid(Close) and IsValid(frame) then Close:SetPos(5, frame:GetTall() - Close:GetTall() - 5) end
		end
		local spawn = vgui.Create("DButton", frame)
		spawn:SetWide(80)
		spawn:SetPos(frame:GetWide() - Close:GetWide() - 5, frame:GetTall() - Close:GetTall() - 5)
		spawn:SetText("Spawn Tool")
		VGUI["spawn"] = function()
			if IsValid(spawn) and IsValid(frame) then spawn:SetPos(frame:GetWide() - Close:GetWide() - 5, frame:GetTall() - Close:GetTall() - 5) end
		end
		
		spawn.DoClick = function()
			local Tool = GetConVarString("gmod_toolmode")
			if Tool == "train_spawner" then Tool = "weld" end
			RunConsoleCommand("train_spawner_oldT", Tool)
			RunConsoleCommand("train_spawner_oldW", LocalPlayer():GetActiveWeapon():GetClass())
			RunConsoleCommand("gmod_tool", "train_spawner")
			frame:Close()
		end
	end
end

net.Receive("MetrostroiTrainSpawner",createFrame)
net.Receive("MetrostroiMaxWagons", function()
	MaxWagons = GetGlobalInt("metrostroi_maxtrains")*GetGlobalInt("metrostroi_maxwagons")
	MaxWagonsOnPlayer = GetGlobalInt("metrostroi_maxtrains_onplayer")*GetGlobalInt("metrostroi_maxwagons")
	if trainTypeT and trainTypeT:IsValid() then trainTypeT:SetText("Train("..GetGlobalInt("metrostroi_train_count").."/"..MaxWagons.."):\nMax for you:"..MaxWagonsOnPlayer) end
end
)
net.Receive("MetrostroiTrainCount", function()
	if trainTypeT and trainTypeT:IsValid() then trainTypeT:SetText("Train("..GetGlobalInt("metrostroi_train_count").."/"..MaxWagons.."):\nMax for you:"..MaxWagonsOnPlayer) end
end
)