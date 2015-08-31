AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/ars_box.mdl")
	self.Sprites = {}
	self.CacheData = {}
	Metrostroi.UpdateSignalEntities()
	
	-- Setup nominal signals (give it few seconds to establish)
	self.NominalSignals = 0
	self.NoNominalSignals = true
	self.GetNominalSignals = function(self) return self.NominalSignals end
	self.SkipCache = true
	timer.Simple(16.0,function()
		if IsValid(self) and self.GetActiveSignals then
			self.SkipCache = false
			self.NoNominalSignals = false
			self.NominalSignals = self:GetActiveSignals()
		end
	end)
end

function ENT:OnRemove()
	Metrostroi.UpdateSignalEntities()
end

function ENT:SetSprite(index,active,model,scale,brightness,pos,color)
	if active and self.Sprites[index] then return end
	SafeRemoveEntity(self.Sprites[index])
	self.Sprites[index] = nil
	
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

function ENT:GetNoFreq()
	if self:GetActiveSignalsBit(14) or
	   self:GetActiveSignalsBit(13) or
	   self:GetActiveSignalsBit(12) or
	   self:GetActiveSignalsBit(11) or
	   self:GetActiveSignalsBit(10) then return false end
	
	return true
end

function ENT:Logic(trackOccupied,nextRed,switchBlocked,switchAlternate)
	-- Should alternate/main position block the path
	if self:GetRedWhenMain() then
		switchBlocked = switchBlocked or (not switchAlternate)
	end
	if self:GetRedWhenAlternate() then
		switchBlocked = switchBlocked or switchAlternate
	end
	
	-- Red if track occupied, switch section is blocked (occupied), or always red
	self.RedState = trackOccupied or switchBlocked or self:GetAlwaysRed() or self.OverrideTrackOccupied
	self:SetRed(self.RedState or (self.ARSOnly and (self.SpeedLimit == 0)))
	
	-- Use normal logic or ARS-only logic
	self:SetBlue(self.ARSFake and self.ARSOnly and (not self.RedState) and (not switchAlternate))
	local blueLight = self.ARSFake and self.ARSOnly and 
		(self:GetTrafficLightsBit(3) or self:GetTrafficLightsBit(7) or self.ARSNoGreen)
	
	-- Yellow if next light is red or switch set to alternate
	self:SetYellow((nextRed and (not blueLight)) or switchAlternate)
	-- Second yellow is switch set to alternate and not red
	self:SetSecondYellow(switchAlternate and (not self:GetRed()))
	
	-- Green if not alternate path selected and not red
	self:SetGreen( not (self:GetRed() or switchBlocked or blueLight or switchAlternate) )
	
	-- Mirror green with yellow, if signal does not have green on it
	--[[if not (
		self:GetTrafficLightsBit(1) or
		self:GetTrafficLightsBit(3) or
		self:GetTrafficLightsBit(6) or
		self:GetTrafficLightsBit(7)) then
		self:SetYellow(self:GetGreen())
	end]]--
end

