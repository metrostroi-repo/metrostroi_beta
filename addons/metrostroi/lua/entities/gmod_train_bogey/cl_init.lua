include("shared.lua")

--------------------------------------------------------------------------------
function ENT:ReinitializeSounds()
	-- Bogey-related sounds
	self.SoundNames = {}
	self.SoundNames["engine"]		= "subway_trains/engine_1.wav"
	self.SoundNames["engine5"]		= "subway_trains/engine_5.wav"
	self.SoundNames["engine6"]		= "subway_trains/engine_6.wav"
	--self.SoundNames["run1"]			= "subway_trains/run_1.wav"
	--self.SoundNames["run2"]			= "subway_trains/run_2.wav"
	--self.SoundNames["run3"]			= "subway_trains/run_3.wav"
	self.SoundNames["run2"]			= "subway_trains/new/run_1.wav"
	self.SoundNames["run3"]			= "subway_trains/new/run_2.wav"
	--self.SoundNames["run2"]			= "subway_trains/new/noise.wav"
	--self.SoundNames["run3"]			= "subway_trains/new/noise.wav"
	--self.SoundNames["run4"]			= "subway_trains/run_4a.mp3"
	--self.SoundNames["run5"]			= "subway_announcer/00_00.mp3"
	self.SoundNames["release"]		= "subway_trains/new/release_1.wav"
	self.SoundNames["brake1"]		= "subway_trains/brake_1.wav"
	self.SoundNames["brake2"]		= "subway_trains/brake_2.wav"
	self.SoundNames["brake3"]		= "subway_trains/brake_3.wav"
	self.SoundNames["brake4"]		= "subway_trains/brake_4.wav"
	self.SoundNames["brake3a"]		= "subway_trains/brake_3.wav"
	self.SoundNames["flange1"]		= "subway_trains/flange_9.wav"
	self.SoundNames["flange2"]		= "subway_trains/flange_10.wav"
	
	-- Remove old sounds
	if self.Sounds then
		for k,v in pairs(self.Sounds) do
			v:Stop()
		end
	end

	-- Create sounds
	--if self.SoundNames["run2"] and not file.Exists("sound/subway_trains/new/noise.wav", "GAME") then
		--self.SoundNames["run2"] = nil
		--self.SoundNames["run3"] = nil
	--end
	self.Sounds = {}
	self.Playing = {}
	for k,v in pairs(self.SoundNames) do
		--if not file.Exists(v, "MOD") then
--			self.SoundNames[k] = nil
		--end
		util.PrecacheSound(v)
		local e = self
		if (k == "brake3a") and IsValid(self:GetNWEntity("TrainWheels")) then
			e = self:GetNWEntity("TrainWheels")
		end
		self.Sounds[k] = CreateSound(e, Sound(v))
	end
end

function ENT:SetSoundState(sound,volume,pitch)
	if not self.Sounds[sound] then return end
	if (volume <= 0) or (pitch <= 0) then
		--self.Sounds[sound]:Stop()
		self.Sounds[sound]:ChangeVolume(0.0,0)
		return
	end

	if not self.Playing[sound] then
		self.Sounds[sound]:Play()
	end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	self.Sounds[sound]:ChangeVolume(math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random(),0)
	self.Sounds[sound]:ChangePitch(pch+1,0)
end

function ENT:Initialize()
--	self:ReinitializeSounds()
end

function ENT:OnRemove()
	if self.Sounds then
		for k,v in pairs(self.Sounds) do
			v:Stop()
		end
	end
end




