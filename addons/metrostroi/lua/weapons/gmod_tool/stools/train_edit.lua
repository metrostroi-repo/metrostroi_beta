TOOL.Category   = "Metro"
TOOL.Name       = "Train Feature Editor"
TOOL.Command    = nil
TOOL.ConfigName = ""

if CLIENT then
	language.Add("Tool.switch.name", "Train Feature Editor")
	language.Add("Tool.switch.desc", "Change features of the target train")
	language.Add("Tool.switch.0", "Primary: Apply selected features to the train")
end

TOOL.ClientConVar["train"] = 0
TOOL.ClientConVar["passtexture"] = 0
TOOL.ClientConVar["texture"] = 0
TOOL.ClientConVar["adv"] = 1
TOOL.ClientConVar["led"] = 0
TOOL.ClientConVar["cran"] = 0
TOOL.ClientConVar["bpsn"] = 1
TOOL.ClientConVar["kvsnd"] = 1
TOOL.ClientConVar["oldkvpos"] = 0
TOOL.ClientConVar["horn"] = 0
TOOL.ClientConVar["ars"] = 1
TOOL.ClientConVar["lamp"] = 0
TOOL.ClientConVar["mask"] = 0
TOOL.ClientConVar["seat"] = 0
TOOL.ClientConVar["hand"] = 0
TOOL.ClientConVar["mvm"] = 0
TOOL.ClientConVar["bort"] = 0
TOOL.ClientConVar["horn"] = 0
TOOL.ClientConVar["breakers"] = 0

function TOOL:LeftClick(trace)
	if CLIENT then return true end
	
	local ply = self:GetOwner()
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end
	if not Metrostroi.IsTrainClass[trace.Entity:GetClass()] then return false end
	
	local train = trace.Entity
	if train:GetClass():find("1-703") then return end
	--train:SetSkin(self:GetClientNumber("skin"))
	train.LED = self:GetClientNumber("led") > 0
	train.ARSType = self:GetClientNumber("ars")
	train:SetNWInt("ARSType",train.ARSType)
	train.LampType = self:GetClientNumber("lamp") 
	train.MaskType = self:GetClientNumber("mask") 
	train.SeatType = self:GetClientNumber("seat") 
	train.HandRail = self:GetClientNumber("hand") 
	train.MVM = self:GetClientNumber("mvm") > 0
	train.BortLampType = self:GetClientNumber("bort") 
	train.BPSNType= self:GetClientNumber("bpsn")
	train.Breakers= self:GetClientNumber("breakers")
	train:SetNWBool("Breakers",(train.Breakers or 1) > 0)
	train.OldKVPos = self:GetClientNumber("oldkvpos") > 0
	train.Adverts = self:GetClientNumber("adv")
	--train:SetNWInt("ARSType",train.ARSType)
	train:SetNWInt("BPSNType",train.BPSNType+1)
	--if self:GetClientNumber("kvsnd") > 0 then
	for k,v in pairs(train.SoundNames) do
		if type(v) ~= "string" then continue end
		if not k:find("kv_") then continue end
		if k:find("ezh") then continue end
		train.SoundNames[k] = string.gsub(v,"kv%d","kv"..self:GetClientNumber("kvsnd"))
		train.NewKV = self:GetClientNumber("kvsnd") > 1
		train:SetNWBool("NewKV",train.NewKV)
	end
	--else
		--for k,v in pairs(train.SoundNames) do
