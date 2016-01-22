--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ALS_ARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

if CreateConVar then
	--[[concommand.Add("metrostroi_give_upps", function(ply, _, args)
		print("Trains on server: "..Metrostroi.TrainCount())
		if CPPI then
			local N = {}
			for k,v in pairs(Metrostroi.TrainClasses) do
				local ents = ents.FindByClass(v)
				for k2,v2 in pairs(ents) do
					N[v2:CPPIGetOwner() or "(disconnected)"] = (N[v2:CPPIGetOwner() or "(disconnected)"] or 0) + 1
				end
			end
			for k,v in pairs(N) do
				print(k,"Trains count: "..v)
			end
		end
	end)]]--

	--CreateConVar("metrostroi_upps",0,FCVAR_ARCHIVE)
end

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("UOS","Relay","Switch", {rc = true})
	self.Train:LoadSystem("BPS","Relay","Switch",{ rc = true,normally_closed = true })
	-- ALS state
	self.Signal80 = false
	self.Signal70 = false
	self.Signal60 = false
	self.Signal40 = false
	self.Signal0 = false
	self.Special = false
	self.NoFreq = true
	self.RealNoFreq = true
	self.Alarm = false
	self.CheckedNF = 2

	-- Internal state
	self.Speed = 0
	self.SpeedLimit = 0
	self.NextLimit = 0
	self.Ring = false
	self.Overspeed = false
	self.ElectricBrake = false
	self.PneumaticBrake1 = false
	self.PneumaticBrake2 = true
	self.PneumaticBrake2_1 = false
	self.AttentionPedal = false
	self.KVT = false
	self.IgnoreThisARS = false

	-- ARS wires
	self["33D"] = 0
	self["33G"] = 0
	self["33Zh"] = 0
	self["2"] = 0
	self["6"] = 0
	self["8"] = 0
	self["20"] = 0
	--self["21"] = 0
	self["29"] = 0
	self["31"] = 0
	self["32"] = 0

	-- Lamps
	---self.LKT = false
	self.LVD = false
end

function TRAIN_SYSTEM:Outputs()
	return { "2", "8", "20", "31", "32", "29", "33D", "33G", "33Zh",
			 "Speed", "Signal80","Signal70","Signal60","Signal40","Signal0","Special","NoFreq","RealNoFreq",
			 "SpeedLimit", "NextLimit","Ring","KVT","EnableARS","EnableALS","Signal", "UAVA"}
end

function TRAIN_SYSTEM:Inputs()
	return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	local Train = self.Train
	if name == "AttentionPedal" then
		self.AttentionPedal = value > 0.5
		if Train and Train.PB then
			Train.PB:TriggerInput("Set",value)
		end
	end
	if name == "IgnoreThisARS" then
		self.IgnoreThisARS = value > 0.5
	end
	if name == "Ring" then
		self.RingOverride = value > 0.5
	end
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

