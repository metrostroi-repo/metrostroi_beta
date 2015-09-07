ENT.Type            = "anim"

ENT.PrintName       = "Train Bogey"
ENT.Author          = ""
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category		= "Metrostroi"

ENT.Spawnable       = true
ENT.AdminSpawnable  = false

function ENT:SetupDataTables()
	self._NetData = {}
end
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
		local val = math.Round(val,0.5)
		if self._NetData[1] == val then return end
		self:SetNWFloat("Speed",val)
	end

	function ENT:SetMotorPower(val)
		local val = math.Round(val,1.5)
		if self._NetData[2] == val then return end
		self:SetNWFloat("MotorPower",val)
	end

	function ENT:SetdPdT(val)
		local val = math.Round(val,2)
		if self._NetData[3] == val then return end
		self:SetNWFloat("dPdT",val)
	end

	function ENT:SetBrakeSqueal(val)
		local val = math.Round(val,2)
		if self._NetData[4] == val then return end
		self:SetNWFloat("BrakeSqueal",val)
	end
end

function ENT:GetEntity()
	return self
end