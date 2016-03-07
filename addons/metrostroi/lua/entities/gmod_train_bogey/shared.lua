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
	return self:GetNW2Int("Speed")/5
end
function ENT:GetMotorPower()
	return self:GetNW2Int("MotorPower")/50
end
function ENT:GetdPdT()
	return self:GetNW2Int("dPdT")/10
end
function ENT:GetBrakeSqueal()
	return self:GetNW2Int("BrakeSqueal")/10
end

if SERVER then
	function ENT:SetSpeed(val)
		if self._NetData[1] == math.floor(val*5) then return end
		self:SetNW2Int("Speed",math.floor(val*5))
	end

	function ENT:SetMotorPower(val)
		if self._NetData[2] == math.floor(val*50) then return end
		self:SetNW2Int("MotorPower",math.floor(val*50))
	end

	function ENT:SetdPdT(val)
		if self._NetData[3] == math.floor(val*10) then return end
		self:SetNW2Int("dPdT",math.floor(val*10))
	end

	function ENT:SetBrakeSqueal(val)
		if self._NetData[4] == math.floor(val*10) then return end
		self:SetNW2Int("BrakeSqueal",math.floor(val*10))
	end
end

function ENT:GetEntity()
	return self
end