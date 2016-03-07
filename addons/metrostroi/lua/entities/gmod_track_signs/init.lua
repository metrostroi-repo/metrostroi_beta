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
	--if self.SignType == 17 or self.SignType == 18 then self:Remove() end --9
end

function ENT:SendUpdate(ply)
	if not self.SignType then return end
	net.Start("metrostroi-signs")
		net.WriteEntity(self)
		net.WriteInt(self.SignType or 1,6)
		--print(Vector(0,self.YOffset,self.ZOffset))
		net.WriteVector(Vector(0,self.YOffset,self.ZOffset))
	if ply then net.Send(ply) else net.Broadcast() end
	--self:SetNW2Int("Type",self.SignType or 1)
	--self:SetNW2Vector("Offset",Vector(0,self.YOffset,self.ZOffset))
	--self:SetNW2Int("LightType", (self.SignalType or 0) + 2)
	--self:SetNW2String("Name", self.Name or "NOT LOADED")
	--self:SetNW2String("Lenses", self.ARSOnly and "ARSOnly" or self.LensesStr)
end
net.Receive("metrostroi-signs", function(_, ply)
	local ent = net.ReadEntity()
	if not IsValid(ent) or not ent.SendUpdate then return end
	ent:SendUpdate(ply)
end)