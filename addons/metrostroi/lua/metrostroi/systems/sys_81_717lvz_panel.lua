--------------------------------------------------------------------------------
-- Панель управления 81-717 ЛВЗ
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_717LVZ_Panel")

function TRAIN_SYSTEM:Initialize()
	-- Выключатель батареи (ВБ)
	self.Train:LoadSystem("VB","Relay","Switch",{paketnik =true})

	-- Buttons on the panel
	self.Train:LoadSystem("DIPon","Relay","Switch", {button = true})
	self.Train:LoadSystem("DIPoff","Relay","Switch", {button = true})
	self.Train:LoadSystem("VozvratRP","Relay","Switch", {button = true})
	self.Train:LoadSystem("RezMK","Relay","Switch", {button = true})
	self.Train:LoadSystem("VMK","Relay","Switch", {switch = true})
	self.Train:LoadSystem("VAH","Relay","Switch", {switch = true})
	self.Train:LoadSystem("VAD","Relay","Switch", {switch = true})
	self.Train:LoadSystem("VUS","Relay","Switch", {switch = true})
	self.Train:LoadSystem("VUD1","Relay","Switch", { normally_closed = true, vud = true })
	self.Train:LoadSystem("VUD2","Relay","Switch", { normally_closed = true, vud = true }) -- Doors close
	self.Train:LoadSystem("VDL","Relay","Switch", {vud = true}) -- Doors left open
	self.Train:LoadSystem("KDL","Relay","Switch", {button = true})
	self.Train:LoadSystem("KDLR","Relay","Switch", {button = true})
	self.Train:LoadSystem("KDP","Relay","Switch", {button = true})
	self.Train:LoadSystem("KRZD","Relay","Switch", {button = true})
	self.Train:LoadSystem("KSN","Relay","Switch", {button = true})
	self.Train:LoadSystem("OtklAVU","Relay","Switch", {switch = true})
	self.Train:LoadSystem("OVT","Relay","Switch", {switch = true})
	self.Train:LoadSystem("OVTPl","Relay","Switch", {switch = true})
	self.Train:LoadSystem("ARS","Relay","Switch", {switch = true})
	self.Train:LoadSystem("ALS","Relay","Switch", {switch = true})
	self.Train:LoadSystem("KVT","Relay","Switch", {button = true})
	self.Train:LoadSystem("KB","Relay","Switch", {button = true})
	self.Train:LoadSystem("KRP","Relay","Switch", {button = true})
	
	self.Train:LoadSystem("R_UPO","Relay","Switch", {switch = true})
	self.Train:LoadSystem("R_G","Relay","Switch", {switch = true})
	self.Train:LoadSystem("R_Radio","Relay","Switch", {switch = true})
	self.Train:LoadSystem("RC1","Relay","Switch",{ paketnik = true,normally_closed = true })
	
	self.Train:LoadSystem("Radio13","Relay","Switch", {button = true})
	self.Train:LoadSystem("ARS13","Relay","Switch", {button = true})
	
	-- Педаль бдительности (ПБ)
	self.Train:LoadSystem("PB","Relay","Switch", {pb = true})
	
	-- Автоматические выключатели (АВ)
	self.Train:LoadSystem("A1","Relay","VA21-29")
	self.Train:LoadSystem("A2","Relay","VA21-29")
	self.Train:LoadSystem("A3","Relay","VA21-29")
	self.Train:LoadSystem("A5","Relay","VA21-29",{normally_closed = false})
	self.Train:LoadSystem("A6","Relay","VA21-29")
	self.Train:LoadSystem("A7","Relay","VA21-29")
	self.Train:LoadSystem("A8","Relay","VA21-29")
	self.Train:LoadSystem("A9","Relay","VA21-29")
	self.Train:LoadSystem("A10","Relay","VA21-29")
	self.Train:LoadSystem("A12","Relay","VA21-29")
	self.Train:LoadSystem("A13","Relay","VA21-29")
	self.Train:LoadSystem("A14","Relay","VA21-29")
	self.Train:LoadSystem("A16","Relay","VA21-29")
	self.Train:LoadSystem("A17","Relay","VA21-29")
	self.Train:LoadSystem("A20","Relay","VA21-29")
	self.Train:LoadSystem("A21","Relay","VA21-29")
	self.Train:LoadSystem("A22","Relay","VA21-29")
	self.Train:LoadSystem("A23","Relay","VA21-29")
	self.Train:LoadSystem("A24","Relay","VA21-29")
	self.Train:LoadSystem("A25","Relay","VA21-29")
	self.Train:LoadSystem("A27","Relay","VA21-29")
	self.Train:LoadSystem("A29","Relay","VA21-29")
	self.Train:LoadSystem("A30","Relay","VA21-29")
	self.Train:LoadSystem("A31","Relay","VA21-29")
	self.Train:LoadSystem("A32","Relay","VA21-29")
	self.Train:LoadSystem("A39","Relay","VA21-29")
	self.Train:LoadSystem("A41","Relay","VA21-29")
	self.Train:LoadSystem("A42","Relay","VA21-29")
	self.Train:LoadSystem("A43","Relay","VA21-29")
	self.Train:LoadSystem("A44","Relay","VA21-29")
	self.Train:LoadSystem("A45","Relay","VA21-29")
	self.Train:LoadSystem("A46","Relay","VA21-29")
	self.Train:LoadSystem("A47","Relay","VA21-29")
	self.Train:LoadSystem("A50","Relay","VA21-29")
	self.Train:LoadSystem("A51","Relay","VA21-29")
	self.Train:LoadSystem("A53","Relay","VA21-29")
	self.Train:LoadSystem("A54","Relay","VA21-29")
	self.Train:LoadSystem("A55","Relay","VA21-29")
	self.Train:LoadSystem("A56","Relay","VA21-29")
	self.Train:LoadSystem("A61","Relay","VA21-29")
	self.Train:LoadSystem("A62","Relay","VA21-29")
	self.Train:LoadSystem("A63","Relay","VA21-29")
	self.Train:LoadSystem("A64","Relay","VA21-29")
	self.Train:LoadSystem("A65","Relay","VA21-29")
	self.Train:LoadSystem("A75","Relay","VA21-29",{ normally_closed = false})
	self.Train:LoadSystem("A80","Relay","VA21-29")
	self.Train:LoadSystem("VU","Relay","VA21-29")
	self.Train:LoadSystem("KDLK","Relay","Switch", { krishka = true,normally_closed = true })
	self.Train:LoadSystem("KDLRK","Relay","Switch", { krishka = true,normally_closed = true })
	self.Train:LoadSystem("KDPK","Relay","Switch", { krishka = true,normally_closed = true })
	self.Train:LoadSystem("KAHK","Relay","Switch", { krishka = true,normally_closed = true })
	
	-- 81-717 special
	self.Train:LoadSystem("BPSNon","Relay","Switch", { switch = true })
	self.Train:LoadSystem("L_1","Relay","Switch",{switch = true})
	self.Train:LoadSystem("L_2","Relay","Switch",{switch = true})
	self.Train:LoadSystem("L_3","Relay","Switch",{switch = true})
	self.Train:LoadSystem("L_4","Relay","Switch",{switch = true})
	self.Train:LoadSystem("L_5","Relay","VA21-29")
	self.Train:LoadSystem("DoorSelect","Relay","Switch", { switch = true, normally_closed = false })
	self.Train:LoadSystem("VZ1","Relay","Switch", {button = true})
	
	self.Train:LoadSystem("Wiper","Relay","Switch")

	self.Train:LoadSystem("OhrSig","Relay","Switch", {switch = true})
	
	-- Map of AV switches to indexes on panel
	self:InitializeAVMap()
	
	self.CabinLight = 0
	self.HeadLights1 = 0
	self.HeadLights2 = 0
	self.HeadLights3 = 0
	self.RedLightLeft = 0
	self.RedLightRight = 0
	self.EmergencyLight = 0
	self.GreenRP = 0
	self.RedRP = 0
	self.KUP = 0
	self.V1 = 0
	self.AVU = 0
	self.Ring = 0
	self.SD = 0
	self.TrainBrakes = 0
	self.TrainRP = 0
	self.TrainDoors = 0
	self.OhrSig = 0
end

function TRAIN_SYSTEM:ClientInitialize()
	self:InitializeAVMap()
end

function TRAIN_SYSTEM:Outputs()
	return { "CabinLight", "HeadLights1", "HeadLights2", "HeadLights3",
			 "RedLightLeft", "RedLightRight", "EmergencyLight",
			 "GreenRP", "RedRP", "KUP", "V1", "AVU", "Ring", "SD",
			 "TrainBrakes", "TrainRP", "TrainDoors" }
end

function TRAIN_SYSTEM:InitializeAVMap()
	self.AVMap = {
		  61,55,54,56,27,21,10,53,43,45,42,41,
		"VU",64,63,50,51,23,14,75, 1, 2, 3,17,
		  62,29, 5, 6, 8,20,25,22,30,39,44,80,
		  65,"L_5",24,32,31,16,13,12, 7, 9,46,47
	}
end