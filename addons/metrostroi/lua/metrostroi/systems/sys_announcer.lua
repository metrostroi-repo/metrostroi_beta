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
	[0003] = { 1.123, "subway_announcer/00_03.mp3" },
	[0004] = { 3.109, "subway_announcer/00_04.mp3" },
	[0005] = { 0.200, "subway_announcer/00_05.mp3" },
	[0006] = { 0.800, "subway_announcer/00_06.mp3" },

	[0101] = { 2.194, "subway_announcer/01_01.mp3" },
	[0102] = { 1.202, "subway_announcer/01_02.mp3" },
	[0103] = { 2.351, "subway_announcer/01_03.mp3" },
	[0104] = { 1.463, "subway_announcer/01_04.mp3" },
	[0105] = { 8.385, "subway_announcer/01_05.mp3" },
	[0106] = { 4.963, "subway_announcer/01_06.mp3" },
	[0107] = { 4.963, "subway_announcer/01_07.mp3" },
	[0108] = { 7.784, "subway_announcer/01_08.mp3" },
	[0109] = { 4.624, "subway_announcer/01_09.mp3" },

	[0201] = { 2.038, "subway_announcer/02_01.mp3" },
	[0202] = { 0.701, "subway_announcer/02_02.mp3" },
	[0203] = { 0.995, "subway_announcer/02_03.mp3" },
	[0204] = { 2.562, "subway_announcer/02_04.mp3" },
	[0205] = { 3.428, "subway_announcer/02_05.mp3" },
	[0206] = { 3.946, "subway_announcer/02_06.mp3" },
	[0207] = { 3.648, "subway_announcer/02_07.mp3" },
	[0208] = { 3.033, "subway_announcer/02_08.mp3" },
	[0209] = { 5.298, "subway_announcer/02_09.mp3" },
	[0210] = { 1.972, "subway_announcer/02_10.mp3" },
	[0211] = { 1.611, "subway_announcer/02_11.mp3" },
	[0212] = { 7.345, "subway_announcer/02_12.mp3" },
	[0213] = { 4.756, "subway_announcer/02_13.mp3" },
	[0214] = { 7.926, "subway_announcer/02_14.mp3" },
	[0215] = { 2.133, "subway_announcer/02_15.mp3" },
	[0216] = { 1.470, "subway_announcer/02_16.mp3" },
	[0217] = { 5.981, "subway_announcer/02_17.mp3" },
	[0218] = { 2.639, "subway_announcer/02_18.mp3" },
	[0219] = { 1.460, "subway_announcer/02_19.mp3" },
	[0220] = { 1.122, "subway_announcer/02_20.mp3" },
	[0221] = { 2.317, "subway_announcer/02_21.mp3" },
	[0222] = { 3.468, "subway_announcer/02_22.mp3" },
	[0223] = { 2.243, "subway_announcer/02_23.mp3" },
	[0224] = { 4.114, "subway_announcer/02_24.mp3" },
	[0225] = { 3.900, "subway_announcer/02_25.mp3" },
	[0226] = { 3.160, "subway_announcer/02_26.mp3" },
	[0227] = { 3.272, "subway_announcer/02_27.mp3" },
	[0228] = { 4.383, "subway_announcer/02_28.mp3" },
	[0229] = { 5.577, "subway_announcer/02_29.mp3" },
	[0230] = { 1.596, "subway_announcer/02_30.mp3" },
	[0231] = { 1.643, "subway_announcer/02_31.mp3" },
	[0232] = { 7.295, "subway_announcer/02_32.mp3" },
	[0233] = { 1.710, "subway_announcer/02_33.mp3" },

	[0308] = { 1.276, "subway_announcer/03_08.mp3" },
	[0309] = { 1.239, "subway_announcer/03_09.mp3" },
	[0310] = { 1.327, "subway_announcer/03_10.mp3" },
	[0311] = { 1.274, "subway_announcer/03_11.mp3" },
	[0312] = { 1.487, "subway_announcer/03_12.mp3" },
	[0313] = { 1.387, "subway_announcer/03_13.mp3" },
	[0314] = { 1.217, "subway_announcer/03_14.mp3" },
	[0315] = { 1.285, "subway_announcer/03_15.mp3" },
	[0316] = { 1.301, "subway_announcer/03_16.mp3" },
	[0317] = { 1.657, "subway_announcer/03_17.mp3" },
	[0318] = { 1.261, "subway_announcer/03_18.mp3" },
	[0319] = { 1.306, "subway_announcer/03_19.mp3" },
	[0320] = { 3.542, "subway_announcer/03_20.mp3" },
	[0321] = { 1.033, "subway_announcer/03_21.mp3" },
	[0322] = { 1.317, "subway_announcer/03_22.mp3" },
	[0323] = { 1.289, "subway_announcer/03_23.mp3" },

	[0415] = { 1.210, "subway_announcer/04_15.mp3" },

	[0521] = { 1.476, "subway_announcer/05_21.mp3" }, -- Yes, these are swapped.
	[0522] = { 1.777, "subway_announcer/05_22.mp3" }, -- It is supposed to be so!

	[0601] = { 1.393, "subway_announcer/06_01.mp3" },
	[0602] = { 0.922, "subway_announcer/06_02.mp3" },
	[0603] = { 0.576, "subway_announcer/06_03.mp3" },
	[0604] = { 0.968, "subway_announcer/06_04.mp3" },
	[0605] = { 1.337, "subway_announcer/06_05.mp3" },
	[0606] = { 1.614, "subway_announcer/06_06.mp3" },
	[0607] = { 1.290, "subway_announcer/06_07.mp3" },
	[0608] = { 1.518, "subway_announcer/06_08.mp3" },
	[0701] = { 0.876, "subway_announcer/07_01.mp3" },
	[0702] = { 1.407, "subway_announcer/07_02.mp3" },
	[0703] = { 0.922, "subway_announcer/06_02.mp3" },

	[0699] = { 1.326, "subway_announcer/06_99.mp3" },
	[0799] = { 1.589, "subway_announcer/07_99.mp3" },
 
 
	[9999] = { 3.0,   "subway_announcer/00_00.mp3" },
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
--[[
Metrostroi.AnnouncementSequenceNames = {
	[1108] = "Avtozavodskaya",
	[1109] = "Industrial'naya",
	[1110] = "Moskovskaya",
	[1111] = "Oktyabrs'kaya",
	[1112] = "Ploschad' Myra",
	[1113] = "Novoarmeyskaya",
	[1114] = "Vokzalnaya",
	[1115] = "Komsomol'skaya",
	[1116] = "Elektrosila",
	[1117] = "Teatral'naya Ploshad",
	[1118] = "Park Pobedy",
	[1119] = "Sineozernaya",
	[1120] = "Lesnaya",
	[1121] = "Minskaya",
	[1122] = "Tsarskiye Vorota",
	[1123] = "Mezhdustroyskaya",
}
]]
-- Quick lookup
for k,v in pairs(Metrostroi.Announcements) do
	v[3] = k
end

