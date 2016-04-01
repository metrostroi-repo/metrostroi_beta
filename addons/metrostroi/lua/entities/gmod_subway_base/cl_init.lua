include("shared.lua")
--if LocalPlayer():GetName():find("iNok") then RunConsoleCommand("say","ЛВЗ говно, обажаю МВМ") end
surface.CreateFont("MetrostroiSubway_LargeText", {
  font = "Arial",
  size = 100,
  weight = 500,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_SmallText", {
  font = "Arial",
  size = 70,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_VerySmallText", {
  font = "Arial",
  size = 45,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_VerySmallText2", {
  font = "Arial",
  size = 35,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
 })
 surface.CreateFont("MetrostroiSubway_VerySmallText3", {
  font = "Arial",
  size = 25,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_LargeText2", {
  font = "Arial",
  size = 86,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_LargeText3", {
  font = "Arial",
  size = 66,
  weight = 1000,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_IGLA", {
  font = "IEE2",
  size = 30,
  weight = 0,
  blursize = 0,
  scanlines = 0,
  antialias = false,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_FixedSYS", {
  font = "FixedsysTTF",
  size = 30,
  weight = 0,
  blursize = 0,
  scanlines = 0,
  antialias = false,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_InfoPanel", {
  font = "Arial",
  size = 64,
  weight = 0,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("MetrostroiSubway_InfoRoute", {
  font = "Arial",
  size = 80,
  weight = 800,
  blursize = 0,
  scanlines = 0,
  antialias = true,
  underline = false,
  italic = false,
  strikeout = false,
  symbol = false,
  rotary = false,
  shadow = false,
  additive = false,
  outline = false
})
surface.CreateFont("Trebuchet24", { --Creating BUILTIN font (idk what happened with this font')
  font = "Trebuchet",
  size = 24,
  weight = 400,
  blursize = 0,
  scanlines = 10,
  antialias =  true,
  additive = false,
})
--------------------------------------------------------------------------------
-- Console commands and convars
--------------------------------------------------------------------------------
concommand.Add("metrostroi_train_manual", function()--ply, _, args)
--[[	local w = ScrW() * 2/3
	local h = ScrH() * 2/3
	local browserWindow = vgui.Create("DFrame")
	browserWindow:SetTitle("Train Manual")
	browserWindow:SetPos((ScrW() - w)/2, (ScrH() - h)/2)
	browserWindow:SetSize(w,h)
	browserWindow.OnClose = function()
		browser = nil
		browserWindow = nil
	end
	browserWindow:MakePopup()

	local browser = vgui.Create("DHTML",browserWindow)
	browser:SetPos(10, 25)
	browser:SetSize(w - 20, h - 35)

	browser:OpenURL
  ]]--
	gui.OpenURL("http://phoenixblack.github.io/Metrostroi/manual.html")
end)




--------------------------------------------------------------------------------
-- Buttons layout
--------------------------------------------------------------------------------
--ENT.ButtonMap = {} Leave nil if unused

-- General Panel
--[[table.insert(ENT.ButtonMap,{
	pos = Vector(7,0,0),
	ang = Angle(0,90,90),
	width = 300,
	height = 100,
	scale = 0.0625,

	buttons = {
		{ID=1, x=-117,  y=   0,  radius=20, tooltip="Test 1"},
		{ID=2, x= -80,  y=   0,  radius=20, tooltip="Test 2"},
	}
})]]--


--------------------------------------------------------------------------------
-- Decoration props
--------------------------------------------------------------------------------
ENT.ClientProps = {}

--[[table.insert(ENT.ClientProps,{
	model = "models/metrostroi/81-717/cabin.mdl",
	pos = Vector(421,-5,15),
	ang = Angle(0,-90,0)
})]]--





--------------------------------------------------------------------------------
-- Clientside entities support
--------------------------------------------------------------------------------
local lastButton
local lastTouch
local drawCrosshair
local canDrawCrosshair
local toolTipText
local lastAimButtonChange
local lastAimButton

function ENT:ShouldRenderClientEnts()
	return self:GetPos():Distance(LocalPlayer():GetPos()) < 960*5 and LocalPlayer():GetPos().z - self:GetPos().z < 500
end

function ENT:ApplyMatrix()
end
function ENT:SpawnCSEnt(k)
	local v = self.ClientPropsOv and self.ClientPropsOv[k] or self.ClientProps[k]
	if v and k ~= "BaseClass" and not IsValid(self.ClientEnts[k]) and not self.Hidden[k] and not self.HiddenAnim[id] then
		local cent = ClientsideModel(v.model ,RENDERGROUP_OPAQUE)
		if not IsValid(cent) then return end
		cent:SetPos(self:LocalToWorld(v.pos))
		cent:SetAngles(self:LocalToWorldAngles(v.ang))
		cent:SetParent(self)

		cent:SetSkin(v.skin or 0)

		if v.bodygroup then
			for k1,v1 in pairs(v.bodygroup) do
				cent:SetBodygroup(v1,k1)
			end
		end

		local texture = Metrostroi.Skins["train"][self:GetNW2String("texture")]
		local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("passtexture")]
		local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("cabtexture")]
		for k1,v1 in pairs(cent:GetMaterials()) do
			local tex = string.Explode("/",v1)
			tex = tex[#tex]
			if cabintexture and cabintexture.textures[tex] then
				if type(cabintexture.textures[tex]) ~= "table" then
					cent:SetSubMaterial(k1-1,cabintexture.textures[tex])
				end
			end
			if passtexture and passtexture.textures[tex] then
				cent:SetSubMaterial(k1-1,passtexture.textures[tex])
			end
			if texture and texture.textures[tex] then
				cent:SetSubMaterial(k1-1,texture.textures[tex])
			end
		end
		--if self.ClientPropsMatrix[k] then cent:EnableMatrix("RenderMultiply",self.ClientPropsMatrix[k]) end
		--print(self:GetNW2String("texture",nil))
		self.ClientEnts[k] = cent
		if self.Anims[k] and self.Anims[k].alpha then
			if self.Anims[k].alpha > 0 then
				cent:SetColor(ColorAlpha(v.color or color_white,self.Anims[k].alpha*255))
				cent:SetRenderMode(RENDERMODE_TRANSALPHA)
			else
				cent:Remove()
				self:ShowHide(k, false,true)
			end
		else
			cent:SetColor(v.color or color_white)
		end
		self:ShowHide(k, not self.Hidden[k],true)
	end
end
function ENT:SetCSBodygroup(csent,id,value)
	if not self.ClientProps[csent].bodygroup then self.ClientProps[csent].bodygroup = {} end
	self.ClientProps[csent].bodygroup[id] = value
	if IsValid(self.ClientEnts[csent]) then self.ClientEnts[csent]:SetBodygroup(id,value) end
end
function ENT:CreateCSEnts()
	for k in pairs(self.ClientProps) do
		if k ~= "BaseClass" and not IsValid(self.ClientEnts[k]) then
			self:SpawnCSEnt(k)
		end
	end
	if not self.ClientPropsOv then return end
	for k in pairs(self.ClientPropsOv) do
		if k ~= "BaseClass" and not IsValid(self.ClientEnts[k]) then
			self:SpawnCSEnt(k)
		end
	end
end

function ENT:RemoveCSEnts()
	if self.ClientEnts then
		for _,v in pairs(self.ClientEnts) do
			if IsValid(v) then
				--v:DisableMatrix("RenderMultiply")
				v:Remove()
			end
		end
	end
	self.ClientEnts = {}
end

function ENT:ApplyCSEntRenderMode(render)
	for _,v in pairs(self.ClientEnts) do
		if render then
			v:SetRenderMode(RENDERMODE_NORMAL)
		else
			v:SetRenderMode(RENDERMODE_NONE)
		end
	end
end



-- Checks if the player is driving a train, also returns said train
local function isValidTrainDriver(ply)
	local seat = ply:GetVehicle()
	if (not seat) or (not seat:IsValid()) then return false end
	local train = seat:GetNW2Entity("TrainEntity")
	if (not train) or (not train:IsValid()) then return false end
	return train
end
--------------------------------------------------------------------------------
-- Clientside initialization
--------------------------------------------------------------------------------
function ENT:CanDrawThings()
	return not IsValid(LocalPlayer():GetVehicle()) or self == LocalPlayer():GetVehicle():GetNW2Entity("TrainEntity")
end
hook.Add("PostDrawOpaqueRenderables", "metrostroi_base_draw", function(isDD)
	if isDD then
		return
	end
	for _,ent in pairs(ents.GetAll()) do
		--print(self.BaseClassName)
		if ent.Base ~= "gmod_subway_base" then continue end
		if ent.DrawPost then ent:DrawPost(not ent:CanDrawThings()) end
		if not ent:CanDrawThings() then continue end
		ent.CLDraw = true

		if not ent.ShouldRenderClientEnts or not ent:ShouldRenderClientEnts() then continue end

		if ent.Systems then
			for _,v in pairs(ent.Systems) do
				v:ClientDraw()
			end
		end

		--Drawing schedule for trains which support it
		if ent.ButtonMap and ent.ButtonMap["Schedule"] then
			ent:DrawOnPanel("Schedule", function(panel)
				ent:DrawSchedule(panel)
			end)
		end

		-- Debug draw for buttons
		if (GetConVarNumber("metrostroi_drawdebug") > 0) and (ent.ButtonMap ~= nil) then
			for kp,panel in pairs(ent.ButtonMap) do
				if kp ~= "BaseClass" then
					ent:DrawOnPanel(kp,function()
						surface.SetDrawColor(0,0,255)
						if ent.HiddenPanels[kp] then surface.SetDrawColor(255,0,0) end
						surface.DrawOutlinedRect(0,0,panel.width,panel.height)

						if panel.aimX and panel.aimY then
							surface.SetTextColor(255,255,255)
							surface.SetFont("BudgetLabel")
							surface.SetTextPos(panel.width/2,5)
							surface.DrawText(string.format("%d %d",panel.aimX,panel.aimY))
						end


						--surface.SetDrawColor(255,255,255)
						--surface.DrawRect(0,0,panel.width,panel.height)
						if panel.buttons then

							surface.SetAlphaMultiplier(0.2)
							if ent.HiddenPanels[kp] then surface.SetAlphaMultiplier(0.1) end

							for kb,button in pairs(panel.buttons) do
								if ent.Hidden[button.PropName] or ent.Hidden[button.ID] or ent.HiddenAnim[button.PropName] or ent.HiddenAnim[button.ID] or ent.HiddenButton[button.PropName] or ent.HiddenButton[button.ID] then
									surface.SetDrawColor(255,255,0)
								elseif ent.Hidden[kb] or ent.HiddenAnim[kb] then
									surface.SetDrawColor(255,255,0)
								elseif ent.HiddenPanels[kp] then
									surface.SetDrawColor(100,0,0)
								elseif not button.ID then
									surface.SetDrawColor(25,40,180)
								elseif button.state then
									surface.SetDrawColor(255,0,0)
								else
									surface.SetDrawColor(0,255,0)
								end

								if button.w and button.h then
									surface.DrawRect(button.x, button.y, button.w, button.h)
									surface.DrawRect(button.x + button.w/2 - 8,button.y + button.h/2 - 8,16,16)
									else
										ent:DrawCircle(button.x,button.y,button.radius or 10)
									surface.DrawRect(button.x-8,button.y-8,16,16)
								end
							end

							--Gotta reset this otherwise the qmenu draws transparent as well
							surface.SetAlphaMultiplier(1)

						end


					end,true)
				end
			end
		end
	end
end)
function ENT:Initialize()
	-- Create clientside props
	self.ClientEnts = {}
	self.ClientPropsMatrix = {}
	self.ButtonMapMatrix = {}
	-- Passenger models
	self.PassengerEnts = {}
	self.PassengerPositions = {}
	self.HiddenPanels = {}
	self.Hidden = {}
	self.HiddenAnim = {}
	self.HiddenButton = {}
	--self.HiddenQuele = {}
	-- Systems defined in the train
	self.Systems = {}
	-- Initialize train systems
	self:InitializeSystems()
	self.Anims = {}
	-- Create sounds
	self:InitializeSounds()
	self.Sounds = {}
	--self:EntIndex()
	self.PassengerModels = {
		"models/metrostroi/passengers/f1.mdl",
		"models/metrostroi/passengers/f2.mdl",
		"models/metrostroi/passengers/f3.mdl",
		"models/metrostroi/passengers/f4.mdl",
		"models/metrostroi/passengers/m1.mdl",
		"models/metrostroi/passengers/m2.mdl",
		"models/metrostroi/passengers/m4.mdl",
		"models/metrostroi/passengers/m5.mdl",
	}
end

function ENT:OnRemove()
	self:RemoveCSEnts()
	drawCrosshair = false
	canDrawCrosshair = false
	toolTipText = nil

	for _,v in pairs(self.Sounds) do
		v:Stop()
	end
	for _,v in pairs(self.PassengerEnts) do
		v:Remove()
	end
end

--------------------------------------------------------------------------------
-- Default think function
--------------------------------------------------------------------------------
function ENT:Think()
	--self.RenderClientEnts = self:ShouldRenderClientEnts()
	self.PrevTime = self.PrevTime or RealTime()
	self.DeltaTime = (RealTime() - self.PrevTime)
	self.PrevTime = RealTime()

	-- Simulate systems
	if self.Systems then
		for _,v in pairs(self.Systems) do
			v:ClientThink(self.DeltaTime)
		end
	end

	-- Reset CSEnts
	if CurTime() - (self.ClientEntsResetTimer or 0) > 10.0 and IsValid(self) then
		self.ClientEntsResetTimer = CurTime()
		self:RemoveCSEnts()
		self:CreateCSEnts()
		for k,v in pairs(self.PassengerEnts) do
			--local min,max = self:GetStandingArea()
			if IsValid(v) then
				v:SetParent(nil)
				v:SetPos(self:LocalToWorld(self.PassengerPositions[k]))
				v:SetParent(self)
			end
		end
	end

	-- Update CSEnts

	if CurTime() - (self.PrevThinkTime or 0) > 1 or self.UpdateRender then
		self.PrevThinkTime = CurTime()

		-- Invalidate entities if needed, for hotloading purposes
		if not self.ClientPropsInitialized then
			self.ClientPropsInitialized = true
			self:RemoveCSEnts()
			self.RenderClientEnts = false
		end

		local shouldrender = self:ShouldRenderClientEnts()
		if self.RenderClientEnts ~= shouldrender or self.UpdateRender then
			if shouldrender and IsValid(self)  then
				self:CreateCSEnts()
				self.RenderClientEnts = shouldrender
			elseif not shouldrender then
				self:RemoveCSEnts()
				self.RenderClientEnts = shouldrender
			end
		end

		--Uncomment for skin disco \o/
		--[[
		for k,v in pairs(self.ClientEnts) do
			if v:SkinCount() > 0 then
				v:SetSkin((v:GetSkin()+1)%(v:SkinCount()-1))
			end
		end
		]]--
		self.UpdateRender = false
	end

	--print("Acceleration at (0,0,0)",self:GetTrainAccelerationAtPos(Vector(0,0,0)))
	--print("Acceleration at (400,0,0)",self:GetTrainAccelerationAtPos(Vector(400,0,0)))
	--Example of pose parameter
	--[[for k,v in pairs(self.ClientEnts) do
		if v:GetPoseParameterRange(0) != nil then
			v:SetPoseParameter("position",math.sin(CurTime()*4)/2+0.5)
		end
	end]]--

	-- Update passengers
	if self.RenderClientEnts then
		if #self.PassengerEnts ~= self:GetNW2Float("PassengerCount") then

			-- Passengers go out
			while #self.PassengerEnts > self:GetNW2Float("PassengerCount") do
				local ent = self.PassengerEnts[#self.PassengerEnts]
				table.remove(self.PassengerPositions,#self.PassengerPositions)
				table.remove(self.PassengerEnts,#self.PassengerEnts)
				ent:Remove()
			end
			-- Passengers go in
			while #self.PassengerEnts < self:GetNW2Float("PassengerCount") do
				local min,max = self:GetStandingArea()
				local pos = min + Vector((max.x-min.x)*math.random(),(max.y-min.y)*math.random(),(max.z-min.z)*math.random())

				local ent = ClientsideModel(table.Random(self.PassengerModels),RENDERGROUP_OPAQUE)
				ent:SetPos(self:LocalToWorld(pos))
				ent:SetAngles(Angle(0,math.random(0,360),0))
				ent:SetSkin(math.floor(ent:SkinCount()*math.random()))
				ent:SetModelScale(0.98 + (-0.02+0.04*math.random()),0)
				ent:SetParent(self)
				table.insert(self.PassengerPositions,pos)
				table.insert(self.PassengerEnts,ent)
			end
		end
	else
		for k,v in pairs(self.PassengerEnts) do
			if IsValid(v) then v:Remove() end
			self.PassengerEnts[k] = nil
		end
	end
end

--------------------------------------------------------------------------------
-- Various rendering shortcuts for trains
--------------------------------------------------------------------------------
function ENT:DrawCircle(cx,cy,radius)
	local step = 2*math.pi/12
	local vertexBuffer = { {}, {}, {} }

	for i=1,12 do
		vertexBuffer[1].x = cx + radius*math.sin(step*(i+0))
		vertexBuffer[1].y = cy + radius*math.cos(step*(i+0))
		vertexBuffer[2].x = cx
		vertexBuffer[2].y = cy
		vertexBuffer[3].x = cx + radius*math.sin(step*(i+1))
		vertexBuffer[3].y = cy + radius*math.cos(step*(i+1))
		surface.DrawPoly(vertexBuffer)
	end
end

--------------------------------------------------------------------------------
-- Schedule Drawing
--
-- Reference: http://static.diary.ru/userdir/1/0/4/7/1047/28088395.jpg
--------------------------------------------------------------------------------
local function AddZero( s )
	if #s == 0 then
		return "00"
	elseif #s == 1 then
		return "0" .. s
	else
		return s
	end
end

local function HoursFromStamp( stamp )
	return AddZero(tostring(math.floor(stamp/3600)%24))
end

local function MinutesFromStamp( stamp )
	return AddZero(tostring(math.floor(stamp/60)%60))
end

local function SecondsFromStamp( stamp )
	return AddZero(tostring(stamp%60))
end

surface.CreateFont( "Schedule_Hand", {
	font = "Monotype Corsiva",
	size = 30,
	weight = 600
})
surface.CreateFont( "Schedule_Hand_Small", {
	font = "Monotype Corsiva",
	size = 18,
	weight = 600
})
surface.CreateFont( "Schedule_Machine", {
	font = "Arial",
	size = 22,
	weight = 500
})
surface.CreateFont( "Schedule_Machine_Small", {
	font = "Arial",
	size = 16,
	weight = 600
})

local DrawRect = surface.DrawRect
local DrawTextHand = function(txt, x, y, col)
	draw.SimpleText(txt, "Schedule_Hand", x, y, Color(0,15*col.y,85*col.z), 0, 0)
end
local DrawTextHandSmall = function(txt, x, y, col)
	draw.SimpleText(txt, "Schedule_Hand_Small", x, y, Color(0,15*col.y,85*col.z), 0, 0)
end
local DrawTextMachine = function(txt, x, y)
	draw.SimpleText(txt, "Schedule_Machine", x, y, Color(0,0,0), 0, 0)
end
local DrawTextMachineSmall = function(txt, x, y)
	draw.SimpleText(txt, "Schedule_Machine_Small", x, y, Color(0,0,0), 0, 0)
end

local function FineStationName(st)
	local StT = string.Explode(" ",st)
	local str = ""
	if #StT > 1 then
		str = StT[1][1]..". "..table.concat(StT," ",2)
	else
		str = st
	end
	return str
end
-- Placeholder code, to be removed when schedule system is in place
local Schedule = {
	stations = {
		{"Station 1", os.time() + 20},
		{"Station 2", os.time() + 46},
		{"Station 3", os.time() + 80},
		{"Station 4", os.time() + 95},
		{"Station 5", os.time() + 120}
	},
	total = 2000,
	interval = 300,
	routenumber = math.random(100,999),
	pathnumber = math.random(100,999)
}

local col1w = 80 -- 1st Column width
local col2w = 32 -- The other column widths
local rowtall = 30 -- Row height, includes -only- the usable space and not any lines
local rowtall2 = rowtall*2 -- Helper

local defaultlight = Vector(0.8,0.8,0.8) -- Light to be used when cabinlights are on
function ENT:DrawSchedule(panel)
	local w = panel.width
	local h = panel.height

	local light = defaultlight
	local cabinlights = self:GetPackedBool(58)
	if not cabinlights then
		light = render.GetLightColor(self:LocalToWorld(Vector(430,0,26))) -- GetLightColor is pretty shit but it works
	end

	--Background
	surface.SetDrawColor(Color(255 * light.x, 253 * light.y, 208 * light.z))
	DrawRect(0,0,w,h)

	--Lines
	surface.SetDrawColor(Color(0,0,0))

	--Horisontal lines
	DrawRect(0,0,1,h)
	DrawRect(1 + col1w,0,1,h)
	DrawRect(1 + col1w + 1 + col2w,rowtall2+2,1,h-rowtall2-2)
	DrawRect(1 + col1w + 1 + col2w + 1 + col2w,rowtall2+2,1,h-rowtall2-2)
	DrawRect(1 + col1w + 1 + col2w + 1 + col2w + 1 + col2w,0,1,h)

	--Vertical lines
	DrawRect(0,0,w,1)
	DrawRect(1 + col1w,rowtall+1,w - col1w - 1,1)
	DrawRect(1 + col1w,rowtall2+2,w - col1w - 1,1)
	for i=(rowtall+1)*3,h,rowtall+1 do
		DrawRect(0,i,w,1)
	end

	-- HACK get schedule from train
	local N = self:GetNW2Int("_schedule_N")
	Schedule = {
		stations = {},
		total = math.floor(self:GetNW2Int("_schedule_duration")/5+0.5)*5,
		interval = self:GetNW2Int("_schedule_interval"),
		routenumber = self:GetNW2Int("_schedule_id"),
		pathnumber = self:GetNW2Int("_schedule_path"),
	}
	for i=1,N do
		Schedule.stations[i] = {
			self:GetNW2String("_schedule_"..i.."_5"),
			math.floor(self:GetNW2Int("_schedule_"..i.."_3")*60/5)*5
		}
	end

	--Text
	local t = Schedule

	--Top info
	DrawTextMachine("М №", 3, 3)
	DrawTextHand(t.routenumber, 42, -2, light)

	DrawTextMachine("П №", 3, rowtall*2 + 3)
	DrawTextHand(t.pathnumber, 42, rowtall*2 - 2, light)

	DrawTextMachineSmall("ВРЕМЯ", col1w + 5, 1, light)
	DrawTextMachineSmall("ХОДА", col1w + 5, 15, light)
	DrawTextHand(MinutesFromStamp(t.total), w - 50, 1, light)
	DrawTextHandSmall(SecondsFromStamp(t.total), w - 25, 5, light)

	DrawTextMachineSmall("ИНТ", col1w + 5, rowtall + 8)
	DrawTextHand(MinutesFromStamp(t.interval), w - 50, rowtall, light)
	DrawTextHandSmall(SecondsFromStamp(t.interval), w - 25, rowtall + 4, light)

	DrawTextMachineSmall("ЧАС", col1w + 4, rowtall*2	+ 8)
	DrawTextMachineSmall("МИН", col1w + col2w + 5, rowtall*2 + 8)
	DrawTextMachineSmall("СЕК", col1w + col2w*2 + 8, rowtall*2 + 8)

	--Schedule rows
	local lasthour = -1
	for i,v in pairs(t.stations) do
		local y = ((rowtall+1)*3+2) + (i-1)*(rowtall+1) -- Uhh..

		local st = FineStationName(v[1])
		surface.SetFont( "Schedule_Machine_Small" )
		local width = select(1, surface.GetTextSize(st))

		local szf = math.ceil(width/80)-1
		if szf > 0 then
			szf = math.ceil(#st/8)-1

			for i1 = 0,szf do
				DrawTextMachineSmall(st:Replace("'",""):sub(i1*8+1,8 + i1*8)..(szf ~= i1 and "-" or ""), 3, y + 6 -6 + 12/szf*i1) -- Stationname
			end
		else
			DrawTextMachineSmall(st, 3, y + 6) -- Stationname
		end

		local hours = HoursFromStamp(v[2])
		local minutes = MinutesFromStamp(v[2])
		local seconds = SecondsFromStamp(v[2])

		if hours ~= lasthour then -- Only draw hours if they've changed
			lasthour = hours

			DrawTextHand(hours, col1w + 3, y, light) -- Hours
		end

		DrawTextHand(minutes, col1w + col2w + 5, y, light) -- Minutes
		DrawTextHand(seconds, col1w + col2w + col2w + 5, y, light) -- Seconds
	end
end

--------------------------------------------------------------------------------
-- Default rendering function
--------------------------------------------------------------------------------
function ENT:Draw()

	-- Draw model
	self:DrawModel()
end


function ENT:DrawOnPanel(index,func,overr)
	if not overr and self.HiddenPanels[index] then return end
	local panel = self.ButtonMapMatrix[index] or self.ButtonMap[index]
	cam.Start3D2D(self:LocalToWorld(panel.pos),self:LocalToWorldAngles(panel.ang),panel.scale)
		func(panel)
	cam.End3D2D()
end


--------------------------------------------------------------------------------
-- Animation function
--------------------------------------------------------------------------------
function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
	local id = clientProp
	if self.Hidden[id] or self.HiddenAnim[id] then return 0 end
	if not self.Anims[id] then
		self.Anims[id] = {}
		self.Anims[id].val = value
		self.Anims[id].V = 0.0
		self.Anims[id].block = false
	end
	if self.Anims[id].Ignore then
		if CurTime()-self.Anims[id].Ignore < 0 then
			return
		else
			self.Anims[id].Ignore = nil
		end
	end
	if value ~= self.Anims[id].oldival then
		self.Anims[id].block = false
	end
	if self.Anims[id].block then
		if IsValid(self.ClientEnts[clientProp]) then
			self.ClientEnts[clientProp]:SetPoseParameter("position",min + (max-min)*self.Anims[id].val)
		end
		return min + (max-min)*self.Anims[id].val
	end
	--if self["_anim_old_"..id] == value then return self["_anim_old_"..id] end
	-- Generate sticky value
	if stickyness and damping then
		self.Anims[id].stuck = self.Anims[id].stuck or false
		self.Anims[id].P = self.Anims[id].P or value
		if (math.abs(self.Anims[id].P - value) < stickyness) and (self.Anims[id].stuck) then
			value = self.Anims[id].P
			self.Anims[id].stuck = false
		else
			self.Anims[id].P = value
		end
	end

	if damping == false then
		local dX = speed * self.DeltaTime
		if value > self.Anims[id].val then
			self.Anims[id].val = self.Anims[id].val + dX
		end
		if value < self.Anims[id].val then
			self.Anims[id].val = self.Anims[id].val - dX
		end
		if math.abs(value - self.Anims[id].val) < dX then
			self.Anims[id].val = value
		end
	else
		-- Prepare speed limiting
		local delta = math.abs(value - self.Anims[id].val)
		local max_speed = 1.5*delta / self.DeltaTime
		local max_accel = 0.5 / self.DeltaTime

		-- Simulate
		local dX2dT = (speed or 128)*(value - self.Anims[id].val) - self.Anims[id].V * (damping or 8.0)
		if dX2dT >  max_accel then dX2dT =  max_accel end
		if dX2dT < -max_accel then dX2dT = -max_accel end

		self.Anims[id].V = self.Anims[id].V + dX2dT * self.DeltaTime
		if self.Anims[id].V >  max_speed then self.Anims[id].V =  max_speed end
		if self.Anims[id].V < -max_speed then self.Anims[id].V = -max_speed end

		self.Anims[id].val = math.max(0,math.min(1,self.Anims[id].val + self.Anims[id].V * self.DeltaTime))

		-- Check if value got stuck
		if (math.abs(dX2dT) < 0.001) and stickyness and (self.DeltaTime > 0) then
			self.Anims[id].stuck = true
		end
	end

	if IsValid(self.ClientEnts[clientProp]) then
		self.ClientEnts[clientProp]:SetPoseParameter("position",min + (max-min)*self.Anims[id].val)
	end
	if self.Anims[id].val == self.Anims[id].oldval and value == self.Anims[id].oldival and self.Anims[id].timer and CurTime() - self.Anims[id].timer > 0 then
		self.Anims[id].block = true
	end
	if self.Anims[id].val == self.Anims[id].oldval and value == self.Anims[id].oldival and not self.Anims[id].timer then
		self.Anims[id].timer = CurTime() + 0.1
	end
	if (self.Anims[id].val ~= self.Anims[id].oldval or value ~= self.Anims[id].oldival) and self.Anims[id].timer then
		self.Anims[id].timer = nil
	end
	--print(id,min + (max-min)*self.Anims[id].val,value, min + (max-min)*value)
	--self["_anim_old_"..id] = min + (max-min)*self.Anims[id].val
	self.Anims[id].oldval = self.Anims[id].val
	self.Anims[id].oldival = value
	return min + (max-min)*self.Anims[id].val
end
function ENT:AnimateFrom(clientProp,from)
	if IsValid(self.ClientEnts[clientProp]) then
		self.ClientEnts[clientProp]:SetPoseParameter("position",self.Anims[from].val)
	end
	return self.Anims[from].val
end

function ENT:ShowHide(clientProp, value, over)
	--if IsValid(self.ClientEnts[clientProp]) then
		if value == true and (self.Hidden[clientProp] or over) then
			if not IsValid(self.ClientEnts[clientProp]) then
				self:SpawnCSEnt(clientProp)
				self.UpdateRender = true
			end
			self.Hidden[clientProp] = false
			--self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_NORMAL)
			--self.ClientEnts[clientProp]:SetColor(Color(255,255,255,255))
			--self.Hidden[clientProp] = false
		elseif value ~= true and (not self.Hidden[clientProp] or over) then
			if IsValid(self.ClientEnts[clientProp]) then
				self.ClientEnts[clientProp]:Remove()
				self.UpdateRender = true
			end
			self.Hidden[clientProp] = true
			--self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_NONE)
			--self.ClientEnts[clientProp]:SetColor(Color(0,0,0,0))
			--self.Hidden[clientProp] = true
		end
		--self.HiddenQuele[clientProp] = nil
	--else
	--end
end

function ENT:HideButton(clientProp, value)
	self.HiddenButton[clientProp] = value
end
function ENT:ShowHideSmooth(clientProp, value)
	if not self.Anims[clientProp] then
		self.Anims[clientProp] = {}
		self.Anims[clientProp].val = value
		self.Anims[clientProp].V = 0.0
		self.Anims[clientProp].block = false
		if IsValid(self.ClientEnts[clientProp]) then self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_TRANSALPHA) end
	end
	if self.Anims[clientProp].alpha == value then return end
	if value > 0 and not IsValid(self.ClientEnts[clientProp]) then
		self:ShowHide(clientProp,true)
	end
	if value == 0 and IsValid(self.ClientEnts[clientProp]) then
		self:ShowHide(clientProp,false)
	end
	if IsValid(self.ClientEnts[clientProp]) then
		local v = self.ClientPropsOv and self.ClientPropsOv[clientProp] or self.ClientProps[clientProp]
		--if v.color then
		--else
		--	self.ClientEnts[clientProp]:SetColor(Color(255,255,255,value*255))
		--end
		self.ClientEnts[clientProp]:SetRenderMode(RENDERMODE_TRANSALPHA)
		self.ClientEnts[clientProp]:SetColor(ColorAlpha(v.color or color_white,value*255))
		--self.HiddenQuele[clientProp] = nil
	--else
	end
	--self.Anims[clientProp].val = value
	self.HiddenAnim[clientProp] = value == 0
	self.Anims[clientProp].alpha = value
end
function ENT:ShowHideSmoothFrom(clientProp,from)
	self:ShowHideSmooth(clientProp,self.Anims[from].alpha or 0)
end
local digit_bitmap = {
  [1] = { 0,0,1,0,0,1,0 },
  [2] = { 1,0,1,1,1,0,1 },
  [3] = { 1,0,1,1,0,1,1 },
  [4] = { 0,1,1,1,0,1,0 },
  [5] = { 1,1,0,1,0,1,1 },
  [6] = { 1,1,0,1,1,1,1 },
  [7] = { 1,0,1,0,0,1,0 },
  [8] = { 1,1,1,1,1,1,1 },
  [9] = { 1,1,1,1,0,1,1 },
  [0] = { 1,1,1,0,1,1,1 },
}

local segment_poly = {
	[1] = {
		{ x = 0,    y = 0 },
		{ x = 100,  y = 0 },
		{ x =  80,  y = 20 },
		{ x =  20,  y = 20 },
	},
	[2] = {
		{ x =  20,  y = 0 },
		{ x =  80,  y = 0 },
		{ x = 100,  y = 20 },
		{ x =   0,  y = 20 },
	},
	[3] = {
		{ x =  0,  y = 0 },
		{ x = 20,  y = 20 },
		{ x = 20,  y = 80 },
		{ x =  0,  y = 100 },
	},
	[4] = {
		{ x =  0,  y = 20 },
		{ x = 20,  y = 0 },
		{ x = 20,  y = 100 },
		{ x =  0,  y = 80 },
	},
	[5] = {
		{ x = 0,  y = 12 },
		{ x = 20,  y = 0 },
		{ x = 80,  y = 0 },
		{ x = 100,  y = 12 },
		{ x = 80,  y = 24 },
		{ x = 20,  y = 24 },
	},
}

local polys = {}
function ENT:DrawSegment(i,x,y,scale_x,scale_y)
	if not polys[i] then polys[i] = {} end
	if not polys[i][k] then
		for k,v in pairs(segment_poly[i]) do
			polys[i][k] = {
				x = (v.x*scale_x) + x,
				y = (v.y*scale_y) + y,
			}
		end
	end

	surface.SetDrawColor(Color(100,255,0,255))
	draw.NoTexture()
	surface.DrawPoly(polys[i])
end

function ENT:DrawDigit(cx,cy,digit,scalex,scaley,thickness)
	scalex = scalex or 1
	scaley = scaley or scalex
	thickness = thickness or 1
	local bitmap = digit_bitmap[digit]
	if not bitmap then return end

	local sx = 0.9*scalex*thickness
	local sy = 0.9*scaley*thickness
	local dx = scalex
	local dy = scaley

	if bitmap[1] == 1 then self:DrawSegment(1,cx+5*dx,cy,			sx,sy)	end
	if bitmap[2] == 1 then self:DrawSegment(3,cx,cy+10*dy,			sx,sy)	end
	if bitmap[3] == 1 then self:DrawSegment(4,cx+80*dx,cy+10*dy,	sx,sy)	end
	if bitmap[4] == 1 then self:DrawSegment(5,cx+5*dx,cy+95*dy,		sx,sy)	end
	if bitmap[5] == 1 then self:DrawSegment(3,cx,cy+110*dy,			sx,sy)	end
	if bitmap[6] == 1 then self:DrawSegment(4,cx+80*dx,cy+110*dy,	sx,sy)	end
	if bitmap[7] == 1 then self:DrawSegment(2,cx+5*dx,cy+190*dy,	sx,sy)	end
end



--------------------------------------------------------------------------------
-- Get train acceleration at given position in train
--------------------------------------------------------------------------------
function ENT:GetTrainAccelerationAtPos(pos)
	local localAcceleration = self:GetTrainAcceleration()
	local angularVelocity = self:GetTrainAngularVelocity()

	return localAcceleration - angularVelocity:Cross(angularVelocity:Cross(pos*0.01905))
end





--------------------------------------------------------------------------------
-- Look into mirrors hook
--------------------------------------------------------------------------------
hook.Add("CalcView", "Metrostroi_TrainView", function(ply,pos,ang,fov,znear,zfar)
	local seat = ply:GetVehicle()
	if (not seat) or (not seat:IsValid()) then return end
	local train = seat:GetNW2Entity("TrainEntity")
	if (not train) or (not train:IsValid()) then return end

	--local hack = string.find(train:GetClass(),"81")
	--local dy = 0
	--if hack then dy = 3 end

	--[[-- Get acceleration in the train
	local headPos = train:WorldToLocal(pos)
	local acceleration = train:GetTrainAccelerationAtPos(headPos)
	train.Acceleration = train.Acceleration or Vector(0,0,0)
	train.Acceleration = train.Acceleration + 0.5*(acceleration - train.Acceleration)*train.DeltaTime
	if train.Acceleration:Length() > 100 then train.Acceleration = Vector(0,0,0) end

	-- Calculate direction
	local direction = train.Acceleration:GetNormalized()
	-- Calculate visual offset
	local a = train.Acceleration:Length()
	local factor = a * math.exp(-0.05*a)
	local offset = 4 * direction * factor

	print(train.Acceleration)
	-- Apply offset
	return {
		origin = train:LocalToWorld(headPos + 0.1*offset),
		angles = ang + Angle(offset.x,0,0),
	}]]--


	if seat:GetThirdPersonMode() then
		local trainAng = ang - train:GetAngles()
		if trainAng.y >  180 then trainAng.y = trainAng.y - 360 end
		if trainAng.y < -180 then trainAng.y = trainAng.y + 360 end
		if trainAng.y > 0 then
			local target_ang = (train:GetAngles() + Angle(2,0,0))
			target_ang:RotateAroundAxis(train:GetAngles():Up(),180)
			return {
				origin = train:LocalToWorld(Vector(475,80,30)),
				angles = target_ang,
				fov = 30,
				znear = znear,
				zfar = zfar
			}
		else
			local target_ang = (train:GetAngles() + Angle(2,0,0))
			target_ang:RotateAroundAxis(train:GetAngles():Up(),180)
			return {
				origin = train:LocalToWorld(Vector(475,-80,30)),
				angles = target_ang,
				fov = 20,
				znear = znear,
				zfar = zfar
			}
		end
	else
		--train.HeadAcceleration = GetConVarNumber("metrostroi_disablecamaccel") == 0 and math.Clamp((train.HeadAcceleration or 0)*0.95 + (train:GetNW2Float("Accel"))*1.1, -10, 10) or 0
--function ENT:Animate(clientProp, value, min, max, speed, damping, stickyness)
	--print(train:GetNW2Float("Accel")*1.1,train:Animate("accel",train:GetNW2Float("Accel")*1.1+5,-0,10, 				nil, nil,  64,2,4))
		train.HeadAcceleration = GetConVarNumber("metrostroi_disablecamaccel") == 0 and (train:Animate("accel",(train:GetNW2Float("Accel")+1)/2,-1,1, 4, 1)*20 - 5) or 0
		--local headPos = train:WorldToLocal(pos)
		return {
			origin = train:LocalToWorld(train:WorldToLocal(pos)+Vector(math.Round((GetConVarNumber("metrostroi_disablecamaccel") == 0 and (train:Animate("accel",(train:GetNW2Float("Accel")+1)/2,-1,1, 4, 1)*20 - 5) or 0),2),0,0)),--train:LocalToWorld(Vector(math.Round(train.HeadAcceleration,2),0,0)) ,
			angles = angles,
			fov = fov/90*75,
			znear = znear,
			zfar = zfar
		}
	end
		return
end)




--------------------------------------------------------------------------------
-- Buttons/panel clicking
--------------------------------------------------------------------------------
--Thanks old gmod wiki!
--[[
Converts from world coordinates to Draw3D2D screen coordinates.
vWorldPos is a vector in the world nearby a Draw3D2D screen.
vPos is the position you gave Start3D2D. The screen is drawn from this point in the world.
scale is a number you also gave to Start3D2D.
aRot is the angles you gave Start3D2D. The screen is drawn rotated according to these angles.
]]--

local function WorldToScreen(vWorldPos, vPos, vScale, aRot)
  vWorldPos = vWorldPos - vPos
  vWorldPos:Rotate(Angle(0, -aRot.y, 0))
  vWorldPos:Rotate(Angle(-aRot.p, 0, 0))
  vWorldPos:Rotate(Angle(0, 0, -aRot.r))

  return vWorldPos.x / vScale, (-vWorldPos.y) / vScale
end

-- Calculates line-plane intersect location
local function LinePlaneIntersect(PlanePos,PlaneNormal,LinePos,LineDir)
	local dot = LineDir:Dot(PlaneNormal)
	local fac = LinePos-PlanePos
	local dis = -PlaneNormal:Dot(fac) / dot
	return LineDir * dis + LinePos
end

local function findAimButton(ply,press)
	local train = isValidTrainDriver(ply)
	if not IsValid(train) and LocalPlayer():GetActiveWeapon():GetClass() == "train_kv_wrench" then
		local trace = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 100,
			filter = function( ent ) if ent:GetClass():find("subway") or ent:GetClass():find("button") then return true end end
		})
		train = trace.Entity

	end
	if IsValid(train) and train.ButtonMap ~= nil then
		local foundbuttons = {}
		for kp,panel in pairs(train.ButtonMap) do
			if train.HiddenPanels[kp] then continue end
			--If player is looking at this panel
			if panel.aimX and panel.aimY and panel.sensor and panel.aimX > 0 and panel.aimX < panel.width and panel.aimY > 0 and panel.aimY < panel.height then return false,panel.aimX,panel.aimY,panel.system end
			if panel.aimedAt and panel.buttons then
				if GetConVarNumber("metrostroi_drawdebug") > 0 and press then print(kp,panel.aimX,panel.aimY) end
				--Loop trough every button on it
				for _,button in pairs(panel.buttons) do
					if (train.Hidden[button.PropName] or train.HiddenButton[button.PropName]) and (not train.ClientProps[button.PropName] or not train.ClientProps[button.PropName].config or not train.ClientProps[button.PropName].config.staylabel) then continue end
					if (train.Hidden[button.ID] or train.HiddenButton[button.ID])  and (not train.ClientProps[button.ID] or not train.ClientProps[button.ID].config or not train.ClientProps[button.ID].config.staylabel) then  continue end
					if button.w and button.h then
						if panel.aimX >= button.x and panel.aimX <= (button.x + button.w) and
								panel.aimY >= button.y and panel.aimY <= (button.y + button.h) then
							table.insert(foundbuttons,{button,0})
						end
					else
						--If the aim location is withing button radis
						local dist = math.Distance(button.x,button.y,panel.aimX,panel.aimY)
						if dist < (button.radius or 10) then
							table.insert(foundbuttons,{button,dist})
						end
					end

				end
			end
		end

		if #foundbuttons > 0 then
			table.SortByMember(foundbuttons,2,true)
			return foundbuttons[1][1]
		else
			return false
		end
	elseif train.IsTouchable then
		return train
	end
