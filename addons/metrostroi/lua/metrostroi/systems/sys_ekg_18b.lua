--------------------------------------------------------------------------------
-- Груповой переключатель положений (ЕКГ-18Б)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("EKG_18B")

function TRAIN_SYSTEM:Initialize()
	-- Rheostat configuration
	self.Configuration = {
	--   ##      1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 
		[ 1] = { 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1 },-- PS
		[ 2] = { 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0 },-- PP
		[ 3] = { 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0 },-- PT1
		[ 4] = { 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0 },-- PT2 (not used)
	}
	self.WrapsAround = true
	Metrostroi.BaseSystems["EKG"].Initialize(self)
	
	-- Rate of rotation (positions per second
	self.RotationRate = 1.0/0.30
	
	-- Реле РПУ
	self.Train:LoadSystem("RPU","Relay","RPU-3",{normal_level = 2})
end

function TRAIN_SYSTEM:Inputs(...)
	return Metrostroi.BaseSystems["EKG"].Inputs(self,...)
end
function TRAIN_SYSTEM:Outputs(...)
	return Metrostroi.BaseSystems["EKG"].Outputs(self,...)
end
function TRAIN_SYSTEM:TriggerInput(...)
	return Metrostroi.BaseSystems["EKG"].TriggerInput(self,...)
end
function TRAIN_SYSTEM:Think(...)
	if self.OldSelectedPosition ~= self.SelectedPosition then
		self.Train:PlayOnce("pkg",nil,0.7)
		self.OldSelectedPosition =  self.SelectedPosition
	end
	return Metrostroi.BaseSystems["EKG"].Think(self,...)
end