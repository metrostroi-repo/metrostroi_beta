include("shared.lua")

--[[
hook.Add("PostDrawOpaqueRenderables", "metrostroi_signal_draw", function(isDD)
	if isDD then return end
	for _,self in pairs(ents.FindByClass("gmod_track_signal")) do
		if not IsValid(self) or not self.Name or self.ARSOnly or not self.Models[2] then continue end

		--if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then continue end
		for i = 0,#self.Name-1 do
			if self.Name[i+1] == " " or not IsValid(self.Models[2][i]) then continue end

			local pos = self.Models[2][i]:LocalToWorld(Vector(0,0.3,0))
			local angle = self.Models[2][i]:LocalToWorldAngles(Angle(0,180,90))
			local offset = (self.RenderOffset[self.LightType] or Vector(0,0,0)) + (self.TrafficLightModels[self.LightType]["name"] or Vector(0,0,0))
			if self.LightType == 1 then
				for i = 1,#self.TrafficLightModels[self.LightType] do
					offset = offset - Vector(0,0,self.TrafficLightModels[self.LightType][i][1])
				end
			end

			cam.Start3D2D( pos, angle, 0.25 )
				surface.SetTextColor( Color(0,0,0) )
				surface.SetFont("CloseCaption_Bold")
				local x,y = surface.GetTextSize(self.Name[i+1])
				surface.SetTextPos(-x/2, -y/2)
				surface.DrawText(self.Name[i+1])
			cam.End3D2D()
		end
	end
end)
]]
--------------------------------------------------------------------------------
function ENT:Initialize()
	self.Sig = {}
	self.OldName = ""
	self.Models = {{},{},{}}
	self.Signals = {}
	self.Anims = {}
	--hook.Add("PlayerBindPress", "metrostroi_signal_startup"..self:EntIndex(), function()
		--self.SendReq = CurTime() + math.random(3)
		--hook.Remove("PlayerBindPress", "metrostroi_signal_startup"..self:EntIndex())
	--end)
end
function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
	local id = clientProp
	if not self.Anims[id] then
		self.Anims[id] = {}
		self.Anims[id].val = value
		self.Anims[id].V = 0.0
	end
	--if self["_anim_old_"..id] == value then return self["_anim_old_"..id] end
	-- Generate sticky value
	if stickyness and damping then
		self.Anims[id].stuck = self.Anims[id].stuck or false
		self.Anims[id].P = self.Anims[id].P or value
		if (math.abs(self.Anims[id].P - value) < stickyness) and (self.Anims[id].stuck) then
			value = self.Anims[id].P
			self.Anims[id].stuck = false
		else
			self.Anims[id].P = value
		end
	end
		
	if damping == false then
		local dX = speed * self.DeltaTime
		if value > self.Anims[id].val then
			self.Anims[id].val = self.Anims[id].val + dX
		end
		if value < self.Anims[id].val then
			self.Anims[id].val = self.Anims[id].val - dX
		end
		if math.abs(value - self.Anims[id].val) < dX then
			self.Anims[id].val = value
		end
	else
		-- Prepare speed limiting
		local delta = math.abs(value - self.Anims[id].val)
		local max_speed = 1.5*delta / self.DeltaTime
		local max_accel = 0.5 / self.DeltaTime

		-- Simulate
		local dX2dT = (speed or 128)*(value - self.Anims[id].val) - self.Anims[id].V * (damping or 8.0)
		if dX2dT >  max_accel then dX2dT =  max_accel end
		if dX2dT < -max_accel then dX2dT = -max_accel end
		
		self.Anims[id].V = self.Anims[id].V + dX2dT * self.DeltaTime
		if self.Anims[id].V >  max_speed then self.Anims[id].V =  max_speed end
		if self.Anims[id].V < -max_speed then self.Anims[id].V = -max_speed end
		
		self.Anims[id].val = math.max(0,math.min(1,self.Anims[id].val + self.Anims[id].V * self.DeltaTime))
		
		-- Check if value got stuck
		if (math.abs(dX2dT) < 0.001) and stickyness and (self.DeltaTime > 0) then
			self.Anims[id].stuck = true
		end
	end
	--print(id,min + (max-min)*self.Anims[id].val,value, min + (max-min)*value)
	--self["_anim_old_"..id] = min + (max-min)*self.Anims[id].val
	return min + (max-min)*self.Anims[id].val
end
function ENT:AnimateFrom(clientProp,from)
	if IsValid(self.ClientEnts[clientProp]) then
		self.ClientEnts[clientProp]:SetPoseParameter("position",self.Anims[from].val)
	end
	return self.Anims[from].val
end
function ENT:OnRemove()
	--hook.Remove("PostDrawOpaqueRenderables", "metrostroi_signal_draw_"..self:EntIndex())	
	self.CLDraw = false
	self.OldName = ""
	self:RemoveModels()
	--self.LightType = 0
	--hook.Remove("PostDrawOpaqueRenderables")
