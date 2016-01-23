--------------------------------------------------------------------------------
-- Радиостанция типа "Моторола"
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("Motorola")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("MotorolaF1","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaMenu","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaF2","Relay","Switch",{button = true})

	self.Train:LoadSystem("MotorolaOff","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaUp","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaDown","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaLeft","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaRight","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaOn","Relay","Switch",{button = true})

	self.Train:LoadSystem("Motorola1","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola2","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola3","Relay","Switch",{button = true})

	self.Train:LoadSystem("Motorola4","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola5","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola6","Relay","Switch",{button = true})

	self.Train:LoadSystem("Motorola7","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola8","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola9","Relay","Switch",{button = true})

	self.Train:LoadSystem("Motorola*","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola0","Relay","Switch",{button = true})
	self.Train:LoadSystem("Motorola#","Relay","Switch",{button = true})

	self.Train:LoadSystem("MotorolaF4","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaF5","Relay","Switch",{button = true})
	self.Train:LoadSystem("MotorolaF6","Relay","Switch",{button = true})

	self.TriggerNames = {
		"MotorolaF1",
		"MotorolaMenu",
		"MotorolaF2",
		
		"MotorolaOff",
		"MotorolaUp",
		"MotorolaDown",
		"MotorolaLeft",
		"MotorolaRight",
		"MotorolaOn",

		"Motorola1",
		"Motorola2",
		"Motorola3",

		"Motorola4",
		"Motorola5",
		"Motorola6",
		
		"Motorola7",
		"Motorola8",
		"Motorola9",

		"Motorola*",
		"Motorola0",
		"Motorola#",

		"MotorolaF4",
		"MotorolaF5",
		"MotorolaF6",
	}
	self.Enabled = true
	self.Triggers = {}
	self.Timer = CurTime()
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.FirstStation = ""
	self.LastStation = ""
	self.Bright = 1
	self.MenuChoosed = 0
	self.AnnMenuChoosed = 0
	self.Mode = 0
	self.Mode1 = 0
