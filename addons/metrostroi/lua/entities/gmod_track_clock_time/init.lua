AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/clock_time.mdl")
end

function ENT:Think()
	-- Time sync
	self.Timeout = self.Timeout or 0
	if (CurTime() - self.Timeout) > 60.0 then
		self.Timeout = CurTime()
		self:SetNW2Float("T0",os.time()-1396011937)
		self:SetNW2Float("T1",CurTime())
	end
end