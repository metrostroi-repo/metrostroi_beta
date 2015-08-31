--------------------------------------------------------------------------------
-- Generic relay with configureable parameters
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Relay")

local relay_types = {
	["PK-162"] = {
		pneumatic		= true,
		contactor		= true,
	},
	["Switch"] = {
		contactor		= true,
	},
	["GV_10ZH"] = {
		contactor		= true,
		normally_closed	= true,
	},
	["VA21-29"] = {
		contactor		= true,
		normally_closed	= true,	
	},
	["AVU-045"] = {
		in_cabin_avu	= true,
	},
}

function TRAIN_SYSTEM:Initialize(parameters,extra_parameters)
	----------------------------------------------------------------------------
	-- Initialize parameters
	if not parameters then parameters = {} end
	if type(parameters) ~= "table" then
		relay_type = parameters
		if relay_types[relay_type] then
			parameters = relay_types[relay_type]
		else
			--print("[sys_relay.lua] Unknown relay type: "..parameters)
			parameters = {}
		end
		parameters.relay_type = relay_type
	end
	
	-- Create new table
	local old_param = parameters
	parameters = {} for k,v in pairs(old_param) do parameters[k] = v end
	
	-- Add extra parameters
	if type(extra_parameters) == "table" then
		for k,v in pairs(extra_parameters) do
			parameters[k] = v
		end
	end	
	
	-- Contactors have different failure modes
	parameters.contactor		= parameters.contactor or false
	-- Should the relay be initialized in 'closed' state
	parameters.normally_closed 	= parameters.normally_closed or false
	-- Time in which relay will close (seconds)
	parameters.close_time 		= parameters.close_time or 0.050
	-- Time in which relay will open (seconds)
	parameters.open_time 		= parameters.open_time or 0.050
	-- Is relay latched (stays in its position even without voltage)
	parameters.latched			= parameters.latched or false
	-- Should relay be spring-returned to initial position
	parameters.returns			= parameters.returns or (not parameters.latched)
	-- Trigger level for the relay
	parameters.trigger_level	= parameters.trigger_level or 0.5
	for k,v in pairs(parameters) do
		self[k] = v
	end



	----------------------------------------------------------------------------
	-- Relay parameters
	FailSim.AddParameter(self,"CloseTime", 		{ value = parameters.close_time, precision = self.contactor and 0.35 or 0.10, min = 0.010, varies = true })
	FailSim.AddParameter(self,"OpenTime", 		{ value = parameters.open_time, precision = self.contactor and 0.35 or 0.10, min = 0.010, varies = true })
	-- Did relay short-circuit?
	FailSim.AddParameter(self,"ShortCircuit",	{ value = 0.000, precision = 0.00 })
	-- Was there a spurious trip?
	FailSim.AddParameter(self,"SpuriousTrip",	{ value = 0.000, precision = 0.00 })

	-- Calculate failure parameters
	local MTBF = parameters.MTBF or 1000000 -- cycles, mean time between failures
	local MFR = 1/MTBF   -- cycles^-1, total failure rate
	local openWeight,closeWeight	
	-- FIXME
	openWeight = 0.25
	closeWeight = 0.25
	--[[if self.Contactor then
		openWeight = 0.25
		closeWeight = 0.25
	elseif self.NormallyOpen then
		openWeight = 0.4
		closeWeight = 0.1
	else
		openWeight = 0.1
		closeWeight = 0.4
	end]]--

	-- Add failure points
	FailSim.AddFailurePoint(self,	"CloseTime", "Mechanical problem (close time not nominal)", 
		{ type = "precision", 	value = 0.5,	mfr = MFR*0.65*openWeight, recurring = true } )
	FailSim.AddFailurePoint(self,	"OpenTime", "Mechanical problem (open time not nominal)", 
		{ type = "precision", 	value = 0.5,	mfr = MFR*0.65*closeWeight , recurring = true } )
	FailSim.AddFailurePoint(self,	"CloseTime", "Stuck closed",
		{ type = "value", 		value = 1e9,	mfr = MFR*0.65*openWeight, dmtbf = 0.2 } )
	FailSim.AddFailurePoint(self,	"OpenTime", "Stuck open",
		{ type = "value", 		value = 1e9,	mfr = MFR*0.65*closeWeight , dmtbf = 0.4 } )
	FailSim.AddFailurePoint(self,	"SpuriousTrip", "Spurious trip",
		{ type = "on",							mfr = MFR*0.20, dmtbf = 0.4 } )
	--FailSim.AddFailurePoint(self,	"ShortCircuit", "Short-circuit",
		--{ type = "on",							mfr = MFR*0.15, dmtbf = 0.2 } )



	----------------------------------------------------------------------------
	-- Initial relay state
	if self.normally_closed then
		self.TargetValue = 1.0
		self.Value = 1.0
	else
		self.TargetValue = self.defaultvalue or 0.0
		self.Value = self.defaultvalue or 0.0
	end
	-- Time when relay should change its value
	self.Time = 0
	self.ChangeTime = nil
	self.Blocked = 0
	
	-- This increases precision at cost of perfomance
	self.SubIterations = 2
end

function TRAIN_SYSTEM:Inputs()
	return { "Open","Close","Set","Toggle","Block","OpenBypass","Check"}
end

