include("shared.lua")

hook.Add("PostDrawOpaqueRenderables", "metrostroi_sign_debug_draw", function(isDD)
		if isDD then return end
		if GetConVarNumber("metrostroi_drawdebug") == 0 then return end
		--print(2)
		for _,self in pairs(ents.FindByClass("gmod_track_signs")) do
			local pos = self:LocalToWorld(Vector(0,0,0))
			local ang = self:LocalToWorldAngles(Angle(0,90,90))
			cam.Start3D2D(pos , ang, 0.25)
				surface.SetDrawColor(125, 125, 0, 255)
				surface.DrawRect(-40, -20, 80, 20)
			cam.End3D2D()
		end
end )
function ENT:Initialize()
	--self.ModelProp = self:GetNWInt("Model")
	hook.Add("PlayerBindPress", "metrostroi_sign_startup"..self:EntIndex(), function()
		self.SendReq = CurTime() + math.random(3)
		hook.Remove("PlayerBindPress", "metrostroi_signal_startup"..self:EntIndex())
	end)
end

function ENT:OnRemove()
	if IsValid(self.Model) then self.Model:Remove() end
	self.Model = nil
end

function ENT:Think()
	self:NextThink(CurTime()+5)
	if self.SendReq == nil or (self.SendReq and CurTime() - self.SendReq <= 0) then return true elseif self.SendReq then self.SendReq = false end
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 10000 or LocalPlayer():GetPos().z - self:GetPos().z > 500 then
		if IsValid(self.Model) then self.Model:Remove() end
		self.Model= nil
		self.MustDraw = false
		return true
	else
		self.MustDraw = true
	end
	--self.ModelProp = self.SignModels[self:GetNWInt("Type",99)-1]
	--self.Offset = self:GetNWVector("Offset")
	if not self.ModelProp and not self.sended then
		--print(self,"require signs")
		net.Start("metrostroi-signs")
			net.WriteEntity(self)
		net.SendToServer()
		self.sended = true
		timer.Simple(1.5,function() self.sended = false end)
	end
	if not self.ModelProp then return true end
	if not IsValid(self.Model) then
		self.Model = ClientsideModel(self.ModelProp.model,RENDERGROUP_OPAQUE)
		self.Model:SetParent(self)
		self.Model:SetPos(self:LocalToWorld(self.ModelProp.pos  + self.Offset))
		local RAND = math.random(-10,10)
		self.Model:SetAngles(self:LocalToWorldAngles(self.ModelProp.angles + (self.ModelProp.noauto and Angle() or self.ModelProp.YAuto and Angle(RAND,0,0) or Angle(RAND,0,0))))
	end
	return true
end

function ENT:Draw()
end
net.Receive("metrostroi-signs", function()
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.SignModels then return end
	ent.ModelProp = ent.SignModels[net.ReadInt(6)-1]
	ent.Offset = net.ReadVector()
	--print(ent.Offset)
	if ent.Model then
		ent.Model:Remove()
	end
	--print(ent,"sign received update")
end)