--------------------------------------------------------------------------------
function ENT:Think()
	--print(file.Exists("sound/subway_trains/new/noise.wav", "GAME"))
	--self:ReinitializeSounds()
	if not self.Sounds then
		self:ReinitializeSounds()
	end
	
	-- Get interesting parameters
	local motorPower = self:GetMotorPower()
	local speed = self:GetSpeed()
	local dPdT = self:GetdPdT()
	
	-- Engine sound
	--speed = 40
	--motorPower = 1.0
	if (speed > 1.0) and (math.abs(motorPower) >= 0.0) then
		local t = RealTime()*2.5
		local modulation = 0.2 + 1.0*math.max(0,0.2+math.sin(t)*math.sin(t*3.12)*math.sin(t*0.24)*math.sin(t*4.0))
		local mod2 = 1.0-math.min(1.0,(math.abs(motorPower)/0.1))
		local startVolRamp = 0.2 + 0.8*math.max(0.0,math.min(1.0,(speed - 1.0)*0.5))
		local powerVolRamp = 0.3*modulation*mod2 + 2*math.abs(motorPower)--2.0*(math.abs(motorPower)^2)
		--math.max(0.3,math.min(1.0,math.abs(motorPower)))

		local k,x = 1.0,math.max(0,math.min(1.1,(speed-1.0)/80))
		local motorPchRamp = (k*x^3 - k*x^2 + x)
		local motorPitch = 0.03+1.85*motorPchRamp
		
		local crossfade = math.min(1.0,math.max(0.0,1.25*(math.abs(motorPower)-0.15) ))
		
		self:SetSoundState("engine",startVolRamp*powerVolRamp*(1-0.5*crossfade),motorPitch)
		self:SetSoundState("engine6",startVolRamp*powerVolRamp*crossfade,motorPitch)
		self:SetSoundState("engine5",0,0)--startVolRamp*powerVolRamp*(1-crossfade),motorPitch)
	else
		self:SetSoundState("engine",0,0)
		self:SetSoundState("engine5",0,0)
		self:SetSoundState("engine6",0,0)
	end
	--print(math.max(0.0,math.min(1.0,speed/60)))
	-- Run sound
	if speed > 0.01 then
		local startVolRamp = math.max(0.0,math.min(1.0,speed/5))
		local bleedVolRamp = math.max(0.0,math.min(1.0,speed/40))
		
		local speedPitch2 = (speed/80)
		local speedPitch3 = math.max(0.1, (speed / 120))
		--print(startVolRamp*(1-bleedVolRamp),startVolRamp*(  bleedVolRamp))
		--self:SetSoundState("run1",0.0,0.0)
		--print(bleedVolRamp)
		self:SetSoundState("run2",startVolRamp*( bleedVolRamp),speedPitch2)
		self:SetSoundState("run3",startVolRamp*(  bleedVolRamp),speedPitch3)
		--[[
		local startVolRamp = math.max(0.0,math.min(1.0,speed/5))
		local bleedVolRamp = math.max(0.0,math.min(1.0,speed/60))
		
		local speedPitch2 = math.max(0.2,math.min(1.0,speed/30))
		local speedPitch3 = math.min(1.2, 0.4 + 0.6 * (speed / 60))
		
		--self:SetSoundState("run1",0.0,0.0)
		--self:SetSoundState("run2",startVolRamp*(1-bleedVolRamp),1)
		self:SetSoundState("run2",0,0)
		self:SetSoundState("run3",startVolRamp*(  bleedVolRamp),speedPitch3)
		self:SetSoundState("run4",0,0) --startVolRamp*3.0,math.min(1.0,speed/30)+math.max(0.0,(speed-60.0)/40))
		self:SetSoundState("run5",0,0) --startVolRamp*3.0,math.min(1.0,speed/30)+math.max(0.0,(speed-60.0)/40))
		]]
	else
		--self:SetSoundState("run1",0,0)
		self:SetSoundState("run2",0,0)
		self:SetSoundState("run3",0,0)
		self:SetSoundState("run4",0,0)
		self:SetSoundState("run5",0,0)
	end
	
	-- Brake release sound
	local sign = 1
	if dPdT < 0 then sign = -1 end
	if self.PrevDpSign ~= sign then
		self.PrevDpSign = sign
		self:SetSoundState("release",0.0,0.0)
	end

	local threshold = 0.01
	if dPdT < -threshold then
		local volRamp = 0*math.min(0.01,-0.1*(dPdT+threshold))
		--self:SetSoundState("release",0*volRamp,0*1.7)
		self:SetSoundState("release",0.0,0.0)
	elseif dPdT > threshold then
		local volRamp = (dPdT-threshold)/4.000
		self:SetSoundState("release",volRamp,1.0)
	else
		self:SetSoundState("release",0.0,0.0)
	end
	
	-- Brake squeal sound
	local squealSound = self:GetNWInt("SquealSound",0)
	local brakeSqueal = math.max(0.0,math.min(1.2,self:GetBrakeSqueal()))
	local brakeRamp = math.min(1.0,math.max(0.0,speed/2.0))
	if speed > 2 then
		brakeRamp = 1 - math.min(1.0,math.max(0.0,(speed-3)/10.0))
	end
	if squealSound == 0 then squealSound = 1 end
	if squealSound == 3 then squealSound = 2 end
	if brakeSqueal > 0.0 then
		self:SetSoundState("brake3",brakeSqueal*1.0*brakeRamp,1)
		self:SetSoundState("brake3a",brakeSqueal*1.0*brakeRamp,1)
		--self:SetSoundState("brake3",brakeSqueal*(0.10+0.90*brakeRamp)*fadeRamp,1+0.06*(1.0-brakeRamp))
		--[[
		if squealSound == 0 then
			self:SetSoundState("brake1",brakeSqueal*(0.10+0.90*brakeRamp),1+0.06*(1.0-brakeRamp))
		elseif squealSound == 1 then
			local fadeRamp = math.min(1.0,math.max(0.0,(speed-0.0)/16.0))
			self:SetSoundState("brake2",brakeSqueal*(0.10+0.90*brakeRamp)*fadeRamp,1+0.06*(1.0-brakeRamp))
			self:SetSoundState("brake4",brakeSqueal*(0.10+0.90*brakeRamp)*(1-fadeRamp),1+0.10*(1.0-brakeRamp))
		elseif squealSound == 2 then
			self:SetSoundState("brake2",brakeSqueal*0.07*(0.10+0.90*brakeRamp),1+0.06*(1.0-brakeRamp))
			self:SetSoundState("brake3",brakeSqueal*1.0*brakeRamp,1)
			self:SetSoundState("brake3a",brakeSqueal*1.0*brakeRamp,1)
		elseif squealSound == 3 then
			self:SetSoundState("brake4",brakeSqueal*(0.10+0.90*brakeRamp),1+0.10*(1.0-brakeRamp))
		end
		]]
	else
		self:SetSoundState("brake1",0,0)
		self:SetSoundState("brake2",0,0)
		self:SetSoundState("brake3",0,0)
		self:SetSoundState("brake3a",0,0)
		self:SetSoundState("brake4",0,0)
	end
	
	-- Timing
	self.PrevTime = self.PrevTime or RealTime()
	local dT = (RealTime() - self.PrevTime)
	self.PrevTime = RealTime()
	
	-- Generate procedural landscape thingy
	local a = self:GetPos().x
	local b = self:GetPos().y
	local c = self:GetPos().z
	local f = math.sin(c/200 + a*c/3e7 + b*c/3e7) --math.sin(a/3000)*math.sin(b/3000)
	
	-- Calculate flange squeal
	self.PreviousAngles = self.PreviousAngles or self:GetAngles()
	local deltaAngle = (self:GetAngles().yaw - self.PreviousAngles.yaw)/dT
	deltaAngle = ((deltaAngle + 180) % 360 - 180)
	deltaAngle = math.max(math.min(1.0,f*10)*math.abs(deltaAngle),0)
	self.PreviousAngles = self:GetAngles()
	
	-- Smooth it out
	self.SmoothAngleDelta = self.SmoothAngleDelta or 0
	self.SmoothAngleDelta = self.SmoothAngleDelta + (deltaAngle - self.SmoothAngleDelta)*1.0*dT
	if (not (self.SmoothAngleDelta <= 0)) and (not (self.SmoothAngleDelta >= 0)) then
		self.SmoothAngleDelta = 0
	end
	
	-- Create sound
	local x = self.SmoothAngleDelta
	local f1 = math.max(0,x-6.0)*0.1
	local f2 = math.max(0,x-9.0)*0.1
	local t = RealTime()
	local modulation = 1.5*math.max(0,0.2+math.sin(t)*math.sin(t*3.12)*math.sin(t*0.24)*math.sin(t*4.0))
	local pitch = math.max(0.8,1.0+(speed-40.0)/160.0)
	local speed_mod = math.min(1.0,math.max(0.0,(speed-20)*0.1))
	
	-- Play it
	self:SetSoundState("flange1",speed_mod*f1,pitch)
	self:SetSoundState("flange2",speed_mod*f2*modulation,pitch)
end