--------------------------------------------------------------------------------
-- Train horn
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Horn")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Active = false
end

function TRAIN_SYSTEM:Outputs() --"21", 
	return { "Active" }
end

function TRAIN_SYSTEM:Inputs()
	return { "Engage","NewType" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if name == "Engage" then
		self.Active = value > 0.5
		self.Train:SetNWBool("HornState",self.Active)
	end
	if name == "NewType" then
		self.NewHorn = value > 0.5
		print(self.NewHorn)
		self.Train:SetNWBool("HornType",self.NewHorn)
	end
end

function TRAIN_SYSTEM:Think()
	self.Train:SetNWBool("HornType",self.NewHorn)
end

function TRAIN_SYSTEM:ClientThink(dT)
	local active = self.Train:GetNWBool("HornState",false)
	self.Active = self.Active or false

	-- Calculate pitch
	local absolutePitch  = 1 - math.exp(-10*self.Train:GetPackedRatio(5))
	local absoluteVolume = 1 - math.exp(-4*self.Train:GetPackedRatio(5))

	-- Play horn sound
	self.Train:SetSoundState(self.Train:GetNWBool("HornType",false) and "horn3" or "horn2",self.Active and absoluteVolume or 0,absolutePitch,nil,1.09)
	if (self.Active ~= active) and (not active) then
		if absolutePitch > 0.2 then
			self.Train:PlayOnce(self.Train:GetNWBool("HornType",false) and "horn3_end" or "horn2_end","cabin",1.09,101.5*absolutePitch) --0.85
		end
	end
	if (self.Active ~= active) and (active) then
		self.Train.Transient = -5.0
	end
	self.Active = active
end