function ENT:ARSLogic()
	if self:GetNoARS() then
		for i=10,15 do self:SetActiveSignalsBit(i,false) end
		return
	end
	
	-- Get position of the next ARS node
	local pos = Metrostroi.SignalEntityPositions[self]
	local node
	if pos then node = pos.node1 end
	if node and pos then
		self.ARSOffset = pos.x
		self.ARSPath = pos.path.id

		-- Check if there is a train anywhere on the isolated area
		local nextARS = self:Cache("nextARS",function() return Metrostroi.GetARSJoint(node,pos.x,    pos.forward) end)
		local prevARS = self:Cache("prevARS",function() return Metrostroi.GetARSJoint(node,pos.x,not pos.forward) end)

		-- Get nominal ARS signals
		local ARS80 = self:GetSettingsBit(0)
		local ARS70 = self:GetSettingsBit(1)
		local ARS60 = self:GetSettingsBit(2)
		local ARS40 = self:GetSettingsBit(3)
		local ARS0  = self:GetSettingsBit(4)
		local ARSsp = self:GetSettingsBit(5)
		
		local ARSdata = true
		if not (ARS80 or ARS70 or ARS60 or ARS40 or ARS0 or ARSsp) then -- Section without nominal values
			if self.NoNominalSignals == false then
				ARS0 = self:GetNominalSignalsBit(14)
				ARS40 = self:GetNominalSignalsBit(13)
				ARS60 = self:GetNominalSignalsBit(12)
				ARS70 = self:GetNominalSignalsBit(11)
				ARS80 = self:GetNominalSignalsBit(10)
			else
				ARSdata = false
			end
		end
		
		-- Get default ARS speed limit
		local speedLimit = 0
		if ARS40 then speedLimit = 40 end
		if ARS60 then speedLimit = 60 end
		if ARS70 then speedLimit = 70 end
		if ARS80 then speedLimit = 80 end
		
		-- Special setting 1
		if self:GetSettingsBit(19) and self.SwitchAlternate then
			speedLimit = 40
		end
		
		-- If ARS data is invalid, use next speed limit
		if (not ARSdata) and prevARS then
			speedLimit = prevARS.SpeedLimit or 0
		end
		
		-- Reset to zero when traffic light is red
		self.AbsoluteStop = false
		self.NextRed = false
		if nextARS and nextARS.RedState and (not self:GetDontPropagate()) then
			--print(self:EntIndex(),self:GetDontPropagate())
			self.AbsoluteStop = true
			self.NextRed = true
			speedLimit = 0
		end

		-- Reset to zero when next section is also at zero
		if nextARS and nextARS.NextRed and (not self:GetDontPropagate()) then
			speedLimit = 0
		end

		-- Reset active signals
		for i=10,15 do self:SetActiveSignalsBit(i,false) end

		-- If speed limit in next section is less, create smooth stop for train
		if nextARS and ((nextARS.SpeedLimit or 0) < speedLimit) then
			if nextARS.SpeedLimit == 0  then speedLimit = 40 self:SetActiveSignalsBit(14,true) end
			if nextARS.SpeedLimit == 40 then speedLimit = 60 self:SetActiveSignalsBit(13,true) end
			if nextARS.SpeedLimit == 60 then speedLimit = 70 self:SetActiveSignalsBit(12,true) end
			if nextARS.SpeedLimit == 70 then speedLimit = 80 self:SetActiveSignalsBit(11,true) end
		end
			
		-- Create signal based on new target speed limit
		if speedLimit ==  0 then self:SetActiveSignalsBit(14,true) end
		if speedLimit == 40 then self:SetActiveSignalsBit(13,true) end
		if speedLimit == 60 then self:SetActiveSignalsBit(12,true) end
		if speedLimit == 70 then self:SetActiveSignalsBit(11,true) end
		if speedLimit == 80 then self:SetActiveSignalsBit(10,true) end
		
		if self.AbsoluteStop and ((CurTime() % 2.0) > 1.0) then
			self:SetActiveSignalsBit(14,false)
		end
		
		-- No voltage
		--[[if Metrostroi.Voltage < 50 then 
			self:SetActiveSignalsBit(14,false)
			self:SetActiveSignalsBit(13,false)
			self:SetActiveSignalsBit(12,false)
			self:SetActiveSignalsBit(11,false)
			self:SetActiveSignalsBit(10,false)
		end]]--
		
		-- Generate speed limit in this ARS section
		self.SpeedLimit = speedLimit
		--if self:GetActiveSignalsBit(13) then self.SpeedLimit = 40 end
		--if self:GetActiveSignalsBit(12) then self.SpeedLimit = 60 end
		--if self:GetActiveSignalsBit(11) then self.SpeedLimit = 70 end
		--if self:GetActiveSignalsBit(10) then self.SpeedLimit = 80 end
	end
end

