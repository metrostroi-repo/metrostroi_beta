ENT.Type            = "anim"

ENT.PrintName       = "Track Switch"
ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable       = false
ENT.AdminSpawnable  = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Channel")	
end