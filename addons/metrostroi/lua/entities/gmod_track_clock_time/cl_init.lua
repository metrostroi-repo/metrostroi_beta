include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():Distance(self:GetPos()) > 10000 or LocalPlayer():GetPos().z - self:GetPos().z > 500 then return end
	local pos = self:LocalToWorld(Vector(50,0,15))
	local ang = self:LocalToWorldAngles(Angle(0,180,90))
	cam.Start3D2D(pos, ang, 0.125)
		--surface.SetDrawColor(0, 0, 0, 255)
		--surface.DrawRect(0, 0, 800, 240)

		local T0 = self:GetNW2Float("T0",os.time())+1396011937
		local T1 = self:GetNW2Float("T1",CurTime())
		local dT = (os.time()-T0 + (CurTime() % 1.0)) - (CurTime()-T1)
		
		local digits = { 1,2,3,4,5,6 }
		local os_time = os.time()-dT
		local d = os.date("!*t",os_time)
		digits[1] = math.floor(d.hour / 10)
		digits[2] = math.floor(d.hour % 10)
		digits[3] = math.floor(d.min / 10)
		digits[4] = math.floor(d.min % 10)
		digits[5] = math.floor(d.sec / 10)
		digits[6] = math.floor(d.sec % 10)

		for i,v in ipairs(digits) do
			local j = i-1
			local x = 56+100*(i-1)+50*math.floor((i-1)/2)
			local y = 48
			Metrostroi.DrawClockDigit(x,y,1.7,v)
		end
		Metrostroi.DrawClockDigit(56+170,48,1.7,".")
	cam.End3D2D()
end