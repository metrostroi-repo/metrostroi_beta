--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Announcer")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end

function table.GetLastKey(t)
    local lk = -math.huge
    for ki in pairs(t) do
        lk = math.max(lk,ki)
    end
    return lk
end

Metrostroi.Announcements = {
	[0001] = { 0.700, "" },
	[0002] = { 1.500, "" },
	[0003]={ 0.451,       "subway_announcer/00_03.mp3" },
	[0005]={ 0.380,       "subway_announcer/00_05.mp3" },
	[0006]={ 0.271,       "subway_announcer/00_06.mp3" },
	[0007]={ 4.577,       "subway_announcer/00_07.mp3" },
	[0201]={ 1.995,       "subway_announcer/02_01.mp3" },
	[0202]={ 0.600,       "subway_announcer/02_02.mp3" },
	[0203]={ 1.000,       "subway_announcer/02_03.mp3" },
	[0204]={ 2.564,       "subway_announcer/02_04.mp3" },
	[0205]={ 3.385,       "subway_announcer/02_05.mp3" },
	[0206]={ 3.806,       "subway_announcer/02_06.mp3" },
	[0207]={ 3.719,       "subway_announcer/02_07.mp3" },
	[0208]={ 2.980,       "subway_announcer/02_08.mp3" },
	[0209]={ 4.958,       "subway_announcer/02_09.mp3" },
	[0210]={ 2.091,       "subway_announcer/02_10.mp3" },
	[0211]={ 1.603,       "subway_announcer/02_11.mp3" },
	[0212]={ 7.187,       "subway_announcer/02_12.mp3" },
	[0213]={ 4.695,       "subway_announcer/02_13.mp3" },
	[0214]={ 7.750,       "subway_announcer/02_14.mp3" },
	[0215]={ 1.991,       "subway_announcer/02_15.mp3" },
	[0216]={ 1.302,       "subway_announcer/02_16.mp3" },
	[0217]={ 5.846,       "subway_announcer/02_17.mp3" },
	[0218]={ 2.341,       "subway_announcer/02_18.mp3" },
	[0219]={ 1.502,       "subway_announcer/02_19.mp3" },
	[0220]={ 1.039,       "subway_announcer/02_20.mp3" },
	[0221]={ 2.216,       "subway_announcer/02_21.mp3" },
	[0222]={ 3.518,       "subway_announcer/02_22.mp3" },
	[0223]={ 2.154,       "subway_announcer/02_23.mp3" },
	[0224]={ 4.094,       "subway_announcer/02_24.mp3" },
	[0225]={ 3.656,       "subway_announcer/02_25.mp3" },
	[0226]={ 2.950,       "subway_announcer/02_26.mp3" },
	[0227]={ 3.255,       "subway_announcer/02_27.mp3" },
	[0228]={ 4.260,       "subway_announcer/02_28.mp3" },
	[0229]={ 5.334,       "subway_announcer/02_29.mp3" },
	[0230]={ 1.515,       "subway_announcer/02_30.mp3" },
	[0231]={ 1.628,       "subway_announcer/02_31.mp3" },
	[0232]={ 7.149,       "subway_announcer/02_32.mp3" },
	[0233]={ 1.315,       "subway_announcer/02_33.mp3" },
	[0234]={ 1.930,       "subway_announcer/02_34.mp3" },
	[0235]={ 1.407,       "subway_announcer/02_35.mp3" },
	[0236]={ 1.372,       "subway_announcer/02_36.mp3" },
	[0237]={ 1.382,       "subway_announcer/02_37.mp3" },
	[0238]={ 2.805,       "subway_announcer/02_38.mp3" },
	[0308]={ 1.152,       "subway_announcer/03_08.mp3" },
	[0309]={ 1.152,       "subway_announcer/03_09.mp3" },
	[0310]={ 1.152,       "subway_announcer/03_10.mp3" },
	[0311]={ 1.111,       "subway_announcer/03_11.mp3" },
	[0312]={ 1.369,       "subway_announcer/03_12.mp3" },
	[0313]={ 1.272,       "subway_announcer/03_13.mp3" },
	[0314]={ 1.052,       "subway_announcer/03_14.mp3" },
	[0315]={ 1.174,       "subway_announcer/03_15.mp3" },
	[0316]={ 1.296,       "subway_announcer/03_16.mp3" },
	[0317]={ 1.712,       "subway_announcer/03_17.mp3" },
	[0318]={ 1.076,       "subway_announcer/03_18.mp3" },
	[0319]={ 1.377,       "subway_announcer/03_19.mp3" },
	[0320]={ 3.490,       "subway_announcer/03_20.mp3" },
	[0321]={ 0.939,       "subway_announcer/03_21.mp3" },
	[0322]={ 1.174,       "subway_announcer/03_22.mp3" },
	[0323]={ 1.377,       "subway_announcer/03_23.mp3" },
	[0415]={ 1.033,       "subway_announcer/04_15.mp3" },
	[0521]={ 1.518,       "subway_announcer/05_21.mp3" },
	[0522]={ 1.969,       "subway_announcer/05_22.mp3" },
	[0601]={ 1.076,       "subway_announcer/06_01.mp3" },
	[0602]={ 1.521,       "subway_announcer/06_02.mp3" },
	[0603]={ 0.939,       "subway_announcer/06_03.mp3" },
	[0604]={ 0.704,       "subway_announcer/06_04.mp3" },
	[0605]={ 1.330,       "subway_announcer/06_05.mp3" },
	[0606]={ 1.663,       "subway_announcer/06_06.mp3" },
	[0607]={ 1.389,       "subway_announcer/06_07.mp3" },
	[0608]={ 1.663,       "subway_announcer/06_08.mp3" },
	[0699]={ 1.399,       "subway_announcer/06_99.mp3" },
	[0701]={ 1.076,       "subway_announcer/06_01.mp3" },
	[0702]={ 1.064,       "subway_announcer/07_02.mp3" },
	[0703]={ 0.939,       "subway_announcer/06_03.mp3" },
	[0704]={ 1.468,       "subway_announcer/07_04.mp3" },
	[0799]={ 1.585,       "subway_announcer/07_99.mp3" },
	[0801]={ 0.923,       "subway_announcer/08_01.mp3" },

	[9999] = { 3.0,   "subway_announcer/00_00.mp3" },
}
Metrostroi.AnnouncementsPNM = {
	[0003] = { 0.2,       "subway_announcer_pnm/00_03.mp3" },
	[0005] = { 0.2,       "subway_announcer_pnm/00_05.mp3" },
	[0006] = { 0.2,       "subway_announcer_pnm/00_06.mp3" },

	[0201] = { 1.831,       "subway_announcer_pnm/02_01.mp3" },
	[0202] = { 0.570,       "subway_announcer_pnm/02_02.mp3" },
	[0203] = { 0.862,       "subway_announcer_pnm/02_03.mp3" },
	[0204] = { 2.272,       "subway_announcer_pnm/02_04.mp3" },
	[0205] = { 3.090,       "subway_announcer_pnm/02_05.mp3" },
	[0206] = { 3.456,       "subway_announcer_pnm/02_06.mp3" },
	[0207] = { 3.498,       "subway_announcer_pnm/02_07.mp3" },
	[0208] = { 2.936,       "subway_announcer_pnm/02_08.mp3" },
	[0209] = { 5.263,       "subway_announcer_pnm/02_09.mp3" },
	[0210] = { 1.974,       "subway_announcer_pnm/02_10.mp3" },
	[0211] = { 1.392,       "subway_announcer_pnm/02_11.mp3" },
	[0212] = { 6.745,       "subway_announcer_pnm/02_12.mp3" },
	[0213] = { 4.711,       "subway_announcer_pnm/02_13.mp3" },
	[0214] = { 8.162,       "subway_announcer_pnm/02_14.mp3" },
	[0215] = { 1.737,       "subway_announcer_pnm/02_15.mp3" },
	[0216] = { 1.049,       "subway_announcer_pnm/02_16.mp3" },
	[0217] = { 6.213,       "subway_announcer_pnm/02_17.mp3" },
	[0218] = { 2.197,       "subway_announcer_pnm/02_18.mp3" },
	[0219] = { 1.370,       "subway_announcer_pnm/02_19.mp3" },
	[0220] = { 0.889,       "subway_announcer_pnm/02_20.mp3" },
	[0221] = { 2.428,       "subway_announcer_pnm/02_21.mp3" },
	[0222] = { 3.494,       "subway_announcer_pnm/02_22.mp3" },
	[0223] = { 1.971,       "subway_announcer_pnm/02_23.mp3" },
	[0224] = { 4.199,       "subway_announcer_pnm/02_24.mp3" },
	[0225] = { 3.734,       "subway_announcer_pnm/02_25.mp3" },
	[0226] = { 2.984,       "subway_announcer_pnm/02_26.mp3" },
	[0227] = { 3.558,       "subway_announcer_pnm/02_27.mp3" },
	[0228] = { 4.255,       "subway_announcer_pnm/02_28.mp3" },
	[0229] = { 5.224,       "subway_announcer_pnm/02_29.mp3" },
	[0230] = { 1.402,       "subway_announcer_pnm/02_30.mp3" },
	[0231] = { 1.322,       "subway_announcer_pnm/02_31.mp3" },
	[0232] = { 7.107,       "subway_announcer_pnm/02_32.mp3" },
	[0233] = { 1.186,       "subway_announcer_pnm/02_33.mp3" },
	[0234] = { 1.641,       "subway_announcer_pnm/02_34.mp3" },
	[0235] = { 1.145,       "subway_announcer_pnm/02_35.mp3" },
	[0236] = { 1.068,       "subway_announcer_pnm/02_36.mp3" },
	[0237] = { 1.141,       "subway_announcer_pnm/02_37.mp3" },
	[0238] = { 2.580,       "subway_announcer_pnm/02_38.mp3" },

	[0308] = { 1.113,       "subway_announcer_pnm/03_08.mp3" },
	[0309] = { 1.122,       "subway_announcer_pnm/03_09.mp3" },
	[0310] = { 0.938,       "subway_announcer_pnm/03_10.mp3" },
	[0311] = { 0.994,       "subway_announcer_pnm/03_11.mp3" },
	[0312] = { 0.970,       "subway_announcer_pnm/03_12.mp3" },
	[0313] = { 1.098,       "subway_announcer_pnm/03_13.mp3" },
	[0314] = { 0.921,       "subway_announcer_pnm/03_14.mp3" },
	[0315] = { 0.963,       "subway_announcer_pnm/03_15.mp3" },
	[0316] = { 0.929,       "subway_announcer_pnm/03_16.mp3" },
	[0317] = { 1.474,       "subway_announcer_pnm/03_17.mp3" },
	[0318] = { 1.026,       "subway_announcer_pnm/03_18.mp3" },
	[0319] = { 1.120,       "subway_announcer_pnm/03_19.mp3" },
	[0320] = { 3.442,       "subway_announcer_pnm/03_20.mp3" },
	[0321] = { 0.795,       "subway_announcer_pnm/03_21.mp3" },
	[0322] = { 1.240,       "subway_announcer_pnm/03_22.mp3" },
	[0323] = { 1.141,       "subway_announcer_pnm/03_23.mp3" },
	[0415] = { 0.860,       "subway_announcer_pnm/04_15.mp3" },
	[0521] = { 1.162,       "subway_announcer_pnm/05_21.mp3" },
	[0522] = { 1.594,       "subway_announcer_pnm/05_22.mp3" },

	[0601] = { 0.845,       "subway_announcer_pnm/06_01.mp3" },
	[0602] = { 1.261,       "subway_announcer_pnm/06_02.mp3" },
	[0603] = { 0.902,       "subway_announcer_pnm/06_03.mp3" },
	[0604] = { 0.549,       "subway_announcer_pnm/06_04.mp3" },
	[0605] = { 1.290,       "subway_announcer_pnm/06_05.mp3" },
	[0606] = { 1.549,       "subway_announcer_pnm/06_06.mp3" },
	[0607] = { 1.136,       "subway_announcer_pnm/06_07.mp3" },
	[0608] = { 1.557,       "subway_announcer_pnm/06_08.mp3" },
	[0699] = { 1.219,       "subway_announcer_pnm/06_99.mp3" },
	[0701] = { 0.934,       "subway_announcer_pnm/06_01.mp3" },
	[0702] = { 0.934,       "subway_announcer_pnm/07_02.mp3" },
	[0703] = { 0.934,       "subway_announcer_pnm/06_03.mp3" },
	[0704] = { 1.260,       "subway_announcer_pnm/07_04.mp3" },
	[0799] = { 1.329,       "subway_announcer_pnm/07_99.mp3" },
	[0801] = { 0.845,       "subway_announcer_pnm/08_01.mp3" },
}
Metrostroi.AnnouncementSequences = {
	[1101] = { 0211, 0308, 0321 },
	[1102] = { 0211, 0321, 0308 },

	[1108] = { 0220, 0308 },
	[1109] = { 0220, 0309 },
	[1110] = { 0220, 0310, 0231 },
	[1111] = { 0220, 0311 },
	[1112] = { 0220, 0312 },
	[1113] = { 0220, 0313 },
	[1114] = { 0220, 0314 },
	[1115] = { 0220, 0315, 0231, 0202, 0203, 0415 },
	[1116] = { 0220, 0316 },
	[1117] = { 0220, 0317 },
	[1118] = { 0220, 0318, 0231 },
	[1119] = { 0220, 0319 },
	[1120] = { },
	[1121] = { 0220, 0321 },
	[1122] = { 0220, 0322 },
	[1123] = { 0220, 0323 },

	[1208] = { 0218, 0219, 0308 },
	[1209] = { 0218, 0219, 0309 },
	[1210] = { 0218, 0219, 0310 },
	[1211] = { 0218, 0219, 0311 },
	[1212] = { 0218, 0219, 0312 },
	[1213] = { 0218, 0219, 0313 },
	[1214] = { 0218, 0219, 0314 },
	[1215] = { 0218, 0219, 0315 },
	[1216] = { 0218, 0219, 0316 },
	[1217] = { 0218, 0219, 0317 },
	[1218] = { 0218, 0219, 0318 },
	[1219] = { 0218, 0219, 0319 },
	[1220] = { },
	[1221] = { 0218, 0219, 0321 },
	[1222] = { 0218, 0219, 0322 },
	[1223] = { 0218, 0219, 0323 },
}
-- Quick lookup
for k,v in pairs(Metrostroi.Announcements) do
	v[3] = k
