AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
end

--[[function ENT:MakeStationSign(rus_name,eng_name)
	self:SetNWString("Type","station_sign")
	self:SetNWInt("Style",2)
	self:SetNWString("RusName",rus_name)
	self:SetNWString("EngName",eng_name)
end]]--