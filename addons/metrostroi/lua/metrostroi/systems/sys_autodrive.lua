--------------------------------------------------------------------------------
-- Автоведение
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Autodrive")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
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
	self.MU = -0.25
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end

function TRAIN_SYSTEM:GetStationRK(dX)
	-- Calculate RK position based on distance and autodrive profile
	local TargetBrakeRKPosition = 1
	if dX < 160+35*self.MU   then TargetBrakeRKPosition = 1 end
	if dX < 70+35+25*self.MU then TargetBrakeRKPosition = 3 end
	if dX < 50+30+20*self.MU then TargetBrakeRKPosition = 5 end
	if dX < 20+25+15*self.MU then TargetBrakeRKPosition = 9 end
	if dX < 10+20+10*self.MU then TargetBrakeRKPosition = 12 end
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
	local dX = Train:ReadCell(49165) + (self.Corrections[self.Train.UPO.Station] or 0) - 4.3
	local speedLimit = (Train.ALS_ARS.Signal0 or Train.ALS_ARS.RealNoFreq) and 0 or Train.ALS_ARS.Signal40 and 40 or Train.ALS_ARS.Signal60 and 60 or Train.ALS_ARS.Signal70 and 70 or Train.ALS_ARS.Signal80 and 80 or 0
	local OnStation = dX < (160+35*self.MU - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Train.UPO.Station]and Metrostroi.AnnouncerData[self.Train.UPO.Station][1]
	if StationBraking and (dX >= (160+35*self.MU - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.Train.UPO.StationAutodrive = false return end
	--print(Train:ReadCell(49165) + (Corrections[self.Train.UPO.Station] or 0) - 4.3)
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

	-- How smooth braking should be (higher self.MU = more gentle braking)
	-- Full stop command
	if Train.ALS_ARS.SpeedLimit < 30 then TargetBrakeRKPosition = 18 Brake = true end
	--print(OnStation,dX,self.Train.UPO.Station)
	-- Calculate RK position based on distance and autodrive profile
	if OnStation then
		TargetBrakeRKPosition = self:GetStationRK(dX)
	else
		if dX > (160+35*self.MU - (speedLimit == 40 and 30 or 0)) then self.StartMoving = nil end
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
	--local StatID = Metrostroi.WorkingStations[self.Train.UPO.Station] or Metrostroi.WorkingStations[self.Train.UPO.Station + (self.Path == 1 and 1 or -1)] or 0

	if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) or (self.StartMoving and 10 < dX and dX < 160) then
		if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) then
			self.Train.UPO.StationAutodrive = false
			--print("Stopped on "..Curr[1]..", "..(Curr[2] and "right side" or "left side")..", next station is "..(Next and (Next[1]..", "..(Next[2] and "right side" or "left side")) or "nil"))

			--
			--self.VUDOverride = true

			--local self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if self.Train.UPO.Station == 0 then return end
			--local StatID = Metrostroi.WorkingStations[self.Train.UPO.Station] or Metrostroi.WorkingStations[self.Train.UPO.Station + (self.Path == 1 and 1 or -1)] or 0
			if GetConVarNumber("metrostroi_paksd_autoopen",0) > 0 and not StationBraking then
				local Curr = Metrostroi.AnnouncerData[self.Train.UPO.Station]
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
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

