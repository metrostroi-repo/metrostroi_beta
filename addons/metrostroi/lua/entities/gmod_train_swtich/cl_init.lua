include("shared.lua")
function ENT:Initialize()
	self.IsTouchable = true
end

function ENT:Pressed(isPressed)
	if isPressed then
		net.Start("metrostroi-specswitch-press")
			net.WriteEntity(self)
			net.WriteBool(isPressed)
		net.SendToServer()
	end
end