end

hook.Remove("Think","metrostroi-DSP-check",function()
  local plypos = LocalPlayer():GetPos()
  local res = util.TraceLine{
    start = plypos,
    endpos = plypos+Vector(0,0,150),
    ignoreworld = true,
    filter = {LocalPlayer()},
  }

  if IsValid(res.Entity) and res.Entity.Base == "gmod_subway_base" then
     res = util.TraceLine{
      start = plypos,
      endpos = plypos-Vector(0,0,150),
      ignoreworld = true,
      filter = {LocalPlayer()},
    }
    if IsValid(res.Entity) and res.Entity.Base == "gmod_subway_base" then
      LocalPlayer():SetDSP(0,true)
    else
    end
  else
  end
end)
-- Checks what button/panel is being looked at and check for custom crosshair
hook.Add("Think","metrostroi-cabin-panel",function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	toolTipText = nil
	drawCrosshair = false
	canDrawCrosshair = false

	local train = isValidTrainDriver(ply)
	local outside = false
	if not IsValid(train) and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "train_kv_wrench" then
		local trace = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 100,
			filter = function( ent ) if ent:GetClass():find("subway") then  return true end end
		})
		train = trace.Entity
		--print(train)
		outside = true
	end
	if(IsValid(train) and train.ButtonMap ~= nil) then
		canDrawCrosshair = true

		local plyaimvec
		if outside then
			plyaimvec = ply:GetAimVector()
		else
			plyaimvec =gui.ScreenToVector(ScrW()/2, ScrH()/2) -- ply:GetAimVector() is unreliable when in seats
		end

		-- Loop trough every panel
		for k2,panel in pairs(train.ButtonMap) do
			if train.HiddenPanels[k2] then continue end
			local wang = train:LocalToWorldAngles(panel.ang)

			if plyaimvec:Dot(wang:Up()) < 0 then
				local wpos = train:LocalToWorld(panel.pos - Vector(math.Round((not outside and train.HeadAcceleration or 0),2),0,0))
				local isectPos = LinePlaneIntersect(wpos,wang:Up(),ply:EyePos(),plyaimvec)
				local localx,localy = WorldToScreen(isectPos,wpos,panel.scale,wang)

				panel.aimX = localx
				panel.aimY = localy
				if localx > 0 and localx < panel.width and localy > 0 and localy < panel.height then
					drawCrosshair = true
					panel.aimedAt = true
				else
					panel.aimedAt = false
				end
			else
				panel.aimedAt = false
			end
		end

		-- Tooltips
		local ttdelay = GetConVarNumber("metrostroi_tooltip_delay")
		if ttdelay and ttdelay >= 0 then
			local button = findAimButton(ply)
			--print(train.ClientProps[button.ID].button)
			if button and
				((train.Hidden[button.ID] or train.Hidden[button.PropName]) and (not train.ClientProps[button.ID].config or not train.ClientProps[button.ID].config.staylabel) or
				(train.HiddenButton[button.ID] or train.HiddenButton[button.PropName]) and (not train.ClientProps[button.PropName].config or not train.ClientProps[button.PropName].config.staylabel)) then
				return
			end
			if button ~= lastAimButton then
				lastAimButtonChange = CurTime()
				lastAimButton = button
			end


			if button then
				if ttdelay == 0 or CurTime() - lastAimButtonChange > ttdelay then
					toolTipText = findAimButton(ply).tooltip
				end
			end
		end
	end