--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
Metrostroi.AnnouncerData =
{
	[108] = {"Avtozavodskaya",          		false,false ,false,true,false,0   },
	[109] = {"Industrial'naya",         		false,true ,false,false,false,0   },
	[110] = {"Moskovskaya",             		true ,false,false,true ,false,0   },
	[111] = {"Oktyabrs'kaya",           		false,false,true ,false,false,0   },
	[112] = {"Ploschad' Myra",          		false,false,false,true ,false,0   },
	[113] = {"Novoarmeyskaya",          	false,true ,true ,false,false,0   },
	[114] = {"Vokzalnaya",						false,false,true ,false,false,0   },
	[115] = {"Komsomol'skaya",        		true ,true ,false,false,false,1215},
	[116] = {"Elektrosila",             			false,false,false,true ,false,0   },
	[117] = {"Teatral'naya Ploshad'",		false,false,true ,false,false,0   },
	[118] = {"Park Pobedy",             		true,false ,false,true ,false,0   },
	[119] = {"Sineozernaya",            		false,true ,false,false,false,0   },
	[120] = { },
	[121] = {"Minskaya",                		false,false,true,true  ,false,0   },
	[122] = {"Tsarskiye Vorota",        		false,true,true,true   ,false,0   ,1},
	[123] = {"Mezhdustroyskaya",        	true,true,true,true    ,false,0   },
	[321] = {"Muzey Skulptur",		    	false,true,true,true   ,false,0   },
	[322] = {"Avtostanciya Yuzhnaya",		false,true,true,true   ,false,0   },
	[1215] = {"Leninskaya" },
	--ORANGE LINE
	[401] = {"Slavnaya Strana",           	false,false,true ,false,false,0   },
	[402] = {"Litievaya",          				false,false,false,true ,false,699   },
	[403] = {"Park",          						true ,true ,true ,false,false,0   },
	[404] = {"Masterskaya",              		true ,false,true ,false,false,0   },
	[405] = {"GFCScape",          				true ,true ,false,false,false,0},
	[406] = {"Im. Uollesa Brina",           	false,false,false,true ,true,0   },
	[407] = {"VHE'",   							false,false,true ,false,false,0   },
	[408] = {"Truzennikov Garry's mod'a",  false,false,false,true ,true,0   ,nil ,1},
	[501] = {"Aeroport",               			true ,false,true,true  ,false,0   },
	[502] = {"Fabriki SENT",        			true ,true,true,true   ,true,0   },
	[503] = {"Litievaya",        					false,true,true,true   ,false,799   },
}
Metrostroi.PathConverter = {
	[1] = 1,
	[2] = 2,
	[29] = 1,
	[30] = 2,
}
Metrostroi.WorkingStations = {
	["gm_metrostroi"] = {
		{108,109,110,111,112,113,114,115,116,117,118,119,121,122,123},
		{108,109,110,111,112,113,114,115,116,117,118,119,121,122,321,322},
	},
	["gm_metrostroi_lite"] = {
		{108,109,110,111,112,113,114},
	},
	["gm_orange"] = {
		{401,402,403,404,405,406,407,408},
		{501,502,503},
	},
	["gm_orange_lite"] = {
		{403,404,405,406,407,408},
	},
}
for k, v in pairs(Metrostroi.WorkingStations) do
	for k1, v1 in pairs(v) do
		for k2, v2 in pairs(v1) do
			Metrostroi.WorkingStations[k][k1][v2] = k2
		end
	end
end

Metrostroi.EndStations = {
	["gm_metrostroi"] = {
		{108,111,114,121,123},
		{108,111,114,121,322},
	},
	["gm_metrostroi_lite"] = {
		{108,111,114},
	},
	["gm_orange"] = {
		{401,403,406,408},
		{501,503},
	},
	["gm_orange_lite"] = {
		{403,406,408},
	},
}
for k, v in pairs(Metrostroi.EndStations) do
	for k1, v1 in pairs(v) do
		for k2, v2 in pairs(v1) do
			Metrostroi.EndStations[k][k1][v2] = k2
		end
	end
end
Metrostroi.PlayingStyles = {"Moscow","St. Petersburg","Kiev"}

--------------------------------------------------------------------------------
function TRAIN_SYSTEM:Initialize()
	for k,v in pairs(Metrostroi.Announcements) do
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

	--Map
	self.AnnMap = ""
	local Map = game.GetMap() or ""
	if Map:find("gm_metrostroi") and Map:find("lite") then
		self.AnnMap = "gm_metrostroi_lite"
	elseif Map:find("gm_metrostroi") then
		self.AnnMap = "gm_metrostroi"
	elseif Map:find("gm_mus_orange_line") and Map:find("long") then
		self.AnnMap = "gm_orange"
	elseif Map:find("gm_mus_orange_line") then
		self.AnnMap = "gm_orange_lite"
	end
	if(Metrostroi.EndStations[self.AnnMap]) then
		self.Settings = {
			Route = 1,
			StartStationT = 1,
			State = nil,
			StartStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute or 1][1],
			EndStationT = #Metrostroi.EndStations,
			EndStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute or 1][#Metrostroi.EndStations[self.AnnMap][self.AnnRoute or 1]],
			Path = 1,
			Style = 1,
			StationT = 1,
			CurTime = CurTime(),
			Arrive = true,
		}
	end 
	self.AnnCurTimeM = 0
	self.AnnCurTimeM1 = 0
	self.AnnChars = "abcdefghijklmnopqrstuvwxyz1234567890-=\\+/."
	self.AnnSeq = "/-\\:"
	self.AnnStationT = 1
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
	if (not Metrostroi.Announcements[id]) and
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
			table.insert(self.Schedule, Metrostroi.Announcements[id])
		end
	end
end


function TRAIN_SYSTEM:ClientInitialize()
	self.AnnMap = ""
	local Map = game.GetMap() or ""
	if Map:find("gm_metrostroi") and Map:find("lite") then
		self.AnnMap = "gm_metrostroi_lite"
	elseif Map:find("gm_metrostroi") then
		self.AnnMap = "gm_metrostroi"
	elseif Map:find("gm_mus_orange_line") and Map:find("long") then
		self.AnnMap = "gm_orange"
	elseif Map:find("gm_mus_orange_line") then
		self.AnnMap = "gm_orange_lite"
	end
end
function TRAIN_SYSTEM:ClientThink()
	local active = self.Train:GetNWBool("BPSNBuzz",false) and self.Train:GetPackedBool(52)
	self.Train:SetSoundState("bpsn_ann",(active and (self.Train:GetPackedBool(127) or self.Train:GetPackedBool(132))) and 0.175 or 0,1)
	self.Train:SetSoundState("bpsn_ann_cab",(active and self.Train:GetPackedBool(125)) and 0.175 or 0,1)
end

function TRAIN_SYSTEM:PlayInfQueueSounds(...)
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