--			if type(v) ~= "string" then continue end
			--if not v:find("kv_") then continue end
			--if v:find("ezh") then continue end
			--train.SoundNames[k] = string.Replace(v,"subway_trains/kv","subway_trains/new/kv")
		--end
	--end
	
	if train.Horn then train.Horn:TriggerInput("NewType",self:GetClientNumber("horn")) end
	if not train:GetClass():find("81") then
		local path = Metrostroi.Skins["ezh3"][self:GetClientNumber("texture")].path
		if path == "RND" then
			path = Metrostroi.Skins["ezh3"][math.random(1,#Metrostroi.Skins["ezh3"])].path
		end
		train.Texture = path
		--ent:SetSkin(self.tbl.Paint == 1 and math.random(0,2) or self.tbl.Paint-2)
	else
		train.Pneumatic.ValveType = self:GetClientNumber("cran")
		train.Texture = Metrostroi.Skins["717"][self:GetClientNumber("texture")] and Metrostroi.Skins["717"][self:GetClientNumber("texture")].path or nil
		local path = Metrostroi.Skins["717_pass"][self:GetClientNumber("passtexture")] and Metrostroi.Skins["717_pass"][self:GetClientNumber("passtexture")].path or nil
		if path == "RND" then
			path = Metrostroi.Skins["717_pass"][math.random(1,#Metrostroi.Skins["717_pass"])].path
		end
		train.PassTexture = path
		--ent:SetSkin(self.tbl.Paint-1)
	end
	
	--Entity:SetSkin(
	--[[local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			v:SetChannel(1)
			print("Set channel 1")
		end
	end]]--
	return true
end

function TOOL:RightClick(trace)
	return true
end

local SettingTypes = {
	"Train,Texture,PassTexture,ARS,Cran,Mask,LED,BPSN,KVSnd,Horn,OldKVPos,Bort,MVM,Hand,Seat,Lamp,Breakers,Adv",
	"Train,Texture,PassTexture,ARS,Cran,Mask,LED,BPSN,KVSnd,Horn,OldKVPos,Bort,MVM,Hand,Seat,Lamp,Breakers,Adv",
	"Train",
	"Train",
	"Train,Texture,Horn",
	"Train",
}
function TOOL:UpdateConCMD()
	for k,v in pairs(self.Settings) do
		RunConsoleCommand("train_edit_"..k:lower(), v)
	end
end

function TOOL:LoadConCMD()
	self.Settings = {
		Train = 1,
		Texture = 1,
		PassTexture = 1,
		Adv = 1,
		ARS = 1,
		Cran = 1,
		Mask = 1,
		BPSN = 1,
		KVSnd = 1,
		OldKVPos = 0,
		Horn = 0,
		LED = 0,
		Horn = 0,
		Bort = 0,
		MVM = 0,
		Hand = 0,
		Seat = 0,
		Lamp = 0,
		Breakers = 0,
	}
	for k in pairs(self.Settings) do
		self.Settings[k] = GetConVarNumber("train_edit_"..k:lower())	
	end
	if self.Settings.Train > #SettingTypes then self.Settings.Train = #SettingTypes RunConsoleCommand("train_edit_train",self.Settings.Train) end
	if self.Settings.Train < 1 then self.Settings.Train = 1 RunConsoleCommand("train_edit_train",self.Settings.Train) end
end

function TOOL:CreateList(name,text,tbl,OnSelect)
	if not SettingTypes[self.Settings.Train]:find(name) then return end
	local frame = controlpanel.Get("train_edit")
	local List,ListLabel = frame:ComboBox(text)
	List:SizeToContents()
	tbl[0] = text
	for i=1,#tbl do
		List:AddChoice(tbl[i], i, self.Settings[name] == i)
	end
	local tool = self
	List.OnSelect = function(self,_, _, index)
		tool.Settings[name] = index
		tool:UpdateConCMD()
		if OnSelect then OnSelect(List,ListLabel) end
		tool.NotBuilt = true
	end
end

function TOOL:CreateCheckBox(name,text,OnSelect)
	if not SettingTypes[self.Settings.Train]:find(name) then return end
	local frame = controlpanel.Get("train_edit")
	local CB = frame:CheckBox(text)
	CB:SetValue(self.Settings[name])
	CB:SizeToContents()
	local tool = self
	function CB:OnChange()
		--tool:BuildCPanelCustom()
		tool.Settings[name] = CB:GetChecked() and 1 or 0
		tool:UpdateConCMD()
		if OnSelect then OnSelect(CB,CBLabel) end
		tool.NotBuilt = true
	end
	--frame:AddItem(CBLabel)
--	frame:AddItem(CB)
end

function TOOL:UpdateTrainList()
	--self.VGUI = {}
	local frame = controlpanel.Get("train_edit")
	self.Pos = 0
	if self.Settings.Train < 3 then
		if #Metrostroi.Skins[self.Settings.Train == 1 and "717" or "ezh3"] < self.Settings.Texture then self.Settings.Texture = 1 end
		--if IsValid(self.VGUI.Texture) then self.VGUI.Texture:Clear() end
		for k,v in pairs(Metrostroi.Skins[self.Settings.Train == 1 and "717" or "ezh3"]) do
			if not v.path:find("/16") or LocalPlayer():IsAdmin() then
				--if IsValid(self.VGUI.Texture) then self.VGUI.Texture:AddChoice(v.name, k, k == self.Settings.Texture)	 end
				--Texture[k] = v.name
			else
				if k == self.Settings.Texture then self.Settings.Texture = 1 end
				--if IsValid(self.VGUI.Texture) then self.VGUI.Texture:ChooseOptionID(1) end
			end	
		end
		for i=1,#Metrostroi.Skins[self.Settings.Train == 1 and "717" or "ezh3"] do
		end
	end
	self.NotBuilt = true
end

function TOOL:BuildCPanelCustom()
	self:LoadConCMD()
	local panel = controlpanel.Get("train_edit")
	if not panel then return end
	panel:ClearControls()
	--panel:SetPadding(0)
	--panel:SetSpacing(0)
	panel:Dock( FILL )
	local Texture = {}
--	for k,v in pairs(Metrostroi.Skins[self.Settings.Train == 1 and "717" or "ezh3"]) do
		--if not v.path:find("/16") or LocalPlayer():IsAdmin() then
--			Texture[k] = v.name
		--end
	--end
	local PassTexture = {}
	--for k,v in pairs(Metrostroi.Skins[self.Settings.Train == 1 and "717_pass" or "717_pass"]) do
		--print(v)
--		PassTexture[k] = v.name
--	end
	self:CreateList("Train","Train:",{"81-71x MVM","81-71x LVZ","E","Em","Ezh","81-703x"},function() self:UpdateTrainList() end)
--	self:CreateSlider("WagNum",0,1, GetGlobalInt("metrostroi_maxwagons"),"Wagons")
	self:CreateList("Texture","Texture",Texture)
	self:CreateList("PassTexture","PassTexture",PassTexture)
	self:CreateList("Adv","Adverts",{"Type1","Type2","Type3","No adverts"})
	self:CreateList("Cran","Cran type",{"334","013"})
	self:CreateList("ARS","ARS Type",{"Standart(square lamps)","Standart(round lamps)","Kiev/St.Petersburg"})
	self:CreateList("Mask","Mask",{"2-2","2-2-2","1-4-1 bumper 1","1-3-1","1-4-1 bumper2","1-1"})
	self:CreateList("BPSN","BPSN type",{"Normal","Old high tone","Old medium tone","Normal2(from St.Petersburg)","Normal3(from wiki)","No sound"})
	self:CreateList("Seat","Seat type",{"Old","New"})
	self:CreateList("Hand","Hand rail type",{"Old","New"})
	self:CreateList("Bort","Bort",{"Horisontal","Vertical"})
	self:CreateList("Lamp","Lamp type",{"Type1","Type2","Type3"})
	self:CreateCheckBox("Breakers","Right-syde breakers")
	self:CreateCheckBox("LED","LED")
	self:CreateList("KVSnd","KV snd",{"Dildo","Type2","Type3"})
	self:CreateCheckBox("OldKVPos","Old KV pos")
	self:CreateCheckBox("Horn","Piter horn")
	self:CreateCheckBox("MVM","MVM icon")
	--self:UpdateTrainList()
	--[[
	local Train = panel:AddControl("ComboBox", {
		Label = "ARS panel type",
		Options = {
			["Moscow/default"]	= { train_edit_ars = 0 },
			["Classic"]			= { train_edit_ars = 1 },
			["Petersburg/Kyiv"]	= { train_edit_ars = 2 },
		}
	})
	
	panel:AddControl("ComboBox", {
		Label = "ARS panel type",
		Options = {
			["Moscow/default"]	= { train_edit_ars = 0 },
			["Classic"]			= { train_edit_ars = 1 },
			["Petersburg/Kyiv"]	= { train_edit_ars = 2 },
		}
	})

	panel:AddControl("ComboBox", {
		Label = "ARS panel type",
		Options = {
			["Moscow/default"]	= { train_edit_ars = 0 },
			["Classic"]			= { train_edit_ars = 1 },
			["Petersburg/Kyiv"]	= { train_edit_ars = 2 },
		}
	})

	panel:AddControl("ComboBox", {
		Label = "Train skin",
		Options = {
			["Default (Moscow)"]	= { train_edit_skin = 0 },
			["Alternative 1"]		= { train_edit_skin = 1 },
			["Alternative 2"]		= { train_edit_skin = 2 },
		}
	})

	panel:AddControl("ComboBox", {
		Label = "Drivers valve type",
		Options = {
			["334"]	= { train_edit_valve = 0 },
			["013"]	= { train_edit_valve = 1 },
		}
	})

	panel:AddControl("ComboBox", {
		Label = "81-717 front mask type",
		Options = {
			["2-2"]	= 			{ train_edit_mask = 0 },
			["2-2-2"]	= 			{ train_edit_mask = 1},
			["1-4-1 adv1"]	= 	{ train_edit_mask = 2},
			["1-4-1 adv2"]	= 				{ train_edit_mask = 3},
			["1-4-1 adv3  bumper 2"]	= 				{ train_edit_mask = 4},
		}
	})

	panel:AddControl("ComboBox", {
		Label = "BPSN type",
		Options = {
			["Normal"] = {train_edit_bpsn = 1},
			["Old high tone"] = {train_edit_bpsn = 2},
			["Old medium tone"] = {train_edit_bpsn = 3},
			["Normal2(from St.Petersburg)"] = {train_edit_bpsn = 4},
			["Normal3(from wiki)"] = {train_edit_bpsn = 5},
			["No sound"] = {train_edit_bpsn = 6},
		}
	})

	panel:AddControl("ComboBox", {
		Label = "Horn",
		Options = {
			["Moscow"] = {train_edit_horn = 0},
			["St. Petersburg'"] = {train_edit_horn = 1},
		}
	})

	panel:AddControl("ComboBox", {
		Label = "KV Sounds",
		Options = {
			["New"] = {train_edit_oldkv = 0},
			["Old'"] = {train_edit_oldkv = 1},
		}
	})
	]]
end
TOOL.NotBuilt = true
function TOOL:Think()
	if CLIENT and (self.NotBuilt or NeedUpdate) then
		--self:SendSettings()
		self:BuildCPanelCustom()
		self.NotBuilt = nil
		NeedUpdate = nil
	end
end
function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Text = "#Tool.switch.name", Description = "#Tool.switch.desc" })
end