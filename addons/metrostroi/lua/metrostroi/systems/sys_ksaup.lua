--------------------------------------------------------------------------------
-- КСАУП - Комплексная Система АвтоУправления поездом
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("KSAUP")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.TriggerNames = {
	}
	self.Triggers = {}
	self.Choose = 0
	self.Train:LoadSystem("R25p","Relay","KPD-110E", { in_cabin_alt4 = true })
end
function TRAIN_SYSTEM:ClientInitialize()
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	function TRAIN_SYSTEM:ClientThink()
	end
end

function TRAIN_SYSTEM:UpdateUPO()
	for k,v in pairs(self.Train.WagonList) do
		if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,v == self.Train) end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local Autodrive = Train.Autodrive
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
	if self.Timer and CurTime() - self.Timer > 0 then
		self.Timer = nil
		self.Choose = 0
	end
	--self.FirstStation = Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line] and Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line][self.ChoosedFStation or 1] or 0
	--self.LastStation = Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line] and Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line][self.ChoosedLStation or 1] or 0

	if self.Train.VZD.Value > 0 and not self.VZD then
		self.Train.ADoorDisable:TriggerInput("Set",0)
		Autodrive.OnStation = false
		Autodrive.AutodriveReset = false
		Autodrive.AutodriveEnabled = false
		self.VZD = true
	end
	if self.Train.VZD.Value == 0 and self.VZD then
		self.VZD = false
	end
	
	if Autodrive.AutodriveReset then
		self.Train:TriggerInput("KVControllerAutodriveSet",0)
		Autodrive.NoAcceleration = nil
		Train:WriteCell(8,0)
		Train:WriteCell(29,0)
		Autodrive.AutodriveEnabled = false
		Autodrive.OnStation = false
		Autodrive.AutodriveReset = false
		Autodrive.KVPos = 0
	end
	local AVDisable = (Train.VAutodrive.Value < 0.5 or Train.VBA.Value < 0.5 or Train.RC2.Value < 0.5 or Train.VU.Value < 0.5 or Train.Panel["SD"] < 0.5)
	if Train.VAutodrive.Value > 0.5 and not Autodrive.AutodriveEnabled and not Autodrive.AutodriveReset and not AVDisable then
		Autodrive:Enable()
	elseif Autodrive.AutodriveEnabled and AVDisable then
		Autodrive:Disable()
	end
	if Autodrive.AutodriveEnabled then
		Autodrive:BoardAutodrive()
	end
		--end
	if Autodrive.RealControllerPosition ~= self.Train.KV.RealControllerPosition then
		local dX = self.Train.UPO.Distance
		--RunConsoleCommand("say",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5))
		--file.Append("puav.txt",Format("%d\t%s\t%d\t%s\t%d\n",self.Train.KV.RealControllerPosition,dX,self.Train.UPO.Station,(Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) and Metrostroi.TrainPositions[self.Train][1].path.id or "unk",math.floor(self.Train.RheostatController.Position+0.5)))
		Autodrive.RealControllerPosition = self.Train.KV.RealControllerPosition
	end
	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 then
		self.Time = CurTime()
		Train:SetPackedBool("KSAUP:Work",Autodrive.AutodriveEnabled and Train.Panel["V1"] > 0)
		Train:SetPackedBool("KSAUP:AutodriveEngage",Autodrive.KVPos and Autodrive.KVPos ~= 0 and Train.Panel["V1"] > 0)
	end
end