function TRAIN_SYSTEM:Announcer1()
	if self.Train.R_Radio and (self.Train.R_Radio.Value > 0.5) then
		-- Startup
		if self.Radioinformator == 0 then
			self:Queue(0005)
			self:Queue(0201)
			self:Queue(0006)
			self.Radioinformator = 100
			self.Radiotimer = CurTime()+5.0

			self.Train:SetNWString("CustomStr2","Prev(Depart)")
			self.Train:SetNWString("CustomStr3","Select")
			self.Train:SetNWString("CustomStr4","")
			self.Train:SetNWString("CustomStr5","Next(Arrive)")
			self.Train:SetNWString("CustomStr6","F1")
			self.Train:SetNWString("CustomStr7","F2")
			self.Train:SetNWString("CustomStr8","F3")
			self.Train:SetNWString("CustomStr9","F4")
			self.Train:SetNWString("CustomStr10","")
			self.Train:SetNWString("CustomStr11","")
			self.Train:SetNWString("CustomStr12","Enable")
			self.Train:SetNWString("CustomStr13","Silent")
		end
		if self.Radioinformator == 100 then
			if (CurTime() > self.Radiotimer) then
				self.Radioinformator = 101
			end
		end
		if self.Radioinformator == 101 then
			self.Radioinformator = 1
			self.SelectedMessage = 1108
			self.Train:SetNWString("CustomStr0","SELECT START STATION")
		end
		-- Select starting station
		if self.Radioinformator == 1 then
			if self.Train.Custom4.Value > 0.5 then
				self.Radioinformator = 91
				self.SelectedMessage = self.SelectedMessage + 1
				if self.SelectedMessage > 1123 then self.SelectedMessage = 1108 end
			end
			if self.Train.Custom1.Value > 0.5 then
				self.Radioinformator = 91
				self.SelectedMessage = self.SelectedMessage - 1
				if self.SelectedMessage < 1108 then self.SelectedMessage = 1123 end
			end
			if self.Train.Custom2.Value > 0.5 then
				self.Radioinformator = 2
				self.Train:SetNWString("CustomStr0","SELECT DIRECTION")
				self.Train:SetNWString("CustomStr1","AVTOZAV -> MINSKAYA")
				self.SelectedDirection = 1
			end
		end
		-- Stop
		if self.Radioinformator == 2 then
			if self.Train.Custom2.Value < 0.5 then
				self.Radioinformator = 3
			end
		end
		-- Select direction
		if self.Radioinformator == 3 then
			if self.Train.Custom1.Value > 0.5 then
				self.Train:SetNWString("CustomStr1","AVTOZAV -> MINSKAYA")
				self.SelectedDirection = 1
				self:Queue(0005)
				self:Queue(1101)
				self:Queue(0006)
				self.Radioinformator = 93
			end
			if self.Train.Custom4.Value > 0.5 then
				self.Train:SetNWString("CustomStr1","MINSKAYA -> AVTOZAV")
				self.SelectedDirection = -1
				self:Queue(0005)
				self:Queue(1102)
				self:Queue(0006)
				self.Radioinformator = 93
			end
			if self.Train.Custom2.Value > 0.5 then
				self.RadioX = 0
				self.Radioinformator = 4
				self.Train:SetNWString("CustomStr0","")
				self.Train:SetNWString("CustomStr1","")
			end
		end
		-- Stop
		if self.Radioinformator == 4 then
			if self.Train.Custom2.Value < 0.5 then
				self.Radioinformator = 5
			end
		end
		-- Working
		if self.Radioinformator == 5 then
			if (self.Train.Custom4.Value > 0.5) then
				if self.Train.CustomC.Value < 0.5 then
					self:Queue(0005)
					self:Queue(self.SelectedMessage)
					self:Queue(0006)
				end
				self.Radioinformator = 95
				self.RadioX = 0

				self.SelectedMessage = self.SelectedMessage + self.SelectedDirection
				if self.SelectedMessage == 1120 then self.SelectedMessage = self.SelectedMessage + self.SelectedDirection end
				if self.SelectedMessage > 1123 then self.SelectedMessage = 1108 end
				if self.SelectedMessage < 1108 then self.SelectedMessage = 1123 end
			end
			if (self.Train.Custom1.Value > 0.5) then
				if self.Train.CustomC.Value < 0.5 then
					self:Queue(0005)
					self:Queue(100+self.SelectedMessage)
					self:Queue(0006)
				end
				self.Radioinformator = 95
				self.RadioX = 0
			end
			if self.Train.Custom3.Value > 0.5 then self:Queue(0005) self:Queue(0217) 				self:Queue(0006) self.Radioinformator = 95 self.RadioX = 0 end
			if self.Train.Custom5.Value > 0.5 then self:Queue(0005) self:Queue(0212+12*self.RadioX) self:Queue(0006) self.Radioinformator = 95 self.RadioX = 1 end
			if self.Train.Custom6.Value > 0.5 then self:Queue(0005) self:Queue(0206+self.RadioX)	self:Queue(0006) self.Radioinformator = 95 self.RadioX = 0 end
			if self.Train.Custom7.Value > 0.5 then self:Queue(0005) self:Queue(0208+self.RadioX)	self:Queue(0006) self.Radioinformator = 95 self.RadioX = 1 end
			if self.Train.Custom8.Value > 0.5 then self:Queue(0005) self:Queue(0204+self.RadioX)	self:Queue(0006) self.Radioinformator = 95 self.RadioX = 1 end
		end

		-- Return to menu
		if self.Radioinformator == 91 then
			if (self.Train.Custom1.Value < 0.5) and (self.Train.Custom4.Value < 0.5) then
				self.Radioinformator = 1
			end
		end
		if self.Radioinformator == 93 then
			if (self.Train.Custom1.Value < 0.5) and (self.Train.Custom4.Value < 0.5) then
				self.Radioinformator = 3
			end
		end
		if self.Radioinformator == 95 then
			if (self.Train.Custom1.Value < 0.5) and (self.Train.Custom4.Value < 0.5) and (self.Train.Custom3.Value < 0.5) and
				(self.Train.Custom5.Value < 0.5) and (self.Train.Custom6.Value < 0.5) and
				(self.Train.Custom7.Value < 0.5) and (self.Train.Custom8.Value < 0.5) then
				self.Radioinformator = 5
			end
		end

		-- Display message
		if self.DisplayedMessage1 ~= self.SelectedMessage then
			self.DisplayedMessage1 = self.SelectedMessage
			self.Train:SetNWString("CustomStr1",
				Format("%04d%s",self.DisplayedMessage1,(Metrostroi.AnnouncementSequenceNames[self.DisplayedMessage1] or "")))
		end
		if self.DisplayedMessage2 ~= self.Announcement then
			self.DisplayedMessage2 = self.Announcement
			if self.DisplayedMessage2 > 0 then
				self.Train:SetNWString("CustomStr0",Format("PLAYING ANN %04d",self.DisplayedMessage2))
			else
				self.Train:SetNWString("CustomStr0","")
			end
		end
	else
		if self.Radioinformator ~= 0 then
			self.Train:SetNWString("CustomStr0","")
			self.Train:SetNWString("CustomStr1","")
			self.Train:SetNWString("CustomStr2","")
			self.Train:SetNWString("CustomStr3","")
			self.Train:SetNWString("CustomStr4","")
			self.Train:SetNWString("CustomStr5","")
			self.Train:SetNWString("CustomStr6","")
			self.Train:SetNWString("CustomStr7","")
			self.Train:SetNWString("CustomStr8","")
			self.Train:SetNWString("CustomStr9","")
			self.Train:SetNWString("CustomStr10","")
			self.Train:SetNWString("CustomStr11","")
			self.Train:SetNWString("CustomStr12","")
			self.Train:SetNWString("CustomStr13","")
		end
		self.Radioinformator = 0
	end
end

