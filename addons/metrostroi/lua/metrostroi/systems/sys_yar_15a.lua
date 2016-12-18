--------------------------------------------------------------------------------
-- Ящик с реле (ЯР-13A)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAR_15A")

function TRAIN_SYSTEM:Initialize()
	-- Реле перегрузки (РПЛ)
	self.Train:LoadSystem("RPL","Relay","RM3001", { trigger_level = 1300 })
	-- Групповое реле перегрузки 1-3 (РП1-3)
	self.Train:LoadSystem("RP1_3","Relay","RM3001",{ trigger_level = 760 }) --630 })
	-- Групповое реле перегрузки 2-4 (РП2-4)
	self.Train:LoadSystem("RP2_4","Relay","RM3001",{ trigger_level = 760 }) --630 })
	
	-- Нулевое реле (НР)
	--   Does not use any power source defined, as the operation is calculated from bus voltage
	self.Train:LoadSystem("NR","Relay","R3150", { power_source = "None" })
	-- Реле системы управления
	self.Train:LoadSystem("RSU","Relay","R3100")
	
	-- Реле заземления (РЗ-1, РЗ-2, РЗ-3)
	self.Train:LoadSystem("RZ_1","Relay","RM3001")
	self.Train:LoadSystem("RZ_2","Relay","RM3001")
	self.Train:LoadSystem("RZ_3","Relay","RM3001")
	-- Возврат реле перегрузки (РПвозврат)
	self.Train:LoadSystem("RPvozvrat","Relay","RM3001",{
		latched = true, 			-- RPvozvrat latches into place
		power_open = "None",		-- Power source for the open signal
		power_close = "Mechanical",	-- Power source for the close signal
	})
	
	-- Реле времени РВ1
	self.Train:LoadSystem("RV1","Relay","RM3100",{ open_time = 0.9 })
	-- Реле времени РВ2 (задерживает отключение ЛК2)
	self.Train:LoadSystem("RV2","Relay","RM3100",{ open_time = 0.9 })
	
	-- Реле ручного тормоза (РРТ)
	self.Train:LoadSystem("RRT","Relay")
	-- Реле резервного пуска (РРП)
	self.Train:LoadSystem("RRP","Relay")
	-- Стоп-реле (СР1)
	self.Train:LoadSystem("SR1","Relay","RM3000")
	-- Реле контроля реверсоров
	self.Train:LoadSystem("RKR","Relay","RM3000",{ rkr = true })
	-- Реле ускорения, торможения (РУТ)
	self.Train:LoadSystem("RUT","Relay","R-52B")
	

	-- Only in Ezh
	-- Реле перехода (Рпер)
	self.Train:LoadSystem("Rper","Relay")
	self.Train:LoadSystem("RUP","Relay")
	
	-- Extra coils for some relays
	self.Train.RUTpod = 0
	self.Train.RRTuderzh = 0
	self.Train.RRTpod = 0
	self.WeightLoadRatio = 0
	self.Slope = 0
	
	-- Need many iterations for engine simulation to converge
	self.SubIterations = 16
end

function TRAIN_SYSTEM:Inputs()
	return { "WeightLoadRatio", "Slope" }
end
function TRAIN_SYSTEM:Outputs()
	return { "Slope" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "WeightLoadRatio" then
		self.WeightLoadRatio = value
	end
	if name == "Slope" then
		self.Slope = value
	end
end

function TRAIN_SYSTEM:Think()
	local Train = self.Train
	-- Zero relay operation
	Train.NR:TriggerInput("Close",Train.Electric.Aux750V > 360) -- 360 - 380 V 
	Train.NR:TriggerInput("Open", Train.Electric.Aux750V < 150) -- 120 - 190 V
	local del = 1
	if self.Slope then
		del = 2
	end
	-- Overload relays operation
	Train.RP1_3:TriggerInput("Set",math.abs(Train.Electric.I13/del))
	Train.RP2_4:TriggerInput("Set",math.abs(Train.Electric.I24/del))
	--Train.RPL:TriggerInput("Set",Train.Electric.Itotal)
	if Train.RP1_3.Value > 0 or Train.RP2_4.Value > 0 then print(Train.RP1_3.Value,Train.Electric.I13/del,Train.RP2_4.Value,Train.Electric.I24/del,math.floor(Train.PositionSwitch.Position + 0.5) , math.floor(Train.RheostatController.Position + 0.5),del) end
	-- RUT operation
	self.RUTCurrent = (math.abs(Train.Electric.I13) + math.abs(Train.Electric.I24))/2
	self.RUTTarget = 210 + 150*self.WeightLoadRatio
	
	if Train.RUTpod > 0.5 
	then Train.RUT:TriggerInput("Close",1.0)
	else Train.RUT:TriggerInput("Set",self.RUTCurrent > self.RUTTarget)
	end
	
	-- RRT operation
	Train.RRT:TriggerInput("Close",(Train.RRT.Value == 0.0) and (Train.RRTpod > 0.5) and (Train.RRTuderzh > 0.5))
	Train.RRT:TriggerInput("Open",(Train.RRTuderzh < 0.5))

	-- RPvozvrat operation
	Train.RPvozvrat:TriggerInput("Close",
		(Train.DR1.Value == 1.0) or
		(Train.DR2.Value == 1.0) or
		(Train.RPL.Value == 1.0) or
		(Train.RP1_3.Value == 1.0) or
		(Train.RP2_4.Value == 1.0) or
		(Train.RZ_1.Value == 1.0) or
		(Train.RZ_2.Value == 1.0) or
		(Train.RZ_3.Value == 1.0))
--[[
	if Train.RPvozvrat.Value == 1 then
		self.RPLReady = true
	elseif self.RPLReady == true then
		if math.random() > 0.9 then
			Train.A17:TriggerInput("OpenBypass",1)
			Train:PlayOnce("av_off","cabin")
			self.RPLReady = false
		else
			self.RPLReady = nil
		end
	end
	
	if self.RPLReady == false and Train.RPvozvrat.Value < 0.5 then
		Train.RPvozvrat:TriggerInput("Set",1)
	end
	]]
end
