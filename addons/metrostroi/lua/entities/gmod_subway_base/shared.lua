ENT.Type            = "anim"

ENT.PrintName       = "Subway Train Base"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false


--------------------------------------------------------------------------------
-- Default initializer only loads up DURA
--------------------------------------------------------------------------------
function ENT:InitializeSystems()
	self:LoadSystem("DURA")
	self:LoadSystem("ALS_ARS")
end

function ENT:PassengerCapacity()
	return 0
end

function ENT:GetStandingArea()
	return Vector(-64,-64,0),Vector(64,64,0)
end

function ENT:BoardPassengers(delta)
	self:SetNWFloat("PassengerCount", math.max(0,math.min(self:PassengerCapacity(),self:GetNWFloat("PassengerCount") + delta)))
end



--------------------------------------------------------------------------------
-- Load/define basic sounds
--------------------------------------------------------------------------------
function ENT:InitializeSounds()
	self.SoundPositions = {} -- Positions (used clientside)
	self.SoundNames = {}
	self.SoundNames["zombie"]	= {
		"npc/zombie/zombie_voice_idle1.wav",
		"npc/zombie/zombie_voice_idle2.wav",
		"npc/zombie/zombie_voice_idle3.wav",
		"npc/zombie/zombie_voice_idle4.wav",
		"npc/zombie/zombie_voice_idle5.wav",
		"npc/zombie/zombie_voice_idle6.wav",
		"npc/zombie/zombie_voice_idle7.wav",
		"npc/zombie/zombie_voice_idle8.wav",
		"npc/zombie/zombie_voice_idle9.wav",
		"npc/zombie/zombie_voice_idle10.wav",
		"npc/zombie/zombie_voice_idle11.wav",
		"npc/zombie/zombie_voice_idle12.wav",
		"npc/zombie/zombie_voice_idle13.wav",
		"npc/zombie/zombie_voice_idle14.wav",
	}
	self.SoundNames["zombie_loop"]	= "npc/zombie/moan_loop4.wav"
	self.SoundPositions["zombie_loop"] = "cabin"

	self.SoundNames["switch"]	= "subway_trains/switch_1.wav"
	self.SoundNames["switch1"]	= "subway_trains/switch_1.wav"
	self.SoundNames["switch2"]	= {
		"subway_trains/new/switch_1.wav",
		"subway_trains/new/switch_2.wav",
		"subway_trains/new/switch_3.wav",
		"subway_trains/new/switch_4.wav",
		"subway_trains/new/switch_5.wav",
	}
	self.SoundNames["switch3"]	= {
		"subway_trains/switch_5.wav",
		"subway_trains/switch_6.wav",
		"subway_trains/switch_7.wav",
	}
	self.SoundNames["switch4"]		= "subway_trains/switch_4.wav"
	self.SoundNames["switch5"]		= "subway_trains/switch_8.wav"
	self.SoundNames["switch6"]		= "subway_trains/switch_9.wav"
	self.SoundNames["switch6_off"]	= "subway_trains/switch_10.wav"
	self.SoundNames["vu22_on"]	= "subway_trains/new/vu22_on.wav"
	self.SoundNames["vu22_off"]	= "subway_trains/new/vu22_off.wav"
	self.SoundNames["button_press"]		= {
		"subway_trains/new/button_1_on.wav",
	}
	self.SoundNames["button_release"]		= {
		"subway_trains/new/button_1_off.wav",
		"subway_trains/new/button_2_off.wav",
	}
	
	self.SoundNames["kru_in"]			= "subway_trains/new/kru_in.wav"
	self.SoundNames["kru_out"]			= "subway_trains/new/kru_out.wav"
	self.SoundNames["revers_in"]			= "subway_trains/new/revers_in.wav"
	self.SoundNames["revers_out"]			= "subway_trains/new/revers_out.wav"

	self.SoundNames["av_on"]			= "subway_trains/av_on.wav"
	self.SoundNames["av_off"]			= "subway_trains/av_off.wav"

	self.SoundNames["bpsn1"] 		= "subway_trains/bpsn_1.wav"
	self.SoundNames["bpsn2"] 		= "subway_trains/bpsn_2.wav"
	self.SoundNames["bpsn3"] 		= "subway_trains/bpsn_3.wav"
	self.SoundNames["bpsn4"] 		= "subway_trains/bpsn_4.wav"
	self.SoundNames["bpsn5"] 		= "subway_trains/bpsn_5.wav"
	self.SoundNames["bpsn6"] 		= "subway_trains/bpsn_6.wav"
	self.SoundNames["bpsn_ann"] 	= "subway_announcer/00_07_new.wav"
	self.SoundNames["bpsn_ann_cab"] 	= "subway_announcer/00_07_new.wav"
	self.SoundPositions["bpsn_ann_cab"]	= "cabin"
	
	self.SoundNames["release1"]		= "subway_trains/new/release_1.wav"
	self.SoundNames["release2"]		= "subway_trains/release_2.wav"
	self.SoundNames["release3"]		= "subway_trains/release_3.wav"
	self.SoundPositions["release2"] = "cabin"
	self.SoundPositions["release3"] = "cabin"
	
	self.SoundNames["release2_w"]	= "subway_trains/release_2.wav"
	self.SoundNames["release3_w"]	= "subway_trains/release_3.wav"
	
	self.SoundNames["horn2"] 		= "subway_trains/horn_3a.wav"
	self.SoundNames["horn2_end"] 	= "subway_trains/horn_4a.wav"
	self.SoundNames["horn3"] 		= "subway_trains/horn_5.wav"
	self.SoundNames["horn3_end"] 	= "subway_trains/horn_6.wav"
	self.SoundPositions["horn1"]	= "cabin"
	self.SoundPositions["horn2"]	= "cabin"
	self.SoundPositions["horn3"]	= "cabin"
	
	self.SoundNames["ring"]			= "subway_trains/new//ring1.wav"
	self.SoundNames["ring_end"]		= "subway_trains/new/ring2.wav"
	self.SoundPositions["ring"] 	= "cabin"
	self.SoundPositions["ring_end"] = "cabin"
	
	self.SoundNames["ring1"]		= "subway_trains/ring1.wav"
	self.SoundNames["ring1_end"]	= "subway_trains/ring2.wav"
	self.SoundPositions["ring1"] 	= "cabin"
	self.SoundPositions["ring1_end"]= "cabin"
	
	self.SoundNames["ring2"]		= "subway_trains/ring_3.wav"
	self.SoundNames["ring2_end"]	= "subway_trains/ring_4.wav"
	self.SoundPositions["ring2"] 	= "cabin"
	self.SoundPositions["ring2_end"]= "cabin"
	
	self.SoundNames["ring3"]		= "subway_trains/new/ring5.wav"
	self.SoundNames["ring3_end"]	= "subway_trains/new/ring6.wav"
	self.SoundPositions["ring3"] 	= "cabin"
	self.SoundPositions["ring3_end"]= "cabin"
	
	self.SoundNames["upps"]			= "subway_trains/upps.wav"
	
	self.SoundNames["dura1"]		= "subway_trains/dura_alarm_1.wav"
	self.SoundNames["dura2"]		= "subway_trains/dura_alarm_2.wav"
	
	self.SoundNames["rk_spin"]		= "subway_trains/rk_1.wav"
	self.SoundNames["rk_stop"]		= "subway_trains/rk_2.wav"

	self.SoundNames["inf_on"]		= "subway_trains/new/inf_on.wav"
	self.SoundNames["inf_off"]		= "subway_trains/new/inf_off.wav"
	
	self.SoundNames["br_334"]		= {
		"subway_trains/new/334_1.wav",
		"subway_trains/new/334_2.wav",
		"subway_trains/new/334_3.wav",
		"subway_trains/new/334_4.wav",
	}
	
	self.SoundNames["br_013"]		= {
		"subway_trains/switch_1.wav",
	}

	self.SoundNames["pneumo_switch"] = {
		"subway_trains/pneumo_1.wav",
		"subway_trains/pneumo_2.wav",
	}
	self.SoundNames["pneumo_disconnect1"] = {
		"subway_trains/pneumo_3.wav",
	}
	self.SoundNames["pneumo_disconnect2"] = {
		"subway_trains/pneumo_4.wav",
		"subway_trains/pneumo_5.wav",
	}
	self.SoundNames["pneumo_reverser"] = "subway_trains/pneumo_6.wav"
	self.SoundNames["pneumo_switch_on"] = "subway_trains/pneumo_7.wav"
	
	self.SoundNames["relay_open"] = {
		"subway_trains/relay_1.wav",
	}
	self.SoundNames["relay_close"] = {
		"subway_trains/relay_2.wav",
		"subway_trains/relay_3.wav",
	}
	self.SoundNames["relay_close2"] = "subway_trains/new/relay_4.wav"
	self.SoundNames["relay_close3"] = "subway_trains/new/relay_5.wav"
	self.SoundNames["relay_close4"] = "subway_trains/new/relay_6.wav"
	self.SoundNames["relay_close5"] = "subway_trains/new/relay_3.wav"
	self.SoundNames["door_close1"] = {
		"subway_trains/door_close_7.wav",
		"subway_trains/door_close_8.wav"
	}
	self.SoundNames["door_open1"] = {
		"subway_trains/door_open_4.wav",
		"subway_trains/door_open_5.wav",
		"subway_trains/door_open_6.wav",
	}
	self.SoundNames["door_fail1"] = {
		"subway_trains/door_fail_1.wav",
		"subway_trains/door_fail_2.wav",
	}
	
	self.SoundNames["door_close2"] = {
		"subway_trains/door_close_2.wav",
		"subway_trains/door_close_3.wav",
		"subway_trains/door_close_4.wav",
		"subway_trains/door_close_5.wav",
	}
	self.SoundNames["door_open2"] = {
		"subway_trains/door_open_1.wav",
		"subway_trains/door_open_2.wav",
		"subway_trains/door_open_3.wav",
	}
	
	self.SoundNames["compressor"]		= "subway_trains/compressor_1.wav"
	self.SoundNames["compressor_end"] 	= "subway_trains/compressor_2.wav"

	self.SoundNames["revers_f"]		= "subway_trains/new/revers_f.wav"
	self.SoundNames["revers_0"]		= "subway_trains/new/revers_0.wav"
	self.SoundNames["revers_b"]		= "subway_trains/new/revers_b.wav"

	self.SoundNames["kru_0_1"]		= "subway_trains/new/kru_0_1.wav"
	self.SoundNames["kru_1_2"]		= "subway_trains/new/kru_1_2.wav"
	self.SoundNames["kru_2_1"]		= "subway_trains/new/kru_2_1.wav"
	self.SoundNames["kru_1_0"]		= "subway_trains/new/kru_1_0.wav"

	self.SoundNames["kv_0_t1"]		= "subway_trains/new/kv_0_t1.wav"
	self.SoundNames["kv_t1_0"]		= "subway_trains/new/kv_t1_0.wav"
	self.SoundNames["kv_t1_t1a"]	= "subway_trains/new/kv_t1_t1a.wav"
	self.SoundNames["kv_t1a_t1"]	= "subway_trains/new/kv_t1a_t1.wav"
	self.SoundNames["kv_t1a_t2"]	= "subway_trains/new/kv_t1a_t2.wav"
	self.SoundNames["kv_t2_t1a"]	= "subway_trains/new/kv_t2_t1a.wav"
	self.SoundNames["kv_0_x1"]		= "subway_trains/new/kv_0_x1.wav"
	self.SoundNames["kv_x1_0"]		= "subway_trains/new/kv_x1_0.wav"
	self.SoundNames["kv_x1_x2"]		= "subway_trains/new/kv_x1_x2.wav"
	self.SoundNames["kv_x2_x1"]		= "subway_trains/new/kv_x2_x1.wav"
	self.SoundNames["kv_x2_x3"]		= "subway_trains/new/kv_x2_x3.wav"
	self.SoundNames["kv_x3_x2"]		= "subway_trains/new/kv_x3_x2.wav"
	
	self.SoundNames["ezh_kv_0_t1"]		= "subway_trains/new/ezh_kv_0_t1.wav"
	self.SoundNames["ezh_kv_t1_0"]		= "subway_trains/new/ezh_kv_t1_0.wav"
	self.SoundNames["ezh_kv_t1_t1a"]	= "subway_trains/new/ezh_kv_t1_t1a.wav"
	self.SoundNames["ezh_kv_t1a_t1"]	= "subway_trains/new/ezh_kv_t1a_t1.wav"
	self.SoundNames["ezh_kv_t1a_t2"]	= "subway_trains/new/ezh_kv_t1a_t2.wav"
	self.SoundNames["ezh_kv_t2_t1a"]	= "subway_trains/new/ezh_kv_t2_t1a.wav"
	self.SoundNames["ezh_kv_0_x1"]		= "subway_trains/new/ezh_kv_0_x1.wav"
	self.SoundNames["ezh_kv_x1_0"]		= "subway_trains/new/ezh_kv_x1_0.wav"
	self.SoundNames["ezh_kv_x1_x2"]		= "subway_trains/new/ezh_kv_x1_x2.wav"
	self.SoundNames["ezh_kv_x2_x1"]		= "subway_trains/new/ezh_kv_x2_x1.wav"
	self.SoundNames["ezh_kv_x2_x3"]		= "subway_trains/new/ezh_kv_x2_x3.wav"
	self.SoundNames["ezh_kv_x3_x2"]		= "subway_trains/new/ezh_kv_x3_x2.wav"
	
	for i = 1,7 do
		self.SoundNames["styk"..i] = "subway_trains/new/styk"..i..".wav"
	end
	
	self.SoundNames["tr"] = {
		"subway_trains/tr_1.wav",
		"subway_trains/tr_2.wav",
		"subway_trains/tr_3.wav",
		"subway_trains/tr_4.wav",
		"subway_trains/tr_5.wav",
	}
	
	self.SoundNames["zap"] = {
		"ambient/energy/zap1.wav",
		"ambient/energy/zap2.wav",
		"ambient/energy/zap3.wav",
	}
	
	self.SoundNames["spark"] = {
		"ambient/energy/spark1.wav",
		"ambient/energy/spark2.wav",
		"ambient/energy/spark3.wav",
		"ambient/energy/spark4.wav",
		"ambient/energy/spark5.wav",
	}	
	self.SoundNames["uava_on"]		= "subway_trains/new/uava_on.wav"
	self.SoundNames["uava_off"]		= "subway_trains/new/uava_off.wav"

	self.SoundNames["paksd"]		= "subway_trains/new/paksd.wav"
	
	self.SoundTimeout = {}
