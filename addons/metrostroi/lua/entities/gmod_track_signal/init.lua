AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString "metrostroi-signal"
util.AddNetworkString "metrostroi-signal-state"
CreateConVar("metrostroi_ars_independent",0,{FCVAR_ARCHIVE},"Enable independent ARS codes")
function ENT:SetSprite(index,active,model,scale,brightness,pos,color)
	if active and self.Sprites[index] then return end
	if not active and not self.Sprites[index] then return end
	if not active and self.Sprites[index] then
		SafeRemoveEntity(self.Sprites[index])
		self.Sprites[index] = nil
	end

	if active then
		local sprite = ents.Create("env_sprite")
		sprite:SetParent(self)
		sprite:SetLocalPos(pos)
		sprite:SetLocalAngles(self:GetAngles())

		-- Set parameters
		sprite:SetKeyValue("rendercolor",
			Format("%i %i %i",
				color.r*brightness,
				color.g*brightness,
				color.b*brightness
			)
		)
		sprite:SetKeyValue("rendermode", 9) -- 9: WGlow, 3: Glow
		sprite:SetKeyValue("renderfx", 14)
		sprite:SetKeyValue("model", model)
		sprite:SetKeyValue("scale", scale)
		sprite:SetKeyValue("spawnflags", 1)

		-- Turn sprite on
		sprite:Spawn()
		self.Sprites[index] = sprite
	end
end
function ENT:OpenRoute(route)
	self.LastOpenedRoute = route
	if self.Routes[route].Manual then self.Routes[route].IsOpened = true end
	if not self.Routes[route].Switches then return end
	local Switches = string.Explode(",",self.Routes[route].Switches)

	for i1 =1, #Switches do
		if not Switches[i1] or Switches[i1] == "" then continue end

		local SwitchState = Switches[i1]:sub(-1,-1) == "-"
		local SwitchName = Switches[i1]:sub(1,-2)
		--if not self.Switches[SwitchName] then self.Switches[SwitchName] = Metrostroi.GetSwitchByName(SwitchName) end
		if not Metrostroi.GetSwitchByName(SwitchName) then print(self.Name,"switch not found") continue end
		--If route go right from this switch - add it
		if SwitchState ~= (Metrostroi.GetSwitchByName(SwitchName):GetSignal() ~= 0) then
			Metrostroi.GetSwitchByName(SwitchName):SendSignal(SwitchState and "alt" or "main",nil,true)
			--RunConsoleCommand("say","changing",SwitchName)
		end
	end
end

function ENT:CloseRoute(route)
	if self.Routes[route].Manual then self.Routes[route].IsOpened = false end
	if not self.Routes[route].Switches then return end

	local Switches = string.Explode(",",self.Routes[route].Switches)
	for i1 =1, #Switches do
		if not Switches[i1] or Switches[i1] == "" then continue end

		--local SwitchState = Switches[i1]:sub(-1,-1) == "-"
		local SwitchName = Switches[i1]:sub(1,-2)
		--if not self.Switches[SwitchName] then self.Switches[SwitchName] = Metrostroi.GetSwitchByName(SwitchName) end
		if not Metrostroi.GetSwitchByName(SwitchName) then print(self.Name,"switch not found") continue end
		--If route go right from this switch - add it
		if SwitchState ~= (Metrostroi.GetSwitchByName(SwitchName):GetSignal() ~= 0) then
			Metrostroi.GetSwitchByName(SwitchName):SendSignal("main",nil,true)
			--RunConsoleCommand("say","changing",SwitchName)
		end
	end
end

