AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/light_outside2_2.mdl")
	self.Sprites = {}
	
	self.YellowSignal = true
	self.WhiteSignal = false
end

function ENT:SetSprite(index,active,model,scale,brightness,pos,color)
	if active and self.Sprites[index] then return end
	SafeRemoveEntity(self.Sprites[index])
	self.Sprites[index] = nil
	
	if active then
		local sprite = ents.Create("env_sprite")
		sprite:SetParent(self)
		sprite:SetLocalPos(pos)
		sprite:SetLocalAngles(self:GetAngles())
	
		-- Set parameters
		sprite:SetKeyValue("rendercolor",
			Format("%i %i %i",
				color.r*brightness,
				color.g*brightness,
				color.b*brightness
			)
		)
		sprite:SetKeyValue("rendermode", 9) -- 9: WGlow, 3: Glow
		sprite:SetKeyValue("renderfx", 14)
		sprite:SetKeyValue("model", model)
		sprite:SetKeyValue("scale", scale)
		sprite:SetKeyValue("spawnflags", 1)
	
		-- Turn sprite on
		sprite:Spawn()
		self.Sprites[index] = sprite
	end
end

function ENT:Think()
	local yellow = self.WhiteSignal
	local white = self.YellowSignal
	
	-- The LED glow
	--[[self:SetSprite("a0",yellow,
		"models/metrostroi_signals/signal_sprite_001.vmt",0.40,1.0,
		Vector(10,4,16),Color(255,255,0,255))]]
	self:SetSprite("a0",yellow,
		"models/metrostroi_signals/signal_sprite_002.vmt",0.25,0.6,
		Vector(10,4,16),Color(255,255,0,255))
		
	--[[self:SetSprite("b0",white,
		"models/metrostroi_signals/signal_sprite_001.vmt",0.40,1.0,
		Vector(10,4,27),Color(255,255,255,255))]]
	self:SetSprite("b0",white,
		"models/metrostroi_signals/signal_sprite_002.vmt",0.25,0.6,
		Vector(10,4,27),Color(255,255,255,255))
	
	self:NextThink(CurTime() + 0.50)
	return true
end