end
for k,v in pairs(Metrostroi.AnnouncementsPNM) do
	v[3] = k
end	


--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Initialize()
	for k,v in pairs(Metrostroi.Announcements) do
		util.PrecacheSound(v[2])
	end
	for k,v in pairs(Metrostroi.AnnouncementsPNM) do
		util.PrecacheSound(v[2])
	end

	-- Currently playing announcement
	self.Announcement = 0
	-- End time of the announcement
	self.EndTime = -1e9
	-- Announcement schedule
	self.Schedule = {}
	-- Fake wire 49
	self.Fake48 = 0
end


function TRAIN_SYSTEM:Inputs()
	return { "Queue" }
end
function TRAIN_SYSTEM:Outputs()
	return { "AnnMap" }
end

function TRAIN_SYSTEM:TriggerInput(name,value)
	if (name == "Queue") and (value > 0.0) then
		self:Queue(math.floor(value))
    end
end


function TRAIN_SYSTEM:Queue(id)
	if (not Metrostroi.Announcements[id]) and (not Metrostroi.AnnouncementsPNM[id]) and
		(not Metrostroi.AnnouncementSequences[id]) then return end
	if self.Train and self.Train.SubwayTrain.Name and self.Train.SubwayTrain.Name:sub(1,-2) ~= "81-71" and
		(id == 5 or id == 6) then return end
	-- Add announcement to queue
	if #self.Schedule < 16 then
		if Metrostroi.AnnouncementSequences[id] then
			for k,i in pairs(Metrostroi.AnnouncementSequences[id]) do
				self:Queue(i)
			end
		else
			local tbl = Metrostroi["Announcements" .. (self.Train.PNM and "PNM" or "")][id] or Metrostroi.Announcements[id]
			--print(Metrostroi["Announcements" .. (self.Train.PNM and "PNM" or "")][id])
			table.insert(self.Schedule, tbl)
		end
	end
