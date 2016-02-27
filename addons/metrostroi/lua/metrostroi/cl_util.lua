--------------------------------------------------------------------------------
-- Clientside utility functions
--------------------------------------------------------------------------------
local bitmap_font_1 = {
	[10] = {
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0},
	["."] = {
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,0,0,
		0,0,1,0},
	[1] = {
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1},
	[2] = {
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		1,1,1,1,
		1,0,0,0,
		1,0,0,0,
		1,1,1,1},
	[3] = {
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		1,1,1,1},
	[4] = {
		1,0,0,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1},
	[5] = {
		1,1,1,1,
		1,0,0,0,
		1,0,0,0,
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		1,1,1,1},
	[6] = {
		1,1,1,1,
		1,0,0,0,
		1,0,0,0,
		1,1,1,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1},
	[7] = {
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1},
	[8] = {
		1,1,1,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1},
	[9] = {
		1,1,1,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1,
		0,0,0,1,
		0,0,0,1,
		0,0,0,1},
	[0] = {
		1,1,1,1,
		1,0,0,1,
		1,0,0,1,
		1,0,0,1,
		1,0,0,1,
		1,0,0,1,
		1,1,1,1},
}



--------------------------------------------------------------------------------
-- Draw bitmap digit
function Metrostroi.DrawClockDigit(cx,cy,scale,digit)
	local bitmap = bitmap_font_1[digit]
	if not bitmap then return end

	local w=12*scale
	local p=8*scale
	for i=1,4*7 do
		local x = (i-1)%4
		local y = math.floor((i-1)/4)
		if bitmap[i] == 1 then
			for z=1,6,1 do
				surface.SetDrawColor(Color(255,60,0,math.max(0,30-1*z*z)))
				surface.DrawRect(cx+x*w-z*scale, cy+y*w-z*scale, p+2*z*scale, p+2*z*scale)
			end

			surface.SetDrawColor(Color(255,240,0,255))
			surface.DrawRect(cx+x*w, cy+y*w, p, p)
		end
	end
end





function Metrostroi.PositionFromPanel(panel,button_id_or_vec,z,train)
	local self = train or ENT
	local panel = self.ButtonMap[panel]
	if not panel then return Vector(0,0,0) end
	if not panel.buttons then return Vector(0,0,0) end
	
	-- Find button or read position
	local vec
	if type(button_id_or_vec) == "string" then
		local button
		for k,v in pairs(panel.buttons) do
			if v.ID == button_id_or_vec then
				button = v
				break
			end
		end
		vec = Vector(button.x + (button.radius and 0 or (button.w or 0)/2),button.y + (button.radius and 0 or (button.h or 0)/2),z or 0)
	else
		vec = button_id_or_vec
	end

	-- Convert to global coords
	vec.y = -vec.y
	vec:Rotate(panel.ang)
	return panel.pos + vec * panel.scale
end

function Metrostroi.AngleFromPanel(panel,ang,train)
	local self = train or ENT
	local panel = self.ButtonMap[panel]
	if not panel then return Vector(0,0,0) end
	local true_ang = panel.ang + Angle(0,0,0)
	true_ang:RotateAroundAxis(panel.ang:Up(),ang or -90)
	return true_ang
end

function Metrostroi.ClientPropForButton(prop_name,config)
	local self = ENT
	self.ClientProps[prop_name] = {
		model = config.model or "models/metrostroi/81-717/button07.mdl",
		pos = Metrostroi.PositionFromPanel(config.panel,config.pos or config.button,(config.z or 0.2)),
		ang = Metrostroi.AngleFromPanel(config.panel,config.ang),
		color = config.color,
		skin = config.skin or 0,
		config = config,
	}
	if self.ButtonMap[config.panel] and not config.ignorepanel and config.propname == nil then
		for k,v in pairs(self.ButtonMap[config.panel].buttons) do
			if v.ID == config.button then
				v.PropName = prop_name
				break
			end
		end
		if not self.ButtonMap[config.panel].props then self.ButtonMap[config.panel].props = {} end
		table.insert(self.ButtonMap[config.panel].props,prop_name)
	end
end

function Metrostroi.TempoaryClientPropForButton(train,prop_name,config)
	local self = train
	self.ClientPropsOv[prop_name] = {
		model = config.model or "models/metrostroi/81-717/button07.mdl",
		pos = Metrostroi.PositionFromPanel(config.panel,config.pos or config.button,(config.z or 0.2),train),
		ang = Metrostroi.AngleFromPanel(config.panel,config.ang,train),
		color = config.color,
		skin = config.skin or 0,
		config = config,
	}
	if self.ButtonMap[config.panel] and not config.ignorepanel then
		for k,v in pairs(self.ButtonMap[config.panel].buttons) do
			if v.ID == config.button then
				v.PropName = prop_name
				break
			end
		end
		if not self.ButtonMap[config.panel].props then self.ButtonMap[config.panel].props = {} end
		table.insert(self.ButtonMap[config.panel].props,prop_name)
	end