function ENT:SayHook(ply, comm)
	--print(ply,comm,self)
	if comm:sub(1,8) == "!sclose " then
		comm = comm:sub(9,-1):upper()
		--RunConsoleCommand("say",comm,"IT WORKED!!!")
		
		comm = string.Explode(":",comm)
		if comm[1] == self.Name then
			RunConsoleCommand("say",comm)
			--RunConsoleCommand("say","open manual route",self.Name)
			if self.Routes[1] and self.Routes[1].Manual then
				self:CloseRoute(1) 
			--RunConsoleCommand("say","open manual route",self.Name)
			else
				if not self.Close then
					self.Close = true
				end
				if self.InvationSignal then
					self.InvationSignal = false
				end
				--RunConsoleCommand("say","close route",self.Name,"next signal",comm[2])
				if (self.LastOpenedRoute and self.LastOpenedRoute == 1) or self.Routes[1].Repeater then
					self:CloseRoute(1) 
				else
					self:OpenRoute(1)
				end
			end
		elseif self.Routes then
			for k,v in pairs(self.Routes) do
				if v.RouteName and v.RouteName:upper() == comm[1] then
					if self.LastOpenedRoute and k ~= self.LastOpenedRoute then self:CloseRoute(self.LastOpenedRoute) end
					self:CloseRoute(k)
				end
			end
		end
	elseif comm:sub(1,7) == "!sopen " then
		comm = comm:sub(8,-1):upper()
		comm = string.Explode(":",comm)
		if comm[1] == self.Name then
			RunConsoleCommand("say",comm)
			if comm[2] then
				if self.NextSignals[comm[2]] then
					local Route
					--RunConsoleCommand("say","open route",self.Name,"next signal",comm[2])
					for k,v in pairs(self.Routes) do
						if v.NextSignal == comm[2] then Route = k break end
					end
					--RunConsoleCommand("say","route",Route)
					self:OpenRoute(Route)
				end
			else
				if self.Routes[1] and self.Routes[1].Manual then
					self:OpenRoute(1) 
				--RunConsoleCommand("say","open manual route",self.Name)
				elseif self.Close then
					self.Close = false
				elseif self.Red then
					self.InvationSignal = true
				end
			end
		elseif self.Routes then
			for k,v in pairs(self.Routes) do
				if v.RouteName and v.RouteName:upper() == comm[1] then
					if self.LastOpenedRoute and k ~= self.LastOpenedRoute then self:CloseRoute(self.LastOpenedRoute) end
					self:OpenRoute(k)
				end
			end
		end
	end
end
ENT.ARSOrder = "04678"
function ENT:Initialize()
	--hook.Add( "metrostroi-signal-update-hook", "metrostroi-signal-update-hook"..self:EntIndex(), self:ARSLogic() )
	self:SetModel("models/metrostroi/signals/ars_box.mdl")
	self.Sprites = {}
	self.Sig = ""
	hook.Add("PlayerSay","metrostroi-signal-say"..self:EntIndex(), function(ply, comm) self:SayHook(ply,comm) end)
	self.FreeBS = 1
	self.OldBSState = 1
	self.OutputARS = 1
	self.EnableDelay = {}
	self.PostInitalized = true
	--[[
	if not self.Name then
		self.SignalType = 0
		self.Name = ""
		self.Lenses = {
		}
		self.RouteNumber = ""
	end
	]]
end

function ENT:PreInitalize()
	self.AutostopOverride = nil
	if not self.Routes or self.Routes[1].NextSignal == "" then
		self.AutostopOverride = true
	end
	if self.Sprites then
		for k,v in pairs(self.Sprites) do
			SafeRemoveEntity(v)
			self.Sprites[k] = nil
		end
	end
	self.NextSignals = {}
	--self.Switches = {}
	for k,v in ipairs(self.Routes) do
		if v.NextSignal == "" then
			self.NextSignals[""] = nil--self
		else
			self.NextSignals[v.NextSignal] = Metrostroi.GetSignalByName(v.NextSignal)
			if not self.NextSignals[v.NextSignal] then
				print(Format("Metrostroi: Signal %s, signal not found(%s)", self.Name, v.NextSignal))
				self.AutostopOverride = true
			end
			--if self.NextSignals[v.NextSignal] then FoundedSignals = FoundedSignals + 1 end
		end
	end
	self.MU = false
	for k,v in ipairs(self.Lenses) do
		if v:find("M") then self.MU = true break end
	end
