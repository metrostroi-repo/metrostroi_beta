--------------------------------------------------------------------------------
-- Announcer and announcer-related code
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("ASNP")
TRAIN_SYSTEM.DontAccelerateSimulation = true
if TURBOSTROI then return end

function table.GetLastKey(t)
    local lk = -math.huge
    for ki in pairs(t) do
        lk = math.max(lk,ki)
    end
    return lk
end


function TRAIN_SYSTEM:Initialize()
	self.TriggerNames = {
		"Custom1",
		"Custom2",
		"Custom3",
	}
	self.Triggers = {}
	self.State = 0
	self.RealState = 99
	self.RouteNumber = "00"
end

function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR2r = {}
	self.STR1x = 1
	self.STR2x = 1
end
if TURBOSTROI then return end

function TRAIN_SYSTEM:Inputs()
	return {}
end

function TRAIN_SYSTEM:Outputs()
	return {}
end

function TRAIN_SYSTEM:TriggerInput(name,value)
end
Metrostroi.AnnButtons = {"-","+","Меню"}
function TRAIN_SYSTEM:AnnDisplay(train)
		-- Draw button labels
		for x=0,2 do
				draw.Text({
					text = string.Trim(Metrostroi.AnnButtons[x+1]),
					font = "MetrostroiSubway_VerySmallText3",
					pos = { 310+x*135,350+0*150},
					xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		end
		draw.Text({
			text = "Manual",
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 735,200},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		draw.Text({
			text = "Auto",
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 735,100},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
			
		--draw.DrawText("SELFDESTRUCT","MetrostroiSubway_VerySmallText3",300,480,Color(0,0,0,255))		
		
		if not train:GetPackedBool(32) then return end
		if train:GetPackedBool(24) then
			local function GetColor(id, text)
				if text then
					return train:GetPackedBool(id) and Color(255,0,0) or Color(0,0,0)
				else
					return not train:GetPackedBool(id) and Color(255,255,255) or Color(0,0,0)
				end
			end
			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(255,255,255)
			surface.DrawRect(58,617,230,22) -- 120
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("DURA V 1.0","MetrostroiSubway_IGLA",60,613 + 22*0, Color(0,0,0,255))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(31)) surface.SetAlphaMultiplier(0.4)
			surface.DrawRect(58,617 + 22 * 1,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel:" .. (train:GetPackedBool(31) and "2" or "1"),"MetrostroiSubway_IGLA",60,613 + 22*1,GetColor(31, true))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(153)) surface.SetAlphaMultiplier(0.4)
			surface.DrawRect(58,617 + 22 * 2,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel1:" .. (train:GetPackedBool(153) and "Alt" or "Main"),"MetrostroiSubway_IGLA",60,613 + 22*2,GetColor(153, true))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(154))
			surface.DrawRect(58,617 + 22 * 3,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel2:" .. (train:GetPackedBool(154) and "Alt" or "Main"),"MetrostroiSubway_IGLA",60,613 + 22*3,GetColor(154, true))
			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(255,255,255)
			surface.DrawRect(58,617 + 22 * 4,230, 120 - 88) -- 120
			surface.SetAlphaMultiplier(1)
		end
		-- Custom announcer display
		for i=1,20 do
			surface.SetDrawColor(Color(53,91,25))
			surface.DrawRect(287+(i-1)*17.7+1,125+4,16,25)			
			--draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+0,Color(0,0,0,210))
		end
		for i=1,20 do
			surface.SetDrawColor(Color(53,91,25))
			surface.DrawRect(287+(i-1)*17.7+1,125+31+4,16,25)
			--draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+31,Color(0,0,0,210))
		end
		
		for y = 0,#self.STR1r-1 do
			local xmin = 0
			local blink = false
			local checked = false
			local x = 0
			local iter = 0
			while((x <= math.min(19+xmin,#self.STR1r[y+1]-1+xmin))) do
			--for x = 0,math.min(19,#self.STR1r[y+1]-1)-xmin do
				local char = self.STR1r[y+1][x+1]
				if char == "|" then
					Metrostroi.DrawLine(295+(x-xmin)*17.7,140 + y*30-10,295+(x-xmin)*17.7,140+ y*30+10, Color(16,36,5),3)
				elseif char == "_" then
					if CurTime()%0.5<=0.25 then
						draw.DrawText(char,"MetrostroiSubway_IGLA",287+(x-xmin)*17.7,121 + y*30, Color(16,36,5))	
					end
					xmin = xmin + 1
				else
					draw.DrawText(char,"MetrostroiSubway_IGLA",287+(x-xmin)*17.7,125 + y*30, Color(16,36,5))
				end
				x = x + 1
			end
		end
		surface.SetAlphaMultiplier(1)
end
function TRAIN_SYSTEM:STR1(str,notchange)
	if type(str) == "number" then str = tostring(str) end
	if SERVER then return end
	if str == true then
		for i = 1,2 do
			self.STR1r[i] = ""
		end
		self.STR1x = 1
	else
		if self.STR1x > (notchange and 3 or 2)  then print("STR1:ERR:MAX",str) return end
		if notchange then
			self.STR1r[self.STR1x-1] = self.STR1r[self.STR1x-1]..str:upper()
		else
			self.STR1r[self.STR1x] = str:upper() or ""
			self.STR1x = self.STR1x + 1
		end
	end
end
function TRAIN_SYSTEM:DisplayStation(St,stay,max)
	max = max or 20
	local sz = stay and #self.STR1r[self.STR1x-1] or #self.STR1r[self.STR1x]
	local Siz = stay and #self.STR1r[self.STR1x-1] or #self.STR1r[self.STR1x]
	local StS = Metrostroi.AnnouncerData[St][1]
	local StT = string.Explode(" ",StS)
	local str = ""
	if #StT > 1 then
		str = StT[1][1]..". "..StT[2]
	elseif #StS > 21-sz-(20-max) then
		str = StS:sub(1,20-sz-2-(20-max)).."..."
	else
		str = StS
	end
	self:STR1(str,stay)
end
TRAIN_SYSTEM.LoadSeq = "/-\\|"
function TRAIN_SYSTEM:ClientThink()
	self.LoadSeq = "/-\\|"
	local State = self.Train:GetNWInt("Announcer:State",-1)
	self:STR1(true)
	if State == 0 then
		self:STR1("loading:")
		self:STR1(self.LoadSeq[math.floor(CurTime()%0.5*8)+1],true)
		
		self:STR1("ver 0.8")
	end
	
	if State == 1 then
		self:STR1("ann initialized")
		self:STR1("press menu to start")
	end
	if State == 2 then
		local RouteNumber = self.Train:GetNWString("Announcer:RouteNumber","00")
		local Pos = self.Train:GetNWInt("Announcer:State2Pos",1)
		self:STR1("enter route number")
		if Pos == 1 then
			self:STR1("_") 
		end
		self:STR1(RouteNumber[1],Pos == 1)
		if Pos == 2 then
			self:STR1("_",true)
		end
		self:STR1(RouteNumber[2],true)
		if Pos == 3 then
			if CurTime()%3 > 1.5 then
				self:STR1(" \"menu\" - accept",true)
			else
				self:STR1("    \"-\" - cancel",true)
			end
		end
	end

	if State == 3 then
		local Line = self.Train:GetNWInt("Announcer:Line",0)
		local St = Metrostroi.EndStations[Line][1]
		local En =Metrostroi.EndStations[Line][#Metrostroi.EndStations[Line]]
		self:STR1("choose route")
		self:STR1("_")
		self:STR1(Line, true)
		local tim = CurTime()%4.5
		if tim < 1.5 then
			self:STR1(" ",true)
			self:STR1(St,true)
			self:STR1("->",true)
			self:STR1(En,true)
		elseif tim < 3 then
			self:STR1(" ST:",true)
			self:DisplayStation(St,true)
		else
			self:STR1(" EN:",true)
			self:DisplayStation(En,true)
		end
	end

	if State == 4 then
		local Line = self.Train:GetNWInt("Announcer:Line",0)
		local StSt = self.Train:GetNWInt("Announcer:FirstStation",1)
		local St =Metrostroi.EndStations[Line][StSt]
		self:STR1("Choose start station")
		self:STR1(St)
		local tim = CurTime()%4.5
		self:STR1(":",true)
		self:DisplayStation(St,true)
	end

	if State == 5 then
		local Line = self.Train:GetNWInt("Announcer:Line",0)
		local StSt = self.Train:GetNWInt("Announcer:LastStation",1)
		local St =Metrostroi.EndStations[Line][StSt]
		self:STR1("Choose end station")
		self:STR1(St)
		local tim = CurTime()%4.5
		self:STR1(":",true)
		self:DisplayStation(St,true)
	end

	if State == 6 then
		local Style = self.Train:GetNWInt("Announcer:Style",1)
		self:STR1("Choose style")
		self:STR1(Metrostroi.PlayingStyles[Style])
	end

	if State == 7 then
		local Line = self.Train:GetNWInt("Announcer:Line",0)
		local StStF = self.Train:GetNWInt("Announcer:FirstStation",1)
		local StStL = self.Train:GetNWInt("Announcer:LastStation",1)
		local StF =Metrostroi.EndStations[Line][StStF]
		local StL =Metrostroi.EndStations[Line][StStL]
		local Style = self.Train:GetNWInt("Announcer:Style",1)
		self:STR1("Check set.")
		local tim = CurTime()%6
		if tim < 1.5 then
			self:STR1("Line:")
			self:STR1(Line,true)
		elseif tim < 3 then
			self:STR1("ST:")
			self:DisplayStation(StF,true)
		elseif tim < 4.5 then
			self:STR1("EN:")
			self:DisplayStation(StL,true)
		else
			self:STR1("Style:")
			self:STR1(Metrostroi.PlayingStyles[Style],true)
		end
	end
end


Metrostroi.PlayingStyles = {"Moscow","St. Petersburg","Kiev"}

function TRAIN_SYSTEM:UpdateAnnouncer()
	for k,v in pairs(self.Train.WagonList) do
		if v.ASNP then
			if v ~= self.Train then
				if self.Line then v.ASNP.Line = self.Line end
				if self.FirstStation then v.ASNP.LastStation = self.FirstStation end
				if self.LastStation then v.ASNP.FirstStation = self.LastStation  end
			end
		end
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	if self.State == 1 and name == "Custom3" then self:SetState(2) return end

	if self.State == 2 then
		if name == "Custom1" and self.State2Pos < 3  then 
			local num = tonumber(self.RouteNumber[self.State2Pos]) - 1
			if num < 0 then num = 9 end
			self.RouteNumber = string.SetChar(self.RouteNumber,self.State2Pos,num)
			self:UpdateAnnouncer()
		end
		if name == "Custom2" and self.State2Pos < 3 then 
			local num = tonumber(self.RouteNumber[self.State2Pos]) + 1
			if num > 9 then num = 0 end
			self.RouteNumber = string.SetChar(self.RouteNumber,self.State2Pos,num)
			self:UpdateAnnouncer()
		end
		if name == "Custom2" and self.State2Pos == 3 then 
			self.State2Pos = 1
		end
		if name == "Custom3" then
			if self.State2Pos < 3 then
				self.State2Pos = self.State2Pos+1
			else
				self:SetState(3)
				return
			end
		end
	end

	if self.State == 3 then
		if name == "Custom1" then 
			self.Line = self.Line - 1
			if self.Line < 1 then self.Line = #Metrostroi.WorkingStations end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then 
			self.Line = self.Line + 1
			if self.Line > #Metrostroi.WorkingStations then self.Line = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(4)
			return
		end
	end

	if self.State == 4 then
		if name == "Custom1" then 
			self.FirstStation = self.FirstStation - 1
			if self.FirstStation < 1 then self.FirstStation = #Metrostroi.EndStations[self.Line] end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then 
			self.FirstStation = self.FirstStation + 1
			if self.FirstStation > #Metrostroi.EndStations[self.Line] then self.FirstStation = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(5)
			return
		end
	end

	if self.State == 5 then
		if name == "Custom1" then 
			self.LastStation = self.LastStation - 1
			if self.LastStation < 1 then self.LastStation = #Metrostroi.EndStations[self.Line] end
			if self.LastStation == self.FirstStation then self:Trigger("Custom1") return end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then 
			self.LastStation = self.LastStation + 1
			if self.LastStation > #Metrostroi.EndStations[self.Line] then self.LastStation = 1 end
			if self.LastStation == self.FirstStation then print(1) self:Trigger("Custom2") return end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(6)
			return
		end
	end

	if self.State == 6 then
		if name == "Custom1" then 
			self.Style = self.Style - 1
			if self.LastStation < 1 then self.LastStation = #Metrostroi.PlayingStyles end
			self:UpdateAnnouncer()
		end
		if name == "Custom2" then 
			self.Style = self.Style + 1
			if self.Style > #Metrostroi.PlayingStyles then self.Style = 1 end
			self:UpdateAnnouncer()
		end
		if name == "Custom3" then
			self:SetState(7)
			return
		end
	end

	if self.State == 7 then
		if name == "Custom1" or name == "Custom2" then 
			self:SetState(2)
			return
		end
		if name == "Custom3" then
			self:SetState(8)
			return
		end
	end
end

function TRAIN_SYSTEM:GetTimer(val)
	return self.TimerMod and (CurTime() - self.Timer) > val
end
function TRAIN_SYSTEM:SetTimer(mod)
	if mod then
		if self.TimerMod == mod then return end
		self.TimerMod = mod
	else
		self.TimerMod = nil
	end
	self.Timer = CurTime()
end

function TRAIN_SYSTEM:SetState(state,state7,noupd)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if state and self.State ~= state then
		self.State = state
		if state == 1 or state == 1.1 then
			self.NextState = add
		end
		self:SetTimer()
	elseif not state then
		state = self.NextState
		self.State = self.NextState
	else
		return
	end
	if state == 0 then
		self.LoadTimer = math.random(1,3)
	end
	if state == 2 then
		self.State2Pos = 1
	end
	if state == 3 then
		self.Line = self.Line or 1
	end
	if state == 4 then
		self.FirstStation = self.FirstStation or 1
	end
	if state == 5 then
		self.LastStation = self.LastStation or self.LastStation ~= self.FirstStation and #Metrostroi.EndStations[self.Line] or 1
	end
	if state == 6 then
		self.Style = 1
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
function TRAIN_SYSTEM:Think()
	local Train = self.Train
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 and self.State > -1  then
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
	if self.Train.R_Radio.Value > 0.5 and self.State == -1 then
		self:SetState(0)
	end
	if self.Train.R_Radio.Value < 0.5 and self.State ~= -1 then
		self:SetState(-1)
	end
	
	if self.State == 0 then
		self:SetTimer(0)
		if self:GetTimer(self.LoadTimer) then
			self.LoadTimer = nil
			self:SetState(1)
		end
	end
	self.Train:SetNWInt("Announcer:State",self.State)
		self.Train:SetNWInt("Announcer:Line",self.Line)
		self.Train:SetNWInt("Announcer:FirstStation",self.FirstStation)
		self.Train:SetNWInt("Announcer:LastStation",self.LastStation)
	if self.State == 2 then
		self.Train:SetNWString("Announcer:RouteNumber",self.RouteNumber)
		self.Train:SetNWInt("Announcer:State2Pos",self.State2Pos)
	end
	if self.State == 6 then
		self.Train:SetNWString("Announcer:Style",self.Style)
	end
end