end)


-- Takes button table, sends current status
local function sendButtonMessage(button,outside)
	if not button.ID then return end
	net.Start("metrostroi-cabin-button")
	net.WriteString(button.ID:find(":") and string.Explode(":",button.ID)[2] or button.ID)
	net.WriteBit(button.state)
	net.WriteBool(outside)
	net.SendToServer()
	--RunConsoleCommand("metrostroi_button_press",button.ID..(button.state and 1 or 0))
end
-- Takes button table, sends current status
local function sendPanelTouch(panel,x,y,outside,state)
	net.Start("metrostroi-panel-touch")
	net.WriteString(panel or "")
	net.WriteInt(x,11)
	net.WriteInt(y,11)
	net.WriteBool(outside)
	net.WriteBool(state)
	net.SendToServer()
	--RunConsoleCommand("metrostroi_button_press",button.ID..(button.state and 1 or 0))
end

-- Goes over a train's buttons and clears them, sending a message if needed
function ENT:ClearButtons()
	if self.ButtonMap == nil then return end
	for _,panel in pairs(self.ButtonMap) do
		if panel.buttons then
			for _,button in pairs(panel.buttons) do
				if button.state == true then
					button.state = false
					sendButtonMessage(button)
				end
			end
		end
	end
end

function ENT:HidePanel(kp,hide)
	if hide and not self.HiddenPanels[kp] then
		if self.ButtonMap[kp].props then
			for _,v in pairs(self.ButtonMap[kp].props) do
				self:ShowHide(v,false,true)
				self.Hidden[v] = true
			end
			self.HiddenPanels[kp] = true
		end
	end
	if not hide and self.HiddenPanels[kp] then
		if self.ButtonMap[kp].props then
			for _,v in pairs(self.ButtonMap[kp].props) do
				self:ShowHide(v,true,true)
				self.Hidden[v] = false
			end
			self.HiddenPanels[kp] = nil
		end
	end
