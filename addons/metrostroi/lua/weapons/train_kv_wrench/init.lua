AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

SWEP.Weight				= 1
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= true


function SWEP:Initialize()
end
--[[
function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end
]]
function SWEP:Think()
	local tr = util.GetPlayerTrace( self.Owner )
	tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) or not IsValid(trace.Entity) then self:SetNWInt("Type",0) return end
	if trace.Entity:GetClass() == "gmod_train_bogey" then
		self:SetNWInt("Type",1)
		self:SetNWBool("EKK",trace.Entity:GetConnectDisconnect())
	else
		self:SetNWInt("Type",0)
	end
end
function SWEP:PrimaryAttack()
	local tr = util.GetPlayerTrace( self.Owner )
	tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end
	if not IsValid(trace.Entity) then return end
	if trace.Entity:GetClass() == "gmod_train_bogey" then
		self.Owner:EmitSound(Format("subway_trains/kv1_%d.wav",math.random(9)))
		trace.Entity:ConnectDisconnect()
		if self.Owner then
			RunConsoleCommand("say",tostring(self.Owner).." touched EKK on "..tostring(trace.Entity))
		end
	end
	self:SetNextPrimaryFire( CurTime()+0.5)
end