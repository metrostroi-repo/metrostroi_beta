AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--------------------------------------------------------------------------------
function ENT:Initialize()
	-- Defined train information
	self.SubwayTrain = {
		Type = "81",
		Name = "81-717",
	}
	-- Set model and initialize
	self.MaskType = 1
	self.LampType = 1
	self:SetModel("models/metrostroi_train/81/81-717.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))
	
	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(432,0,-23+7.8))
	self.InstructorsSeat = self:CreateSeat("instructor",Vector(440,50,-28+3),Angle(0,270,0))
	self.ExtraSeat1 = self:CreateSeat("instructor",Vector(430,-40,-28+1))
	self.ExtraSeat2 = self:CreateSeat("instructor",Vector(435,-50,-43),Angle(0,180,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.ExtraSeat3 = self:CreateSeat("instructor",Vector(412,50,-43),Angle(0,-40+90,0),"models/vehicles/prisoner_pod_inner.mdl")

	-- Hide seats
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat1:SetColor(Color(0,0,0,0))
	self.ExtraSeat1:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat2:SetColor(Color(0,0,0,0))
	self.ExtraSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat3:SetColor(Color(0,0,0,0))
	self.ExtraSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)
	
	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector( 325-5,0,-75),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-325+0,0,-75),Angle(0,0,0),false)
	
	-- Initialize key mapping
	self.KeyMap = {
		[KEY_1] = "KVSetX1",
		[KEY_2] = "KVSetX2",
		[KEY_3] = "KVSetX3",
		[KEY_4] = "KVSet0",
		[KEY_5] = "KVSetT1",
		[KEY_6] = "KVSetT1AB",
		[KEY_7] = "KVSetT2",
		[KEY_8] = "KRP",
		
		[KEY_EQUAL] = "R_Program1Set",
		[KEY_MINUS] = "R_Program2Set",

		[KEY_G] = "VozvratRPSet",
		
		[KEY_0] = "KVReverserUp",
		[KEY_9] = "KVReverserDown",
		[KEY_PAD_PLUS] = "KVReverserUp",
		[KEY_PAD_MINUS] = "KVReverserDown",
		[KEY_W] = "KVUp",
		[KEY_S] = "KVDown",
		["invprev"] = "KVUp",
		["invnext"] = "KVDown",
		[KEY_F] = "PneumaticBrakeUp",
		[KEY_R] = "PneumaticBrakeDown",
		
		[KEY_A] = "KDL",
		[KEY_D] = "KDP",
		[KEY_V] = "VUD1Toggle",
		[KEY_L] = "HornEngage",
		[KEY_N] = "VZ1Set",
		[KEY_PAD_1] = "PneumaticBrakeSet1",
		[KEY_PAD_2] = "PneumaticBrakeSet2",
		[KEY_PAD_3] = "PneumaticBrakeSet3",
		[KEY_PAD_4] = "PneumaticBrakeSet4",
		[KEY_PAD_5] = "PneumaticBrakeSet5",
		[KEY_PAD_6] = "PneumaticBrakeSet6",
		[KEY_PAD_7] = "PneumaticBrakeSet7",
		[KEY_PAD_DIVIDE] = "KRPSet",
		[KEY_PAD_MULTIPLY] = "KAHSet",
		
		[KEY_SPACE] = "PBSet",
		[KEY_BACKSPACE] = "EmergencyBrake",

		[KEY_PAD_0] = "DriverValveDisconnectToggle",
		[KEY_PAD_DECIMAL] = "EPKToggle",
		[KEY_LSHIFT] = {
			[KEY_W] = "KVUp_Unlocked",
			[KEY_SPACE] = "KVTSet",
		
			[KEY_A] = "DURASelectAlternate",
			[KEY_D] = "DURASelectMain",
			[KEY_V] = "DURAToggleChannel",
			[KEY_1] = "DIPonSet",
			[KEY_2] = "DIPoffSet",
			[KEY_4] = "KVSet0Fast",
			[KEY_L] = "DriverValveDisconnectToggle",
			
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV", 
			[KEY_0] = "KVWrench0",
			[KEY_6] = "KVSetT1A",
		},
		
		[KEY_RSHIFT] = {
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
			[KEY_L] = "DriverValveDisconnectToggle",
		},
		[KEY_LALT] = {
			[KEY_V] = "VUD1Toggle",
			[KEY_L] = "EPKToggle",
			[KEY_PAD_1] = "B1Set",
			[KEY_PAD_2] = "B2Set",
			[KEY_PAD_3] = "B3Set",
			[KEY_PAD_4] = "B4Set",
			[KEY_PAD_5] = "B5Set",
			[KEY_PAD_6] = "B6Set",
			[KEY_PAD_7] = "B7Set",
			[KEY_PAD_8] = "B8Set",
			[KEY_PAD_9] = "B9Set",
			[KEY_PAD_0] = "B0Set",
			[KEY_PAD_DIVIDE] = "BLeftSet",
			[KEY_PAD_MULTIPLY] = "BUpSet",
			[KEY_PAD_DECIMAL] = "BDownSet",
			[KEY_PAD_PLUS] = "BPlusSet",
			[KEY_PAD_MINUS] = "BMinusSet",
			[KEY_PAD_ENTER] = "BEnterSet",
		},
		[KEY_RALT] = {
			[KEY_L] = "EPKToggle",
		},
	}
	
	self.InteractionZones = {
		{	Pos = Vector(460,-26,-47),
			Radius = 16,
			ID = "FrontBrakeLineIsolationToggle" },
		{	Pos = Vector(460, 21, -49),
			Radius = 16,
			ID = "FrontTrainLineIsolationToggle" },
		{	Pos = Vector(-482,30,-55),
			Radius = 16,
			ID = "RearTrainLineIsolationToggle" },
		{	Pos = Vector(-469, -23, -48),
			Radius = 16,
			ID = "RearBrakeLineIsolationToggle" },
		{	Pos = Vector(122, 61, -53),
			Radius = 16,
			ID = "GVToggle" },
		{	Pos = Vector(405, -53, 21),
			Radius = 30,
			ID = "VBToggle" },
		{	Pos = Vector(-180,61,-53),
			Radius = 20,
			ID = "AirDistributorDisconnectToggle" },
		{	Pos = Vector(-475, -25, 20),
			Radius = 32,
			ID = "1:RearDoor" },
		{	Pos = Vector(-475, -25, -11),
			Radius = 32,
			ID = "2:RearDoor" },
		{	Pos = Vector(391, 14, 10),
			Radius = 32,
			ID = "PassengerDoor" },
		{	Pos = Vector(415, 65, 30),
			Radius = 28,
			ID = "1:CabinDoor" },
		{	Pos = Vector(415, 65, -9),
			Radius = 28,
			ID = "2:CabinDoor" },
		{	Pos = Vector(441, 66, -48),
			Radius = 28,
			ID = "3:CabinDoor" },
	}

	-- Lights
	local vX = Angle(0,-90-0.2,56.3):Forward() -- For ARS panel
	local vY = Angle(0,-90-0.2,56.3):Right()
	self.Lights = {
		-- Headlight glow
		[1] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(216,161,92), fov = 100 },
		-- Headlight glow ДУВ
		[110] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(127,255,255), fov = 100 },
		
		-- Head (type 1)
		[2] = { "glow",				Vector(470,-51,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[3] = { "glow",				Vector(472,-40, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[4] = { "glow",				Vector(0,0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[5] = { "glow",				Vector(0, 0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[6] = { "glow",				Vector(472, 41, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[7] = { "glow",				Vector(470, 53,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },

		-- Reverse
		[8] = { "light",			Vector(478,-44, 60), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		[9] = { "light",			Vector(478, 44, 60), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		
		-- Cabin
		[10] = { "dynamiclight",	Vector( 440, 0, 40), Angle(0,0,0), Color(255,255,255), brightness = 0.05, distance = 550 },
		
		-- Interior
		[11] = { "dynamiclight",	Vector( 294, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 },
		[12] = { "dynamiclight",	Vector(   0, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 },
		[13] = { "dynamiclight",	Vector(-294, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 },
		
		-- Side lights
		[14] = { "light",			Vector(-50, 69, 59.5), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[15] = { "light",			Vector(15.2,   69, 59.5), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[16] = { "light",			Vector(12,   69, 59.5), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[17] = { "light",			Vector(9,  69, 59.5), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		
		[18] = { "light",			Vector(-50, -69, 59.5), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[19] = { "light",			Vector(15,   -69, 59.5), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[20] = { "light",			Vector(12,   -69, 59.5), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[21] = { "light",			Vector(9,  -69, 59.5), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

	--self.Lights[22]
		--self.Lights[26]
	--self.Lights[23]
		-- Green RP
		[22] = { "light",			Vector(461,12.55+1.5-9.6,-0.8), Angle(0,0,0), Color(0,255,0), brightness = 1.0, scale = 0.020 },
		-- AVU
		[23] = { "light",			Vector(463.0,12.4+1.5-20.3,1.15), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
		-- LKVP
		[24] = { "light",			Vector(463.0,12.3+1.5-23.1,1.15), Angle(0,0,0), math.random() > 0.3 and Color(0,0,255) or math.random() > 0.5 and Color(100,255,100) or Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Pneumatic brake
		[25] = { "light",			Vector(460,-26.5,-0.3), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Cabin heating
		[26] = { "light",			Vector(460,-21.5,-0.3), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Door left open (#1)
		[27] = { "light",			Vector(459.3,4.4,-2.9), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },
		-- Door left open (#2)
		[28] = { "light",			Vector(459.3,10.8,-2.9), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },
		-- Door right open 
		[29] = { "light",			Vector(460.1,-24.0,-0.25), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },

		-- Cabin texture light
		[30] = { "headlight", 		Vector(412.0,15,50), Angle(60,-50,0), Color(176,161,132), farz = 128, nearz = 1, shadows = 0, brightness = 0.20, fov = 140 },
		-- Manometers
		[31] = { "headlight", 		Vector(470.00,3,8.5), Angle(0,-90,0), Color(216,161,92), farz = 32, nearz = 1, shadows = 0, brightness = 0.4, fov = 30 },
		-- Voltmeter
		[32] = { "headlight", 		Vector(470.00,10,12.5), Angle(28,90,0), Color(216,161,92), farz = 16, nearz = 1, shadows = 0, brightness = 0.4, fov = 40 },
		-- Ampermeter
		[33] = { "headlight", 		Vector(467.05,-32.8+1.5,20.1), Angle(-90,0,0), Color(216,161,92), farz = 10, nearz = 1, shadows = 0, brightness = 4.0, fov = 60 },
		-- Voltmeter
		[34] = { "headlight", 		Vector(467.05,-32.8+1.5,23.85), Angle(-90,0,0), Color(216,161,92), farz = 10, nearz = 1, shadows = 0, brightness = 4.0, fov = 60 },
		
		-- Custom D
		[35] = { "light", 			Vector(464.3,25.6-1.6*0,6.3), Angle(0,0,0), Color(255,0,0), brightness = 1.0, scale = 0.020 },
		-- Custom E
		[36] = { "light", 			Vector(464.3,25.0-1.4*1,6.3), Angle(0,0,0), Color(255,255,255), brightness = 1.0, scale = 0.020 },
		-- Custom F
		[37] = { "light", 			Vector(464.3,25.0-1.6*2,6.3), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Custom G
		[38] = { "light", 			Vector(464.3,25.0-1.6*3,6.3), Angle(0,0,0), Color(100,255,0), brightness = 1.0, scale = 0.020 },
		
		-- LSP
		[39] = { "light",			Vector(465.8,11.3-23.0,3.75), Angle(0,0,0), Color(255,0,0), brightness = 1.0, scale = 0.020 },
	
		-- ARS panel lights
		[40] = { "light", Vector(469.56,11.0,13.3)+vY*5.25+vX*3,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[41] = { "light", Vector(469.56,11.0,13.3)+vY*5.25+vX*4.15,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[42] = { "light", Vector(469.56,11.0,13.3)+vY*5.25+vX*5.4,				Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[43] = { "light", Vector(469.56,11.0,13.3)+vY*5.28+vX*7.64,				Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[44] = { "light", Vector(469.56,11.0,13.3)+vY*5.27+vX*11.14,			Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[45] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*0),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[46] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*1),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[47] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*2),	Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[48] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*3),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[49] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*4),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[50] = { "light", Vector(469.56,11.0,13.3)+vY*2.63+vX*(5.42+1.13*5),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[51] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.30*0)+vX*12.70,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[52] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.30*1)+vX*12.71,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[53] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.30*2)+vX*12.72,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[54] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.30*3)+vX*12.73,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[55] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.31*0)+vX*16.15,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[56] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.31*1)+vX*16.16,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[57] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.31*2)+vX*16.17,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[58] = { "light", Vector(469.56,11.0,13.3)+vY*(1.37+1.31*3)+vX*16.18,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },		
		
		-- Interior lights
		[60+0] = { "headlight", Vector(290-130*0,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+1] = { "headlight", Vector(290-130*1,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+2] = { "headlight", Vector(290-130*2,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+3] = { "headlight", Vector(290-130*3,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+4] = { "headlight", Vector(290-130*4,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+5] = { "headlight", Vector(290-130*5,0,70), Angle(90,0,0),  Color(255,255,255), farz = 150, nearz = 1, shadows = 0, brightness = 0.1, fov = 160 },
		[60+6] = { "headlight", Vector(270-230*0,0,20), Angle(-90,0,0), Color(255,255,255), farz = 120, nearz = 1, shadows = 0, brightness = 0.1, fov = 170 },
		[60+7] = { "headlight", Vector(270-230*1,0,20), Angle(-90,0,0), Color(255,255,255), farz = 120, nearz = 1, shadows = 0, brightness = 0.1, fov = 170 },
		[60+8] = { "headlight", Vector(270-230*2,0,20), Angle(-90,0,0), Color(255,255,255), farz = 120, nearz = 1, shadows = 0, brightness = 0.1, fov = 170 },
		[60+9] = { "headlight", Vector(270-230*3,0,20), Angle(-90,0,0), Color(255,255,255), farz = 120, nearz = 1, shadows = 0, brightness = 0.1, fov = 170 },
	}
	for i = 1,23 do
		self.Lights[69+i] = { "light", Vector(-470 + 35.8*i, 0, 70), Angle(180,0,0), Color(255,220,180), brightness = 1, scale = 0.75}
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
	
	-- KV wrench mode
	self.KVWrenchMode = 0
	
	-- BPSN type
	self.BPSNType = self.BPSNType or 2+math.floor(Metrostroi.PeriodRandomNumber()*5+0.5)
	self:SetNWInt("BPSNType",self.BPSNType)
	
	-- ARS type
	self.ARSType = 1
	self:SetNWInt("ARSType",1)

	self.RearDoor = false
	self.FrontDoor = false
	self.CabinDoor = false
	self.PassengerDoor = false
	if not self.Announcer.AnnMap:find("metrostroi") then
		self.A45:TriggerInput("Set",0)
	end
	self.L_5:TriggerInput("Set",1)
	self.A5:TriggerInput("Set",0)
	self.OldTexture = 0
end

--------------------------------------------------------------------------------
function ENT:Think()
	if self.Lights[70] and self.LampType and self.LampType == 1 and self.Lights[70][4] ~= Color(255,175,50) then
		for i = 1,23 do
			self:SetLightPower(69+i,false)
			self.Lights[69+i][2] = Vector(-470 + 35.8*i, 0, 70)
			self.Lights[69+i][4] = Color(255,175,50)
		end
		for i = 11,13 do
			self:SetLightPower(i,false)
			self.Lights[i][4] = Color(255,175,50)
		end
		self.LightsReload = true
	end
	if self.Lights[70] and self.LampType and self.LampType > 1 and ((self.Lights[70][4] ~= Color(200,200,255)  and self.LampType == 2) or (self.Lights[70][4] ~= Color(255,255,255)  and self.LampType == 3)) then
		for i = 1,23 do
			self:SetLightPower(69+i,false)
			self.Lights[69+i][2] = Vector(-474 + 67.5*i, 0, 70)
			if self.LampType == 2 then
				self.Lights[69+i][4] = Color(200,200,255)
			elseif self.LampType == 3 then
				self.Lights[69+i][4] = Color(255,255,255)
			end
		end
		for i = 11,13 do
			self:SetLightPower(i,false)
			if self.LampType == 2 then
				self.Lights[i][4] = Color(200,200,255)
			elseif self.LampType == 3 then
				self.Lights[i][4] = Color(255,255,255)
			end
		end
		self.LightsReload = true
	end

	if self.PassTexture ~= self.OldTexture or self.Adverts ~= self.OldAdverts then
		for k,v in pairs(self:GetMaterials()) do
			if v == "models/metrostroi_train/81/int02" then
				if self.Adverts ~= 4 then
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][(self.PassTexture and (Metrostroi.Skins["717_pass2"][self.PassTexture]:find("Peters") and "p" or "m") or "m").."_"..self.Map:sub(4,-1)].path1)
				else
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][(self.PassTexture and (Metrostroi.Skins["717_pass2"][self.PassTexture]:find("Peters") and "p" or "m") or "m").."_"..self.Map:sub(4,-1)].path2)
				end
			end
		end
		self.OldTexture = self.PassTexture
		self.OldAdverts = self.Adverts
	end
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 1.0 then
		--table.insert(self.SignsList,"Синергия-1")
		--print(1)
		self.TextureTime = CurTime()
		self:SetNWInt("ARSType",(self.ARSType or 1))
		self:SetNWBool("Breakers",(self.Breakers or 0) > 0)
		
		if self.Texture or self.PassTexture or self.SignsList	 then
			for k,v in pairs(self:GetMaterials()) do
				if v == "models/metrostroi_train/81/b01a" then
					if self.Texture then self:SetSubMaterial(k-1,self.Texture) end
				elseif v == "models/metrostroi_train/81/int01" then
					if self.PassTexture then self:SetSubMaterial(k-1,self.PassTexture) end
					--print(self.PassTexture)
					--if self.SignsList then print(self.SignsList[self.SignsIndex][1]) end
				elseif v == "models/metrostroi_train/81/tabl" then
					if self.SignsList then
						if self.SignsList[self.SignsIndex] then self:SetSubMaterial(k-1,self.SignsList[self.SignsIndex][1]) else print(self.SignsIndex) end
					else
						self:PrepareSigns()
					end
				elseif v ~= "models/metrostroi_train/81/int02" then
					self:SetSubMaterial(k-1,"")
				end
			end
			self:SetNWString("texture",self.Texture)
			self:SetNWString("passtexture",self.PassTexture)
		end
	end
	self:SetBodygroup(1,(self.ARSType or 1)-1)
	self:SetBodygroup(2,(self.LampType or 1)-1)
	self:SetBodygroup(3,(self.MaskType or 1)-1)
	self:SetBodygroup(4,(self.SeatType or 1)-1)
	self:SetBodygroup(5,(self.HandRail or 1)-1)
	self:SetBodygroup(6,(self.MVM and ((self.MaskType > 2 and self.MaskType ~= 6) and 1 or 0) or 2))
	self:SetBodygroup(7,(self.BortLampType or 1)-1)
	self:SetBodygroup(9,(self.Breakers or 0))
	self:SetBodygroup(10,math.min(3,self.Adverts or 1)-1)
	self:SetBodygroup(13,2-self.Pneumatic.ValveType)
	self:SetBodygroup(14,self.ARSType == 3 and 1 or 0)

	--self:SetSubMaterial(0,"metrostroi_skins/81-717/6.pnqw")
	--PrintTable(self:GetMaterials())
	--print(self.DeltaTime)
	--print(self.SpeedSign)
	--if not self.SpeedSign then return end

	--print(self.Panel["HeadLights1"])
	--if not self.Panel["HeadLights1"] then return end
	self.RetVal = self.BaseClass.Think(self)
	-- Check if wrench was pulled out
	if self.DriversWrenchPresent then
		self.KV:TriggerInput("Enabled",self:IsWrenchPresent() and 1 or 0)
	end

	-- Set wrench sounds
	if not self.DriversWrenchSoundsInit then
		self.KV:TriggerInput("Type",2)
		self.DriversWrenchSoundsInit = true
	end
	
	-- Headlights
	local brightness = self.Panel["HeadLights1"] and (math.min(1,self.Panel["HeadLights1"])*0.50 + 
						math.min(1,self.Panel["HeadLights2"])*0.25 + 
						math.min(1,self.Panel["HeadLights3"])*0.25)
						or 0
	self:SetLightPower(1,self.Panel["HeadLights3"] and (self.Panel["HeadLights3"] > 0.5) and (self.L_4.Value > 0.5),brightness)
	
	if self.LED and self.Lights[1][4] ~= Color(127,255,255) then
		for i = 1,7 do self:SetLightPower(i,false) end
		self.Lights[1][4] = Color(127,255,255)
		for i = 2,7 do
			self.Lights[i][4] = Color(127,255,255)
			self.Lights[i]["brightness"] = 5
			self.Lights[i]["scale"] = 2.0
		end
	end
	if not self.LED and self.Lights[1][4] ~= Color(216,161,92) then
		for i = 1,7 do self:SetLightPower(i,false) end
		self.Lights[1][4] = Color(216,161,92)
		for i = 2,7 do
			self.Lights[i][4] = Color(255,220,180)
			self.Lights[i]["brightness"] = 1
			self.Lights[i]["scale"] = 1.0
		end
	end
	if self.MaskType == 2 and self.Lights[4][2] ~= Vector(477,-4, 60) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(477,-51,-19)
		 self.Lights[3][2] = Vector(477,-40, -19)
		 self.Lights[4][2] = Vector(477,-4, 60)
		 self.Lights[5][2] = Vector(477, 6, 60)
		 self.Lights[6][2] = Vector(477, 40, -19)
		 self.Lights[7][2] = Vector(477, 51,-19)
	end
	if self.MaskType == 1 and self.Lights[3][2] ~= Vector(472,-40, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(470,-51,-19)
		 self.Lights[3][2] = Vector(472,-40, -19)
		 self.Lights[4][2] = Vector(0,0, 0)
		 self.Lights[5][2] = Vector(0, 0, 0)
		 self.Lights[6][2] = Vector(472, 41, -19)
		 self.Lights[7][2] = Vector(470, 53,-19)
	end
	if (self.MaskType == 3 or self.MaskType == 5) and self.Lights[4][2] ~= Vector(477,-7, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(477,-51,-19)
		 self.Lights[3][2] = Vector(477,-18,-19)
		 self.Lights[4][2] = Vector(477,-7, -19)
		 self.Lights[5][2] = Vector(477, 7, -19)
		 self.Lights[6][2] = Vector(477, 18,-19)
		 self.Lights[7][2] = Vector(477, 51,-19)
	end
	if self.MaskType == 4 and self.Lights[4][2] ~= Vector(477,1, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(477,-51,-19)
		 self.Lights[3][2] = Vector(477,-12,-19)
		 self.Lights[4][2] = Vector(477,1, -19)
		 self.Lights[5][2] = Vector(0, 0, -0)
		 self.Lights[6][2] = Vector(477, 12,-19)
		 self.Lights[7][2] = Vector(477, 51,-19)
	end
	if self.MaskType == 6 and self.Lights[3][2] ~= Vector(472,-45, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(0,0,0)
		 self.Lights[3][2] = Vector(472,-45, -19)
		 self.Lights[4][2] = Vector(0,0, 0)
		 self.Lights[5][2] = Vector(0, 0, 0)
		 self.Lights[6][2] = Vector(472, 48, -19)
		 self.Lights[7][2] = Vector(0, 0,0)
		for i = 1,7 do self:SetLightPower(i,true) end
	end
	if self.Panel["HeadLights1"] and self.Panel["HeadLights2"] then
		if self.ARSType == 3 then
			if self.MaskType == 3 or self.MaskType == 5 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
			elseif self.MaskType == 2 then
				self:SetLightPower(2, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
			end
		else
			if self.MaskType == 3 or self.MaskType == 5 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
			elseif self.MaskType == 2 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
			end
		end
		if self.MaskType == 1 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, false)
				self:SetLightPower(5, false)
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 4 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, false)
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 6 then
				self:SetLightPower(2, false)
				self:SetLightPower(3, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, false)
				self:SetLightPower(5, false)
				self:SetLightPower(6, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, false)
		end
	end
	--if self.ARSType == 3 then self.ARSType = 2 end
--[[
	--if self.ARSType == 3 then
		self:SetLightPower(2,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(3,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(4,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(5,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(6,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(7,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))

		self:SetLightPower(93, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(94, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(95, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(96, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(97, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(92, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))

		self:SetLightPower(98, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(99, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(100, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(101, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(103, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(102, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		
		self:SetLightPower(105,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(106,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(107,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(108,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(109,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(104,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
	else
		self:SetLightPower(3,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(7,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(5,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(4,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(6,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(2,   self.TrainModel == 2 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))

		self:SetLightPower(93, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(94, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(95, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(96, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(97, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(92, self.TrainModel == 1 and not self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))

		self:SetLightPower(99, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(103, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(101, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(100, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(102, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(98, self.TrainModel == 2 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		
		self:SetLightPower(105,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(106,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(107,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(108,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(109,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		self:SetLightPower(104,  self.TrainModel == 1 and self.LED and (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
	end
	]]
	-- Reverser lights
	self:SetLightPower(8, self.Panel["RedLightRight"] > 0.5)
	self:SetLightPower(9, self.Panel["RedLightLeft"] > 0.5)
	
	-- Interior/cabin lights
	self:SetLightPower(10,(self.Panel["CabinLight"] > 0.5) and (self.L_2.Value > 0.5))
	self:SetLightPower(30, (self.Panel["CabinLight"] > 0.5), 0.03 + 0.97*self.L_2.Value)
	
	local lightsActive1 = (self.Battery.Voltage > 55.0 and self.Battery.Voltage < 85.0) and
		((self:ReadTrainWire(33) > 0) or (self:ReadTrainWire(34) > 0))
	local lightsActive2 = (self.PowerSupply.XT3_4 > 55.0) and
		(self:ReadTrainWire(33) > 0)
	if not self.LightsActive then self.LightsActive = 0 end
	if (lightsActive1 and not lightsActive2) and self.LightsActive ~= 1 or lightsActive2 and self.LightsActive ~= 2 or (not lightsActive1 and not lightsActive2) and self.LightsActive ~= 0 or self.LightsReload then
		self:SetLightPower(11, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
		self:SetLightPower(12, lightsActive2, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
		self:SetLightPower(13, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
		self.LightsReload = nil
		local Ip = self.LampType == 1 and 5 or 3
		for i = 1,23 do
			self:SetLightPower(69+i,(lightsActive2 or (lightsActive1 and (i+Ip-2)%Ip==1)) and (self.LampType == 1 or i < 14))
		end
		self.LightsActive = (lightsActive2 and 2 or lightsActive1 and 1 or 0)
	end
	--[[self:SetLightPower(12, (self.Panel["EmergencyLight"] > 0.5) and ((self.L_1.Value > 0.5) or (self.L_5.Value > 0.5)),
		0.5*self.L_5.Value + ((self.PowerSupply.XT3_4 > 65.0) and 0.5 or 0))]]
		
	--[[for i=60,69 do
		self:SetLightPower(i,
			(self.Panel["EmergencyLight"] > 0.5) and ((self.L_1.Value > 0.5) or (self.L_5.Value > 0.5)),
			0.1*self.L_5.Value + ((self.PowerSupply.XT3_4 > 65.0) and 1 or 0))
	end]]--
	--self:SetLightPower(12, self.Panel["EmergencyLight"] > 0.5)
	--self:SetLightPower(13, self.PowerSupply.XT3_4 > 65.0)	
	self:SetLightPower(31, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(32, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(33, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(34, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))

	-- Door button lights
	self:SetLightPower(27,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	self:SetLightPower(28,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	self:SetLightPower(29,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 1) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	if self.BortLampType == 1 and self.Lights[19][2] ~=  Vector(15,   -69, 59.5) then
		for i = 0,6 do self:SetLightPower(15+i,false) end
		self.Lights[15][2] = Vector(15.2,   69, 59.5)
		self.Lights[16][2] = Vector(12,   69, 59.5)
		self.Lights[17][2] = Vector(9,  69, 59.5)

		self.Lights[19][2] = Vector(15,   -69, 59.5)
		self.Lights[20][2] = Vector(12,   -69, 59.5)
		self.Lights[21][2] = Vector(9,  -69, 59.5)
	end
	if self.BortLampType == 2 and self.Lights[19][2] ~= Vector(42.8,   -69, 57.5) then
		for i = 0,6 do self:SetLightPower(15+i,false) end
		self.Lights[15][2] = Vector(-48.8,   69, 57.5)
		self.Lights[16][2] = Vector(-48.8,   69, 54.7)
		self.Lights[17][2] = Vector(-48.8,  69, 51.5)

		self.Lights[19][2] = Vector(42.8,   -69, 57.5)
		self.Lights[20][2] = Vector(42.8,   -69, 54.7)
		self.Lights[21][2] = Vector(42.8,  -69, 51.5)
	end
	-- Side lights
	self:SetLightPower(15, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(19, self.Panel["TrainDoors"] > 0.5)
	
	self:SetLightPower(16, self.Panel["GreenRP"] > 0.5)
	self:SetLightPower(20, self.Panel["GreenRP"] > 0.5)
	
	self:SetLightPower(17, self.Panel["TrainBrakes"] > 0.5)
	self:SetLightPower(21, self.Panel["TrainBrakes"] > 0.5)
	self:SetLightPower(25, self.Panel["TrainBrakes"] > 0.5)
	
	-- Switch and button states
	self:SetPackedBool(0,self:IsWrenchPresent())
	self:SetPackedBool(1,self.VUS.Value == 1.0)
	self:SetPackedBool(2,self.VozvratRP.Value == 1.0)
	self:SetPackedBool(3,self.DIPon.Value == 1.0)
	self:SetPackedBool(4,self.DIPoff.Value == 1.0)
	self:SetPackedBool(5,self.GV.Value == 1.0)
	self:SetPackedBool(6,self.DriverValveDisconnect.Value == 1.0)
	self:SetPackedBool(7,self.VB.Value == 1.0)
	self:SetPackedBool(8,self.RezMK.Value == 1.0)
	self:SetPackedBool(9,self.VMK.Value == 1.0)
	self:SetPackedBool(10,self.VAH.Value == 1.0)
	self:SetPackedBool(11,self.VAD.Value == 1.0)
	self:SetPackedBool(12,self.VUD1.Value == 1.0)
	self:SetPackedBool(13,self.VUD2.Value == 1.0)
	self:SetPackedBool(14,self.VDL.Value == 1.0)
	self:SetPackedBool(15,self.KDL.Value == 1.0)
	self:SetPackedBool(16,self.KDP.Value == 1.0)
	self:SetPackedBool(17,self.KRZD.Value == 1.0)
	self:SetPackedBool(18,self.KSN.Value == 1.0)
	self:SetPackedBool(19,self.OtklAVU.Value == 1.0)
	self:SetPackedBool(20,self.Pneumatic.Compressor == 1.0)
	self:SetPackedBool(21,self.Pneumatic.LeftDoorState[1] > 0.5)
	self:SetPackedBool(22,self.Pneumatic.ValveType == 2)
	--23
	self:SetPackedBool(24,self.DURA.Power)
	self:SetPackedBool(25,self.Pneumatic.RightDoorState[1] > 0.5)
	self:SetPackedBool(27,self.KVWrenchMode == 2)
	self:SetPackedBool(28,self.KVT.Value == 1.0)
	self:SetPackedBool(29,self.DURA.SelectAlternate == false)
	self:SetPackedBool(30,self.DURA.SelectAlternate == true)
	self:SetPackedBool(31,self.DURA.Channel == 2)
	--print(self.KB.Value)
	self:SetPackedBool(56,self.ARS.Value == 1.0)
	self:SetPackedBool(57,self.ALS.Value == 1.0)
	self:SetPackedBool(58,(self.Panel["CabinLight"] > 0.5) and (self.L_2.Value > 0.5))
	self:SetPackedBool(59,self.BPSNon.Value == 1.0)
	self:SetPackedBool(60,self.L_1.Value == 1.0)
	self:SetPackedBool(61,self.L_2.Value == 1.0)
	self:SetPackedBool(62,self.L_3.Value == 1.0)
	self:SetPackedBool(63,self.L_4.Value == 1.0)
	self:SetPackedBool(53,self.L_5.Value == 1.0)
	self:SetPackedBool(55,self.DoorSelect.Value == 1.0)
	self:SetPackedBool(112,(self.RheostatController.Velocity ~= 0.0))
	self:SetPackedBool(113,self.KRP.Value == 1.0)
	self:SetPackedBool(114,self.Custom1.Value == 1.0)
	self:SetPackedBool(115,self.Custom2.Value == 1.0)
	self:SetPackedBool(116,self.Custom3.Value == 1.0)
	self:SetPackedBool(117,self.Custom4.Value == 1.0)
	self:SetPackedBool(118,self.Custom5.Value == 1.0)
	self:SetPackedBool(119,self.Custom6.Value == 1.0)
	self:SetPackedBool(120,self.Custom7.Value == 1.0)
	self:SetPackedBool(121,self.Custom8.Value == 1.0)
	self:SetPackedBool(122,self.CustomA.Value == 1.0)
	self:SetPackedBool(123,self.CustomB.Value == 1.0)
	self:SetPackedBool(124,self.CustomC.Value == 1.0)
	self:SetLightPower(35,self.ARSType < 3 and self.CustomD.Value == 1.0)
	self:SetLightPower(36,self.ARSType < 3 and self.CustomE.Value == 1.0)
	self:SetLightPower(37,self.ARSType < 3 and self.CustomF.Value == 1.0)
	self:SetLightPower(38,self.ARSType < 3 and self.CustomG.Value == 1.0)
	self:SetPackedBool(125,self.R_G.Value == 1.0)
	self:SetPackedBool(126,self.R_Radio.Value == 1.0)
	self:SetPackedBool(127,self.R_UNch.Value == 1.0)
	self:SetPackedBool(128,self.R_Program1.Value == 1.0)
	self:SetPackedBool(129,self.R_Program2.Value == 1.0)
	self:SetPackedBool(130,self.RC1.Value == 1.0)
	self:SetPackedBool(132,self:ReadTrainWire(48) ~= -1)
	self:SetPackedBool(134,self.UOS.Value == 1.0)
	self:SetPackedBool(135,self.BPS.Value == 1.0)
	self:SetPackedBool(150,self.ARS13.Value == 1.0)
	self:SetPackedBool(151,self.Radio13.Value == 1.0)
	self:SetPackedBool(152,self.UAVA.Value == 1.0)
	self:SetPackedBool(153,self.DURA.Channel1Alternate)
	self:SetPackedBool(154,self.DURA.Channel2Alternate)
	self:SetPackedBool(155,self.EPK.Value == 1.0)

	self:SetPackedBool(156,self.RearDoor)
	self:SetPackedBool(158,self.PassengerDoor)
	self:SetPackedBool(159,self.CabinDoor)
	
	--self.ARSType = self.ARSType or 1
	self:SetPackedBool(160,self.ParkingBrake.Value > 0)
	self:SetPackedBool(161,self.ParkingBrakeSign.Value > 0)
	self:SetPackedBool(162,self.KB.Value == 1.0)
	self:SetPackedBool(163,self.KAH.Value == 1.0)
	self:SetPackedBool(164,self.OldKVPos)
	self:SetPackedBool(165,self.PB.Value > 0)
	self:SetPackedBool("VPA",self.VPA.Value > 0)
	self:SetPackedBool("Indicate1",self.Indicate.Value == 1.0)
	self:SetPackedBool("Indicate2",self.Indicate.Value == 2.0)
	self:SetPackedBool("Indicate3",self.Indicate.Value == 3.0)
	self:SetPackedBool("BCCD",self.BCCD.Value == 1.0)
	self:SetPackedBool("VZP",self.VZP.Value == 1.0)
	self:SetPackedBool("B7",self.B7.Value == 1.0)
	self:SetPackedBool("B8",self.B8.Value == 1.0)
	self:SetPackedBool("B9",self.B9.Value == 1.0)
	self:SetPackedBool("BLeft",self.BLeft.Value == 1.0)
	self:SetPackedBool("B4",self.B4.Value == 1.0)
	self:SetPackedBool("B5",self.B5.Value == 1.0)
	self:SetPackedBool("B6",self.B6.Value == 1.0)
	self:SetPackedBool("BUp",self.BUp.Value == 1.0)
	self:SetPackedBool("B1",self.B1.Value == 1.0)
	self:SetPackedBool("B2",self.B2.Value == 1.0)
	self:SetPackedBool("B3",self.B3.Value == 1.0)
	self:SetPackedBool("BDown",self.BDown.Value == 1.0)
	self:SetPackedBool("B0",self.B0.Value == 1.0)
	self:SetPackedBool("BMinus",self.BMinus.Value == 1.0)
	self:SetPackedBool("BPlus",self.BPlus.Value == 1.0)
	self:SetPackedBool("BEnter",self.BEnter.Value == 1.0)
	
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
	
	-- DIP/power
	self:SetPackedBool(32,self.Panel["V1"] > 0.5)
	-- LxRK
	self:SetPackedBool(33,self:ReadTrainWire(2) > 0.5)--self.RheostatController.MotorCoilState ~= 0.0)
	-- NR1
	self:SetPackedBool(34,(self.NR.Value == 1.0) or (self.RPU.Value == 1.0))
	-- Red RP
	self.RTW18 = self:GetTrainWire18Resistance()
	if (self.KV.ControllerPositionAutodrive == 0 and self.KV.ControllerPosition == 0) or (self.Panel["V1"] < 0.5) then self.RTW18 = 1e9 end
	self:SetPackedBool(35,self.RTW18 < 1.39-0.208*self:GetWagonCount())
	self:SetPackedBool(131,self.RTW18 < 100)
	-- Green RP
	self:SetPackedBool(36,self.Panel["GreenRP"] > 0.5)
	self:SetLightPower(22,self.Panel["GreenRP"] > 0.5)
	-- Cabin heating
	self:SetPackedBool(37,self.Panel["KUP"] > 0.5)
	self:SetLightPower(26,self.Panel["KUP"] > 0.5)
	-- AVU
	self:SetPackedBool(38,self.Panel["AVU"] > 0.5)
	--21.3 -0.4 5.05
		-- AVU
	self:SetLightPower(23,self.Panel["AVU"] > 0.5)
	-- Ring
	self:SetPackedBool(39,self.Panel["Ring"] > 0.5)
	-- SD
	self:SetPackedBool(40,self.Panel["SD"] > 0.5)
	-- OCh
	self:SetPackedBool(41,self.ALS_ARS.NoFreq)
	-- 0
	self:SetPackedBool(42,self.ALS_ARS.Signal0)
	-- 40
	self:SetPackedBool(43,self.ALS_ARS.Signal40)
	-- 60
	self:SetPackedBool(44,self.ALS_ARS.Signal60)
	-- 75
	self:SetPackedBool(45,self.ALS_ARS.Signal70)
	-- 80
	self:SetPackedBool(46,self.ALS_ARS.Signal80)
	-- KT
	self:SetPackedBool(47,self.ALS_ARS.LKT)
	-- KVD
	self:SetPackedBool(48,self:ReadTrainWire(21) > 0.5)--self.ALS_ARS.LVD)
	-- LST
	self:SetPackedBool(49,self:ReadTrainWire(6) > 0.5)
	-- LVD
	self:SetPackedBool(50,self:ReadTrainWire(1) > 0.5)
	-- LKVC
	self:SetPackedBool(51,self.KVC.Value < 0.5)
	-- BPSN
	self:SetLightPower(24,(self.PowerSupply.XT3_1 > 0) and (self.Panel["V1"] > 0.5))
	self:SetPackedBool(52,self.PowerSupply.XT3_1 > 0)
	-- LRS
	self:SetPackedBool(54,(self.Panel["V1"] > 0.5) and 
		(self.ALS.Value > 0.5) and 
		(self.ALS_ARS.NextLimit >= self.ALS_ARS.SpeedLimit))
	
	-- AV states
	for i,v in ipairs(self.Panel.AVMap) do
		if tonumber(v) 
		then self:SetPackedBool(64+(i-1),self["A"..v].Value == 1.0)
		else self:SetPackedBool(64+(i-1),self[v].Value == 1.0)
		end
	end
	
	-- Non-standard ARS logic
	
	if self.ARSType == 2 then
		-- LSD
		self:SetLightPower(40,self:GetPackedBool(40) and self:GetPackedBool(32))
		self:SetLightPower(41,self:GetPackedBool(40) and self:GetPackedBool(32))
		-- LHRK
		self:SetLightPower(42,self:GetPackedBool(33) and self:GetPackedBool(32))
		-- RP LSN
		self:SetLightPower(43,self:GetPackedBool(35) and self:GetPackedBool(32))
		self:SetLightPower(44,self:GetPackedBool(131) and self:GetPackedBool(32))
		self:SetLightPower(43,(self:GetPackedBool(35) or self:GetPackedBool(131)) and self:GetPackedBool(32),self:GetPackedBool(35) and 1 or 0.35)
		self:SetLightPower(44,self:GetPackedBool(131) and self:GetPackedBool(32))
		-- Och
		self:SetLightPower(45,self:GetPackedBool(41) and self:GetPackedBool(32))
		-- 0
		self:SetLightPower(46,self:GetPackedBool(42) and self:GetPackedBool(32))
		-- 40
		self:SetLightPower(47,self:GetPackedBool(43) and self:GetPackedBool(32))
		-- 60
		self:SetLightPower(48,self:GetPackedBool(44) and self:GetPackedBool(32))
		-- 70
		self:SetLightPower(49,self:GetPackedBool(45) and self:GetPackedBool(32))
		-- 80
		self:SetLightPower(50,self:GetPackedBool(46) and self:GetPackedBool(32))
		-- LEKK
		self:SetLightPower(51,false)
		-- LN
		self:SetLightPower(52,false)
		-- LKVD
		self:SetLightPower(53,self:GetPackedBool(48) and self:GetPackedBool(32))
		-- LKT
		self:SetLightPower(54,self:GetPackedBool(47) and self:GetPackedBool(32))
		-- LKVC
		self:SetLightPower(55,self:GetPackedBool(51) and self:GetPackedBool(32))
		-- LRS
		self:SetLightPower(56,self:GetPackedBool(54) and self:GetPackedBool(32))
		-- LVD
		self:SetLightPower(57,self:GetPackedBool(50) and self:GetPackedBool(32))
		-- LST
		self:SetLightPower(58,self:GetPackedBool(49) and self:GetPackedBool(32))
	else
		for i=40,58 do
			self:SetLightPower(i,false)
		end
	end
	
	-- Total temperature
	local IGLA_Temperature = math.max(self.Electric.T1,self.Electric.T2)
    
	-- Feed packed floats
	self:SetPackedRatio(0, 1-self.Pneumatic.DriverValvePosition/7)
	self:SetPackedRatio(1, (self.KV.ControllerPosition+3)/7)
	if self.KVWrenchMode == 2 then
		self:SetPackedRatio(2, self.KRU.Position)
	else
		self:SetPackedRatio(2, 1-(self.KV.ReverserPosition+1)/2)	
	end
	if self.Pneumatic.ValveType == 1 then
		self:SetPackedRatio(4, self.Pneumatic.ReservoirPressure/16.0)
	else
		self:SetPackedRatio(4, self.Pneumatic.BrakeLinePressure/16.0)	
	end	
	self:SetPackedRatio(5, self.Pneumatic.TrainLinePressure/16.0)
	self:SetPackedRatio(6, math.min(2.7,self.Pneumatic.BrakeCylinderPressure)/6.0)
	self:SetPackedRatio(7, self.Electric.Power750V/1000.0)
	self:SetPackedRatio(8, 0.5 + 0.5*(self.Electric.I24/500.0))
	if self.Pneumatic.TrainLineOpen then
		self:SetPackedRatio(9, (self.Pneumatic.TrainLinePressure_dPdT or 0)*6)
	else
		self:SetPackedRatio(9, self.Pneumatic.BrakeLinePressure_dPdT or 0)
	end
	if (self.ARS13) and (self.ARS13.Value > 0) then
		local EnableARS = (self.ARS.Value == 1.0) and (self.VB.Value == 1.0) and (self.KV.ReverserPosition ~= 0.0)
		self:SetPackedRatio(10,(EnableARS and 13.0 or 0.0) / 150.0)
	elseif (self.Radio13) and (self.Radio13.Value > 0) then
		self:SetPackedRatio(10,0.0)
	else
		--print(self.Panel["V1"] * self.Battery.Voltage)
		self:SetPackedRatio(10,(self.Panel["V1"] * self.Battery.Voltage) / 150.0)
	end
	self:SetPackedRatio(11,IGLA_Temperature)
	self:SetLightPower(39,(self.Electric.Overheat1 > 0) or (self.Electric.Overheat2 > 0))

	-- Update ARS system
	self:SetPackedRatio(3, self.ALS_ARS.Speed/100.0)
	if (self.ALS_ARS.Ring == true) or --(self:ReadTrainWire(21) > 0) or 
		((IGLA_Temperature > 500) and ((CurTime() % 2.0) > 1.0) and self.A63.Value == 1) then
		self:SetPackedBool(39,true)
	end
	
	-- RUT test
	--print(self:GetNWFloat("PassengerCount"))
	local weightRatio = 2.00*math.max(0,math.min(1,(self:GetNWFloat("PassengerCount")/300)))
	if math.abs(self:GetAngles().pitch) > 2.5 then weightRatio = weightRatio + 1.00 end
	self.YAR_13A:TriggerInput("WeightLoadRatio",math.max(0,math.min(2.50,weightRatio)))
	self.YAR_27:TriggerInput("WeightLoadRatio",math.max(0,math.min(2.50,weightRatio)))
	
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
		--self.RearBogey.MotorPower  = P*0.5
		--self.FrontBogey.MotorPower = P*0.5
		
		--self.Acc = (self.Acc or 0)*0.95 + self.Acceleration*0.05
		--print(self.Acc)
		
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

	if self:EntIndex() == 2561 then
		--print(Format("Train Wire 18 R=%.3f Ohm",RTW18)) --self:GetTrainWire18Resistance()))
	end
	-- Temporary hacks
	--self:SetNWFloat("V",self.Speed)
	--self:SetNWFloat("A",self.Acceleration)
	
	--print(self.Electric.RPSignalResistor)

	-- Send networked variables
	--self:SendPackedData()
	if self:ReadTrainWire(5)*self:ReadTrainWire(4) > 0 and not self.RevCheck then
		self.RevCheck = CurTime()+0.25
	end
	if self.RevCheck and CurTime() - self.RevCheck > 0 then
		if self:ReadTrainWire(5)*self:ReadTrainWire(4) > 0 then
			self:TriggerInput("VUOpenBypass")
			if self.VU.TargetValue == 0 then
				self:PlayOnce("av_off","cabin")
			end
		end
		self.RevCheck = nil
	end
	return self.RetVal
end


function ENT:Check2Cab(button,breaker,func,isbreaker)
	local x = 0
	if not istw then
		local x = (1 - self[button].TargetValue)*self[breaker].Value
		for k,v in pairs(self.WagonList) do
			if v[(isbreaker and breaker or button)] and v[button].Value*v[breaker].Value > 0.5 then
				x = x + 1
			end
		end
		if x > 1 then
			for k,v in pairs(self.WagonList) do
				if self[(isbreaker and breaker or button)] and v[button].Value*v[breaker].Value > 0.5 then
					v:TriggerInput((isbreaker and button or breaker).."Set",0)
					v:PlayOnce("av_off","cabin")
				end
			end
			self:TriggerInput((isbreaker and button or breaker).."OpenBypass")
			self:PlayOnce("av_off","cabin")
		end
	end
end
function ENT:PhysicsCollide( colData, collider )
	if colData.HitEntity == Entity(0) then
		--PrintTable(colData)
		file.Append("collides.txt",tostring(self:WorldToLocal(colData.HitPos)).."\n")
		print("COLLIDE")
		print(self:WorldToLocal(colData.HitPos))
		--print(collider)
	end
end
--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,state)
	if button:find(":") then
		button = string.Explode(":",button)[2]
	end
	--self["PA-KSD"]:TriggerInput("Press",button)
	if button == "BPSNonToggle" then
		self:Check2Cab("BPSNon","A27")
	end
	if button == "A27Toggle" then
		self:Check2Cab("A27","BPSNon",nil,true)
	end
	if button == "VMKToggle" then
		self:Check2Cab("VMK","A10")
	end
	if button == "A10Toggle" then
		self:Check2Cab("A10","VMK",nil,true)
	end
			
	if string.find(button,"PneumaticBrakeSet") then
		self.Pneumatic:TriggerInput("BrakeSet",tonumber(button:sub(-1,-1)))
		return
	end
	if button:find("RearDoor") then
		self.RearDoor = not self.RearDoor
	end
	if button:find("PassengerDoor") then
		self.PassengerDoor = not self.PassengerDoor
	end
	if button == "CabinDoor" then
		self.CabinDoor = not self.CabinDoor
	end
	if button == "VAHToggle" then
		local drv = self:GetDriverName()
		local state = self.VAH.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." VAH!")
	end
	if button == "OtklAVUToggle" then
		local drv = self:GetDriverName()
		local state = self.OtklAVU.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." OtklAVU!")
	end
	if button == "VADToggle" then
		local drv = self:GetDriverName()
		local state = self.VAD.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." VAD!")
	end
	if button == "RC1Toggle" then
		local drv = self:GetDriverName()
		local state = self.RC1.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." RC1!")
	end
	if button == "UOSToggle" then
		local drv = self:GetDriverName()
		local state = self.UOS.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." UOS!")
	end
	if button == "UAVAToggle" then
		local drv = self:GetDriverName()
		local state = self.UAVA.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." UAVA!")
	end
	if button == "BPSToggle" then
		local drv = self:GetDriverName()
		local state = self.BPS.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." BPS!")
	end
	if button == "A5Toggle" then
		local drv = self:GetDriverName()
		local state = self.A5.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." A5!")
	end
	if button == "AirDistributorDisconnectToggle" then return end
	if button == "NextSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex + 1
		if self.SignsIndex > #self.SignsList then self.SignsIndex = 1 end
		
		self:SetNWString("FrontText",self.SignsList[self.SignsIndex][2])
	end
	if button == "PrevSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex - 1
		if self.SignsIndex < 1 then self.SignsIndex = #self.SignsList end
		
		self:SetNWString("FrontText",self.SignsList[self.SignsIndex][2])
	end

	if button == "Num1P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNWString("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNWString("RouteNumber",self.RouteNumber)
		end
			
	end
	if button == "Num1M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNWString("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNWString("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNWString("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNWString("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNWString("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNWString("RouteNumber",self.RouteNumber)
		end
	end
	if button == "RouteNumberUpdate" then
		self.RouteNumber = #state == 0 and "00" or #state == 1 and "0"..state or state
		self:SetNWString("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNWString("RouteNumber",self.RouteNumber)
		end
	end

	if button == "KVUp" then
		if self.KV.ControllerPosition ~= -1 then
			self.KV:TriggerInput("ControllerUp",1.0)
		end
	end
	if button == "KVUp_Unlocked" then
		self.KV:TriggerInput("ControllerUp",1.0)
	end
	if button == "KVDown" then
		self.KV:TriggerInput("ControllerDown",1.0)
	end

	if (self.KVWrenchMode == 2) and (button == "KVReverserUp") then
		self.KRU:TriggerInput("Up",1)
		self:OnButtonPress("KRUUp")
	end
	if (self.KVWrenchMode == 2) and (button == "KVReverserDown") then
		self.KRU:TriggerInput("Down",1)
		self:OnButtonPress("KRUDown")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX1") then
		self.KRU:TriggerInput("SetX1",1)
		self:OnButtonPress("KRUSetX1")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX2") then
		self.KRU:TriggerInput("SetX2",1)
		self:OnButtonPress("KRUSetX2")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSetX3") then
		self.KRU:TriggerInput("SetX3",1)
		self:OnButtonPress("KRUSetX3")
	end
	if (self.KVWrenchMode == 2) and (button == "KVSet0") then
		self.KRU:TriggerInput("Set0",1)
		self:OnButtonPress("KRUSet0")
	end	

	if button == "KVSetT1AB" then
		if self.KV.ControllerPosition == -2 then
			self.KV:TriggerInput("ControllerSet",-1)
			timer.Simple(0.20,function()
				self.KV:TriggerInput("ControllerSet",-2)			
			end)
		else
			self.KV:TriggerInput("ControllerSet",-2)
		end
	end

	if button == "KVWrench0" then 
		if self.KVWrenchMode == 3 or self.KVWrenchMode == 1 then
			if self.KVWrenchMode ~= 1 then
				self:PlayOnce("revers_in","cabin",0.7)
			end
			self.KVWrenchMode = 0
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = false
			self.KV:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	if button == "KVWrenchKV" then
		if self.KVWrenchMode == 3 or self.KVWrenchMode == 0 then
			if self.KVWrenchMode ~= 0 then
				self:PlayOnce("revers_in","cabin",0.7)
			end
			self.KVWrenchMode = 1
			self.DriversWrenchPresent = true
			self.DriversWrenchMissing = false
			self.KV:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	if button == "KVWrenchKRU" then
		if self.KVWrenchMode == 3 then
			self:PlayOnce("kru_in","cabin",0.7)
			self.KVWrenchMode = 2
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = true
			self.KV:TriggerInput("Enabled",0)
			self.KRU:TriggerInput("Enabled",1)
			self.KRU:TriggerInput("LockX3",1)
			local drv = self:GetDriverName()
			RunConsoleCommand("say",drv.." want drive with KRU!")
		end
	end
	if button == "KVWrenchNone" then
		if self.KVWrenchMode ~= 3 then
			if self.KVWrenchMode == 2 then
				self:PlayOnce("kru_out","cabin",0.7,120.0)
				local drv = self:GetDriverName()
				RunConsoleCommand("say",drv.." stop drive with KRU!")
			else
				self:PlayOnce("revers_out","cabin",0.7,120.0)
			end
			self.KVWrenchMode = 3
			self.DriversWrenchPresent = false
			self.DriversWrenchMissing = true
			self.KV:TriggerInput("Enabled",0)
			self.KRU:TriggerInput("Enabled",0)
		end
	end
	--if button == "KVT2Set" then self.KVT:TriggerInput("Close",1) end
	if button == "KDL" then self.KDL:TriggerInput("Close",1) self:OnButtonPress("KDLSet") end
	if button == "KDP" then self.KDP:TriggerInput("Close",1) self:OnButtonPress("KDPSet") end
	if button == "VDL" then self.VDL:TriggerInput("Close",1) self:OnButtonPress("VDLSet") end
	if button == "KRP" then 
		self.KRP:TriggerInput("Set",1)
		self:OnButtonPress("KRPSet")
	end
	if button == "EmergencyBrake" then
		self.KV:TriggerInput("ControllerSet",-3)
		self.Pneumatic:TriggerInput("BrakeSet",7)
		self.DriverValveDisconnect:TriggerInput("Set",1)
		return
	end
	
	-- Special logic
	if (button == "VDL") or (button == "KDL") or (button == "KDP") then
		--self.VUD1:TriggerInput("Open",1)
		--self.VUD2:TriggerInput("Open",1)
	end
	if (button == "VDL") or (button == "KDL") then
		self.DoorSelect:TriggerInput("Open",1)
	end
	if (button == "KDP") then
		self.DoorSelect:TriggerInput("Close",1)
	end
	if (button == "VUD1Set") or (button == "VUD1Toggle") or
	   (button == "VUD2Set") or (button == "VUD2Toggle") then
		self.VDL:TriggerInput("Open",1)
		self.KDL:TriggerInput("Open",1)
		self.KDP:TriggerInput("Open",1)
	end
	--print(button)
	-- Special sounds
	if button == "L_5Toggle" or (button == "VUToggle") or ((string.sub(button,1,1) == "A") and (tonumber(string.sub(button,2,2)))) then
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

	if (button == "UAVAToggle") then
		if self.UAVA then
			if self.UAVA.Value > 0.5 then
				self:PlayOnce("uava_off","cabin")
			else
				self:PlayOnce("uava_off","cabin")
			end
		end
		return
	end
	if button == "PBSet" then self:PlayOnce("switch6","cabin",0.55,100) return end
	if button == "GVToggle" then
		if self.GV.Value > 0.5 then
			self:PlayOnce("revers_f",nil,0.7)
		else
			self:PlayOnce("revers_b",nil,0.7)
		end
		return
	end

	if button == "VUD1Toggle" then 
		if self.VUD1.Value > 0.5 then
			self:PlayOnce("vu22_off","cabin")
		else
			self:PlayOnce("vu22_on","cabin")
		end
		return
	end
	if button == "VUD2Toggle" then 
		if self.VUD2.Value > 0.5 then
			self:PlayOnce("vu22_off","instructor")
		else
			self:PlayOnce("vu22_on","instructor")
		end
		return
	end
	if button == "VUD1Set" then 
		self:PlayOnce("vu22_on","cabin")
		return
	end
	if button == "VUD2Set" then 
		self:PlayOnce("vu22_on","instructor")
		return
	end
	if button == "VDLSet" then
		self:PlayOnce("vu22_on","instructor")
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

	if button == "R_Program1Helper" then
		self.R_Program1:TriggerInput("Set",1)
		self:PlayOnce("inf_on","instructor",0.7)
		return
	end
	if button == "R_Program2Helper" then
		self.R_Program2:TriggerInput("Set",1)
		self:PlayOnce("inf_on","instructor",0.7)
		return
	end
	if string.find(button,"R_Program") then
		self:PlayOnce("inf_on","cabin",0.7)
		return
	end
	
	-- Generic button or switch sound
	if string.find(button,"Set") or string.find(button,"DURASelect") then
		self:PlayOnce("button_press","cabin")
	end
	if string.find(button,"Toggle") then
		self:PlayOnce("switch2","cabin",0.7)
	end
end

function ENT:OnButtonRelease(button)
	if button:find(":") then
		button = string.Explode(":",button)[2]
	end
	if string.find(button,"PneumaticBrakeSet") then
		return
	end
	--if button == "KVT2Set" then self.KVT:TriggerInput("Open",1) end
	if button == "KDL" then self.KDL:TriggerInput("Open",1) self:OnButtonRelease("KDLSet") end
	if button == "KDP" then self.KDP:TriggerInput("Open",1) self:OnButtonRelease("KDPSet") end
	if button == "VDL" then self.VDL:TriggerInput("Open",1) self:OnButtonRelease("VDLSet") end
	if button == "KRP" then 
		self.KRP:TriggerInput("Set",0)
		self:OnButtonRelease("KRPSet")
	end

	if button == "PBSet" then self:PlayOnce("switch6_off","cabin",0.55,100) return end
	--[[
	if (button == "PneumaticBrakeDown") and (self.Pneumatic.DriverValvePosition == 1) then
		self.Pneumatic:TriggerInput("BrakeSet",2)
	end	
	if self.Pneumatic.ValveType == 1 then
		if (button == "PneumaticBrakeUp") and (self.Pneumatic.DriverValvePosition == 5) then
			self.Pneumatic:TriggerInput("BrakeSet",4)
		end
	end
	]]
	if button == "VUD1Set" then 
		self:PlayOnce("vu22_off","cabin")
		return
	end
	if button == "VUD2Set" then 
		self:PlayOnce("vu22_off","cabin")
		return
	end
	if button == "VDLSet" then
		self:PlayOnce("vu22_off","instructor")
		return
	end
	
	if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	if string.find(button,"KRU") then return end

	if button == "R_Program1Helper" then
		self.R_Program1:TriggerInput("Set",0)
		self:PlayOnce("inf_off","instructor",0.7)
		return
	end
	if button == "R_Program2Helper" then
		self.R_Program2:TriggerInput("Set",0)
		self:PlayOnce("inf_off","instructor",0.7)
		return
	end
	if string.find(button,"R_Program") then
		self:PlayOnce("inf_off","cabin",0.7)
		return
	end

	if string.find(button,"Set") or string.find(button,"DURASelect") then
		self:PlayOnce("button_release","cabin")
	end
end

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

function ENT:OnTrainWireError(k)
	if k == 4 then
		--self.VU:TriggerInput("Open",1.0)
		--self:PlayOnce("av_off","cabin")
	end
end