end
-- Args are player, IN_ enum and bool for press/release
local function handleKeyEvent(ply,key,pressed)
	if key ~= IN_ATTACK and key ~= 2048 and key ~= 524288 then return end
	if key == 524288 and pressed then return end
	if not game.SinglePlayer() and not IsFirstTimePredicted() then return end
	if not IsValid(ply) then return end
	local train = isValidTrainDriver(ply)
	local outside = false
	if not IsValid(train) and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "train_kv_wrench" then
		local trace = util.TraceLine({
			start = LocalPlayer():EyePos(),
			endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 100,
			filter = function( ent ) if ent:GetClass():find("subway") then return true end end
		})
		train = trace.Entity

		outside = true
	end
	if not IsValid(train) then return end
	if train.ButtonMap == nil then return end
	if key == 524288 and not pressed then train:ClearButtons() end
	if pressed then
		local button,x,y,system = findAimButton(ply,true)
		if button and not button.state and not button.IsTouchable then
			button.state = true
			sendButtonMessage(button,outside)
			lastButton = button

			if train.OnButtonPressed then
				if button.ID and button.ID:find(":") then
					train:OnButtonPressed(string.Explode(":",button.ID)[2])
				else
					train:OnButtonPressed(button.ID)
				end
			end
		elseif button and button.IsTouchable then
			button:Pressed(true)
			lastButton = button
		elseif x and y then
			sendPanelTouch(system,x,y,outside,true)
			lastTouch = {system,x,y}
		end
	else
		-- Reset the last button pressed
		if lastButton ~= nil then
			if lastButton.state == true then
				lastButton.state = false
				sendButtonMessage(lastButton,outside)
			end
			if lastButton.IsTouchable then lastButton:Pressed(false) end
			if train.OnButtonReleased and button then
				if button.ID:find(":") then
					train:OnButtonReleased(string.Explode(":",button.ID)[2])
				else
					train:OnButtonReleased(button.ID)
				end
			end
		end
		if lastTouch ~= nil then
			sendPanelTouch(lastTouch[1],lastTouch[2],lastTouch[3],outside,false)
			lastTouch = nil
		end
	end
