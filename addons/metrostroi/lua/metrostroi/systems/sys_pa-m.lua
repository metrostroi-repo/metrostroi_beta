--------------------------------------------------------------------------------
-- ПА-М Поездная Аппаратура Модифицированная
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-M")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("BRight","Relay","Switch",{button = true})
	self.Train:LoadSystem("BEsc","Relay","Switch",{button = true})
	self.Train:LoadSystem("BF","Relay","Switch",{button = true})
	self.Train:LoadSystem("BM","Relay","Switch",{button = true})
	self.Train:LoadSystem("BP","Relay","Switch",{button = true})

	self.TriggerNames = {
		"B7",
		"B8",
		"B9",
		"BLeft",
		"BRight",
		"B4",
		"B5",
		"B6",
		"BUp",
		"B1",
		"B2",
		"B3",
		"BDown",
		"B0",
		"BMinus",
		"BPlus",
		"BEnter",
		"BEsc",
		"BF",
		"BM",
		"BP",
	}
	self.Triggers = {}
	self.Pass = "31173"
	self.EnteredPass = ""
	self.Timer = CurTime()
	self.Line = 1
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.State4Choosed = 1
	self.FirstStation = ""
	self.LastStation = ""
	self.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
	self.Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  -0.25,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
	 self.State74 = 1
	 self.State75 = 1
end
function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR2r = {}
	self.STR1x = 1
	self.STR2x = 1
	self.Positions = {
		[-3] = "T2",
		[-2] = "T1a",
		[-1] = "T1",
		[0]  = "0",
		[1]  = "X1",
		[2]  = "X2",
		[3]  = "X3",
		[4]  = "RR0",
		[5]  = "0XT",
		[6]  = "T2",
	}
	self.Positions2 = {"PS","PP","PT",}
	self.Types = {
		[0] = "EPV",
		[1] = "AV",
		[2] = "OD",
		[3] = "KV",
		[4] = "UA",
		[5] = "SL",
	}
	self.StataionData =
	{
		[0] = "ERR",
		[108] = "AV",
		[109] = "IND",
		[110] = "MOSK",
		[111] = "OKT",
		[112] = "PLMI",
		[113] = "NOV",
		[114] = "VOK",
		[115] = "KOM",
		[116] = "ELE",
		[117] = "TEPL",
		[118] = "PP",
		[119] = "SINE",
		[120] = "LES X",
		[121] = "MNSK",
		[122] = "TSVO",
		[123] = "MZHD",
		[321] = "MUSK",
		[322] = "AVUZ",
		[1215] = "LEN",
		--ORANGE LINE
		[401] = "SLS",
		[402] = "LITE",
		[403] = "PA",
		[404] = "MAST",
		[405] = "GFC",
		[406] = "UB",
		[407] = "VHE",
		[408] = "TGM",
		[501] = "AERO",
		[502] = "SENT",
		[503] = "LIT",
	}
	self.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
	self.Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  -0.25,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

function TRAIN_SYSTEM:AnnNotLast(path)
	local Announcer = self.Train.Announcer
    return 	self:GetSTNum(self.Last) > 1
end
function TRAIN_SYSTEM:GetSTNum(station)
	local Announcer = self.Train.Announcer
	local station = tonumber(station)
	if not Metrostroi.WorkingStations[Announcer.AnnMap] then return 0 end
	if not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] then return 0 end
	if not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][station] and station ~= 120 then return 0 end
	return station == 120 and 12 or Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][station]
end
function TRAIN_SYSTEM:AnnEnd(station,path,next)
	if not station or station == 0 then return true end
	if next then
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) > self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) > self:GetSTNum(self.LastStation)) and path == 1)),Metrostroi.AnnouncerData[station][9]
	else
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) >= self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) >= self:GetSTNum(self.LastStation)) and path == 1))
	end
end

