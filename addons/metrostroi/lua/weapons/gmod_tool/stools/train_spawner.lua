TOOL.AddToMenu = false
TOOL.ClientConVar["train"] = 1
TOOL.ClientConVar["wagnum"] = 3
TOOL.ClientConVar["lighter"] = 0
TOOL.ClientConVar["texture"] = ""
TOOL.ClientConVar["passtexture"] = ""
TOOL.ClientConVar["cabtexture"] = ""
TOOL.ClientConVar["adv"] = 1
TOOL.ClientConVar["ars"] = 1
TOOL.ClientConVar["skin"] = 1
TOOL.ClientConVar["cran"] = 1
TOOL.ClientConVar["prom"] = 1
TOOL.ClientConVar["mask"] = 1
TOOL.ClientConVar["pitermsk"] = 1
TOOL.ClientConVar["bpsn"] = 2
TOOL.ClientConVar["led"] = 0
TOOL.ClientConVar["kvsnd"] = 1
TOOL.ClientConVar["oldkvpos"] = 0
TOOL.ClientConVar["horn"] = 0
TOOL.ClientConVar["nm"] = 8.2
TOOL.ClientConVar["battery"] = 0
TOOL.ClientConVar["switches"] = 1
TOOL.ClientConVar["switchesr"] = 0
TOOL.ClientConVar["doorsl"] = 0
TOOL.ClientConVar["doorsr"] = 0
TOOL.ClientConVar["gv"] = 1
TOOL.ClientConVar["pb"] = 0
TOOL.ClientConVar["oldt"] = ""
TOOL.ClientConVar["oldw"] = ""
TOOL.ClientConVar["seat"] = 1
TOOL.ClientConVar["hand"] = 1
TOOL.ClientConVar["mvm"] = 1
TOOL.ClientConVar["bort"] = 1
TOOL.ClientConVar["lamp"] = 1
TOOL.ClientConVar["breakers"] = 0
TOOL.ClientConVar["blok"] = 1
TOOL.ClientConVar["pnm"] = 0
local Trains = {{"81-717_mvm","81-714_mvm"},{"81-717_lvz","81-714_lvz"},{"81-703","81-703_2"},{"Ema","Em"},{"Ezh3","Ema508T"},{"81-7036","81-7037"},{"em508"}}
local Switches = {	"A61","A55","A54","A56","A27","A21","A10","A53","A43","A45","A42","A41",
					"VU","A64","A63","A50","A51","A23","A14","A1","A2","A3","A17",
					"A62","A29","A5","A6","A8","A20","A25","A22","A30","A39","A44","A80"
					,"A65","A24","A32","A31","A16","A13","A12","A7","A9","A46","A47"}
if CLIENT then
	language.Add("Tool.train_spawner.name", "Train Spawner")
	language.Add("Tool.train_spawner.desc", "Spawn a train")
	language.Add("Tool.train_spawner.0", "Primary: Spawns a full train. Secondary: self.Reverse facing (yellow ed when facing the opposite side).")
	language.Add("Undone_81-7036", "Undone 81-7036 (does not work)")
	language.Add("Undone_81-7037", "Undone 81-7037 (does not work)")
	language.Add("Undone_81-717", "Undone 81-717")
	language.Add("Undone_81-714", "Undone 81-714")
	language.Add("Undone_Ezh3", "Undone Ezh3")
	language.Add("Undone_Ema508T", "Undone Em508T")
end

