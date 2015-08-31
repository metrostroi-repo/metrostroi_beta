--------------------------------------------------------------------------------
-- Ящик с линейными контакторами (ЛК-755А)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("LK_755A")

function TRAIN_SYSTEM:Initialize()
	-- Линейный контактор (ЛК1)
	self.Train:LoadSystem("LK1","Relay","PK-162")
	-- Линейный контактор (ЛК2)
	self.Train:LoadSystem("LK2","Relay","PK-162")
	-- Линейный контактор (ЛК3)
	self.Train:LoadSystem("LK3","Relay","PK-162")
	-- Линейный контактор (ЛК4)
	self.Train:LoadSystem("LK4","Relay","PK-162")
	-- Линейный контактор (ЛК5)
	self.Train:LoadSystem("LK5","Relay","PK-162")
end