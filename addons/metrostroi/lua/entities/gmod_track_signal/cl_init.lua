include("shared.lua")


hook.Add("PostDrawOpaqueRenderables", "metrostroi_signal_draw", function(isDD)
	if isDD then return end
	for _,self in pairs(ents.FindByClass("gmod_track_signal")) do
		if not IsValid(self) or not self.Name or self.ARSOnly or self.NotDraw then continue end

		--if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then continue end
		for i = 0,#self.Name-1 do
			if self.Name[i+1] == " " or not IsValid(self.Models["names_"..i]) then continue end

			local pos = self.Models["names_"..i]:LocalToWorld(Vector(0,0.3,0))
			local angle = self.Models["names_"..i]:LocalToWorldAngles(Angle(0,180,90))
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
--------------------------------------------------------------------------------
function ENT:Initialize()
	self.OldName = ""
	self.Models = {}
	hook.Add("PlayerBindPress", "metrostroi_signal_startup"..self:EntIndex(), function()
		self.SendReq = CurTime() + math.random(3)
		hook.Remove("PlayerBindPress", "metrostroi_signal_startup"..self:EntIndex())
	end)
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
	if self.Models then
		for k,v in pairs(self.Models) do v:Remove() end
	end
	self.Models = {}
end

net.Receive("metrostroi-signal", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	ent.LightType = net.ReadInt(3)
	ent.Name = net.ReadString()
	ent.Lenses = net.ReadString()
	ent.ARSOnly = ent.Lenses == "ARSOnly"
	if not ent.ARSOnly then
		ent.LensesTBL = string.Explode("-",ent.Lenses)
	end
	if ent.RemoveModels then ent:RemoveModels() end
	--print(ent.Name..", signal received update")
end)

function ENT:Think()
	if self.SendReq == nil or (self.SendReq and CurTime() - self.SendReq <= 0) then return true elseif self.SendReq then self.SendReq = false end
	if not self.Models then self.Models = {} self.OldName = "++--++--++--" end
	if LocalPlayer():GetPos().z - self:GetPos().z > 500 or LocalPlayer():GetPos():Distance(self:GetPos()) > 10000 then
		--local x = 0
		for k,v in pairs(self.Models) do
			if IsValid(v) then
				v:Remove()
				self.Models[k] = nil
			end
		end
		--if x > 0 then
			--print(#self.Models)
			--self.Models = {}	
		--end
		self.NotDraw  = true
	else
		self.NotDraw  = false
	end
	if self.NotDraw then return end
	
	--if self.Name == "37" then print(self.Name) end
	--self.LightType = self:GetNWInt("LightType",nil)
	--self.Name = self:GetNWString("Name",nil)
	--self.Lenses = self:GetNWString("Lenses",nil)
	--self.ARSOnly = self.Lenses == "ARSOnly"
	--self.LensesTBL = string.Explode("-",self.Lenses)
	if not self.Name then
		if not self.sended  then
			--print((self.Name or tostring(self))..", require update")
			net.Start("metrostroi-signal")
				net.WriteEntity(self)
			net.SendToServer()
			self.sended = true
			timer.Simple(1.5,function() self.sended = false end)
		end
		return
	end
	--[[
	if ((self.LightType > 0 and self.Lenses == "") or (self.LightType == 1 and self.Lenses ~= "")
	or (self.LightType > 0 and self.Name == "") or (self.LightType == 1 and self.Name ~= "")
	or (self.Name ~= "" and self.Lenses == "") or (self.Name == "" and self.Lenses ~= "") or self.LightType < 1)
	]]
	--self.LightType = self.LightType - 2
	--self.ARSOnly = self.Lenses == "ARSOnly"
	--print(self.ARSOnly)
	--self.RouteNumber = self:GetNWString("RouteNumber")
	local models = self.TrafficLightModels[self.LightType] or {}
	local ID = 0
	-- Create new clientside models
	if not self.ARSOnly then
		if self.Lenses ~= self.OldLenses then
			for k,v in pairs(self.Models) do
				if IsValid(v) then
					v:Remove()
				end
				self.Models[k] = nil
			end
		end
		--if not self.LensesTBL or self.Lenses ~= self.OldLenses then
			--self.LensesTBL = string.Explode("-",self.Lenses)
		--end
		for k,v in pairs(models) do
			if type(v) == "string" then
				if not IsValid(self.Models[v]) then
					self.Models[v] = ClientsideModel(v,RENDERGROUP_OPAQUE)
					self.Models[v]:SetPos(self:LocalToWorld(self.BasePosition))
					self.Models[v]:SetAngles(self:GetAngles())
					self.Models[v]:SetParent(self)
				end
			end
		end
		self.NamesOffset = Vector(0,0,0)
		-- Create traffic light models
		if self.LightType > 2 then self.LightType = 2 end
		if self.LightType < 0 then self.LightType = 0 end

		local offset = self.RenderOffset[self.LightType] or Vector(0,0,0)
		for k,v in ipairs(self.LensesTBL) do
			if not IsValid(self.Models[ID]) then
				local data	
				if v ~= "M" then
					data = #v ~= 1 and self.TrafficLightModels[self.LightType][#v-1] or self.TrafficLightModels[self.LightType][Metrostroi.Signal_IS]
				else
					data = self.TrafficLightModels[self.LightType][Metrostroi.Signal_RP]
				end
				if not data then continue end
				offset = offset - Vector(0,0,data[1])
				self.NamesOffset = self.NamesOffset + Vector(0,0,data[1])

				self.Models[ID] = ClientsideModel(data[2],RENDERGROUP_OPAQUE)
				self.Models[ID]:SetPos(self:LocalToWorld(self.BasePosition + offset))
				self.Models[ID]:SetAngles(self:GetAngles())
				self.Models[ID]:SetParent(self)
			end
			ID = ID + 1
		end

		for i = 0,#self.Name-1 do
			if self.Name[i+1] == " " then continue end
			if not IsValid(self.Models["names_"..i]) then
				self.OldName = ""
				break
			end
		end

		if self.OldName ~= self.Name then
			for i = 0,#self.Name-1 do
				if self.Name[i+1] == " " then continue end
				if self.Models["names_"..i] then
					self.Models["names_"..i]:Remove()
					self.Models["names_"..i] = nil
				end
			end

			local offset = (self.RenderOffset[self.LightType] or Vector(0,0,0)) + (self.TrafficLightModels[self.LightType]["name"] or Vector(0,0,0))
			if self.LightType == 1 then
				offset = offset - self.NamesOffset
			end
			for i = 0,#self.Name-1 do
				if self.Name[i+1] == " " then continue end
				if not IsValid(self.Models["names_"..i]) then
					self.Models["names_"..i] = ClientsideModel("models/metrostroi/signals/letter.mdl",RENDERGROUP_OPAQUE)
					self.Models["names_"..i]:SetAngles(self:GetAngles())
					self.Models["names_"..i]:SetPos(self:LocalToWorld(self.BasePosition + offset - Vector(0,0,i*5.5)))
					self.Models["names_"..i]:SetParent(self)
				end
			end
		end
	else
		local k = "m1"
		local v = self.TrafficLightModels[self.LightType]["m1"]

		if not IsValid(self.Models[k]) then
			self.Models[k] = ClientsideModel(v,RENDERGROUP_OPAQUE)
			self.Models[k]:SetPos(self:LocalToWorld(self.BasePosition))
			self.Models[k]:SetAngles(self:GetAngles())
			self.Models[k]:SetParent(self)
		end
	end

	self.OldLenses = self.Lenses
	self.OldName = self.Name
end

function ENT:Draw()
	-- Draw model
	self:DrawModel()
end