end


function TRAIN_SYSTEM:ClientInitialize()
end

function TRAIN_SYSTEM:ClientThink()
	local active = self.Train:GetNWBool("BPSNBuzz",false) and self.Train:GetPackedBool(52)
	local btype = self.Train:GetNWBool("BPSNBuzzType",false)
	self.Train:SetSoundState("bpsn_ann",(active and  not btype and (self.Train:GetPackedBool(127) or self.Train:GetPackedBool(132))) and 0.175 or 0,1)
	self.Train:SetSoundState("bpsn_ann_cab",(active and  not btype and self.Train:GetPackedBool(125)) and 0.175 or 0,1)
	self.Train:SetSoundState("bpsn_ann_pnm",(active and  btype and (self.Train:GetPackedBool(127) or self.Train:GetPackedBool(132))) and 0.175 or 0,1)
	self.Train:SetSoundState("bpsn_ann_pnm_cab",(active and  btype and self.Train:GetPackedBool(125)) and 0.175 or 0,1)
end

function TRAIN_SYSTEM:MultiQuele(...)
	for _,v in pairs({...}) do
		local v = tonumber(v)
		if v ~= nil then
			if Metrostroi.AnnouncerData[v] then
				self:Queue(tonumber(tostring(v):sub(-3,-1)) + 200)
			else
				self:Queue(v)
			end
		end
	end
