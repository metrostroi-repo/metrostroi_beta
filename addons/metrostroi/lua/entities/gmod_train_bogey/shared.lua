ENT.Type            = "anim"

ENT.PrintName       = "Train Bogey"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:GetSpeed()
	return self:GetNWFloat("Speed")
end
function ENT:GetMotorPower()
	return self:GetNWFloat("MotorPower")
end
function ENT:GetdPdT()
	return self:GetNWFloat("dPdT")
end
function ENT:GetBrakeSqueal()
	return self:GetNWFloat("BrakeSqueal")
end

if SERVER then
	function ENT:SetSpeed(val)
		self:SetNWFloat("Speed",math.Round(val,0.5))
	end

	function ENT:SetMotorPower(val)
		self:SetNWFloat("MotorPower",math.Round(val,1.5))
	end

	function ENT:SetdPdT(val)
		self:SetNWFloat("dPdT",math.Round(val,2))
	end

	function ENT:SetBrakeSqueal(val)
		self:SetNWFloat("BrakeSqueal",math.Round(val,2))
	end
end

function ENT:GetEntity()
	return self
end