end

-- Hook for clearing the buttons when player exits
net.Receive("metrostroi-cabin-reset",function()
	local ent = net.ReadEntity()
	if IsValid(ent) and ent.ClearButtons ~= nil then
		ent:ClearButtons()
	end
end)

hook.Add("KeyPress", "metrostroi-cabin-buttons", function(ply,key) handleKeyEvent(ply, key,true) end)
hook.Add("KeyRelease", "metrostroi-cabin-buttons", function(ply,key) handleKeyEvent(ply, key,false) end)

hook.Add( "HUDPaint", "metrostroi-draw-crosshair-tooltip", function()
	--if not drawCrosshair then return end
	if IsValid(LocalPlayer()) then
		local scrX,scrY = surface.ScreenWidth(),surface.ScreenHeight()

		if canDrawCrosshair then
			surface.DrawCircle(scrX/2,scrY/2,4.1,drawCrosshair and Color(255,0,0) or Color(255,255,150))
		end

		if toolTipText ~= nil then
			local text1 = string.sub(toolTipText,1,string.find(toolTipText,"\n"))
			local text2 = string.sub(toolTipText,string.find(toolTipText,"\n") or 1e9)
			surface.SetFont("BudgetLabel")
			local w1 = surface.GetTextSize(text1)
			local w2 = surface.GetTextSize(text2)

			surface.SetTextColor(255,255,255)
			surface.SetTextPos((scrX-w1)/2,scrY/2+10)
			surface.DrawText(text1)
			surface.SetTextPos((scrX-w2)/2,scrY/2+30)
			surface.DrawText(text2)
		end
	end
end)

