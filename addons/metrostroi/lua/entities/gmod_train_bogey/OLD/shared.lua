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
	self._Net = {}
end

function ENT:GetSpeed()
	return self._Net[1] or 0
end
function ENT:GetMotorPower()
	return self._Net[2] or 0
end
function ENT:GetdPdT()
	return self._Net[3] or 0
end
function ENT:GetBrakeSqueal()
	return self._Net[4] or 0
end

--------------------------------------------------------------------------------
-- Finds players in given range(8192 and 768)
--------------------------------------------------------------------------------
function ENT:GetPlayersInRange()
	local plytbl = {}
	local entpos = self:GetPos()
	for _,player in pairs(player.GetAll()) do
		local vec = entpos - player:GetPos()
		local dx,dy,dz = vec.x,vec.y,vec.z
		if (math.abs(dx) + math.abs(dy)) < 8192 and math.abs(dz) < 768 then
			table.insert(plytbl, player)
		end
	end
	return plytbl
end

if SERVER then
	function ENT:SetSpeed(val)
		local val = math.Round(val,0.5)
		if self._Net[1] ~= nil and self._Net[1] == val then return end
		local plytbl = self:GetPlayersInRange()
		net.Start("metrostroi-bogey")
			net.WriteEntity(self)
			net.WriteInt(0,3)
			net.WriteFloat(val)
		net.Send(plytbl)

		self._Net[1] = val
	end

	function ENT:SetMotorPower(val)
		local val = math.Round(val,1.5)
		if self._Net[2] ~= nil and self._Net[2] == val then return end
		local plytbl = self:GetPlayersInRange()
		net.Start("metrostroi-bogey")
			net.WriteEntity(self)
			net.WriteInt(1,3)
			net.WriteFloat(val)
		net.Send(plytbl)
		
		self._Net[2] = val
	end

	function ENT:SetdPdT(val)
		local val = math.Round(val,2)
		if self._Net[3] ~= nil and self._Net[3] == val then return end
		local plytbl = self:GetPlayersInRange()
		net.Start("metrostroi-bogey")
			net.WriteEntity(self)
			net.WriteInt(2,3)
			net.WriteFloat(val)
		net.Send(plytbl)
		
		self._Net[3] = val
	end

	function ENT:SetBrakeSqueal(val)
		local val = math.Round(val,2)
		if self._Net[4] ~= nil and self._Net[4] == val then return end
		local plytbl = self:GetPlayersInRange()
		net.Start("metrostroi-bogey")
			net.WriteEntity(self)
			net.WriteInt(3,3)
			net.WriteFloat(val)
		net.Send(plytbl)
		
		self._Net[4] = val
	end

	function ENT:SendAllToClient(ply)
		if not ply or (type(ply) == "table" and #ply == 0) then return end
		net.Start("metrostroi-bogey-sync")
			net.WriteEntity(self)
			net.WriteTable(self._Net)
		net.Send(ply)
	end
end

function ENT:GetEntity()
	return self
end