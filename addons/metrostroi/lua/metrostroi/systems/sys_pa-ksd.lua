--------------------------------------------------------------------------------
-- ПА-КСД Поездная Аппаратура-Комплексная Система Движения
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-KSD")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("Indicate","Relay","Switch",{maxvalue = 3,defaultvalue = 1})
	self.Train:LoadSystem("VPA","Relay","Switch",{defaultvalue = 1})

	self.Train:LoadSystem("BCCD","Relay","Switch")
	self.Train:LoadSystem("VZP","Relay","Switch")
	self.Train:LoadSystem("B7","Relay","Switch")
	self.Train:LoadSystem("B8","Relay","Switch")
	self.Train:LoadSystem("B9","Relay","Switch")
	self.Train:LoadSystem("BLeft","Relay","Switch")
	self.Train:LoadSystem("B4","Relay","Switch")
	self.Train:LoadSystem("B5","Relay","Switch")
	self.Train:LoadSystem("B6","Relay","Switch")
	self.Train:LoadSystem("BUp","Relay","Switch")
	self.Train:LoadSystem("B1","Relay","Switch")
	self.Train:LoadSystem("B2","Relay","Switch")
	self.Train:LoadSystem("B3","Relay","Switch")
	self.Train:LoadSystem("BDown","Relay","Switch")
	self.Train:LoadSystem("B0","Relay","Switch")
	self.Train:LoadSystem("BMinus","Relay","Switch")
	self.Train:LoadSystem("BPlus","Relay","Switch")
	self.Train:LoadSystem("BEnter","Relay","Switch")
	self.Train:LoadSystem("PAKSD_DOOR","Relay","Switch")
	self.Train:LoadSystem("PAKSD_VUD","Relay","Switch")

	self.Train:LoadSystem("R25p","Relay","KPD-110E", { in_cabin_alt4 = true })

	self.TriggerNames = {
		"B7",
		"B8",
		"B9",
		"BLeft",
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
CreateConVar("metrostroi_paksd_autoopen",0,{FCVAR_ARCHIVE},"PA-KSD:Auto open doors")
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

function TRAIN_SYSTEM:Autodrive(StationBraking)
	local Train= self.Train
	-- Calculate distance to station
	local dX = Train:ReadCell(49165) + (self.Corrections[self.Station] or 0) - 4.3
	local speedLimit = (Train.ALS_ARS.Signal0 or Train.ALS_ARS.RealNoFreq) and 0 or Train.ALS_ARS.Signal40 and 40 or Train.ALS_ARS.Signal60 and 60 or Train.ALS_ARS.Signal70 and 70 or Train.ALS_ARS.Signal80 and 80 or 0
	local OnStation = dX < (160+35 - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Station]and Metrostroi.AnnouncerData[self.Station][1]
	if StationBraking and (dX >= (160+35 - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.StationAutodrive = false return end
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
	local mu = 0
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
			if not self.AutodriveWorking and self.Train.ALS_ARS["33D"] > 0.5 then
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
			
		--[[
	elseif self.State == 74 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = true
			self.Nakat = false
			self.Stancionniy = false
			self.State = 7
		end
		if name == "BMinus" then
			self.State = 7
		end
	elseif self.State == 75 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = true
			self.Stancionniy = false
			self.State = 7
		end
		if name == "BMinus" then
			self.State = 7
		end
	elseif self.State == 77 then
		if name == "BEnter" then
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = false
			self.Stancionniy = true
			self.State = 7
		end
		if name == "BMinus" then
			self.State = 7
		end
		]]
	end
	if not nosnd then self.Train:PlayOnce("paksd","cabin",0.75,160.0) end
end
--[[
function TRAIN_SYSTEM:PAKSD1()
	surface.SetDrawColor(0,255,127)
	for x = 1,20 do
		for y = 0,3 do
			for x1 = 1,5 do
				for y1 = 1,7 do
					self.Train:DrawCircle(5+x1*2 + x*12,5+y1*2 + y*16,1)
				end
			end
		end
	end
end
function TRAIN_SYSTEM:PAKSD2()
	surface.SetDrawColor(0,255,127)
	for i = 0,1 do
		for x = 1,5 do
			for y = 1,7 do
				self.Train:DrawCircle(5+x*2,5+y*2 + i*16,1)
			end
		end
	end
end
]]
function TRAIN_SYSTEM:PAKSD1(train)
	--print(self,train,self==train)
	if train:GetPackedBool("Indicate3") then return end
	if train:GetPackedBool("Indicate2") then return end
	for y = 0,#self.STR1r-1 do
		local xmin = 0
		local blink = false
		local checked = false
		for x = 0,math.min(19,#self.STR1r[y+1]-1) do
			local char = self.STR1r[y+1][x+1]
			if char == "@" then
				blink = true
				xmin = xmin + 1
			elseif char == "$" then
				checked = true
				xmin = xmin + 1
			elseif blink then
				if CurTime()%1<=0.5 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
					surface.SetDrawColor(0,0,0)
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
					--xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
					--xmin = xmin + 1
				end
			elseif checked then
				surface.SetDrawColor(0,255,127)
				surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
				surface.SetDrawColor(0,0,0)
				draw.DrawText(self.STR1r[y+1][x+1],"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
			elseif char == "_" then
				if CurTime()%0.65<=0.4 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16,y*28+5,16,20)
				end
			elseif char == "#" then
				surface.SetDrawColor(0,255,127)
				surface.DrawRect(x*16+1,y*28+5,14,20)
			elseif self.STR1r[y+1][x+2] == "%" then
				if CurTime()%0.5<=0.25 then
					surface.SetDrawColor(0,255,127)
					surface.DrawRect((x-xmin)*16+1,y*28+5,14,20)
					surface.SetDrawColor(0,0,0)
					draw.DrawText(self.STR1r[y+1][x+1],"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,0,0))
					xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
					xmin = xmin + 1
				end
			elseif char ~= "%" then
				draw.DrawText(char,"MetrostroiSubway_IGLA",(x-xmin)*16,y*28, Color(0,255,127))
			end
		end
	end
	surface.SetAlphaMultiplier(1)
end
function TRAIN_SYSTEM:PAKSD2(train)
	if train:GetPackedBool("Indicate3") then return end
	if not train:GetPackedBool("Indicate1") and not train:GetPackedBool("Indicate2") then return end
	for y = 0,#self.STR2r-1 do
		for x = 0,math.min(19,#self.STR2r[y+1]-1) do
			local char = self.STR2r[y+1][x+1]
			if char == "_" then
				if CurTime()%0.5>0.25 then
					char = ""
				else
					surface.SetDrawColor(0,255,127)
					surface.DrawRect(x*16-3,y*40 + 15,16,28)
				end
			end
			draw.DrawText(char,"MetrostroiSubway_IGLA",x*16-3,y*40 + 15, Color(0,255,127))
		end
	end
	surface.SetAlphaMultiplier(1)
end

function TRAIN_SYSTEM:STR1(str,notchange)
	if SERVER then return end
	if str == true then
		for i = 1,4 do
			self.STR1r[i] = ""
		end
		self.STR1x = 1
	else
		if self.STR1x > 4 then print("STR1:ERR:MAX",str) return end
		if notchange then
			self.STR1r[self.STR1x-1] = self.STR1r[self.STR1x-1]..str
		else
			self.STR1r[self.STR1x] = str or ""
			self.STR1x = self.STR1x + 1
		end
	end
end
function TRAIN_SYSTEM:STR2(str,notchange)
	if SERVER then return end
	if str == true then
		for i = 1,2 do
			self.STR2r[i] = ""
		end
		self.STR2x = 1
	else
		if self.STR2x > 2 then print("STR2:ERR:MAX",str) return end
		if notchange then
			self.STR2r[self.STR2x] = self.STR2r[self.STR2x]..(str or "")
		else
			self.STR2r[self.STR2x] = str or ""
			self.STR2x = self.STR2x + 1
		end
	end
end
function TRAIN_SYSTEM:ClientThink()
	if not self.Train.ARSType or self.Train.ARSType < 3 then return end
	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.5 then
		--print(1)
		self.Time = CurTime()
		--self.STR1 = string.Explode("\n",self.Train:GetNWString("PAKSD1"))
		--self.STR2 = string.Explode("\n",self.Train:GetNWString("PAKSD2"))
		self:STR1(true)
		self:STR2(true)
		local State = self.Train:GetNWInt("PAKSD:State",0)
		if State == -1 or State >= 1 and State < 6 then
			self:STR2("<*>")
		end
		local Announcer = self.Train.Announcer
		if State == 8 then
			self:STR1("<*>")
		elseif State == -2 then
			self:STR2("_")
		elseif State == 1 then
			self:STR1("+INITIAL TEST")
			self:STR1("+INITIAL SETUP")
			self:STR1("V 0.3")
			self:STR1("     PRESS ENTER")
		elseif State == 2 then
			self:STR1("ENTER PASSWORD")
			self:STR1("TO ENTER SYSTEM>")
			self:STR1(self.Train:GetNWInt("PAKSD:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAKSD:Pass",0)) or "ACCESS ERROR")
		elseif State == 3 then
			self:STR1(" 1 GO TO LINE")
			if self.Train:GetNWBool("PAKSD:Restart",false) then self:STR1(" 2 RESTART") end
			--if self.FirstStation ~= "" and self.LastStation ~= "" then self:STR1("\n 2 RESTART" end
		elseif State == 4 then
			local State4Choosed = self.Train:GetNWInt("PAKSD:State4",1)
			if State4Choosed < 4 then
				local Line = self.Train:GetNWInt("PAKSD:Line",0)
				local FirstStation = self.Train:GetNWInt("PAKSD:FirstStation",-1)
				local LastStation = self.Train:GetNWInt("PAKSD:LastStation",-1)
				local tbl = Metrostroi.EndStations
				self:STR1("LINE "..Line..(State4Choosed == 1 and "_" or " ").." ")
				if tbl[Announcer.AnnMap][Line] then
					local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][Line]
					self:STR1("<"..tbl[Announcer.AnnMap][Line][1].."->"..tbl[Announcer.AnnMap][Line][Routelength]..">",true)
				else
					self:STR1("<ERR->ERR>",true)
				end
				local st = ""
				if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][FirstStation] and Metrostroi.AnnouncerData[FirstStation] then
					st = Metrostroi.AnnouncerData[FirstStation][1]:sub(1,10)
				end
				self:STR1("FIRST "..(FirstStation ~= -1 and FirstStation or "")..(State4Choosed == 2 and "_" or " ")..st:upper())
				st = ""
				if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
					st = Metrostroi.AnnouncerData[LastStation][1]:sub(1,10)
				end
				self:STR1("LAST  "..(LastStation ~= -1 and LastStation or "")..(State4Choosed == 3 and "_" or " ")..st:upper())
				self:STR1("        VVVV        ")
			else
				local RouteNumber = self.Train:GetNWInt("PAKSD:RouteNumber",-1)
				self:STR1("ROUTEn "..(RouteNumber ~= -1 and RouteNumber or "").."_")
				self:STR1("\"ENTER\" FOR CONFIRM")
			end
		elseif State == 49 then
			local State4Choosed = self.Train:GetNWInt("PAKSD:State4",1)
			local Line = self.Train:GetNWInt("PAKSD:Line",0)
			local LastStation = self.Train:GetNWInt("PAKSD:LastStation",-1)
			local RouteNumber = self.Train:GetNWInt("PAKSD:RouteNumber",-1)
			local tbl = Metrostroi.EndStations
			self:STR1("LINE "..Line..(State4Choosed == 1 and "_" or " ").." ")
			if tbl[Announcer.AnnMap][Line] then
				local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][Line]
				self:STR1("<"..tbl[Announcer.AnnMap][Line][1].."->"..tbl[Announcer.AnnMap][Line][Routelength]..">",true)
			else
				self:STR1("<ERR->ERR>",true)
			end
			local st = ""
			if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				st = Metrostroi.AnnouncerData[LastStation][1]:sub(1,10)
			end
			self:STR1("LAST  "..(LastStation ~= -1 and LastStation or "")..(State4Choosed == 2 and "_" or " ")..st:upper())
			self:STR1("ROUTEn "..(RouteNumber ~= -1 and RouteNumber or "")..(State4Choosed == 3 and "_" or " "))
			self:STR1("\"ENTER\" FOR CONFIRM")
		elseif State == 48 or State == 45 then
			self:STR1("ERROR WHEN ENTER")
			self:STR1("SOURCE DATA")
			self:STR1("FOR CONTINUE")
			self:STR1("PRESS ENTER")
		elseif State == 5 then
			self:STR1(" TRAIN CHECK")
			self:STR1(" APPROVED")
			self:STR1(" WHEN CHECK")
			self:STR1(" PRESS ENTER")
		elseif State == 6 then
			self:STR1("ENTER")
			self:STR1("TO WORKING MODE?")
			self:STR1("")
			self:STR1("YES-\"ENTER\" NO-\"<-\"")
		elseif State > 6 then
			
			local speed = math.floor(self.Train:GetPackedRatio(3)*100.0)
			local station = self.Train:GetNWInt("PAKSD:Station",0)
			local spd = self.Train:GetNWBool("PAKSD:UOS", false) and 35 or self.Train:GetNWBool("PAKSD:VRD",false) and 20 or self.Train:GetPackedBool(46) and 80 or self.Train:GetPackedBool(45) and 70 or self.Train:GetPackedBool(44) and 60 or self.Train:GetPackedBool(43) and 40 or self.Train:GetPackedBool(42) and "00" or "H4"
			local VZ = (self.Train:GetNWBool("PAKSD:VZ1",false) and "B1" or "").." "..(self.Train:GetNWBool("PAKSD:VZ2",false) and "B2" or "")
			if self.OldVRD ~= self.Train:GetNWBool("PAKSD:VRD",false) then
				self.OldVRD = self.Train:GetNWBool("PAKSD:VRD",false)
				if self.OldVRD then
					self.VRDTimer = CurTime() + 7
				end
			end
			local distance = self.Train:GetNWInt("PAKSD:Distance",-99)
			local pos =self.Positions[self.Train:GetNWInt("PAKSD:KV",0)]
			local typ = self.Types[pos == "RR0" and 3 or self.Train:GetNWInt("PAKSD:Type",0)]
			local RK = (self.Positions2[self.Train:GetNWInt("PAKSD:PPT",1)]).."="..tostring(self.Train:GetNWInt("PAKSD:RK",0))
			if speed < 10 then
				speed = "0"..speed
			end
			if State == 71 then
				self:STR1("CONFIRM")
				self:STR1("AUTODRIVE MODE?")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 72 then
				self:STR1("CONFIRM")
				self:STR1("SC MODE? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 73 then
				self:STR1("CONFIRM")
				self:STR1("SL MODE? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 74 then
				local State74 = self.Train:GetNWInt("PAKSD:State74",1)
				local SD = self.Train:GetNWBool("PAKSD:KD",false)
				if State74 < 4 then
					self:STR1("1"..(State74 == 1 and "%" or "")..":"..(State74 == 1 and "$" or "").."ROLLING CHECK")
					self:STR1("2"..(State74 == 2 and "%" or "")..":"..(State74 == 2 and "$" or "").."DRIVE "..(SD and "WITH" or "WITHOUT").." SD")
					self:STR1("3"..(State74 == 3 and "%" or "")..":"..(State74 == 3 and "$" or "").."SETTINGS CHANGE")
					self:STR1("        VVVV        ")
				elseif State74 < 7 then
					self:STR1("4"..(State74 == 4 and "%" or "")..":"..(State74 == 4 and "$" or "")..(self.Train:GetNWBool("PAKSD:Transit",false) and "DIS " or "").."TRANSIT MODE")
					self:STR1("5"..(State74 == 5 and "%" or "")..":"..(State74 == 5 and "$" or "").."DRIVE WITH Vd=0")
					self:STR1("6"..(State74 == 6 and "%" or "")..":"..(State74 == 6 and "$" or "").."ZONED TURN")
					self:STR1("        VVVV        ")
				else
					self:STR1("7"..(State74 == 7 and "%" or "")..":"..(State74 == 7 and "$" or "").."FIX STATION")
					self:STR1("8"..(State74 == 8 and "%" or "")..":"..(State74 == 8 and "$" or "").."STATION MODE")
				end
			elseif State == 75 then
				local State75 = self.Train:GetNWInt("PAKSD:State75",1)
				self:STR1("1"..(State75 == 1 and "%" or "")..":"..(State75 == 1 and "$" or "").."GO OUT FROM TRAIN")
				self:STR1("2"..(State75 == 2 and "%" or "")..":"..(State75 == 2 and "$" or "").."ENTRY FASTER")
				self:STR1("3"..(State75 == 3 and "%" or "")..":"..(State75 == 3 and "$" or "").."RELEASE DOORS")
				self:STR1("4"..(State75 == 4 and "%" or "")..":"..(State75 == 4 and "$" or "").."TRAIN DEPEAT SOON")
			elseif State == 76 then
				self:STR1("CONTINUE MOVEMENT")
				self:STR1("WITH VD=0? ")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
			elseif State == 77 then
				self:STR1("ACCEPT")
				self:STR1("ROLLING CHECK?")
				self:STR1()
				self:STR1("YES-\"ENTER\"  NO-\"<-\"")
				--self:STR1("5:DRIVE WITH Vd = 0")
				--self:STR1("6:ZONED TURN")
			--[[
			elseif State == 79 then
				self:STR1("FOR TRANSIT MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			elseif State == 75 then
				self:STR1("FOR ROLL MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			elseif State == 77 then
				self:STR1("FOR STATION GO MODE")
				self:STR1("PRESS ENTER")
				self:STR1("FOR CANCEL")
				self:STR1("PRESS \"-\"")
			]]
			elseif self.Train:GetNWBool("PAKSD:Nakat",false) then
				self:STR1("ROLLING CHECK")
				self:STR1("DISTANCE:"..Format("%.2f",self.Train:GetNWFloat("PAKSD:Meters",0)))
				self:STR1("DIRECTION:"..(self.Train:GetNWBool("PAKSD:Sign",false) and "BACKWARD" or "FORWARD"))
				self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-5-#VZ-6-1).."Vf="..speed)
			else
				local State7 = self.Train:GetNWInt("PAKSD:State7",0)
				if State7 == 0 then
					self:STR1("  EXIT TO THE LINE")
					local date = os.date("!*t",os_time)
					self:STR1("    Tm="..Format("%02d:%02d:%02d",date.hour,date.min,date.sec))
					self:STR1()
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNWBool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-5-#VZ-6-1).."Vd="..spd)
						self.VRDTimer = nil
					end
				elseif State7 == 1 then
					local path =  self.Train:GetNWInt("PAKSD:Path",0)
					local bt = tostring(self.Train:GetNWInt("PAKSD:BoardTime",0))
					local date = os.date("!*t",os_time)
					local tm = Format("%02d:%02d:%02d",date.hour,date.min,date.sec)
					self:STR1(Metrostroi.AnnouncerData[station][1]:upper())
					self:STR1("TO "..Metrostroi.AnnouncerData[self.Train:GetNWInt("PAKSD:LastStation",108)][1]:upper())
					self:STR1("ST "..bt..string.rep(" ",20-8-3-#bt)..tm)
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNWBool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-6-4-#VZ)..(path == 1 and "I " or "II" ).."P")
						self.VRDTimer = nil
					end
				else
					local name = self.Train:GetNWString("PAKSD:SName","ERR")
					local curr = string.rep("#",speed/4.7-1)
					local max = string.rep("-",(spd ~= "H4" and spd or 0)/4.7-1)
					self:STR1(curr.."<"..string.rep(" ",20-#curr-3)..speed)
					self:STR1(max.."^"..string.rep(" ",20-#max-3)..spd)
					self:STR1("TC="..name..string.rep(" ",20-9-#name)..math.min(9999,math.floor(distance)).." m")
					if self.VRDTimer and CurTime() - self.VRDTimer < 0 then
						self:STR1("@ACC MOV WITH Vd=0")
					elseif self.Train:GetNWBool("PAKSD:Transit",false) then
						self:STR1("TRANSIT MODE")
					else
						self:STR1(typ.."="..pos..string.rep(" ",6-#typ-#pos)..VZ..string.rep(" ",20-2-6-1-#VZ-math.max(4,#self.StataionData[station])).."<"..self.StataionData[station]..">")
						self.VRDTimer = nil
					end
				end
			end
			self:STR2("V+= "..speed.." Vd= "..spd.." S= "..(station == 0 and "unk" or math.min(999,math.floor(distance))))
			self:STR2(typ.."= "..pos..string.rep(" ",6-#typ-#pos)..RK..string.rep(" ",20-7-4-3-#RK).."T= "..(self.Train:GetPackedRatio(3)*100.0 > 0.25 and math.min(999,math.floor(distance/(speed*1000/3600))) or "inf"))
		end
	end
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
	if self.Train.ARSType ~= self.ARSTypeOld and self.Train.PAKSD_VUD then
		self.Train.PAKSD_VUD:TriggerInput("Set",self.Train.ARSType == 3)
		self.ARSTypeOld = self.Train.ARSType
	end
	--print(self.Train.PAKSD_VUD.Value)
	if self.Train.ARSType < 3 then self.State = 0 return end
	if self.Train.VB.Value > 0.5 and self.Train.Battery.Voltage > 55 and self.Train.VPA.Value > 0.5 and self.State >= -1  then
		for k,v in pairs(self.TriggerNames) do
			if self.Train[v] and (self.Train[v].Value > 0.5) ~= self.Triggers[v] then
				if self.Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = self.Train[v].Value > 0.5
			end
		end
	end
	--print(self.Train.Owner)
	local ARS = self.Train.ALS_ARS
	local Announcer = self.Train.Announcer
	self.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
	self.Path = Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
	self.Distance = self.Train:ReadCell(49165) + (self.Corrections[self.Station] or 0) - 4.3
	--print(self.Train.VB.Value < 0.5 or self.Train.Battery.Voltage < 55)
	if self.Train.VB.Value < 0.5 or self.Train.Battery.Voltage < 55 or self.Train.VPA.Value < 0.5  then self.State = 0 elseif self.State == 0 then self.State = -2 end
	--if not ARS.EnableARS and self.State > 6 then self.State = -1 end
	if self.Train.KV.ReverserPosition == 0 and self.State > 6 and self.State ~= 8 then self.State = 8 end
	if self.Train.KV.ReverserPosition ~= 0 and self.State > 6 and self.State == 8 then 
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
	if self.State == 0 and self.RealState ~= 0 then
		ARS:TriggerInput("Ring",0)
		self.EnteredPass = ""
		self:SetTimer()
	elseif self.State == -2 then
		self.EnteredPass = ""
		self:SetTimer(0.5)
		if self:GetTimer(5) then
			self.State = -1
			self:SetTimer()
			return
		end
	elseif self.State == -1 and self.RealState ~= -1 then
		self.Train:PlayOnce("paksd","cabin",0.75,200.0)
	elseif self.State == -1 then
		self:SetTimer(0.5)
		if self:GetTimer(10) then
			self.State = 1
			self:SetTimer()
			return
		end
	elseif self.State == 1 and self.RealState ~= 1 then
		self:SetTimer(0.5)
		self.Train:PlayOnce("paksd","cabin",0.75,200.0)
	elseif self.State == 1 then
		if self:GetTimer(0.1) then
			self.Train:PlayOnce("paksd","cabin",0.75,200.0)
			self:SetTimer()
		end
	elseif self.State == 5 then
		if self.Check == nil then ARS:TriggerInput("Ring",1) end
		--print(ARS.KVT)
		if ARS.KVT and self.Check == nil then
			self.Check = true
			self:SetTimer(4)
		end
		if not ARS.KVT and self.Check ~= false then
			self.Check = nil
			self:SetTimer()
		end
		if ARS.KVT and self:GetTimer(1) then
			self.Check = false
			ARS:TriggerInput("Ring",0)
			self:SetTimer()
		end
	elseif self.State > 6 and self.State ~= 8 and self.State ~= 49 and self.State ~= 45 and self.State ~= 48 then
		if self.VRD and (not ARS.Signal0 or ARS.Signal0 and (ARS.Signal40 or ARS.Signal60 or ARS.Signal70 or ARS.Signal80)) then self.VRD = false end
		if self.Distance > 40 and (self.Distance + (self.Corrections[self.Station] or 0) - 4.3) < (160+35 - (ARS.SpeedLimit == 40 and 30 or 0)) then
			self.StationAutodrive = true
		end
		if ARS["33G"] > 0.5 then
			self.AutodriveReset = true
			self.AutodriveWorking = false
		end
		if (self:GetSTNum(self.LastStation) > self:GetSTNum(self.FirstStation) and self.Path == 2) or (self:GetSTNum(self.FirstStation) > self:GetSTNum(self.LastStation)  and self.Path == 1) then
			local old = self.LastStation
			self.LastStation = self.FirstStation
			self.FirstStation = old
			self:ReloadSigns()
		end
		self.State7 = (self:AnnEnd(self.Station,self.Path,true) or self:GetSTNum(self.LastStation) > self:GetSTNum(self.Station) and self.Path == 2 or self:GetSTNum(self.Station) < self:GetSTNum(self.FirstStation) and self.Path == 1) and 0 or self.Arrived ~= nil and 1 or 2
		if self.State7 ~= 0 then
			if (self.RealState == 8 or self.RealState == 6 or self.RealState == 49) and not self.Transit then
				if self.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Station] and ARS.Speed <= 1 then
					self.Arrived = true
					local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
					self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
				end
			end
			if not self.Transit and 45 < self.Distance and self.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Station] then
				self.Arrived = true
				local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
				self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
			end
			if self.Transit then self.Arrived = nil end
			if self.Distance > 75 then
				self.Arrived = nil
			else
				--if self.Train.Panel.SD < 0.5 then self.Arrived = true end
			end
			if self.Arrived and 	self.Train.Panel.SD < 0.5 and not self.BoardTime then
				self.BoardTime = CurTime() + (self.Train.BoardTime or 0) + (20-(#self.Train.WagonList)*4)  + (self.Train.Horlift and 7 or 0)
				self.Ring = false
			end
			if (self.Arrived == nil or self.Train.Panel.SD > 0.5) and self.BoardTime then
				self.BoardTime = nil
				--self.Ring = nil
			end
			--if (self.Ring == nil or self.Ring == 0) and self.Train.Panel.SD < 0.5 then
				--self.Ring = false
			--end
			if self.Arrived then
				if self.BoardTime and math.floor((self.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
					if not self:AnnEnd(self.Station,self.Path) then
						local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
						self:AnnPlayDepeate(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
					else
						self.Ring = 2
					end
					self.Arrived = false
				end
			elseif self.Arrived == nil then
				self.Ring = nil
			end
			if self.Ring == false and self.Train.Panel.SD > 0.5 then 
				self.Ring = 1
			end
			if (self.Train:ReadCell(1) > 0 or ARS.Speed > 1) and self.Arrived == false then self.Arrived = nil end
			if self.Train:ReadCell(48) == 218 and self.Ring == false then
				self.Ring = 2
			end
			if self.Ring == 2 and self.Train.Panel.SD > 0.5 then
				self.Ring = 0
			end
			if (self.Ring or self.Ring ~= 0) and ARS.KVT then
				self.Ring = 0
			end
			if self.Ring == 0 and self.Arrived == nil then
				self.Ring = nil
			end
			if (self.Ring and self.Ring > 0) and not ARS.Ring then	
				ARS:TriggerInput("Ring",1)
			end
			if (not self.Ring or self.Ring == 0) and ARS.Ring then	
				ARS:TriggerInput("Ring",0)
			end
			if self.Nakat then
				if not self.Meters then self.Meters = 0 end
				self.Meters = self.Meters + ARS.Speed*self.Train.SpeedSign/3600*1000*dT
				if math.abs(self.Meters) > 2.5 then
					self.Nakat = false
					if self.Train:ReadTrainWire(1) < 1 then
						ARS.Nakat = true
					end
				end
			else
				self.Meters = nil
			end
		end
		--self.StationAutodrive = dX < (160+35*0 - (ARS.SpeedLimit == 40 and 30 or 0))
		--[[
		if self.State7 == 0 then
			self.Arrived = false
			self.STR1 = "  EXIT TO THE LINE  \n"
			local date = os.date("!*t",os_time)
			self.STR1 = "    Tm="..Format("%02d:%02d:%02d",date.hour,date.min,date.sec).."   \n\n"
			self.STR1 = typ.."="..pos..string.rep(" ",20-5-#typ-#pos-1).."Vd="..spd
		elseif self.State7 == 1 then
			local date = os.date("!*t",os_time)
			local tm = Format("%02d:%02d:%02d",date.hour,date.min,date.sec)
			self.STR1 = Metrostroi.AnnouncerData[self.Station][1]:upper().."\n"
			self.STR1 = self.STR1 .."TO "..Metrostroi.AnnouncerData[tonumber(self.LastStation)][1]:upper().."\n"
			self.STR1 = self.STR1 .."ST "..(bt)..string.rep(" ",20-8-3-#bt)..tm.."\n"
			self.STR1 = typ.."="..pos..string.rep(" ",20-#typ-#pos-4)..(self.Path == 1 and "I " or "II" ).."P"
		else
			local sig = ARS.Signal
			local name = sig and sig.RealName or "ERR"
			local curr = string.rep("#",speed/4.7-1)
			local max = string.rep("-",(spd ~= "H4" and spd or 0)/4.7-1)
			self.STR1 = curr.."<"..string.rep(" ",20-#curr-3)..speed.."\n"
			self.STR1 = max.."^"..string.rep(" ",20-#max-3)..spd.."\n"
			self.STR1 = "TC="..name..string.rep(" ",20-9-#name)..math.min(9999,math.floor(self.Distance)).." m\n"
			self.STR1 = typ.."="..pos..string.rep(" ",20-2-#typ-#pos-1-#self.StataionData[self.Station]).."<"..self.StataionData[self.Station]..">"
		end
		self.STR2 = "V+= "..speed.." Vd= "..spd.." self.Distance= "..(self.Station == 0 and "unk" or math.min(999,math.floor(self.Distance))).."\n"
		self.STR2 = typ.."= "..pos..string.rep(" ",6-#typ-#pos)..RK..string.rep(" ",20-7-4-3-#RK).."T= "..(ARS.Speed > 0.25 and math.min(999,math.floor(self.Distance/(ARS.Speed*1000/3600))) or "inf")
		]]
	end
	if self.State <= 6 then
		self.BoardTime = nil
	end
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end

	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		--if self.STR1 ~= self.STR1Real then
			--self.Train:SetNWString("PAKSD1",self.STR1)
			--self.STR1 = self.STR1Real
		--end
		--if self.STR2 ~= self.STR2Real then
			--self.Train:SetNWString("PAKSD2",self.STR2)
			--self.STR2 = self.STR2Real
		--end
		--self.Train:SetNWString("PAKSD2","V+= 59 VD= 70 self.Distance= 307\nKB=T1       Tx= -2c")
		self.Train:SetNWInt("PAKSD:State",self.State)
		if self.State == 2 then self.Train:SetNWInt("PAKSD:Pass",self.EnteredPass ~= "/" and #self.EnteredPass or -1)
		elseif self.State == 3 then self.Train:SetNWBool("PAKSD:Restart",self.FirstStation ~= "" and self.LastStation ~= "")
		elseif self.State == 4 then
			self.Train:SetNWInt("PAKSD:State4",self.State4Choosed)
			if self.State4Choosed < 4 then
				self.Train:SetNWInt("PAKSD:FirstStation",tonumber(self.FirstStation) or -1)
				self.Train:SetNWInt("PAKSD:LastStation",tonumber(self.LastStation) or -1)
				self.Train:SetNWInt("PAKSD:Line",self.Line)
			else
				self.Train:SetNWInt("PAKSD:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
			end
		elseif self.State == 49 then
			self.Train:SetNWInt("PAKSD:State4",self.State4Choosed)
			self.Train:SetNWInt("PAKSD:LastStation",tonumber(self.LastStation) or -1)
			self.Train:SetNWInt("PAKSD:Line",self.Line)
			self.Train:SetNWInt("PAKSD:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 7 then
			self.Train:SetNWInt("PAKSD:State7",self.State7)
			self.Train:SetNWInt("PAKSD:Nakat",self.Nakat)
			self.Train:SetNWBool("PAKSD:VRD",self.VRD)
			self.Train:SetNWBool("PAKSD:Transit",self.Transit)
			self.Train:SetNWInt("PAKSD:Station",self.Station)
			self.Train:SetNWInt("PAKSD:Distance",self.Distance)
			self.Train:SetNWInt("PAKSD:Type",(self.Train.Pneumatic.EmergencyValveEPK and 0 or self.Train.ALS_ARS.UAVAContacts and 4 or self.UOS and 5 or self.VRD and 2 or (self.AutodriveEnabled or self.StationAutodrive) and 1 or 3))
			self.Train:SetNWInt("PAKSD:PPT",math.Clamp(math.floor(self.Train.PositionSwitch.Position + 0.5),1,3))
			self.Train:SetNWInt("PAKSD:RK",math.floor(self.Train.RheostatController.Position+0.5))
			self.Train:SetNWInt("PAKSD:KV",self.Train.KV.ReverserPosition == 0 and 4 or self.AutodriveEnabled and (self.Rotating and -3 or self.Brake and -1 or self.Accelerate and 3 or 0) or (ARS["33G"] > 0 or (self.UOS and (ARS["8"] + (1-self.Train.RPB.Value)) > 0)) and 5 or self.Train.KV.RealControllerPosition)
			self.Train:SetNWBool("PAKSD:VZ1", self.Train:ReadTrainWire(29) > 0)
			self.Train:SetNWBool("PAKSD:VZ2", self.Train.PneumaticNo2.Value > 0)
			self.Train:SetNWBool("PAKSD:UOS", self.UOS)
			
			--self.Train:SetNWInt("PAKSD:ARS",ARS.Signal80 and 80 or ARS.Signal70 and 70 or ARS.Signal60 and 60 or ARS.Signal40 and 40 or ARS.Signal0 and 0 or -1)
			--local speed = tostring(math.floor(ARS.Speed))

			if self.State7 == 1 then
				self.Train:SetNWInt("PAKSD:BoardTime",math.floor((self.BoardTime or CurTime()) - CurTime()))
				self.Train:SetNWInt("PAKSD:Path",self.Path)
			elseif self.State7 == 2 then
				self.Train:SetNWString("PAKSD:SName",ARS.Signal and ARS.Signal.RealName or "ERR")
			end
			if self.Nakat then
				self.Train:SetNWFloat("PAKSD:Meters",math.Round(math.abs(self.Meters or 0),1))
				self.Train:SetNWBool("PAKSD:Sign",ARS.Speed > 0.5 and self.Train.SpeedSign < 0)
			end
		elseif self.State == 74 then
			self.Train:SetNWInt("PAKSD:State74",self.State74)
			self.Train:SetNWBool("PAKSD:KD",self.KD)
			self.Train:SetNWBool("PAKSD:Transit",self.Transit)
		elseif self.State == 75 then
			self.Train:SetNWInt("PAKSD:State75",self.State75)
		elseif self.State == 8 then
			self.Train:SetNWBool("PAKSD:VRD",self.VRD)
			self.AutodriveWorking = false
			self.UOS = false
			self.VRD = false
			self.Transit = false
			self.Nakat = false
			self.Stancionniy = false
		end
	end
	local Train = self.Train
	if Train.VZP then
		if Train.BCCD.Value > 0 then
			Train.PAKSD_DOOR:TriggerInput("Set",0)
		end
		--[[if Train:CPPIGetOwner() and Train:CPPIGetOwner():GetName() ~= "glebqip(RUS)" and (self.AutodriveEnabled or not self.AutodriveReset) then
			self.AutodriveReset = true
		else]]

		if self.AutodriveReset then
			Train:TriggerInput("KVControllerAutodriveSet",4)
			self.NoAcceleration = nil
			if Train.KV.ControllerPosition <= 0.0 then
				Train:WriteCell(1,0)
			end
			if Train.KV.ControllerPosition == 0.0 then
				Train:WriteCell(20,0)
			end
			if Train.KV.ControllerPosition <= 1.5 and Train.KV.ControllerPosition >= -1.5  then
				Train:WriteCell(2,0)
			end
			if Train.KV.ControllerPosition <= 2.5  then
				Train:WriteCell(3,0)
			end
			if Train.KV.ControllerPosition >= 0.0 then
				Train:WriteCell(6,0)
			end
			Train:WriteCell(29, 0)
			Train:WriteCell(32,0)
			self.AutodriveEnabled = false
		end

		if Train.VZP.Value < 0.5 and self.AutodriveReset then
			self.AutodriveReset = false
		end

		--Disable autodrive, if KV pos is not zero, ARS or ALS not enabled, Reverser position is not forward or Driver value pos is > 2
		if not self.AutodriveWorking and not self.VRD or Train.KV.ControllerPosition ~= 0.0 or not Train.ALS_ARS.EnableARS or Train.KV.ReverserPosition ~= 1.0 or Train.Pneumatic.DriverValvePosition > 2 or self.Train.Panel.SD < 0.5 then
			self.AutodriveReset = true
		end

		if self.StationAutodrive and self.AutodriveWorking and not self.VRD and Train.ALS_ARS.EnableARS and Train.KV.ReverserPosition == 1.0 and Train.Pneumatic.DriverValvePosition <= 2 and self.Train.Panel.SD > 0.5 then
			self:Autodrive(true)
		elseif self.StationAutodrive then
			self.StationAutodrive = false
		end
		if Train.VZP.Value > 0.5 and not self.AutodriveEnabled and not self.AutodriveReset then
			--[[
			if Train.Schedule then
				for k,v in pairs(Train.Schedule) do
					for k1,v1 in pairs(v) do
					end
				end
			end
			]]
			self.AutodriveEnabled = true
			self.StartMoving = true
		end
		if self.AutodriveEnabled then
			self:Autodrive()
		end
		--end
	end
end