TRAIN_SYSTEM.Commands = {
	{
		[108] = {
		},		
		[109] = {
			[1366] = 0,
			[1217] = 3,
			[981] = 0,
			[684] = 3,
			[338] = 0,
			[259] = 2,
			[152] = 0,
		},
	},
	{
	}
}
function TRAIN_SYSTEM:GetCurrentCommand()
	self.Commands = {
		{
			[108] = {
				{9999,2},
			},		
			[109] = {
				{9999,2},
				{1366,0},
				{1217,3},
				{981,0},
				{684,3},
				{338,0},
				{259,2},
				{152,-6},
			},
			[110] = {
				{9999,2},
				{1003,0},
				{1016,-1},
				{885,0},
				{136,-6},
			},
			[111] = {
				{9999,2},
				{860,0},
				{335,-1},
				{233,0},
				{153,-6},
			},
			[112] = {
				{9999,2},
				{1809,3},
				{1645,0},
				{1446,-4},
				{1402,-4},
				{1286,0},
				{1220,-4},
				{1049,0},
				{541,-5},
				{403,0},
				{138,-6},
			},
		},
		{
			[111] = {
				{9999,2},
				{1651,3},
				{1464,0},
				{1260,2},
				{1232,2},
				{893,0},
				{847,2},
				{712,0},
				{491,-4},
				{288,0},
				{216,2},
				{156,0},
				{170,-6},
			},
			[110] = {
				{9999,2},
				{805,3},
				{770,0},
				{127,-6},
			},
			[109] = {
				{9999,3},
				{1043,0},
				{419,2},
				{353,3},
				{224,0},
				{176,-6},
			},
			[108] = {
				{9999,2},
				{1433,0},
				{1345,-1},
				{1339,-2},
				{1167,-1},
				{1075,0},
				{817,-1},
				{650,0},
				{167,-6},
			},
		}
	}
	--print(self.Train:ReadCell(49165))
	--print(self.Commands[2][self.Train.UPO.Station],self.Train.UPO.Station)
	if (Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) then
		self.PathID = Metrostroi.TrainPositions[self.Train][1].path.id
	end
	if not self.Commands[self.PathID] or not self.Commands[self.PathID][self.Train.UPO.Station] then return 2 end
	if self.Train:ReadCell(49165) < 20 and not self.OnStation then return 2 end
	local max-- = self.Train:ReadCell(49165)
	local pos
	for k,v in ipairs(self.Commands[self.PathID][self.Train.UPO.Station]) do
		if v[1] > self.Train:ReadCell(49165) then
			max = v[1]
			pos = v[2]
		end
	end
	if pos > -4 then
		return pos
	elseif pos == -4 then
		local RKPosition = math.floor(self.Train.RheostatController.Position+0.5)
		return not self.Train:GetPackedBool(35) and RKPosition < 7 and -3 or -1
	elseif pos == -5 then
		local speedLimit = (self.Train.ALS_ARS.Signal0 or self.Train.ALS_ARS.RealNoFreq) and 0 or self.Train.ALS_ARS.Signal40 and 40 or self.Train.ALS_ARS.Signal60 and 60 or self.Train.ALS_ARS.Signal70 and 70 or self.Train.ALS_ARS.Signal80 and 80 or 0
		return self.Train.Speed > speedLimit-5 and -2 or -1
	elseif pos == -6 then
		self.OnStation = true
		local RKPosition = math.floor(self.Train.RheostatController.Position+0.5)
		local S = self.Train:ReadCell(49165) + (self.Corrections[self.Train.UPO.Station] or 0) - 4.3
		if self.Train.Speed < 0.5 then self:Disable() end
		local RK = self:GetStationRK(S)
		return (not self.Train:GetPackedBool(35) and (RK > RKPosition or RK == 18)) and -3 or -1 
	end
