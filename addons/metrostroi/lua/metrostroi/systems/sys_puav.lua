--------------------------------------------------------------------------------
-- ПУАВ - Поездное Устройство АвтоВедения
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PUAV")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("KH","Relay","Switch",{button = true})
	self.Train:LoadSystem("VAV","Relay","Switch",{switch = true})
	self.Train:LoadSystem("P1","Relay","Switch",{button = true})
	self.Train:LoadSystem("P2","Relay","Switch",{button = true})
	self.Train:LoadSystem("P3","Relay","Switch",{button = true})
	self.Train:LoadSystem("P4","Relay","Switch",{button = true})
	self.Train:LoadSystem("P5","Relay","Switch",{button = true})
	self.TriggerNames = {
		"P1",
		"P2",
		"P3",
		"P4",
		"P5",
	}
	self.Triggers = {}
	self.Choose = 0
end
function TRAIN_SYSTEM:ClientInitialize()
	self.StataionData =
	{
		[0] = "ERR",
		[108] = "AV",
		[109] = "IND",
		[110] = "MOSK",
		[111] = "OKT",
		[112] = "PLMI",
		[113] = "NOV",
		[114] = "VOK",
		[115] = "KOM",
		[116] = "ELE",
		[117] = "TEPL",
		[118] = "PP",
		[119] = "SINE",
		[120] = "LES X",
		[121] = "MNSK",
		[122] = "TSVO",
		[123] = "MZHD",
		[321] = "MUSK",
		[322] = "AVUZ",
		[1215] = "LEN",
		--ORANGE LINE
		[401] = "SLS",
		[402] = "LITE",
		[403] = "PA",
		[404] = "MAST",
		[405] = "GFC",
		[406] = "UB",
		[407] = "VHE",
		[408] = "TGM",
		[501] = "AERO",
		[502] = "SENT",
		[503] = "LIT",
	}
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	function TRAIN_SYSTEM:PUAV1(train)
		--self:DrawDigit(2.3+9.8*0,	4, 8, 0.0625, 0.056)
		--self:DrawDigit(2.3+9.8*1,	4, 8, 0.0625, 0.056)
		if self:GetNW2Int("PUAV:Choose",0) == 0 then
			local time = os.date("!%H%M",os.time())--)os.date("%h",os_time)
			self:DrawDigit(2.3+9.8*2,	4, tonumber(time[1]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*3,	4, tonumber(time[2]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*4,	4, tonumber(time[3]), 0.0625, 0.056)
			if RealTime()%1 > 0.5 then
				surface.SetDrawColor(Color(100,255,0,255))
				surface.DrawRect(39,15,1,1)
			end
			self:DrawDigit(2.3+9.8*5,	4, tonumber(time[4]), 0.0625, 0.056)
		elseif self:GetNW2Int("PUAV:Choose",0) == 1 then
			self:DrawDigit(2.3+9.8*0,	4, self:GetNW2Int("PUAV:Line",1), 0.0625, 0.056)
		elseif self:GetNW2Int("PUAV:Choose",0) == 2 then
			local st = tostring(self:GetNW2Int("PUAV:FirstStation",111))
			self:DrawDigit(2.3+9.8*3,	4 ,tonumber(st[1]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*4,	4 ,tonumber(st[2]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*5,	4 ,tonumber(st[3]), 0.0625, 0.056)
		elseif self:GetNW2Int("PUAV:Choose",0) == 3 then
			local st = tostring(self:GetNW2Int("PUAV:LastStation",111))
			self:DrawDigit(2.3+9.8*3,	4 ,tonumber(st[1]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*4,	4 ,tonumber(st[2]), 0.0625, 0.056)
			self:DrawDigit(2.3+9.8*5,	4 ,tonumber(st[3]), 0.0625, 0.056)
		end
		surface.SetAlphaMultiplier(1)
	end
	surface.CreateFont("MetrostroiSubway_PUAV1", {
	  font = "Arial",
	  size = 15,
	  weight = 800,
	  blursize = 0,
	  scanlines = 0,
	  antialias = false,
	  underline = false,
	  italic = false,
	  strikeout = false,
	  symbol = false,
	  rotary = false,
	  shadow = false,
	  additive = false,
	  outline = false
	})
	surface.CreateFont("MetrostroiSubway_PUAV2", {
	  font = "Arial",
	  size = 30,
	  weight = 800,
	  blursize = 0,
	  scanlines = 0,
	  antialias = false,
	  underline = false,
	  italic = false,
	  strikeout = false,
	  symbol = false,
	  rotary = false,
	  shadow = false,
	  additive = false,
	  outline = false
	})
	surface.CreateFont("MetrostroiSubway_PUAV3", {
	  font = "Arial",
	  size = 25,
	  weight = 800,
	  blursize = 0,
	  scanlines = 0,
	  antialias = false,
	  underline = false,
	  italic = false,
	  strikeout = false,
	  symbol = false,
	  rotary = false,
	  shadow = false,
	  additive = false,
	  outline = false
	})
	function TRAIN_SYSTEM:PUAV2(train)
		local b = self:Animate("light_16",self:GetPackedBool("W16") and 1 or 0,0,1,15,false)
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(200,200,0))
			surface.DrawRect(13,9,30,32)
			draw.SimpleText("ЛК16","MetrostroiSubway_PUAV1",27, 25,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self:Animate("light_LOS",self:GetPackedBool("LOS") and 1 or 0,0,1,15,false)
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(200,0,0))
			surface.DrawRect(13,54,30,28)
			draw.SimpleText("ЛОС","MetrostroiSubway_PUAV1",27, 68,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self:Animate("light_LAVT",self:GetPackedBool("AVT") and 1 or 0,0,1,15,false)
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(200,100,0))
			surface.DrawRect(13,95,30,25)
			draw.SimpleText("ЛАВТ","MetrostroiSubway_PUAV1",27, 107,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self:Animate("light_LRS",self:GetPackedBool("ARS") and 1 or 0,0,1,15,false)
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(0,200,0))
			surface.DrawRect(13,134,30,24)
			draw.SimpleText("ЛРС","MetrostroiSubway_PUAV1",27, 146,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self:Animate("light_LKI1",self:GetPackedBool("LKI") and 0 or 1,0,1,15,false)
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(200,0,0))
			surface.DrawRect(13,171,30,28)
			draw.SimpleText("ЛКИ1","MetrostroiSubway_PUAV1",27, 185,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		--surface.SetDrawColor(Color(200,0,0))
		--surface.DrawRect(13,171,30,28)
		--draw.SimpleText("ЛКН1","MetrostroiSubway_PUAV1",27, 185,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		--surface.SetDrawColor(Color(200,0,0))
		--surface.DrawRect(13,213,30,23)
		--draw.SimpleText("ЛКН2","MetrostroiSubway_PUAV1",27, 224,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		local b = self.Anims["light_OCh"] and self.Anims["light_OCh"].val or 0
		if b > 0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(Color(200,0,0))
			surface.DrawRect(13 + 478,9,30,32)
			draw.SimpleText("НЧ","MetrostroiSubway_PUAV3",27 + 478, 25,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self.Anims["light_0"] and self.Anims["light_0"].val or 0
		if b > 0 then
			surface.SetDrawColor(Color(200,0,0))
			surface.DrawRect(13 + 478,54,30,28)
			draw.SimpleText("0","MetrostroiSubway_PUAV2",27 + 478, 68,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self.Anims["light_40"] and self.Anims["light_40"].val or 0
		if b > 0 then
			surface.SetDrawColor(Color(200,100,0))
			surface.DrawRect(13 + 478,95,30,25)
			draw.SimpleText("40","MetrostroiSubway_PUAV2",27 + 478, 107,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self.Anims["light_60"] and self.Anims["light_60"].val or 0
		if b > 0 then
			surface.SetDrawColor(Color(0,200,0))
			surface.DrawRect(13 + 478,134,30,24)
			draw.SimpleText("60","MetrostroiSubway_PUAV2",27 + 478, 146,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self.Anims["light_70"] and self.Anims["light_70"].val or 0
		if b > 0 then
			surface.SetDrawColor(Color(0,200,0))
			surface.DrawRect(13 + 478,171,30,28)
			draw.SimpleText("70","MetrostroiSubway_PUAV2",27 + 478, 185,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		local b = self.Anims["light_80"] and self.Anims["light_80"].val or 0
		if b > 0 then
			surface.SetDrawColor(Color(0,200,0))
			surface.DrawRect(13 + 478,213,30,23)
			draw.SimpleText("80","MetrostroiSubway_PUAV2",27 + 478, 224,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
		surface.SetAlphaMultiplier(1)
	end


	function TRAIN_SYSTEM:ClientThink()
	end
end

function TRAIN_SYSTEM:UpdateUPO()
	for k,v in pairs(self.Train.WagonList) do
		if v.UPO then v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,v == self.Train) end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	if name == "P2" and self.Choose == 1 then
		self.Line = (self.Line or 1) + 1
		if self.Line > #Metrostroi.EndStations then
			self.Line = 1
		end
	end
	if name == "P3" and self.Choose == 2 then
		self.ChoosedFStation = (self.ChoosedFStation or 1) + 1
		if self.ChoosedFStation > #Metrostroi.EndStations[self.Line] then
			self.ChoosedFStation = 1
		end
	end
	if name == "P4" and self.Choose == 3 then
		self.ChoosedLStation = (self.ChoosedLStation or 1) + 1
		if self.ChoosedLStation > #Metrostroi.EndStations[self.Line] then
			self.ChoosedLStation = 1
		end
	end
	if name == "P2" and self.Choose == 0 then
		self.Choose = 1
		self.Line = self.Line or 1
		self.ChoosedFStation = self.ChoosedFStation or 1
		self.ChoosedLStation = self.ChoosedLStation or #Metrostroi.EndStations[self.Line]
		self.Timer = CurTime() + 3
	end
	if name == "P3" and self.Choose == 0 then
		self.Choose = 2
		self.Line = self.Line or 1
		self.ChoosedFStation = self.ChoosedFStation or 1
		self.ChoosedLStation = self.ChoosedLStation or #Metrostroi.EndStations[self.Line]
		self.Timer = CurTime() + 3
	end
	if name == "P4" and self.Choose == 0 then
		self.Choose = 3
		self.Line = self.Line or 1
		self.ChoosedFStation = self.ChoosedFStation or 1
		self.ChoosedLStation = self.ChoosedLStation or #Metrostroi.EndStations[self.Line]
		self.Timer = CurTime() + 3
	end
	if name == "P5" and self.Choose == 0 then
		self.Choose = 4
		self.Timer = CurTime() + 3
	end
	if self.Timer then
		self.Timer = CurTime() + 3
		self.TimeOverride = true
	end
	self.FirstStation = Metrostroi.EndStations[self.Line] and Metrostroi.EndStations[self.Line][self.ChoosedFStation or 1] or 0
	self.LastStation = Metrostroi.EndStations[self.Line] and Metrostroi.EndStations[self.Line][self.ChoosedLStation or 1] or 0
	self:UpdateUPO()
end
function TRAIN_SYSTEM:Think(dT)
	if self.Train.Blok and self.Train.Blok ~= 1 then return end
	local Train = self.Train
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
	if self.Train.VZP.Value > 0.5 then
		Train.Autodrive:Enable()
	end
	if Train.VAV.Value < 0.5 then
		Train.Autodrive:Disable()
	end
	if self.Timer and CurTime() - self.Timer > 0 then
		self.Timer = nil
		self.Choose = 0
	end
	--self.FirstStation = Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line] and Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line][self.ChoosedFStation or 1] or 0
	--self.LastStation = Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line] and Metrostroi.EndStations[Train.Announcer.AnnMap][self.Line][self.ChoosedLStation or 1] or 0
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end

	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		Train:SetNW2Int("PUAV:Choose",self.Choose)
		Train:SetNW2Int("PUAV:LastStation",self.LastStation or 1)
		Train:SetNW2Int("PUAV:FirstStation",self.FirstStation or 1)
		Train:SetNW2Int("PUAV:Line",self.Line or 1)
	end
	self.RouteNumber = string.gsub(Train.RouteNumber or "","^(0+)","")
	self.Line = Train.UPO.Line
	self.FirstStation = tostring(Train.UPO.FirstStation or "")
	self.LastStation = tostring(Train.UPO.LastStation or "")
	local pathID
	if (Metrostroi.TrainPositions[self.Train] and Metrostroi.TrainPositions[self.Train][1]) then
		PathID = Metrostroi.TrainPositions[self.Train][1].path.id
	end
	Train:SetPackedBool("LKI",self.Train.Autodrive.Commands[PathID] and self.Train.Autodrive.Commands[PathID][self.Train.UPO.Station] ~= nil)
end
