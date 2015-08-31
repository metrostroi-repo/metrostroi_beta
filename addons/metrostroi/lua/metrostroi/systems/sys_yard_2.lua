--------------------------------------------------------------------------------
-- Ящик с аппаратурой (ЯРД-2)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("YARD_2")

function TRAIN_SYSTEM:Initialize()
	-- Контактор диффиренциальной защиты (ДР1, ДР2)
	self.Train:LoadSystem("DR1","Relay","KMG13_19", { trigger_level = 120 })
	self.Train:LoadSystem("DR2","Relay","KMG13_19", { trigger_level = 120 })
	
	-- Номинальное значение срабатывания
	self.DeltaCurrent = 120 -- A
end

function TRAIN_SYSTEM:Think()
	local Train = self.Train
	
	--print("D",Train.Electric.I13,Train.Electric.I13 - Train.Electric.I24)
	--Train.DR1:TriggerInput("Set",Train.Electric.I13 - Train.Electric.I24)
	--Train.DR2:TriggerInput("Set",Train.Electric.I24 - Train.Electric.I13)
	--Train.RPL:TriggerInput("Set",Train.Electric.I13)
end
