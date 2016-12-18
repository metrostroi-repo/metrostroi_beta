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
	self:SetNW2Float("PassengerCount", math.max(0,math.min(self:PassengerCapacity(),self:GetNW2Float("PassengerCount") + delta)))
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
		"subway_trains/tumbler_1_off.wav",
		"subway_trains/tumbler_2_off.wav",
		"subway_trains/tumbler_3_off.wav",
		"subway_trains/tumbler_4_off.wav",
	}
	self.SoundNames["switch_off"]	= {
		"subway_trains/tumbler_1_off.wav",
		"subway_trains/tumbler_2_off.wav",
		"subway_trains/tumbler_3_off.wav",
		"subway_trains/tumbler_4_off.wav",
	}
	self.SoundNames["switch_on"]	= {
		"subway_trains/tumbler_1_on.wav",
		"subway_trains/tumbler_2_on.wav",
		"subway_trains/tumbler_3_on.wav",
		"subway_trains/tumbler_4_on.wav",
	}
	self.SoundNames["switch3"]	= {
		"subway_trains/tumbler_1_off.wav",
		"subway_trains/tumbler_2_off.wav",
		"subway_trains/tumbler_3_off.wav",
		"subway_trains/tumbler_4_off.wav",
	}
	self.SoundNames["rcr_off"]	= {
		"subway_trains/ezh/rcr_ars_off.wav",
	}
	self.SoundNames["rcr_on"]	= {
		"subway_trains/ezh/rcr_ar_on.wav",
	}
	self.SoundNames["igla_on"]	= "subway_trains/igla_on1.mp3"
	self.SoundNames["igla_off"]	= "subway_trains/igla_off2.mp3"
	self.SoundNames["igla_start1"]	= "subway_trains/igla_start.mp3"
	self.SoundNames["igla_start2"]	= "subway_trains/igla_on2.mp3"

	-----
	--E
	-----
	self.SoundNames["auto_on"] =  "subway_trains/vu_on.wav"
	self.SoundNames["auto_off"] = "subway_trains/vu_off.wav"
	self.SoundNames["mainauto_on"]		= {
		"subway_trains/kv1_4.wav",
		"subway_trains/kv1_5.wav",
		"subway_trains/kv1_3.wav",
	}
	self.SoundNames["mainauto_off"]		= {
		"subway_trains/kv1_2.wav",
		"subway_trains/kv1_10.wav",
	}
	-----
	self.SoundNames["kurlik"]		= "subway_trains/new/kurlik.wav"
	self.SoundNames["switch4"]		= "subway_trains/switch_4.wav"
	self.SoundNames["switch5"]		= "subway_trains/switch_8.wav"
	self.SoundNames["switch6"]		= "subway_trains/tumblers/pb_on.wav"
	self.SoundNames["switch6_off"]	= "subway_trains/tumblers/pb_off.wav"
	self.SoundNames["vu22_on"]		= {
			"subway_trains/tumblers/vud_on1.wav",
	}
	self.SoundNames["vu22_off"]		= {
			"subway_trains/tumblers/vud_off1.wav",
			"subway_trains/tumblers/vud_off2.wav",
			"subway_trains/tumblers/vud_off3.wav",
			"subway_trains/tumblers/vud_off4.wav",
	}
	self.SoundNames["vu22b_off"]	= "subway_trains/vu22_3_off.wav"
	self.SoundNames["vu22b_on"]	= "subway_trains/vu22_3_on.wav"
	self.SoundNames["button_press"]		= {
		"subway_trains/trains/button_on1.wav"
		--"subway_trains/but_on1.wav",
		--"subway_trains/but_on2.wav",
		--"subway_trains/but_on3.wav",
		--"subway_trains/but_on4.wav",
		--"subway_trains/but_on5.wav",
		--"subway_trains/but_on6.wav",
		--"subway_trains/button_1_on.wav",
	}
	self.SoundNames["button_release"]		= {
		"subway_trains/trains/button_off1.wav",
		"subway_trains/trains/button_off2.wav",
		"subway_trains/trains/button_off3.wav",
		--"subway_trains/button_1_off.wav",
		--"subway_trains/button_2_off.wav",
		--"subway_trains/but_off1.wav",
		--"subway_trains/but_off2.wav",
		--"subway_trains/but_off3.wav",
		--"subway_trains/but_off4.wav",
		--"subway_trains/but_off5.wav",
		--"subway_trains/but_off6.wav",
		--"subway_trains/but_off7.wav",
	}
	self.SoundNames["skripy"]			= "subway_trains/trains/skripy.wav"

	self.SoundNames["epv_on"]			= "subway_trains/trains/epv/epv_on.wav"
	self.SoundNames["epv_off"]			= "subway_trains/trains/epv/epv_off.wav"

	self.SoundNames["epv_start"]			= "subway_trains/trains/epv/epv_start.wav"

	self.SoundNames["kr_open"]			= "subway_trains/trains/flip2_down.wav"
	self.SoundNames["kr_close"]			= "subway_trains/trains/flip2_up.wav"

	self.SoundNames["kru_in"]			= "subway_trains/trains/kru_insert.wav"
	self.SoundNames["kru_out"]			= "subway_trains/trains/kru_eject.wav"
	self.SoundNames["revers_in"]			= "subway_trains/revers_in.wav"
	self.SoundNames["revers_out"]			= "subway_trains/revers_out.wav" --FIXME

	--self.SoundNames["av_on"]			= "subway_trains/av_on.wav"
	--self.SoundNames["av_off"]			= "subway_trains/av_off.wav"
	self.SoundNames["av_on"]			=  {
		"subway_trains/va21_1_on.wav",
		"subway_trains/va21_2_on.wav",
		"subway_trains/va21_3_on.wav",
		"subway_trains/va21_4_on.wav",
	}
	self.SoundNames["av_off"]			=  {
		"subway_trains/va21_1_off.wav",
		"subway_trains/va21_2_off.wav",
		"subway_trains/va21_3_off.wav",
		"subway_trains/va21_4_off.wav",
	}

	self.SoundNames["pak_on"]			= "subway_trains/pak_on.wav"
	self.SoundNames["pak_off"]			= "subway_trains/pak_off.wav"

	self.SoundNames["bpsn1"] 		= "subway_trains/bpsn_1.wav"
	self.SoundNames["bpsn2"] 		= "subway_trains/bpsn3.wav"
	self.SoundNames["bpsn3"] 		= "subway_trains/bpsn_4.wav"
	self.SoundNames["bpsn4"] 		= "subway_trains/bpsn_5.wav"
	self.SoundNames["bpsn5"] 		= "subway_trains/bpsn_6.wav"
	self.SoundNames["bpsn6"] 		= "subway_trains/bpsn_7.wav"
	self.SoundNames["bpsn7"] 		= "subway_trains/trains/717/bpsn_kiyv.wav"

	self.SoundNames["bpsn_ann_pnm"] 	= "subway_announcer_pnm/00_07.wav"
	self.SoundNames["bpsn_ann_pnm_cab"] 	= "subway_announcer_pnm/00_07.wav"
	self.SoundPositions["bpsn_ann_pnm_cab"]	= "cabin"
	self.SoundNames["bpsn_ann"] 	= "subway_announcer/00_07.wav"
	self.SoundNames["bpsn_ann_cab"] 	= "subway_announcer/00_07.wav"
	self.SoundPositions["bpsn_ann_cab"]	= "cabin"

	self.SoundNames["release1"]		= "subway_trains/trains/release_1.wav"
	self.SoundNames["release2"]		= "subway_trains/trains/release_2.wav"
	self.SoundNames["release3"]		= "subway_trains/trains/epv/epv_loop.wav"
	
	self.SoundNames["release2_ezh"]		= "subway_trains/ezh/release_ezh_2.wav"
	self.SoundNames["release1_ezh"]		= "subway_trains/ezh/release_ezh_1.wav"
	
	self.SoundPositions["release2"] = "cabin"
	self.SoundPositions["release3"] = "cabin"
	self.SoundPositions["release2_ezh"] = "cabin"
	self.SoundPositions["release1_ezh"] = "cabin"
	
	self.SoundNames["cran1"]		= "subway_trains/ezh/pneumo_idle.wav"
	self.SoundNames["idle_electric"]		= "subway_trains/ezh/idle_electric.wav"
	
	self.SoundPositions["cran1"] = "cabin"
	self.SoundPositions["idle_electric"] = "cabin"

	self.SoundNames["release2_w"]	= "subway_trains/trains/release_2.wav"
	self.SoundNames["release3_w"]	= "subway_trains/trains/epv/epv_loop.wav"

	self.SoundNames["horn2"] 		= "subway_trains/horn_3a.wav"
	self.SoundNames["horn2_end"] 	= "subway_trains/horn_4a.wav"
	self.SoundNames["horn3"] 		= "subway_trains/horn_5.wav"
	self.SoundNames["horn3_end"] 	= "subway_trains/horn_6.wav"
	self.SoundPositions["horn1"]	= "cabin"
	self.SoundPositions["horn2"]	= "cabin"
	self.SoundPositions["horn3"]	= "cabin"

	self.SoundNames["ring"]			= "subway_trains/ring_loop.wav"
	self.SoundNames["ring_end"]		= "subway_trains/ring_end.wav"
	self.SoundPositions["ring"] 	= "cabin"
	self.SoundPositions["ring_end"] = "cabin"

	self.SoundNames["ring1"]		= "subway_trains/ring1.wav"
	self.SoundNames["ring1_end"]	= "subway_trains/ring2.wav"
	self.SoundPositions["ring1"] 	= "cabin"
	self.SoundPositions["ring1_end"]= "cabin"

	self.SoundNames["ring2"]		= "subway_trains/trains/717/ringc_loop.wav"
	self.SoundNames["ring2_end"]	= "subway_trains/trains/717/ringc_end.wav"
	self.SoundPositions["ring2"] 	= "cabin"
	self.SoundPositions["ring2_end"]= "cabin"

	self.SoundNames["ring_old"]		= "subway_trains/trains/717/ringo_loop.wav"
	self.SoundNames["ring_old_end"]	= "subway_trains/trains/717/ringo_end.wav"
	self.SoundPositions["ring_old"] 	= "cabin"
	self.SoundPositions["ring_old_end"]= "cabin"

	self.SoundNames["ring3"]		= "subway_trains/new/ring5.wav"
	self.SoundNames["ring3_end"]	= "subway_trains/new/ring6.wav"
	self.SoundPositions["ring3"] 	= "cabin"
	self.SoundPositions["ring3_end"]= "cabin"

	self.SoundNames["ring4"]		= "subway_trains/new/ring7.wav"
	self.SoundNames["ring4_end"]	= "subway_trains/new/ring8.wav"
	self.SoundPositions["ring4"] 	= "cabin"
	self.SoundPositions["ring4_end"]= "cabin"

	self.SoundNames["upps"]			= {"subway_trains/upps.wav","subway_trains/trains/upps_2.wav"}

	self.SoundNames["dura1"]		= "subway_trains/dura_alarm_1.wav"
	self.SoundNames["dura2"]		= "subway_trains/dura_alarm_2.wav"

	self.SoundNames["rk_spin"]		= "subway_trains/trains/rk_spin.wav"
	self.SoundNames["rk_stop"]		= "subway_trains/trains/rk_stop.wav"

	self.SoundNames["lk2_on"]		= "subway_trains/lk2_on.wav"
	self.SoundNames["lk2_off"]		= "subway_trains/lk2_off.wav"
	self.SoundNames["lk3_on"]		= "subway_trains/lk3_on.wav"
	self.SoundNames["lk3_off"]		= "subway_trains/lk3_off.wav"
	self.SoundNames["pkg"] = {"subway_trains/pkg1.wav","subway_trains/pkg2.wav"}

	self.SoundNames["inf_on"]		= "subway_trains/program_on.wav"
	self.SoundNames["inf_off"]		= "subway_trains/program_0.wav"

	self.SoundNames["vpr"]		= "subway_trains/vpr.wav"
	self.SoundNames["vpr_end"]	= "subway_trains/vpr_off.wav"
	self.SoundPositions["vpr"] 	= "cabin"
	self.SoundPositions["vpr_end"]= "cabin"
	
	self.SoundNames["br_334"]		= {
		"subway_trains/new/334_1.wav",
		"subway_trains/new/334_2.wav",
		"subway_trains/new/334_3.wav",
		"subway_trains/new/334_4.wav",
	}
	
 	self.SoundNames["sos"] = "subway_trains/message1.wav"
		
	self.SoundNames["br_334_1-2"]		= "subway_trains/trains/334_1-2.wav"
	self.SoundNames["br_334_2-1"]		= "subway_trains/trains/334_2-1.wav"
	self.SoundNames["br_334_2-3"]		= "subway_trains/trains/334_2-3.wav"
	self.SoundNames["br_334_3-2"]		= "subway_trains/trains/334_3-2.wav"
	self.SoundNames["br_334_4-3"]		= "subway_trains/trains/334_4-3.wav"
	self.SoundNames["br_334_4-5"]		= "subway_trains/trains/334_4-5.wav"

	self.SoundNames["br_013"]		= {
		"subway_trains/013_1.wav",
		"subway_trains/013_2.wav",
		"subway_trains/013_3.wav",
		"subway_trains/013_4.wav",
	}

	self.SoundNames["pneumo_switch"] = {
		"subway_trains/pneumo_1.wav",
		"subway_trains/pneumo_2.wav",
	}
	self.SoundNames["pneumo_disconnect2"] = {
		"subway_trains/trains/pneumo_close.wav",
	}
	self.SoundNames["pneumo_TL_open"] = {
		"subway_trains/ezh/pneumo_BL_open2.wav",
	}
	self.SoundNames["pneumo_TL_disconnect"] = {
		"subway_trains/trains/334_close.wav",
	}
	self.SoundNames["pneumo_BL_disconnect"] = {
		"subway_trains/ezh/pneumo_TL_disconnect1.wav",
	}
	
	self.SoundNames["pneumo_disconnect1"] = {
		"subway_trains/trains/pneumo_open.wav",
		"subway_trains/trains/pneumo_open2.wav",
	}
	self.SoundNames["pneumo_reverser"] = "subway_trains/pneumo_6.wav"
	self.SoundNames["pneumo_switch_on"] = "subway_trains/pneumo_7.wav"

	self.SoundNames["relay_open"] = {
		"subway_trains/trains/717/lsd_2.wav",
		--"subway_trains/trains/717/lsd_3.wav",
	}
	self.SoundNames["relay_close"] = {
		"subway_trains/trains/relay_1.wav",
	}
	self.SoundNames["relay_close2"] = "subway_trains/new/relay_4.wav"
	self.SoundNames["relay_close3"] = "subway_trains/new/relay_5.wav"
	self.SoundNames["relay_close4"] = {
		"subway_trains/trains/717/lsd_1.wav",
	}
	self.SoundNames["rvt_close"] = {
		"subway_trains/trains/717/brake_on1.wav",
		"subway_trains/trains/717/brake_on2.wav",
		"subway_trains/trains/717/brake_on3.wav",
	}
	self.SoundNames["r1_5_close"] = {
		"subway_trains/trains/717/drive_on1.wav",
		"subway_trains/trains/717/drive_on2.wav",
	}
	
	self.SoundNames["r1_5_close_ezh"] = {
		"subway_trains/ezh/drive_on.wav",
	}
	
	self.SoundNames["rvt_open"] = {
		"subway_trains/trains/717/brake_off1.wav",
		"subway_trains/trains/717/brake_off2.wav",
		"subway_trains/trains/717/brake_off3.wav",
	}
	self.SoundNames["r1_5_open"] = "subway_trains/trains/717/drive_off.wav"

	self.SoundNames["relay_close5"] = {
	"subway_trains/trains/relay_3.wav",
	"subway_trains/trains/relay_2.wav",
	}
	
	self.SoundNames["door_close1"] = {
		"subway_trains/door_close_7.wav",
		"subway_trains/door_close_8.wav",
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
	self.SoundNames["plomb"] = {
		"subway_trains/new/plomb1.wav",
		"subway_trains/new/plomb2.wav",
	}

	self.SoundNames["door_open_tor"] = {
		"subway_trains/trains/cab_door_open2.wav",
		"subway_trains/trains/cab_door_open.wav",
	}
	
	self.SoundNames["door_close_tor"] = {
		"subway_trains/trains/cab_door_close2.wav",
		"subway_trains/trains/cab_door_close.wav",
	}


	self.SoundNames["compressor_717"]		= "subway_trains/compressor_717_loop.wav"
	self.SoundNames["compressor_717_end"] 	= "subway_trains/compressor_717_end.wav"
	self.SoundNames["compressor_ezh"]		= "subway_trains/compressor_ezh_loop.wav"
	self.SoundNames["compressor_ezh_end"] 	= "subway_trains/compressor_ezh_end.wav"
	self.SoundNames["compressor_e"]		= "subway_trains/compressor_e_loop.wav"
	self.SoundNames["compressor_e_end"] 	= "subway_trains/compressor_e_end.wav"

	self.SoundNames["revers_f"]		= "subway_trains/revers_f.wav"
	self.SoundNames["revers_0"]		= "subway_trains/revers_0.wav"
	self.SoundNames["revers_b"]		= "subway_trains/revers_f.wav"

	self.SoundNames["kru_0_1"]		= "subway_trains/trains/kru_0-1.wav"
	self.SoundNames["kru_1_2"]		= "subway_trains/trains/kru_1-2.wav"
	self.SoundNames["kru_2_1"]		= "subway_trains/trains/kru_2-1.wav"
	self.SoundNames["kru_1_0"]		= "subway_trains/trains/kru_1-0.wav"
	self.SoundNames["kru_2_3"]		= "subway_trains/trains/kru_2-3.wav"
	self.SoundNames["kru_3_2"]		= "subway_trains/trains/kru_3-2.wav"

	self.SoundNames["kv_0_t1"]		= "subway_trains/kv1/kv_0_t1.wav"
	self.SoundNames["kv_t1_0"]		= "subway_trains/kv1/kv_t1_0.wav"
	self.SoundNames["kv_t1_t1a"]	= "subway_trains/kv1/kv_t1_t1a.wav"
	self.SoundNames["kv_t1a_t1"]	= "subway_trains/kv1/kv_t1a_t1.wav"
	self.SoundNames["kv_t1a_t2"]	= "subway_trains/kv1/kv_t1a_t2.wav"
	self.SoundNames["kv_t2_t1a"]	= "subway_trains/kv1/kv_t2_t1a.wav"
	self.SoundNames["kv_0_x1"]		= "subway_trains/kv1/kv_0_x1.wav"
	self.SoundNames["kv_x1_0"]		= "subway_trains/kv1/kv_x1_0.wav"
	self.SoundNames["kv_x1_x2"]		= "subway_trains/kv1/kv_x1_x2.wav"
	self.SoundNames["kv_x2_x1"]		= "subway_trains/kv1/kv_x2_x1.wav"
	self.SoundNames["kv_x2_x3"]		= "subway_trains/kv1/kv_x2_x3.wav"
	self.SoundNames["kv_x3_x2"]		= "subway_trains/kv1/kv_x3_x2.wav"

	self.SoundNames["ezh_kv_0_t1"]		= "subway_trains/kve1/kv_0_t1.wav"
	self.SoundNames["ezh_kv_t1_0"]		= "subway_trains/kve1/kv_t1_0.wav"
	self.SoundNames["ezh_kv_t1_t1a"]	= "subway_trains/kve1/kv_t1_t1a.wav"
	self.SoundNames["ezh_kv_t1a_t1"]	= "subway_trains/kve1/kv_t1a_t1.wav"
	self.SoundNames["ezh_kv_t1a_t2"]	= "subway_trains/kve1/kv_t1a_t2.wav"
	self.SoundNames["ezh_kv_t2_t1a"]	= "subway_trains/kve1/kv_t2_t1a.wav"
	self.SoundNames["ezh_kv_0_x1"]		= "subway_trains/kve1/kv_0_x1.wav"
	self.SoundNames["ezh_kv_x1_0"]		= "subway_trains/kve1/kv_x1_0.wav"
	self.SoundNames["ezh_kv_x1_x2"]		= "subway_trains/kve1/kv_x1_x2.wav"
	self.SoundNames["ezh_kv_x2_x1"]		= "subway_trains/kve1/kv_x2_x1.wav"
	self.SoundNames["ezh_kv_x2_x3"]		= "subway_trains/kve1/kv_x2_x3.wav"
	self.SoundNames["ezh_kv_x3_x2"]		= "subway_trains/kve1/kv_x3_x2.wav"

	for i = 1,10 do
		self.SoundNames["st"..i.."a"] = "subway_trains/new/st"..i.."a.wav"
		self.SoundNames["st"..i.."b"] = "subway_trains/new/st"..i.."b.wav"
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
		"subway_trains/trains/spark.wav",
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

				local ent = self:GetNW2Entity(ent_nwID)
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
function ENT:PlayOnce(soundid,location,range,pitch,randoff)
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
		self:EmitSound(sound, 100*(range or default_range), pitch or (not randoff) and  math.random(95,105) or nil)
	elseif (location == true) or (location == "cabin") then
		if CLIENT then self.DriverSeat = self:GetNW2Entity("seat_driver") end
		if IsValid(self.DriverSeat) then
			self.DriverSeat:EmitSound(sound, 100*(range or default_range),pitch or (not randoff) and  math.random(95,105) or nil)
		end
	elseif (location == true) or (location == "instructor") then
		if CLIENT then self.InstructorsSeat = self:GetNW2Entity("seat_instructor") end
		if IsValid(self.InstructorsSeat) then
			self.InstructorsSeat:EmitSound(sound, 100*(range or default_range),pitch or (not randoff) and  math.random(95,105) or nil)
		end
	elseif location == "front_bogey" then
		if IsValid(self.FrontBogey) then
			self.FrontBogey:EmitSound(sound, 100*(range or default_range),pitch or (not randoff) and  math.random(95,105) or nil)
		end
	elseif location == "rear_bogey" then
		if IsValid(self.RearBogey) then
			self.RearBogey:EmitSound(sound, 100*(range or default_range),pitch or (not randoff) and  math.random(95,105) or nil)
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

	if not Metrostroi.Systems[name] then ErrorNoHalt("No system defined: "..name) return end
	if self.Systems[sys_name] then ErrorNoHalt("System already defined: "..sys_name)  return end

	local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation
	local run_everywhere = Metrostroi.BaseSystems[name].RunEverywhere
	if SERVER and Turbostroi then
		-- Load system into turbostroi
		if (not GLOBAL_SKIP_TRAIN_SYSTEMS) then
			Turbostroi.LoadSystem(sys_name,name,...)
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
	local idx = type(idx) == "number" and 999-idx or idx
	if self._NetData[2][idx] ~= nil and self._NetData[2][idx] == math.floor(value*100) then return end
	self:SetNW2Int(idx,math.floor(value*500))
end

function ENT:GetPackedRatio(idx)
	return self:GetNW2Int(type(idx) == "number" and 999-idx or idx)/500
end

--------------------------------------------------------------------------------
-- Sends and get bool via NWVars
--------------------------------------------------------------------------------
function ENT:SetPackedBool(idx,value)
	if self._NetData[1][idx] ~= nil and self._NetData[1][idx] == value then return end
	self:SetNW2Bool(idx,value)
end

function ENT:GetPackedBool(idx)
	return self:GetNW2Bool(idx)
end