local function Trace(ply,tr)
	local verticaloffset = 5 -- Offset for the train model
	local distancecap = 2000 -- When to ignore hitpos and spawn at set distanace
	local pos, ang = nil
	local inhibitrerail = false

	--TODO: Make this work better for raw base ent

	if tr.Hit then
		-- Setup trace to find out of this is a track
		local tracesetup = {}
		tracesetup.start=tr.HitPos
		tracesetup.endpos=tr.HitPos+tr.HitNormal*80
		tracesetup.filter=ply

		local tracedata = util.TraceLine(tracesetup)

		if tracedata.Hit then
			-- Trackspawn
			pos = (tr.HitPos + tracedata.HitPos)/2 + Vector(0,0,verticaloffset)
			ang = tracedata.HitNormal
			ang:Rotate(Angle(0,90,0))
			ang = ang:Angle()
			-- Bit ugly because Rotate() messes with the orthogonal vector | Orthogonal? I wrote "origional?!" :V
		else
			-- Regular spawn
			if tr.HitPos:Distance(tr.StartPos) > distancecap then
				-- Spawnpos is far away, put it at distancecap instead
				pos = tr.StartPos + tr.Normal * distancecap
				inhibitrerail = true
			else
				-- Spawn is near
				pos = tr.HitPos + tr.HitNormal * verticaloffset
			end
			ang = Angle(0,tr.Normal:Angle().y,0)
		end
	else
		-- Trace didn't hit anything, spawn at distancecap
		pos = tr.StartPos + tr.Normal * distancecap
		ang = Angle(0,tr.Normal:Angle().y,0)
	end
	return {pos,ang,inhibitrerail}
end

function TOOL:GetCurrentModel(trNum,head,pr)
	if trNum == 1 or trNum == 2 then
		if not pr then
			return "models/metrostroi_train/81/81-717.mdl"
		else
			return "models/metrostroi/81/81-714.mdl"
		end
	elseif trNum == 3 then
			return "models/metrostroi_train/81-703/81-703_2.mdl"
	elseif trNum == 4 then
			return "models/metrostroi_train/em/em.mdl"
	elseif trNum == 5 then
			return "models/metrostroi/e/"..(pr and "ema508t" or "em508")..".mdl"
	--else
		--return "models/metrostroi/81/81-703"..(pr and 6 or 7)..".mdl"
	elseif trNum == 7 then
			return "models/metrostroi_train/81-508/81-508.mdl"
	end
	
end

function TOOL:GetConvar()
	local tbl = {}
	tbl.Train = self:GetClientNumber("train")
	tbl.WagNum = self:GetClientNumber("wagnum")
	tbl.Texture = self:GetClientInfo("texture")
	tbl.PassTexture = self:GetClientInfo("passtexture")
	tbl.CabTexture = self:GetClientInfo("cabtexture")
	tbl.Adv = self:GetClientNumber("adv")
	tbl.ARS = self:GetClientNumber("ars")
	tbl.Skin = self:GetClientNumber("skin")
	tbl.Cran = self:GetClientNumber("cran")
	tbl.Prom = self:GetClientNumber("prom")
	tbl.Mask = self:GetClientNumber("mask")
	tbl.PiterMsk = self:GetClientNumber("pitermsk")
	tbl.LED = self:GetClientNumber("led")
	tbl.Horn = self:GetClientNumber("horn")
	tbl.KVSnd = math.max(1,self:GetClientNumber("kvsnd"))
	tbl.OldKVPos = self:GetClientNumber("oldkvpos")
	tbl.BPSN = self:GetClientNumber("bpsn")
	tbl.NM = self:GetClientNumber("nm")
	tbl.Battery = self:GetClientNumber("battery")
	tbl.Lighter = self:GetClientNumber("lighter")
	tbl.Switches = self:GetClientNumber("switches")
	tbl.SwitchesR = self:GetClientNumber("switchesr")
	tbl.DoorsL = self:GetClientNumber("doorsl")
	tbl.DoorsR = self:GetClientNumber("doorsr")
	tbl.GV = self:GetClientNumber("gv")
	tbl.PB = self:GetClientNumber("pb")
	tbl.Bort = self:GetClientNumber("bort")
	tbl.MVM = self:GetClientNumber("mvm")
	tbl.Hand = self:GetClientNumber("hand")
	tbl.Seat = self:GetClientNumber("seat")
	tbl.Lamp = self:GetClientNumber("lamp")
	tbl.Breakers = self:GetClientNumber("breakers")
	tbl.Blok = self:GetClientNumber("blok")
	tbl.PNM = self:GetClientNumber("pnm")
	return tbl
