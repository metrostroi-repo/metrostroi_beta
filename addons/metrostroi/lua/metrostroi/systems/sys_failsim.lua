--------------------------------------------------------------------------------
-- Failure simulator interface
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("FailSim")
TRAIN_SYSTEM.RunEverywhere = true

function TRAIN_SYSTEM:Initialize()

end

function TRAIN_SYSTEM:Outputs()
	return {"TrainWireFail"}
end

function TRAIN_SYSTEM:Inputs()
	return { "Status", "Fail", "Reset", "TrainWires","ResetTW" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Status" then
		if TURBOSTROI then FailSim.Report(nil,"failures") end
	elseif name == "Reset" then
		if TURBOSTROI then FailSim.Reset() end
	elseif name == "Fail" then
		if TURBOSTROI then 
			if math.random() > 0.95 then
				local TW = math.floor(math.random(1,self.TrainWires))
				print("Generated random train line failure:")
				print("[!FAIL!] Outside power in train wire "..TW)
				self.TrainWireFail = TW
			else FailSim.RandomFailure() end
		end
	elseif name == "TrainWires" then
		self.TrainWires = value
	elseif name == "ResetTW" then
		self.TrainWireFail = 0
	end
end