AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel(self.Model)
    local w=10  //Width
    local l=10  //Length
    local h=10  //Height
 
    //Vectors
    local min=Vector(0-(w/2),0-(l/2),0-(h/2))
    local max=Vector(w/2,l/2,h/2)
 
 
    self:PhysicsInitBox(Vector(-1,-1,-0.5),Vector(1,1,0.5))
	self:GetPhysicsObject():EnableCollisions(false)
	self.Sounds = {{
		"subway_trains/but_on1.wav",
		"subway_trains/but_on2.wav",
		"subway_trains/but_on3.wav",
		"subway_trains/but_on4.wav",
		"subway_trains/but_on5.wav",
		"subway_trains/but_on6.wav",
	},{
		"subway_trains/but_off1.wav",
		"subway_trains/but_off2.wav",
		"subway_trains/but_off3.wav",
		"subway_trains/but_off4.wav",
		"subway_trains/but_off5.wav",
		"subway_trains/but_off6.wav",
		"subway_trains/but_off7.wav",
	}}
	
	self.IsTouchable = true
	self.Value = 0
end

function ENT:Trigger(val)
	if type(val) == "boolean" then val = val and 1 or 0 end
	--if typ == "Set" then
		self.Value = val
	--elseif typ == "Toggle" then
		--self.Value = self.Value + 1
	--end
end
function ENT:Animate(value, min, max, speed, damping, stickyness)
	if not self.Anims then
		self.Anims = {}
		self.Anims.val = value
		self.Anims.V = 0.0
		self.Anims.block = false
	end
	if value ~= self.Anims.oldival then
		self.Anims.block = false
	end
	if self.Anims.block then
		self:SetPoseParameter("position",min + (max-min)*self.Anims.val)
		return min + (max-min)*self.Anims.val
	end
	--if self["_anim_old_"..id] == value then return self["_anim_old_"..id] end
	-- Generate sticky value
	if stickyness and damping then
		self.Anims.stuck = self.Anims.stuck or false
		self.Anims.P = self.Anims.P or value
		if (math.abs(self.Anims.P - value) < stickyness) and (self.Anims.stuck) then
			value = self.Anims.P
			self.Anims.stuck = false
		else
			self.Anims.P = value
		end
	end
		
	if damping == false then
		local dX = speed * self.DeltaTime
		if value > self.Anims.val then
			self.Anims.val = self.Anims.val + dX
		end
		if value < self.Anims.val then
			self.Anims.val = self.Anims.val - dX
		end
		if math.abs(value - self.Anims.val) < dX then
			self.Anims.val = value
		end
	else
		-- Prepare speed limiting
		local delta = math.abs(value - self.Anims.val)
		local max_speed = 1.5*delta / self.DeltaTime
		local max_accel = 0.5 / self.DeltaTime

		-- Simulate
		local dX2dT = (speed or 128)*(value - self.Anims.val) - self.Anims.V * (damping or 8.0)
		if dX2dT >  max_accel then dX2dT =  max_accel end
		if dX2dT < -max_accel then dX2dT = -max_accel end
		
		self.Anims.V = self.Anims.V + dX2dT * self.DeltaTime
		if self.Anims.V >  max_speed then self.Anims.V =  max_speed end
		if self.Anims.V < -max_speed then self.Anims.V = -max_speed end
		
		self.Anims.val = math.max(0,math.min(1,self.Anims.val + self.Anims.V * self.DeltaTime))
		
		-- Check if value got stuck
		if (math.abs(dX2dT) < 0.001) and stickyness and (self.DeltaTime > 0) then
			self.Anims.stuck = true
		end
	end

	self:SetPoseParameter("position",min + (max-min)*self.Anims.val)
	if self.Anims.val == self.Anims.oldval and value == self.Anims.oldival and self.Anims.timer and CurTime() - self.Anims.timer > 0 then
		self.Anims.block = true
	end
	if self.Anims.val == self.Anims.oldval and value == self.Anims.oldival and not self.Anims.timer then
		self.Anims.timer = CurTime() + 0.1
	end
	if (self.Anims.val ~= self.Anims.oldval or value ~= self.Anims.oldival) and self.Anims.timer then
		self.Anims.timer = nil
	end
	--print(id,min + (max-min)*self.Anims.val,value, min + (max-min)*value)
	--self["_anim_old_"..id] = min + (max-min)*self.Anims.val
	self.Anims.oldval = self.Anims.val
	self.Anims.oldival = value
	return min + (max-min)*self.Anims.val
end

function ENT:Think()
	self.PrevTime = self.PrevTime or RealTime()
	self.DeltaTime = (RealTime() - self.PrevTime)
	self.PrevTime = RealTime()
	--self.Value = CurTime()%2>1 and 1 or 0
	self:Animate(self.Value, 	0,1, 16, false)
	if self.Value ~= self.OldValue then
		local snd
		if self.Value > 0.5 then
			snd = self.Sounds[2]

			if type(snd) == "table" then
				snd = table.Random(snd)
			end
		else
			snd = self.Sounds[1]

			if type(snd) == "table" then
				snd = table.Random(snd)
			end
		end

		self:EmitSound(snd, 75, 100, 1)
		
		self.OldValue = self.Value
	end
	self:NextThink(CurTime()+0.05)
	return true
end

util.AddNetworkString("metrostroi-specbutton-press")
net.Receive("metrostroi-specbutton-press",function()
	net.ReadEntity():Trigger(net.ReadBool())
end)