end

local CLpos,CLang = Vector(0,0,0),Angle(0,0,0)

function UpdateGhostPos(pl)
	local trace = util.TraceLine(util.GetPlayerTrace(pl))

	local tbl =  Metrostroi.RerailGetTrackData(trace.HitPos,pl:GetAimVector())

	if not tbl then tbl = Trace(pl, trace) end

	local pos,ang = Vector(0,0,0),Angle(0,0,0)
	if tbl[3] ~= nil then
		pos = tbl[1]+Vector(0,0,55)
		ang = tbl[2]
	else
		pos = tbl.centerpos + Vector(0,0,112)
		ang = tbl.right:Angle()+Angle(0,90,0)
	end
	return pos,ang
end


function TOOL:UpdateGhost(pl, ent)
	local pos,ang
	if SERVER then
		pos, ang = UpdateGhostPos(pl)
		self:GetOwner():SetNW2Vector("metrostroi_train_spawner_pos",pos)
		self:GetOwner():SetNW2Angle("metrostroi_train_spawner_angle",ang + Angle(0,self.Rev and 180 or 0,0))
	else
		pos, ang = self:GetOwner():GetNW2Vector("metrostroi_train_spawner_pos"), self:GetOwner():GetNW2Angle("metrostroi_train_spawner_angle")
	end
	if not ent then return end
	if self.tbl.Train == 4 then
	--
		local path = Metrostroi.Skins["ezh3"][self.tbl.Texture].path
		if path == "RND" then path = Metrostroi.Skins["ezh3"][math.random(1,#Metrostroi.Skins["ezh3"])].path end
		for k,v in pairs(ent:GetMaterials()) do
			if v:find("ewagon") then
				ent:SetSubMaterial(k-1,path)
			else
				ent:SetSubMaterial(k-1,"")
			end
		end
		
	else
		--ent:SetSkin(self.tbl.Paint == 1 and math.random(0,2) or self.tbl.Paint-2)
		ent:SetBodygroup(1,(self.tbl.ARS or 1)-1)
		ent:SetBodygroup(2,(self.tbl.Lamp or 1)-1)
		ent:SetBodygroup(3,(self.tbl.Mask or 1)-1)
		ent:SetBodygroup(4,(self.tbl.Seat or 1)-1)
		ent:SetBodygroup(5,(self.tbl.Hand or 1)-1)
		ent:SetBodygroup(6,(self.tbl.MVM > 0 and ((self.tbl.Mask > 2 and self.tbl.Mask ~= 6) and 1 or 0) or 2))
		ent:SetBodygroup(7,(self.tbl.Bort or 1)-1)
		ent:SetBodygroup(9,(self.tbl.Breakers or 0))
		ent:SetBodygroup(14,self.tbl.ARS == 3 and 1 or 0)
		--[[
		for k,v in pairs(ent:GetMaterials()) do
			if v == "models/metrostroi_train/81/b01a" then
				ent:SetSubMaterial(k-1,Metrostroi.Skins["717"][self.tbl.Texture].path)
			elseif v == "models/metrostroi_train/81/int01" then
				local path = Metrostroi.Skins["717_pass"][self.tbl.PassTexture].path
				if path == "RND" then path = Metrostroi.Skins["717_pass"][math.random(1,#Metrostroi.Skins["717_pass"])].path end
				ent:SetSubMaterial(k-1,path)
			else
				ent:SetSubMaterial(k-1,"")
			end
		end
		]]
		--ent:SetSkin(self.tbl.Paint-1)
	end
	ent:SetColor(self.Rev and Color(255	,255,0) or Color(255,255,255))
	ent:SetPos(pos)
	ent:SetAngles(ang + Angle(0,self.Rev and 180 or 0,0))
end

local owner
function TOOL:Think()
	owner = self:GetOwner()
	self.tbl = self:GetConvar()
	self.int = self.tbl.Prom > 0 or !Trains[self.tbl.Train][1]:find("Ezh")
	if not self.Spawned then
		if (!IsValid(self.GhostEntity) or self.GhostEntity:GetModel() ~= self:GetCurrentModel(self.tbl.Train)) then
			self:MakeGhostEntity(self:GetCurrentModel(self.tbl.Train), Vector( 0, 0, 0 ), Angle( 0, 0, 0 ))
		end
		self:UpdateGhost(self:GetOwner(), self.GhostEntity)
	end
	---if SERVER then self.Rev = self.Rev end
end

local function SendCodeToCL()
	local pos,ang = UpdateGhostPos(owner)
	net.Start("metrostroi_train_spawner_ghost")
		net.WriteVector(pos)
		net.WriteAngle(ang)
		net.WriteBit(self.Rev)
	net.Send(owner)
end

function TOOL:Spawn(ply, tr, clname, i)
	local rot = false
	if i > 1 then
		rot = i == self.tbl.WagNum and true or math.random() > 0.5
	end
	local pos,ang = Vector(0,0,0),Angle(0,0,0)
	if i == 1 then
		local tbl = Trace(ply, tr)
		pos = tbl[1]
		ang = tbl[2]
		rerail = tbl[3]
	else
		local dir = self.fent:GetAngles():Forward() * -1
		local add = clname:find("714")
		local wagheg = math.abs(self.oldent:OBBMaxs().x - self.oldent:OBBMins().x)+ 30 + ((rot or self.Rev) and 30 or 0)
		pos = self.oldent:GetPos() + dir*wagheg - Vector(0,0,140)
		ang = self.fent:GetAngles() + Angle(0,rot and 180 or 0,0)
	end
	local ent = ents.Create(clname)
	ent:SetPos(pos)
	ent:SetAngles(ang + Angle(0,(self.Rev and !rot) and 180 or 0,0))
	ent.Owner = ply
	ent:Spawn()
	ent:Activate()
	if IsValid(ent) then
		Metrostroi.RerailTrain(ent)
	end
	self.rot = rot
	return ent
end
function TOOL:SetSettings(ent, ply, i,inth)
	local rot = false
	if i > 1 then
		rot = i == self.tbl.WagNum and true or math.random() > 0.5
	end
	undo.Create(Trains[self.tbl.Train][i>1 and i<self.tbl.WagNum and self.int and 2 or 1])
		undo.AddEntity(ent)
		undo.SetPlayer(ply)
	undo.Finish()
	if ent.SubwayTrain.Name ~= "81-7036" then
		if ent.SubwayTrain.Type == "81" then
			--ent:SetSkin(self.tbl.Paint-1)
			if ent.SubwayTrain.Manufacturer == "MVM" then
				ent.ARSType = self.tbl.ARS
				ent.MaskType = self.tbl.Mask
				ent:SetNW2Int("ARSType", ent.ARSType)
			else
				ent.Blok = self.tbl.Blok
				ent.MaskType = self.tbl.PiterMsk
			end
			ent.Pneumatic.ValveType = self.tbl.Cran
		end
		ent.Pneumatic.TrainLinePressure = self.tbl.NM
		ent.BPSNType = self.tbl.BPSN+1
		ent:SetNW2Int("BPSNType",ent.BPSNType)
		for k,v in pairs(Switches) do
			if (i == 1 or i == self.tbl.WagNum or !self.int) and v ~= "A5"  then ent:TriggerInput(v.."Set", self.tbl.Switches > 0 and (math.random() > math.random(0.1,0.4) or self.tbl.SwitchesR == 0)) end
		end
		local rot = (self.fent:GetAngles().yaw - ent:GetAngles().yaw) ~= 0
		--local rot =
		--print
		local DoorsL = self.tbl.DoorsL
		local DoorsR = self.tbl.DoorsR
		for I=1,4 do
			ent.Pneumatic.LeftDoorState[I] = ((DoorsL > 0 and !rot) or (DoorsR > 0 and rot)) and 1 or 0
			ent.Pneumatic.RightDoorState[I] = ((DoorsL > 0 and rot) or (DoorsR > 0 and !rot)) and 1 or 0
		end
		if i > 1 and i < self.tbl.WagNum then
			ent.Pneumatic.UAVA = true
			--ent.UAVA:TriggerInput("Set",1)
			--ent:TriggerInput("A5Set",1)
		else
			--ent:TriggerInput("A5Set",0)
		end
		ent.Lighter = self.tbl.Lighter
		ent.LampType = self.tbl.Lamp
		ent.SeatType = self.tbl.Seat
		ent.HandRail = self.tbl.Hand
		ent.Adverts = self.tbl.Adv
		ent.MVM = self.tbl.MVM > 0
		ent.BortLampType = self.tbl.Bort
		ent.LED = self.tbl.LED > 0
		ent.Breakers= self.tbl.Breakers
		ent.PNM= self.tbl.PNM > 0
		ent:SetNW2Bool("Breakers",(ent.Breakers or 1) > 0)
		ent:TriggerInput("VBSet", self.tbl.Battery)
		ent:TriggerInput("GVSet", self.tbl.GV)
		ent:TriggerInput("ParkingBrakeSet", self.tbl.PB)
		ent:TriggerInput("ParkingBrakeSignSet", self.tbl.PB)
		for k,v in pairs(ent.SoundNames) do
			if type(v) ~= "string" then continue end
			if not k:find("kv_") then continue end
			if k:find("ezh") then continue end
			ent.SoundNames[k] = string.gsub(v,"kv%d","kv"..self:GetClientNumber("kvsnd"))
			ent.KVSnd = self:GetClientNumber("kvsnd")
			ent.NewKV = self:GetClientNumber("kvsnd") > 1
			ent:SetNW2Bool("NewKV",ent.NewKV)
		end
		ent.OldKVPos = self.tbl.OldKVPos > 0
		if ent.Horn then ent.Horn:TriggerInput("NewType",self.tbl.Horn) end
		if ent.A45 then
			ent.A45:TriggerInput("Set",0)
			--ent.A5:TriggerInput("Block",0)
			--ent.A5:TriggerInput("Set",0)
			--ent.A5:TriggerInput("Block",1)
		end
		if inth and ent.UAVA  then
			ent.UAVA:TriggerInput("Set",1)
			if ent.VU and (not self.Plombs or not self.Plombs.VU) then
				ent.VU:TriggerInput("Set",0)
				ent.VU:TriggerInput("Block",1)
			end
		end
	end

	if ent.UpdateTextures then 
		local tex = Metrostroi.Skins["train"][self.tbl.Texture]
		local ptex = Metrostroi.Skins["pass"][self.tbl.PassTexture]
		local ctex = Metrostroi.Skins["cab"][self.tbl.CabTexture]
		if tex and (ent:GetClass() == "gmod_subway_"..tex.typ  or Metrostroi.NameConverter[tex.typ] and ent:GetClass()  == "gmod_subway_"..Metrostroi.NameConverter[tex.typ]) then print("1tex.typ")
			ent.Texture = self.tbl.Texture  
		end
		if ptex and (ent:GetClass() == "gmod_subway_"..ptex.typ  or Metrostroi.NameConverter[ptex.typ] and ent:GetClass()  == "gmod_subway_"..Metrostroi.NameConverter[ptex.typ]) then
			ent.PassTexture = self.tbl.PassTexture
		end
		if ctex and (ent:GetClass() == "gmod_subway_"..ctex.typ  or Metrostroi.NameConverter[ctex.typ] and ent:GetClass()  == "gmod_subway_"..Metrostroi.NameConverter[ctex.typ]) then
			ent.CabTexture = self.tbl.CabTexture
		end

		ent:SetNW2String("NW2Fix",string.rep(" ",math.random()*5))
		ent:UpdateTextures()
	end
end

function TOOL:SpawnWagon(trace)
	if CLIENT then return end
	local ply = self:GetOwner()
	self.oldent = NULL
	local FIXFIXFIX = {}
	for i=1,math.random(12) do
		FIXFIXFIX[i] = ents.Create("env_sprite")
	end
	for i=1,self.tbl.WagNum do
		local ent = self:Spawn(ply, trace, "gmod_subway_"..Trains[self.tbl.Train][i>1 and i<self.tbl.WagNum and self.int and 2 or 1]:lower(), i)
		self.fent = i == 1 and ent or self.fent
		if ent and ent:IsValid() then
			self:SetSettings(ent,ply,i,i>1 and i<self.tbl.WagNum)
		end
		self.oldent = ent
	end
	self.rot = false
	for k,v in pairs(FIXFIXFIX) do SafeRemoveEntity(v) end
end

function TOOL:Finish()
	if not self then return end
	if IsValid(self.GhostEntity) then
		self.GhostEntity:Remove()
	end
	self.Spawned = false
	if SERVER then
		self:GetOwner():SelectWeapon(self:GetClientInfo("oldW"))
	else
		RunConsoleCommand("gmod_toolmode", self:GetClientInfo("oldT"))
	end
end

function TOOL:LeftClick(trace)
	self.Spawned = true
	--[[
	if CLIENT then
		[
		timer.Simple(0.5,
			function()
				if self.GhostEntity then
					RunConsoleCommand("gmod_toolmode", self:GetClientInfo("oldT"))
					self.GhostEntity:Remove()
				end
			end
		)]
		return true
	end
	]]
	--timer.Create(0.5, function() if self.GhostEntity then self.GhostEntity:Remove() end)
	if SERVER then
		if self.tbl.WagNum > GetConVarNumber("metrostroi_maxwagons") then
			self.tbl.WagNum = GetConVarNumber("metrostroi_maxwagons")
		end
		if Metrostroi.TrainCountOnPlayer(self:GetOwner()) + self.tbl.WagNum > GetConVarNumber("metrostroi_maxtrains_onplayer")*GetConVarNumber("metrostroi_maxwagons")
			or Metrostroi.TrainCount() + self.tbl.WagNum > GetConVarNumber("metrostroi_maxtrains")*GetConVarNumber("metrostroi_maxwagons") then
			Metrostroi.LimitMessage(self:GetOwner())
			return true
		end
	end
	self:SpawnWagon(trace)
	timer.Simple(0,function()
		self:Finish()
	end)
	return
end

function TOOL:RightClick(trace)
	if CLIENT then return end
	self.Rev = not self.Rev
	--SendCodeToCL()
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Text = "#Tool.train_spawner.name", Description = "#Tool.train_spawner.desc" })
end

if SERVER then
	--util.AddNetworkString "metrostroi_train_spawner_ghost"
	--[[
	timer.Create("metrostroi_train_spawner_ghost",0.3,0,
		function()
			if owner and IsValid(owner) then
				SendCodeToCL()
			end
		end
	)]]
	return
end
--[[
function TOOL:Think()
	self.tbl = self:GetConvar()
	if (!IsValid(self.GhostEntity) or self.GhostEntity:GetModel() ~= self:GetCurrentModel(self.tbl.Train,self.tbl.Mask)) then
		self:MakeGhostEntity(self:GetCurrentModel(self.tbl.Train,self.tbl.Mask), Vector( 0, 0, 0 ), Angle( 0, 0, 0 ))
	end
	if not self.GhostEntity then return end
	self.GhostEntity:SetPos(pos)
	self.GhostEntity:SetAngles(ang)
end]]
local function CLGhost()
	CLpos = net.ReadVector()
	CLang = net.ReadAngle()
	self.Rev = net.ReadBit() > 0
end
--net.Receive("metrostroi_train_spawner_ghost",CLGhost)
