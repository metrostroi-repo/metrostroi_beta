--------------------------------------------------------------------------------
-- АСОТП "ИГЛА"
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("IGLA")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
	self.States = {}
	self.Messages = {}
	self.MessageCount = 0
	self.Train:LoadSystem("IGLA1","Relay","Switch",{igla = true})
	self.Train:LoadSystem("IGLA2","Relay","Switch",{igla = true})
	self.Train:LoadSystem("IGLA3","Relay","Switch",{igla = true})
	self.Train:LoadSystem("IGLA4","Relay","Switch",{igla = true})

	self.TriggerNames = {
		"IGLA1",
		"IGLA2",
		"IGLA3",
		"IGLA4",
	}
	self.Triggers = {}
	self.Timer = CurTime()
	self.Time = 0
	self.State = 0
	self.RealState = 99
end
function TRAIN_SYSTEM:ClientInitialize()
	self.STRr = {}
	self.STRx = 1
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "" }
end
if CLIENT then
	function TRAIN_SYSTEM:STR(str,notchange)
		if SERVER then return end
		if str == true then
			for i = 1,2 do
				self.STRr[i] = ""
			end
			self.STRx = 1
		else
			if notchange and self.STRx > 5 or not notchange and self.STRx > 4 then print("STR:ERR:MAX",str) return end
			if notchange then
				self.STRr[self.STRx-1] = self.STRr[self.STRx-1]..str
			else
				self.STRr[self.STRx] = str or ""
				self.STRx = self.STRx + 1
			end
		end
	end
	TRAIN_SYSTEM.StartRandom = {" ","full","lhalf","rhalf","shade"}
	TRAIN_SYSTEM.Chars = {
		full  = utf8.char(0x2588),
		lhalf = utf8.char(0x258C),
		rhalf = utf8.char(0x2590),
		shade = utf8.char(0x2592),
		[1]   = utf8.char(0x2776),
		[2]   = utf8.char(0x2777),
		[3]   = utf8.char(0x2778),
		[4]   = utf8.char(0x2779),
		[5]   = utf8.char(0x277A),
		[6]   = utf8.char(0x277B),
		[7]   = utf8.char(0x277C),
		[8]   = utf8.char(0x277D),
		[9]   = utf8.char(0x277E),
		[0]   = utf8.char(0x24FF),
	}
	TRAIN_SYSTEM.Converter = {
		["\1"]   = TRAIN_SYSTEM.Chars[1],
		["\2"]   = TRAIN_SYSTEM.Chars[2],
		["\3"]   = TRAIN_SYSTEM.Chars[3],
		["\4"]   = TRAIN_SYSTEM.Chars[4],
		["\5"]   = TRAIN_SYSTEM.Chars[5],
		["\6"]   = TRAIN_SYSTEM.Chars[6],
		["\7"]   = TRAIN_SYSTEM.Chars[7],
		["\8"]   = TRAIN_SYSTEM.Chars[8],
		["\9"]   = TRAIN_SYSTEM.Chars[9],
		["\0"]   = TRAIN_SYSTEM.Chars[0],
	}
	TRAIN_SYSTEM.Translit = {a="а",b="б",c="ц",d="д",e="е",f="ф",g="г",h="х",i="и",j="ж",k="к",l="л",m="м",n="н",o="о",p="п",q="я",r="р",s="с",t="т",u="у",v="в",w="ш",x="х",y="й",z="з",}
	function TRAIN_SYSTEM:Format(num)
		if num == 1 then return ""
		elseif 1 < num and num < 5 then return "а" end
		return "ов"
	end
	function TRAIN_SYSTEM:Format2(num)
		if num == 1 then return "ка"
		elseif 1 < num and num < 5 then return "ки" end
		return "ок"
	end
	function TRAIN_SYSTEM:IGLA(train)
		for i=1,20 do
			--surface.SetDrawColor(Color(0,0,100,155))
			--surface.DrawRect(54+(i-1)*25.1,70,20,30)
			--surface.DrawRect(54+(i-1)*25.1,70+35,20,30)
		end
		for y = 0,#self.STRr-1 do
			local xmin = 0
			local blink = false
			local skip = false
			local half = false
			for x = 0,utf8.len(self.STRr[y+1])-1 do
				local str = {utf8.codepoint(self.STRr[y+1],1,-1)}
				local char = utf8.char(str[x+1])
				if char == "@" then
					blink = true
					xmin = xmin + 1
					skip = true
				end
				if char == "%" then
					half = true
					xmin = xmin + 1
					skip = true
				end
				if blink == 1 then
					blink = false
					xmin = xmin + 1
					skip = true
				end
				if not skip and (blink and CurTime()%1<=0.5 or char == "_" and CurTime()%0.5<=0.25 or not blink and char ~= "_") then
					if char == "_" then char = self.Chars.full end
					draw.DrawText(self.Converter[char] or char,"MetrostroiSubway_IGLA",54+(x-xmin)*25.1-2,68+y*34,Color(0,200,255,half and 75 or 255))
					--draw.DrawText(self.Converter[char] or char,"MetrostroiSubway_PAKSD1",(x-xmin)*28,y*49+8, Color(110,209,182))
				end
				skip = false
			end
		end
	end
	function TRAIN_SYSTEM:ClientThink()
		self.Time = self.Time or CurTime()
		if (CurTime() - self.Time) > 0.1 then
			self.Time = CurTime()
			self:STR(true)
			local State = self.Train:GetNW2Int("IGLA:State",0)
			if self.OldState ~= State then
				if State == -1 then
					self.StartSTR = ""
					self.StartSTR2 = ""
					for i=1,20 do
						self.StartSTR = self.StartSTR..(self.Chars[self.StartRandom[math.random(5)]] or " ")
						self.StartSTR2 = self.StartSTR2..(self.Chars[self.StartRandom[math.random(5)]] or " ")
					end
				end
				self.OldState = State
			end
			--print(State)
			if State == -1 then
				print(self.StartSTR)
				self:STR(self.StartSTR)
				self:STR(self.StartSTR2)
			elseif State == 0 then
				self:STR("_")
			elseif State == 1 then
				self:STR("к 15в 5в 3.3в бт пчм")
				if self.Train:GetNW2Bool("IGLA:1P",false) and self.Train:GetNW2Bool("IGLA:1C",false) and self.Train:GetNW2Bool("IGLA:1M",false) then
					self:STR("1")
				else
					self:STR("0")
				end
				self:STR(" 15 5.0 3.2 2.9 ",true)
				self:STR(self.Train:GetNW2Bool("IGLA:1P",false) and "." or " ",true)
				self:STR(self.Train:GetNW2Bool("IGLA:1C",false) and "." or " ",true)
				self:STR(self.Train:GetNW2Bool("IGLA:1M",false) and "." or " ",true)
			elseif State == 2 then
				local Num = self.Train:GetNW2Int("IGLA:Count",0)
				local Standby = self.Train:GetNW2Bool("IGLA:Standby",false)
				local Low = self.Train:GetNW2Bool("IGLA:Low",false)
				local StandbyShow = self.Train:GetNW2Bool("IGLA:StandbyShow",false)
				local MessageCount = self.Train:GetNW2Int("IGLA:MessageCount",0)
				if MessageCount > 0 and not self.Train:GetNW2Bool("IGLA:IgnoreMessages",false) then
					local i = self.Train:GetNW2Int("IGLA:SelectedMessage",MessageCount)
					local wag = self.Train:GetNW2Int("IGLA:Message"..i.."_train")
					local typ = self.Train:GetNW2String("IGLA:Message"..i)
					if typ == "AKB" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("акб вагона выкл"))
					end
					if typ == "RP" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("сработка РП вагона!"))
					end
					if typ == "DOORS" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("двери вагона откр!"))
					end
					if typ == "BC" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("колодки прижаты!"))
					end
					if typ == "LK" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("несбор схемы вагона!"))
					end
					if typ == "TL" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("низкое давление НМ!"))
					end
					if typ == "BPSN" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("БПСН вагона откл!"))
					end
					if typ == "PARK" then
						self:STR(Format("%05d%s%s сообщение",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("стоян тормоз вагона!"))
					end
					if typ == "FIRE" then
						self:STR(Format("%05d%s%s птр    | квц",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						if CurTime()%2 > 1 then
							if CurTime()%0.5 > .25 then
								self:STR("%!!! ПИЗДА ПОЕЗДУ !!!")
							else
								self:STR("!!! ПИЗДА ПОЕЗДУ !!!")
							end
						else
							self:STR(Format("пожар  неиспр  | вкл"))
						end
					end
					if typ == "OVER" then
						self:STR(Format("%05d%s%s   птр  | квц",wag,MessageCount > 1 and "+" or " ",MessageCount > 1 and MessageCount-1 or " "))
						self:STR(Format("перегр T=%4dС | вкл",self.Train:GetNW2Int("IGLA:Message"..i.."_1",0)))
					end
				elseif Standby then
					if MessageCount == 0 or CurTime()%3 >1 then
						self:STR()
					else
						self:STR("%")
						self:STR(tostring(MessageCount),true)
						self:STR(" ошиб",true)
						self:STR(self:Format2(MessageCount),true)
						self:STR("!",true)
					end
					if StandbyShow then
						local date = os.date("!*t")
						self:STR(Format("%%%02d-%02d-%02d    %02d:%02d:%02d",date.day,date.month,math.ceil(date.year%100),date.hour,date.min,date.sec))
					else
						self:STR()
					end
				else
					if MessageCount == 0 or CurTime()%3 >1 then
						self:STR(Low and "%" or "")
						self:STR("асотп ",true)
						self:STR(Num,true)
						self:STR(" комплект",true)
						self:STR(self:Format(Num),true)
					else
						self:STR(tostring(MessageCount))
						self:STR(" ошиб",true)
						self:STR(self:Format2(MessageCount),true)
						self:STR("!",true)

					end
					local date = os.date("!*t")
					self:STR(Format("%s%02d-%02d-%02d    %02d:%02d:%02d",Low and "%" or "",date.day,date.month,math.ceil(date.year%100),date.hour,date.min,date.sec))
				end
				--[[
				if Fire > 0 then
				elseif Warn > 0 then
					self:STR(Format("%05d%s   птр  | квц",WarnWagonNumber,Warn > 1 and "+"..tostring(Warn-1) or "  "))
					self:STR(Format("перегр T=%4dС | вкл",T))
				else
				end
				]]
			end
		end
	end
else
	function TRAIN_SYSTEM:Trigger(name,value)
		if self.State == 2 then
			if (self.MessageCount == 0 or self.IgnoreMessages) then
				if name == "IGLA3" and self.MessageCount > 0 then
					self.IgnoreMessages = false
				end
				if name == "IGLA4" then
					if value and self.Standby then
						self.STTimer = CurTime()+1
					end
					if not value and self.Standby and self.STTimer and self.STTimer - CurTime() >= 0 then
						self:SetTimer()
						self.Standby = false
						self.Lower = false
					end
					if not value then
						self.STTimer = nil
					end
				end
			else
				if name == "IGLA1" and self.MessageCount > 0 and value then
					self.SelectedMessage = math.Clamp(self.SelectedMessage-1,1,self.MessageCount)
				end
				if name == "IGLA2" and self.MessageCount > 0 and value then
					self.SelectedMessage = math.Clamp(self.SelectedMessage+1,1,self.MessageCount)
				end
				if name == "IGLA4" and self.MessageCount > 0 and value and not self.IgnoreMessages then
					self.IgnoreMessages = true
				end
			end
		end
	end

	function TRAIN_SYSTEM:SetState(state,state7,noupd)
		local Train = self.Train
		local ARS = Train.ALS_ARS
		local Announcer = Train.Announcer
		if state and self.State ~= state then
			self.State = state
			if noupd then return end
			self:SetTimer()
			if state == 1 then
				Train:PlayOnce("igla_start1","cabin")
				self.State1Pt = CurTime()+math.random(0.5,2.5)
				self.State1Ct = CurTime()+math.random(0.5,2.5)
				self.State1Mt = CurTime()+math.random(0.5,2.5)
			else
				self.State1Pt = nil
				self.State1Ct = nil
				self.State1Mt = nil
			end
			if state == 2 then
				Train:PlayOnce("igla_start2","cabin")
				self.Standby = false
				self.StandbyShow = false
				self.States = {}
				self.Messages = {}
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
	function TRAIN_SYSTEM:Check(num,name,val,scengaged)
		if not self.States[name] then self.States[name] = {} end
		if (scengaged ~= nil and scengaged ~= self.SchemeEngaged) or self.States[name][num] ~= val  then
			local have = false
			for k,v in pairs(self.Messages) do
				if v[1] == name and v[2] == num then
					have = k
					break
				end
			end
			if (scengaged == nil or scengaged) and not val and not have then
				table.insert(self.Messages,{name,num})
				self.IgnoreMessages = false
				self.Train:PlayOnce("igla_start1","cabin")
			elseif val and have then
				table.remove(self.Messages,have)
			end
			self.States[name][num] = val
		end
	end
	function TRAIN_SYSTEM:CheckWTimer(num,name,val,scengaged,time)
		if not self.States[name] then self.States[name] = {} end
		if not self.States[name][num] then self.States[name][num] = {} end
		if not val and (scengaged == nil or scengaged) and not self.States[name][num].timer then
			self.States[name][num].timer = CurTime()+time
		end
		if ((scengaged ~= nil and scengaged ~= self.SchemeEngaged) or self.States[name][num].val ~= val) and self.States[name][num].timer and self.States[name][num].timer-CurTime()<0  then
			local have = false
			for k,v in pairs(self.Messages) do
				if v[1] == name and v[2] == num then
					have = k
					break
				end
			end
			if (scengaged == nil or scengaged) and not val and not have then
				table.insert(self.Messages,{name,num})
				self.IgnoreMessages = false
				self.Train:PlayOnce("igla_start1","cabin")
			elseif val and have then
				table.remove(self.Messages,have)
			end
			self.States[name][num].val = val
		end
		if val and self.States[name][num].timer then
			self.States[name][num].timer = nil
		end
	end
	function TRAIN_SYSTEM:CheckOverheat(num,temp,over)
		local val = temp < 500 or over
		local name = "OVER"
		if not self.States[name] then self.States[name] = {} end
		if not self.States[name][num] then self.States[name][num] = {} end
		if self.States[name][num].val ~= val or self.States[name][num].temp ~= temp  then
			local have = false
			for k,v in pairs(self.Messages) do
				if v[1] == name and v[2] == num then
					have = k
					break
				end
			end
			if not val and not have then
				table.insert(self.Messages,{name,num,temp})
				self.IgnoreMessages = false
				self.MessageCount = #self.Messages
				self.Train:PlayOnce("igla_start1","cabin")
			elseif not val and have then
				self.Messages[have][3] = temp
			elseif val and have then
				table.remove(self.Messages,have)
			end
			self.States[name][num].val = val
		end
	end
	function TRAIN_SYSTEM:Diagnostic(Train)
		local scengaged = Train.KV.ControllerPosition > 0
		self:Check(Train:EntIndex(),"TL",Train.Pneumatic.TrainLinePressure > 5.8,scengaged)
		--print(scengaged)
		for i=1,#Train.WagonList do
			local train = Train.WagonList[i]
			if train.VB and train.A56 then self:Check(train:EntIndex(),"AKB",train.VB.Value > 0.5 and train.A56.Value > 0.5,scengaged) end
			if train.RPvozvrat then self:Check(train:EntIndex(),"RP",train.RPvozvrat.Value < 0.5,scengaged) end
			if train.RD then self:Check(train:EntIndex(),"DOORS",train.RD.Value > 0.5 or Train.VAD.Value > 0.5,scengaged) end
			if train.ParkingBrake then self:Check(train:EntIndex(),"PARK",train.ParkingBrake.Value < 0.5,scengaged) end
			if train.Pneumatic then self:CheckWTimer(train:EntIndex(),"BC",train.Pneumatic.BrakeCylinderPressure < 1 or not scengaged,scengaged,5) end
			if train.LK4 then self:CheckWTimer(train:EntIndex(),"LK",train.LK4.Value > 0.5 or Train.KV.ControllerPosition == 0,nil,5) end
			if train.PowerSupply then self:CheckWTimer(train:EntIndex(),"BPSN",train.PowerSupply.XT3_1 > 50,scengaged,2) end
			if train.Electric then
				self:Check(train:EntIndex(),"FIRE",math.max(train.Electric.Overheat1,train.Electric.Overheat2) == 0)
				self:CheckOverheat(train:EntIndex(),math.max(train.Electric.T1,train.Electric.T1),math.max(train.Electric.Overheat1,train.Electric.Overheat2) > 0)
			end
		end
		self.SchemeEngaged = scengaged
		if self.MessageCount ~= #self.Messages then
			self.MessageCount = #self.Messages
			self.SelectedMessage = self.MessageCount
		end
		for i,msg in pairs(self.Messages) do
			Train:SetNW2String("IGLA:Message"..i,msg[1])
			Train:SetNW2Int("IGLA:Message"..i.."_train",msg[2])
			for num = 3,#msg do
				local data = msg[num]
				if type(data) == "string" then
					Train:SetNW2String("IGLA:Message"..i.."_"..num-2,data)
				else
					Train:SetNW2Int("IGLA:Message"..i.."_"..num-2,data)
				end
			end
		end
	end
	function TRAIN_SYSTEM:Think(dT)
		local Train = self.Train
		if Train.Panel.V1 > 0.5 and Train.A63.Value > 0.5 and self.State > -2  then
			for k,v in pairs(self.TriggerNames) do
				if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
					--if Train[v].Value > 0.5 then
					self:Trigger(v,Train[v].Value > 0.5)
					--end
					--print(v,self.Train[v].Value > 0.5)
					self.Triggers[v] = Train[v].Value > 0.5
				end
			end
		end
		if Train.Panel.V1 < 0.5 or Train.A63.Value < 0.5 then
			if self.State ~= -2 then self:SetState(-2) end
		end
		if self.State == -2 and Train.Panel.V1 > 0.5 and Train.A63.Value > 0.5 then
			self:SetState(-1)
		elseif self.State == -1 then
			self:SetTimer(0)
			if self:GetTimer(0.25) then
				self:SetState(0)
			end
		elseif self.State == 0 then
			self:SetTimer(0)
			if self:GetTimer(1) then
				self:SetState(1)
			end
		elseif self.State == 1 then
			self:SetTimer(0)

			if self:GetTimer(5) then
				self:SetState(2)
			end
		elseif self.State == 2 then
			if not self.Standby then
				self:SetTimer(0)
				if self:GetTimer(7) then
					self.Standby = true
				end
				if self:GetTimer(3.5) then
					self.Lower = true
				end
			end
			if self.STTimer and self.STTimer - CurTime() < 0 then
				self.StandbyShow = not self.StandbyShow
				self.STTimer = false
			end
			self:Diagnostic(Train)
			--print(self.Train.WagonList)
		end
		if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
			self.TimeOverride = nil
			self.Time = CurTime()

			Train:SetNW2Int("IGLA:State",self.State)
			if self.State == 1 then
				Train:SetNW2Bool("IGLA:1P",self.State1Pt - CurTime() < 0)
				Train:SetNW2Bool("IGLA:1C",self.State1Ct - CurTime() < 0)
				Train:SetNW2Bool("IGLA:1M",self.State1Mt - CurTime() < 0)
			elseif self.State == 2 then
				Train:SetNW2Int("IGLA:Count",Train:GetWagonCount())
				Train:SetNW2Bool("IGLA:Low",self.Lower)
				Train:SetNW2Bool("IGLA:Standby",self.Standby)
				Train:SetNW2Bool("IGLA:StandbyShow",self.StandbyShow)
				Train:SetNW2Int("IGLA:MessageCount",self.MessageCount)
				Train:SetNW2Bool("IGLA:IgnoreMessages",self.IgnoreMessages)
				Train:SetNW2Int("IGLA:SelectedMessage",self.SelectedMessage)

			end
		end
	end
end
