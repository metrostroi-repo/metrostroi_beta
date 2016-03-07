--------------------------------------------------------------------------------
-- АРС-АЛС
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("NoARS")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	--self.Train:LoadSystem("UOS","Relay","Switch", {paketnik = true})
	--self.Train:LoadSystem("BPS","Relay","Switch",{ paketnik = true,normally_closed = true })
	-- ALS state
	self.Signal80 = false
	self.Signal70 = false
	self.Signal60 = false
	self.Signal40 = false
	self.Signal0 = false
	self.Special = false
	self.NoFreq = true
	self.RealNoFreq = true

	-- Internal state
	self.Speed = 0
	self.SpeedLimit = 0
	self.NextLimit = 0
	self.Ring = false
	self.Overspeed = false

	-- ARS wires
	self["33D"] = 1
	self["33G"] = 0                
	self["33Zh"] = 1--KAH
	--
	self["2"] = 0
	self["20"] = 0
	self["29"] = 0
	--
	self["31"] = 0
	self["32"] = 0
	self["8"] =0

	-- Lamps
	---self.LKT = false
	self.LVD = false
end

function TRAIN_SYSTEM:Outputs()
	return { "2", "8", "20", "31", "32", "29", "33D", "33G", "33Zh",
			 "Speed", "Signal80","Signal70","Signal60","Signal40","Signal0","Special","NoFreq","RealNoFreq",
			 "SpeedLimit", "NextLimit","Ring","KVT","EnableARS","EnableALS","Signal", "UAVA"}
end

function TRAIN_SYSTEM:Inputs()
	return { "IgnoreThisARS","AttentionPedal","Ring" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
