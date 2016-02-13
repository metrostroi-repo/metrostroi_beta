--------------------------------------------------------------------------------
-- Токоприёмник контактного рельса (ТР-3Б)
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("TR_3B")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	-- Output voltage from contact rail
	self.Main750V = 0.0
	self.DropByPeople = 0
	self.Ignores = {}
end

function TRAIN_SYSTEM:Inputs()
	return { }
end

function TRAIN_SYSTEM:Outputs()
	return { "Main750V", "DropByPeople"}
end


function TRAIN_SYSTEM:CheckContact(ent,pos,dir,id)
	local trace = {
		start = ent:LocalToWorld(pos),
		endpos = ent:LocalToWorld(pos + dir*10),
		mask = -1,
		filter = { self.Train, ent },
	}
	local result = util.TraceLine(trace)
	if IsValid(result.Entity) and (self.Main750V > 40) and result.Entity:GetClass() ~= "gmod_track_udochka" then
		local pos = result.Entity:GetPos()
		self.VoltageDropByTouch = (self.VoltageDropByTouch or 0) + 1
		util.BlastDamage(result.Entity,result.Entity,pos,64,3.0*self.Main750V)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(pos + Vector(0,0,-16+math.random()*(40+0)))
		util.Effect("cball_explode",effectdata,true,true)
		sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",pos,75,math.random(100,150),1.0)
	elseif IsValid(result.Entity) and result.Entity:GetClass() == "gmod_track_udochka" then
		local IsFront = ent == self.Train.FrontBogey
		local bogey = IsFront and self.Train.FrontBogey or self.Train.RearBogey
		--[[
		local constrainttable = constraint.FindConstraints(ent,"Weld")
		local coupled = false
		for k,v in pairs(constrainttable) do
			if v.Type == "Weld" then 
				if( (v.Ent1 == ent or v.Ent1 == result.Entity) and (v.Ent2 == ent or v.Ent2 == result.Entity)) then
					coupled = true
				end
			end
		end
		]]
		if not result.Entity.Timer and result.Entity.CoupledWith ~= bogey and IsValid(constraint.Weld(
			ent,
			result.Entity,
			0, --bone
			0, --bone
			0, --forcelimit
			true, --nocollide
			false --nocollide
		)) then
			constraint.ForgetConstraints( ent )
			result.Entity.Coupled = ent
			sound.Play("buttons/lever2.wav",(ent:GetPos()+result.Entity:GetPos())/2)
		end
		return result.Entity.Power,true
	end
	return result.Hit
end