function TRAIN_SYSTEM:Outputs()
	return { "Value" , "Blocked","TargetValue"}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	-- Boolean values accepted
	if type(value) == "boolean" then value = value and 1 or 0 end
		--print(name)
	if name == "Check" then
		if not value then print(self.Name) end
		if value < 0 and self.Value == 1 then
			self:TriggerInput("Set",0)
			--self:TriggerInput("Set",0)
			self.Train:PlayOnce("av_off","cabin",0.7,70)
		end
		return
	end
	if value == -1 and self.relay_type == "VA21-29" then
		self:TriggerInput("Set",0)
		return
	end
	if name == "OpenBypass" then
		if (not self.ChangeTime) and (self.TargetValue ~= 0.0) then
			self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
		end
		self.TargetValue = 0.0
		return
	end
		
	if self.Blocked > 0 and name ~= "Block" and (name == "Close" or self.rkr) then return end
	
	-- Open/close coils of the relay
	if (name == "Block") then
		self.Blocked = value
	elseif (name == "Close") and (value > self.trigger_level) and (self.Value ~= 1.0 or self.TargetValue ~= 1.0) then --(self.TargetValue ~= 1.0 and self.rpb))
		if (not self.ChangeTime) and (self.TargetValue ~= 1.0) then
			self.ChangeTime = self.Time + FailSim.Value(self,"CloseTime")
		end
		--if self.rpb and 
		if self.Value == 1.0 then self.ChangeTime = nil end
		self.TargetValue = 1.0
	elseif (name == "Open") and (value > self.trigger_level) and (self.Value ~= 0.0) then
		if (not self.ChangeTime) and (self.TargetValue ~= 0.0) then
			self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
		end
		self.TargetValue = 0.0
	elseif name == "Set" then
		if self.maxvalue then
			if not self.ChangeTime then
				self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
			end
			self.TargetValue = math.max(0.0,math.min(self.maxvalue,math.floor(value)))
		elseif self.three_position then
			if not self.ChangeTime then
				self.ChangeTime = self.Time + FailSim.Value(self,"OpenTime")
			end
			self.TargetValue = math.max(0.0,math.min(2.0,math.floor(value)))
		else
			if value > self.trigger_level
			then self:TriggerInput("Close",self.trigger_level+1)
			else self:TriggerInput("Open",self.trigger_level+1)
			end
		end
	elseif (name == "Toggle") and (value > 0.5) then
		if self.maxvalue then
			self:TriggerInput("Set",self.Value > self.maxvalue-1 and 0 or self.Value+1)
		elseif self.three_position then
			self:TriggerInput("Set",self.Value > 1 and 0 or self.Value+1)
		else
			self:TriggerInput("Set",(1.0 - self.Value)*(self.trigger_level+1))
		end
	end
end

function TRAIN_SYSTEM:Think(dT)
	--print(self.relay_type)
	self.Time = self.Time + dT
	--if self.relay_type == "VA21-29" then
		--if self.Value
	--if self.Value == -1 then print(self.Name) end
	-- Short-circuited relay
	if FailSim.Value(self,"ShortCircuit") > 0.5 then
		self.Value = 1.0
		return
	end
	-- Spurious trip
	if FailSim.Value(self,"SpuriousTrip") > 0.5 then
		self.SpuriousTripTimer = self.Time + (0.5 + 2.5*math.random())
		FailSim.ResetParameter(self,"SpuriousTrip",0.0)
		FailSim.Age(self,1)
		
		-- Simulate switch right away
		self.Value = 1.0 - self.Value
		self.TargetValue = self.Value
		self.ChangeTime = nil
	end
	if self.SpuriousTripTimer and (self.Time > self.SpuriousTripTimer) then
		self.Value = self.TargetValue
		self.SpuriousTripTimer = nil
	end
	-- Switch relay
	if self.ChangeTime and (self.Time > self.ChangeTime) and not self.SpuriousTripTimer then
		self.Value = self.TargetValue
		self.ChangeTime = nil

		-- Age relay a little
		FailSim.Age(self,1)

		-- Electropneumatic relays make this sound
		if self.pneumatic and (self.Value == 0.0) then		self.Train:PlayOnce("pneumo_switch",nil,0.6)		end
		if self.pneumatic and (self.Value == 1.0) then		self.Train:PlayOnce("pneumo_switch_on",nil,0.57)	end
		if self.rkr then									self.Train:PlayOnce("pneumo_reverser",nil,0.9)		end
		if self.in_cabin and (self.Value == 0.0) then		self.Train:PlayOnce("relay_open","cabin",0.6)		end
		if self.in_cabin and (self.Value == 1.0) then		self.Train:PlayOnce("relay_close","cabin",0.6)		end
		if self.in_cabin_alt and (self.Value == 0.0) then	self.Train:PlayOnce("relay_open","cabin",0.6)		end
		if self.in_cabin_alt and (self.Value == 1.0) then	self.Train:PlayOnce("relay_close2","cabin",0.6)		end
		if self.in_cabin_alt2 and (self.Value == 0.0) then	self.Train:PlayOnce("relay_open","cabin",0.6)		end
		if self.in_cabin_alt2 and (self.Value == 1.0) then	self.Train:PlayOnce("relay_close3","cabin",0.6)		end
		if self.in_cabin_alt2 and (self.Value == 0.0) then	self.Train:PlayOnce("relay_open","cabin",0.6)		end
		if self.in_cabin_alt3 and (self.Value == 1.0) then	self.Train:PlayOnce("relay_close4","cabin",0.6)		end
		if self.in_cabin_avu and (self.Value == 0.0) then	self.Train:PlayOnce("relay_open","cabin",0.7,70)	end
		if self.in_cabin_avu and (self.Value == 1.0) then	self.Train:PlayOnce("relay_close","cabin",0.7,70)	end
	end
end