function TRAIN_SYSTEM:AnnPlayArriving(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if self:AnnEnd(station,path) then
		Announcer:PlayInfQueueSounds(0230,0222,0002,0221,station)
		if Metrostroi.AnnouncerData[station][2] then
			Announcer:PlayInfQueueSounds(0215)
		end
		--Announcer:PlayInfQueueSounds(0006)
		self.AnnState = 7
		Announcer:PlayInfQueueSounds(0006)
		return
	end

	Announcer:PlayInfQueueSounds(Metrostroi.AnnouncerData[station][6] and 0220 or nil,station)
	if Metrostroi.AnnouncerData[station][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[station][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[station][7]] and 0203 or nil,Metrostroi.AnnouncerData[station][7])
	end

	if Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end

	if nextNonWorkingStation then
		Announcer:PlayInfQueueSounds(0230,nextNonWorkingStation)
	end
	Announcer:PlayInfQueueSounds(0002,0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end

	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:PlayInfQueueSounds(0006)
end

function TRAIN_SYSTEM:AnnPlayDepeate(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if self:AnnNotLast(path) then
		Announcer:PlayInfQueueSounds(0210,path == 1 and self.LastStation or self.FirstStation,0002)
	elseif Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation,0002)
	end
	Announcer:PlayInfQueueSounds(0218)

	if self.NextNonWorkingStation then
		Announcer:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
	end
	Announcer:PlayInfQueueSounds(0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end
	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:PlayInfQueueSounds(0006)
end
function TRAIN_SYSTEM:AnnII(ann)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if ann == 1 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0207 or 0206)
	elseif ann == 2 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0209 or 0208)
	elseif ann == 3 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0204 or 0205)
	else
		if not self.AnnIIalr then
			Announcer:PlayInfQueueSounds(self.Type == 1 and 0229 or 0217)
			self.AnnIIalr = true
		else
			Announcer:PlayInfQueueSounds(0228)
			self.AnnIIalr = false
		end
	end
    Announcer:PlayInfQueueSounds(0006)
end

local function GetStationRK(mu,dX)
	-- Calculate RK position based on distance and autodrive profile
	local TargetBrakeRKPosition = 1
	if dX < 160+35*mu   then TargetBrakeRKPosition = 1 end
	if dX < 70+35+25*mu then TargetBrakeRKPosition = 3 end
	if dX < 50+30+20*mu then TargetBrakeRKPosition = 5 end
	if dX < 20+25+15*mu then TargetBrakeRKPosition = 9 end
	if dX < 10+20+10*mu then TargetBrakeRKPosition = 12 end
	if dX < 15          then TargetBrakeRKPosition = 13 end
	if dX < 12    	    then TargetBrakeRKPosition = 15 end
	if dX <  8          then TargetBrakeRKPosition = 16 end
	if dX <  5          then TargetBrakeRKPosition = 17 end
	if dX <  1          then TargetBrakeRKPosition = 18 end
	return TargetBrakeRKPosition
end