end


--------------------------------------------------------------------------------
-- Sound functions
--------------------------------------------------------------------------------
function ENT:SetSoundState(sound,volume,pitch,timeout,range)
	--if not self.Sounds[sound] then return end
	--if sound == "ring" then sound = "zombie_loop" end
	if not self.Sounds[sound] then 
		if self.SoundNames and self.SoundNames[sound] then
			local name = self.SoundNames[sound]
			if self.SoundPositions[sound] then
				local ent_nwID
				if self.SoundPositions[sound] == "cabin" then ent_nwID = "seat_driver" end
				
				local ent = self:GetNWEntity(ent_nwID)
				if IsValid(ent) then
					self.Sounds[sound] = CreateSound(ent, Sound(name))
				else
					return
				end
			else
				self.Sounds[sound] = CreateSound(self, Sound(name))
			end
		else
			return 
		end
	end
	local default_range = 0.80
	if (volume <= 0) or (pitch <= 0) then
		self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
		self.Sounds[sound]:Stop()
		return
	end

	if soundid == "switch" then default_range = 0.50 end
	local pch = math.floor(math.max(0,math.min(255,100*pitch)) + math.random())
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
	self.Sounds[sound]:Play()
	self.Sounds[sound]:ChangeVolume(math.max(0,math.min(255,2.55*volume)) + (0.001/2.55) + (0.001/2.55)*math.random(),timeout or 0)
	self.Sounds[sound]:ChangePitch(pch+1,timeout or 0)
	self.Sounds[sound]:SetSoundLevel(100*(range or default_range))
