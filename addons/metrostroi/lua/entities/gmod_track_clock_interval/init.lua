AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")




--------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/metrostroi/signals/clock_interval.mdl")
end

function ENT:Think()
	-- Time sync
	self.Timeout = self.Timeout or 0
	if (CurTime() - self.Timeout) > 60.0 then
		self.Timeout = CurTime()
		self:SetNWFloat("T0",os.time()-1396011937)
		self:SetNWFloat("T1",CurTime())
	end

	-- Check if train passes the sign
	self.SensingTrain = false
	for ray=0,6 do
		local trace = {
			start = self:GetPos() - self:GetRight()*16 + self:GetForward()*50*(ray-3) + Vector(0,0,64),
			endpos = self:GetPos() - self:GetRight()*16 + self:GetForward()*50*(ray-3) - Vector(0,0,256),
			--mask = -1,
			--filter = { },
			ignoreworld = true,
		}
		
		--debugoverlay.Cross(trace.start,10,1,Color(0,0,255))
		--debugoverlay.Line(trace.start,trace.endpos,1,Color(0,0,255))
		
		local result = util.TraceLine(trace)
		if result.Hit and (not result.HitWorld) then
			--debugoverlay.Sphere(result.HitPos,5,1,Color(0,0,255),true)
			if result.Entity and (not result.Entity:IsPlayer()) then
				self.SensingTrain = true
			end
		end
	end

	-- If only sensing train for the first time, reset
	self.SensingTime = self.SensingTime or (os.time())
	if self.SensingTrain and (not self.IntervalReset) then
		self:SetIntervalResetTime(os.time()-1396011937)
		self.SensingTime = os.time()
		self.IntervalReset = true
	end
	
	-- If not sensing anything for more than 3 seconds, expect something again
	if (not self.SensingTrain) and (os.time() - self.SensingTime > 7.0) then
		self.IntervalReset = false
	end
	self:NextThink(CurTime() + 0.25)
	return true
end