function TRAIN_SYSTEM:AnnNotLast()
    return 	(self.AnnStartStationT > 1 and self.AnnPath == 2) or
			(self.AnnEndStationT < #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] and self.AnnPath == 1)
end

function TRAIN_SYSTEM:AnnEnd(next)
	local station
	if next then
		station = self.AnnNext
	else
		station = self.AnnStation
	end
	if not station then return false end
    return (not Metrostroi.AnnouncerData[station][9]) and ((station <= self.AnnStartStation and self.AnnPath == 2) or
			(station >= self.AnnEndStation and self.AnnPath == 1)), Metrostroi.AnnouncerData[station][9]
end

function TRAIN_SYSTEM:AnnPlayArriving()
    self:PlayInfQueueSounds(0005)

    if self.AnnStyle == 1 then
        self:PlayInfQueueSounds(0220,self.AnnStation)
        if Metrostroi.AnnouncerData[self.AnnStation][2] then
            self:PlayInfQueueSounds(0231)
        end

        if Metrostroi.AnnouncerData[self.AnnStation][7] > 0 then
            self:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[self.AnnStation][7]] and 0203 or nil,Metrostroi.AnnouncerData[self.AnnStation][7])	
        end

        if self:AnnEnd() then
            self:PlayInfQueueSounds(0224,0002,0230,0226,0006)
			self.AnnState = 7
            return
        end
		if Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0223,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
		end
        if Metrostroi.AnnouncerData[self.AnnStation][4] then
			if not (Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8]) then self:PlayInfQueueSounds(0230) end
            self:PlayInfQueueSounds(math.random() > 0.5 and 0226 or nil,0227)
        end
    elseif self.AnnStyle == 2 then
        self:PlayInfQueueSounds(0003)
        if self:AnnEnd() then
            self:PlayInfQueueSounds(0230,0222,0002,0221,self.AnnStation)
            if Metrostroi.AnnouncerData[self.AnnStation][2] then
                self:PlayInfQueueSounds(0215)
            end
            self:PlayInfQueueSounds(0006)
			self.AnnState = 7
            return
        end

		self:PlayInfQueueSounds(Metrostroi.AnnouncerData[self.AnnStation][6] and 0220 or nil,self.AnnStation)
        if Metrostroi.AnnouncerData[self.AnnStation][2] then
            self:PlayInfQueueSounds(0215)
        end

        if Metrostroi.AnnouncerData[self.AnnStation][7] > 0 then
            self:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[self.AnnStation][7]] and 0203 or nil,Metrostroi.AnnouncerData[self.AnnStation][7])
        end

		if Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end

        if self.NextNonWorkingStation then
            self:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
        end
        self:PlayInfQueueSounds(0002,0219,self.AnnNext)
        if Metrostroi.AnnouncerData[self.AnnNext][2] then
            self:PlayInfQueueSounds(0215)
        end

        if Metrostroi.AnnouncerData[self.AnnNext][7] > 0 then
            self:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[self.AnnNext][7]] and 0203 or nil,Metrostroi.AnnouncerData[self.AnnNext][7])
        end

		if Metrostroi.AnnouncerData[self.AnnNext][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnNext][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end
    else
        self:PlayInfQueueSounds(0220,self.AnnStation)
        if Metrostroi.AnnouncerData[self.AnnStation][2] then
            self:PlayInfQueueSounds(0215)
        end
        if Metrostroi.AnnouncerData[self.AnnStation][7] > 0 then
            self:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[self.AnnStation][7]] and 0203 or nil,Metrostroi.AnnouncerData[self.AnnStation][7])
        end

        if self:AnnEnd() then
            self:PlayInfQueueSounds(0212,0006)
			self.AnnState = 7
            return
        end
		if Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end
        if Metrostroi.AnnouncerData[self.AnnStation][4] then
            if not (Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8]) then self:PlayInfQueueSounds(0230) end
            self:PlayInfQueueSounds(0226)
        end

    end
    self:PlayInfQueueSounds(0006)
end