end
function TRAIN_SYSTEM:BoardAutodrive()
	local Train= self.Train
	-- Calculate distance to station
	local dX = Train:ReadCell(49165) + (self.Corrections[self.Train.UPO.Station] or 0) - 4.3
	local OnStation = dX < (160+35*self.MU - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Train.UPO.Station]and Metrostroi.AnnouncerData[self.Train.UPO.Station][1]
	--if StationBraking and (dX >= (160+35*self.MU - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.Train.UPO.StationAutodrive = false return end
	--print(Train:ReadCell(49165) + (Corrections[self.Train.UPO.Station] or 0) - 4.3)
	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local Command = self:GetCurrentCommand()
	print(self.Train.Owner,Command)
	local KVPos = Command
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
	if OnStation then
		self.Train.R25p:TriggerInput("Set",self.OldRheostatBrakeRotating ~= RheostatBrakeRotating)
		self.OldRheostatBrakeRotating = RheostatBrakeRotating	
	end
	Train:WriteCell(29, PneumaticValve1 and 1 or 0) -- Engage PN1
	Train:TriggerInput("KVControllerAutodriveSet",KVPos)
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

function TRAIN_SYSTEM:Enable()
	if not self.AutodriveEnabled and not self.AutodriveReset then
		self.AutodriveEnabled = true
		self.StartMoving = true
	end
end
function TRAIN_SYSTEM:Disable()
	self.AutodriveReset = true
end
function TRAIN_SYSTEM:Think()
	if self.Train.VZP then
		if self.Train.BCCD.Value > 0 then
			self.Train.PAKSD_DOOR:TriggerInput("Set",0)
		end
		--[[if Train:CPPIGetOwner() and Train:CPPIGetOwner():GetName() ~= "glebqip(RUS)" and (self.AutodriveEnabled or not self.AutodriveReset) then
			self.AutodriveReset = true
		else]]

		if self.AutodriveReset then
			self.Train:TriggerInput("KVControllerAutodriveSet",4)
			self.NoAcceleration = nil
			self.Train:WriteCell(29,0)
			self.AutodriveEnabled = false
			self.OnStation = false
		end

		if self.Train.VZP.Value < 0.5 and self.AutodriveReset then
			self.AutodriveReset = false
		end
		--Disable autodrive, if KV pos is not zero, ARS or ALS not enabled, Reverser position is not forward or Driver value pos is > 2
		if self.Train.Blok and self.Train.Blok ~= 1 then
			if (self.Train.Pneumatic.BrakeLinePressure < 4.8 or self.Train.Pneumatic.BrakeCylinderPressure > 1.8) and not self.BCTimer then
				self.BCTimer = CurTime()+3
			end
			if self.Train.Pneumatic.BrakeLinePressure >= 4.8 and self.Train.Pneumatic.BrakeCylinderPressure <= 1.8 then
				self.BCTimer = nil
			end
			if self.BCTimer and CurTime() - self.BCTimer > 0 then
				self:Disable()
			end
			if self.Train.KV.ControllerPosition ~= 0.0 or not self.Train.ALS_ARS.EnableARS or self.Train.KV.ReverserPosition ~= 1.0 or self.Train.Panel.SD < 0.5 then
				self:Disable()
			end
			if self.Train.ALS_ARS["33G"] > 0.5 then
				self:Disable()
			end
		end
		--if self.OnStation and self.Train.UPO.StationAutodrive and self.AutodriveWorking and not self.VRD and self.Train.ALS_ARS.EnableARS and self.Train.KV.ReverserPosition == 1.0 and self.Train.Pneumatic.DriverValvePosition <= 2 and self.self.Train.Panel.SD > 0.5 then
			--self:Autodrive(true)
		--elseif self.Train.UPO.StationAutodrive then
			--self.Train.UPO.StationAutodrive = false
		--end
		if self.AutodriveEnabled then
			if self.Train.Blok ~= 1  then
				self:Autodrive()
			else
				self:BoardAutodrive()
			end
		end
		if self.Blocks == 2 and self["PA-KSD"].StationAutodrive then
			self:Autodrive(true)
		end
		--end
	end
	if self.RealControllerPosition ~= self.Train.KV.RealControllerPosition and self.Train.Blok == 1 then
		local dX = self.Train:ReadCell(49165) + (self.Corrections[self.Train.UPO.Station] or 0) - 4.3
		--RunConsoleCommand("say",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5))
		--file.Append("puav.txt",Format("%d\t%s\t%d\t%s\t%d\n",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5)))
		self.RealControllerPosition = self.Train.KV.RealControllerPosition
	end
	--self:GetCurrentCommand()
	--print(Metrostroi.TrainPositions[self.Train][1].x)
end
