include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():Distance(self:GetPos()) > 10000 or LocalPlayer():GetPos().z - self:GetPos().z > 500 then return end
	local pos = self:LocalToWorld(Vector(25,0,15))
	local ang = self:LocalToWorldAngles(Angle(0,180,90))
	cam.Start3D2D(pos, ang, 0.125)
		--surface.SetDrawColor(255, 0, 0, 255)
		--surface.DrawRect(0, 0, 400, 240)
		local T0 = self:GetNW2Float("T0",os.time())+1396011937
		local T1 = self:GetNW2Float("T1",CurTime())
		local dT = (os.time()-T0 + (CurTime() % 1.0)) - (CurTime()-T1)
		
		local digits = { 1,2,3 }
		local interval = -dT + os.time() - (self:GetIntervalResetTime()+1396011937)
		if (interval <= (9*60+59)) and (interval >= 0) then
			digits[1] = math.floor(interval/60)
			digits[2] = math.floor((interval%60)/10)
			digits[3] = math.floor((interval%60)%10)
		else
			digits[1] = nil
			digits[2] = nil
			digits[3] = nil
		end

		for i,v in ipairs(digits) do
			local j = i-1
			local x = 40+100*(i-1)+50*math.floor(i/2)
			local y = 48
			Metrostroi.DrawClockDigit(x,y,1.7,v)
		end
		Metrostroi.DrawClockDigit(40+70,48,1.7,".")
	cam.End3D2D()
end