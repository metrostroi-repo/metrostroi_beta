--------------------------------------------------------------------------------
-- Ящик с сопротивлениями (ЯС-44В)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YAS_44V")

function TRAIN_SYSTEM:Initialize()
	self.Resistors = {
		["P13-P33"]	= 51,
		["MK1-MK2"]	= 18.75,
		["P33-P42"]	= 300,
	}
	
	for k,v in pairs(self.Resistors) do
		self[k] = v
	end
end