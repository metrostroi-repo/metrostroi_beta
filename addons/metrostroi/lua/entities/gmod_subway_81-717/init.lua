AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner

--------------------------------------------------------------------------------
function ENT:Initialize()
	self:Remove()
	-- Defined train information
	self.SubwayTrain = {
		Type = "81",
		Name = "81-717",
	}

	-- Set model and initialize
	self.TrainModel = 1
	self:SetModel("models/metrostroi/81/81-717a.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))
	
	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(410,0,-23+2.5))
	self.InstructorsSeat = self:CreateSeat("instructor",Vector(420,50,-28+3),Angle(0,270,0))
	self.ExtraSeat1 = self:CreateSeat("instructor",Vector(410,-40,-28+1))
	self.ExtraSeat2 = self:CreateSeat("instructor",Vector(415,-50,-43),Angle(0,180,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.ExtraSeat3 = self:CreateSeat("instructor",Vector(392,50,-43),Angle(0,-40+90,0),"models/vehicles/prisoner_pod_inner.mdl")

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
	self.FrontBogey = self:CreateBogey(Vector( 325-20,0,-80),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-325-10,0,-80),Angle(0,0,0),false)
	
	-- Initialize key mapping
	self.KeyMap = {
		[KEY_1] = "KVSetX1",
		[KEY_2] = "KVSetX2",
		[KEY_3] = "KVSetX3",
		[KEY_4] = "KVSet0",
		[KEY_5] = "KVSetT1",
		[KEY_6] = "KVSetT1A",
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
		
		[KEY_SPACE] = "PBSet",
		[KEY_BACKSPACE] = "EmergencyBrake",

		[KEY_PAD_0] = "DriverValveDisconnectToggle",
		[KEY_PAD_DECIMAL] = "EPKToggle",
		[KEY_LSHIFT] = {
			[KEY_W] = "KVUp_Unlocked",
			[KEY_SPACE] = "KBSet",
		
			[KEY_A] = "DURASelectAlternate",
			[KEY_D] = "DURASelectMain",
			[KEY_V] = "DURAToggleChannel",
			[KEY_1] = "DIPonSet",
			[KEY_2] = "DIPoffSet",
			[KEY_L] = "DriverValveDisconnectToggle",
			
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
		},
		
		[KEY_RSHIFT] = {
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
			[KEY_L] = "DriverValveDisconnectToggle",
		},
		[KEY_LALT] = {
			[KEY_L] = "EPKToggle",
		},
		[KEY_RALT] = {
			[KEY_L] = "EPKToggle",
		},
		[KEY_PAD_1] = "PneumaticBrakeSet1",
		[KEY_PAD_2] = "PneumaticBrakeSet2",
		[KEY_PAD_3] = "PneumaticBrakeSet3",
		[KEY_PAD_4] = "PneumaticBrakeSet4",
		[KEY_PAD_5] = "PneumaticBrakeSet5",
		[KEY_PAD_6] = "PneumaticBrakeSet6",
		[KEY_PAD_7] = "PneumaticBrakeSet7",
		[KEY_PAD_DIVIDE] = "KRPSet",
		[KEY_PAD_MULTIPLY] = "KAHSet",
	}
	
	self.InteractionZones = {
		{	Pos = Vector(458,-30,-55),
			Radius = 16,
			ID = "FrontBrakeLineIsolationToggle" },
		{	Pos = Vector(458, 30,-55),
			Radius = 16,
			ID = "FrontTrainLineIsolationToggle" },
		{	Pos = Vector(-482,30,-55),
			Radius = 16,
			ID = "RearBrakeLineIsolationToggle" },
		{	Pos = Vector(-482, -30,-55),
			Radius = 16,
			ID = "RearTrainLineIsolationToggle" },
		{	Pos = Vector(154,62.5,-65),
			Radius = 16,
			ID = "GVToggle" },
		{	Pos = Vector(398.0,-56.0+1.5,25.0),
			Radius = 20,
			ID = "VBToggle" },
		{	Pos = Vector(-180,68.5,-50),
			Radius = 20,
			ID = "AirDistributorDisconnectToggle" },
		{	Pos = Vector(-480,-39,9),
			Radius = 28,
			ID = "RearDoor" },
		{	Pos = Vector(372,17,16),
			Radius = 28,
			ID = "PassengerDoor" },
		{	Pos = Vector(386,65,-24),
			Radius = 28,
			ID = "CabinDoor2" },
		{	Pos = Vector(386,65,24),
			Radius = 28,
			ID = "CabinDoor2" },
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
		[2] = { "glow",				Vector(460, 51,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[3] = { "glow",				Vector(460, 40, -23), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[4] = { "glow",				Vector(460, 6, 55), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[5] = { "glow",				Vector(460,-4, 55), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[6] = { "glow",				Vector(460,-40, -23), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[7] = { "glow",				Vector(460,-51,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },

		--[[
		-- Head (type 2)
		[92] = { "glow",			Vector(460, 51,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[93] = { "glow",			Vector(460,-51,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[94] = { "glow",			Vector(460,-18,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[95] = { "glow",			Vector(460,-7, -23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[96] = { "glow",			Vector(460, 7, -23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[97] = { "glow",			Vector(460, 18,-23), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },

		-- Head (type 1, LED) 
		[98] = { "glow",				Vector(460, 51,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[99] = { "glow",				Vector(460,-51,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[100] = { "glow",				Vector(460, 6, 55), Angle(0,0,0),  Color(127,255,255), brightness = 2, scale = 2.0 },
		[101] = { "glow",				Vector(460,-4, 55), Angle(0,0,0),  Color(127,255,255), brightness = 2, scale = 2.0 },
		[102] = { "glow",				Vector(460, 40, -23), Angle(0,0,0),Color(127,255,255), brightness = 2, scale = 2.0 },
		[103] = { "glow",				Vector(460,-40, -23), Angle(0,0,0),Color(127,255,255), brightness = 2, scale = 2.0 },
		
		-- Head (type 2, LED)
		[104] = { "glow",			Vector(460, 51,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[105] = { "glow",			Vector(460,-51,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[106] = { "glow",			Vector(460,-18,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[107] = { "glow",			Vector(460,-7, -23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[108] = { "glow",			Vector(460, 7, -23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },
		[109] = { "glow",			Vector(460, 18,-23), Angle(0,0,0), Color(127,255,255), brightness = 2, scale = 2.0 },]]
		-- Reverse
		[8] = { "light",			Vector(458,-45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		[9] = { "light",			Vector(458, 45, 55), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1.0 },
		
		-- Cabin
		[10] = { "dynamiclight",	Vector( 420, 0, 35), Angle(0,0,0), Color(255,255,255), brightness = 0.1, distance = 550 },
		
		-- Interior
		[11] = { "dynamiclight",	Vector( 250, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		[12] = { "dynamiclight",	Vector(   0, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		[13] = { "dynamiclight",	Vector(-350, 0, 5), Angle(0,0,0), Color(255,220,180), brightness = 3, distance = 400 },
		
		-- Side lights
		[14] = { "light",			Vector(-50, 68, 53.7), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[15] = { "light",			Vector(6,   68, 53.7), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[16] = { "light",			Vector(3,   68, 53.7), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[17] = { "light",			Vector(-0,  68, 53.7), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		
		[18] = { "light",			Vector(-50, -69, 53.7), Angle(0,0,0), Color(255,0,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[19] = { "light",			Vector(6,   -69, 53.7), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[20] = { "light",			Vector(3,   -69, 53.7), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },
		[21] = { "light",			Vector(-0,  -69, 53.7), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "models/metrostroi_signals/signal_sprite_002.vmt" },

		-- Green RP
		[22] = { "light",			Vector(439.8,12.5+1.5-9.6,-6.1), Angle(0,0,0), Color(0,255,0), brightness = 1.0, scale = 0.020 },
		-- AVU
		[23] = { "light",			Vector(441.6,12.5+1.5-20.3,-4.15), Angle(0,0,0), Color(255,40,0), brightness = 1.0, scale = 0.020 },
		-- LKVP
		[24] = { "light",			Vector(441.6,12.5+1.5-23.0,-4.15), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Pneumatic brake
		[25] = { "light",			Vector(438.7,-26.1,-5.35), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Cabin heating
		[26] = { "light",			Vector(438.7,-21.1,-5.35), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Door left open (#1)
		[27] = { "light",			Vector(437.8,4.4,-8.0), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },
		-- Door left open (#2)
		[28] = { "light",			Vector(437.8,10.8,-8.0), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },
		-- Door right open 
		[29] = { "light",			Vector(438.7,-23.3,-5.35), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.024 },

		-- Cabin texture light
		[30] = { "headlight", 		Vector(390.0,16,45), Angle(60,-50,0), Color(176,161,132), farz = 128, nearz = 1, shadows = 0, brightness = 0.20, fov = 140 },
		-- Manometers
		[31] = { "headlight", 		Vector(450.00,5,3.0), Angle(0,-90,0), Color(216,161,92), farz = 32, nearz = 1, shadows = 0, brightness = 0.4, fov = 30 },
		-- Voltmeter
		[32] = { "headlight", 		Vector(449.00,10,7.0), Angle(28,90,0), Color(216,161,92), farz = 16, nearz = 1, shadows = 0, brightness = 0.4, fov = 40 },
		-- Ampermeter
		[33] = { "headlight", 		Vector(445.0,-35,9.0), Angle(-90,0,0), Color(216,161,92), farz = 10, nearz = 1, shadows = 0, brightness = 4.0, fov = 60 },
		-- Voltmeter
		[34] = { "headlight", 		Vector(445.0,-35,13.0), Angle(-90,0,0), Color(216,161,92), farz = 10, nearz = 1, shadows = 0, brightness = 4.0, fov = 60 },
		
		-- Custom D
		[35] = { "light", 			Vector(443.2,25.0-1.8*0,1.15), Angle(0,0,0), Color(255,0,0), brightness = 1.0, scale = 0.020 },
		-- Custom E
		[36] = { "light", 			Vector(443.2,25.0-1.8*1,1.15), Angle(0,0,0), Color(255,255,255), brightness = 1.0, scale = 0.020 },
		-- Custom F
		[37] = { "light", 			Vector(443.2,25.0-1.8*2,1.15), Angle(0,0,0), Color(255,160,0), brightness = 1.0, scale = 0.020 },
		-- Custom G
		[38] = { "light", 			Vector(443.2,25.0-1.8*3,1.15), Angle(0,0,0), Color(100,255,0), brightness = 1.0, scale = 0.020 },
		
		-- LSP
		[39] = { "light",			Vector(444.55,11.3-23.0,-1.45), Angle(0,0,0), Color(255,0,0), brightness = 1.0, scale = 0.020 },
	
		-- ARS panel lights
		[40] = { "light", Vector(448.26,11.0,7.84)+vY*5.15+vX*3.14,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[41] = { "light", Vector(448.26,11.0,7.84)+vY*5.15+vX*4.28,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[42] = { "light", Vector(448.26,11.0,7.84)+vY*5.18+vX*5.49,				Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[43] = { "light", Vector(448.26,11.0,7.84)+vY*5.22+vX*7.74,				Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[44] = { "light", Vector(448.26,11.0,7.84)+vY*5.23+vX*11.07,			Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[45] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*0),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[46] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*1),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[47] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*2),	Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[48] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*3),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[49] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*4),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[50] = { "light", Vector(448.26,11.0,7.84)+vY*2.63+vX*(5.52+1.10*5),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[51] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*0)+vX*12.70,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[52] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*1)+vX*12.71,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[53] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*2)+vX*12.72,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[54] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*3)+vX*12.73,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[55] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*0)+vX*16.05,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[56] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*1)+vX*16.06,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[57] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*2)+vX*16.07,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[58] = { "light", Vector(448.26,11.0,7.84)+vY*(1.37+1.29*3)+vX*16.08,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },		
		
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
end

--------------------------------------------------------------------------------
function ENT:Think()
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 1.0 then
		--table.insert(self.SignsList,"Синергия-1")
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
	self:SetLightPower(1, self.Panel["HeadLights3"] and (self.Panel["HeadLights3"] > 0.5) and (self.L_4.Value > 0.5),brightness)
	
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
	if self.TrainModel == 2 and self.Lights[4][2] ~= Vector(460,-4, 55) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(460,-51,-23)
		 self.Lights[3][2] = Vector(460,-40, -23)
		 self.Lights[4][2] = Vector(460,-4, 55)
		 self.Lights[5][2] = Vector(460, 6, 55)
		 self.Lights[6][2] = Vector(460, 40, -23)
		 self.Lights[7][2] = Vector(460, 51,-23)
	end
	if self.TrainModel == 3 and self.Lights[4][2] ~= Vector(0,0, 0) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(455,-51,-23)
		 self.Lights[3][2] = Vector(457,-40, -23)
		 self.Lights[4][2] = Vector(0,0, 0)
		 self.Lights[5][2] = Vector(0, 0, 0)
		 self.Lights[6][2] = Vector(457, 40, -23)
		 self.Lights[7][2] = Vector(455, 51,-23)
	end
	if self.TrainModel == 1 and self.Lights[4][2] ~= Vector(460,-7, -23) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(460,-51,-23)
		 self.Lights[3][2] = Vector(460,-18,-23)
		 self.Lights[4][2] = Vector(460,-7, -23)
		 self.Lights[5][2] = Vector(460, 7, -23)
		 self.Lights[6][2] = Vector(460, 18,-23)
		 self.Lights[7][2] = Vector(460, 51,-23)
	end
	if self.Panel["HeadLights1"] and self.Panel["HeadLights2"] then
		if self.ARSType == 3 then
			if self.TrainModel == 1 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
			elseif self.TrainModel == 2 then
				self:SetLightPower(2, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
			end
		else
			if self.TrainModel == 2 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
			elseif self.TrainModel == 1 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
			end
		end
		if self.TrainModel == 3 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4, false)
				self:SetLightPower(5, false)
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
	end
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
	self:SetLightPower(10, (self.Panel["CabinLight"] > 0.5) and (self.L_2.Value > 0.5))
	self:SetLightPower(30, (self.Panel["CabinLight"] > 0.5), 0.03 + 0.97*self.L_2.Value)
	
	local lightsActive1 = (self.Battery.Voltage > 55.0 and self.Battery.Voltage < 85.0) and
		((self:ReadTrainWire(33) > 0) or (self:ReadTrainWire(34) > 0))
	local lightsActive2 = (self.PowerSupply.XT3_4 > 65.0) and
		(self:ReadTrainWire(33) > 0)
	--print(lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	self:SetLightPower(11, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	self:SetLightPower(12, lightsActive2, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	self:SetLightPower(13, lightsActive1, 0.2*self:ReadTrainWire(34) + 0.8*self:ReadTrainWire(33))
	for i = 1,23 do
		self:SetLightPower(69+i,lightsActive2 and true or lightsActive1 and i%5==1 or false)
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
	self:SetLightPower(27, (self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0))
	self:SetLightPower(28, (self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0))
	self:SetLightPower(29, (self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 1))
	
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
	self:SetLightPower(35,self.CustomD.Value == 1.0)
	self:SetLightPower(36,self.CustomE.Value == 1.0)
	self:SetLightPower(37,self.CustomF.Value == 1.0)
	self:SetLightPower(38,self.CustomG.Value == 1.0)
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
	
	self:SetPackedBool(160,self.ParkingBrake.Value > 0)
	self:SetPackedBool(161,self.ParkingBrakeSign.Value > 0)
	self:SetPackedBool(162,self.KB.Value == 1.0)
	self:SetPackedBool(163,self.KAH.Value == 1.0)
	self:SetPackedBool(164,self.OldKVPos)
	
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
	if (self.KV.ControllerPosition == 0) or (self.Panel["V1"] < 0.5) then self.RTW18 = 1e9 end
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
	self:SetBodygroup(2,(self.ARSType or 1)-1)
	if self.ARSType == 2 then
		-- LSD
		self:SetLightPower(40,self:GetPackedBool(40) and self:GetPackedBool(32))
		self:SetLightPower(41,self:GetPackedBool(40) and self:GetPackedBool(32))
		-- LHRK
		self:SetLightPower(42,self:GetPackedBool(33) and self:GetPackedBool(32))
		-- RP LSN
		self:SetLightPower(43,self:GetPackedBool(35) and self:GetPackedBool(32))
		self:SetLightPower(44,self:GetPackedBool(131) and self:GetPackedBool(32))
		--self:SetLightPower(43,(self:GetPackedBool(35) or self:GetPackedBool(131)) and self:GetPackedBool(32),self:GetPackedBool(35) and 1 or 0.35)
		--self:SetLightPower(44,self:GetPackedBool(131) and self:GetPackedBool(32))
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
--------------------------------------------------------------------------------
function ENT:OnButtonPress(button)
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
	if button:find("CabinDoor") then
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
	if button == "AirDistributorDisconnectToggle" then return end
	if button == "NextSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex + 1
		if self.SignsIndex > #self.SignsList then self.SignsIndex = 1 end
		
		self:SetNWString("FrontText",self.SignsList[self.SignsIndex])
	end
	if button == "PrevSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex - 1
		if self.SignsIndex < 1 then self.SignsIndex = #self.SignsList end
		
		self:SetNWString("FrontText",self.SignsList[self.SignsIndex])
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

	if button == "KVSetT1A" then
		if self.KV.ControllerPosition == -2 then
			self.KV:TriggerInput("ControllerSet",-1)
			timer.Simple(0.20,function()
				self.KV:TriggerInput("ControllerSet",-2)			
			end)
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