end
function ENT:RemoveModels()
	if self.Models and  self.Models.have then
		for k,v in pairs(self.Models) do if type(v) == "table" then for _,v1 in pairs(v) do v1:Remove() end end end
	end
	self.Models = {{},{},{}}
end

net.Receive("metrostroi-signal", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	ent.LightType = net.ReadInt(3)
	ent.Name = net.ReadString()
	ent.Lenses = net.ReadString()
	ent.ARSOnly = ent.Lenses == "ARSOnly"
	ent.Left = net.ReadBool()
	if not ent.ARSOnly then
		ent.LensesTBL = string.Explode("-",ent.Lenses)
	end
	if ent.RemoveModels then ent:RemoveModels() end
	--print(ent.Name..", signal received update")
end)
net.Receive("metrostroi-signal-state", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	ent.Sig = {}
	for i = 1,net.ReadInt(16) do
		ent.Sig[i] = net.ReadInt(3)
	end
	ent.NextSignalWork = CurTime() + 0.6
end)

function ENT:Think()
	self.PrevTime = self.PrevTime or RealTime()
	self.DeltaTime = (RealTime() - self.PrevTime)
	self.PrevTime = RealTime()
	--if self.SendReq == nil or (self.SendReq and CurTime() - self.SendReq <= 0) then return true elseif self.SendReq then self.SendReq = false end
	--if not self.Models then self.Models = {{},{},{}} self.OldName = "++--++--++--" end
	if LocalPlayer():GetPos().z - self:GetPos().z > 500 or LocalPlayer():GetPos():Distance(self:GetPos()) > 10000 then
		self:RemoveModels()
		return
	end
	

	if not self.Name then
		if self.sended and (CurTime() - self.sended) > 0 then 
			self.sended = nil
		end
		if not self.sended then
			--print((self.Name or tostring(self))..", require update")
			net.Start("metrostroi-signal")
				net.WriteEntity(self)
			net.SendToServer()
			self.sended = CurTime() + 1.5
		end
		return
	end
	--[[
	if ((self.LightType > 0 and self.Lenses == "") or (self.LightType == 1 and self.Lenses ~= "")
	or (self.LightType > 0 and self.Name == "") or (self.LightType == 1 and self.Name ~= "")
	or (self.Name ~= "" and self.Lenses == "") or (self.Name == "" and self.Lenses ~= "") or self.LightType < 1)
	]]
	local ID = 0
	local ID2 = 0
	-- Create new clientside models
	if not self.ARSOnly then
		self.Sig = self:GetNW2String("Signal")
		self.Num = self:GetNW2String("Number",nil)
		if self.OldSig ~= self.Sig then
			self.NextSignalWork = CurTime() + 0.7
		end
		self.OldSig = self.Sig
		if self.OldNum ~= self.Num then
			self.NextNumWork = CurTime() + 1
		end
		self.OldNum = self.Num
		
		if (self.NextSignalWork or CurTime()) - CurTime() >= 0 then
			self.Sig = ""
		end
		if (self.NextNumWork or CurTime()) - CurTime() >= 0 then
			self.Num = ""
		end
		if self.Lenses ~= self.OldLenses then
			self:RemoveModels()
		end
		--if not self.LensesTBL or self.Lenses ~= self.OldLenses then
			--self.LensesTBL = string.Explode("-",self.Lenses)
		--end
		
		--self.SigStop = (self.NextSignalWork or CurTime()) - CurTime() >= 0
		for k,v in pairs(self.TrafficLightModels[self.LightType]) do
			if type(v) == "string" then
				if IsValid(self.Models[1][v]) then break end
				--if not IsValid(self.Models[1][v]) then
					self.Models[1][v] = ClientsideModel(v,RENDERGROUP_OPAQUE)
					self.Models[1][v]:SetPos(self:LocalToWorld(self.BasePosition))
					self.Models[1][v]:SetAngles(self:GetAngles())
					self.Models[1][v]:SetParent(self)
				--end
			end
		end
		self.NamesOffset = Vector(0,0,0)
		-- Create traffic light models
		--if self.LightType > 2 then self.LightType = 2 end
		--if self.LightType < 0 then self.LightType = 0 end

		local offset = self.RenderOffset[self.LightType] or Vector(0,0,0)
		for k,v in ipairs(self.LensesTBL) do
			local data	
			if v ~= "M" then
				data = #v ~= 1 and self.TrafficLightModels[self.LightType][#v-1] or self.TrafficLightModels[self.LightType][Metrostroi.Signal_IS]
			else
				self.RouteNumber = ID
				data = self.TrafficLightModels[self.LightType][Metrostroi.Signal_RP]
			end
			if not data then continue end
			offset = offset - Vector(0,0,data[1])
			if not IsValid(self.Models[1][ID]) then
				self.NamesOffset = self.NamesOffset + Vector(0,0,data[1])
				if self.Left then print(data[2]:Replace(".mdl","_mirror.mdl")) end
				self.Models[1][ID] = ClientsideModel(self.Left and data[2]:Replace(".mdl","_mirror.mdl") or data[2],RENDERGROUP_OPAQUE)
				self.Models[1][ID]:SetPos(self:LocalToWorld(self.BasePosition + offset))
				self.Models[1][ID]:SetAngles(self:LocalToWorldAngles(Angle(0,self.Left and 180 or 0,0)))
				self.Models[1][ID]:SetParent(self)
			end
			if v ~= "M" then
				for i = 1,#v do
					ID2 = ID2 + 1
					if not self.Signals[ID] then self.Signals[ID] = {} end
					--if self.Sig[ID2] == "1" or (self.Sig[ID2] == "2" and (RealTime() % 2 > 0.25)) then 
					--else
					--end
					local State = self:Animate(ID.."/"..i,	((tonumber(self.Sig[ID2]) == 1 or (tonumber(self.Sig[ID2]) == 2 and (RealTime() % 1.2 > 0.5))) and not self.SigStop) and 1 or 0, 	0,1, 256)
					if not IsValid(self.Models[3][ID..ID2]) and State > 0 then self.Signals[ID][i] = nil end
					
					if State >0 and self.Signals[ID][i] ~= State  and not IsValid(self.Models[3][ID..ID2]) then
						self.Models[3][ID..ID2] = ClientsideModel("models/metrostroi/signals/sign_lense.mdl",RENDERGROUP_OPAQUE)
						self.Models[3][ID..ID2]:SetPos(self:LocalToWorld(self.BasePosition + offset + data[3][i-1]*Vector(1,self.Left and -1.1 or 1,1)+Vector(0,0.1,0)))
						self.Models[3][ID..ID2]:SetAngles(self:LocalToWorldAngles(Angle(90,90*(self.Left and -1 or 1),0)))
						self.Models[3][ID..ID2]:SetSkin(self.SignalConverter[v[i]]-1)
						self.Models[3][ID..ID2]:SetParent(self)
						self.Models[3][ID..ID2]:SetRenderMode(RENDERMODE_TRANSALPHA)
						self.Models[3][ID..ID2]:SetColor(Color(255,255,255,0))
					end
					if IsValid(self.Models[3][ID..ID2]) then 
						if State > 0 and self.Signals[ID][i] ~= State then
							self.Models[3][ID..ID2]:SetColor(Color(255,255,255,State*255))
						elseif  State == 0 and self.State ~= State then
							self.Models[3][ID..ID2]:Remove()
						end
					end
					self.Signals[ID][i] = State
				end
			else
				self.Models[1][self.RouteNumber]:SetSkin(Metrostroi.RoutePointer[self.Num])
			end
			ID = ID + 1
		end
		for i = 0,#self.Name-1 do
			if self.Name[i+1] == " " then continue end
			if not IsValid(self.Models[2][i]) then
				self.OldName = ""
				break
			end
		end

		if self.OldName ~= self.Name then
			for i = 0,#self.OldName-1 do
				if self.Name[i+1] == " " then continue end
				if self.Models[2][i] then
					self.Models[2][i]:Remove()
					self.Models[2][i] = nil
				end
			end

			local offset = (self.RenderOffset[self.LightType] or Vector(0,0,0)) + (self.TrafficLightModels[self.LightType]["name"] or Vector(0,0,0))
			if self.LightType == 1 then
				offset = offset - self.NamesOffset
			end
			for i = 0,#self.Name-1 do
				if self.Name[i+1] == " " then continue end
				if not IsValid(self.Models[2][i]) then
					self.Models[2][i] = ClientsideModel("models/metrostroi/signals/letter.mdl",RENDERGROUP_OPAQUE)
					self.Models[2][i]:SetAngles(self:GetAngles()+Angle(0,self.Left and 180 or 0,0))
					self.Models[2][i]:SetPos(self:LocalToWorld(self.BasePosition + offset*Vector(1,self.Left and -1 or 1,1) - Vector(0,0,i*5.5)))
					self.Models[2][i]:SetParent(self)
					for k,v in pairs(self.Models[2][i]:GetMaterials()) do
						if v == "models/metrostroi_signals/signal_001" then
							self.Models[2][i]:SetSubMaterial(k-1,"models/metrostroi_signals/signs/"..(Metrostroi.LiterWarper[self.Name[i+1]] or self.Name[i+1]))
						end
					end
				end
			end
		end
	else
		local k = "m1"

		if not IsValid(self.Models[1][k]) then
			local v = self.TrafficLightModels[self.LightType]["m1"]
			self.Models[1][k] = ClientsideModel(v,RENDERGROUP_OPAQUE)
			self.Models[1][k]:SetPos(self:LocalToWorld(self.BasePosition))
			self.Models[1][k]:SetAngles(self:GetAngles())
			self.Models[1][k]:SetParent(self)
		end
	end
	self.Models.have = true
	self.OldLenses = self.Lenses
	self.OldName = self.Name
end
function ENT:Draw()
	-- Draw model
	self:DrawModel()
end