Metrostroi.RouteTextures = {
	p = {
		["0"] = CreateMaterial("models/metrostroi_train/signs/route_p/0","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/0"}),
		["1"] = CreateMaterial("models/metrostroi_train/signs/route_p/1","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/1"}),
		["2"] = CreateMaterial("models/metrostroi_train/signs/route_p/2","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/2"}),
		["3"] = CreateMaterial("models/metrostroi_train/signs/route_p/3","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/3"}),
		["4"] = CreateMaterial("models/metrostroi_train/signs/route_p/4","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/4"}),
		["5"] = CreateMaterial("models/metrostroi_train/signs/route_p/5","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/5"}),
		["6"] = CreateMaterial("models/metrostroi_train/signs/route_p/6","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/6"}),
		["7"] = CreateMaterial("models/metrostroi_train/signs/route_p/7","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/7"}),
		["8"] = CreateMaterial("models/metrostroi_train/signs/route_p/8","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/8"}),
		["9"] = CreateMaterial("models/metrostroi_train/signs/route_p/9","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route_p/9"}),
	},
	m = {
		["0"] = CreateMaterial("models/metrostroi_train/signs/route/0","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/0"}),
		["1"] = CreateMaterial("models/metrostroi_train/signs/route/1","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/1"}),
		["2"] = CreateMaterial("models/metrostroi_train/signs/route/2","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/2"}),
		["3"] = CreateMaterial("models/metrostroi_train/signs/route/3","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/3"}),
		["4"] = CreateMaterial("models/metrostroi_train/signs/route/4","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/4"}),
		["5"] = CreateMaterial("models/metrostroi_train/signs/route/5","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/5"}),
		["6"] = CreateMaterial("models/metrostroi_train/signs/route/6","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/6"}),
		["7"] = CreateMaterial("models/metrostroi_train/signs/route/7","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/7"}),
		["8"] = CreateMaterial("models/metrostroi_train/signs/route/8","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/8"}),
		["9"] = CreateMaterial("models/metrostroi_train/signs/route/9","UnlitGeneric",{["$basetexture"] = "models/metrostroi_train/signs/route/9"}),
	},
}

net.Receive("metrostroi_train_limit",function()
	GAMEMODE:AddNotify( "Wagons limit!",NOTIFY_ERROR, 10 )
	surface.PlaySound( "buttons/button10.wav" )
end)
