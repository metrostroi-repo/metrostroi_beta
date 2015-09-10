--------------------------------------------------------------------------------
-- Панели с реле и контакторами (ПР-143, ПР-144)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PR_14X_Panels")

function TRAIN_SYSTEM:Initialize()
	----------------------------------------------------------------------------
	-- ПР-143
	----------------------------------------------------------------------------
	-- Контактор включения провода 1 (Р1-Р5)
	self.Train:LoadSystem("R1_5","Relay","KPD-110E", { in_cabin_alt = true })
	-- Контактор 6-ого провода (К6)
	self.Train:LoadSystem("K6","Relay","KPD-110E", { in_cabin = true })
	-- Реле времени торможения (РВТ)
	self.Train:LoadSystem("RVT","Relay","REV-811T", { in_cabin_alt2	 = true, open_time = 0.3 })--(self.Train.Electric.TrainSolver:find("81-") and 0.3 or 0.7)
	-- Реле педали бдительности (РПБ)
	self.Train:LoadSystem("RPB","Relay","REV-813T", { in_cabin = true, open_time = 2.5, rpb = true })
	-- РВ-2
	self.Train:LoadSystem("RV_2","Relay","REV-813T")
	
	
	
	----------------------------------------------------------------------------
	-- ПР-144
	----------------------------------------------------------------------------
	-- Контактор 25ого провода (К25)
	self.Train:LoadSystem("K25","Relay","PR-143", { in_cabin = true })
	-- Реле-повторитель провода 8 (РП8)
	self.Train:LoadSystem("Rp8","Relay","REV-811T", { in_cabin = true })
	-- Контактор дверей (КД)
	self.Train:LoadSystem("KD","Relay","REV-811T", { in_cabin_alt3 = true })
	-- Реле освещения (РО)
	self.Train:LoadSystem("RO","Relay","KPD-110E", { in_cabin = true })	
end

function TRAIN_SYSTEM:Think()
	--print("K25",self.Train.K25.Value)
	--print("K6",self.Train.K6.Value)
	--print("RVT",self.Train.RVT.Value)
	if not self.Checked then
		if not self.Train.Electric.TrainSolver:find("81") then
			self.Train.RVT.open_time = 1
			FailSim.AddParameter(self.Train.RVT,"OpenTime", 		{ value = self.Train.RVT.open_time, precision = self.Train.RVT.contactor and 0.35 or 0.10, min = 0.010, varies = true })
		end
		self.Checked = true
	end
	self.Train.RPB:TriggerInput("Set",(self.Train.PB.Value + self.Train.KVT.Value + self.Train.RV_2.Value)*self.Train.VB.Value)
end