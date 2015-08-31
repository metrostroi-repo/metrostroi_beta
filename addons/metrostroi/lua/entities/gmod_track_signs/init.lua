AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
util.AddNetworkString "metrostroi-signs"

function ENT:Initialize()
	self:DrawShadow(false)
end

function ENT:OnRemove()
end

function ENT:Think()
end

function ENT:SendUpdate(ply)
	if not self.SignType then return end
	net.Start("metrostroi-signs")
		net.WriteEntity(self)
		net.WriteInt(self.SignType or 1,6)
		--print(Vector(0,self.YOffset,self.ZOffset))
		net.WriteVector(Vector(0,self.YOffset,self.ZOffset))
	net.Send(ply)
	--self:SetNWInt("Type",self.SignType or 1)
	--self:SetNWVector("Offset",Vector(0,self.YOffset,self.ZOffset))
	--self:SetNWInt("LightType", (self.SignalType or 0) + 2)
	--self:SetNWString("Name", self.Name or "NOT LOADED")
	--self:SetNWString("Lenses", self.ARSOnly and "ARSOnly" or self.LensesStr)
end
net.Receive("metrostroi-signs", function(_, ply)
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.SendUpdate then return end
	ent:SendUpdate(ply)
end)