AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BogeyDistance = 650 -- Needed for gm trainspawner


---------------------------------------------------
-- Defined train information
-- Types of wagon(for wagon limit system):
-- 0 = Head or intherim
-- 1 = Only head
-- 2 = Only intherim
---------------------------------------------------
ENT.SubwayTrain = {
	Type = "81",
	Name = "81-717.5m",
	Manufacturer = "LVZ",
	WagType = 1,
}

function ENT:Initialize()
	self.Plombs = {
		VAH = true,
		VAD = true,
		OtklAVU = true,
		OVT = true,
		RC1 = true,
		A5 = true,
		Init = true,
	}
	-- Set model and initialize
	self.MaskType = 1
	self.LampType = 1
	self.WorkingLights = 6
	self:SetModel("models/metrostroi_train/81/81-717.mdl")
	self.BaseClass.Initialize(self)
	self:SetPos(self:GetPos() + Vector(0,0,140))

	-- Create seat entities
	self.DriverSeat = self:CreateSeat("driver",Vector(421,0,-23+7.8))
	self.InstructorsSeat = self:CreateSeat("instructor",Vector(420,50,-28+3),Angle(0,270,0))
	self.ExtraSeat1 = self:CreateSeat("instructor",Vector(410,-40,-28+1))
	self.ExtraSeat2 = self:CreateSeat("instructor",Vector(430,-50,-43),Angle(0,180,0),"models/vehicles/prisoner_pod_inner.mdl")
	self.ExtraSeat3 = self:CreateSeat("instructor",Vector(402,50,-43),Angle(0,-40+90,0),"models/vehicles/prisoner_pod_inner.mdl")

	-- Hide seats
	self.DriverSeat:SetColor(Color(0,0,0,0))
	self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.InstructorsSeat:SetColor(Color(0,0,0,0))
	self.InstructorsSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat1:SetColor(Color(0,0,0,0))
	self.ExtraSeat1:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat2:SetColor(Color(0,0,0,0))
	self.ExtraSeat2:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.ExtraSeat3:SetColor(Color(0,0,0,0))
	self.ExtraSeat3:SetRenderMode(RENDERMODE_TRANSALPHA)

	-- Create bogeys
	self.FrontBogey = self:CreateBogey(Vector(317-5,0,-75),Angle(0,180,0),true)
	self.RearBogey  = self:CreateBogey(Vector(-317+0,0,-75),Angle(0,0,0),false)

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

		[KEY_PAD_0] = "DriverValveDisconnect",
		[KEY_PAD_DECIMAL] = "EPKToggle",
		[KEY_LSHIFT] = {
			[KEY_W] = "KVUp_Unlocked",
			[KEY_SPACE] = "KVTSet",
			[KEY_F] = "BCCDSet",
			[KEY_R] = "VZPSet",

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

			[KEY_PAD_7] = "BFSet",
			[KEY_PAD_8] = "BUpSet",
			[KEY_PAD_9] = "BMSet",
			[KEY_PAD_4] = "BLeftSet",
			[KEY_PAD_5] = "BDownSet",
			[KEY_PAD_6] = "BRightSet",
			[KEY_PAD_ENTER] = "BPSet",
		},

		[KEY_RSHIFT] = {
			[KEY_7] = "KVWrenchNone",
			[KEY_8] = "KVWrenchKRU",
			[KEY_9] = "KVWrenchKV",
			[KEY_0] = "KVWrench0",
			[KEY_L] = "DriverValveDisconnectToggle",
			[KEY_F] = "BCCDSet",
			[KEY_R] = "VZPSet",

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
			[KEY_PAD_DECIMAL] = "BEscSet",
			[KEY_PAD_ENTER] = "BEnterSet",
			[KEY_UP] = "BUpSet",
			[KEY_LEFT] = "BLeftSet",
			[KEY_DOWN] = "BDownSet",
			[KEY_RIGHT] = "BRightSet",
			[KEY_PAD_MINUS] = "BFSet",
			[KEY_PAD_PLUS] = "BMSet",
			[KEY_PAD_MULTIPLY] = "BPSet",
		},
		[KEY_RALT] = {
			[KEY_L] = "EPKToggle",
		},
	}

	self.InteractionZones = {
		--{	Pos = Vector(460,-26,-47),
--			Radius = 16,
			--ID = "FrontBrakeLineIsolationToggle" },
		--{	Pos = Vector(460, 21, -49),
--			Radius = 16,
			--ID = "FrontTrainLineIsolationToggle" },
		--{	Pos = Vector(-482,30,-55),
--			Radius = 16,
			--ID = "RearTrainLineIsolationToggle" },
		--{	Pos = Vector(-469, -23, -48),
--			Radius = 16,
			--ID = "RearBrakeLineIsolationToggle" },
		--{	Pos = Vector(122, 61, -53),
--			Radius = 16,
			--ID = "GVToggle" },
		--{	Pos = Vector(405, -53, 21),
--			Radius = 30,
			--ID = "VBToggle" },
		--{	Pos = Vector(-180,61,-53),
--			Radius = 20,
			--ID = "AirDistributorDisconnectToggle" },
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

	local vX = Angle(0,-90-0.2,56.3):Forward() -- For ARS panel
	local vY = Angle(0,-90-0.2,56.3):Right()
	self.Lights = {
		-- Headlight glow
		[1] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(216,161,92), fov = 100, farz=6144,brightness = 4},

		-- Head (type 1)
		[2] = { "glow",				Vector(470,-51,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },
		[3] = { "glow",				Vector(472,-40, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[4] = { "glow",				Vector(0,0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[5] = { "glow",				Vector(0, 0, 0), Angle(0,0,0),  Color(255,220,180), brightness = 1, scale = 1.0 },
		[6] = { "glow",				Vector(472, 41, -19), Angle(0,0,0),Color(255,220,180), brightness = 1, scale = 1.0 },
		[7] = { "glow",				Vector(470, 53,-19), Angle(0,0,0), Color(255,220,180), brightness = 1, scale = 1.0 },

		-- Reverse
		[8] = { "light",			Vector(472,-41, 60), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1 },
		[9] = { "light",			Vector(472, 45, 60), Angle(0,0,0), Color(255,0,0),     brightness = 10, scale = 1 },

		-- Cabin
		[10] = { "dynamiclight",	Vector( 430, 0, 40), Angle(0,0,0), Color(255,255,255), brightness = 0.05, distance = 550 },

		-- Interior
		[11] = { "dynamiclight",	Vector( 200, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },
		[12] = { "dynamiclight",	Vector(   0, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400, fov=180,farz = 128 },
		[13] = { "dynamiclight",	Vector(-200, 0, 10), Angle(0,0,0), Color(255,175,50), brightness = 3, distance = 400 , fov=180,farz = 128 },

		-- Side lights
		[15] = { "light",			Vector(15,   69, 58.3), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[16] = { "light",			Vector(12,   69, 58.3), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[17] = { "light",			Vector(9,  69, 58.3), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },

		[19] = { "light",			Vector(15,   -69, 58.3), Angle(0,0,0), Color(150,255,255), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[20] = { "light",			Vector(12,   -69, 58.3), Angle(0,0,0), Color(50,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },
		[21] = { "light",			Vector(9,  -69, 58.3), Angle(0,0,0), Color(255,255,0), brightness = 0.9, scale = 0.10, texture = "sprites/light_glow02.vmt" },

	--self.Lights[22]
		--self.Lights[26]
	--self.Lights[23]

		-- Cabin texture light
		[30] = { "headlight", 		Vector(412.0,30,60), Angle(60,-50,0), Color(176,161,132), farz = 128, nearz = 1, shadows = 0, brightness = 0.20, fov = 140 },
		-- Manometers
		[31] = { "headlight", 		Vector(460.00,3,8.5), Angle(0,-90,0), Color(240,140,70), farz = 32, nearz = 1, shadows = 0, brightness = 1.0, fov = 30 },
		-- Voltmeter
		[32] = { "headlight", 		Vector(460.00,10,12.5), Angle(28,90,0), Color(240,140,70), farz = 16, nearz = 1, shadows = 0, brightness = 1.0, fov = 40 },
		-- Ampermeter
		[33] = { "headlight", 		Vector(458.05,-32.8+1.5,21.1), Angle(-90,0,0), Color(240,140,70), farz = 10, nearz = 1, shadows = 0, brightness = 1.0, fov = 60 },
		-- Voltmeter
		[34] = { "headlight", 		Vector(458.05,-32.8+1.5,24.85), Angle(-90,0,0), Color(240,140,70), farz = 10, nearz = 1, shadows = 0, brightness = 1.0, fov = 60 },


		-- ARS panel lights
		[40] = { "light", Vector(459.4,10.8,13.1)+vY*5.15+vX*3,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[41] = { "light", Vector(459.4,10.8,13.1)+vY*5.15+vX*4.15,				Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[42] = { "light", Vector(459.4,10.8,13.1)+vY*5.15+vX*5.4,				Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[43] = { "light", Vector(459.4,10.8,13.1)+vY*5.17+vX*7.55,				Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[44] = { "light", Vector(459.4,10.8,13.1)+vY*5.19+vX*10.9,			Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[45] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*0),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[46] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*1),	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[47] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*2),	Angle(0,0,0), Color(255,190,0), brightness = 1.0, scale = 0.008 },
		[48] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*3),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[49] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*4),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[50] = { "light", Vector(459.4,10.8,13.1)+vY*2.61+vX*(5.42+1.09*5),	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[51] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*0)+vX*12.55,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[52] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*1)+vX*12.56,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[53] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*2)+vX*12.57,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[54] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*3)+vX*12.58,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[55] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*0)+vX*15.85,	Angle(0,0,0), Color(255,30, 0), brightness = 1.0, scale = 0.008 },
		[56] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*1)+vX*15.86,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[57] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*2)+vX*15.87,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },
		[58] = { "light", Vector(459.4,10.8,13.1)+vY*(1.37+1.27*3)+vX*15.88,	Angle(0,0,0), Color(160,255,0), brightness = 1.0, scale = 0.008 },

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
		[70    ] = { "headlight",	Vector( 430, -60, -47), Angle(45,-90,0), Color(255,255,255), brightness = 0.5, distance = 400 , fov=120, shadows = 1 },

		--[[2-2
		[97] = { "headlight",		Vector(465,-45,-19), Angle(0,-20,0), Color(216,161,92), fov = 70 },
		[98] = { "headlight",		Vector(465,45,-19), Angle(0,20,0), Color(216,161,92), fov = 70 },
		1-4-1
		2-2-2
		1-3-1
		[97] = { "headlight",		Vector(460,-45,-10), Angle(-5,-20,0), Color(216,161,92), fov = 70 },
		[98] = { "headlight",		Vector(465,0,-10), Angle(-5,0,0), Color(216,161,92), fov = 70 },
		[99] = { "headlight",		Vector(460,45,-10), Angle(-5,20,0), Color(216,161,92), fov = 70 },
		]]
	}
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

	self.KVPType = self.KVPType or 0+math.floor(math.random()*4+1.5)
	if self.KVPType == 1 then self.KVPType = 0 end
	-- BPSN type
	self.BPSNType = self.BPSNType or 2+math.floor(Metrostroi.PeriodRandomNumber()*7+0.5)
	self:SetNW2Int("BPSNType",self.BPSNType)
	self:SetNW2Int("KVPType",self.KVPType)

	self.Blok = 1
	self:SetNW2Int("Blok",1)

	self.RearDoor = false
	self.FrontDoor = false
	self.CabinDoor = false
	self.PassengerDoor = false

	self.OldTexture = 0
	self.LampsBlink = {}
	self.Lamps = {}
	self.BrokenLamps = {}
	local rand = math.random() > 0.5 and 1 or math.random(0.93,0.99)
	for i = 1,23 do
		if math.random() > rand then self.BrokenLamps[i] = math.random() > 0.5 end
	end

	self:UpdateTextures()
end

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self.Texture]
	local passtexture = Metrostroi.Skins["pass"][self.PassTexture]
	local cabintexture = Metrostroi.Skins["cab"][self.CabTexture]

	for k in pairs(self:GetMaterials()) do
		self:SetSubMaterial(k-1,"")
	end
	local cab = self.Blok == 4 and "paksdm" or self.Blok == 3 and "pam" or self.Blok == 2 and "paksd" or "puav"
	for k,v in pairs(self:GetMaterials()) do
		if v == "models/metrostroi_train/81/int02" then
			if not Metrostroi.Skins["717_schemes"] or not Metrostroi.Skins["717_schemes"]["p"] then
				self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"][""])
			else
				if not self.Adverts or self.Adverts ~= 4 then
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["p"].adv)
				else
					self:SetSubMaterial(k-1,Metrostroi.Skins["717_schemes"]["p"].clean)
				end
			end
		elseif v == "models/metrostroi_train/81/tabl" then
			if not self.SignsList then
				self:PrepareSigns()
			end
			if self.SignsList[self.SignsIndex] then self:SetSubMaterial(k-1,self.SignsList[self.SignsIndex][1])  end
		end
		local tex = string.Explode("/",v)
		tex = tex[#tex]
		if cabintexture and cabintexture.textures[cab][tex] then
			self:SetSubMaterial(k-1,cabintexture.textures[cab][tex])
		end
		if passtexture and passtexture.textures[tex] then
			self:SetSubMaterial(k-1,passtexture.textures[tex])
		end
		if texture and texture.textures[tex] then
			self:SetSubMaterial(k-1,texture.textures[tex])
		end
	end
	self:SetNW2Int("Blok",(self.Blok or 1))
	self:SetNW2Bool("Breakers",(self.Breakers or 0) > 0)
	self:SetNW2Int("LampType",(self.LampType or 1))
	self:SetNW2Bool("BPSNBuzzType",self.PNM)
	self:SetNW2String("texture",self.Texture)
	self:SetNW2String("passtexture",self.PassTexture)
	self:SetNW2String("cabtexture",self.CabTexture)
end
function ENT:Think()
	if self.Breakers ~= self.OldBreakers then
		if self.Breakers == 1 then
				self.SoundNames["r1_5_close"] = {"subway_trains/drive_on1.wav","subway_trains/drive_on2.wav"}
		else
				self.SoundNames["r1_5_close"] = {"subway_trains/drive_on3.wav","subway_trains/drive_on4.wav"}
		end
		self.OldBreakers = self.Breakers
	end
	if self.KVSnd ~= self.OldKVSnd then
		if self.KVSnd == 3 then
			self.R1_5:TriggerInput("CloseTime",0.1)
		else
			self.R1_5:TriggerInput("CloseTime",0)
		end
		self.OldKVSnd = self.KVSnd
	end
	if self.SignsIndex ~= self.OldSignsIndex then
		for k,v in pairs(self:GetMaterials()) do
			if v == "models/metrostroi_train/81/tabl" then
				if not self.SignsList then
					self:PrepareSigns()
				end
				if self.SignsList[self.SignsIndex] then self:SetSubMaterial(k-1,self.SignsList[self.SignsIndex][1]) end
			end
		end
		self.OldSignsIndex = self.SignsIndex
	end
	self.ExtraSeat1:SetPos(Vector(420,-40,-28+1))
	--self.ExtraSeat3:SetPos(Vector(402,50,-43))
	if self.VUD1.Value > 0 and self.VUD2.Value > 0 and self.ASNP31.Value == 0 then self.ASNP31:TriggerInput("Set",1) self.ASNP32:TriggerInput("Set",1) end
	if (self.VUD1.Value == 0 or self.VUD2.Value == 0) and self.ASNP31.Value > 0 then self.ASNP31:TriggerInput("Set",0) self.ASNP32:TriggerInput("Set",0) end
	if self.Plombs and self.Plombs.Init then
		self.Plombs.Init = nil
		for k in pairs(self.Plombs) do
			self[k]:TriggerInput("Reset",true)
			self[k]:TriggerInput("Block",true)
		end
	end
	if self.YAR_13A.Slope and self.YAR_13A.Slope == 0 and self:GetAngles().pitch*self.SpeedSign <= -1 then
		self.YAR_13A:TriggerInput("Slope",1)
	end
	if self.YAR_13A.Slope and self.YAR_13A.Slope > 0 and self:GetAngles().pitch*self.SpeedSign > -1 then
		self.YAR_13A:TriggerInput("Slope",0)
	end	if self.Lights[11] and self.LampType and self.LampType == 1 and self.Lights[11][4] ~= Color(255,175,75) then
		for i = 11,13 do
			self:SetLightPower(i,false)
			self.Lights[i][4] = Color(255,175,75)
		end
	end
	if self.Lights[11] and self.LampType and self.LampType > 1 and ((self.Lights[11][4] ~= Color(200,200,255)  and self.LampType == 2) or (self.Lights[11][4] ~= Color(255,255,255)  and self.LampType == 3)) then
		for i = 11,13 do
			self:SetLightPower(i,false)
			if self.LampType == 2 then
				self.Lights[i][4] = Color(200,200,255)
			elseif self.LampType == 3 then
				self.Lights[i][4] = Color(255,255,255)
			end
		end
	end

	self:SetBodygroup(1,(self.Breakers or 0))
	self:SetBodygroup(2,math.min(3,self.Adverts or 1)-1)
	self:SetBodygroup(3,2)
	self:SetBodygroup(4,(self.LampType or 1)-1)
	self:SetBodygroup(5,6)
	self:SetBodygroup(6,(self.MaskType or 1)-1)
	self:SetBodygroup(7,(self.SeatType or 1)-1)
	self:SetBodygroup(8,(self.HandRail or 1)-1)
	self:SetBodygroup(9,2)
	self:SetBodygroup(10,(self.BortLampType or 1)-1)
	self:SetBodygroup(12,0)
	self:SetBodygroup(13,1-(self.Lighter or 0))
	self:SetBodygroup(16,2-self.Pneumatic.ValveType)
	self:SetBodygroup(17,self.Blok)
	self:SetBodygroup(18,1)
	--self:SetSubMaterial(0,"metrostroi_skins/81-717/6.pnqw")
	--PrintTable(self:GetMaterials())
	--print(self.DeltaTime)
	--print(self.SpeedSign)
	--if not self.SpeedSign then return end
	--self.Lights[1] = { "headlight",		Vector(465,0,-20), Angle(0,0,0), Color(216,161,92), fov = 100, farz=8192,brightness = 5}
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
	self:SetLightPower(1,self.Panel["HeadLights3"] and (self.Panel["HeadLights3"] > 0.5 or self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5),brightness*self.WorkingLights/6)

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
	if self.MaskType == 1 and self.Lights[4][2] ~= Vector(467,-7, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(465,-50,-19)
		 self.Lights[3][2] = Vector(467,-19,-19)
		 self.Lights[4][2] = Vector(467,-7, -19)
		 self.Lights[5][2] = Vector(467, 7, -19)
		 self.Lights[6][2] = Vector(467, 19,-19)
		 self.Lights[7][2] = Vector(465, 52,-19)
		 self.WorkingLights = 6
	end
	if self.MaskType == 2 and self.Lights[4][2] ~= Vector(467,-4, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(467,-51,-19)
		 self.Lights[3][2] = Vector(467,-38, -19)
		 self.Lights[4][2] = Vector(467,-4, -19)
		 self.Lights[5][2] = Vector(467, 6, -19)
		 self.Lights[6][2] = Vector(467, 38, -19)
		 self.Lights[7][2] = Vector(467, 51,-19)
		 self.WorkingLights = 6
	end
	if self.MaskType == 3 and (self.Lights[3][2] ~= Vector(467,-38, -19) or self.Lights[4][2] ~= Vector(0,0, 0)) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(467,-51,-19)
		 self.Lights[3][2] = Vector(467,-38, -19)
		 self.Lights[4][2] = Vector(0,0, 0)
		 self.Lights[5][2] = Vector(0, 0, 0)
		 self.Lights[6][2] = Vector(467, 38, -19)
		 self.Lights[7][2] = Vector(467, 51,-19)
		 self.WorkingLights = 4
	end
	if self.MaskType == 4 and self.Lights[4][2] ~= Vector(467,-4, 58) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(467,-51,-19)
		 self.Lights[3][2] = Vector(467,-38, -19)
		 self.Lights[4][2] = Vector(467,-4, 58)
		 self.Lights[5][2] = Vector(467, 6, 58)
		 self.Lights[6][2] = Vector(467, 38, -19)
		 self.Lights[7][2] = Vector(467, 51,-19)
		 self.WorkingLights = 6
	end
	if self.MaskType == 5 and self.Lights[4][2] ~= Vector(467,1, -19) then
		for i = 1,7 do self:SetLightPower(i,false) end
		 self.Lights[2][2] = Vector(465,-50,-19)
		 self.Lights[3][2] = Vector(467,-12,-19)
		 self.Lights[4][2] = Vector(467,1, -19)
		 self.Lights[5][2] = Vector(467, 12, -19)
		 self.Lights[6][2] = Vector(0, 0,0)
		 self.Lights[7][2] = Vector(465, 52,-19)
		 self.WorkingLights = 6
	end
	if self.Panel["HeadLights1"] and self.Panel["HeadLights2"] then
		if self.MaskType == 1 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4,  (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5,  (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 2 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4,  (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5,  (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 3 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4,  false)
				self:SetLightPower(5,  false)
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 4 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4,  (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5,  (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
		if self.MaskType == 5 then
				self:SetLightPower(2, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(3, (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(4,  (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(5,  (self.Panel["HeadLights1"] > 0.5) and (self.L_4.Value > 0.5))
				self:SetLightPower(6, false)
				self:SetLightPower(7, (self.Panel["HeadLights2"] > 0.5) and (self.L_4.Value > 0.5))
		end
	end

	-- Reverser lights
	self:SetLightPower(8, self.Panel["RedLightRight"] > 0.5)
	self:SetLightPower(9, self.Panel["RedLightLeft"] > 0.5)

	-- Interior/cabin lights
	self:SetLightPower(10,(self.Panel["CabinLight"] > 0.5) and (self.L_2.Value > 0.5))
	self:SetLightPower(30, (self.Panel["CabinLight"] > 0.5), 0.03 + 0.97*self.L_2.Value)

	local lightsActive1 = (self.Battery.Voltage > 55.0 and self.Battery.Voltage < 85.0) and
		((self:ReadTrainWire(33) > 0) or (self:ReadTrainWire(34) > 0))
	local lightsActive2 = (self.PowerSupply.LightsActive > 0.0) and
		(self:ReadTrainWire(33) > 0)
	local mul = 0
	local LampCount  = (self.LampType == 1 and 23 or 12)
	for i = 1,LampCount do
		local Ip = self.LampType == 1 and 6 or 3
		if (lightsActive2 or (lightsActive1 and (i+Ip-2)%Ip==1)) then
			if not self.BrokenLamps[i]  and not self.LampsBlink[i] then self.LampsBlink[i] = CurTime() + math.random() end
			if self.BrokenLamps[i] == nil and self.LampsBlink[i] and CurTime() - self.LampsBlink[i] > 0 and not self.Lamps[i] then self.Lamps[i] = CurTime() + math.random()*4 end
		else
			self.LampsBlink[i] = nil
			self.Lamps[i] = nil
		end
		if (self.Lamps[i] and CurTime() - self.Lamps[i] > 0) then
			mul = mul + 1
		elseif (self.LampsBlink[i] and CurTime() - self.LampsBlink[i] > 0) then
			mul = mul + 0.5
		end
		self:SetPackedBool("lightsActive"..i,(self.Lamps[i] and CurTime() - self.Lamps[i] > 0) or false)
		self:SetPackedBool("lightsActiveB"..i,(self.LampsBlink[i] and CurTime() - self.LampsBlink[i] > 0) or false)
	end
	self:SetLightPower(11, mul > 0,mul/LampCount)
	self:SetLightPower(12, mul > 0,mul/LampCount)
	self:SetLightPower(13, mul > 0,mul/LampCount)

	self:SetLightPower(31, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(32, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(33, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))
	self:SetLightPower(34, (self.Panel["CabinLight"] > 0.5) and (self.L_3.Value > 0.5))

	-- Door button lights
	self:SetPackedBool("Left",(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0) and self:ReadTrainWire(16) < 1)
	self:SetPackedBool("Right",(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 1) and self:ReadTrainWire(16) < 1)
	self:SetPackedBool("KDLK",self.KDLK.Value > 0)
	self:SetPackedBool("KDLRK",self.KDLRK.Value > 0)
	self:SetPackedBool("KDPK",self.KDPK.Value > 0)
	self:SetPackedBool("KAHK",self.KAHK.Value > 0)
	if not self.Blok or self.Blok == 1 then
		self:SetPackedBool("W16",self:ReadTrainWire(16) > 0)
		self:SetPackedBool("ARS",self.ALS_ARS.EnableARS)
		self:SetPackedBool("AVT",self.Autodrive.AutodriveEnabled)
		self:SetPackedBool("LOS",self.RC1.Value < 0.5 and not self.ALS_ARS.EnableARS and self.KV.ReverserPosition ~= 0.0)
		self:SetPackedBool("KH",self.KH.Value > 0.5)
		self:SetPackedBool("VAV",self.VAV.Value > 0.5)
		self:SetPackedBool("P1",self.P1.Value > 0.5)
		self:SetPackedBool("P2",self.P2.Value > 0.5)
		self:SetPackedBool("P3",self.P3.Value > 0.5)
		self:SetPackedBool("P4",self.P4.Value > 0.5)
		self:SetPackedBool("P5",self.P5.Value > 0.5)
	end
	--self:SetLightPower(27,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	--self:SetLightPower(28,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 0) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	--self:SetLightPower(29,(self.Panel["HeadLights2"] > 0.5) and (self.DoorSelect.Value == 1) and (self.ARSType < 3 or self.ARSType == 3 and self:ReadTrainWire(16) < 1))
	if self.BortLampType == 1 and self.Lights[19][2] ~=  Vector(15,   -69, 58.3) then
		for i = 0,2 do self:SetLightPower(15+i,false) end
		for i = 0,2 do self:SetLightPower(19+i,false) end
		self.Lights[15][2] = Vector(15,   69, 58.3)
		self.Lights[16][2] = Vector(12,   69, 58.3)
		self.Lights[17][2] = Vector(9,  69, 58.3)

		self.Lights[19][2] = Vector(15,   -69, 58.3)
		self.Lights[20][2] = Vector(12,   -69, 58.3)
		self.Lights[21][2] = Vector(9,  -69, 58.3)
	end
	if self.BortLampType == 2 and self.Lights[19][2] ~= Vector(41.8,   -69, 55.8)then
		for i = 0,2 do self:SetLightPower(15+i,false) end
		for i = 0,2 do self:SetLightPower(19+i,false) end
		self.Lights[15][2] = Vector(-48.0,   69, 55.8)
		self.Lights[16][2] = Vector(-48.0,   69, 53.7)
		self.Lights[17][2] = Vector(-48.0,  69, 50.2)

		self.Lights[19][2] = Vector(41.8,   -69, 55.8)
		self.Lights[20][2] = Vector(41.8,   -69, 53.7)
		self.Lights[21][2] = Vector(41.8,  -69, 50.2)
	end
	-- Side lights
	self:SetLightPower(15, self.Panel["TrainDoors"] > 0.5)
	self:SetLightPower(19, self.Panel["TrainDoors"] > 0.5)

	self:SetLightPower(16, self.Panel["GreenRP"] > 0.5)
	self:SetLightPower(20, self.Panel["GreenRP"] > 0.5)

	self:SetLightPower(17, self.Panel["TrainBrakes"] > 0.5)
	self:SetLightPower(21, self.Panel["TrainBrakes"] > 0.5)
	self:SetPackedBool("PN", self.Panel["TrainBrakes"] > 0.5)
	local OhrSigWork = false
	for _,v in pairs(self.WagonList) do
		if v.OhrSig and v.OhrSig.Value > 0 then OhrSigWork = true break end
	end
	self.Panel.OhrSig = 0
	for _,v in pairs(self.WagonList) do
		if v.PassengerDoor then self.Panel.OhrSig = 1 end
	end
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
	self:SetPackedBool("KDLR",self.KDLR.Value == 1.0)
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
	self:SetPackedBool(125,self.R_G.Value == 1.0)
	self:SetPackedBool(126,self.R_Radio.Value == 1.0)
	self:SetPackedBool(127,self.R_UPO.Value == 1.0)
	self:SetPackedBool("VPR",self.Radiostation.State > 0 and self.Panel["V1"])
	self:SetPackedBool(128,self.OhrSig.Value == 1.0)
	self:SetPackedBool(129,self.OVT.Value == 1.0)
	self:SetPackedBool(130,self.RC1.Value == 1.0)
	self:SetPackedBool(132,self:ReadTrainWire(48) ~= -1)
	self:SetPackedBool(134,self.VAU.Value == 1.0)
	self:SetPackedBool(135,self.RC2.Value == 1.0)
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
	self:SetPackedBool(163,self.Panel.OhrSig == 1.0)
	self:SetPackedBool(164,OhrSigWork and self.Panel.OhrSig == 1.0)
	self:SetPackedBool(165,self.PB.Value > 0)
	self:SetPackedBool("VPA1",self.VPA.Value == 2)
	self:SetPackedBool("VPA2",self.VPA.Value == 0)
	self:SetPackedBool("Indicate1",self.Indicate.Value == 1.0)
	self:SetPackedBool("Indicate2",self.Indicate.Value == 2.0)
	self:SetPackedBool("Indicate3",self.Indicate.Value == 3.0)
	self:SetPackedBool("BCCD",self.BCCD.Value == 1.0)
	self:SetPackedBool("VZP",self.VZP.Value == 1.0)
	self:SetPackedBool("VRD",self.VRD.Value == 1.0)
	if self.Blok > 1 then
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
		if self.Blok >= 3 then
			self:SetPackedBool("BRight", self.BRight.Value == 1.0)
			self:SetPackedBool("BEsc", self.BEsc.Value == 1.0)
			self:SetPackedBool("BF", self.BF.Value == 1.0)
			self:SetPackedBool("BM", self.BM.Value == 1.0)
			self:SetPackedBool("BP", self.BP.Value == 1.0)
		end
	end
	self:SetPackedBool("VZ1",self.VZ1.Value == 1)
	self:SetPackedBool("Wiper",self.Wiper.Value == 1)
	self:SetPackedBool("ConverterProtection",self.ConverterProtection.Value == 1)
	self:SetPackedBool("RZP",self:ReadTrainWire(35) == 1)
	self:SetPackedBool("DriverValveBLDisconnect",self.DriverValveBLDisconnect.Value == 1.0)
	self:SetPackedBool("DriverValveTLDisconnect",self.DriverValveTLDisconnect.Value == 1.0)
	if self.DriverValveDisconnect.Blocked > 0 and self.Pneumatic.ValveType == 2 then
		self.DriverValveDisconnect:TriggerInput("Block",0)
		self.DriverValveBLDisconnect:TriggerInput("Block",1)
		self.DriverValveTLDisconnect:TriggerInput("Block",1)
	end
	if self.DriverValveDisconnect.Blocked == 0 and self.Pneumatic.ValveType == 1 then
		self.DriverValveDisconnect:TriggerInput("Block",1)
		self.DriverValveBLDisconnect:TriggerInput("Block",0)
		self.DriverValveTLDisconnect:TriggerInput("Block",0)
	end
	for k,v in pairs(self.Plombs) do
		self:SetPackedBool(k.."Pl",v)
		if not v then v = nil end
	end
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
	if (self:ReadTrainWire(20) == 0) or (self.Panel["V1"] < 0.5) then self.RTW18 = 1e9 end
	self:SetPackedBool(35,self.RTW18 < 1.39-0.208*self:GetWagonCount())
	self:SetPackedBool(131,self.RTW18 < 100)
	-- Green RP
	self:SetPackedBool(36,self.Panel["GreenRP"] > 0.5)
	--self:SetLightPower(22,self.Panel["GreenRP"] > 0.5)
	-- Cabin heating
	self:SetPackedBool(37,self.Panel["KUP"] > 0.5)
	--self:SetLightPower(26,self.Panel["KUP"] > 0.5)
	-- AVU
	self:SetPackedBool(38,self.Panel["AVU"] > 0.5)
	--21.3 -0.4 5.05
		-- AVU
	--self:SetLightPower(23,self.Panel["AVU"] > 0.5)
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
	--self:SetLightPower(24,(self.PowerSupply.XT3_1 > 0) and (self.Panel["V1"] > 0.5))
	self:SetPackedBool(52,self.PowerSupply.XT3_1 > 0)
	-- LRS
	self:SetPackedBool(54,(self.Panel["V1"] > 0.5) and
		(self.ALS.Value > 0.5) and
		(self.ALS_ARS.NextLimit >= self.ALS_ARS.SpeedLimit))

	-- AV states
	for i,v in ipairs(self.Panel.AVMap) do
		if tonumber(v) then
			self:SetPackedBool(64+ (i-1), self["A"..v].Value == 1.0)
		else
			self:SetPackedBool(64+(i-1), self[v].Value == 1.0)
		end
	end

	self.SOSD = self.Panel["SD"] <= 0 and self.Panel["V1"] > 0 and self.KV.ReverserPosition ~= 0
	self:SetLightPower(70,self.SOSD)


	-- Total temperature

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
		self:SetPackedRatio(9, (-self.Pneumatic.TrainLinePressure_dPdT or 0)*6)
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
	self:SetPackedBool("LSP",(self.Electric.Overheat1 > 0) or (self.Electric.Overheat2 > 0))

	-- Update ARS system
	self:SetPackedRatio(3, self.ALS_ARS.Speed/100.0)
	if self.ALS_ARS.Ring == true then
		self:SetPackedBool(39,true)
	end

	-- RUT test
	--print(self:GetNW2Float("PassengerCount"))
	local weightRatio = 2.00*math.max(0,math.min(1,(self:GetNW2Float("PassengerCount")/300)))
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

	-- Temporary hacks
	--self:SetNW2Float("V",self.Speed)
	--self:SetNW2Float("A",self.Acceleration)

	--print(self.Electric.RPSignalResistor)

	-- Send networked variables
	--self:SendPackedData()
	if self:ReadTrainWire(5)*self:ReadTrainWire(4) > 0 and not self.RevCheck then
		self.RevCheck = CurTime()+0.25
	end
	if self.RevCheck and CurTime() - self.RevCheck > 0 then
		if self:ReadTrainWire(5)*self:ReadTrainWire(4) > 0 then
			self:TriggerInput("VUOpenBypass")
		end
		self.RevCheck = nil
	end
	return self.RetVal
end


function ENT:Check2Cab(button,breaker,_,isbreaker)
	if not istw then
		local x = (1 - self[button].TargetValue)*self[breaker].Value
		for _,v in pairs(self.WagonList) do
			if v[(isbreaker and breaker or button)] and v[button].Value*v[breaker].Value > 0.5 then
				x = x + 1
			end
		end
		if x > 1 then
			for _,v in pairs(self.WagonList) do
				if self[(isbreaker and breaker or button)] and v[button].Value*v[breaker].Value > 0.5 then
					v:TriggerInput((isbreaker and button or breaker).."Set",0)
					v:PlayOnce("av_off","cabin")
					if button:find("BPSN") then v.RZP:TriggerInput("Close",1) end
					if breaker:find("BPSN") then v.RZP:TriggerInput("Close",1) end
				end
			end
			self:TriggerInput((isbreaker and button or breaker).."OpenBypass")
			if button:find("BPSN") then self.RZP:TriggerInput("Close",1) end
			if breaker:find("BPSN") then self.RZP:TriggerInput("Close",1) end
			--self:PlayOnce("av_off","cabin")
		end
	end
end
function ENT:PhysicsCollide( colData )
	if colData.HitEntity == Entity(0) then
		--PrintTable(colData)
		file.Append("collides.txt",tostring(self:WorldToLocal(colData.HitPos)).."\n")
		print("COLLIDE")
		print(self.Owner)
		print(self:WorldToLocal(colData.HitPos))
		--print(collider)
	end
end
function ENT:BrokePlomb(but,nosnd)
	self[but]:TriggerInput("Block",false)
	self.Plombs[but] = false
	local drv = self:GetDriverName()
	if not nosnd then
		hook.Run("MetrostroiPlombBroken",self,but,drv)
		RunConsoleCommand("say",drv.." broke seal on "..but.."!")
	end

end
--------------------------------------------------------------------------------
function ENT:OnButtonPress(button,rn)
	if button:find(":") then
		button = string.Explode(":",button)[2]
	end
	if button:sub(-2,-1) == "Pl" and self.Plombs[button:sub(1,-3)]  then
		self:BrokePlomb(button:sub(1,-3))
		if button:sub(1,-3) == "KAH" then
			self:BrokePlomb("KAHK",true)
		end
		self:PlayOnce("plomb","cabin",0.7)
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
		if self.RearDoor then self:PlayOnce("door_open_tor") else self:PlayOnce("door_close_tor") end
	end
	if button:find("PassengerDoor") then
		self.PassengerDoor = not self.PassengerDoor
		if self.PassengerDoor then self:PlayOnce("door_open_tor","cabin") else self:PlayOnce("door_close_tor","cabin") end
	end
	if button == "CabinDoor" then
		self.CabinDoor = not self.CabinDoor
		if self.CabinDoor then self:PlayOnce("door_open_tor","cabin") else self:PlayOnce("door_close_tor","cabin") end
	end
	if button == "UAVAToggle" then
		local drv = self:GetDriverName()
		local state = self.UAVA.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." UAVA!")
	end
	if button == "A45Toggle" then
		local drv = self:GetDriverName()
		local state = self.A45.TargetValue < 0.5 and "enabled" or "disabled"
		RunConsoleCommand("say",drv.." "..state.." A45!")
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

		self:SetNW2String("FrontText",self.SignsList[self.SignsIndex][2])
	end
	if button == "PrevSign" then
		self:PrepareSigns()
		self.SignsIndex = self.SignsIndex - 1
		if self.SignsIndex < 1 then self.SignsIndex = #self.SignsList end

		self:SetNW2String("FrontText",self.SignsList[self.SignsIndex][2])
	end

	if button == "Num1P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end

	end
	if button == "Num1M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[2])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,2, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2P" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num + 1
		if num > 9 then num = 0 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "Num2M" then
		if not self.RouteNumber then self.RouteNumber = "00" end
		local num = tonumber(self.RouteNumber[1])
		num = num - 1
		if num < 0 then num = 9 end
		self.RouteNumber = string.SetChar(self.RouteNumber,1, num)
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
		end
	end
	if button == "RouteNumberUpdate" then
		self.RouteNumber = #rn == 0 and "00" or #rn == 1 and "0"..rn or rn
		self:SetNW2String("RouteNumber",self.RouteNumber)
		local trn = self.WagonList[#self.WagonList]
		if IsValid(trn) and trn ~= self then
			trn.RouteNumber = self.RouteNumber
			trn:SetNW2String("RouteNumber",self.RouteNumber)
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
		if self.KVWrenchMode ~= 3 and self.KV.ReverserPosition == 0 then
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
	if button == "KDL" and self.VUD1.Value < 1 then self.KDL:TriggerInput("Close",1) self:OnButtonPress("KDLSet") end
	if button == "KDP" and self.VUD1.Value < 1 then self.KDP:TriggerInput("Close",1) self:OnButtonPress("KDPSet") end
	if button == "VDL" and self.VUD1.Value < 1 then self.VDL:TriggerInput("Close",1) self:OnButtonPress("VDLSet") end
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

	if (button == "VDL") or (button == "KDL") then
		self.DoorSelect:TriggerInput("Open",1)
		self.KDLK:TriggerInput("Open",1)
		self.KDPK:TriggerInput("Close",1)
	end
	if (button == "KDP") then
		self.DoorSelect:TriggerInput("Close",1)
		self.KDLK:TriggerInput("Close",1)
		self.KDPK:TriggerInput("Open",1)
	end
	if (button == "VUD1Set") or (button == "VUD1Toggle") or
	   (button == "VUD2Set") or (button == "VUD2Toggle") then
		self.VDL:TriggerInput("Open",1)
		self.KDL:TriggerInput("Open",1)
		self.KDP:TriggerInput("Open",1)
	end
	--print(button)

	--if button == "PBSet" then self:PlayOnce("switch6","cabin",0.55,100) return end
	if button == "GVToggle" then
		if self.GV.Value > 0.5 then
			self:PlayOnce("revers_f",nil,0.7)
		else
			self:PlayOnce("revers_b",nil,0.7)
		end
		return
	end

	if button == "DriverValveDisconnect" then
		if self.Pneumatic.ValveType == 2 then
			if self.DriverValveDisconnect.Value == 1.0 then
				self.DriverValveDisconnect:TriggerInput("Set",0)
				self:PlayOnce("pneumo_disconnect2","cabin",0.9)
				if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
			else
				self.DriverValveDisconnect:TriggerInput("Set",1)
				self:PlayOnce("pneumo_disconnect1","cabin",0.9)
				if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
			end
		else
			if self.DriverValveBLDisconnect.Value == 0 or self.DriverValveTLDisconnect.Value == 0 then
				self.DriverValveBLDisconnect:TriggerInput("Set",1)
				self.DriverValveTLDisconnect:TriggerInput("Set",1)
			else
				self.DriverValveBLDisconnect:TriggerInput("Set",0)
				self.DriverValveTLDisconnect:TriggerInput("Set",0)
			end
			if self.DriverValveBLDisconnect.Value == 1.0 then
				if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
			else
				if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
			end
		end
		return
	end

	if button == "DriverValveDisconnectToggle" then
		if self.DriverValveDisconnect.Value == 1.0 then
			self:PlayOnce("pneumo_disconnect2","cabin",0.9)
			if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
		else
			self:PlayOnce("pneumo_disconnect1","cabin",0.9)
			if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
		end
		return
	end

	if button == "DriverValveBLDisconnectToggle" then
		if self.DriverValveBLDisconnect.Value == 1.0 then
			if self.EPK.Value == 1 then self:PlayOnce("epv_off","cabin",0.9) end
		else
			if self.EPK.Value == 1 then self:PlayOnce("epv_on","cabin",0.9) end
		end
		return
	end

	if button == "EPKToggle" and
		(self.Pneumatic.ValveType == 1 and self.DriverValveBLDisconnect.Value == 1.0 or self.Pneumatic.ValveType == 2 and self.DriverValveDisconnect.Value == 1.0) then
		if self.EPK.Value == 1.0 then
			self:PlayOnce("epv_off","cabin",0.9)
		else
			self:PlayOnce("epv_on","cabin",0.9)
		end
		return
	end
	if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	if string.find(button,"KRU") then return end

	if button == "R_Program1Helper" then
		self.R_Program1:TriggerInput("Set",1)
		--self:PlayOnce("inf_on","instructor",0.7)
		return
	end
	if button == "R_Program2Helper" then
		self.R_Program2:TriggerInput("Set",1)
		--self:PlayOnce("inf_on","instructor",0.7)
		return
	end
	if string.find(button,"R_Program") then
		--self:PlayOnce("inf_on","cabin",0.7)
		return
	end

	if button == "VPAOff" then self.VPA:TriggerInput("Set",0) end
	if button == "VPAOn" then self.VPA:TriggerInput("Set",2) end
end

function ENT:OnButtonRelease(button)
	if button:find(":") then
		button = string.Explode(":",button)[2]
	end
	if string.find(button,"PneumaticBrakeSet") then
		return
	end
	if button == "VPAOff" then self.VPA:TriggerInput("Set",1) end
	if button == "VPAOn" then self.VPA:TriggerInput("Set",1) end
	--if button == "KVT2Set" then self.KVT:TriggerInput("Open",1) end
	if button == "KDL" then self.KDL:TriggerInput("Open",1) self:OnButtonRelease("KDLSet") end
	if button == "KDP" then self.KDP:TriggerInput("Open",1) self:OnButtonRelease("KDPSet") end
	if button == "VDL" then self.VDL:TriggerInput("Open",1) self:OnButtonRelease("VDLSet") end
	if button == "KRP" then
		self.KRP:TriggerInput("Set",0)
		self:OnButtonRelease("KRPSet")
	end

	--if button == "PBSet" then self:PlayOnce("switch6_off","cabin",0.55,100) return end
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
		----self:PlayOnce("vu22_off","cabin")
		return
	end
	if button == "VUD2Set" then
		----self:PlayOnce("vu22_off","cabin")
		return
	end
	if button == "VDLSet" then
		----self:PlayOnce("vu22_off","instructor")
		return
	end

	--if (not string.find(button,"KVT")) and string.find(button,"KV") then return end
	--if string.find(button,"KRU") then return end

	if button == "R_Program1Helper" then
		self.R_Program1:TriggerInput("Set",0)
		----self:PlayOnce("inf_off","instructor",0.7)
		--return
	end
	if button == "R_Program2Helper" then
		self.R_Program2:TriggerInput("Set",0)
		----self:PlayOnce("inf_off","instructor",0.7)
		--return
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
--[[
function ENT:OnTrainWireError(k)
	--
end
]]
