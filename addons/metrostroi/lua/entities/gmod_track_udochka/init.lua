AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/utilityconnecter006c.mdl")
	self.VMF = self.VMF or {}
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local physobj = self:GetPhysicsObject()
	if physobj:IsValid() then physobj:SetMass(25) end
end

local function removeWeldBetweenEnts(ent1,ent2)
	local constrainttable = constraint.FindConstraints(ent1,"Weld")
	for k,v in pairs(constrainttable) do
		if (v.Ent1 == ent1 or v.Ent1 == ent2) and (v.Ent2 == ent1 or v.Ent2 == ent2) then
			v.Constraint:Remove()
		end
	end
end
function ENT:Use()
	if self.Coupled then
		sound.Play("buttons/lever8.wav",(self:GetPos()+self.Coupled:GetPos())/2)
		removeWeldBetweenEnts(self,self.Coupled)
		removeWeldBetweenEnts(self.Coupled,self)

		self.Coupled = nil
		self.Timer = CurTime()+2
	end
end
function ENT:Think()
	self.Power = self.VMF.power and self.VMF.power == "1"
	if self.Timer and CurTime() - self.Timer > 0 then
		self.Timer = nil
	end
	local constrainttable = constraint.FindConstraints(self,"Weld")
	self.CoupledWith = nil
	for k,v in pairs(constrainttable) do
		if v.Type == "Weld" then
			if( (v.Ent1 == self or v.Ent1 == self.Coupled) and (v.Ent2 == self or v.Ent2 == self.Coupled.Coupled)) then
				self.CoupledWith = (v.Ent1 == self.Coupled and v.Ent1 or v.Ent2)
				if not self.Coupled then
					--removeWeldBetweenEnts(v.Ent1,v.Ent2)
				end
			end
		end
	end
	self:NextThink(CurTime() + 0.50)
	return true
end

function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end
