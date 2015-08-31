AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")




--------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/props_phx/rt_screen.mdl")
end

function ENT:Think()
end