--	self:SendUpdate()
end
function ENT:PostInitalize()
	if not self.Routes or #self.Routes == 0 then print(self, "NEED SETUP") return end
	local pos = self.TrackPosition
	local node = pos and pos.node1 or nil
	self.Node = node

	self.SwitchesFunction = {}
	self.Switches = {}
	for i = 1,#self.Routes do
		if not self.Routes[i].Switches then continue end
	
		local Switches = string.Explode(",",self.Routes[i].Switches)
		local SwitchesTbl = {}
		--local GoodSwitches = true
		--Checking all route switches
		for i1 =1, #Switches do
			if not Switches[i1] or Switches[i1] == "" then continue end

			local SwitchState = Switches[i1]:sub(-1,-1) == "-"
			local SwitchName = Switches[i1]:sub(1,-2)
			--if not self.Switches[SwitchName] then self.Switches[SwitchName] = Metrostroi.GetSwitchByName(SwitchName) end
			if not Metrostroi.GetSwitchByName(SwitchName) then print(Format("Metrostroi: %s, switch not found(%s)", self.Name, SwitchName)) continue end
			--If route go right from this switch - add it
			table.insert(SwitchesTbl,{n = SwitchName,s = SwitchState})
		end
		self.Switches[i] = SwitchesTbl
		self.SwitchesFunction[i] = function()
			local GoodSwitches = true
			for i1 = 1,#self.Switches[i] do
				if not self.Switches[i][i1] or not IsValid(Metrostroi.GetSwitchByName(self.Switches[i][i1].n)) then continue end
				if self.Switches[i][i1].s ~= (Metrostroi.GetSwitchByName(self.Switches[i][i1].n):GetSignal() > 0) then
					GoodSwitches = false
					break
				end
			end
			return GoodSwitches
		end
	end
	for k,v in pairs(self.Routes) do
		if not v.Lights then continue end
		v.LightsExploded = string.Explode("-",v.Lights)
	end
	self.PostInitalized = false
end

function ENT:OnRemove()
	Metrostroi.UpdateSignalEntities()
	hook.Remove("PlayerSay","metrostroi-signal-say"..self:EntIndex())
	Metrostroi.PostSignalInitialize()
end

function ENT:GetARS(ARSID, Train)
	--print(self.Name,self.ARSNextSpeedLimit)
	if self.OverrideTrackOccupied then return ARSID == 0 end
	if Metrostroi.Voltage < 50 then return false end
	return self.ARSSpeedLimit == ARSID or (self.ARSNextSpeedLimit == ARSID and self.ARSSpeedLimit > self.ARSNextSpeedLimit and GetConVarNumber("metrostroi_ars_sfreq") > 0)
end
function ENT:Get325Hz()
	--print(self.Name,self.ARSNextSpeedLimit)
	if self.OverrideTrackOccupied then return true end
	return self.ARSSpeedLimit == 0 and self.Approve0