function ENT:Cache(name,value_func)
	-- Old entry
	self.CacheData = self.CacheData or {}
	if self.CacheData[name] and (not self.SkipCache) and IsValid(self.CacheData[name]) then return self.CacheData[name] end
	
	-- New entry
	self.CacheData[name] = value_func()
	return self.CacheData[name]
end

function ENT:Think()
	self.ARSOnly = true
	self.ARSFake = GetConVarNumber("metrostroi_arsmode") > 0.5
	self.ARSNoGreen = GetConVarNumber("metrostroi_arsmode_nogreen") > 0.5

	-- Do no interesting logic if there's no traffic light involved
	if (self:GetTrafficLights() == 0) and (self.ARSOnly == false) then
		self:ARSLogic()
		self:NextThink(CurTime() + 1.0 + 0.5*math.random())
		return true
	end
	
	-- Traffic light logic
	self.PrevTime = self.PrevTime or 0
	if (CurTime() - self.PrevTime) > 1.0 then
		self.PrevTime = CurTime()+0.5*math.random()
		self:ARSLogic()
		
		-- Get position of the traffic light
		local pos = Metrostroi.SignalEntityPositions[self]
		local node
		if pos then node = pos.node1 end
		if node and pos then
			-- Check if there is a train anywhere on the isolated area
			local trackOccupied = Metrostroi.IsTrackOccupied(node,pos.x,pos.forward,self.ARSOnly and "ars" or "light")
			local nextLight = self:Cache("nextLight",function() return Metrostroi.GetNextTrafficLight(node,pos.x,pos.forward) end)
			local nextRed = false
			if nextLight then nextRed = nextLight:GetRed() or nextLight:GetNoFreq() end
			
			-- Check if there's a track switch and it's set to alternate
			local switchAlternate = false
			local switchBlocked = false
			local switches = self:Cache("switches",function() return Metrostroi.GetTrackSwitches(node,pos.x,pos.forward) end)
			for _,switch in pairs(switches) do
				switchBlocked = switchBlocked or (switch.AlternateTrack and self.InhibitSwitching)
				switchAlternate = switchAlternate or switch.AlternateTrack
			end
			
			-- Voltage check
			if Metrostroi.Voltage < 10 then
				--trackOccupied = true
			end
			
			-- Store some flags
			self.SwitchAlternate = switchAlternate
			
			-- Execute logic
			self:Logic(trackOccupied,nextRed,switchBlocked,switchAlternate)
		else
			-- Execute logic (but no track data is available
			self:Logic(false,false,false,false)
		end
	end
	
	-- Create sprites and manage lamps
	local index = 1
	local models = self.TrafficLightModels[self:GetLightsStyle()] or {}	
	local offset = self.RenderOffset[self:GetLightsStyle()] or Vector(0,0,0)
	for k,v in ipairs(models) do	
		if self:GetTrafficLightsBit(k-1) and v[3] then
			offset = offset - Vector(0,0,v[1])
			for light,data in pairs(v[3]) do
				local state = self:GetActiveSignalsBit(light)
				if light == 4 then state = state and ((CurTime() % 1.00) > 0.25) end
				if Metrostroi.Voltage < 50 then state = false end
				
				-- The LED glow
				self:SetSprite(k..light.."a",state,
					"models/metrostroi_signals/signal_sprite_001.vmt",0.40,1.0,
					self.BasePosition + offset + data[1],data[2])
				
				-- Overall glow
				self:SetSprite(k..light.."b",state,
					"models/metrostroi_signals/signal_sprite_002.vmt",0.25,0.6,
					self.BasePosition + offset + data[1],data[2])
				index = index + 1
				
				--self:SetSprite(index,true,"models/metrostroi_signals/signal_sprite_002.vmt",
					--self.BasePosition + offset + data[1],data[2])
				--index = index + 1
			end
		end
	end
	
	self:NextThink(CurTime() + 0.25)
	return true
end