end

--[[function ENT:CheckActionTimeout(action,timeout)
	self.LastActionTime = self.LastActionTime or {}
	self.LastActionTime[action] = self.LastActionTime[action] or (CurTime()-1000)
	if CurTime() - self.LastActionTime[action] < timeout then return true end
	self.LastActionTime[action] = CurTime()

	return false
end
]]--
function ENT:PlayOnce(soundid,location,range,pitch)
	--soundid = "zombie"
	--if self:CheckActionTimeout(soundid,self.SoundTimeout[soundid] or 0.0) then return end

	-- Pick wav file
	local sound = self.SoundNames[soundid]
	if not sound then return end
	if type(sound) == "table" then sound = table.Random(sound) end

	-- Setup range
	local default_range = 0.80
	if soundid == "switch" then default_range = 0.50 end

	-- Emit sound from right location
	if not location then
		self:EmitSound(sound, 100*(range or default_range), pitch or math.random(95,105))
	elseif (location == true) or (location == "cabin") then
		if CLIENT then self.DriverSeat = self:GetNWEntity("seat_driver") end				
		if IsValid(self.DriverSeat) then
			self.DriverSeat:EmitSound(sound, 100*(range or default_range),pitch or math.random(95,105))
		end
	elseif (location == true) or (location == "instructor") then
		if CLIENT then self.InstructorsSeat = self:GetNWEntity("seat_instructor") end				
		if IsValid(self.InstructorsSeat) then
			self.InstructorsSeat:EmitSound(sound, 100*(range or default_range),pitch or math.random(95,105))
		end
	elseif location == "front_bogey" then
		if IsValid(self.FrontBogey) then
			self.FrontBogey:EmitSound(sound, 100*(range or default_range),pitch or math.random(95,105))
		end
	elseif location == "rear_bogey" then
		if IsValid(self.RearBogey) then
			self.RearBogey:EmitSound(sound, 100*(range or default_range),pitch or math.random(95,105))
		end
	end