function TRAIN_SYSTEM:AnnPlayDepeate()
    self:PlayInfQueueSounds(0005)

    if self.AnnStyle == 1 then
        if self:AnnNotLast() then
            self:PlayInfQueueSounds(0223,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
        elseif Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0223,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
		end
        if self.NextNonWorkingStation then
            self:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
        end
        self:PlayInfQueueSounds(0218,0219,self.AnnNext)
        if Metrostroi.AnnouncerData[self.AnnNext][2] then
            self:PlayInfQueueSounds(0231)
        end
		if Metrostroi.AnnouncerData[self.AnnNext][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnNext][8] then
            self:PlayInfQueueSounds(0230,0233,0223,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end
        if Metrostroi.AnnouncerData[self.AnnStation][3] then
			if not (Metrostroi.AnnouncerData[self.AnnNext][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnNext][8]) then self:PlayInfQueueSounds(0230) end
            self:PlayInfQueueSounds(0232)
        end
    elseif self.AnnStyle == 2 then
        self:PlayInfQueueSounds(0003)
        if self:AnnNotLast() then
            self:PlayInfQueueSounds(0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
        elseif Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
		end
        self:PlayInfQueueSounds(0218)

        if self.NextNonWorkingStation then
            self:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
        end
        self:PlayInfQueueSounds(0219,self.AnnNext)
        if Metrostroi.AnnouncerData[self.AnnNext][2] then
            self:PlayInfQueueSounds(0215)
        end

        if Metrostroi.AnnouncerData[self.AnnNext][7] > 0 then
            self:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[self.AnnNext][7]] and 0203 or nil,Metrostroi.AnnouncerData[self.AnnNext][7])
        end
		if Metrostroi.AnnouncerData[self.AnnNext][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnNext][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end
    else
        if self:AnnNotLast() then
            self:PlayInfQueueSounds(0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
        elseif Metrostroi.AnnouncerData[self.AnnStation][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnStation][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation,0002)
		end

        if self.NextNonWorkingStation then
            self:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
        end

        self:PlayInfQueueSounds(0218,0219,self.AnnNext)
        if Metrostroi.AnnouncerData[self.AnnNext][2] then
            self:PlayInfQueueSounds(0215)
        end
		if Metrostroi.AnnouncerData[self.AnnNext][8] and self.AnnPath == Metrostroi.AnnouncerData[self.AnnNext][8] then
            self:PlayInfQueueSounds(0230,0233,0210,self.AnnPath == 1 and self.AnnEndStation or self.AnnStartStation)
		end
        if Metrostroi.AnnouncerData[self.AnnNext][3] then
            self:PlayInfQueueSounds(0214)
        end
        if Metrostroi.AnnouncerData[self.AnnNext][5] then
            self:PlayInfQueueSounds(0213)
        end
    end
    self:PlayInfQueueSounds(0006)
end

function TRAIN_SYSTEM:AnnII()
    self:PlayInfQueueSounds(0005)
    if self.AnnStyle == 2 then
        self:PlayInfQueueSounds(0003)
	end
	if self.AnnState == 8 then
		self:PlayInfQueueSounds(math.random() > 0.5 and 0207 or 0206)
	else
		if self.Arrive then
			self:PlayInfQueueSounds(math.random() > 0.5 and 0209 or 0208)
		else
			if self.Train.Panel["SD"] <= 0.5 then
				self:PlayInfQueueSounds(math.random() > 0.5 and 0204 or 0205)
			else
				if not self.AnnIIalr then
					self:PlayInfQueueSounds(self.Type == 1 and 0229 or 0217)
					self.AnnIIalr = true
				else
					self:PlayInfQueueSounds(0228)
					self.AnnIIalr = false
				end
			end
		end
	end
    self:PlayInfQueueSounds(0006)
end

local function PrintToConsole( str )
	if not DEBUG_ANNOUNCER then return end
	print("[Announcer Debug]:"..str)
	--print(utf8toibm866(str))
end

function TRAIN_SYSTEM:GetLastWagon()
	PrintToConsole("Полуение вагонов в составе...")
	self.Train:UpdateWagonList()
	return self.Train.WagonList[#self.Train.WagonList]
end
function TRAIN_SYSTEM:GetSettings()
	PrintToConsole("Начало получения настроек...")

	local LastTrain = self:GetLastWagon()

	PrintToConsole(LastTrain.SubwayTrain.Name)
	local Settings = LastTrain.Announcer.Settings

	if #self.Train.WagonList == 1 or not LastTrain.Custom3 then
		PrintToConsole("Последнйи состав не найден!")
		Settings = self.Settings
		--return
	elseif LastTrain.R_Radio and LastTrain.R_Radio.Value > 0.5 and LastTrain.KV.ReverserPosition == 1.0 then
		PrintToConsole("Включён инорматор в задней кабине!")
		self.AnnState = -12
		return
	elseif Settings.CurTime <= self.Settings.CurTime then
		PrintToConsole("Взяты настройки из передней кабины.")
		Settings = self.Settings
	end

	if not Settings.State then
		PrintToConsole("State в настройках nil. Начало загрузки сначала...")
		self.AnnState = -1
		self.Train:SetNWString("CustomStr0","0x0148adef6af0")
	else
		PrintToConsole("Назначение настроек...")
		self.AnnRoute = Settings.Route
		self.AnnStartStationT = Settings.StartStationT
		self.AnnStartStation = Settings.StartStation
		local StateS = tostring(math.abs(Settings.State))
		self.AnnState = 100+tonumber(StateS:sub(-1,-1))
		PrintToConsole(tostring(StateS:sub(-1,-1)))
		self.AnnState = self.AnnState*(Settings.State < 0 and -1 or 1)
		PrintToConsole("State назначен на:"..self.AnnState.." Был:"..Settings.State)
		self.AnnEndStationT = Settings.EndStationT
		self.AnnEndStation = Settings.EndStation
		self.AnnPath = Settings.Path
		self.AnnStyle = Settings.Style
		self.AnnStationT = Settings.StationT
		self.Arrive = Settings.Arrive
	end
end

--States:
-- -2 - Loaded in another cab
-- -1 - Starting up
--nil - First setUp and get settings from last
--1   - Welcome Screen
--2   - Route Choose
--3   - Choose start station
--4   - Choose end station
--5   - Choose path
--6   - Choose style of playing
--7   - Normal state
--8   - Confim a settings (on last stations)
function TRAIN_SYSTEM:Announcer2()
	if self.Train.R_Radio and self.Train.R_Radio.Value > 0.5 and self.Train.KV.ReverserPosition == 1.0 and self.Train.VB.Value > 0.5 then
		--table.ForEach(self.Settings,print)
		--self.Train:UpdateWagonList()
		--self.Train.WagonList[#self.Train.WagonList].Announcer
		if not self.AnnState then
			--self.Settings.CurTime = CurTime()
			if not self.Settings then
				self.AnnState = -199
			else
				self:GetSettings()
				self.Train:SetNWString("CustomStr2","-")
				self.Train:SetNWString("CustomStr3","+")
				self.Train:SetNWString("CustomStr4","Menu")
				self.Train:SetNWString("CustomStr5","")
				--self.Train:SetNWString("CustomStr6","")
				self.Train:SetNWString("CustomStr7","")
				self.Train:SetNWString("CustomStr8","")
				self.Train:SetNWString("CustomStr9","")
				--self.Train:SetNWString("CustomStr10","")
				--self.Train:SetNWString("CustomStr11","")
				--self.Train:SetNWString("CustomStr12","")
				--self.Train:SetNWString("CustomStr13","")
				self.Train:TriggerInput("CustomDSet", 0)
				self.Train:TriggerInput("CustomESet", 0)
				self.Train:TriggerInput("CustomFSet", 1)
				self.Train:TriggerInput("CustomGSet", 0)
			end
		else
			if self.AnnRoute and self.AnnRoute > #Metrostroi.EndStations[self.AnnMap] then
				self.AnnRoute = #Metrostroi.EndStations[self.AnnMap]
			end
		end

		if self.AnnState == -199 then
			self.Train:SetNWString("CustomStr0","RIU CMOS GET FAILED")
			self.Train:SetNWString("CustomStr1","ERR 0x01 NOT SUPPORT")
			self.AnnState = -99
		end

		if self.AnnState == -2 then
			if self.Train.Custom3.Value > .5 then
				self.AnnState = -22
				--self.Settings.CurTime = CurTime()
				self:GetSettings()
			end
		end

		if self.AnnState == -12 then
			self.Train:SetNWString("CustomStr0","ALREADY LOADED")
			self.Train:SetNWString("CustomStr1","PRESS MENU TO RETRY")
			self.AnnState = -2
		end

		if self.AnnState == -22 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = -2
		end

		if self.AnnState == -1 then
			if not self.loadState then self.loadState = 0 end
			if not self.loadRand then self.loadRand = math.floor(math.random(8,30)) end
			if self.loadState < self.loadRand then
				timer.Simple(math.random(0.15,0.50),function()
					if not self.AnnState then return end
					local chars = ""
					for i=1,20 do
						chars = chars..string[math.random() > 0.5 and "upper" or "lower"](self.AnnChars[math.random(1,#self.AnnChars)])
					end
					self.AnnState = -1
					self.Train:SetNWString("CustomStr0",chars)
					self.Train:SetNWString("CustomStr1","Loading "..self.AnnSeq[math.floor(self.loadState%3+1)])
					self.loadState = self.loadState + 1
					self.Train:TriggerInput("CustomDSet", self.loadState > self.loadRand*0)
					self.Train:TriggerInput("CustomESet", self.loadState > self.loadRand*0.25)
					self.Train:TriggerInput("CustomFSet", self.loadState > self.loadRand*0.5)
					self.Train:TriggerInput("CustomGSet", self.loadState > self.loadRand*0.75)
				end)
				self.AnnState = -91
			else
				self.AnnState = 101
			end
		end

		if self.AnnState == 1 and self.Train.Custom3.Value > 0.5 then
			self.AnnState = 102
		end

		if self.AnnState == 101 then
			self.Train:SetNWString("CustomStr0","RIU V 1.1 REV 84")
			self.Train:SetNWString("CustomStr1","PRESS MENU TO START")
			self.AnnState = 1
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
			if self.AnnPath and self.AnnPath == 2 then
				local Start = self.AnnStartStationT
				self.AnnStartStationT = self.AnnEndStationT
				self.AnnStartStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]
				self.AnnEndStationT = Start
				self.AnnEndStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnEndStationT]
			end
		end

		if self.AnnState == 2 or self.AnnState == 12 or self.AnnState == 22 or self.AnnState == 32 then
			if not self.AnnCurTime or self.AnnCurTime ~= math.floor((CurTime()-self.AnnCurTimeM)%8/2) then
				self.AnnCurTime = math.floor((CurTime() - self.AnnCurTimeM)%8/2)

				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr0","Choose route")
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr0","with + and - buttons")
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr0","when you choose")
				else
					self.Train:SetNWString("CustomStr0","press MENU button")
				end

				local Routelength = #Metrostroi.EndStations[self.AnnMap][self.AnnRoute]
				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr1",Metrostroi.EndStations[self.AnnMap][self.AnnRoute][1].."->"..Metrostroi.EndStations[self.AnnMap][self.AnnRoute][Routelength])
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][1]][1])
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr1","->")
				else
					self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][Routelength]][1])
				end
			end
		end

		if self.AnnState == 2 then
			if self.Train.Custom2.Value > 0.5 then
				if self.AnnRoute < #Metrostroi.EndStations[self.AnnMap] then
					self.AnnRoute = self.AnnRoute + 1
				else
					self.AnnRoute = 1
				end
				self.AnnState = 22
				self.AnnCurTime = nil
				self.AnnCurTimeM = CurTime()
			end
			if self.Train.Custom1.Value > 0.5  then
				if self.AnnRoute > 1 then
					self.AnnRoute = self.AnnRoute - 1
				else
					self.AnnRoute = #Metrostroi.EndStations[self.AnnMap]
				end
				self.AnnState = 12
				self.AnnCurTime = nil
				self.AnnCurTimeM = CurTime()
			end
			if self.Train.Custom3.Value > 0.5 then
				self.AnnState = 103
			end
		end
		if self.AnnState == 12 and self.Train.Custom1.Value <= 0.5 then
			self.AnnState = 2
		end
		if self.AnnState == 22 and self.Train.Custom2.Value <= 0.5 then
			self.AnnState = 2
		end
		if self.AnnState == 32 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 2
		end
		if self.AnnState == 102 then
			self.AnnRoute = self.Settings.Route or 1
			self.AnnCurTimeM = CurTime()
			self.AnnCurTime = nil
			self.AnnState = 32
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
		end

		if self.AnnState == 3 or self.AnnState == 13 or self.AnnState == 23 or self.AnnState == 33 then
			if not self.AnnCurTime or self.AnnCurTime ~= math.floor((CurTime()-self.AnnCurTimeM)%8/2) then
				self.AnnCurTime = math.floor((CurTime() - self.AnnCurTimeM)%8/2)

				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr0","Choose first station")
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr0","with + and - buttons")
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr0","when you choose")
				else
					self.Train:SetNWString("CustomStr0","press MENU button")
				end
			end
		end

		if self.AnnState == 3 then
			if self.Train.Custom2.Value > 0.5 then
				if self.AnnStartStationT < #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] then
					self.AnnStartStationT = self.AnnStartStationT + 1
				else
					self.AnnStartStationT = 1
				end
				self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]][1])
				self.AnnState = 23
			end
			if self.Train.Custom1.Value > 0.5 then
				if self.AnnStartStationT > 1 then
					self.AnnStartStationT = self.AnnStartStationT - 1
				else
					self.AnnStartStationT = #Metrostroi.EndStations[self.AnnMap][self.AnnRoute]
				end
				self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]][1])
				self.AnnState = 13
			end
			if self.Train.Custom3.Value > 0.5 then
				self.AnnState = 104
			end
		end
		if self.AnnState == 13 and self.Train.Custom1.Value <= 0.5 then
			self.AnnState = 3
		end
		if self.AnnState == 23 and self.Train.Custom2.Value <= 0.5 then
			self.AnnState = 3
		end
		if self.AnnState == 33 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 3
		end
		if self.AnnState == 103 then
			self.AnnStartStationT = self.Settings.StartStationT or math.random(1,#Metrostroi.EndStations[self.AnnMap][self.AnnRoute])
			if self.AnnStartStationT > #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] then
				self.AnnStartStationT = math.random(1,#Metrostroi.EndStations[self.AnnMap][self.AnnRoute])
			end
			self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]][1])
			self.AnnCurTimeM = CurTime()
			self.AnnCurTime = nil
			self.AnnState = 33
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
		end

		if self.AnnState == 4 or self.AnnState == 41 or self.AnnState == 24 or self.AnnState == 34 then
			if not self.AnnCurTime or self.AnnCurTime ~= math.floor((CurTime() - self.AnnCurTimeM)%8/2) then
				self.AnnCurTime = math.floor((CurTime() - self.AnnCurTimeM)%8/2)

				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr0","Choose last station")
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr0","with + and - buttons")
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr0","when you choose")
				else
					self.Train:SetNWString("CustomStr0","press MENU button")
				end
			end
		end

		if self.AnnState == 4 then
			if self.Train.Custom2.Value > 0.5 then
				if self.AnnEndStationT < #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] then
					self.AnnEndStationT = self.AnnEndStationT + 1
				else
					self.AnnEndStationT = 1
				end

				if self.AnnEndStationT == self.AnnStartStationT then
					self.AnnEndStationT = self.AnnEndStationT + 1
					if self.AnnEndStationT >= #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] then self.AnnEndStationT = 1 end
				end

				self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnEndStationT]][1])
				self.AnnState = 24
			end
			if self.Train.Custom1.Value > 0.5 then
				if self.AnnEndStationT > 1 then
					self.AnnEndStationT = self.AnnEndStationT - 1
				else
					self.AnnEndStationT = #Metrostroi.EndStations[self.AnnMap][self.AnnRoute]
				end

				if self.AnnEndStationT == self.AnnStartStationT then
					self.AnnEndStationT = self.AnnEndStationT - 1
					if self.AnnEndStationT <= 1 then self.AnnEndStationT = #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] end
				end

				self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnEndStationT]][1])
				self.AnnState = 14
			end
			if self.Train.Custom3.Value > 0.5 then
				self.AnnState = 105
			end
		end
		if self.AnnState == 14 and self.Train.Custom1.Value <= 0.5 then
			self.AnnState = 4
		end
		if self.AnnState == 24 and self.Train.Custom2.Value <= 0.5 then
			self.AnnState = 4
		end
		if self.AnnState == 34 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 4
		end

		if self.AnnState == 104 then
			self.AnnEndStationT = self.Settings.EndStationT or math.random(#Metrostroi.EndStations[self.AnnMap][self.AnnRoute],1)
			if self.AnnEndStationT > #Metrostroi.EndStations[self.AnnMap][self.AnnRoute] then
				self.AnnEndStationT = math.random(1,#Metrostroi.EndStations[self.AnnMap][self.AnnRoute])
			end
			while self.AnnEndStationT == self.AnnStartStation do
				self.AnnEndStationT = math.random(#Metrostroi.EndStations[self.AnnMap][self.AnnRoute],1)
			end
			self.Train:SetNWString("CustomStr1", Metrostroi.AnnouncerData[Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnEndStationT]][1])
			self.AnnCurTime = nil
			self.AnnCurTimeM = CurTime()
			self.AnnStartStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]
			self.AnnState = 34
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
		end

		if self.AnnState == 105 then
			self.AnnState = 106
			self.AnnCurTime = nil
			if self.AnnStartStationT > self.AnnEndStationT then
				local Start = self.AnnStartStationT
				self.AnnStartStationT = self.AnnEndStationT
				self.AnnStartStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnStartStationT]
				self.AnnEndStationT = Start
				self.AnnPath = 2
			else
				self.AnnPath = 1
			end
			self.AnnEndStation = Metrostroi.EndStations[self.AnnMap][self.AnnRoute][self.AnnEndStationT]
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
		end

		if self.AnnState == 6 or self.AnnState == 16 or self.AnnState == 26 or self.AnnState == 36 then
			if not self.AnnCurTime or self.AnnCurTime ~= math.floor((CurTime() - self.AnnCurTimeM)%8/2) then
				self.AnnCurTime = math.floor((CurTime() - self.AnnCurTimeM)%8/2)

				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr0","Choose playing style")
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr0","with + and - buttons")
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr0","when you choose")
				else
					self.Train:SetNWString("CustomStr0","press MENU button")
				end

			end
		end

		if self.AnnState == 6 then
			if self.Train.Custom2.Value > 0.5 then
				if self.AnnStyle < #Metrostroi.PlayingStyles then
					self.AnnStyle = self.AnnStyle + 1
				else
					self.AnnStyle = 1
				end
				self.Train:SetNWString("CustomStr1", Metrostroi.PlayingStyles[self.AnnStyle].." style")
				self.AnnState = 26
			end
			if self.Train.Custom1.Value > 0.5 then
				if self.AnnStyle > 1 then
					self.AnnStyle = self.AnnStyle - 1
				else
					self.AnnStyle = #Metrostroi.PlayingStyles
				end
				self.Train:SetNWString("CustomStr1", Metrostroi.PlayingStyles[self.AnnStyle].." style")
				self.AnnState = 16
			end
			if self.Train.Custom3.Value > 0.5 then
				self.AnnState = 108
			end
		end
		if self.AnnState == 16 and self.Train.Custom1.Value <= 0.5 then
			self.AnnState = 6
		end
		if self.AnnState == 26 and self.Train.Custom2.Value <= 0.5 then
			self.AnnState = 6
		end
		if self.AnnState == 36 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 6
		end
		if self.AnnState == 106 then
			self.AnnCurTime = nil
			self.AnnCurTimeM = CurTime()
			self.AnnStyle = self.Settings.Style or 1
			self.Train:SetNWString("CustomStr1", Metrostroi.PlayingStyles[self.AnnStyle].." style")
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
			self.AnnState = 36
		end


		if self.AnnState == 7 or self.AnnState == 17 or self.AnnState == 27 or self.AnnState == 37 or self.AnnState == 87 or self.AnnState == 97 then
			if false and self.Train.CustomC.Value > 0.5 then
				local Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
				local Path = Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
				if Station and Station ~= 0 and Path and Path ~= 0 then
					local StatID = Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][Station] or Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][Station + (Path == 1 and 1 or -1)] or 0
					if StatID ~= 0 then
						local Curr,Next
						if StatID ~= 0 then
							Curr = Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][StatID]]
							Next = Metrostroi.AnnouncerData[Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][StatID + (Path == 1 and 1 or -1)]]
						end

						-- Set announcer settings
						if Path ~= self.AnnPath or StatID ~= self.AnnStationT then
							self.AnnPath = Path > 1 and 2 or 1
							self.AnnStationT = StatID
							self.AnnState7NeedRedraw = true
						end

						local dX = self.Train:ReadCell(49165)
						if 45 < dX and dX < 75 and not self.Arrive and Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][Station] then
							self:AnnPlayArriving()
							self.Arrive = true
							if not self:AnnEnd() then
								self.AnnState = 87
							elseif Metrostroi.AnnouncerData[self.AnnStation][9] then
								self.AnnPath = self.AnnPath == 1 and 2 or 1
								self.AnnStation = self.AnnStation - 1
								self.AnnState7NeedRedraw = true
								self.AnnState = 107
							else
								self.AnnPath = self.AnnPath == 1 and 2 or 1
								self.AnnCurTime = nil
								self.AnnCurTimeM = CurTime()
								self.AnnState7NeedRedraw = nil
								self.AnnState = 108
							end
							self.AnnState7NeedRedraw = true
						end

						if dX > 75 and self.Arrive then
							self.Arrive = false
							self.AnnState7NeedRedraw = nil
						end
					end
				end
			end
			--self.AnnStationT = 7
			self.AnnStation = Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][self.AnnStationT]
			--print(self.AnnNextT,self.AnnStationT)
			self.AnnNextT = self.AnnStationT + (self.AnnPath == 1 and 1 or -1) - (self.AnnPath  == Metrostroi.AnnouncerData[self.AnnStation][9] and 2 or 0)
			self.AnnNext = Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][self.AnnNextT]
			self.NextNonWorkingStation = ((Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][self.AnnStationT] or 0) + (self.AnnPath == 1 and 1 or -1) == 120)
			and self.AnnStation + (self.AnnPath == 1 and 1 or -1) or nil
			self.Train:TriggerInput("CustomGSet", self.ScheduleAnnouncement > 2)
		end

		if (self.AnnState == 7 or self.AnnState == 17 or self.AnnState == 27 or self.AnnState == 37 or self.AnnState == 87 or self.AnnState == 97) and self.AnnState7NeedRedraw then
			local Str = "C:"..Metrostroi.AnnouncerData[self.AnnStation][1]
			local str1T = (self:AnnEnd() and "E" or " ")..(Metrostroi.AnnouncerData[self.AnnStation][2] and "R" or "L")..(not self.Arrive and "<" or " ")
			if #Str<=17 then
				str1 = Str..string.rep(" ",17-#Str)..str1T
			else
				str1 = Str:sub(1,14).."..."..str1T
			end
			self.Train:SetNWString("CustomStr0",str1)
			local str2
			if self:AnnEnd() then
				str2 = "Last station"
			else
				local Str = "N:"..Metrostroi.AnnouncerData[self.AnnNext][1]
				local str2T = (self:AnnEnd(true) and "E" or " ")..(Metrostroi.AnnouncerData[self.AnnNext][2] and "R" or "L")..(self.Arrive and "<" or " ")
				if #Str<=17 then
					str2 = Str..string.rep(" ",17-#Str)..str2T
				else
					str2 = Str:sub(1,14).."..."..str2T
				end
			end
			self.Train:SetNWString("CustomStr1",str2)
			self.Train:TriggerInput("CustomDSet", self:AnnEnd())
			self.Train:TriggerInput("CustomESet", Metrostroi.AnnouncerData[self.AnnStation][2])
			self.Train:TriggerInput("CustomFSet", 0)
			self.AnnState7NeedRedraw = nil
		end
		if self.AnnState == 7 then
			if self.Train.Custom1.Value > 0.5 then
				if (self.AnnPath == 1 and self.AnnStation > self.AnnStartStation) or
					(self.AnnPath == 2 and self.AnnEndStation > self.AnnStation) then
					self.Arrive = not self.Arrive
					if self.Arrive then self.AnnStationT = self.AnnStationT - (self.AnnPath == 1 and 1 or -1) end
					self.AnnState = 17
					self.AnnState7NeedRedraw = true
				elseif Metrostroi.AnnouncerData[self.AnnStation][9] then
					self.AnnPath = Metrostroi.AnnouncerData[self.AnnStation][9]
					self.Arrive = not self.Arrive
					self.AnnState = 17
					self.AnnState7NeedRedraw = true
				end
			end

			if self.Train.Custom2.Value > 0.5 then
				if (self.AnnPath == 2 and self.AnnStation > self.AnnStartStation) or
					(self.AnnPath == 1 and self.AnnEndStation > self.AnnStation) then
					self.Arrive = not self.Arrive
					if not self.Arrive then self.AnnStationT = self.AnnStationT + (self.AnnPath == 1 and 1 or -1) end
					self.AnnState = 27
					self.AnnState7NeedRedraw = true
				elseif Metrostroi.AnnouncerData[self.AnnStation][9] then
					self.AnnPath = Metrostroi.AnnouncerData[self.AnnStation][9] == 1 and 2 or 1
					self.Arrive = true
					self.AnnState = 27
					self.AnnState7NeedRedraw = true
				end
			end
			if self.Train.R_Program1.Value > 0.5 and #self.Schedule == 0 then
                if not self.Arrive then
					if true or self.Train.CustomC.Value < 0.5 then
						self:AnnPlayArriving()
						self.Arrive = true
						if not self:AnnEnd() then
							self.AnnState = 87
						else
							self.AnnPath = self.AnnPath == 1 and 2 or 1
							self.AnnCurTime = nil
							self.AnnCurTimeM = CurTime()
							self.AnnState7NeedRedraw = nil
							self.AnnState = 108
						end
					end
                else
					self:AnnPlayDepeate()
					self.Arrive = false
					if Metrostroi.AnnouncerData[self.AnnStation][9] == self.AnnPath then
						self.AnnPath = self.AnnPath == 1 and 2 or 1
					end
					self.AnnStationT = self.AnnStationT + (self.AnnPath == 1 and 1 or -1)
					self.AnnState = 87
                end
				self.AnnState7NeedRedraw = true
			end
			if self.Train.R_Program2.Value > 0.5 and #self.Schedule == 0 then
				self:AnnII()
				self.AnnState = 97
			end
			if self.Train.Custom3.Value > 0.5 then
				self.AnnState = 108
			end
		end
		if self.AnnState == 17 and self.Train.Custom1.Value <= 0.5 then
			self.AnnState = 7
			self.AnnState7NeedRedraw = true
		end
		if self.AnnState == 27 and self.Train.Custom2.Value <= 0.5 then
			self.AnnState = 7
			self.AnnState7NeedRedraw = true
		end
		if self.AnnState == 37 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 7
			self.AnnState7NeedRedraw = true
		end
		if self.AnnState == 97 and self.Train.R_Program2.Value <= 0.5 then
			self.AnnState = 7
			self.AnnState7NeedRedraw = true
		end
		if self.AnnState == 87 and self.Train.R_Program1.Value <= 0.5 then
			self.AnnState = 7
			self.AnnState7NeedRedraw = true
		end
		if self.AnnState == 107 or self.AnnState == 117 then
			--print(Metrostroi.AnnouncerData[self.AnnStartStation][1].."->"..Metrostroi.AnnouncerData[self.AnnEndStation][1].."\nPath:"..(self.AnnPath == 1 and "I" or "II").."\nStyle:"..Metrostroi.PlayingStyles[self.AnnStyle].." style")
			if self.AnnState == 117 then
				self:PlayInfQueueSounds(0005)
				if self.AnnStyle == 2 then
					self:PlayInfQueueSounds(0003)
				end
				self:PlayInfQueueSounds(0201,0211,Metrostroi.AnnouncerData[self.AnnPath == 2 and self.AnnEndStation or self.AnnStartStation][6] and 0220 or nil,self.AnnPath == 2 and self.AnnEndStation or self.AnnStartStation,
					0000,Metrostroi.AnnouncerData[self.AnnPath==1 and self.AnnEndStation or self.AnnStartStation][6] and 0220 or nil,self.AnnPath==1 and self.AnnEndStation or self.AnnStartStation,0006
				)
				self.Arrive = true
				self.AnnStationT = Metrostroi.WorkingStations[self.AnnMap][self.AnnRoute][self.AnnPath == 2 and self.AnnEndStation or self.AnnStartStation]
			end
			self.Train:PrepareSigns()
			self.Train.SignsIndex = self.Train.SignsList[self.AnnPath == 2 and self.AnnStartStation or self.AnnEndStation] or 1
			self.Train:SetNWString("FrontText",self.Train.SignsList[self.Train.SignsIndex])
			local LastTrain = self:GetLastWagon()

			if #self.Train.WagonList > 1 then
				LastTrain:PrepareSigns()
				LastTrain.SignsIndex = self.Train.SignsList[self.AnnPath == 1 and self.AnnStartStation or self.AnnEndStation] or 1
				LastTrain:SetNWString("FrontText",self.Train.SignsList[LastTrain.SignsIndex])
			end
			--self.Train:TriggerInput("CustomDSet", 0)
			--self.Train:TriggerInput("CustomESet", 0)
			--self.Train:TriggerInput("CustomFSet", 0)
			--self.Train:TriggerInput("CustomGSet", 0)
			self.AnnState = 37
		end

		--print(self.AnnStationT,self.AnnStation)
		if self.AnnState == 8 or self.AnnState == 18 or self.AnnState == 28 or self.AnnState == 38 then
			if not self.AnnCurTime or self.AnnCurTime ~= math.floor((CurTime() - self.AnnCurTimeM)%12/2) then
				self.AnnCurTime = math.floor((CurTime() - self.AnnCurTimeM)%12/2)

				if self.AnnCurTime < 1 then
					self.Train:SetNWString("CustomStr0","Settings changed")
					self.Train:SetNWString("CustomStr1","Path:"..(self.AnnPath == 1 and "I" or "II"))
				elseif self.AnnCurTime < 2 then
					self.Train:SetNWString("CustomStr0","Start station:")
					self.Train:SetNWString("CustomStr1",Metrostroi.AnnouncerData[self.AnnStartStation][1])
				elseif self.AnnCurTime < 3 then
					self.Train:SetNWString("CustomStr0","End station:")
					self.Train:SetNWString("CustomStr1",Metrostroi.AnnouncerData[self.AnnEndStation][1])
				elseif self.AnnCurTime < 4 then
					self.Train:SetNWString("CustomStr0","Playing style:")
					self.Train:SetNWString("CustomStr1",Metrostroi.PlayingStyles[self.AnnStyle])
				elseif self.AnnCurTime < 5 then
					self.Train:SetNWString("CustomStr0","press MENU button")
					self.Train:SetNWString("CustomStr1","to confim")
				else
					self.Train:SetNWString("CustomStr0","press \"+\" or \"-\"")
					self.Train:SetNWString("CustomStr1","button to reset")
				end
			end
		end
		if self.AnnState == 8 then
			if self.Train.Custom1.Value > 0.5 or self.Train.Custom2.Value > 0.5  then
				self.AnnState = nil
			end
			if self.Train.Custom3.Value > 0.5  then
				self.AnnState = 117
			end
			if self.Train.R_Program2.Value > 0.5 then
				self:AnnII()
				self.AnnState = 98
			end
		end
		if self.AnnState == 38 and self.Train.Custom3.Value <= 0.5 then
			self.AnnState = 8
		end

		if self.AnnState == 98 and self.Train.R_Program2.Value <= 0.5 then
			self.AnnState = 8
		end
		if self.AnnState == 108 then
			self.AnnState = 38
			self.AnnCurTime = nil
			self.AnnCurTimeM = CurTime()
			self.AnnState7NeedRedraw = nil
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 1)
			self.Train:TriggerInput("CustomGSet", 0)
		end

		if self.Settings and self.AnnState ~= -2 and self.AnnState ~= -12 and self.AnnState ~= -22 then
			self.Settings.Route = self.AnnRoute
			self.Settings.StartStationT = self.AnnStartStationT
			self.Settings.StartStation = self.AnnStartStation
			self.Settings.State = self.AnnState
			self.Settings.EndStationT = self.AnnEndStationT
			self.Settings.EndStation = self.AnnEndStation
			self.Settings.Path = self.AnnPath
			self.Settings.Style = self.AnnStyle
			self.Settings.StationT = self.AnnStationT
			self.Settings.CurTime = CurTime()
			self.Settings.Arrive = self.Arrive
		end
	else
		if self.AnnState and self.AnnState < 0 and self.Settings then
			self.Settings.State = nil
		end
		if self.AnnState then
			self.Train:SetNWString("CustomStr0" ,"")
			self.Train:SetNWString("CustomStr1" ,"")
			self.Train:SetNWString("CustomStr2" ,"")
			self.Train:SetNWString("CustomStr3" ,"")
			self.Train:SetNWString("CustomStr4" ,"")
			self.Train:SetNWString("CustomStr5" ,"")
			--self.Train:SetNWString("CustomStr6" ,"")
			self.Train:SetNWString("CustomStr7" ,"")
			self.Train:SetNWString("CustomStr8" ,"")
			self.Train:SetNWString("CustomStr9" ,"")
			--self.Train:SetNWString("CustomStr10","")
			--self.Train:SetNWString("CustomStr11","")
			--self.Train:SetNWString("CustomStr12","")
			--self.Train:SetNWString("CustomStr13","")
			self.Train:TriggerInput("CustomDSet", 0)
			self.Train:TriggerInput("CustomESet", 0)
			self.Train:TriggerInput("CustomFSet", 0)
			self.Train:TriggerInput("CustomGet" , 0)
			self.AnnState = nil
		end
	end
end

function TRAIN_SYSTEM:Think()
	-- Build-in Black Phoenix Announcer logic
	--	self:Announcer1()
	-- Build-in glebqip Announcer logic
	if self.Train.Custom3 and (not self.Train.ARSType or self.Train.ARSType < 3) then
		self:Announcer2()
	end
	-- Check if new announcement must be started from train wire
	local targetAnnouncement = self.Train:ReadTrainWire(48)
	if targetAnnouncement < 0 then targetAnnouncement = 0 end
	local onlyCabin = false
	if (targetAnnouncement == 0) then targetAnnouncement = self.Fake48 or 0  onlyCabin = true end
	if (targetAnnouncement > 0) and (targetAnnouncement ~= self.Announcement) and (CurTime() > self.EndTime) then
		self.Announcement = targetAnnouncement
		if Metrostroi.Announcements[targetAnnouncement] then
			self.Sound = Metrostroi.Announcements[targetAnnouncement][2]
			self.EndTime = CurTime() + Metrostroi.Announcements[targetAnnouncement][1]

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
			if targetAnnouncement == 5 then timer.Simple(0.3,function() self.Train:SetNWBool("BPSNBuzz",true) end) end
			if targetAnnouncement == 6 then timer.Simple(0.4,function() self.Train:SetNWBool("BPSNBuzz",false) end) end
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

	-- Check if new announcement must be started from schedule
	if (self.ScheduleAnnouncement == 0) and (self.Schedule[1]) then
		self.ScheduleAnnouncement = self.Schedule[1][3]
		self.ScheduleEndTime = CurTime() + self.Schedule[1][1]
		table.remove(self.Schedule,1)
	end


	-- Check if schedule announcement is playing
	if self.ScheduleAnnouncement ~= 0 then
		if self.Train.DriverSeat and (self.Train.R_UNch.Value < 0.5) then
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
	if self.Train.R_UNch and self.Train.KV then
		if self.Train.R_UNch.Value < 0.5 and self.Train.KV.ReverserPosition == 1.0 then
			self.Train:WriteTrainWire(48,-1)
		elseif self.Train:ReadTrainWire(48) == -1 then
			self.Train:WriteTrainWire(48,0)
		end
		return
	end
end