end
function TRAIN_SYSTEM:ClientInitialize()
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	local gr_up = Material("vgui/gradient-d")
	function TRAIN_SYSTEM:Motorola(train)
		surface.SetAlphaMultiplier(1)
		draw.NoTexture()

		if train:GetNWInt("Motorola:State",-1) >= 0 then
			surface.SetDrawColor(Color(20,20,20))
			surface.DrawRect(0,0,140,107)
		else
			surface.SetDrawColor(Color(0,0,0))
			surface.DrawRect(0,0,140,107)
		end
		--surface.SetAlphaMultiplier(train:GetNWInt("Motorola:Bright",1))
		if train:GetNWInt("Motorola:State",-1) == 1 then
			surface.SetDrawColor(Color(255,255,255))
			surface.DrawRect(0,0,94,107)
			surface.SetDrawColor(Color(139,200,235))
			surface.DrawRect(94,0,46,107)
			Metrostroi.DrawLine(7, 2, 10, 5,Color(0,0,0),1)
			Metrostroi.DrawLine(10, 1, 10, 9,Color(0,0,0),1)
			Metrostroi.DrawLine(13, 2, 10, 5,Color(0,0,0),1)
			
			Metrostroi.DrawLine(16, 8, 16, 9,Color(060,240,106),1)
			Metrostroi.DrawLine(18, 6, 18, 9,Color(060,240,106),1)
			Metrostroi.DrawLine(20, 4, 20, 9,Color(060,240,106),1)
			Metrostroi.DrawLine(22, 2, 22, 9,Color(060,240,106),1)
			if not train:GetNWBool("Motorola:Menu",false) and train:GetNWInt("Motorola:Mode",0) == 0 then
				local RouteNumber = train:GetNWInt("Motorola:RouteNumber",-1) > -1 and tostring(train:GetNWInt("Motorola:RouteNumber")) or "N/A"
				draw.SimpleText(train:EntIndex().."/"..RouteNumber,"Metrostroi_PAM1_20",47, 30,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Folder 1","Metrostroi_PAM1_20",47, 48,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("TRL "..(train:GetNWInt("Motorola:Line",0) > 0 and train:GetNWInt("Motorola:Line") or "N/A"),"Metrostroi_PAM1_20",47, 66,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(os.date("%d-%m-%y %H.%M",os.time()),"Metrostroi_PAM15",47, 82,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("DURA","Metrostroi_PAM15",117, 23,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawLine(94, 47, 140, 47,Color(89,150,175),1)
				draw.SimpleText("Menu","Metrostroi_PAM15",117, 53,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		
				draw.SimpleText("Annou-","Metrostroi_PAM15",117, 77,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("nces	","Metrostroi_PAM15",117, 89,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawLine(94, 61, 140, 61,Color(89,150,175),1)
			elseif train:GetNWInt("Motorola:Mode",0) == 0 then
				Metrostroi.DrawRectOL(1,13*1, 93, 13,Color(89,150,175),1,Color(139,200,235))
				draw.SimpleText("Main Menu","Metrostroi_PAM15",46, 6+13*1,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--surface.DrawRect(0,13*1,94,13)
				surface.SetDrawColor(Color(255,255,255))
				surface.DrawRect(94,47,46,14)
				draw.SimpleText("Back","Metrostroi_PAM15",117, 23,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Select","Metrostroi_PAM15",117, 83,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

				surface.SetDrawColor(Color(103,178,209))
				surface.DrawRect(11,1+13*(2+train:GetNWInt("Motorola:MenuChoosed",0)) , 83, 13)

				draw.SimpleText("UPO","Metrostroi_PAM15",13, 7+13*2,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("Route number","Metrostroi_PAM15",13, 7+13*3,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("Announces","Metrostroi_PAM15",13, 7+13*4,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("DURA","Metrostroi_PAM15",13, 7+13*5,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			else
				surface.SetDrawColor(Color(255,255,255))
				if train:GetNWInt("Motorola:Mode",0) == 2 then surface.DrawRect(94,47,46,60) else surface.DrawRect(94,47,46,14) end
				draw.SimpleText("Back","Metrostroi_PAM15",117, 23,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				if train:GetNWInt("Motorola:Mode",0) == 1 then draw.SimpleText("OK","Metrostroi_PAM15",117, 83,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
				if train:GetNWInt("Motorola:Mode",0) == 1 then
					local Line = train:GetNWInt("Motorola:Line",-1) > -1 and tostring(train:GetNWInt("Motorola:Line")) or ""
					local FirstStation = train:GetNWInt("Motorola:FirstStation",-1) > -1 and tostring(train:GetNWInt("Motorola:FirstStation")) or ""
					local LastStation = train:GetNWInt("Motorola:LastStation",-1) > -1 and tostring(train:GetNWInt("Motorola:LastStation")) or ""
			
					Metrostroi.DrawRectOL(1,13 + 32*0, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("Line","Metrostroi_PAM15",46, 19+32*0,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText(Line,"Metrostroi_PAM1_20",5, 35 + 32*0,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					if train:GetNWInt("Motorola:Mode1",0) == 0 and CurTime()%0.5>0.25 then Metrostroi.DrawLine(5 +9*#Line, 40 + 32*0, 15+9*#Line, 40 + 32*0,Color(0,0,0),2) end

					Metrostroi.DrawRectOL(1,13 + 32*1, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("First station","Metrostroi_PAM15",46, 19+32*1,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText(FirstStation,"Metrostroi_PAM1_20",5, 35 + 32*1,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					if train:GetNWInt("Motorola:Mode1",0) == 1 and CurTime()%0.5>0.25 then Metrostroi.DrawLine(5 +9*#FirstStation, 40 + 32*1, 15+9*#FirstStation, 40 + 32*1,Color(0,0,0),2) end

					Metrostroi.DrawRectOL(1,13 + 32*2, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("Last station","Metrostroi_PAM15",46, 19+32*2,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText(LastStation,"Metrostroi_PAM1_20",5, 35 + 32*2,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					if train:GetNWInt("Motorola:Mode1",0) == 2 and CurTime()%0.5>0.25 then Metrostroi.DrawLine(5 +9*#LastStation, 40 + 32*2, 15+9*#LastStation, 40 + 32*2,Color(0,0,0),2) end
				end
				
				if train:GetNWInt("Motorola:Mode",0) == 2 then
					Metrostroi.DrawRectOL(1,13*1, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("Route number","Metrostroi_PAM15",46, 6+13*1,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					local RouteNumber = train:GetNWInt("Motorola:RouteNumber",-1) > -1 and tostring(train:GetNWInt("Motorola:RouteNumber")) or ""
					draw.SimpleText(RouteNumber,"Metrostroi_PAM1_20",5, 35,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					if CurTime()%0.5>0.25 then Metrostroi.DrawLine(5 +9*#RouteNumber, 40, 15+9*#RouteNumber, 40,Color(0,0,0),2) end
				end
				if train:GetNWInt("Motorola:Mode",0) == 3 then
					Metrostroi.DrawRectOL(1,13*1, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("Announces","Metrostroi_PAM15",46, 6+13*1,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					--surface.DrawRect(0,13*1,94,13)
					surface.SetDrawColor(Color(255,255,255))
					surface.DrawRect(94,47,46,14)
					draw.SimpleText("Back","Metrostroi_PAM15",117, 23,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("Play","Metrostroi_PAM15",117, 83,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

					surface.SetDrawColor(Color(103,178,209))
					surface.DrawRect(3,1+13*(2+train:GetNWInt("Motorola:AnnMenuChoosed",0)) , 88, 13)

					draw.SimpleText("Go out from tr..","Metrostroi_PAM15",5, 7+13*2,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					draw.SimpleText("Go faster","Metrostroi_PAM15",5, 7+13*3,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					draw.SimpleText("Release doors","Metrostroi_PAM15",5, 7+13*4,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					draw.SimpleText("Train dep. soon","Metrostroi_PAM15",5, 7+13*5,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				end
				if train:GetNWInt("Motorola:Mode",0) == 4 then
					Metrostroi.DrawRectOL(1,13*1, 93, 13,Color(89,150,175),1,Color(139,200,235))
					draw.SimpleText("Dura control","Metrostroi_PAM15",46, 6+13*1,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					--surface.DrawRect(0,13*1,94,13)
					surface.SetDrawColor(Color(255,255,255))
					surface.DrawRect(94,47,46,14)
					draw.SimpleText("Back","Metrostroi_PAM15",117, 23,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("Select","Metrostroi_PAM15",117, 83,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					
					local RouteNumber = train:GetNWInt("Motorola:RouteNumber",-1) > -1 and tostring(train:GetNWInt("Motorola:RouteNumber")) or ""
					draw.SimpleText(RouteNumber,"Metrostroi_PAM1_20",5, 35,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
					if CurTime()%0.5>0.25 then Metrostroi.DrawLine(5 +9*#RouteNumber, 40, 15+9*#RouteNumber, 40,Color(0,0,0),2) end
				end
				
			end
		end
		surface.SetAlphaMultiplier(1-train:GetNWInt("Motorola:Bright",1))
		surface.SetDrawColor(Color(20,20,20))
		surface.DrawRect(0,0,145,110)
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

function TRAIN_SYSTEM:Trigger(name)
	if self.Mode == 0 then
		if self.Menu then
			if name == "MotorolaF1" then
				self.Menu = false
			end
			if name == "MotorolaUp" then
				self.MenuChoosed = math.max(0,self.MenuChoosed  - 1)
			end
			if name == "MotorolaDown" then
				self.MenuChoosed = math.min(3,self.MenuChoosed  + 1)
			end
			if name == "MotorolaF2" then
				self.Mode = self.MenuChoosed + 1
				
				if self.Mode == 3 then
					self.AnnChoosed = 0
				end
			end
			local Char = tonumber(name:sub(9,9))
			if Char and Char > 0 and Char < 5 then
				self.Mode = Char
			end
		else
			if name == "MotorolaF2" then
				self.Mode = 3
				self.AnnChoosed = 0
			end
			if name == "MotorolaF1" then
				self.Mode = 4
			end
			if name == "MotorolaMenu" then
				self.Menu = true
				self.MenuChoosed = 0
			end
		end
	else
		if self.Mode == 1 then
			if name == "MotorolaUp" then
				self.Mode1 = math.max(0,self.Mode1  - 1)
			end
			if name == "MotorolaDown" then
				self.Mode1 = math.min(2,self.Mode1  + 1)
			end
			if name == "MotorolaLeft" then
				if self.Mode1 == 1 then
					self.FirstStation= self.FirstStation:sub(1,-2)
				end
				if self.Mode1 == 2 then
					self.LastStation= self.LastStation:sub(1,-2)
				end
				self:UpdateUPO()
			end

			local Char = tonumber(name:sub(9,9))
			if Char then
				if self.Mode1 == 0 then
					self.Line = Char
					if Metrostroi.WorkingStations[self.Line] then
						local Routelength = #Metrostroi.WorkingStations[self.Line]
						self.FirstStation = tostring(Metrostroi.WorkingStations[self.Line][1])
						self.LastStation = tostring(Metrostroi.WorkingStations[self.Line][Routelength])
					end
				end
				if self.Mode1 == 1 and #self.FirstStation < 3 and (Char ~= 0 or #self.FirstStation > 0) then
					self.FirstStation= self.FirstStation..tostring(Char)
				end
				if self.Mode1 == 2 and #self.LastStation < 3 and (Char ~= 0 or #self.LastStation > 0) then
					self.LastStation= self.LastStation..tostring(Char)
				end
				self:UpdateUPO()
			end
			if name == "MotorolaF2" then
				if not Metrostroi.WorkingStations[self.Line] or
					not Metrostroi.WorkingStations[self.Line][tonumber(self.FirstStation)] or 
					not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
					not Metrostroi.WorkingStations[self.Line][tonumber(self.LastStation)] or 
					not Metrostroi.AnnouncerData[tonumber(self.LastStation)] then
					self.Error = not self.Error
				else
					if not self.Error then self.Mode = 0 else self.Error = false end
				end
			end
		--[[
			if name == "MotorolaLeft" then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
			local Char = tonumber(name:sub(9,9))
			if Char and self.RouteNumber and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end]]
		end
		if self.Mode == 2 then
			if name == "MotorolaLeft" then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
			local Char = tonumber(name:sub(9,9))
			if Char and self.RouteNumber and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		
		if self.Mode == 3 then
			if name == "MotorolaUp" then
				self.AnnMenuChoosed = math.max(0,self.AnnMenuChoosed  - 1)
			end
			if name == "MotorolaDown" then
				self.AnnMenuChoosed = math.min(3,self.AnnMenuChoosed  + 1)
			end
			if name == "MotorolaF2" then
				self.Mode = 0
				
				self.Train.UPO:II(self.AnnMenuChoosed+1)
			end
			local Char = tonumber(name:sub(9,9))
			if Char and Char > 0 and Char < 5 and self.Train.R_UPO.Value > 0 then
				self.Mode = 0
				self.Train.UPO:II(Char)
				self.AnnChoosed = 0
			end
		end
		if name == "MotorolaF1" then
			if not self.Error then self.Mode = 0 else self.Error = false end
		end
	end
	if name == "MotorolaF6" then
		self.Bright = self.Bright + 0.25
		if self.Bright > 1 then self.Bright = 0 end
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

function TRAIN_SYSTEM:SetState(state,add,state9)
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
	
	if state == 1 then self.Bright = 1 end
end
function TRAIN_SYSTEM:Think(dT)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if Train.MotorolaOff.Value >0.5 and not self.OffTimer and not self.OnTimer then --self.VPA and 
		if self.Enabled then
			self.OffTimer = CurTime() + 1
		else
			self.Enabled = true
		end
	end
	if self.OffTimer and (CurTime() - self.OffTimer) > 0 then
		self.Enabled = false
	end
	if Train.MotorolaOff.Value <0.5  and self.OffTimer then
		self.OffTimer = nil
	end
	if Train.Panel["V1"] < 0.5 or Train.VB.Value < 0.5 then self:SetState(-1) end
	if not self.Enabled then self:SetState(-1) end
	if self.Enabled and self.State == -1 and Train.Panel["V1"] > 0.5 and Train.VB.Value > 0.5 then self:SetState(0) end
	
	--self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
	--self.Train.UPO.Path = self.Train:ReadCell(49170)
	--self.Train.UPO.Distance = math.min(9999,self.Train:ReadCell(49165) + (Train.Autodrive.Corrections[self.Train.UPO.Station] or 0) - 4.3)
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 and self.State > 0  then
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
	
	if self.State == 0 then
		self:SetTimer(1)
		if self:GetTimer(3) then
			self:SetState(1)
		end
	end
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end
	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		Train:SetNWInt("Motorola:State",self.State)
		Train:SetNWInt("Motorola:Line",Train.UPO.Line)
		Train:SetNWInt("Motorola:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		Train:SetNWInt("Motorola:Bright",self.Bright)
		Train:SetNWBool("Motorola:Menu",self.Menu == true)
		Train:SetNWInt("Motorola:MenuChoosed",self.MenuChoosed)
		Train:SetNWInt("Motorola:Mode",self.Mode)
		Train:SetNWBool("Motorola:Error",self.Error)
		if self.Mode == 1 then
			Train:SetNWInt("Motorola:Mode1",self.Mode1)
			Train:SetNWInt("Motorola:FirstStation",tonumber(self.FirstStation ~= "" and self.FirstStation or -1))
			Train:SetNWInt("Motorola:LastStation",tonumber(self.LastStation ~= "" and self.LastStation or -1))
		elseif self.Mode == 2 then
		elseif self.Mode == 3 then
			Train:SetNWInt("Motorola:AnnMenuChoosed",self.AnnMenuChoosed)
		end
	end
	self.RouteNumber = string.gsub(Train.RouteNumber or "","^(0+)","")
	self.Line = Train.UPO.Line
	self.FirstStation = tostring(Train.UPO.FirstStation or "")
	self.LastStation = tostring(Train.UPO.LastStation or "")
	self.RealState = self.State
end