end
function ENT:GetMaxARS()
	local ARSCodes = self.Routes[1].ARSCodes
	if not self.Routes[1] or not ARSCodes then return 1 end
	return tonumber(ARSCodes[#ARSCodes]) or 1
end

function ENT:ARSLogic(tim)
	--print(self.FoundedAll)
	--if not self.FoundedAll then return end
	if not self.Routes or not self.NextSignals then return end

	-- Check track occuping
	if not self.Routes[self.Route or 1].Repeater  then
		if Metrostroi.Voltage > 50 and not self.Close then --not self.OverrideTrackOccupied and 
			if self.Node and  self.TrackPosition then
				self.Occupied,self.OccupiedBy,self.OccupiedByNow = Metrostroi.IsTrackOccupied(self.Node, self.TrackPosition.x, self.Left and not self.TrackPosition.forward or self.TrackPosition.forward,self.ARSOnly and "ars" or "light", self)
			end
			if self.Routes[self.Route] and self.Routes[self.Route].Manual then
				self.Occupied = self.Occupied or not self.Routes[self.Route].IsOpened
			end
			if self.OccupiedByNowOld ~= self.OccupiedByNow then
				self.InvationSignal = false
				self.OccupiedByNowOld = self.OccupiedByNow
			end
			--if self.Name == "AU477" then print( self.OccupiedBy) end
		else
			self.NextSignalLink = nil
			self.Occupied = Metrostroi.Voltage < 50 or self.Close --self.OverrideTrackOccupied or 
		end

		if self.Occupied then	
			if self.Routes[self.Route or 1].Manual then self.Routes[self.Route or 1].IsOpened = false end
		end
		if self.Occupied or not self.NextSignalLink or not self.NextSignalLink.FreeBS then	
			if self.Routes[self.Route or 1].Manual then self.Routes[self.Route or 1].IsOpened = false end
			self.FreeBS = 0
		else
			self.FreeBS = math.min(10,self.NextSignalLink.FreeBS + 1)
		end
		--if not self.NextSignalLink then print(self.Name) end
		if self.FreeBS - (self.OldBSState or self.FreeBS) > 1 then
			local Free = self.FreeBS
			timer.Simple(tim+0.1,function()
				if not IsValid(self) then return end
				if self.NextSignalLink and self.NextSignalLink.FreeBS + 1 - self.OldBSState > 1 then
					self.FreeBS = Free
					self.OldBSState = Free
				end
			end)
			self.FreeBS = self.OldBSState
		end
		self.OldBSState = self.FreeBS
		if self.FreeBS == 1 then
			self.OccupiedBy = self
		elseif self.FreeBS > 1 then
			self.AutostopEnt = nil
		end
		if self.OccupiedByNow ~= self.AutostopEnt and self.AutostopEnt ~= self.CurrentAutostopEnt then
			self.AutostopEnt = nil
		end
	end
	--Removing NSL					
	self.NextSignalLink = nil
	--Set the first route, if no switches in route or no switches
	--or not self.Switches
	if #self.Routes == 1 and (self.Routes[1].Switches == "" or not self.Routes[1].Switches) then
		self.NextSignalLink = self.NextSignals[self.Routes[1].NextSignal]
		self.Route = 1
	else
		--Finding right route
		for i = 1,#self.Routes do
			--if not self.Routes[i].Switches then continue end
			--If we have NSL, then we don't must find right route
			if self.NextSignalLink ~= nil then break end
			
			--If all switches right - get this signal!
			if not self.SwitchesFunction[i] or self.SwitchesFunction[i]() then
				if self.Route ~= i then
					self.Route = i
					self.NextSignalLink = nil
					break
				end
				self.NextSignalLink = self.NextSignals[self.Routes[i].NextSignal]
				break
			end
		end
	end
	if not self.NextSignalLink then
		if self.Occupied then
			self.NextSignalLink = self
			self.FreeBS = 0
			self.Route = 1
		end
	end
	if self.Routes[self.Route] then
		if self.Routes[self.Route or 1].Repeater then
			self.RealName = IsValid(self.NextSignalLink) and self.NextSignalLink.Name or self.Name
		else
			self.RealName = self.Name
		end
		if self.Routes[self.Route or 1].Repeater then
			self.RealName = IsValid(self.NextSignalLink) and self.NextSignalLink.Name or self.Name
			self.ARSSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSSpeedLimit or 1
			self.ARSNextSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSNextSpeedLimit or 1
			self.FreeBS = IsValid(self.NextSignalLink) and self.NextSignalLink.FreeBS or 0
			--print(self.NextSignalLink)
		elseif self.Routes[self.Route].ARSCodes then
			--print(self.Name,self.NextSignalLink)
			local ARSCodes = self.Routes[self.Route].ARSCodes
			self.ARSNextSpeedLimit = IsValid(self.NextSignalLink) and self.NextSignalLink.ARSSpeedLimit or tonumber(ARSCodes[1])
			if GetConVarNumber("metrostroi_ars_independent") > 0 then
				self.ARSSpeedLimit = tonumber(ARSCodes[#ARSCodes] or "1")
			else
				local curr = ARSCodes[math.min(#ARSCodes, self.FreeBS+1)]
				local max = tonumber(ARSCodes[#ARSCodes])
				if curr == "1" or curr == "0" or self.ARSNextSpeedLimit == nil or not max then
					self.ARSSpeedLimit = IsValid(self.NextSignalLink) and tonumber(curr) or tonumber(ARSCodes[1] or "1")
				else
					if self.ARSNextSpeedLimit == 4 and max >= 6 then
						self.ARSSpeedLimit = 6
					elseif  self.ARSNextSpeedLimit == 0 or self.ARSNextSpeedLimit == 1 and max >= 4 then
						self.ARSSpeedLimit = 4
					else
						self.ARSSpeedLimit = math.min(max,self.ARSNextSpeedLimit + 1)
					end
				end
			end
		end
	end
end

function ENT:Think()
	--if self.LensesStr == "YR-GW-M" then
		--self.Routes[1].Lights = "2-21-1-13-3"
	--end
	if self.PostInitalized then return end
	--if self.Name == "PR 2R3" then print(self.TrackPosition and self.TrackPosition.path.id or "shit") end
	--Outdated for now
	--Setting network vars
	--self:SetNWInt("LightType", (self.SignalType or 0))
	--self:SetNWString("Name", self.Name or "NOT LOADED")
	--self:SetNWString("Lenses", self.ARSOnly and "ARSOnly" or self.LensesStr)

	self.PrevTime = self.PrevTime or 0
	if (CurTime() - self.PrevTime) > 1.0 then
		--print(1)
		self.PrevTime = CurTime()+math.random(0.5,1.5)
		self:ARSLogic(self.PrevTime - CurTime())
	end
	--self:ARSLogic(0.25 )
	
	--If we use only ARS Box - we stop all next operations (lenses, autostop)
	if self.ARSOnly then
		local number = self.NextSignalLink and (self.NextSignalLink.RouteNumberOverrite or self.NextSignalLink.RouteNumber) or nil
		self.RouteNumberOverrite = self.RouteNumber or (number ~= "" and number or nil)
	end
	self.RouteNumberOverrite = nil
	local number
	if self.MU or self.Depot or self.ARSOnly then
		number = self.NextSignalLink and (self.NextSignalLink.RouteNumberOverrite or self.NextSignalLink.RouteNumber) or ""
		if self.NextSignalLink and self.Depot and self.NextSignalLink.FreeBS < 2 then
			number = self.NextSignalLink.RouteNumber or self.NextSignalLink.RouteNumberOverrite
		elseif self.NextSignalLink and self.Depot then
			--print(self.NextSignalLink.Name)
			--if number == "4" then self.FreeBS = 0 self.NextSignalLink = nil end
		end
		if (self.Depot and self.NextSignalLink and self.NextSignalLink.FreeBS > 2) or not self.Depot then
			self.RouteNumberOverrite = number ~= "" and number or nil
		end
	end
	if self.ARSOnly or Metrostroi.Voltage <= 50  then 
		if self.Sprites then
			for k,v in pairs(self.Sprites) do
				SafeRemoveEntity(v)
				self.Sprites[k] = nil
			end
			if self.ARSOnly and self.Sprites then
				self.Sprites = nil
			end
		end
		self:SetNWString("Signal","")
		self.AutoEnabled = not self.ARSOnly and Metrostroi.Voltage <= 50
		return
	end
	--[[
	if self.AutoEnabled then
		self.CurrentAutostopEnt = nil
		local pos = self.AutostopPos and self.AutostopPos+Vector(0,0,50) or self:GetPos()+Vector(0,0,50)
		local FEnts = ents.FindInSphere(pos,5)

		for k,v in pairs(FEnts) do
			local Tpos = Metrostroi.TrainPositions[v] and Metrostroi.TrainPositions[v][1]
			if IsValid(v) and v.Pneumatic and Tpos and self.TrackPosition.path == Tpos.path and self.TrackDir == Metrostroi.TrainDirections[v] then--and  v:GetPos():Distance(pos) < 300 then
				--(v.SubwayTrain.Name == "81-717" or v.SubwayTrain.Name == "Ezh3") and 
				if (IsValid(self.OccupiedBy) and v ~= self.OccupiedBy or self.AutostopOverride) and v.UAVA and not v.Pneumatic.UAVA and not v.Pneumatic.EmergencyValve and v.SpeedSign > 0 and v.Speed >= 1 and v ~= self.AutostopEnt and v ~= self.CurrentAutostopEnt then
					--print(v ~= self.CurrentAutostopEnt)
					print("SRYV!!!", self.AutostopOverride,self.Name,v.SubwayTrain.Name,self.OccupiedBy,v.SpeedSign, v.Owner,self.Occupied,self:GetAngles(),v:GetAngles())
					RunConsoleCommand("say", "SORVALO",tostring(v.Owner),tostring(self.Name))
					v.Pneumatic.EmergencyValve = true
					self.AutostopEnt = v
				end
				self.CurrentAutostopEnt = v
				self.InvationSignal = false
			end
		end
	else
		self.InvationSignal = false
	end
	]]
	--if self.IsolateSwitches then print(self.Name) end
	self.AutoEnabled = false
	self.Red = nil
	--if self.Name == "LT 31" then print(self.Occupied) end
	if not self.Routes[self.Route or 1].Lights then return end
	local Route = self.Routes[self.Route or 1]
	local index = 1
	local offset = self.RenderOffset[self.SignalType] or Vector(0,0,0)
	--if self.Name == "MN339" then print(self.NextSignalLink.NextSignalLink.NextSignalLink.NextSignalLink.RouteNumberOverrite) end
	self.Sig = ""
	for k,v in ipairs(self.Lenses) do
		if v ~= "M" then
			--get the some models data
			local data = #v ~= 1 and self.TrafficLightModels[self.SignalType][#v-1] or self.TrafficLightModels[self.SignalType][Metrostroi.Signal_IS]
			if not data then continue end
			offset = offset - Vector(0,0,data[1])
			for i = 1,#v do
				--Get the LightID and check, is this light must light up
				local LightID = IsValid(self.NextSignalLink) and math.min(#Route.LightsExploded,self.FreeBS+1) or 1
				
				--local InvationSignal = ((v[i] == "W" and self.InvationSignal and k == self.InS)
				local AverageState = Route.LightsExploded[LightID]:find(tostring(index)) or ((v[i] == "W" and self.InvationSignal and k == self.InS) and 1 or 0)
				local MustBlink = (((self.Lenses[#self.Lenses] ~= "W" and v[i] == "W") or v == "W") and self.InvationSignal) or (AverageState > 0 and Route.LightsExploded[LightID][AverageState+1] == "b") --Blinking, when next is "b" (or it's invasion signal')
				self.Sig = self.Sig..(AverageState > 0 and (MustBlink and 2 or 1) or 0)
				local TimeToOff = not (RealTime() % 1 > 0.25)
				--if v[i] == "R" and #Route.LightsExploded[LightID] == 1 and AverageState then self.AutoEnabled = true end
				if v[i] == "R" and AverageState > 0 then
					self.AutoEnabled = true
					if self.Red == nil then self.Red = true end
				elseif AverageState > 0 then
					self.Red = false
				end
				--if v[i] == "R" and AverageState > 0 then print(self.Name,v[i] == "R",AverageState) end
				--if MustBlink and TimeToOff then AverageState = 0 end
				--Simulate signal changing delay
				--[=[ 
--				if not self.Sprites[index.."a"] and Route.LightsExploded[LightID]:find(tostring(index)) and not self.EnableDelay[index] and not MustBlink then
					--self.EnableDelay[index] = true
				--else
--					if self.EnableDelay[index] and AverageState == 0 then
						--self.EnableDelay[index] = false
					--end
				
					-- Overall glow
					self:SetSprite(index.."a",fa,
						"models/metrostroi_signals/signal_sprite_002.vmt",0.40,1.0,
						self.BasePosition + offset + data[3][i-1], Metrostroi.Lenses[v[i]])

					The LED glow
					self:SetSprite(index.."b",false,
						"models/metrostroi_signals/signal_sprite_002.vmt",0.25,0.6,
						self.BasePosition + offset + data[3][i-1], Metrostroi.Lenses[ v[i] ])
					self.EnableDelay[index] = nil
				end
					]=]
				index = index + 1
			end
		else
			if number then self:SetNWString("Number",self.Red and "" or number) end
			--[[
			--Get the some models data
			local data = self.TrafficLightModels[self.SignalType][Metrostroi.Signal_RP]
			offset = offset - Vector(0,0,data[1])

			--Let's draw the sprites
			local RN = tostring(self.RouteNumber,(self.ARSSpeedLimit or 0) < 4)..tostring(self.NextSignalLink and self.NextSignalLink.Name or "unk")
			if self.OldRouteNumber ~= RN then
				self.SpriteDelay = CurTime() + 0.25
				self.OldRouteNumber = RN
			end
			for i = 0,34 do
				local i1 = i%5
				local i2 = math.floor(i/5)
				--Get's the number table
				local RPData = Metrostroi.RoutePointer[number]
				--Check, can we light'up this route pointer sprite
				local AverageState = RPData and (not self.Red and RPData[i+1]) or false
				if self.SpriteDelay and self.SpriteDelay - CurTime() > 0 then AverageState = false end
				--Overall glow
				self:SetSprite(k..i.."m",AverageState,
					"models/metrostroi_signals/signal_sprite_002.vmt",data[6]/100,0.6,
					self.BasePosition + offset + data[3] - Vector(i1*data[4],0,i2*data[5]), Color(255,255,255))
			end
			]]
		end
	end
	self:SetNWString("Signal",self.Sig)
	if self.Sig ~= self.Oldsig then
		--net.Start("metrostroi-signal-state")
--			net.WriteEntity(self)
			--net.WriteInt(#self.Sig,16)
			--for i = 1,#self.Sig do
--				net.WriteInt(tonumber(self.Sig[i]),3)
			--end
		--net.Broadcast()
	end
	self.Oldsig = self.Sig
	if not self.AutoEnabled then
		self.InvationSignal = false
	end
	self:NextThink(CurTime() + 0.25)
	return true
end

--Net functions
--Send update, if parameters have been changed
function ENT:SendUpdate(ply)
	net.Start("metrostroi-signal")
		net.WriteEntity(self)
		net.WriteInt(self.SignalType or 0,3)
		net.WriteString(self.Name or "NOT LOADED")
		net.WriteString(self.ARSOnly and "ARSOnly" or self.LensesStr)
		net.WriteBool(self.Left)
	if ply then net.Send(ply) else net.Broadcast() end
end

--On receive update request, we send update
net.Receive("metrostroi-signal", function(_, ply)
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.SendUpdate then return end
	ent:SendUpdate(ply)
	--net.Start("metrostroi-signal-state")
--		net.WriteEntity(ent)
		--net.WriteInt(#ent.Sig,16)
		--for i = 1,#ent.Sig do
--			net.WriteInt(tonumber(ent.Sig[i]),3)
		--end
	--net.Broadcast()
end)