ENT.Type            = "anim"
ENT.Base            = "gmod_subway_base"

ENT.PrintName       = "81-717_test"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi (trains)"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:PassengerCapacity()
	return 300
end

function ENT:GetStandingArea()
	return Vector(-450,-30,-45),Vector(380,30,-45)
end

function ENT:InitializeSystems()
	-- Электросистема 81-705
	self:LoadSystem("Electric","81_717_Electric")
	
	-- Токоприёмник
	self:LoadSystem("TR","TR_3B")	
	-- Электротяговые двигатели
	self:LoadSystem("Engines","DK_117DM")	

	-- Резисторы для реостата/пусковых сопротивлений
	self:LoadSystem("KF_47A")
	-- Резисторы для ослабления возбуждения
	self:LoadSystem("KF_50A")
	-- Ящик с предохранителями
	self:LoadSystem("YAP_57")
	
	-- Резисторы для цепей управления
	--self:LoadSystem("YAS_44V")
	-- Реостатный контроллер для управления пусковыми сопротивления
	self:LoadSystem("RheostatController","EKG_17B")
	-- Групповой переключатель положений
	self:LoadSystem("PositionSwitch","EKG_18B")
	-- Кулачковый контроллер
	self:LoadSystem("KV","KV_70")
	-- Контроллер резервного управления
	self:LoadSystem("KRU")

	
	-- Ящики с реле и контакторами
	self:LoadSystem("LK_755A")
	self:LoadSystem("YAR_13A")
	self:LoadSystem("YAR_27")
	self:LoadSystem("YAK_36")
	self:LoadSystem("YAK_37E")
	self:LoadSystem("YAS_44V")
	self:LoadSystem("YARD_2")
	self:LoadSystem("PR_14X_Panels")	

	-- Пневмосистема 81-705
	self:LoadSystem("Pneumatic","81_717_Pneumatic")
	-- Панель управления 81-705
	self:LoadSystem("Panel","81_705_Panel")
	-- Everything else
	self:LoadSystem("Battery")
	self:LoadSystem("PowerSupply","BPSN")
	self:LoadSystem("DURA")
	self:LoadSystem("ALS_ARS")
	self:LoadSystem("PA-KSD")
	self:LoadSystem("Horn")
	self:LoadSystem("Announcer")
	
	
	-- Extra switches not on Ezh3
	self:LoadSystem("L_1","Relay","Switch", { normally_closed = true })
	self:LoadSystem("L_2","Relay","Switch", { normally_closed = true })
	self:LoadSystem("L_3","Relay","Switch", { normally_closed = true })
	self:LoadSystem("L_4","Relay","Switch", { normally_closed = true })
	self:LoadSystem("L_5","Relay","Switch", { normally_closed = true })
	self:LoadSystem("DoorSelect","Relay","Switch", { normally_closed = false })
	self:LoadSystem("VZ1","Relay","Switch")
	self:LoadSystem("KAH","Relay","Switch")
	
	self:LoadSystem("Custom1","Relay","Switch")
	self:LoadSystem("Custom2","Relay","Switch")
	self:LoadSystem("Custom3","Relay","Switch")
	self:LoadSystem("Custom4","Relay","Switch")
	self:LoadSystem("Custom5","Relay","Switch")
	self:LoadSystem("Custom6","Relay","Switch")
	self:LoadSystem("Custom7","Relay","Switch")
	self:LoadSystem("Custom8","Relay","Switch")
	
	self:LoadSystem("CustomA","Relay","Switch")
	self:LoadSystem("CustomB","Relay","Switch")
	self:LoadSystem("CustomC","Relay","Switch")
	self:LoadSystem("CustomD","Relay","Switch")
	self:LoadSystem("CustomE","Relay","Switch")
	self:LoadSystem("CustomF","Relay","Switch")
	self:LoadSystem("CustomG","Relay","Switch")
	
	self:LoadSystem("Autodrive","Relay","Switch")
	
	self:LoadSystem("Wiper","Relay","Switch")
	

end