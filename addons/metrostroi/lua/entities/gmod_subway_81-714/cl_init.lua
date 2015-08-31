include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(460.0,-45.0,-50.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-483.0,45.0,-50.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-180,68.5,-50),
	ang = Angle(0,180,90),
	width = 80,
	height = 40,
	scale = 0.1,
}

-- Battery panel
ENT.ButtonMap["Battery"] = {
	pos = Vector(445.0,4,59.0),
	ang = Angle(0,-90,90),
	width = 100,
	height = 100,
	scale = 0.08,
	
	buttons = {
		{ID = "VBToggle", x=0, y=0, w=100, h=100, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
	}
}

-- AV panel
ENT.ButtonMap["AV_Left"] = {
	pos = Vector(449.0,50.0,-3.0),
	ang = Angle(0,-82,90),
	width = 460,
	height = 340,
	scale = 0.0625,
	
	buttons = {
		{ID = "A65Toggle", x=180+35*1,  y=260, radius=30, tooltip="A65 Interior lighting"},
		{ID = "A56Toggle", x=180+35*2,  y=260, radius=30, tooltip="A56 Включение аккумуляторной батареи\nTurn on battery power to control circuits"},
		{ID = "A63Toggle", x=180+35*3,  y=260, radius=30, tooltip="A63 IGLA/BIS"},
		{ID = "A10Toggle", x=180+35*4,  y=260, radius=30, tooltip="A10 Motor-compressor control"},
		{ID = "A30Toggle", x=180+35*5,  y=260, radius=30, tooltip="A30 Rheostat controller motor power"},
		{ID = "A80Toggle", x=180+35*6,  y=260, radius=30, tooltip="A80 Power circuit mode switch motor power"},
	}
}

-- AV panel
ENT.ButtonMap["AV_Right"] = {
	pos = Vector(453.0,-21.0,-3),
	ang = Angle(0,-98,90),
	width = 460,
	height = 340,
	scale = 0.0625,
	
	buttons = {
		{ID = "A54Toggle", x=120+35*0,  y=60+100*0, radius=30, tooltip="A54 Управление проводом 10АК\nTrain wire 10AK control"},
		{ID = "A27Toggle", x=120+35*1,  y=60+100*0, radius=30, tooltip="A27 Turn on DIP and lighting"},
		{ID = "A24Toggle", x=120+35*2,  y=60+100*0, radius=30, tooltip="A24 Battery charging"},
		{ID = "A53Toggle", x=120+35*3,  y=60+100*0, radius=30, tooltip="A53 KVC power supply"},
		{ID = "A13Toggle", x=120+35*4,  y=60+100*0, radius=30, tooltip="A13 Door alarm"},
		{ID = "A32Toggle", x=120+35*5,  y=60+100*0, radius=30, tooltip="A32 Open right doors"},
		{ID = "A31Toggle", x=120+35*6,  y=60+100*0, radius=30, tooltip="A31 Open left doors"},
		{ID = "A16Toggle", x=120+35*7,  y=60+100*0, radius=30, tooltip="A16 Close doors"},
		{ID = "A12Toggle", x=120+35*8,  y=60+100*0, radius=30, tooltip="A12 Emergency door close"},
		------------------------------------------------------------------------
		{ID = "A50Toggle", x=120+35*0,  y=60+100*1, radius=30, tooltip="A50 Turn on DIP and lighting"},
		{ID = "A51Toggle", x=120+35*1,  y=60+100*1, radius=30, tooltip="A51 Turn off DIP and lighting"},
		{ID = "A1Toggle",  x=120+35*2,  y=60+100*1, radius=30, tooltip="A1  XOD-1"},
		-- None
		-- None
		-- None
		{ID = "A2Toggle",  x=120+35*6,  y=60+100*1, radius=30, tooltip="A2  XOD-2"},
		{ID = "A3Toggle",  x=120+35*7,  y=60+100*1, radius=30, tooltip="A3  XOD-3"},
		{ID = "A17Toggle", x=120+35*8,  y=60+100*1, radius=30, tooltip="A17 Reset overload relay"},
		------------------------------------------------------------------------
		{ID = "A5Toggle",  x=120+35*0,  y=60+100*2, radius=30, tooltip="A5  "},
		{ID = "A6Toggle",  x=120+35*1,  y=60+100*2, radius=30, tooltip="A6  T-1"},
		{ID = "A8Toggle",  x=120+35*2,  y=60+100*2, radius=30, tooltip="A8  Pneumatic valves #1, #2"},
		{ID = "A20Toggle", x=120+35*3,  y=60+100*2, radius=30, tooltip="A20 Drive/brake circuit control, train wire 20"},
		{ID = "A25Toggle", x=120+35*4,  y=60+100*2, radius=30, tooltip="A25 Manual electric braking"},
		{ID = "A22Toggle", x=120+35*5,  y=60+100*2, radius=30, tooltip="A22 Turn on KK"},
		{ID = "A23Toggle", x=120+35*6,  y=60+100*2, radius=30, tooltip="A23 Emergency motor-compressor turn on"},
		{ID = "A39Toggle", x=120+35*7,  y=60+100*2, radius=30, tooltip="A39 Emergency control"},
		{ID = "A14Toggle", x=120+35*8,  y=60+100*2, radius=30, tooltip="A14 Train wire 18"},
	}
}

-- Everything else panel
ENT.ButtonMap["Main"] = {
	pos = Vector(453.0,-21.0,-3),
	ang = Angle(0,-98,90),
	width = 460,
	height = 340,
	scale = 0.0625,
	
	buttons = {
		{ID = "KRPSet",			x=230+45*0, y=115+45*0, radius=20, tooltip="ПУСК: Кнопка пуска\nSTART: Start button"},
		{ID = "VozvratRPSet",	x=230+45*1, y=115+45*0, radius=20, tooltip="Возврат реле перегрузки\nReset overload relay"},
		{ID = "RezMKSet",		x=230+45*0, y=115+45*1, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		{ID = "VMKToggle",		x=230+45*0, y=115+45*2, radius=20, tooltip="Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "BPSNonToggle",	x=230+45*1, y=115+45*2, radius=20, tooltip="БПСН: Блок питания собственных нужд\nBPSN: Train power supply"},
	}
}

-- Wagon numbers
ENT.ButtonMap["TrainNumber1"] = {
	pos = Vector(30,-67.6,-11.5),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(30+28,67.7,-11.5),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

ENT.ButtonMap["FrontDoor"] = {
	pos = Vector(455,16,48.4),
	ang = Angle(0,-90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="Передняя дверь\nFront door"},
	}
}

ENT.ButtonMap["RearDoor"] = {
	pos = Vector(-480,16,48.4),
	ang = Angle(0,-90,90),
	width = 642,
	height = 1900,
	scale = 0.1/2,
	buttons = {
		{ID = "RearDoor",x=0,y=0,w=642,h=1900, tooltip="Передняя дверь\nFront door"},
	}
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake013"] = {
	model = "models/metrostroi/81-717/brake.mdl",
	pos = Vector(453.0,25.9,-6),
	ang = Angle(0,-90,20)
}
ENT.ClientProps["brake334"] = {
	model = "models/metrostroi/81-717/brake334.mdl",
	pos = Vector(453.5,25.9,-7),
	ang = Angle(0,-90,20)
}
ENT.ClientProps["brake334_body"] = {
	model = "models/metrostroi/81-717/brake334_body.mdl",
	pos = Vector(453.5,30,-10),
	ang = Angle(0,98,-20)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(449.5,42,-20),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.10,-14.4,58),
	ang = Angle(90,0,180)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi/81-717/red_arrow.mdl",
	pos = Vector(447.00,-14.4,58),
	ang = Angle(90,0,180)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos =Vector(447.10,-18.8,57.9),
	ang = Angle(90,0,180)
}

ENT.ClientProps["pmp"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(449.6,43,-12),
	ang = Angle(90,-90+8,90)
}
ENT.ClientProps["pmp_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(449.6,43,-12),
	ang = Angle(135,98,0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,11.0,57.3),
	ang = Angle(90,0,180)
}
ENT.ClientProps["voltmeter"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,15.5,57.3),
	ang = Angle(90,0,180)
}
ENT.ClientProps["volt1"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(447.00,-9.4,57.9),
	ang = Angle(90,0,180)
}
--------------------------------------------------------------------------------
ENT.ClientProps["battery"] = {
	model = "models/metrostroi/81-717/switch01.mdl",
	pos = Vector(446.0,0.0,55),
	ang = Angle(90,0,180)
}
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(154,62.5+1.5,-65),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(154,62.5+1.5,-65),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
local function addAV(i,panel,av)
	Metrostroi.ClientPropForButton("a"..i,{
		panel = panel,
		button = "A"..av.."Toggle",	
		model = "models/metrostroi/81-717/circuit_breaker.mdl",
	})
end

-- Map of switches
local AVMap = {
	61,55,54,56,27,21,10,53,43,45,42,41,
	"VU",64,63,50,51,23,14,75, 1, 2, 3,17,
	62,29, 5, 6, 8,20,25,22,30,39,44,80,
	65, 0,24,32,31,16,13,12, 7, 9,46,47
}
local AVInverseMap = {}
for k,v in pairs(AVMap) do AVInverseMap[v] = k-1 end

-- Add actual models
for k,v in pairs(ENT.ButtonMap["AV_Right"].buttons) do
	local av = tonumber(string.sub(v.ID,2,(string.find(v.ID,"Toggle") or 1)-1)) or "VU"
	addAV(AVInverseMap[av],"AV_Right",av)
end
for k,v in pairs(ENT.ButtonMap["AV_Left"].buttons) do
	local av = tonumber(string.sub(v.ID,2,(string.find(v.ID,"Toggle") or 1)-1)) or "VU"
	addAV(AVInverseMap[av],"AV_Left",av)
end

--------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("KRP",{
	panel = "Main",
	button = "KRPSet",
	model = "models/metrostroi/81-717/button05.mdl"
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi/81-717/button02.mdl"
})
Metrostroi.ClientPropForButton("RezMK",{
	panel = "Main",
	button = "RezMKSet",
	model = "models/metrostroi/81-717/button02.mdl"
})
Metrostroi.ClientPropForButton("VMK",{
	panel = "Main",
	button = "VMKToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("BPSNon",{
	panel = "Main",
	button = "BPSNonToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})

--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0 
	then return Vector(351.0 - 34*k     - 231*i,-65*(1-2*k),-2.8)
	else return Vector(351.0 - 34*(1-k) - 231*i,-65*(1-2*k),-2.8)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi/81/81-717_door3.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi/81/81-717_door4.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,180*k,0)
		}
	end
end
ENT.ClientProps["door1"] = {
	model = "models/metrostroi/81/81-717_door2.mdl",
	pos = Vector(455.5,0.5,-7.5),
	ang = Angle(0,180,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi/81/81-717_door2.mdl",
	pos = Vector(-479.5,0.0,-7.5),
	ang = Angle(0,0,0)
}

ENT.RearDoor = 0
ENT.FrontDoor = 0
--------------------------------------------------------------------------------
function ENT:Think()
	if not self.Animate then self.BaseClass = baseclass.Get("gmod_subway_base") end
	if self.RearDoor < 90 and self:GetPackedBool(156) or self.RearDoor > 0 and not self:GetPackedBool(156) then
		self.RearDoor = math.max(0,math.min(90,self.RearDoor + (self:GetPackedBool(156)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door2",Vector(0,16,0),Angle(0,self.RearDoor,0))
	end
	if not self.ClientPropsMatrix["door2"] or self.ClientPropsMatrix["door2"]:GetAngles().yaw ~= self.RearDoor then
		self:ApplyMatrix("door2",Vector(0,-16,0),Angle(0,self.RearDoor,0))
	end
	if self.FrontDoor < 90 and self:GetPackedBool(157) or self.FrontDoor > 0 and not self:GetPackedBool(157) then
		self.FrontDoor = math.max(0,math.min(90,self.FrontDoor + (self:GetPackedBool(157)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door1",Vector(0,16,0),Angle(0,self.FrontDoor,0))
	end
	if not self.ClientPropsMatrix["door1"] or self.ClientPropsMatrix["door1"]:GetAngles().yaw ~= self.FrontDoor then
		self:ApplyMatrix("door1",Vector(0,-16,0),Angle(0,self.FrontDoor,0))
	end
	self.BaseClass.Think(self)
	
	-- Distance cull
	local distance = self:GetPos():Distance(LocalPlayer():GetPos())
	if distance > 8192 then return end
	
	local transient = (self.Transient or 0)*0.05
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end
	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake334", 		1-self:GetPackedRatio(0), 			0.00, 0.50,  256,24)
	self:Animate("pmp_wrench",		self:GetPackedRatio(2),				0.40, 0.75,  4,false)
	--self:Animate("brake013", 		self:GetPackedRatio(0)^0.5,			0.00, 0.65,  256,24)
	self:Animate("brake013",		self:GetPackedRatio(0),				0.30, 0.90,  256,24)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.38,0.64)
	
	self:ShowHide("pmp_wrench",		self:GetPackedBool(0))
	self:ShowHide("brake013",		self:GetPackedBool(22))
	self:ShowHide("brake334",		not self:GetPackedBool(22))
	
	self:Animate("brake_line",		self:GetPackedRatio(4),				0.16, 0.84,  256,2)--,,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5),				0.16, 0.84,  256,2)--,,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.17, 0.86,  256,2)--,,0.03)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.38, 0.63)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.38, 0.63)
	--self:Animate("volt2",			0, 									0.38, 0.63)
	
	self:Animate("VozvratRP",		self:GetPackedBool(2) and 1 or 0, 	0,1, 16, false)
	self:Animate("brake_disconnect",self:GetPackedBool(6) and 1 or 0, 	0,0.7, 3, false)
	self:Animate("battery",			self:GetPackedBool(7) and 1 or 0, 	0,1, 16, false)
	self:Animate("RezMK",			self:GetPackedBool(8) and 1 or 0, 	0,1, 16, false)
	self:Animate("VMK",				self:GetPackedBool(9) and 1 or 0, 	0,1, 16, false)
	self:Animate("KRP",				self:GetPackedBool(113) and 1 or 0, 0,1, 16, false)	
	self:Animate("BPSNon",			self:GetPackedBool(59) and 1 or 0, 	0,1, 16, false)
	
	-- Animate AV switches
	for i,v in ipairs(self.Panel.AVMap) do
		local value = self:GetPackedBool(64+(i-1)) and 1 or 0
		self:Animate("a"..(i-1),value,0,1,8,false)
	end	
	
	-- Main switch
	if self.LastValue ~= self:GetPackedBool(5) then
		self.ResetTime = CurTime()+1.5
		self.LastValue = self:GetPackedBool(5)
	end	
	self:Animate("gv_wrench",	(self:GetPackedBool(5) and 1 or 0), 	0,0.51, 128,  1,false)
	self:ShowHide("gv_wrench",	CurTime() < self.ResetTime)
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 5.0 and self:GetNWString("texture",nil) then
		--print(1)
		self.TextureTime = CurTime()
		for tex,ent in pairs(self.ClientEnts) do
			if tex:find("door") then
				for k,v in pairs(ent:GetMaterials()) do
					if v:sub(-10,-1) == "81-717_003" or v:sub(-10,-1) == "81-717_002" or v:sub(-10,-1) == "81-717_006" then
						ent:SetSubMaterial(k-1,self:GetNWString("texture"))
					else
						ent:SetSubMaterial(k-1,"")
					end
				end
			end
		end
	end
	
	-- Animate doors
	--[[for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			local animation = self:Animate(n_l,self:GetPackedBool(21+i+4-k*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] then
				self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
				self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end
		end
	end]]--
	for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			local animation = self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			local offset_l = Vector(math.abs(31*animation),0,0)
			local offset_r = Vector(math.abs(32*animation),0,0)
			if self.ClientEnts[n_l] then
				self.ClientEnts[n_l]:SetPos(self:LocalToWorld(self.ClientProps[n_l].pos + (1.0 - 2.0*k)*offset_l))
				self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end
		end
	end
	if self.ClientEnts["door1"] then self.ClientEnts["door1"]:SetSkin(self:GetSkin()) end
	if self.ClientEnts["door2"] then self.ClientEnts["door2"]:SetSkin(self:GetSkin()) end

	-- Brake-related sounds
	local brakeLinedPdT = self:GetPackedRatio(9)
	local dT = self.DeltaTime
	self.BrakeLineRamp1 = self.BrakeLineRamp1 or 0

	if (brakeLinedPdT > -0.001)
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*((-0.4*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self:SetSoundState("release2_w",self.BrakeLineRamp1*0.75,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0.02*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self:SetSoundState("release3_w",self.BrakeLineRamp2,1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if not state then
			self:PlayOnce("compressor_end",nil,0.75)		
		end
	end
	self:SetSoundState("compressor",state and 1 or 0,1,nil,0.75)
	
	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	local state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self.PreviousRKState = self.PreviousRKState or false
	if self.PreviousRKState ~= state then
		self.PreviousRKState = state
		if state then
			self:SetSoundState("rk_spin",0.15,1)
		else
			self:SetSoundState("rk_spin",0,0)
			self:PlayOnce("rk_stop",nil,0.67)		
		end
	end
	
	-- DIP sound
	self.BPSNType = self:GetNWInt("BPSNType",6)
	if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
	if self.BPSNType ~= self.OldBPSNType then
		self:SetSoundState("bpsn"..self.OldBPSNType,0,1.0)
	end
	self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool(52) and 2 or 0,1.0,nil,0.9)
	self.OldBPSNType = self.BPSNType
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end

function ENT:DrawPost()
	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNWBool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNWBool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
		draw.DrawText(self:GetPackedBool(160) and "Brake" or "Released","Trebuchet24",950,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNWBool("RbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNWBool("RtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNWBool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AV_Left",function()
		draw.DrawText("ВП","Trebuchet24",180,100,Color(0,0,0,255))
		draw.DrawText("НАЗ","Trebuchet24",80,55,Color(0,0,0,255))
		draw.DrawText("0","Trebuchet24",150,55,Color(0,0,0,255))
	end)
	
	-- Draw train numbers
	local dc = render.GetLightColor(self:GetPos())
	self:DrawOnPanel("TrainNumber1",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	self:DrawOnPanel("TrainNumber2",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
end