function TRAIN_SYSTEM:Think(dT)
	-- Don't do logic if train is broken
	if (not IsValid(self.Train.FrontBogey)) or (not IsValid(self.Train.RearBogey)) then
		return
	end

	-- Draw overheat of the engines FIXME
	local smoke_intensity = 
		self.Train.Electric.Overheat1 or
		self.Train.Electric.Overheat2 or 0

	-- Generate smoke
	self.PrevSmokeTime = self.PrevSmokeTime or CurTime()
	if (smoke_intensity > 0.0) and (CurTime() - self.PrevSmokeTime > 0.5+4.0*(1-smoke_intensity)) then
		self.PrevSmokeTime = CurTime()

		ParticleEffect("generic_smoke",
			self.Train:LocalToWorld(Vector(100*math.random(),40,-80)),
			Angle(0,0,0),self.Train)
	end

	-- Check contact states
	self.PlayTime = self.PlayTime or { 0, 0, 0, 0 }
	self.ContactStates = self.ContactStates or { false, false, false, false }
	self.NextStates = self.NextStates or { false,false,false,false }
	self.Udochkas = self.Udochkas or { false,false,false,false }
	self.CheckTimeout = self.CheckTimeout or 0
	if (CurTime() - self.CheckTimeout) > 0.25 then
		self.CheckTimeout = CurTime()
		self.VoltageDropByTouch = 0
		self.NextStates[1],self.Udochkas[1] = self:CheckContact(self.Train.FrontBogey,Vector(0,-61,-14),Vector(0,-1,0),1)
		self.NextStates[2],self.Udochkas[2]  = self:CheckContact(self.Train.FrontBogey,Vector(0, 61,-14),Vector(0, 1,0),2)
		self.NextStates[3],self.Udochkas[3]  = self:CheckContact(self.Train.RearBogey,Vector(0, -61,-14),Vector(0,-1,0),3)
		self.NextStates[4],self.Udochkas[4]  = self:CheckContact(self.Train.RearBogey,Vector(0,  61,-14),Vector(0, 1,0),4)
	end
	
	-- Voltage spikes
	self.VoltageDrop = self.VoltageDrop or 0
	self.VoltageDrop = math.max(-30,math.min(30,self.VoltageDrop + (0 - self.VoltageDrop)*10*dT))
	
	-- Detect changes in contact states
	for i=1,4 do
		local state = self.NextStates[i]
		if state ~= self.ContactStates[i] then
			self.ContactStates[i] = state
			
			if true then --state then
				local sound_source = (i <= 2) and "front_bogey" or "rear_bogey"
				if state then
					self.VoltageDrop = -40*(0.5 + 0.5*math.random())
				end
				
				local dt = CurTime() - self.PlayTime[i]
				self.PlayTime[i] = CurTime()

				local volume = 0.63
				if dt < 1.0 then volume = 0.53 end
				self.Train:PlayOnce("tr",sound_source,volume,math.random(90,120))
				
				-- Sparking probability
				local probability = math.min(1.0,math.max(0.0,1-(self.Train.Electric.Itotal/600)))
				if state and (math.random() > probability) then
					local effectdata = EffectData()
					if i == 1 then effectdata:SetOrigin(self.Train.FrontBogey:LocalToWorld(Vector(0,-70,-18))) end
					if i == 2 then effectdata:SetOrigin(self.Train.FrontBogey:LocalToWorld(Vector(0, 70,-18))) end
					if i == 3 then effectdata:SetOrigin(self.Train.RearBogey:LocalToWorld( Vector(0,-70,-18))) end
					if i == 4 then effectdata:SetOrigin(self.Train.RearBogey:LocalToWorld( Vector(0, 70,-18))) end
					effectdata:SetNormal(Vector(0,0,-1))
					util.Effect("stunstickimpact", effectdata, true, true)

					local light = ents.Create("light_dynamic")
					light:SetPos(effectdata:GetOrigin())
					light:SetKeyValue("_light","100 220 255")
					light:SetKeyValue("style", 0)
					light:SetKeyValue("distance", 256)
					light:SetKeyValue("brightness", 5)
					light:Spawn()
					light:Fire("TurnOn","","0") 

					local function rem()
						if IsValid(light) then
							SafeRemoveEntity(light)
						else
							timer.Simple(0.3,rem)
						end
					end
					timer.Simple(0.3,rem)
					sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",effectdata:GetOrigin(),75,math.random(100,150),1.0)
					--self.Train:PlayOnce("zap",sound_source,0.7*volume,50+math.random(90,120))
				end
			end
		end
	end

	-- Non-metrostroi maps
	if ((GetConVarNumber("metrostroi_train_requirethirdrail") <= 0)) or 
	   (not Metrostroi.MapHasFullSupport()) then
		self.Main750V = (Metrostroi.Voltage or 750) + self.VoltageDrop
		return 
	end

	-- Detect voltage
	self.Main750V = 0
	self.DropByPeople = 0
	for i=1,4 do
		if self.ContactStates[i] then self.Main750V = Metrostroi.Voltage + self.VoltageDrop end
		if self.Udochkas[i] then
			self.Main750V = Metrostroi.Voltage
		end
	end
	if self.VoltageDropByTouch > 0 then
		local Rperson = 0.613
		local Iperson = Metrostroi.Voltage / (Rperson/(self.VoltageDropByTouch + 1e-9))
		self.DropByPeople = Iperson
	end
	-- Too high current
	if self.Train.Electric.Itotal*self.Main750V > (750*1000) then
		self.Train:PlayOnce("spark","front_bogey",1.0,math.random(100,150))
		self.Train:PlayOnce("spark","rear_bogey",1.0,math.random(100,150))
	end
end