local mu = -0.25
function TRAIN_SYSTEM:Autodrive(StationBraking)
	local Train= self.Train
	-- Calculate distance to station
	local dX = Train:ReadCell(49165) + (self.Corrections[self.Station] or 0) - 4.3
	local speedLimit = (Train.ALS_ARS.Signal0 or Train.ALS_ARS.RealNoFreq) and 0 or Train.ALS_ARS.Signal40 and 40 or Train.ALS_ARS.Signal60 and 60 or Train.ALS_ARS.Signal70 and 70 or Train.ALS_ARS.Signal80 and 80 or 0
	local OnStation = dX < (160+35*mu - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Station]and Metrostroi.AnnouncerData[self.Station][1]
	if StationBraking and (dX >= (160+35*mu - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.StationAutodrive = false return end
	--print(Train:ReadCell(49165) + (Corrections[self.Station] or 0) - 4.3)
	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local RKPosition = math.floor(Train.RheostatController.Position+0.5)

	-- Calculate next speed limit

	-- Get angle
	local Slope = Train:GetAngles().pitch

	-- Check speed constraints
	if Train.ALS_ARS.Speed > (speedLimit - 6) then self.NoAcceleration = true end
	if Train.ALS_ARS.Speed < (speedLimit - 10) then self.NoAcceleration = false end

	local Brake = false
	local Accelerate = false

	local threshold = 1.0 + (Slope > 1 and 1 or 0)

	-- Slow down on slopes
	if Train.ALS_ARS.Speed > speedLimit - 5 - (self.NoAcceleration and 4 or 7) then
		if Slope > 1 then
			if speedLimit == 40 then
				TargetBrakeRKPosition = 7
			elseif speedLimit > 40  then
				TargetBrakeRKPosition = 1
				Brake = (Train.ALS_ARS.Speed > speedLimit - 4)
			end
		end
	end

	-- Slow down if overspeeding soon
	if (Train.ALS_ARS.Speed > (speedLimit - threshold)) then
		TargetBrakeRKPosition = 18
	end

	-- How smooth braking should be (higher mu = more gentle braking)
	-- Full stop command
	if Train.ALS_ARS.SpeedLimit < 30 then TargetBrakeRKPosition = 18 Brake = true end

	-- Calculate RK position based on distance and autodrive profile
	if OnStation then
		TargetBrakeRKPosition = GetStationRK(mu, dX)
	else
		if dX > (160+35*mu - (speedLimit == 40 and 30 or 0)) then self.StartMoving = nil end
	end

	-- Generate commands
	local ElectricBrakeActive = FullStop or TargetBrakeRKPosition > 0
	local AcceleratingActive = not ElectricBrakeActive and not self.NoAcceleration and Slope <  1

	-- Generate brake rheostat rotation
	local RheostatBrakeRotating = Brake or RKPosition < TargetBrakeRKPosition
	-- Generate accel rheostat rotation
	local PP = math.floor(Train.PositionSwitch.Position + 0.5) == 2
	--print(Train.Electric.Itotal,RKPosition)
	local AmpNorm = true --Train.Electric.Itotal < (350 - (Train:GetPhysicsObject():GetMass()-30000)/24) * math.floor(Train.PositionSwitch.Position + 0.5)
	local RheostatAccelRotating = AcceleratingActive
	--	print(math.floor(Train.PositionSwitch.Position + 0.5) , RKPosition , Train.Electric.Itotal)
	if Slope < -2 and (math.floor(Train.PositionSwitch.Position + 0.5) == 2 and RKPosition == 10 and Train.Electric.Itotal > 500) then
		--if PP and (8 <= RKPosition and RKPosition <= 12) then
			RheostatAccelRotating = false
		--end
	end
	local PneumaticValve1 = ((dX < 1.55) and (Train.ALS_ARS.Speed > 0.1) and OnStation and TargetBrakeRKPosition == 18) or (Train.ALS_ARS.Speed > (Train.ALS_ARS.SpeedLimit - threshold))
	--or (Train:ReadCell(6) > 0 and Train:ReadCell(18) < 1 and Slope > 1)

	--Disable autodrive on end of station brake
	--local StatID = Metrostroi.WorkingStations[self.Station] or Metrostroi.WorkingStations[self.Station + (self.Path == 1 and 1 or -1)] or 0

	if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) or (self.StartMoving and 10 < dX and dX < 160) then
		if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) then
			self.StationAutodrive = false
			--print("Stopped on "..Curr[1]..", "..(Curr[2] and "right side" or "left side")..", next station is "..(Next and (Next[1]..", "..(Next[2] and "right side" or "left side")) or "nil"))

			--
			--self.VUDOverride = true

			--local self.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if self.Station == 0 then return end
			--local StatID = Metrostroi.WorkingStations[self.Station] or Metrostroi.WorkingStations[self.Station + (self.Path == 1 and 1 or -1)] or 0
			if GetConVarNumber("metrostroi_paksd_autoopen",0) > 0 and not StationBraking then
				local Curr = Metrostroi.AnnouncerData[self.Station]
				if Curr[2] then
					Train:WriteCell(32,1)
				else
					Train:WriteCell(31,1)
				end
				timer.Simple(0.1,function()
					if not IsValid(Train) then return end
					Train:WriteCell(32,0)
					Train:WriteCell(31,0)
				end)
				Train.PAKSD_DOOR:TriggerInput("Set",1)
			end
		end
		self.AutodriveReset = true
		return
	end

	-- Enter commands
	--Train:WriteCell(1, AcceleratingActive and 1 or 0) --Engage engines
	--Train:WriteCell(2, (RheostatAccelRotating or (ElectricBrakeActive and (RheostatBrakeRotating or RKPosition == 18 and not OnStation))) and 1 or 0) --X2/T2
	--Train:WriteCell(3, (Train.ALS_ARS.Speed > 30 and RheostatAccelRotating) and 1 or 0) --X3
	--Train:WriteCell(6, ElectricBrakeActive and 1 or 0) --Engage brakes
	--Train:WriteCell(20,(ElectricBrakeActive or not self.NoAcceleration) and 1 or 0) -- Engage power circuits
	local KVPos = 0
	if ElectricBrakeActive then
		if (RheostatBrakeRotating or RKPosition == 18 and not OnStation) and not Train:GetPackedBool(35) then
			KVPos = -3
		else
			KVPos = -1
		end
	elseif AcceleratingActive then
		if Train.ALS_ARS.Speed > 30 and RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 3
		elseif RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 2
		else
			KVPos = 1
		end
	end
	if (KVPos == -1) and Train:GetPackedBool(35) then
		if not self.VZTimer1 then self.VZTimer1 = CurTime() + 1 end
	else
		self.VZTimer1 = nil
	end
	if self.VZTimer1 and self.VZTimer1 < CurTime() then
		PneumaticValve1 = true
	end
	if OnStation then
		self.Train.R25p:TriggerInput("Set",self.OldRheostatBrakeRotating ~= RheostatBrakeRotating)
		self.OldRheostatBrakeRotating = RheostatBrakeRotating	
	end
	Train:WriteCell(29, PneumaticValve1 and 1 or 0) -- Engage PN1
	Train:TriggerInput("KVControllerAutodriveSet",KVPos)
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	Train:WriteCell(17,1)
	timer.Simple(0.1,function()
		if not IsValid(Train) then return end
		Train:WriteCell(17,0)
	end)
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