end

function TRAIN_SYSTEM:Think()
	-- Check if new announcement must be started from train wire
	local targetAnnouncement = self.Train:ReadTrainWire(48)
	if targetAnnouncement < 0 then targetAnnouncement = 0 end
	local onlyCabin = false
	if (targetAnnouncement == 0) then targetAnnouncement = self.Fake48 or 0  onlyCabin = true end
	if (targetAnnouncement > 0) and (targetAnnouncement ~= self.Announcement) and (CurTime() > self.EndTime) then
		self.Announcement = targetAnnouncement
		local tbl = Metrostroi["Announcements" .. (self.Train.PNM and "PNM" or "")][targetAnnouncement] or Metrostroi.Announcements[targetAnnouncement]
		if tbl then
			--if not Metrostroi["Announcements" .. (self.Train.PNM and "PNM" or "")][targetAnnouncement] then print(targetAnnouncement) end
			self.Sound = tbl[2]
			self.EndTime = CurTime() + tbl[1]

			-- Emit the sound
			if self.Sound ~= "" then
				if self.Train.DriverSeat and (self.Train.R_G.Value > 0.5) then
					self.Train.DriverSeat:EmitSound(self.Sound, 73, 100)
				end
				if onlyCabin == false then
					self.Train:EmitSound(self.Sound, 85, 100)
				end
				if (self.Announcement == 0206) or
				   (self.Announcement == 0207) or
				   (self.Announcement == 0212) or
				   (self.Announcement == 0221) or
				   (self.Announcement == 0224) then
					self.Train.AnnouncementToLeaveWagon = true
					self.Train.AnnouncementToLeaveWagonAcknowledged = false
				--else
					--self.Train.AnnouncementToLeaveWagon = false
				end
				if self.Train:GetNWFloat("PassengerCount") == 0 then
					self.Train.AnnouncementToLeaveWagon = false
				end
			end
			
			-- BPSN buzz
			if targetAnnouncement == 5 and self.Train.PNM then timer.Simple(0.1,function() self.Train:SetNWBool("BPSNBuzz",true) end) end
			if targetAnnouncement == 5 and not self.Train.PNM then timer.Simple(0.2,function() self.Train:SetNWBool("BPSNBuzz",true) end) end
			if targetAnnouncement == 6 then
				self.Train:SetNWBool("BPSNBuzz",false)
					--[[
					if self.Train.PNM then
					self.Train:SetNWBool("BPSNBuzz",false)
					self.BPSNBuzzTimeout1 = CurTime() + 0
				else
					self.BPSNBuzzTimeout1 = CurTime() + 0.4
					--timer.Simple(0.4,function() if not IsValid(self.Train) then return end self.Train:SetNWBool("BPSNBuzz",false) end)
				end
				]]
			end
			self.BPSNBuzzTimeout = CurTime() + 10.0
		end
	elseif (targetAnnouncement == 0) then
		self.Announcement = 0
	end

	-- Buzz timeout
	if self.BPSNBuzzTimeout and (CurTime() > self.BPSNBuzzTimeout) then
		self.BPSNBuzzTimeout = nil
		self.Train:SetNWBool("BPSNBuzz",false)
	end
	if self.BPSNBuzzTimeout1 and (CurTime() > self.BPSNBuzzTimeout1) then
		self.BPSNBuzzTimeout1 = nil
		self.Train:SetNWBool("BPSNBuzz",false)
	end

	-- Check if new announcement must be started from schedule
	if (self.ScheduleAnnouncement == 0) and (self.Schedule[1]) then
		self.ScheduleAnnouncement = self.Schedule[1][3]
		self.ScheduleEndTime = CurTime() + self.Schedule[1][1]
		table.remove(self.Schedule,1)
	end


	-- Check if schedule announcement is playing
	if self.ScheduleAnnouncement ~= 0 then
		if self.Train.DriverSeat and ((self.Train.R_ZS and self.Train.R_ZS.Value < 0.5) or (self.Train.R_UPO and self.Train.R_UPO.Value < 0.5)) then
			self.Fake48 = self.ScheduleAnnouncement
		else
			self.Train:WriteTrainWire(48,self.ScheduleAnnouncement)
			self.Fake48 = 0
		end
		if CurTime() > (self.ScheduleEndTime or -1e9) then
			self.ScheduleAnnouncement = 0
			self.Fake48 = 0
			self.Train:WriteTrainWire(48,0)
		end
	end
	if self.Train.R_ZS and self.Train.KV then
		if self.Train.R_ZS.Value < 0.5 and self.Train.KV.ReverserPosition == 1.0 then
			self.Train:WriteTrainWire(48,-1)
		elseif self.Train:ReadTrainWire(48) == -1 then
			self.Train:WriteTrainWire(48,0)
		end
		return
	end
end