end




--------------------------------------------------------------------------------
-- Load a single system with given name
--------------------------------------------------------------------------------
function ENT:LoadSystem(a,b,...)
	local name
	local sys_name
	if b then
		name = b
		sys_name = a
	else
		name = a
		sys_name = a
	end
	
	if not Metrostroi.Systems[name] then error("No system defined: "..name) end
	if self.Systems[sys_name] then error("System already defined: "..sys_name)  end
	
	local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation
	local run_everywhere = Metrostroi.BaseSystems[name].RunEverywhere
	if SERVER and Turbostroi then
		-- Load system into turbostroi
		if (not GLOBAL_SKIP_TRAIN_SYSTEMS) then
			Turbostroi.LoadSystem(sys_name,name)
		end
		
		-- Load system locally (this may load any systems nested in the initializer)
		GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS or 0
		if GLOBAL_SKIP_TRAIN_SYSTEMS then GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS + 1 end
		self[sys_name] = Metrostroi.Systems[name](self,...)
		GLOBAL_SKIP_TRAIN_SYSTEMS = GLOBAL_SKIP_TRAIN_SYSTEMS - 1
		if GLOBAL_SKIP_TRAIN_SYSTEMS == 0 then GLOBAL_SKIP_TRAIN_SYSTEMS = nil end
		
		-- Setup nice name as normal
		--if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
		self[sys_name].Name = sys_name
		self.Systems[sys_name] = self[sys_name]
		
		-- Create fake placeholder
		if not no_acceleration then
			if run_everywhere then
				local old_func = self[sys_name].TriggerInput
				self[sys_name].TriggerInput = function(system,name,value)
					old_func(self,sys_name,name,value)
					Turbostroi.TriggerInput(self,sys_name,name,value)
				end
			else
				self[sys_name].TriggerInput = function(system,name,value)
					Turbostroi.TriggerInput(self,sys_name,name,value)
				end
			end
			self[sys_name].Think = function() end
		end
	else
		-- Load system like normal
		self[sys_name] = Metrostroi.Systems[name](self,...)
		--if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
		self[sys_name].Name = sys_name
		self.Systems[sys_name] = self[sys_name]

		--if SERVER then
			--[[self[sys_name].TriggerOutput = function(sys,name,value)
				local varname = (sys.Name or "")..name
				--self:TriggerOutput(varname, tonumber(value) or 0)
				self.DebugVars[varname] = value
			end]]--
		--end
	end
end

function ENT:SetupDataTables()
	self._NetData = {{},{}}
end
---------------------------------------------------------------------------------------
-- Sends and get float via NWVars
---------------------------------------------------------------------------------------
function ENT:SetPackedRatio(idx,value)
	if self._NetData[2][idx] ~= nil and self._NetData[2][idx] == math.Round(value,3) then return end
	self:SetNWFloat(999-idx,math.Round(value,3))
end

function ENT:GetPackedRatio(idx)
	return self:GetNWFloat(999-idx)
end

--------------------------------------------------------------------------------
-- Sends and get bool via NWVars
--------------------------------------------------------------------------------
function ENT:SetPackedBool(idx,value)
	if self._NetData[1][idx] ~= nil and self._NetData[1][idx] == value then return end
	self:SetNWBool(idx,value)
end

function ENT:GetPackedBool(idx)
	return self:GetNWBool(idx)
end