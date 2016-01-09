--------------------------------------------------------------------------------
-- Пневматическая система 81-717
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717_Pneumatic")
TRAIN_SYSTEM.DontAccelerateSimulation = true
local LKNames = { "LK1", "LK2", "LK3", "LK4", "LK5" }

function TRAIN_SYSTEM:Initialize()

	self.ValveType = 1
	
	-- Position of the train drivers valve 
	--  Type 1 (334)
	-- 1 Accelerated charge
	-- 2 Normal charge (brake release)
	-- 3 Closed
	-- 4 Service application
	-- 5 Emergency application
	--
	-- Type 2 (013)
	-- 1 Accelerated charge
	-- 2 Normal charge (brake release)
	-- 3 Closed
	-- 4 Service application
	-- 5 Emergency application
	self.DriverValvePosition = 2
	self.RealDriverValvePosition = self.DriverValvePosition
	

	-- Pressure in reservoir
	self.ReservoirPressure = 0.0 -- atm
	-- Pressure in trains feed line
	self.TrainLinePressure = 8.0 -- atm
	-- Pressure in trains brake line
	self.BrakeLinePressure = 0.0 -- atm
	-- Pressure in brake cylinder
	self.BrakeCylinderPressure = 0.0 -- atm
	-- Pressure in the door line
	self.DoorLinePressure = 0.0 -- atm

	--DKPT
	self.Train:LoadSystem("DKPT","Relay","R-52B") --
	-- Valve #1
	self.Train:LoadSystem("PneumaticNo1","Relay")
	-- Valve #2
	self.Train:LoadSystem("PneumaticNo2","Relay")
	-- Автоматический выключатель торможения (АВТ)
	self.Train:LoadSystem("AVT","Relay","AVT-325")
	-- Регулятор давления (АК)
	self.Train:LoadSystem("AK","Relay","AK-11B")	
	-- Автоматический выключатель управления (АВУ)
	self.Train:LoadSystem("AVU","Relay","AVU-045")
	-- Блокировка тормозов
	self.Train:LoadSystem("BPT","Relay","")
	-- Блокировка дверей
	self.Train:LoadSystem("BD","Relay","")
	-- Вентили дверного воздухораспределителя (ВДОЛ, ВДОП, ВДЗ)
	self.Train:LoadSystem("VDOL","Relay","")
	self.Train:LoadSystem("VDOP","Relay","")
	self.Train:LoadSystem("VDZ","Relay","")
	
	
	-- Разобщение клапана машиниста
	self.Train:LoadSystem("DriverValveDisconnect","Relay","Switch")
	-- Воздухораспределитель
	self.Train:LoadSystem("AirDistributorDisconnect","Relay","Switch")
	--УАВА
	self.Train:LoadSystem("UAVA","Relay","Switch",{uava = true})
	self.Train:LoadSystem("UAVAContact","Relay","Switch",{button = true})
	--Стояночный тормоз
	self.Train:LoadSystem("ParkingBrake","Relay","Switch")
	self.Train:LoadSystem("ParkingBrakeSign","Relay","Switch")
	--ЭПК
	self.Train:LoadSystem("EPK","Relay","Switch")
	-- Isolation valves
	self.Train:LoadSystem("FrontBrakeLineIsolation","Relay","Switch", { normally_closed = true})
	self.Train:LoadSystem("RearBrakeLineIsolation","Relay","Switch", { normally_closed = true})
	self.Train:LoadSystem("FrontTrainLineIsolation","Relay","Switch", { normally_closed = true})
	self.Train:LoadSystem("RearTrainLineIsolation","Relay","Switch", { normally_closed = true})

	-- Brake cylinder atmospheric valve open
	self.BrakeCylinderValve = 0
	
	-- Overpressure protection valve open
	self.TrainLineOverpressureValve = 0
	
	-- Compressor simulation
	self.Compressor = 0 --Simulate overheat with TRK FIXME
	
	-- Disconnect valve status
	self.DriverValveDisconnectPrevious = 0
	
	-- Doors state
	--[[self.Train:LoadSystem("LeftDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("LeftDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("LeftDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("LeftDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("RightDoor1","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("RightDoor2","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("RightDoor3","Relay",{ open_time = 0.5, close_time = 0.5 })
	self.Train:LoadSystem("RightDoor4","Relay",{ open_time = 0.5, close_time = 0.5 })]]--
	self.LeftDoorState = { 0,0,0,0 }
	self.RightDoorState = { 0,0,0,0 }
	
	self.PlayOpen = 1e9
	self.PlayClosed = 1e9
	self.TrainLineOpen = false

	self.EmergencyValve = false
	self.EmergencyValveEPK = false
	self.OldValuePos = self.DriverValvePosition
end

function TRAIN_SYSTEM:Inputs()
	return { "BrakeUp", "BrakeDown", "BrakeSet", "ValveType" }
end

function TRAIN_SYSTEM:Outputs()
	return { "BrakeLinePressure", "BrakeCylinderPressure", "DriverValvePosition", 
			 "ReservoirPressure", "TrainLinePressure", "DoorLinePressure" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "BrakeSet" then
		self.DriverValvePosition = math.floor(value)
		if self.ValveType == 1 then
			if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
			if self.DriverValvePosition > 5 then self.DriverValvePosition = 5 end
		else
			if self.DriverValvePosition < 1 then self.DriverValvePosition = 1 end
			if self.DriverValvePosition > 7 then self.DriverValvePosition = 7 end
		end
	elseif (name == "BrakeUp") and (value > 0.5) then
		self:TriggerInput("BrakeSet",self.DriverValvePosition+1)
	elseif (name == "BrakeDown") and (value > 0.5) then
		self:TriggerInput("BrakeSet",self.DriverValvePosition-1)
	elseif name == "ValveType" then
		self.ValveType = math.floor(value)
	end
end




-- Calculate derivatives
function TRAIN_SYSTEM:equalizeLeakPressure(dT,pressure,train,valve_status,rate,close_rate)
	if not valve_status then return end
	local other
	if IsValid(train) then other = train.Pneumatic end
	
	-- Get second pressure
	local P2 = 0
	if other then P2 = other[pressure] end
	if (not other) and (valve_status) then
		self.TrainLineOpen = (pressure == "TrainLinePressure")
		rate = close_rate or rate
		--self.TrainLinePressure_dPdT = 0.0
	end
	
	-- Calculate rate
	local dPdT = rate * (P2 - self[pressure])
	-- Calculate delta
	local dP = dPdT*dT
	-- Equalized pressure
	local P0 = (P2 + self[pressure]) / 2
	-- Update pressures
	if dP > 0 then
		self[pressure] = math.min(P0,self[pressure] + dP)
		if other then
			other[pressure] = math.max(P0,other[pressure] - dP)
		end
	else
		self[pressure] = math.max(P0,self[pressure] + dP)
		if other then
			other[pressure] = math.min(P0,other[pressure] - dP)
		end
	end
	-- Update delta if losing air
	if self.TrainLineOpen and (pressure == "TrainLinePressure") then
		self[pressure.."_dPdT"] = (self[pressure.."_dPdT"] or 0) + dPdT
	end
end
-------------------------------------------------------------------------------
function TRAIN_SYSTEM:UpdatePressures(Train,dT)
	local frontBrakeOpen = Train.FrontBrakeLineIsolation.Value == 0
	local rearBrakeOpen = Train.RearBrakeLineIsolation.Value == 0
	local frontTrainOpen = Train.FrontTrainLineIsolation.Value == 0
	local rearTrainOpen = Train.RearTrainLineIsolation.Value == 0
	
	local frontBrakeLeak = false
	local rearBrakeLeak = false
	local frontTrainLeak = false
	local rearTrainLeak = false

	-- Check if both valve on this train and connected train are open
	if Train.FrontTrain and Train.FrontTrain.FrontBrakeLineIsolation then
		Train.FrontTrain.FrontBrakeLineIsolation = Train.FrontTrain.FrontBrakeLineIsolation or
			{ Value = 1 }
		Train.FrontTrain.RearBrakeLineIsolation = Train.FrontTrain.RearBrakeLineIsolation or
			{ Value = 1 }
		Train.FrontTrain.FrontTrainLineIsolation = Train.FrontTrain.FrontTrainLineIsolation or
			{ Value = 1 }
		Train.FrontTrain.RearTrainLineIsolation = Train.FrontTrain.RearTrainLineIsolation or
			{ Value = 1 }
		if Train.FrontTrain.FrontTrain == Train then -- Nose to nose
			frontBrakeLeak = frontBrakeOpen and (Train.FrontTrain.FrontBrakeLineIsolation.Value == 1)
			frontTrainLeak = frontTrainOpen and (Train.FrontTrain.FrontTrainLineIsolation.Value == 1)
		else -- Rear to nose
			frontBrakeLeak = frontBrakeOpen and (Train.FrontTrain.RearBrakeLineIsolation.Value == 1)
			frontTrainLeak = frontTrainOpen and (Train.FrontTrain.RearTrainLineIsolation.Value == 1)
		end
	end
	if Train.RearTrain and Train.RearTrain.FrontBrakeLineIsolation then
		Train.RearTrain.FrontBrakeLineIsolation = Train.RearTrain.FrontBrakeLineIsolation or
			{ Value = 1 }
		Train.RearTrain.RearBrakeLineIsolation = Train.RearTrain.RearBrakeLineIsolation or
			{ Value = 1 }
		Train.RearTrain.FrontTrainLineIsolation = Train.RearTrain.FrontTrainLineIsolation or
			{ Value = 1 }
		Train.RearTrain.RearTrainLineIsolation = Train.RearTrain.RearTrainLineIsolation or
			{ Value = 1 }
		if Train.RearTrain.FrontTrain == Train then -- Back to back
			rearBrakeLeak = rearBrakeOpen and (Train.RearTrain.FrontBrakeLineIsolation.Value == 1)
			rearTrainLeak = rearTrainOpen and (Train.RearTrain.FrontTrainLineIsolation.Value == 1)
		else -- Back to nose
			rearBrakeLeak = rearBrakeOpen and (Train.RearTrain.RearBrakeLineIsolation.Value == 1)
			rearTrainLeak = rearTrainOpen and (Train.RearTrain.RearTrainLineIsolation.Value == 1)
		end
	end
	
	-- Equalize pressure
	self.TrainLineOpen = false
	if self.ValveType == 1 then
		self:equalizeLeakPressure(dT,"ReservoirPressure",nil,self.EmergencyValve or self.EmergencyValveEPK,0.45 + 0.1875*(Train:GetWagonCount() - 1))
	else
		self:equalizeLeakPressure(dT,"BrakeLinePressure",nil,self.EmergencyValve or self.EmergencyValveEPK,0.75 + 0.1875*(Train:GetWagonCount() - 1))--1.5
	end

	local Ft = Train.FrontTrain
	local Rt = Train.RearTrain
	if frontBrakeLeak then Ft = nil end
	if rearBrakeLeak then Rt = nil end
	if self.ValveType == 1 then
		if not Ft then self:equalizeLeakPressure(dT,"ReservoirPressure",Ft,frontBrakeOpen,200.0) end
		if not Rt then self:equalizeLeakPressure(dT,"ReservoirPressure",Rt,rearBrakeOpen,200.0) end
	end
	self:equalizeLeakPressure(dT,"BrakeLinePressure",Ft,frontBrakeOpen,200.0)
	self:equalizeLeakPressure(dT,"BrakeLinePressure",Rt,rearBrakeOpen,200.0)
	--end
	local Ft = Train.FrontTrain
	local Rt = Train.RearTrain
	if frontTrainLeak then Ft = nil end
	if rearTrainLeak then Rt = nil end
	self:equalizeLeakPressure(dT,"TrainLinePressure",Ft,frontTrainOpen,200.0,0.08)
	self:equalizeLeakPressure(dT,"TrainLinePressure",Rt,rearTrainOpen,200.0,0.08)
end




function TRAIN_SYSTEM:equalizePressure(dT,pressure,target,rate,fill_rate,no_limit,smooth)
	if fill_rate and (target > self[pressure]) then rate = fill_rate end
	
	-- Calculate derivative
	local dPdT = rate
	if target < self[pressure] then dPdT = -dPdT end
	local dPdTramp = math.min(1.0,math.abs(target - self[pressure])*(smooth or 0.5))
	dPdT = dPdT*dPdTramp

	-- Update pressure
	self[pressure] = self[pressure] + dT * dPdT
	self[pressure] = math.max(0.0,math.min(16.0,self[pressure]))
	self[pressure.."_dPdT"] = (self[pressure.."_dPdT"] or 0) + dPdT
	if no_limit ~= true then
		if self[pressure] == 0.0  then self[pressure.."_dPdT"] = 0 end
		if self[pressure] == 16.0 then self[pressure.."_dPdT"] = 0 end
	end
	return dPdT
end
-------------------------------------------------------------------------------
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	
	-- Apply specific rate to equalize pressure
	
	
	----------------------------------------------------------------------------
	-- Accumulate derivatives
	self.TrainLinePressure_dPdT = 0.0
	self.BrakeLinePressure_dPdT = 0.0
	self.ReservoirPressure_dPdT = 0.0
	self.BrakeCylinderPressure_dPdT = 0.0
	
	-- Reduce pressure for brake line
	self.TrainToBrakeReducedPressure = math.min(5.1,self.TrainLinePressure) -- * 0.725)
	-- Feed pressure to door line
	self.DoorLinePressure = self.TrainToBrakeReducedPressure * 0.90
	
	local trainLineConsumption_dPdT = 0.0
	if self.ValveType == 1 then
		-- 334: 1 Fill reservoir from train line, fill brake line from train line
		if (self.DriverValvePosition == 1) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"ReservoirPressure", self.TrainLinePressure, 1.50)
			
			self.BrakeLinePressure = self.ReservoirPressure
			self.BrakeLinePressure_dPdT = self.ReservoirPressure_dPdT
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 334: 2 Brake line, reservoir replenished from brake line reductor
		if (self.DriverValvePosition == 2) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"ReservoirPressure", self.TrainToBrakeReducedPressure*1.05, 1.30)

			self.BrakeLinePressure = self.ReservoirPressure
			self.BrakeLinePressure_dPdT = self.ReservoirPressure_dPdT
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 334: 3 Close all valves
		if (self.DriverValvePosition == 3) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"ReservoirPressure", self.BrakeLinePressure, 3.00)
			self:equalizePressure(dT,"BrakeLinePressure", self.ReservoirPressure, 3.00)
			
			-- Typical leak
			self:equalizePressure(dT,"ReservoirPressure", 0.00, 0.03)
		end
		
		-- 334: 4 Reservoir open to atmosphere, brake line equalizes with reservoir
		if (self.DriverValvePosition == 4) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"ReservoirPressure", 0.0,0.35 + 0.04*(Train:GetWagonCount() - 1))--0.35)-0.55
			self.BrakeLinePressure = self.ReservoirPressure
			self.BrakeLinePressure_dPdT = self.ReservoirPressure_dPdT
		end
		
		-- 334: 5 Reservoir and brake line open to atmosphere
		if (self.DriverValvePosition == 5) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"ReservoirPressure", 0.0, 1.00 + 0.175*(Train:GetWagonCount() - 1))--1.70
			self.BrakeLinePressure = self.ReservoirPressure
			self.BrakeLinePressure_dPdT = self.ReservoirPressure_dPdT
		end
	else
		local pr_speed = 3.00 + 1.375*(Train:GetWagonCount() - 1)
		-- 013: 1 Overcharge
		if (self.DriverValvePosition == 1) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", self.TrainLinePressure, pr_speed)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 013: 2 Normal pressure
		if (self.DriverValvePosition == 2) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(5.1,self.TrainToBrakeReducedPressure), pr_speed, nil, 8.0)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 013: 3 4.3 Atm
		if (self.DriverValvePosition == 3) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.3,self.TrainToBrakeReducedPressure), pr_speed, nil, 8.0)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 013: 4 4.0 Atm
		if (self.DriverValvePosition == 4) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(4.0,self.TrainToBrakeReducedPressure), pr_speed, nil, 8.0)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 013: 5 3.7 Atm
		if (self.DriverValvePosition == 5) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.7,self.TrainToBrakeReducedPressure), pr_speed, nil, 8.0)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
		
		-- 013: 6 3.0 Atm
		if (self.DriverValvePosition == 6) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 1.01*math.min(3.0,self.TrainToBrakeReducedPressure), pr_speed, nil, 8.0)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
			
		-- 013: 7 0.0 Atm
		if (self.DriverValvePosition == 7) and (Train.DriverValveDisconnect.Value == 1.0) then
			self:equalizePressure(dT,"BrakeLinePressure", 0.0, pr_speed)
			trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,self.BrakeLinePressure_dPdT)
		end
	end

	----------------------------------------------------------------------------
	-- Fill brake cylinders
	if Train.AirDistributorDisconnect.Value == 0 then
		local targetPressure = math.max(0,math.min(5.2,
			1.5*(math.min(5.1,self.TrainToBrakeReducedPressure) - self.BrakeLinePressure)))
		if math.abs(self.BrakeCylinderPressure - targetPressure) > 0.150 then
			self.BrakeCylinderValve = 1
		end
		if math.abs(self.BrakeCylinderPressure - targetPressure) < 0.025 then
			self.BrakeCylinderValve = 0
		end
		if self.BrakeCylinderValve == 1 then
			--if self.DriversValve == 1 then
				--self:equalizePressure(dT,"BrakeCylinderPressure", targetPressure, 2.00, 3.50, nil, 1.0) --0.75, 1.25)
			--else
				self:equalizePressure(dT,"BrakeCylinderPressure", targetPressure, 1.50, 6.50, nil, 1.0) --0.75, 1.25)
			--end
		end
		--if self.Train:EntIndex() == 3178 then print(math.abs(self.Train:GetAngles().pitch)) end
		-- Valve #1
		self.BrakeCylinderRegulationError = self.BrakeCylinderRegulationError or (math.random()*0.20 - 0.10)
		local error = self.BrakeCylinderRegulationError
		local pneumaticValveConsumption_dPdT = 0
		if (self.Train.PneumaticNo1.Value == 1.0) and (self.Train.PneumaticNo2.Value == 0.0) then
		--1,2
			local PN1 = math.min(self.TrainLinePressure,(1.4 + error)*(1.3 + math.min(1,math.abs(self.Train:GetAngles().pitch)/6.68*0.7)))
			self:equalizePressure(dT,"BrakeCylinderPressure", PN1, 1.00, 5.50)
			pneumaticValveConsumption_dPdT = pneumaticValveConsumption_dPdT + self.BrakeCylinderPressure_dPdT
		end
		-- Valve #2
		if self.Train.PneumaticNo2.Value == 1.0 then
			local PN2 = math.min(self.TrainLinePressure,(2.5 + error)*(1 + math.min(1,math.abs(self.Train:GetAngles().pitch)/6.68)))
			self:equalizePressure(dT,"BrakeCylinderPressure", PN2, 1.00, 5.50)
			--self:equalizePressure(dT,"BrakeCylinderPressure", self.TrainLinePressure * 0.39 + error, 1.00, 5.50)
			pneumaticValveConsumption_dPdT = pneumaticValveConsumption_dPdT + self.BrakeCylinderPressure_dPdT
		end
		trainLineConsumption_dPdT = trainLineConsumption_dPdT + math.max(0,pneumaticValveConsumption_dPdT)
	else
		self:equalizePressure(dT,"BrakeCylinderPressure", 0.0, 2.00)
	end

	if (self.BrakeLinePressure < 2.0 or self.UAVA) and self.EmergencyValve then
		self.EmergencyValve = false
	end
	if self.BrakeLinePressure < 3.0 and Train.UAVA and Train.UAVA.Value > 0.5 then
		self.UAVA = true
	end
	if Train.UAVA and Train.UAVA.Value < 0.5 then
		self.UAVA = false
	end
	-- Simulate cross-feed between different wagons
	self:UpdatePressures(Train,dT)
	
	
	----------------------------------------------------------------------------
	-- Simulate compressor operation and train line depletion
	self.Compressor = Train.KK.Value * ((not Train.Electric or Train.Electric.Power750V > 550) and 1 or 0)
	local Ratio = 29/420
	if Train.SubwayTrain.Type == "E" then Ratio = 38/420 end
	self.TrainLinePressure = self.TrainLinePressure - 0.07*trainLineConsumption_dPdT*dT -- 0.190 --0.170
	if self.Compressor == 1 then self:equalizePressure(dT,"TrainLinePressure", 10.0, 0.04) end
	self:equalizePressure(dT,"TrainLinePressure", 0,0.001)
	-- Overpressure
	if self.TrainLinePressure > 9.0 then self.TrainLineOverpressureValve = 1 end
	if self.TrainLineOverpressureValve == 1 then
		self:equalizePressure(dT,"TrainLinePressure", 0.0, 0.2)
		self.TrainLineOpen = true
		if self.TrainLinePressure < 5.2 then self.TrainLineOverpressureValve = 0 end
	end
	
	----------------------------------------------------------------------------
	-- Pressure triggered relays
	Train.AVT:TriggerInput("Open", self.BrakeCylinderPressure > 1.9) -- 1.8 - 2.0
	Train.AVT:TriggerInput("Close",self.BrakeCylinderPressure < 1.2) -- 0.9 - 1.5
	Train.AK:TriggerInput( "Open", self.TrainLinePressure > 8.2)
	Train.AK:TriggerInput( "Close",self.TrainLinePressure < 6.3)
	Train.AVU:TriggerInput("Open", self.BrakeLinePressure < 2.7) -- 2.7 - 2.9
	Train.AVU:TriggerInput("Close",self.BrakeLinePressure > 3.5) -- 3.5 - 3.7
	Train.BPT:TriggerInput("Set",  self.BrakeCylinderPressure > 0.4)
	Train.DKPT:TriggerInput("Set", self.BrakeCylinderPressure > 0.8) -- 1.8 - 2.0
	
	----------------------------------------------------------------------------
	-- Simulate doors opening, closing
	if self.DoorLinePressure > 3.5 then
		if (Train.VDOL.Value == 1.0) and (Train.VDOP.Value == 0.0) then
			if (self.LeftDoorState[1] == 0) or
			   (self.LeftDoorState[2] == 0) or
			   (self.LeftDoorState[3] == 0) or
			   (self.LeftDoorState[4] == 0) then
				self.PlayOpen = CurTime()
			end
			   
			self.LeftDoorState[1] = 1
			self.LeftDoorState[2] = 1
			self.LeftDoorState[3] = 1
			self.LeftDoorState[4] = 1
		end
		if (Train.VDOL.Value == 0.0) and (Train.VDOP.Value == 1.0) then
			if (self.RightDoorState[1] == 0) or
			   (self.RightDoorState[2] == 0) or
			   (self.RightDoorState[3] == 0) or
			   (self.RightDoorState[4] == 0) then
				self.PlayOpen = CurTime()
			end

			self.RightDoorState[1] = 1
			self.RightDoorState[2] = 1
			self.RightDoorState[3] = 1
			self.RightDoorState[4] = 1
		end
		if (Train.VDZ.Value == 1.0) or
		   ((Train.VDOL.Value == 1.0) and (Train.VDOP.Value == 1.0)) then
			if (self.LeftDoorState[1] == 1) or
			   (self.LeftDoorState[2] == 1) or
			   (self.LeftDoorState[3] == 1) or
			   (self.LeftDoorState[4] == 1) or
			   (self.RightDoorState[1] == 1) or
			   (self.RightDoorState[2] == 1) or
			   (self.RightDoorState[3] == 1) or
			   (self.RightDoorState[4] == 1) then
				self.PlayClose = CurTime()
			end
			
			self.LastCloseTrigger = self.LastCloseTrigger or CurTime()
			if (CurTime() - self.LastCloseTrigger) > 2.0 then
				self.LastCloseTrigger = CurTime()
				--self.CloseValue = nil
			end
			
			if self.CloseValue == nil then
				self.CloseValue = (math.random() > 0.005) --05)
				if self.CloseValue == false then print("DOOR FAIL",self.Train) end
				--print("DOOR DESTINY",self.CloseValue)
			end
			
			if self.CloseValue == true then
				self.LeftDoorState[1] = 0
				self.LeftDoorState[2] = 0
				self.LeftDoorState[3] = 0
				self.LeftDoorState[4] = 0
			
				self.RightDoorState[1] = 0
				self.RightDoorState[2] = 0
				self.RightDoorState[3] = 0
				self.RightDoorState[4] = 0
			end
		else
			self.CloseValue = nil
		end
	end
	Train.BD:TriggerInput("Set",
		(self.LeftDoorState[1] == 0) and
		(self.LeftDoorState[2] == 0) and
		(self.LeftDoorState[3] == 0) and
		(self.LeftDoorState[4] == 0) and
		(self.RightDoorState[1] == 0) and
		(self.RightDoorState[2] == 0) and
		(self.RightDoorState[3] == 0) and
		(self.RightDoorState[4] == 0))
		
	-- Play sounds
	local play_open 		= (CurTime() - (self.PlayOpen or 1e9)) > 0.3
	local play_close 		= (CurTime() - (self.PlayClose or 1e9)) > 0.3
	local play_open_early 	= (CurTime() - (self.PlayOpen or 1e9)) > 0.0
	local play_close_early 	= (CurTime() - (self.PlayClose or 1e9)) > 0.0
	if play_open_early and play_close_early then
		Train:PlayOnce("door_fail1")
		Train:PlayOnce("switch3")
		self.PlayOpen = 1e9
		self.PlayClose = 1e9
		play_open = false
		play_close = false
		self.TrainLinePressure = self.TrainLinePressure - 0.01
	end
 	if play_open then
		self.PlayOpen = 1e9
		Train:PlayOnce("door_open1")
		Train:PlayOnce("switch3")
		self.TrainLinePressure = self.TrainLinePressure - 0.04
	end
	if play_close then
		self.PlayClose = 1e9
		Train:PlayOnce("door_close1")
		self.TrainLinePressure = self.TrainLinePressure - 0.04
	end
	
	----------------------------------------------------------------------------
	if self.DriverValveDisconnectPrevious ~= Train.DriverValveDisconnect.Value then
		self.DriverValveDisconnectPrevious = Train.DriverValveDisconnect.Value
		if Train.DriverValveDisconnect.Value == 0 and self.ValveType == 2 then
			self.BrakeLinePressure = math.max(0.0,self.BrakeLinePressure - 3.0)
		end
	end
	

	----------------------------------------------------------------------------	
	-- FIXME
	Train:SetNWBool("FbI",Train.FrontBrakeLineIsolation.Value ~= 0)
	Train:SetNWBool("RbI",Train.RearBrakeLineIsolation.Value ~= 0)
	Train:SetNWBool("FtI",Train.FrontTrainLineIsolation.Value ~= 0)
	Train:SetNWBool("RtI",Train.RearTrainLineIsolation.Value ~= 0)
	Train:SetNWBool("AD",Train.AirDistributorDisconnect.Value == 0)
	

	local ValveType = self.ValveType > 1

	self.Timer = self.Timer or CurTime()
	if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition > self.RealDriverValvePosition)) then
		self.Timer = CurTime()
		self.RealDriverValvePosition = self.RealDriverValvePosition + 1		if not ValveType then
			self.Train:PlayOnce("br_334","cabin")
		else
			self.Train	:PlayOnce("br_013","cabin")
		end
	end
	if ((CurTime() - self.Timer > 0.10) and (self.DriverValvePosition < self.RealDriverValvePosition)) then
		self.Timer = CurTime()
		self.RealDriverValvePosition = self.RealDriverValvePosition - 1		if not ValveType then
			self.Train:PlayOnce("br_334","cabin")
		else
			self.Train:PlayOnce("br_013","cabin")
		end
	end
	if self.Train.LK1 then
		if self.TrainLinePressure < 3 and self.Train.LK1.Blocked < 1 then
			for i = 1,5 do
				--self.Train[Format("LK%d",i)]:TriggerInput("Open", 1)
				self.Train[LKNames[i]]:TriggerInput("Block", 1)
			end
			self.Train.RKR:TriggerInput("Block", 1)
		elseif self.TrainLinePressure > 3 and self.Train.LK1.Blocked > 0  then
			for i = 1,5 do
				self.Train[LKNames[i]]:TriggerInput("Block", 0)
			end
			self.Train.RKR:TriggerInput("Block", 0)
		end
	end
end