function TRAIN_SYSTEM:UPPS(Train)
	-- Calculate distance to station
	local Station = Train:ReadCell(49160) > 0 and Train:ReadCell(49160) or Train:ReadCell(49161)
	local Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  0.70,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
	local dX = Train:ReadCell(49165) - 10 - 5 + 6.5 - 3.3 + (Corrections[Station] or 0)

	local RKPosition = math.floor(Train.RheostatController.Position+0.5)

	local mu = 0.5
	--local OnStation = dX < (160+35*mu - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.WorkingStations[Station]
	local TargetBrakeRKPosition = GetStationRK(mu, dX)

	local RheostatBrakeRotating = RKPosition < TargetBrakeRKPosition

	local PneumaticValve1 = dX < 1.55 or self.Speed > 50
	--self.PneumaticBrake2 = dX < 1.55 and self.Speed < 0.1

	-- Enter commands
	self["29"] = PneumaticValve1 and 1 or 0 -- Engage PN1
	self["33D"] = 0
	self["33G"] = 1
	self["33Zh"] = 0
	self["2"] = RheostatBrakeRotating and 1 or 0 --T2
	self["6"] = 1 --Engage brakes
	self["20"] = 1 -- Engage power circuits
	Train:WriteCell(17,1)
	timer.Simple(0.1,function()
		if not IsValid(Train) then return end
		Train:WriteCell(17,0)
	end)
end
function TRAIN_SYSTEM:Autodrive(Train)
	-- Calculate distance to station
	local Station = Train:ReadCell(49160) > 0 and Train:ReadCell(49160) or Train:ReadCell(49161)
	local Path = Train:ReadCell(65510)
	local Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  0.70,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
	local dX = Train:ReadCell(49165) - 10 - 5 + 6.5 - 3.3 + (Corrections[Station] or 0) + 7.5

	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local RKPosition = math.floor(Train.RheostatController.Position+0.5)

	-- Calculate next speed limit
	local speedLimit = self.NextLimit
	if speedLimit == 0 then speedLimit = 20 end

	-- Get angle
	local Slope = Train:GetAngles().pitch

	-- Check speed constraints
	if self.Speed > (speedLimit - 5) then self.NoAcceleration = true end
	if self.Speed < (speedLimit - 9) then self.NoAcceleration = false end

	local Brake = false
	local Accelerate = false

	local threshold = 1.0 + (Slope > 1 and 1 or 0)

	-- Slow down on slopes
	if self.Speed > speedLimit - 5 - (self.NoAcceleration and 4 or 9) then
		if Slope > 1 then
			if speedLimit == 40 then
				TargetBrakeRKPosition = 7
			elseif speedLimit > 40  then
				TargetBrakeRKPosition = 1
				Brake = (self.Speed > speedLimit - 4)
			end
		end
	end

	-- Slow down if overspeeding soon
	if (self.Speed > (speedLimit - threshold)) then
		TargetBrakeRKPosition = 18
	end

	-- How smooth braking should be (higher mu = more gentle braking)
	local mu = 0
	-- Full stop command
	if self.SpeedLimit < 30 then TargetBrakeRKPosition = 18 Brake = true end

	local OnStation = dX < (160+35*mu - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[Station]
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
	local AmpNorm = Train.Electric.Itotal < (350 - (Train:GetPhysicsObject():GetMass()-30000)/24) * math.floor(Train.PositionSwitch.Position + 0.5)
	local RheostatAccelRotating = AcceleratingActive
	if Slope < -2 then
		--if PP and (8 <= RKPosition and RKPosition <= 12) then
			RheostatAccelRotating = AmpNorm
		--end
	end
	local PneumaticValve1 = ((dX < 1.55) and (self.Speed > 0.1) and OnStation) or (self.Speed > (self.SpeedLimit - threshold))
	--or (Train:ReadCell(6) > 0 and Train:ReadCell(18) < 1 and Slope > 1)

	--Disable autodrive on end of station brake
	--local StatID = Metrostroi.WorkingStations[Station] or Metrostroi.WorkingStations[Station + (Path == 1 and 1 or -1)] or 0

	if (TargetBrakeRKPosition == 18 and self.Speed < 0.1 and not self.StartMoving and OnStation) or (self.StartMoving and 5 < dX and dX < 160) then
		if (TargetBrakeRKPosition == 18 and self.Speed < 0.1 and not self.StartMoving and OnStation) then
			--print("Stopped on "..Curr[1]..", "..(Curr[2] and "right side" or "left side")..", next station is "..(Next and (Next[1]..", "..(Next[2] and "right side" or "left side")) or "nil"))

			Train.VUD1:TriggerInput("Set",0)
			self.VUDOverride = true

			local Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if Station == 0 then return end
			--local StatID = Metrostroi.WorkingStations[Station] or Metrostroi.WorkingStations[Station + (Path == 1 and 1 or -1)] or 0
			local Curr = Metrostroi.AnnouncerData[Station]

			if Train.CustomA.Value < 0.5 then
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

				self.AutoTimer = CurTime() + 30
			end
		end
		self.AutrodriveReset = true
		return
	end

	-- Enter commands
	self["29"] = PneumaticValve1 and 1 or 0 -- Engage PN1
	Train:WriteCell(1, AcceleratingActive and 1 or 0) --Engage engines
	Train:WriteCell(2, (RheostatAccelRotating or (ElectricBrakeActive and RheostatBrakeRotating)) and 1 or 0) --X2/T2
	Train:WriteCell(3, (self.Speed > 30 and RheostatAccelRotating) and 1 or 0) --X3
	Train:WriteCell(6, ElectricBrakeActive and 1 or 0) --Engage brakes
	Train:WriteCell(20,(ElectricBrakeActive or not self.NoAcceleration) and 1 or 0) -- Engage power circuits
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	Train:WriteCell(17,1)
	timer.Simple(0.1,function()
		if not IsValid(Train) then return end
		Train:WriteCell(17,0)
	end)
end

function TRAIN_SYSTEM:MoscowARS(EnableARS,KRUEnabled,BPSWorking,EnableUOS,EPKActivated)
	local Train = self.Train
	if EnableARS then
		--Train.RPB:TriggerInput("Set",1)
		--print(Train.UOS:TriggerInput("Check"))
		-- Check absolute stop
		if self.RealNoFreq and (not self.PrevNoFreq) and Train:ReadTrainWire(6) < 1 then
			self.IgnorePedal = true
		end
		self.PrevNoFreq = self.RealNoFreq
		-- Check overspeed
		if self.Overspeed and not self.ARSBrake then
			self.ElectricBrake = true
			self.ARSBrake = true
			self.PneumaticBrake1 = true
			self.PV1Timer = CurTime() - (self.SpeedLimit <= 20 and 2 or 0)
		end
		-- Check cancel of overspeed command
		if not self.Overspeed and not self.ElectricBrake then
			self.PneumaticBrake1 = false
		end
		if self.KVT and (not self.Overspeed) then
			self.ElectricBrake = false
			self.ARSBrake = false
			self.PneumaticBrake1 = false
			self.PneumaticBrake2 = false
		end
		-- Check use of valve #1 during overspeed
		--self.PV1Timer = self.PV1Timer or -1e9
		if self.PV1Timer and ((CurTime() - self.PV1Timer) >= 1) then 
			if self.Overspeed then
				self.ElectricBrake = true
				self.PneumaticBrake2 = true
			else
				self.PneumaticBrake1 = false
				print(self.Overspeed)
			end
			self.PV1Timer = nil
		end
		if self.ARSBrake and self.ElectricBrake and self.Speed < 0.25 then
			self.PneumaticBrake2 = true
		end
		-- Parking brake limit
		triggerSpeed = 5
		if self.Speed < triggerSpeed and self.TW1Timer and (CurTime() - self.TW1Timer) > 7 and not self.PneumaticBrake1 and	not self.PneumaticBrake2 then
			if (not self.RealNoFreq and (not self.Train.SubwayTrain or self.Train.SubwayTrain.Type ~= "E" or (self.Train.SubwayTrain.Type == "E" and not self.KVT))) then
				self.PneumaticBrake1 = true
				if self.Speed > 0.25 then
					self.AntiRolling = true
				end
			else
				self.TW1Timer =  CurTime()
			end
		end
		--if self.AntiRolling and Train:ReadTrainWire(1) == 0 and Train.RRP and Train.RRP.Value == 0 and not Train.Pneumatic.EmergencyValveEPK then
			--Train.Pneumatic.EmergencyValveEPK = true
			--RunConsoleCommand("say","EPV braking (Driver don't reach 5km\\h in 7 sec')",Train:GetDriverName())
		--end
		if self.Speed > triggerSpeed and self.TW1Timer then
			self.TW1Timer = nil
		end
		if self.Speed < 0.25 then 
 			self.PneumaticBrake1 = true
		end
		--[[
		if self.Speed > triggerSpeed and self.TW1Timer then
			self.TW1Timer = nil
		end
		]]
		--BPS Logic
		local BPSWorking = (Train.BPS ~= nil and Train.BPS.Value > 0.5) and not KRUEnabled and Train:GetAngles().pitch < -1
		if not BPSWorking then
			self.StoppedOnSlopeByRP = false
			self.BPSActive = false
		end
		if (Train.BPS == nil or Train.BPS.Value < 0.5) then self.AntiRolling = false end
		if BPSWorking and Train.Panel and Train.Panel["GreenRP"] > 0.5 and self.Speed < 5 then
			self.StoppedOnSlopeByRP = true
		end
		-- Check parking brake functionality
		if self.Speed < 5 and BPSWorking and Train.LK4 and Train.LK4.Value == 0 then
			self.BPSActive = true
		end

		-- Check cancel pneumatic brake 1 command
		--if (Train.RV2) and (Train.RV2.Value > 0) then
		if ((Train:ReadTrainWire(1) > 0) or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake)) then
			if Train.Panel and Train.Panel["GreenRP"] < 0.5 then
				self.StoppedOnSlopeByRP = nil
			end
			if self.BPSActive then
				if Train.Pneumatic.BrakeCylinderPressure < 1.5 then
					Train.AVT:TriggerInput("Set",1)
				end
			end
			if (self.BPSActive and Train.LK4.Value > 0 and Train.KV.ControllerPosition > 0) then
				self.BPSActive = false
				if Train.Panel and Train.Panel["GreenRP"] < 0.5 then
					self.StoppedOnSlopeByRP = nil
				end
			end
			if Train.Pneumatic.BrakeCylinderPressure >= 1.5 and Train.Panel["GreenRP"] < 0.5 then
				self.BPSActive = false
			end
			if (Train:ReadTrainWire(1) > 0 or (Train.RRP and Train.RRP.Value > 0 and not self.ElectricBrake)) and self.PneumaticBrake1 and not self.Overspeed then
				self.TW1Timer = CurTime()
				self.PneumaticBrake1 = false
			end
		end
		-- Door close cancel pneumatic brake 1 command trigger
		if (Train:GetSkin() == 1) and (Train.KD) and Train.SubwayTrain.Name:sub(1,-2) == "81-71" then
			-- Prepare
			if (Train.KD.Value == 0) then
				self.KDReadyToRelease = true
			end
			if (Train.KD.Value == 1) and (self.KDReadyToRelease == true) then
				self.KDReadyToRelease = false
				self.PneumaticBrake1 = false
				self.TW1Timer = CurTime() - 2.0
			end
		end
		-- ARS signals
		local Ebrake, Abrake, NFBrake, Pbrake1,Pbrake2 =
			((self.ElectricBrake) and 1 or 0),
			((self.ARSBrake)  and 1 or 0),
			((self.RealNoFreq and not self.KVT and not self.ARSBrake) and 1 or 0),
			(self.PneumaticBrake1 and 1 or 0),
			(self.PneumaticBrake2 and 1 or 0)
		-- Apply ARS system commands
		self["33D"] = (1 - Abrake) *(1-NFBrake) --*(2 - Pbrake2)
		self["33G"] = Ebrake + NFBrake
		self["33Zh"] = (1 - Abrake)*(1-NFBrake)--*(2 - Pbrake2)
		--print(self["33Zh"])
		self["2"] = Ebrake + NFBrake
		self["20"] = Ebrake + NFBrake
		self["29"] = Pbrake1-- + (self.BPSActive and 1 or 0)
		--print(Train.Speed)
		--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.SpeedLimit,self.self.SpeedLimit <= 20 and not self.KVT) end
		--if StPetersburg then print(self.Train:EntIndex()) end
		self["8"] = Pbrake2
			+ (KRUEnabled and 1 or 0)*Ebrake
			+ ((self.SpeedLimit < 20 and not self.KVT or self.Speed > 20 and self.SpeedLimit < 20) and 1 or 0)
			+ (self.BPSActive and 1 or 0)
			+ (self.AntiRolling and 1 or 0)
			+ (1 - ((EPKActivated and 1 or 0) or 1))
		---self.LKT = (self["33G"] > 0.5) or (self["29"] > 0.5) or (Train:ReadTrainWire(35) > 0)
		self.LVD = self.LVD or self["33D"] < 0.5
		if Train:ReadTrainWire(6) < 1 and self["33D"] > 0.5  then  self.LVD = false end
		self.Ring = ((self["33D"] < 0.5 and NFBrake < 1) or self.KSZD)
		if self.ElectricBrake or self.PneumaticBrake2 then
			if not self.LKT and not self.EPKTimer then
				self.EPKTimer = CurTime() + ((10 <= self.Speed and self.Speed <= 30) and 5.5 or 3.3)
			elseif self.LKT then
				self.EPKTimer = nil
			end
		else
			self.EPKTimer = nil
		end
		--if self.BPSActive then self.AntiRolling = false end
		if EPKActivated and not self.LKT and self.Speed < 0.05 and Train:ReadTrainWire(1) == 0 then -- or (self.AntiRolling and Train:ReadTrainWire(1) > 0) then
			if not self.EPKTimer2 then
				self.EPKTimer2 = CurTime()+1
			end
			if self.EPKTimer2 and CurTime() - self.EPKTimer2 > 0 and not Train.Pneumatic.EmergencyValveEPK then
				Train.Pneumatic.EmergencyValveEPK = true

				RunConsoleCommand("say","EPV braking (LKT off when stopped)",Train:GetDriverName())
			end
		else
			self.EPKTimer2 = nil
		end
	else
		if (Train.RPB) and not self.AttentionPedal then
			--Train.RPB:TriggerInput("Open",1)
		end
		
		self.ElectricBrake = true
		self.PneumaticBrake1 = false
		self.PneumaticBrake2 = true
		self.ARSBrake = true
		self["33D"] = 0
		self["33Zh"] = 0
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0
		self["33G"] = 0
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0

		---self.LKT = false
		self.LVD = false
		self.Ring = false
		self.AntiRolling = false
	end
	-- ARS signalling train wires
	if EnableARS then
		self.Train:WriteTrainWire(21,self.LVD and 1 or 0)-----self.LKT and 1 or 0)
	else--if not EnableUOS then
		self.Train:WriteTrainWire(21,0)
	end
	-- ARS anti-door-closing
	if EnableARS and self.Train.SubwayTrain and self.Train.SubwayTrain.HaveASNP then
		local SD = self.Train:ReadTrainWire(15)
		if (SD < 1.0) and (self.Speed > 6.0) then
			self["31"] = CurTime()%(1/10)*10
			self["32"] = CurTime()%(1/10)*10
		else
			self["31"] = 0
			self["32"] = 0
		end
	end
	-- Special UPPS behavior
	if self.Train.A45 and self.Train.A45.Value == 1 and (Train.KV) then
		local distance = Train:ReadCell(49165)
		local skip_station = false

		-- Check if station must be skipped
		local station = Train:ReadCell(49160) > 0 and Train:ReadCell(49160) or Train:ReadCell(49161)
		if not Metrostroi.AnnouncerData[station] then
			skip_station = true
		end

		if (Train.CustomA and Train.CustomA.Value > 0.5 and distance < 120 and not self.UPPSOverride)
			or self.AutodriveEnabled or not Train.KV or Train.KV.ReverserPosition ~= 1.0 or Train.VB.Value ~= 1.0
			or Train.KV.ControllerPosition <= -0.5 or not EnableARS or not EnableALS or (self.Train.RC1 and (self.Train.RC1.Value == 0))then
			self.UPPSOverride = true
		end
		if distance > 120 then
			self.UPPSOverride = false
		end
		if distance < 120 and Train.KV.ControllerPosition > -0.5 and not self.UPPSBraking and not self.UPPSOverride and not skip_station then
			self.UPPSBraking = true
			Train:PlayOnce("dura1","cabin",0.5,50.0)
			timer.Create("UPPSAlarm"..Train:EntIndex(),4,0,function()
				if IsValid(Train) then
					Train:PlayOnce("dura1","cabin",0.5,50.0)
				else
					timer.Remove("UPPSAlarm"..Train:EntIndex())
				end
			end)
		end
		if skip_station then self.UPPSBraking = false end
		if ((distance > 120 or self.UPPSOverride) and self.UPPSBraking) then
			self["2"] = 0
			self["6"] = 0
			self["20"] = 0
			self["33D"] = 1
			self["33G"] = 0
			self["33Zh"] = 1
			timer.Remove("UPPSAlarm"..Train:EntIndex())
			self.UPPSBraking = false
		end

		if self.UPPSBraking then
			self:UPPS(Train)
		end
		-- Default trigger
		if (distance > 120) and (distance < 210) and (not skip_station) then self.UPPSArmed1 = true end
		if self.UPPSArmed1 and (distance < 120) and Train.VB.Value == 1.0 then
			Train:PlayOnce("upps","cabin",0.55,100.0)
			self.UPPSArmed1 = false
		end

		-- KV trigger
		if Train.KV and (Train.KV.ReverserPosition == 0.0) then
			self.UPPSArmed2 = true
			self.UPPSTimer2 = CurTime() + 1
		end
		if self.UPPSArmed2 and Train.KV and (Train.KV.ReverserPosition == 1.0) and Train.VB.Value == 1.0 and self.UPPSTimer2 and (CurTime() > self.UPPSTimer2) then
			Train:PlayOnce("upps","cabin",1,nil,true)
			self.UPPSArmed2 = false
		end
	elseif self.UPPSBraking then
		self["2"] = 0
		self["6"] = 0
		self["20"] = 0
		self["33D"] = 1
		self["33G"] = 0
		self["33Zh"] = 1
		timer.Remove("UPPSAlarm"..Train:EntIndex())
		self.UPPSBraking = false
	end
	-- RC1 operation
	if self.Train.RC1 and (self.Train.RC1.Value == 0) then
		local KAH = (Train.KAH ~= nil and Train.KAH.Value > 0.5) and 1 or 0
		self["33D"] = KAH
		self["33G"] = 0                
		self["33Zh"] = 1--KAH
		--
		self["2"] = 0
		self["20"] = 0
		self["29"] = 0
		--
		self["31"] = 0
		self["32"] = 0
		self["8"] = KRUEnabled and (1-Train.RPB.Value) or 0

		if not EnableARS and EnableUOS then
			self["33D"] = (self.Speed + 0.5 > 35) and 0 or KAH
			--self["33Zh"] = 1--(self.Speed + 0.5 > 40) and 0 or KAH
			self["8"] = (self.Speed + 0.5 > 35) and 1 or KRUEnabled and (1-Train.RPB.Value) or 0
		end
	else
		if (not EPKActivated) then
			self["33D"] = 0
			self["33Zh"] = 0
		end
	end