end

function Metrostroi.InsertHide(panel,prop_name)
	local self = ENT
	if self.ButtonMap[panel] then
		if not self.ButtonMap[panel].props then self.ButtonMap[panel].props = {} end
		table.insert(self.ButtonMap[panel].props,prop_name)
	end
end






--------------------------------------------------------------------------------
-- Training markers
--------------------------------------------------------------------------------
local prevV = 0
local A = 0
local D1true = 0
local D2true = 0
local prevTime
hook.Add("PostDrawOpaqueRenderables", "metrostroi-draw-stopmarker",function()
	prevTime = prevTime or RealTime()
	local dT = math.max(0.001,RealTime() - prevTime)
	prevTime = RealTime()
	
	-- Skip if disabled
	if GetConVarNumber("metrostroi_stop_helper") ~= 1 then return end

	-- Get seat and train
	local seat = LocalPlayer():GetVehicle()
	if not seat then return end
	local train = seat:GetNWEntity("TrainEntity")
	if not IsValid(train) then return end

	-- Calculate acceleration
	local V = train:GetNWFloat("V",train:GetVelocity():Length()*0.01905)*0.277778
	local newA = (V - prevV)/dT
	prevV = V

	-- Calculate marker position
	A = train:GetNWFloat("A",A + (newA - A)*1.0*dT)
	local T1 = math.abs(V/(A+1e-8))
	local T2 = math.abs(V/(1.2+1e-8))
	local D1 = T1*V + (T1^2)*A/2
	local D2 = T2*V + (T2^2)*A/2

	-- Smooth out D	
	D1 = math.min(200,math.max(0,D1))*0.65
	D2 = math.min(200,math.max(0,D2))*0.70
	D1true = D1true + (D1 - D1true)*12.0*dT
	D2true = D2true + (D2 - D2true)*12.0*dT
	local offset1 = D1true/0.01905
	local offset2 = D2true/0.01905

	-- Draw marker
	if A > -0.1 then return end
--	if D1 > 195 then return end
	if D2 > 195 then return end
	local base_pos1 = train:LocalToWorld(Vector(500+offset1,80,10))
	cam.Start3D2D(base_pos1,train:LocalToWorldAngles(Angle(0,-90,90)),1.0)
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(-1,-1,8*20+2,4+2)
		for i=0,19 do
			surface.SetDrawColor(240,200,40)
			surface.DrawRect(8*i+0,0,4,4)
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(8*i+4,0,4,4)
		end
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(-1,-96,2,192)
		surface.DrawRect(8*20,-96,2,192)

--		surface.SetTextColor(255,255,255)
--		surface.SetFont("Trebuchet24")
--		surface.SetTextPos(64-128,-30)
--		surface.DrawText(Format("%.1f m  %.1f m/s %.1f m/s2",D,V,A))
--		surface.SetTextPos(64,-30)
--		surface.DrawText(Format("%.1f m %.0f sec",D,T))
	cam.End3D2D()

	local base_pos2 = train:LocalToWorld(Vector(500+offset2,80,10))
	cam.Start3D2D(base_pos2,train:LocalToWorldAngles(Angle(0,-90,90)),1.0)
		surface.SetDrawColor(240,40,40)
		surface.DrawRect(-1,-1,8*20+2,4+2)
		for i=0,19 do
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(8*i+0,0,4,4)
			surface.SetDrawColor(240,40,40)
			surface.DrawRect(8*i+4,0,4,4)
		end

		surface.SetDrawColor(240,40,40)
		surface.DrawRect(-1,-1+110,8*20+2,16+2)
		for i=0,19 do
			surface.SetDrawColor(0,0,0)
			surface.DrawRect(8*i+0,110,4,16)
			surface.SetDrawColor(240,40,40)
			surface.DrawRect(8*i+4,110,4,16)
		end

		surface.SetDrawColor(240,40,40)
		surface.DrawRect(-6,-96,6,192)
		surface.DrawRect(8*20,-96,4,192)
	cam.End3D2D()
end)




--------------------------------------------------------------------------------
-- Fix for gm_metrostroi 3D sky
--------------------------------------------------------------------------------
local player_state = {} 
timer.Create("Metrostroi_3DSkyFix",1.0,0,function()
	local player = LocalPlayer()
	if not IsValid(player) then return end
	if string.sub(game.GetMap(),1,13) ~= "gm_metrostroi" then return end
	
	RunConsoleCommand("r_3dsky", (player:GetPos().z < -1024) and "0" or "1")
end)