function TRAIN_SYSTEM:ReloadSigns()
	self.Train:PrepareSigns()
	if self.Train.SignsList[tonumber(self.LastStation)] then
		self.Train.SignsIndex = self.Train.SignsList[tonumber(self.LastStation)] or 1
		self.Train:SetNWString("FrontText",self.Train.SignsList[self.Train.SignsIndex])
	end
	if #self.Train.WagonList > 1 then
		local LastTrain = self.Train.Announcer:GetLastWagon()
		LastTrain:PrepareSigns()
		if LastTrain.SignsList[tonumber(self.FirstStation)] then
			LastTrain.SignsIndex = self.Train.SignsList[tonumber(self.FirstStation)] or 1
			LastTrain:SetNWString("FrontText",self.Train.SignsList[self.Train.SignsIndex])
		end
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	local Announcer = self.Train.Announcer
	if self.State == 1 and name == "BEnter" then
		self.State = 2
	elseif self.State == 2 then
		if name == "BEnter" then
			if self.Pass ~= self.EnteredPass then
				self.EnteredPass = "/"
			else
				self.State = 3
			end
		else
			if self.EnteredPass == "/" then self.EnteredPass = "" end
			local Char = tonumber(name:sub(2,2))
			if Char and #self.EnteredPass < 6 then self.EnteredPass = self.EnteredPass..tonumber(name:sub(2,2)) end
		end
	elseif self.State == 3 then
		if name == "B1" then
				self.State = 4
				self.Line = 1
				self.RouteNumber = ""
				self.State4Choosed = 1
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
					self.FirstStation = tostring(self.Path == 2 and Metrostroi.EndStations[Announcer.AnnMap][self.Line][#Metrostroi.EndStations[Announcer.AnnMap][self.Line]] or Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(self.Path == 1 and Metrostroi.EndStations[Announcer.AnnMap][self.Line][#Metrostroi.EndStations[Announcer.AnnMap][self.Line]] or Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
				else
					self.FirstStation = "111"
					self.LastStation = "123"
				end
		end
		if name == "B2" and self.FirstStation ~= "" and self.LastStation ~= "" then
				self.State = 49
				self.State4Choosed = 1
		end
	elseif self.State == 4 then
		--print(name)
		if name == "BDown" then
			self.State4Choosed = math.min(4,self.State4Choosed + 1)
		end
		if name == "BUp" then
			self.State4Choosed = math.max(1,self.State4Choosed - 1)
		end
		if name == "BLeft" then
			if self.State4Choosed == 2 then
				self.FirstStation= self.FirstStation:sub(1,-2)
			end
			if self.State4Choosed == 3 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State4Choosed == 4 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		if name == "BEnter" then
			if not Metrostroi.EndStations[Announcer.AnnMap][self.Line] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.FirstStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.LastStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				self.RouteNumber == "" then
				self.State = 45
			else
				self.State = 5
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State4Choosed == 1 then
				self.Line = Char
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][self.Line]
					self.FirstStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength])
				end
			end
			if self.State4Choosed == 2 and #self.FirstStation < 3 then
				self.FirstStation= self.FirstStation..tostring(Char)
			end
			if self.State4Choosed == 3 and #self.LastStation < 3 then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State4Choosed == 4 and #self.RouteNumber < 2 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		self:ReloadSigns()
	elseif self.State == 49 then
		if name == "BDown" then
			self.State4Choosed = math.min(3,self.State4Choosed + 1)
		end
		if name == "BUp" then
			self.State4Choosed = math.max(1,self.State4Choosed - 1)
		end
		if name == "BLeft" then
			if self.State4Choosed == 2 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State4Choosed == 3 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		if name == "BEnter" then
			if not Metrostroi.EndStations[Announcer.AnnMap][self.Line] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.LastStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				self.RouteNumber == "" then
				self.State = 48
			else
				self.State = 7
				for k,v in pairs(self.Train.WagonList) do
					if v ~= self.Train and v["PA-KSD"] then
						v["PA-KSD"].State = 8
						v["PA-KSD"].Line = self.Line 
						v["PA-KSD"].RouteNumber = self.RouteNumber
						v["PA-KSD"].State4Choosed = self.State4Choosed
						v["PA-KSD"].FirstStation = self.FirstStation
						v["PA-KSD"].LastStation = self.LastStation
					end
				end
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State4Choosed == 1 then
				self.Line = Char
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][self.Line]
					self.FirstStation = self.FirstStation ~= "" and self.FirstStation or tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength])
					if tonumber(self.LastStation) < tonumber(self.FirstStation) then
						local temp = self.FirstStation
						self.FirstStation = self.LastStation
						self.LastStation = temp
					end
				end
			end
			if self.State4Choosed == 2 and #self.LastStation < 3 then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State4Choosed == 3 and #self.RouteNumber < 2 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		self:ReloadSigns()
	elseif self.State == 45 then
		if name == "BEnter" then
				self.State = 4
		end
	elseif self.State == 48 then
		if name == "BEnter" then
				self.State = 49
		end
	elseif self.State == 5 then
		if name == "BEnter" and self.Check == false then
			self.Check = nil
			self.State = 6
		end
	elseif self.State == 6 then
		if name == "BLeft" then
			self.State = 3
		end
		if name == "BEnter" then
			self.State = 7
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v["PA-KSD"] then
					v["PA-KSD"].State = 8
					v["PA-KSD"].Line = self.Line 
					v["PA-KSD"].RouteNumber = self.RouteNumber
					v["PA-KSD"].State4Choosed = self.State4Choosed
					v["PA-KSD"].FirstStation = self.FirstStation
					v["PA-KSD"].LastStation = self.LastStation
				end
			end
		end
	elseif self.State == 7 and not self.Nakat then
		if name == "B1" then
			if not self.AutodriveWorking and self.Train.ALS_ARS["33G"] < 0.5 then
				self.State = 71
			end
		elseif name == "B2" then
			if (self.AutodriveWorking or self.VRD or self.UOS) and not self.Trainsit then
				self.State = 72
			end
		elseif name == "B3" then
			--print(self.Train.ALS_ARS.Signal0,self.Train.ALS_ARS.RealNoFreq)
			if not self.UOS and not self.Train.ALS_ARS.EnableARS then
				self.State = 73
			end
		elseif name == "BEnter" then
			self.State = 74
			self.State74 = 1
		elseif name == "BPlus" then
			self.State = 75
			self.State75 = 1
		end
		--[[
		elseif name == "B5" then
			if not self.Transit and not self.VRD then
				self.State = 74
			end
		elseif name == "B6" then
			if not self.Nakat and not self.VRD then
				self.State = 75
			end
		elseif name == "B7" then
			if not self.Stancionniy and not self.VRD then
				self.State = 77
			end
		elseif name == "BUp" then
			self:AnnII(4)
		elseif name == "BDown" then
			self:AnnII(3)
		elseif name == "BPlus" then
			self:AnnII(2)
		elseif name == "BMinus" then
			self:AnnII(1)
		end
		]]
	elseif self.State == 7 and self.Nakat then
		self.Nakat = false
		if self.Train:ReadTrainWire(1) < 1 then
			self.Train.ALS_ARS.Nakat = false
		end
	elseif self.State == 71 then
		if name == "BEnter" then
			self.AutodriveWorking = true
			self.UOS = false
			self.State = 7
		end
		if name == "BLeft" then
			self.State = 7
		end
	elseif self.State == 72 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.State = 7
		end
		if name == "BLeft" then
			self.State = 7
		end
	elseif self.State == 73 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = true
			self.State = 7
		end
		if name == "BLeft" then
			self.State = 7
		end
	elseif self.State == 74 then
		if name == "BUp" then
			self.State74 = math.max(1,self.State74 - 1)
			--if self.State74 == 4 and self.Transit then
				--self:Trigger("BUp",true)
			--else
			if self.State74 == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
				self:Trigger("BUp",true)
			elseif self.State74 == 6 then
				if self.LastStation == tostring(self.Station) then
					self:Trigger("BUp",true)
				end
			elseif self.State74 == 7 then
				if self.FirstStation == tostring(self.Station) then
					self:Trigger("BUp",true)
				end
			end
		end
		if name == "BDown" then
			self.State74 = math.min(8,self.State74 + 1)
			--if self.State74 == 4 and self.Transit then
				--self:Trigger("BDown",true)
			--else
			if self.State74 == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
				self:Trigger("BDown",true)
			elseif self.State74 == 6 then
				if self.LastStation == tostring(self.Station) then
					self:Trigger("BDown",true)
				end
			elseif self.State74 == 7 then
				if self.FirstStation == tostring(self.Station) then
					self:Trigger("BDown",true)
				end
			end
		end
		if name == "BLeft" then
			self.State = 7
		end
		if name == "BEnter" then
			if self.State74 == 1 and self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self.State = 77
			elseif self.State74 == 2 then
				self.KD = not self.KD
			elseif self.State74 == 3 then
				self.State = 3
			elseif self.State74 == 4 then
				self.Transit = not self.Transit
				self.AutodriveWorking = false
			elseif self.State74 == 5 then
				self.State = 76
			elseif self.State74 == 6 then
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line][self.Station] then
					self.LastStation = tostring(self.Station)
				end
			elseif self.State74 == 7 then
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line][self.Station] then
					self.FirstStation = tostring(self.Station)
				end
			elseif self.State74 == 8 and not self.Arrived then
				self.Arrived = true
				local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
				self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
			end
			if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
		end
		if self.State74 > 6 then
			if name == "B7" then
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line][self.Station] then
					self.FirstStation = tostring(self.Station)
					if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
				end
			end
			if name == "B8"  and not self.Arrived == nil then
				self.Arrived = true
				local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
				self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
		elseif self.State74 > 3 then
			if name == "B4" then
				self.Transit = not self.Transit
				self.AutodriveWorking = false
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
			if name == "B5" then
				self.State = 76
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
			if name == "B6" then
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line][self.Station] then
					self.LastStation = tostring(self.Station)
					if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
				end
			end
		else
			if name == "B1" and self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self.State = 77
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
			if name == "B2" then
				self.KD = not self.KD
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
			if name == "B3" then
				self.State = 3
				if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
		end
	elseif self.State == 75 then
		if name == "BUp" then
			self.State75 = math.max(1,self.State75 - 1)
		end
		if name == "BDown" then
			self.State75 = math.min(4,self.State75 + 1)
		end
		if name == "BLeft" then
			self.State = 7
		end
		if name == "BEnter" then
			self:AnnII(self.State75)
			self.State = 7
		end
		local Char = tonumber(name:sub(2,2))
		if Char and Char > 0 and Char < 5 then
			self:AnnII(Char)
			self.State = 7
		end
	elseif self.State == 76 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.VRD = true
			self.State = 7
		end
		if name == "BLeft" then
			self.State = 7
		end
	elseif self.State == 77 then
		if name == "BEnter" then
			if self.Train.Speed < 0.5 and self.Train.ALS_ARS.SpeedLimit > 20 then
				self.AutodriveWorking = false
				self.VRD = false
				self.Nakat = true
			end
			self.State = 7
		end
		if name == "BLeft" then
			self.State = 7
		end
	end
	if not nosnd then self.Train:PlayOnce("paksd","cabin",0.75,160.0) end
end
function TRAIN_SYSTEM:PAM(train)
	surface.SetAlphaMultiplier(1)
end
function TRAIN_SYSTEM:ClientThink()
end

function TRAIN_SYSTEM:GetTimer(val)
	return self.TimerMod and (CurTime() - self.Timer) > val
end
function TRAIN_SYSTEM:SetTimer(mod)
	if mod then
		if self.TimerMod == mod then return end
		self.TimerMod = mod
	else
		self.TimerMod = nil
	end
	self.Timer = CurTime()
end

function TRAIN_SYSTEM:Think(dT)
end
