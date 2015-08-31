AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--------------------------------------------------------------------------------
function ENT:Initialize()
	if self.FrontBogey then
		
	--DISTANCES
	--0.774
	--WHEELS:81 2.05 --2.66
	--TRAIN:755 19.17 24.79
	--89 2.26 2.92
	--171 4.34 5.61
	--584 14.83 19.17
	--666 16.91 21.84
end
	-- Defined train information
	self.SubwayTrain = {
		Type = "81",
		Name = "81-714",
	}

	-- Set model and initialize
	self:SetModel("models/metrostroi/81/81-714.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))
	
	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(415,0,-48+2.5),Angle(0,90,0),"models/vehicles/prisoner_pod_inner.mdl")
	--self.InstructorsSeat = self:CreateSeat("instructor",Vector(430,47,-27+2.5),Angle(0,-90,0))

	-- Hide seats
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	--self.InstructorsSeat:SetColor(Color(0,0,0,0))
	--self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)

	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 325-20,0,-80),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-325-10,0,-80),Angle(0,0,0),false)
	
	-- Initialize key mapping
	self.KeyMap = {
		[KEY_8] = "KRPSet",
		[KEY_G] = "VozvratRPSet",
	
		[KEY_0] = "PMPUp",
		[KEY_9] = "PMPDown",
		[KEY_F] = "PneumaticBrakeUp",
		[KEY_R] = "PneumaticBrakeDown",
		
		[KEY_LSHIFT] = {
			[KEY_L] = "DriverValveDisconnectToggle",
			
			--[KEY_7] = "KVWrenchNone",
			--[KEY_8] = "KVWrenchKRU",
			--[KEY_9] = "KVWrenchKV",
			--[KEY_0] = "KVWrench0",
		},
		
		[KEY_RSHIFT] = {
			--[KEY_7] = "KVWrenchNone",
			--[KEY_8] = "KVWrenchKRU",
			--[KEY_9] = "KVWrenchKV",
			--[KEY_0] = "KVWrench0",
			[KEY_L] = "DriverValveDisconnectToggle",
		},

		[KEY_PAD_1] = "PneumaticBrake1",
		[KEY_PAD_2] = "PneumaticBrake2",
		[KEY_PAD_3] = "PneumaticBrake3",
		[KEY_PAD_4] = "PneumaticBrake4",
		[KEY_PAD_5] = "PneumaticBrake5",
		[KEY_PAD_6] = "PneumaticBrake6",
		[KEY_PAD_7] = "PneumaticBrake7",
		
	}
	
	self.InteractionZones = {
		{	Pos = Vector(458,-30,-55),
			Radius = 16,
			ID = "FrontBrakeLineIsolationToggle" },
		{	Pos = Vector(458, 30,-55),
			Radius = 16,
			ID = "FrontTrainLineIsolationToggle" },
		{	Pos = Vector(458, 60,-55),
			Radius = 16,
			ID = "ParkingBrakeToggle" },
		{	Pos = Vector(-482,30,-55),
			Radius = 16,
			ID = "RearBrakeLineIsolationToggle" },
		{	Pos = Vector(-482, -30,-55),
			Radius = 16,
			ID = "RearTrainLineIsolationToggle" },
		{	Pos = Vector(154,62.5,-65),
			Radius = 16,
			ID = "GVToggle" },
		{	Pos = Vector(446.0,0.0,50),
			Radius = 16,
			ID = "VBToggle" },
		{	Pos = Vector(-180,68.5,-50),
			Radius = 20,
			ID = "AirDistributorDisconnectToggle" },
		{	Pos = Vector(-470,-38,9),
			Radius = 28,
			ID = "RearDoor" },
		{	Pos = Vector(450,38,9),
			Radius = 28,
			ID = "FrontDoor" },
	}

	-- Lights
	self.Lights = {
		-- Head
		[1] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(176,161,132), fov = 100 },
		[2] = { "glow",				Vector(460, 51,-23), Angle(0,0,0), Color(255,255,255), brightness = 2 },
		[3] = { "glow",				Vector(460,-51,-23), Angle(0,0,0), Color(255,255,255), brightness = 2 },
		[4] = { "glow",				Vector(460,-8, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
		[5] = { "glow",				Vector(460,-8, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
		[6] = { "glow",				Vector(460, 2, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
		[7] = { "glow",				Vector(460, 2, 55), Angle(0,0,0), Color(255,255,255), brightness = 0.3 },
		
		-- Reverse
		[8] = { "light",			Vector(458,-45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		[9] = { "light",			Vector(458, 45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		
		-- Cabin
		[10] = { "dynamiclight",	Vector( 420, 0, 35), Angle(0,0,0), Color(255,255,255), brightness = 0.1, distance = 550 },
		
		-- Interior
		[11] = { "dynamiclight",	Vector( 350, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		[12] = { "dynamiclight",	Vector(   0, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		[13] = { "dynamiclight",	Vector(-350, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		
		-- Side lights
		[14] = { "light",			Vector(-50, 68, 51.9), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[15] = { "light",			Vector(6,   68, 51.9), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[16] = { "light",			Vector(3,   68, 51.9), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[17] = { "light",			Vector(-0,  68, 51.9), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		
		[18] = { "light",			Vector(-50, -69, 51.9), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[19] = { "light",			Vector(6,   -69, 51.9), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[20] = { "light",			Vector(3,   -69, 51.9), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[21] = { "light",			Vector(-0,  -69, 51.9), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
			
		-- Green RP
		[22] = { "light",			Vector(439.4,12.5-9.6,-5.7), Angle(0,0,0), Color(100,255,0), brightness = 1.0, scale = 0.020 },
		-- AVU
		[23] = { "light",			Vector(441.2,12.5-20.3,-3.7), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
		-- LKTP
		[24] = { "light",			Vector(441.2,12.5-23.0,-3.7), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
	}
	for i = 1,23 do
		self.Lights[69+i] = { "light", Vector(-470 + 35*i, 0, 65), Angle(180,0,0), Color(255,220,180), brightness = 0.25, scale = 0.75}
		--self:SetLightPower(69+i,RealTime()%1*2>1)
	end

	
	-- Cross connections in train wires
	self.TrainWireCrossConnections = {
		[5] = 4, -- Reverser F<->B
		[31] = 32, -- Doors L<->R
	}
	
	-- Setup door positions
	self.LeftDoorPositions = {}
	self.RightDoorPositions = {}
	for i=0,3 do
		table.insert(self.LeftDoorPositions,Vector(353.0 - 35*0.5 - 231*i,65,-1.8))
		table.insert(self.RightDoorPositions,Vector(353.0 - 35*0.5 - 231*i,-65,-1.8))
	end
	
	-- BPSN type
	self.BPSNType = self.BPSNType or 2+math.floor(Metrostroi.PeriodRandomNumber()*5+0.5)
	self:SetNWInt("BPSNType",self.BPSNType)
end


function ENT:CreateJointSound(sndnum)
	table.insert(self.Joints,{type = sndnum,state = self.SpeedSign > 0 and 0 or 4,dist = self.SpeedSign > 0 and 0 or 19.17})
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 1.0 then
		--print(1)
		self.TextureTime = CurTime()
		if self.Texture then
			for k,v in pairs(self:GetMaterials()) do
				if v:sub(-10,-1) == "81-717_003" or v:sub(-10,-1) == "81-717_002" or v:sub(-10,-1) == "81-717_006" then
					self:SetSubMaterial(k-1,self.Texture)
				else
					self:SetSubMaterial(k-1,"")
				end
			end
			self:SetNWString("texture",self.Texture)
		end
	end
	local retVal = self.BaseClass.Think(self)
	
	if not self:IsWrenchPresent() then
		self.PMP:TriggerInput("Set", 0)
	end
	self.Electric:TriggerInput("TrainMode",1)
	
	--self.DriverSeat:SetLocalPos(Vector(415,0,-48+2.5))
	--self.InstructorsSeat:SetLocalPos(Vector(410,47,-27+2.5))
	--seat:SetPos(self:LocalToWorld(seat_info.offset))
	--seat:SetAngles(self:GetAngles()+Angle(0,-90,0)+seat_info.angle)

	-- Interior/cabin lights
	local lightsActive1 = (self.Battery.Voltage > 55.0 and self.Battery.Voltage < 85.0) and
		((self:ReadTrainWire(33) > 0) or (self:ReadTrainWire(34) > 0))
	local lightsActive2 = (self.PowerSupply.XT3_4 > 65.0) and
		(self:ReadTrainWire(33) > 0)
	self:SetLightPower(11, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	self:SetLightPower(12, lightsActive2, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	self:SetLightPower(13, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	--print(lightsActive1,lightsActive2)
	for i = 1,23 do
		self:SetLightPower(69+i,lightsActive2 and true or lightsActive1 and i%5==1 or false)
	end
	-- Side lights
	self:SetLightPower(15, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(19, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(16, (self.Panel["GreenRP"] or 0) > 0.5)
	self:SetLightPower(20, (self.Panel["GreenRP"] or 0) > 0.5)
	self:SetLightPower(17, self.Panel["TrainBrakes"] > 0.5)
	self:SetLightPower(21, self.Panel["TrainBrakes"] > 0.5)

	-- Switch and button states
	self:SetPackedBool(0,self:IsWrenchPresent())
	self:SetPackedBool(2,self.VozvratRP.Value == 1.0)
	self:SetPackedBool(5,self.GV.Value == 1.0)
	self:SetPackedBool(6,self.DriverValveDisconnect.Value == 1.0)
	self:SetPackedBool(7,self.VB.Value == 1.0)
	self:SetPackedBool(8,self.RezMK.Value == 1.0)
	self:SetPackedBool(9,self.VMK.Value == 1.0)
	self:SetPackedBool(20,self.Pneumatic.Compressor == 1.0)
	self:SetPackedBool(21,self.Pneumatic.LeftDoorState[1] > 0.5)
	self:SetPackedBool(22,self.Pneumatic.ValveType == 2)
	--self:SetPackedBool(22,self.Pneumatic.LeftDoorState[2] > 0.5)
	--self:SetPackedBool(23,self.Pneumatic.LeftDoorState[3] > 0.5)
	--self:SetPackedBool(24,self.Pneumatic.LeftDoorState[4] > 0.5)
	self:SetPackedBool(25,self.Pneumatic.RightDoorState[1] > 0.5)
	--self:SetPackedBool(26,self.Pneumatic.RightDoorState[2] > 0.5)
	--self:SetPackedBool(27,self.Pneumatic.RightDoorState[3] > 0.5)
	--self:SetPackedBool(28,self.Pneumatic.RightDoorState[4] > 0.5)
	self:SetPackedBool(59,self.BPSNon.Value == 1.0)
	self:SetPackedBool(112,(self.RheostatController.Velocity ~= 0.0))
	self:SetPackedBool(113,self.KRP.Value == 1.0)
	self:SetPackedBool(132,self:ReadTrainWire(48) ~= -1)
	self:SetPackedBool(156,self.RearDoor)
	self:SetPackedBool(157,self.FrontDoor)

	self:SetPackedBool(160,self.ParkingBrake.Value > 0)

	-- Signal if doors are open or no to platform simulation
	self.LeftDoorsOpen = 
		(self.Pneumatic.LeftDoorState[1] > 0.5) or
		(self.Pneumatic.LeftDoorState[2] > 0.5) or
		(self.Pneumatic.LeftDoorState[3] > 0.5) or
		(self.Pneumatic.LeftDoorState[4] > 0.5)
	self.RightDoorsOpen = 
		(self.Pneumatic.RightDoorState[1] > 0.5) or
		(self.Pneumatic.RightDoorState[2] > 0.5) or
		(self.Pneumatic.RightDoorState[3] > 0.5) or
		(self.Pneumatic.RightDoorState[4] > 0.5)
	self:WriteTrainWire(35,(self.Pneumatic.BrakeCylinderPressure > 0.1) and 1 or 0)
		
	-- Is there a driver
	self:SetBodygroup(1,(self:GetDriver() ~= nil) and 1 or 0)
	--self:SetBodygroup(1,((CurTime() % 2.0) > 0.2) and 1 or 0)
	
	-- BPSN
	self:SetPackedBool(52,self.PowerSupply.XT3_1 > 0)
	
	-- AV states
	for i,v in ipairs(self.Panel.AVMap) do
		if tonumber(v) 
		then self:SetPackedBool(64+(i-1),self["A"..v].Value == 1.0)
		elseif self[v] then self:SetPackedBool(64+(i-1),self[v].Value == 1.0)
		end
	end
    
	-- Feed packed floats
	self:SetPackedRatio(0, 1-self.Pneumatic.DriverValvePosition/7)
	--self:SetPackedRatio(1, (self.KV.ControllerPosition+3)/7)
	self:SetPackedRatio(2, 1-(self.PMP.Position+1)/2)
	if self.Pneumatic.ValveType == 1 then
		self:SetPackedRatio(4, self.Pneumatic.ReservoirPressure/16.0)
	else
		self:SetPackedRatio(4, self.Pneumatic.BrakeLinePressure/16.0)	
	end	
	self:SetPackedRatio(5, self.Pneumatic.TrainLinePressure/16.0)
	self:SetPackedRatio(6, self.Pneumatic.BrakeCylinderPressure/6.0)
	self:SetPackedRatio(7, self.Electric.Power750V/1000.0)
	self:SetPackedRatio(8, math.abs(self.Electric.I24)/1000.0)	
	if self.Pneumatic.TrainLineOpen then
		self:SetPackedRatio(9, (self.Pneumatic.TrainLinePressure_dPdT or 0)*6)
	else
		self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	end
	self:SetPackedRatio(10,(self.VB.Value * self.Battery.Voltage) / 120.0)

	-- RUT test
	local weightRatio = 2.00*math.max(0,math.min(1,(self:GetNWFloat("PassengerCount",0)/300)))
	if math.abs(self:GetAngles().pitch) > 2.5 then weightRatio = weightRatio + 1.00 end
	self.YAR_13A:TriggerInput("WeightLoadRatio",math.max(0,math.min(2.50,weightRatio)))
	
	-- Exchange some parameters between engines, pneumatic system, and real world
	self.Engines:TriggerInput("Speed",self.Speed)
	if IsValid(self.FrontBogey) and IsValid(self.RearBogey) then
		self.FrontBogey.MotorForce = 35300
		self.FrontBogey.Reversed = (self.RKR.Value > 0.5)
		self.RearBogey.MotorForce  = 35300
		self.RearBogey.Reversed = (self.RKR.Value < 0.5)
	
		-- These corrections are required to beat source engine friction at very low values of motor power
		local A = 2*self.Engines.BogeyMoment
		local P = math.max(0,0.04449 + 1.06879*math.abs(A) - 0.465729*A^2)
		if math.abs(A) > 0.4 then P = math.abs(A) end
		if math.abs(A) < 0.05 then P = 0 end
		if self.Speed < 10 then P = P*(1.0 + 0.5*(10.0-self.Speed)/10.0) end
		self.RearBogey.MotorPower  = P*0.5*((A > 0) and 1 or -1)
		self.FrontBogey.MotorPower = P*0.5*((A > 0) and 1 or -1)
		
		-- Apply brakes
		self.FrontBogey.PneumaticBrakeForce = 40000.0
		self.FrontBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
		self.FrontBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		self.FrontBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
		self.RearBogey.PneumaticBrakeForce = 40000.0
		self.RearBogey.BrakeCylinderPressure = self.Pneumatic.BrakeCylinderPressure
		self.RearBogey.BrakeCylinderPressure_dPdT = -self.Pneumatic.BrakeCylinderPressure_dPdT
		--self.RearBogey.ParkingBrake = self.ParkingBrake.Value > 0.5
	end
	
	-- Generate bogey sounds
	local jerk = math.abs((self.Acceleration - (self.PrevAcceleration or 0)) / self.DeltaTime)
	self.PrevAcceleration = self.Acceleration
	
	if jerk > (2.0 + self.Speed/15.0) then
		self.PrevTriggerTime1 = self.PrevTriggerTime1 or CurTime()
		self.PrevTriggerTime2 = self.PrevTriggerTime2 or CurTime()
		
		if ((math.random() > 0.00) or (jerk > 10)) and (CurTime() - self.PrevTriggerTime1 > 1.5) then
			self.PrevTriggerTime1 = CurTime()
			self.FrontBogey:EmitSound("subway_trains/chassis_"..math.random(1,3)..".wav", 70, math.random(90,110))
		end
		if ((math.random() > 0.00) or (jerk > 10)) and (CurTime() - self.PrevTriggerTime2 > 1.5) then
			self.PrevTriggerTime2 = CurTime()
			self.RearBogey:EmitSound("subway_trains/chassis_"..math.random(1,3)..".wav", 70, math.random(90,110))
		end
	end

	-- Send networked variables
	--self:SendPackedData()
	return retVal
end


--------------------------------------------------------------------------------
function ENT:OnCouple(train,isfront)
	self.BaseClass.OnCouple(self,train,isfront)
	
	if isfront then
		self.FrontBrakeLineIsolation:TriggerInput("Open",1.0)
		self.FrontTrainLineIsolation:TriggerInput("Open",1.0)
	else
		self.RearBrakeLineIsolation:TriggerInput("Open",1.0)
		self.RearTrainLineIsolation:TriggerInput("Open",1.0)
	end
end
function ENT:OnButtonPress(button)
	if string.find(button,"PneumaticBrakeSet") then
		self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
		return
	end
	if button == "FrontDoor" then
		self.FrontDoor = not self.FrontDoor
	end
	if button == "RearDoor" then
		self.RearDoor = not self.RearDoor
	end
	if button == "AirDistributorDisconnectToggle" then return end
	if button == "GVToggle" then
		if self.GV.Value > 0.5 then
			self:PlayOnce("revers_f",nil,0.7)
		else
			self:PlayOnce("revers_b",nil,0.7)
		end
		return
	end
	if (button == "VUToggle") or ((string.sub(button,1,1) == "A") and (tonumber(string.sub(button,2,2)))) then
		local name = string.sub(button,1,(string.find(button,"Toggle") or 0)-1)
		if self[name] then
			if self[name].Value > 0.5 then
				self:PlayOnce("av_off","cabin")
			else
				self:PlayOnce("av_on","cabin")
			end
		end
		return
	end
	
	if button == "DriverValveDisconnectToggle" then
		if self.DriverValveDisconnect.Value == 1.0 then
			if self.Pneumatic.ValveType == 2 then
				self:PlayOnce("pneumo_disconnect2","cabin",0.9)
			end
		else
			self:PlayOnce("pneumo_disconnect1","cabin",0.9)
		end
		return
	end
	if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	if string.find(button,"KRU") then return end
	

	if button == "VBToggle" then 
		if self.VUD1.Value > 0.5 then
			self:PlayOnce("vu22_off","cabin")
		else
			self:PlayOnce("vu22_on","cabin")
		end
		return
	end
	-- Generic button or switch sound
	if string.find(button,"Set") then
		self:PlayOnce("button_press","cabin")
	end
	if string.find(button,"Toggle") then
		self:PlayOnce("switch2","cabin",0.7)
	end
end

function ENT:OnButtonRelease(button)
	if string.find(button,"PneumaticBrakeSet") then
		return
	end
	if (button == "PneumaticBrakeDown") and (self.Pneumatic.DriverValvePosition == 1) then
		self.Pneumatic:TriggerInput("BrakeSet",2)
	end	
	if self.Pneumatic.ValveType == 1 then
		if (button == "PneumaticBrakeUp") and (self.Pneumatic.DriverValvePosition == 5) then
			self.Pneumatic:TriggerInput("BrakeSet",4)
		end
	end

	if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	if string.find(button,"KRU") then return end

	if string.find(button,"Set") then
		self:PlayOnce("button_release","cabin")
	end
end