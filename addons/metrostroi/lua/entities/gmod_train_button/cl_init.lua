include("shared.lua")
function ENT:Initialize()
	self.IsTouchable = true
end

function ENT:Pressed(isPressed)
	net.Start("metrostroi-specbutton-press")
		net.WriteEntity(self)
		net.WriteBool(isPressed)
	net.SendToServer()
end