end

function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(Train:ReadCell(49165)) end
	self.LKT = true
	for i,train in ipairs(Train.WagonList) do
		--print(i,train.RKTT.Value,self["33G"],train.DKPT.Value)
		--if (train.RKTT and train.RKTT.Value < 0.5 and train.DKPT.Value < 0.5 and self["33G"] > 0) or (train.DKPT and train.DKPT.Value < 0.5 and self["33G"] == 0) then
		if (train.RKTT and train.RKTT.Value < 0.5 and train.DKPT.Value < 0.5) then-- or (train.DKPT and train.DKPT.Value < 0.5) then
			self.LKT = false
		end
	end
	local OverrideState = false
	if (not Train.VB) or (not Train.ALS) or (not Train.ARS) or (not Train.KV) then
		OverrideState = true
	end

	-- ALS, ARS state
	local KRUEnabled =  Train.KRU and Train.KRU.Position > 0
	local EnableARS = (OverrideState or (Train.VB.Value == 1.0) and (Train.KV.ReverserPosition ~= 0.0 or KRUEnabled))
	if Train.A42 and Train.A42.Value == 0.0 then EnableARS = false end
	local EnableALS = OverrideState or (Train.VB.Value == 1.0) and (not Train.A43 or Train.A43.Value == 1.0)
	local EnableUOS = OverrideState or (Train.VB.Value == 1.0) and ((Train.KV.ReverserPosition ~= 0.0) or KRUEnabled)
	--if self.Train.ARSType == 3 and self.Train:EntIndex() ~= 3472 then self.Train.ARSType = 1 end
	if not OverrideState then
		EnableARS = EnableARS and Train.ARS.Value == 1.0
		EnableALS = EnableALS and Train.ALS.Value == 1.0
		EnableUOS = EnableUOS and Train.UOS.Value == 1.0
	end
	self.EnableARS = EnableARS
	self.EnableALS = EnableALS
	local EPKActivated = Train.EPK and (Train.EPK.Value > 0.5 and Train.DriverValveDisconnect.Value > 0.5) 
	-- Pedal state
	--if (Train.PB) and Train.PB.Value > 0.5 then self.AttentionPedal = true end
	--if (Train.PB) and Train.PB.Value <  0.5 then self.AttentionPedal = false end
	local PB = Train.PB and Train.PB.Value > 0.5
	--(Train.PB) and Train.PB.Value > 0.5
	if PB and not self.AttentionPedalTimer and not self.Overspeed then
		self.AttentionPedalTimer = CurTime() + 1
	end
	
	if PB and self.AttentionPedalTimer and (CurTime() - self.AttentionPedalTimer) > 0  then
		self.AttentionPedal = true
	end
	if not PB and (self.AttentionPedalTimer or self.AttentionPedal) then
		self.AttentionPedal = false
		self.AttentionPedalTimer = nil
	end
	if PB or (Train.KVT) and Train.KVT.Value > 0.5 then self.KVT = true end
	if not PB and (Train.KVT) and Train.KVT.Value < 0.5 then self.KVT = false end

	-- Ignore pedal
	if self.IgnorePedal and self.KVT then
		self.KVT = false
	else
		self.IgnorePedal = false
	end

	-- Speed check and update speed data
	if CurTime() - (self.LastSpeedCheck or 0) > 0.5 then
		self.LastSpeedCheck = CurTime()
		self.Speed = (Train.Speed or 0)
	end

	if (Train.UAVA and Train.SpeedSign and Train.SpeedSign > 0 and self.Speed > 0.25) or EnableALS then
		local ars,arsback
		self.Timer = self.Timer or CurTime()
		if CurTime() - self.Timer > 1.00 then
			self.Timer = CurTime()
			-- Get train position
			local pos = Metrostroi.TrainPositions[Train] --Metrostroi.GetPositionOnTrack(Train:GetPos(),Train:GetAngles()) --(this metod laggy for dir checks)
			if pos then pos = pos[1] end
			-- Get previous ARS section
			if pos then 
				ars,arsback = Metrostroi.GetARSJoint(pos.node1,pos.x,Metrostroi.TrainDirections[Train], Train)
			end
			
			if Train.UAVA and Train.SpeedSign > 0 then
				if IsValid(arsback) then
					if arsback == self.AutostopSignal then
						Train.Pneumatic.EmergencyValve = not Train.Pneumatic.UAVA
						self.UAVAContacts = not Train.Pneumatic.UAVA
						self.AutostopSignal = nil
						if not Train.Pneumatic.UAVA then
							RunConsoleCommand("say","Autostop braking",Train:GetDriverName(),arsback.Name)
						end
						if Train.A5 and Train.A5.Value < 1 then
							RunConsoleCommand("say","Passed stop signal",Train:GetDriverName(),arsback.Name)
						end
					end
				end
				if IsValid(ars) then
					if ars.AutoEnabled then
						self.AutostopSignal = ars
						--print("enty")
					elseif self.AutostopSignal == ars then
						self.AutostopSignal = nil
						--print("entn")
					end
				end
			end

			if not OverrideState and Train:ReadTrainWire(5) < 1 then
				ars = nil
				self.RealNoFreq = true
				self.NoFreq = true
				self.CheckedNF = 2
			end
		
			if IsValid(ars) then
				self.CheckedNF = 0
				self.Alert = nil
				self.Signal80	= ars:GetARS(8,Train)
				self.Signal70	= ars:GetARS(7,Train)
				self.Signal60	= ars:GetARS(6,Train)
				self.Signal40	= ars:GetARS(4,Train)
				self.Signal0	= ars:GetARS(0,Train)
				self.Special	= ars:Get325Hz()
				self.NoFreq		= ars:GetARS(1,Train) or not (self.Signal80 or self.Signal70 or self.Signal60 or self.Signal40 or self.Signal0)
				if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then RunConsoleCommand("say",ars.Name,tostring(arsback and arsback.Name),tostring(ars.NextSignalLink and ars.NextSignalLink.Name or "unknown"),tostring(pos.node1.path.id),tostring(Metrostroi.TrainDirections[Train])) end
				self.RealNoFreq = not (self.Signal80 or self.Signal70 or self.Signal60 or self.Signal40 or self.Signal0)
			else
				if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then RunConsoleCommand("say","LOSE SIGNAL",tostring(pos and pos.node1.path.id or "unknown"),tostring(Metrostroi.TrainDirections[Train])) end
				if (self.CheckedNF  and self.CheckedNF > 1) or (self.CheckedNF == 0 and self.NoFreq) or self.RealNoFreq then
					self.Alert = nil
					self.Signal80 = false
					self.Signal70 = false
					self.Signal60 = false
					self.Signal40 = false
					self.Signal0 = false
					self.Special = false
					self.NoFreq = true
					self.RealNoFreq = true
					self.CheckedNF = 2
				else
					if not self.CheckedNF then self.CheckedNF = 0 end
					self.CheckedNF = self.CheckedNF + 1
					self.NoFreq = true
					self.Alert = CurTime() + 0.5
				end
			end
			self.Signal = ars
		end
	end
	-- Check ARS signals
	if not EnableALS --[[or EnableUOS]] then
		self.Signal80 = false
		self.Signal70 = false
		self.Signal60 = false
		self.Signal40 = false
		self.Signal0 = false
		self.Special = false
		self.NoFreq = EnableARS
		self.RealNoFreq = EnableARS
		self.CheckedNF = 2
		self.Alert = nil
	end

	-- ARS system placeholder logic
	if EnableALS --[[or EnableUOS]] then
		local V = math.floor(self.Speed +0.05)
		local Vlimit = 0
		if self.Signal40 then Vlimit = 40 end
		if self.Signal60 then Vlimit = 60 end
		if self.Signal70 then Vlimit = 70 end
		if self.Signal80 then Vlimit = 80 end

		self.Overspeed = false
		if self.AttentionPedal then
			Vlimit = 0
		end
		if (    self.KVT) and (Vlimit ~= 0) and (V > Vlimit) then self.Overspeed = true end
		if (    self.KVT) and (Vlimit == 0) and (V > 20) then self.Overspeed = true end
		if (not self.KVT) and (V > Vlimit) and (V > (self.RealNoFreq and 0 or 3)) then self.Overspeed = true end
		--if (    self.KVT) and (Vlimit == 0) and self.Train.ARSType and self.Train.ARSType == 3 and not self.Train["PA-KSD"].VRD then self.Overspeed = true end
		--self.Ring = self.Overspeed and (self.Speed > 5)

		-- Determine next limit and current limit
		self.SpeedLimit = Vlimit
		self.NextLimit = Vlimit
		if self.Signal80 then self.NextLimit = 80 end
		if self.Signal70 then self.NextLimit = 70 end
		if self.Signal60 then self.NextLimit = 60 end
		if self.Signal40 then self.NextLimit = 40 end
		if self.Signal0  then self.NextLimit =  0 end
		--[=[if EnableUOS then
			--hack
			--[[
			if self.NextLimit >= 60 then
				self.SpeedLimit = 40
			else
				self.SpeedLimit = 20
			end]]
			self.SpeedLimit = 40
			self.Overspeed = false
			if (not self.KVT) then self.Overspeed = true end
			if (    self.KVT) and (V > self.SpeedLimit) then self.Overspeed = true end
		else]=]
		if not EnableARS then
			self.ElectricBrake = false
			self.PneumaticBrake1 = false
			self.PneumaticBrake2 = false
		end
		--self.Ring = false
	else
		local V = math.floor(self.Speed +0.05)
		self.SpeedLimit = 0
		self.NextLimit = 0
		self.Overspeed = false
		if not self.KVT and V > 0 then self.Overspeed = true end
		if (    self.KVT) and (V > 20) then self.Overspeed = true end
	end
	if StPetersburg then
		--if not self.PiterARS then print(self.Train.Owner) end
		self:PiterARS(EnableARS,KRUEnabled,BPSWorking,EPKActivated,dT)
	else
		self:MoscowARS(EnableARS,KRUEnabled,BPSWorking,EnableUOS,EPKActivated)
	end
	if Train.RV_2 then
		Train.RV_2:TriggerInput("Set",EnableARS and 1 or 0)
	end

	if EPKActivated then
		if (self.EPKOffARS or self.EPKTimer3) and not Train.Pneumatic.EmergencyValveEPK then
			Train.Pneumatic.EmergencyValveEPK = true
			if self.EPKOffARS then
				RunConsoleCommand("say","EPV braking (Was the emergency brake)",Train:GetDriverName())
			else
				RunConsoleCommand("say","EPV braking (3 sec has not passed)",Train:GetDriverName())
			end
		end
		self.EPKTimer3 = nil
		self.EPKOffARS = nil
		--if self.EPKTimer then print(self.EPKTimer - CurTime(),self.EPKTimer < CurTime(),self.EPKTimer > CurTime() ) end
		if (not EnableARS or (self.EPKTimer and self.EPKTimer < CurTime())) and not Train.Pneumatic.EmergencyValveEPK then
			Train.Pneumatic.EmergencyValveEPK = true
			if not EnableARS then
				RunConsoleCommand("say","EPV braking (ARS disabled)",Train:GetDriverName())
			else
				RunConsoleCommand("say","EPV braking (LKT not light-up on ARS stopping)",Train:GetDriverName())
			end
		end
		if self.EPKTimer4 and self.EPKTimer4 < CurTime() and not Train.Pneumatic.EmergencyValveEPK then
			Train.Pneumatic.EmergencyValveEPK = true
			RunConsoleCommand("say","EPV braking (Braking 5 second)",Train:GetDriverName())
			self.EPKTimer4 = nil
		end
	else
		--[[if EnableARS and self.EPKOffARS == nil then
			self.EPKOffARS = true
		else
			self.EPKOffARS = false
		end]]
		if EnableARS and self.EPKOffARS == nil then
			self.EPKOffARS = Train.Pneumatic and Train.Pneumatic.EmergencyValveEPK or false
		end
		if Train.Pneumatic and Train.Pneumatic.EmergencyValveEPK then
			Train.Pneumatic.EmergencyValveEPK = false
		end
		if Train.KV and Train.KV.ReverserPosition == 0.0 then
			self.AntiRolling = false
		end
		if not EnableARS then
			if self.EPKTimer3 == nil then
				self.EPKTimer3 = CurTime() + 2
			elseif self.EPKTimer3 and CurTime() - self.EPKTimer3 > 0 then
				self.EPKTimer3 = false
			end
		end
		--if self.EPKOffARS then
			--self.EPKOffARS = false
		--end
	end
	--if GetConVarNumber("metrostroi_ars_printnext") == Train:EntIndex() then print(self.EPKOffARS,EnableARS) end
	if not EnableARS then self.EPKOffARS = false end
	-- 81-717 autodrive/autostop
	if (Train.Pneumatic and Train.Pneumatic.EmergencyValve) or self.UAVAContacts then
		self["33D"] = 0
		self["33Zh"] = 1
	end

	-- 81-717 special VZ1 button
	if self.Train.VZ1 then
		self["29"] = self["29"] + self.Train.VZ1.Value
	end
	if Train.UAVAContact and Train.UAVAContact.Value > 0.5 and not Train.Pneumatic.EmergencyValve then
		self.UAVAContacts = nil
	end
	self["8"] = self["8"]*(self.Train.A41 and self.Train.A41.Value or 1)*(self.Train.A8 and self.Train.A8.Value or 1)
	self["29"] = self["29"]*(self.Train.A8 and self.Train.A8.Value or 1)
	self.Ring = self.Ring or (self.Alert and self.Alert - CurTime() > 0)
	if Train.Rp8 then Train.Rp8:TriggerInput("Set",self["8"] + ((self.Train.RC1 and (self.Train.RC1.Value == 0)) and (1-self["33D"]) or 0)) end
	self.Ring = self.RingOverride or self.Ring
end