--------------------------------------------------------------------------------
-- ПА-М Поездная Аппаратура Модифицированная
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-M")
TRAIN_SYSTEM.DontAccelerateSimulation = true
function TRAIN_SYSTEM:Initialize()
	self.Train:LoadSystem("BRight","Relay","Switch",{button = true})
	self.Train:LoadSystem("BEsc","Relay","Switch",{button = true})
	self.Train:LoadSystem("BF","Relay","Switch",{button = true})
	self.Train:LoadSystem("BM","Relay","Switch",{button = true})
	self.Train:LoadSystem("BP","Relay","Switch",{button = true})

	self.TriggerNames = {
		"B7",
		"B8",
		"B9",
		"BLeft",
		"BRight",
		"B4",
		"B5",
		"B6",
		"BUp",
		"B1",
		"B2",
		"B3",
		"BDown",
		"B0",
		"BMinus",
		"BPlus",
		"BEnter",
		"BEsc",
		"BF",
		"BM",
		"BP",
	}
	self.Triggers = {}
	self.Pass = "777"
	self.EnteredPass = ""
	self.Timer = CurTime()
	self.Line = 1
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.FirstStation = ""
	self.LastStation = ""
	self.AutoTimer = false
	self.Corrections = {
		[110] =  1.50,
		[111] = -0.10,
		[113] = -0.05,
		--[114] = -0.05,
		[114] =  -0.25,
		[117] = -0.15,
		[118] =  1.40,
		[121] = -0.10,
		[122] = -0.10,
		[123] =  3.00,
		[322] =  3.00,
	}
	 self.MenuChoosed = 1
	 self.State75 = 1
end
function TRAIN_SYSTEM:ClientInitialize()
	self.STR1r = {}
	self.STR2r = {}
	self.STR1x = 1
	self.STR2x = 1
	self.Positions = {
		[-3] = "T2",
		[-2] = "T1a",
		[-1] = "T1",
		[0]  = "0",
		[1]  = "X1",
		[2]  = "X2",
		[3]  = "X3",
		--[4]  = "RR0",
		[5]  = "0ХТ",
		[6]  = "T2",
	}
	self.Types = {
		[0] = "ЭПВ",
		[1] = "КС",
		[2] = "ОД",
		[3] = "КВ",
		[4] = "УА",
		[5] = "ОС",
	}
	self.Questions = {
		[1] = "проверку наката",
		[5] = "движение с Vф=0",
		[6] = "изменение станции оборота",
		[7] = "режим фиксации станции",
	}
	self.AutoTimer = false
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	surface.CreateFont("Metrostroi_PAM30", {
	  font = "Arial",
	  size = 30,
	  weight = 700,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM50", {
	  font = "Arial",
	  size = 50,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM60", {
	  font = "Arial",
	  size = 60,
	  weight = 800,
	  blursize = 0,
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

	surface.CreateFont("Metrostroi_PAM25", {
	  font = "Arial",
	  size = 25,
	  weight = 400,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM1_25", {
	  font = "Arial",
	  size = 25,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM20", {
	  font = "Arial",
	  size = 20,
	  weight = 400,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM1_20", {
	  font = "Arial",
	  size = 20,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM15", {
	  font = "Arial",
	  size = 15,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM24", {
	  font = "Arial",
	  size = 24,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM22", {
	  font = "Arial",
	  size = 22,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAM28", {
	  font = "Arial",
	  size = 28,
	  weight = 800,
	  blursize = 0,
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
	
	surface.CreateFont("Metrostroi_PAM80", {
	  font = "Arial",
	  size = 80,
	  weight = 800,
	  blursize = 0,
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
	surface.CreateFont("Metrostroi_PAMBSOD", {
	  font = "Trebuchet",
	  size = 13,
	  weight = 800,
	  blursize = 0,
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
	
	function Metrostroi.DrawLine(x1,y1,x2,y2,col,sz)
		surface.SetDrawColor(col)
		if x1 == x2 then
			-- vertical line
			local wid =  (sz or 1) / 2
			surface.DrawRect(x1-wid, y1, wid*2, y2-y1)
		elseif y1 == y2 then
			-- horizontal line
			local wid =  (sz or 1) / 2
			surface.DrawRect(x1, y1-wid, x2-x1, wid*2)
		else
			-- other lines
			local x3 = (x1 + x2) / 2
			local y3 = (y1 + y2) / 2
			local wx = math.sqrt((x2-x1) ^ 2 + (y2-y1) ^ 2)
			local angle = math.deg(math.atan2(y1-y2, x2-x1))
			draw.NoTexture()
			surface.DrawTexturedRectRotated(x3, y3, wx, (sz or 1), angle)
		end
	end
	local function rect_ol(x,y,w,h,c)
		Metrostroi.DrawLine(x-1,y,x+w,y,c)
		Metrostroi.DrawLine(x+w,y,x+w,y+h,c)
		Metrostroi.DrawLine(x,y+h,x+w,y+h,c)
		Metrostroi.DrawLine(x,y,x,y+h,c)
	end
	 
	function Metrostroi.DrawRectOutline(x,y,w,h,col,sz)
		local wid = sz or 1
		if wid < 0 then
			for i=0, wid+1, -1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col)
			end
		elseif wid > 0 then
			for i=0, wid-1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col)
			end
		end
	end
	 
	function Metrostroi.DrawRectOL(x,y,w,h,col,sz,col1)
		local wid = sz or 1
		if wid < 0 then
			for i=0, wid+1, -1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col)
			end
		elseif wid > 0 then
			for i=0, wid-1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col)
			end
		end
		surface.SetDrawColor(col1)
		surface.DrawRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*1.5))
	end
	 
	function Metrostroi.DrawTextRect(x,y,w,h,col,mat)
		surface.SetDrawColor(col)
		surface.SetMaterial(mat) 
		surface.DrawTexturedRect(x,y,w,h)
	end
	 
	function Metrostroi.DrawTextRectOL(x,y,w,h,col,mat,sz,col1)
		local wid = sz or 1
		if wid < 0 then
			for i=0, wid+1, -1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col1)
			end
		elseif wid > 0 then
			for i=0, wid-1 do
				rect_ol(x+i, y+i, w-2*i, h-2*i, col1)
			end
		end
		surface.SetDrawColor(col)
		surface.DrawRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*1.5))
		surface.SetDrawColor(Color(col.r - 40,col.g - 40,col.b - 40))
		surface.SetMaterial(mat) 
		surface.DrawTexturedRect(x+math.max(0,sz-1),y+math.max(0,sz-1),w-math.max(0,(sz-0.5)*2),h-math.max(0,(sz-0.5)*2))
	end

	function TRAIN_SYSTEM:PAM(train)
		local Announcer = self.Train.Announcer
		surface.SetAlphaMultiplier(1)
		draw.NoTexture()

		if train:GetNWInt("PAM:State",-1) ~= -1 then
			surface.SetDrawColor(Color(225,225,225,2))
			surface.DrawTexturedRect(0,0,512,427)
		end
		if train:GetNWInt("PAM:State",-1) == -2 then
			if not self.BSODTimer then self.BSODTimer = CurTime() end
			surface.SetDrawColor(Color(0,0,172))
			surface.DrawTexturedRect(0,19,512,389)
			
            if  CurTime() - self.BSODTimer > 1/32*1 then draw.SimpleText("A problem has been detected and PA-M has been shut down to prevent damage","Metrostroi_PAMBSOD",5, 25,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 2/32*1 then draw.SimpleText("to your train.","Metrostroi_PAMBSOD",5, 35,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 4/32*1 then draw.SimpleText("The problem seems to be caused by the following file: CORE.SYS","Metrostroi_PAMBSOD",5, 55,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 6/32*1 then draw.SimpleText("VISITED_BY_KEK_POLICE_ERROR","Metrostroi_PAMBSOD",5, 75,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 7/32*1 then draw.SimpleText("If this is the first time you've seen this Stop error screen","Metrostroi_PAMBSOD",5, 95,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 8/32*1 then draw.SimpleText("restart your computer. If this screen appears again, follow","Metrostroi_PAMBSOD",5, 105,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 9/32*1 then draw.SimpleText("these steps:","Metrostroi_PAMBSOD",5, 115,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 11/32*1 then draw.SimpleText("Check to make sure any new hardware or software is properly installed.","Metrostroi_PAMBSOD",5, 135,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 12/32*1 then draw.SimpleText("If this is a new installation, ask your hardware or software manufacturer","Metrostroi_PAMBSOD",5, 145,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 13/32*1 then draw.SimpleText("for any Windows updates you might need.","Metrostroi_PAMBSOD",5, 155,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 15/32*1 then draw.SimpleText("If problems continue, disable or remove any newly installed hardware","Metrostroi_PAMBSOD",5, 175,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 16/32*1 then draw.SimpleText("or software. Disable BIOS memory options such as caching or shadowing.","Metrostroi_PAMBSOD",5, 185,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 17/32*1 then draw.SimpleText("If you need to use Safe Mode to remove or disable components, restart","Metrostroi_PAMBSOD",5, 195,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 18/32*1 then draw.SimpleText("your computer, press F8 to select Advanced Startup Options, and then","Metrostroi_PAMBSOD",5, 205,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 19/32*1 then draw.SimpleText("select Safe Mode.","Metrostroi_PAMBSOD",5, 215,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 21/32*1 then draw.SimpleText("Technical information:","Metrostroi_PAMBSOD",5, 235,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 22/32*1 then draw.SimpleText("*** STOP: 0x0000000A (0x0000000C, 0x00000002, 0x00000000, 3311BACE)","Metrostroi_PAMBSOD",5, 255,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            
            if  CurTime() - self.BSODTimer > 25/32*1 then draw.SimpleText("*** autodrive.sys - Address 3311BACE base at 5721DAC7, Date Stamp 533acb25","Metrostroi_PAMBSOD",5, 285,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            
            if  CurTime() - self.BSODTimer > 27/32*1 then draw.SimpleText("Beginning dump of physical memory.","Metrostroi_PAMBSOD",5, 305,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 28/32*1 then draw.SimpleText("Physical memory dump complete.","Metrostroi_PAMBSOD",5, 315,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 29/32*1 then draw.SimpleText("Contact your system administrator or technical support group for further","Metrostroi_PAMBSOD",5, 325,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end
            if  CurTime() - self.BSODTimer > 30/32*1 then draw.SimpleText("assistance.","Metrostroi_PAMBSOD",5, 335,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER) end

		else
			if self.BSODTimer then self.BSODTimer = nil end
		end
		if train:GetNWInt("PAM:State",-1) == 0 then
			if CurTime()%0.4 > 0.2 then draw.SimpleText("_","Metrostroi_PAM30",5, 0,Color(150,150,150,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM) end
		end
		if train:GetNWInt("PAM:State",-1) == 2 then
			surface.SetDrawColor(Color(0,0,255))
			surface.SetMaterial( Material("vgui/gradient_down"))
			surface.DrawTexturedRect(0,0,512,427)
			
			surface.SetDrawColor(Color(255,255,255))
			surface.SetMaterial( Material("vgui/gradient-d"))
			surface.DrawTexturedRect(0,200,512,50)
			surface.SetMaterial( Material("vgui/gradient-u"))
			surface.DrawTexturedRect(0,250,512,50)
			
			surface.SetDrawColor(Color(0,255,0))
			surface.SetMaterial( Material("vgui/gradient-d"))
			surface.DrawTexturedRect(0,200,512,227)
			
			draw.SimpleText("НИИ Фабрики SENT","Metrostroi_PAM30",256, 100,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Терминал машиниста (ПА-М)","Metrostroi_PAM30",256, 130,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
			
		if train:GetNWInt("PAM:State",-1) == 3 then
			
			draw.SimpleText("НАЧАЛЬНЫЙ ТЕСТ ЗАКОНЧЕН","Metrostroi_PAM30",256, 30,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			Metrostroi.DrawRectOutline(10, 80, 492, 210,Color(110,172,95),3)

			surface.SetDrawColor(Color(2,2,2))
			surface.DrawRect(17,70,180,20)
			draw.SimpleText("РЕЗУЛЬТАТЫ","Metrostroi_PAM30",22, 80,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			draw.SimpleText("Начальный тест","Metrostroi_PAM30",60, 125,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("норма","Metrostroi_PAM30",480, 125,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Начальная установка","Metrostroi_PAM30",60, 165,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("норма","Metrostroi_PAM30",480, 165,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Версия ПО БЦВМ     =     0.6","Metrostroi_PAM30",80, 245,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			if not train:GetNWBool("PAM:RR",false) then
				draw.SimpleText("Вставьте реверсивную рукоятку","Metrostroi_PAM30",10, 320,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Для ввода кода доступа","Metrostroi_PAM30",10, 320,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOutline(100, 345, 75, 30,Color(110,172,95),3 ,Color(230,230,230))
				draw.SimpleText("нажми Enter","Metrostroi_PAM30",10, 360,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
		end
		if train:GetNWInt("PAM:State",-1) == 4 then
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 80, 492, 170,Color(110,172,95),3)
			if train:GetNWInt("PAM:Pass",0) == -1 then
				draw.SimpleText("ОШИБКА ДОСТУПА","Metrostroi_PAM30",256, 160,Color(200,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Введи код доступа в систему","Metrostroi_PAM30",256, 130,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				if train:GetNWInt("PAM:Pass",0) > 0 then
					Metrostroi.DrawRectOutline(241 - train:GetNWInt("PAM:Pass",0)*13, 165, 30 + train:GetNWInt("PAM:Pass",0)*26, 40,Color(110,172,95),3,Color(230,230,230))
					draw.SimpleText(string.rep("*",train:GetNWInt("PAM:Pass",0)),"Metrostroi_PAM80",256, 200,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
			
			Metrostroi.DrawRectOutline(190, 330, 135, 40,Color(110,172,95),3,Color(230,230,230) )
			draw.SimpleText("Для ввода нажми","Metrostroi_PAM30",256, 300,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("ENTER","Metrostroi_PAM30",256, 350,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
		end
		if train:GetNWInt("PAM:State",-1) == 5 then
			draw.SimpleText("Депо. Начальное меню.","Metrostroi_PAM30",256, 30,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 80, 492, 333,Color(110,172,95),3)
			
			Metrostroi.DrawRectOL(40, 166 + (not train:GetNWBool("PAM:Restart") and 40 or 0), 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State5",1) == 1 and Color(230,230,230) or Color(180,180,180))

			draw.SimpleText("Выход на линию","Metrostroi_PAM30",60, 186 + (not train:GetNWBool("PAM:Restart") and 40 or 0),Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:Restart") then
				Metrostroi.DrawRectOL(40, 216, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State5",1) == 2 and Color(230,230,230) or Color(180,180,180))
				draw.SimpleText("Перезапуск","Metrostroi_PAM30",60, 236,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
		end
		if train:GetNWInt("PAM:State",-1) == 6 then
			local Line = self.Train:GetNWInt("PAM:Line",0)
			local FirstStation = self.Train:GetNWInt("PAM:FirstStation",-1)
			local LastStation = self.Train:GetNWInt("PAM:LastStation",-1)
			local RouteNumber = self.Train:GetNWInt("PAM:RouteNumber",-1)
			local tbl = Metrostroi.WorkingStations
			print(tbl[Announcer.AnnMap],Announcer.AnnMap)
			draw.SimpleText("Ввод исходных данных","Metrostroi_PAM30",256, 30,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 50, 492, 367,Color(110,172,95),3)
			
			Metrostroi.DrawRectOL(40, 60, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State6",1) == 1 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Линия","Metrostroi_PAM30",45, 80,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Line,"Metrostroi_PAM30",457, 80,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)

			Metrostroi.DrawRectOL(40, 110, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State6",1) == 2 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Нач. ст.","Metrostroi_PAM30",45, 130,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap] and tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][FirstStation] and Metrostroi.AnnouncerData[FirstStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[FirstStation][1]:sub(1,10).." "..FirstStation,"Metrostroi_PAM30",457, 130,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif FirstStation ~= -1 then
				draw.SimpleText(FirstStation,"Metrostroi_PAM30",457, 130,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end

			Metrostroi.DrawRectOL(40, 160, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State6",1) == 3 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Кон. ст.","Metrostroi_PAM30",45, 180,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap] and tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1]:sub(1,10).." "..LastStation,"Metrostroi_PAM30",457, 180,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif LastStation ~= -1 then
				draw.SimpleText(LastStation,"Metrostroi_PAM30",457, 180,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			Metrostroi.DrawRectOL(40, 210, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State6",1) == 4 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Маршрут","Metrostroi_PAM30",45, 230,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAM30",457, 230,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			
			Metrostroi.DrawRectOL(40, 260, 432, 40,Color(110,172,95),3,train:GetNWBool("PAM:State6",1) == 5 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Ввод данных","Metrostroi_PAM30",45, 280,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:State6Error",false) then
				Metrostroi.DrawRectOL(106, 125, 300, 150,Color(110,172,95),3,Color(180,180,180))
				draw.SimpleText("Ошибка при","Metrostroi_PAM30",256, 150,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("вводе данных","Metrostroi_PAM30",256, 180,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190, 220, 132, 40,Color(2,2,2),3,Color(220,220,220))
				draw.SimpleText("ENTER","Metrostroi_PAM30",256, 240,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
				
			
			if train:GetNWInt("PAM:State6",1) == 2 and tbl[Announcer.AnnMap] and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
						i = i + 1
						if i > 10 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 155, 391, -9 + i*22,Color(110,172,95),3,Color(230,230,230))
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
							if i < 10 then
								draw.SimpleText(v,"Metrostroi_PAM30",86, 150+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAM30",465, 150+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							else
								draw.SimpleText("...","Metrostroi_PAM30",86, 150+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText("...","Metrostroi_PAM30",465, 150+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							end
							
							i = i + 1
							if i > 10 then break end
						end
					end
					Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(110,172,95),3)
				end
			end
			if train:GetNWInt("PAM:State6",1) == 3 and tbl[Announcer.AnnMap] and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
						if i > 9 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 205, 391, -9 + i*22,Color(110,172,95),3,Color(230,230,230))
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
							if i < 9 then
							draw.SimpleText(v,"Metrostroi_PAM30",86, 200+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAM30",465, 200+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							else
								draw.SimpleText("...","Metrostroi_PAM30",86, 200+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText("...","Metrostroi_PAM30",465, 200+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							end
							
							i = i + 1
							if i > 9 then break end
						end
					end
					Metrostroi.DrawLine(140, 205, 140, 195 + i*22,Color(110,172,95),3)
				end
			end
		end
		if train:GetNWInt("PAM:State",-1) == 7 then
			local Line = self.Train:GetNWInt("PAM:Line",0)
			local LastStation = self.Train:GetNWInt("PAM:LastStation",-1)
			local RouteNumber = self.Train:GetNWInt("PAM:RouteNumber",-1)
			local tbl = Metrostroi.WorkingStations
			draw.SimpleText("Перезапуск","Metrostroi_PAM30",110, 30,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 50, 492, 367,Color(110,172,95),3)
			
			Metrostroi.DrawRectOL(40, 60, 432, 40,Color(110,172,95),3,train:GetNWInt("PAM:State6",1) == 1 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Линия","Metrostroi_PAM30",45, 80,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Line,"Metrostroi_PAM30",457, 80,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)


			Metrostroi.DrawRectOL(40, 110, 432, 40,Color(110,172,95),3,train:GetNWInt("PAM:State6",1) == 2 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Кон. ст.","Metrostroi_PAM30",45, 130,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1]:sub(1,10).." "..LastStation,"Metrostroi_PAM30",457, 130,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif LastStation ~= -1 then
				draw.SimpleText(LastStation,"Metrostroi_PAM30",457, 130,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end

			Metrostroi.DrawRectOL(40, 160, 432, 40,Color(110,172,95),3,train:GetNWInt("PAM:State6",1) == 3 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Маршрут","Metrostroi_PAM30",45, 180,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAM30",457, 180,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			

			Metrostroi.DrawRectOL(40, 210, 432, 40,Color(110,172,95),3,train:GetNWInt("PAM:State6",1) == 4 and Color(230,230,230) or Color(180,180,180))
			draw.SimpleText("Ввод данных","Metrostroi_PAM30",45, 230,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:State6Error",false) then
				Metrostroi.DrawRectOL(106, 125, 300, 150,Color(110,172,95),3,Color(180,180,180))
				draw.SimpleText("Ошибка при","Metrostroi_PAM30",256, 150,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("вводе данных","Metrostroi_PAM30",256, 180,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190, 220, 132, 40,Color(2,2,2),3,Color(220,220,220))
				draw.SimpleText("ENTER","Metrostroi_PAM30",256, 240,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end

			if train:GetNWInt("PAM:State6",1) == 2 and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
						if i > 10 then break end
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 155, 391, -9 + i*22,Color(110,172,95),3,Color(230,230,230) )
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
							if i < 10 then
								draw.SimpleText(v,"Metrostroi_PAM30",86, 150+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAM30",465, 150+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							else
								draw.SimpleText("...","Metrostroi_PAM30",86, 150+i*22,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
								draw.SimpleText("...","Metrostroi_PAM30",465, 150+i*22,Color(2,2,2),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							end
							
							i = i + 1
							if i > 10 then break end
						end
					end
					Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(110,172,95),3)
				end
			end
		end
		if train:GetNWInt("PAM:State",-1) == 8 then
			draw.SimpleText("Проверка состава","Metrostroi_PAM30",10, 30,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("перед выходом на линию","Metrostroi_PAM30",10, 70,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 100, 492, 210,Color(110,172,95),3)
			draw.SimpleText("Для перехода в рабочий режим","Metrostroi_PAM30",60, 170,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawRectOutline(240, 225, 100, 30,Color(110,172,95),3,Color(254,237,142))
			draw.SimpleText("нажми              ENTER","Metrostroi_PAM30",60, 240,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Проверка состава разрешена","Metrostroi_PAM30",256, 365,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
		end
		if train:GetNWInt("PAM:State",-1) == 9 then
			local Line = train:GetNWInt("PAM:Line",0)
			local Path = train:GetNWInt("PAM:Path",0)
			local Station = tonumber(train:GetNWInt("PAM:Station",0))
			local LastStation = tonumber(train:GetNWInt("PAM:LastStation",-1))
			local S = Format("%.2f",train:GetNWInt("PAM:Distance",0))
			local speed = math.floor(self.Train:GetPackedRatio(3)*100.0)
			local spd = self.Train:GetNWBool("PAM:UOS", false) and 35 or self.Train:GetNWBool("PAM:VRD",false) and 20 or self.Train:GetPackedBool(46) and 80 or self.Train:GetPackedBool(45) and 70 or self.Train:GetPackedBool(44) and 60 or self.Train:GetPackedBool(43) and 40 or self.Train:GetPackedBool(42) and 0 or "НЧ"
			Metrostroi.DrawRectOutline(10, 6, 100, 40,Color(110,172,95),3 )
			local date = os.date("!*t",os_time)
			draw.SimpleText(Format("%02d:%02d:%02d",date.hour,date.min,date.sec),"Metrostroi_PAM25",59, 30,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Линия "..Line,"Metrostroi_PAM30",120, 30,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if Station > 0 then
				draw.SimpleText("до "..Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAM25",508, 10,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				if Metrostroi.AnnouncerData[Station] then draw.SimpleText(Metrostroi.AnnouncerData[Station][1] or "err","Metrostroi_PAM25",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			else
				draw.SimpleText("выход на линию","Metrostroi_PAM25",508, 13,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAM25",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			if Path and Path > 0 then
				draw.SimpleText("Путь "..Path,"Metrostroi_PAM30",240, 30,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Путь N/A","Metrostroi_PAM30",240, 30,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			Metrostroi.DrawRectOutline(10, 100, 400, 20,Color(40,38,39), 2)
			Metrostroi.DrawLine(10, 110, 410, 110,Color(40,38,39), 2)

			surface.SetDrawColor(Color(110,172,95))
			surface.DrawRect(11,101,398*self.Train:GetPackedRatio(3),7)
			surface.SetDrawColor((spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or  Color(200,0,0))
			surface.DrawRect(11,111,398*(spd == "НЧ" and 20 or spd)/100,7)
			for i = 0,10 do
				if i > 0 and i < 10 then
					Metrostroi.DrawLine(10 + i*40, 100, 10 + i*40, 120,Color(40,38,39), 2)
				end

				if i%2 == 0 or (i == 7 and spd == 70) then
					draw.SimpleText(i*10,"Metrostroi_PAM30",10 + i*40, 135,(spd == "НЧ" and 20 or spd) == i*10 and ((spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or Color(200,0,0)) or Color(74,74,74),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
			draw.SimpleText(speed,"Metrostroi_PAM50",480, 85,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(spd,"Metrostroi_PAM50",480, 120,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or  Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("S = "..S,"Metrostroi_PAM30",6, 401,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Рц = "..train:GetNWString("PAM:SName",""),"Metrostroi_PAM30",240, 401,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(Color(180,180,180))
			if not train:GetNWBool("PAM:RR",false) then
				surface.DrawRect(6,295,490,21)
				draw.SimpleText("Установи реверсивную рукоятку","Metrostroi_PAM30",10, 305,Color(20,20,20),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			surface.DrawRect(6,320,100,24)  surface.DrawRect(171,320,36,24) surface.DrawRect(212,320,54,24) --surface.DrawRect(266,320,40,20)
			draw.SimpleText(self.Types[train:GetNWBool("PAM:Type",false)].."="..self.Positions[train:GetNWBool("PAM:KV",false)],"Metrostroi_PAM30",10, 331,Color(20,20,20),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				surface.DrawRect(111,320,55,24)
			if train:GetNWBool("PAM:VZ1",false) or train:GetNWBool("PAM:VZ2",false) then
				draw.SimpleText(train:GetNWBool("PAM:VZ1",false) and (train:GetNWBool("PAM:VZ2",false) and "В1 2" or "В1") or "В   2","Metrostroi_PAM30",85 + 55/2, 331,Color(20,20,20),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText("КД","Metrostroi_PAM30",171+35/2, 331,train:GetPackedBool(40) and Color(20,20,20) or Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("ЛПТ","Metrostroi_PAM30",239, 331,train:GetPackedBool("PN") and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.DrawRect(6,355,100,21)-- surface.DrawRect(111,355,100,20) surface.DrawRect(215,355,50,20)
			draw.SimpleText("КВ АРС","Metrostroi_PAM30",56, 365,train:GetPackedBool(48) and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			Metrostroi.DrawRectOutline(370, 320, 130, 60,Color(110,172,95),3 )
			draw.SimpleText("Т.       "..Format("%02d:%02d:%02d",date.hour,date.min,date.sec),"Metrostroi_PAM20",375, 330,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Тпр.    "..(self.Train:GetPackedRatio(3)*100.0 > 0.25 and math.min(999,math.floor(S/(speed*1000/3600))) or "inf"),"Metrostroi_PAM20",375, 347.5,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--draw.SimpleText("Na   =","Metrostroi_PAM20",375, 347.5,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Тост = "..train:GetNWInt("PAM:BoardTime",0),"Metrostroi_PAM20",375, 365,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			if train:GetNWInt("PAM:Menu",0) > 0 then
				Metrostroi.DrawRectOL(50, 150, 385, 24*7+3,Color(160,160,160), 3,Color(180,180,180))
				--surface.SetDrawColor(Color(180,180,180))
				--surface.DrawRect(51,151,382,24*7-4)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(51,127 + train:GetNWInt("PAM:Menu",0)*24,382,23)
				for i = 1,6 do
					Metrostroi.DrawLine(50,150+24*i,435,150+24*i,Color(160,160,160),3)
				end
				draw.SimpleText("Проверка наката","Metrostroi_PAM22",256, 162,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(train:GetNWBool("PAM:KD") and "Движение с КД" or "Движение без КД","Metrostroi_PAM22",256, 186,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(train:GetNWBool("PAM:LPT") and "Движение с контролем ЛПТ" or "Движение без контроля ЛПТ","Metrostroi_PAM22",256, 210,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Движение транзитом","Metrostroi_PAM22",256, 234,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Движение с  Vд = 0","Metrostroi_PAM22",256, 258,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Зонный оборот","Metrostroi_PAM22",256, 282,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Фиксация станции","Metrostroi_PAM22",256, 306,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--draw.SimpleText("Station mode","Metrostroi_PAM22",256, 330,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWInt("PAM:Ann",0) > 0 then
				Metrostroi.DrawRectOutline(50, 150, 385, 24*4,Color(160,160,160), 3)
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(51,151,382,24*4-4)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(51,127 + train:GetNWInt("PAM:Ann",0)*24,382,23)
				for i = 1,3 do
					Metrostroi.DrawLine(50,150+24*i,435,150+24*i,Color(160,160,160),3)
				end
				draw.SimpleText("Просьба выйти из вагонов","Metrostroi_PAM22",256, 162,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Заходите и выходите быстрее","Metrostroi_PAM22",256, 186,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Отпустите двери","Metrostroi_PAM22",256, 210,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Поезд скоро отправится","Metrostroi_PAM22",256, 234,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWInt("PAM:NeedConfirm",0) > 0 then
				Metrostroi.DrawRectOL(106-100, 150, 300+200, 100,Color(160,160,160),3,Color(180,180,180))
				draw.SimpleText("Подтверди "..self.Questions[train:GetNWInt("PAM:NeedConfirm",0)].."?","Metrostroi_PAM28",256, 175,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190-90, 195, 132, 40,Color(160,160,160),2,Color(230,230,230))
				draw.SimpleText("Да - Enter","Metrostroi_PAM30",256-90, 215,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190+90, 195, 132, 40,Color(160,160,160),2,Color(230,230,230))
				draw.SimpleText("Нет - Esc","Metrostroi_PAM30",256+90, 215,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWBool("PAM:Nakat") then
				Metrostroi.DrawRectOL(106, 150, 300, 125,Color(20,20,20),3,Color(180,180,180))
				draw.SimpleText("Проверка наката","Metrostroi_PAM30",256, 165,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Расстояние: ","Metrostroi_PAM30",111, 195,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Format("%.2f",self.Train:GetNWFloat("PAM:Meters",0)),"Metrostroi_PAM30",300, 195,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("Направление: ","Metrostroi_PAM30",111, 225,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.Train:GetNWBool("PAM:Sign",false) and "Назад" or "Вперёд","Metrostroi_PAM30",300, 225,self.Train:GetNWBool("PAM:Sign",false) and Color(200,0,0) or Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190-20, 240, 132+40, 30,Color(160,160,160),2,Color(230,230,230))
				draw.SimpleText("Отмена - Esc","Metrostroi_PAM30",256, 255,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				--draw.SimpleText(self.Questions[train:GetNWInt("PAM:NeedConfirm",0)].."?","Metrostroi_PAM30",256, 180,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWInt("PAM:Fix",-1) > -1 or train:GetNWInt("PAM:Zon",-1) > -1 then
				local Line = train:GetNWInt("PAM:FLine",0)
				local StationAc = train:GetNWInt("PAM:FAc",-1)
				local Station = train:GetNWInt("PAM:FStation",0)
				local choosed = train:GetNWInt("PAM:Fix",-1) > -1 and train:GetNWInt("PAM:Fix",0) or train:GetNWInt("PAM:Zon",0)
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(10,151,512-20,24*6+3)
				--Metrostroi.DrawRectOutline(12,153,512-24,24*8-8,Color(20,20,20), 2)
				Metrostroi.DrawRectOL(12,153,512-24,24*1,Color(20,20,20), 2,choosed == 0 and Color(230,230,230) or Color(180,180,180))
				draw.SimpleText("Линия","Metrostroi_PAM22",50, 164,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				if Line > -1 then draw.SimpleText(Line,"Metrostroi_PAM22",350, 164,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER) end
				Metrostroi.DrawRectOL(12,153 + 24*1-1,512-24,24*1,Color(20,20,20), 2,choosed == 1 and Color(230,230,230) or Color(180,180,180))
				draw.SimpleText("Код станции","Metrostroi_PAM22",50, 187,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				local tbl = Metrostroi.WorkingStations

				if Station ~= -1 then
					for i = 1,#tostring(Station) do
						draw.SimpleText(tostring(Station)[i],"Metrostroi_PAM22",350 + (i-1)*20, 187,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				else
					if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][StationAc] and Metrostroi.AnnouncerData[StationAc] then
						draw.SimpleText(Metrostroi.AnnouncerData[StationAc][1].."("..StationAc..")","Metrostroi_PAM22",350, 187,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					elseif StationAc ~= -1 then
						draw.SimpleText(StationAc,"Metrostroi_PAM22",350, 187,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					end
				end
				Metrostroi.DrawRectOL(12,153 + 24*2-2,512-24,24*1,Color(20,20,20), 2,choosed == 2 and Color(230,230,230) or Color(180,180,180))
				draw.SimpleText("Ввод данных","Metrostroi_PAM22",50, 210,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(12,153 + 24*3,512-24,24*3,Color(20,20,20), 2,Color(180,180,180))
				local i = 0
				local FLine = train:GetNWInt("PAM:FLine",-1)
				if Metrostroi.WorkingStations[Announcer.AnnMap][FLine] then
					for k,v in pairs(Metrostroi.WorkingStations[Announcer.AnnMap][FLine]) do
						if Metrostroi.AnnouncerData[v] and tostring(v):find(Station ~= -1 and Station or StationAc) then
							local name = Metrostroi.AnnouncerData[v][1]
							local tbl = string.Explode(" ",name)
							if #tbl > 1 then
								name = ""
								for k,v in pairs(tbl) do
									name = name..v[1]
								end
							end
							draw.SimpleText(v .."-".. name:sub(1,2),"Metrostroi_PAM22",30 + math.floor(i/4)*110, 250-15 + i%4*15,Color(2,2,2),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							i = i + 1
						end
					end
				end
				if train:GetNWBool("PAM:State6Error",false) then
					Metrostroi.DrawRectOL(106, 125, 300, 150,Color(20,20,20),3,Color(180,180,180))
					draw.SimpleText("Ошибка при","Metrostroi_PAM30",256, 150,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					draw.SimpleText("вводе данных","Metrostroi_PAM30",256, 180,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
					Metrostroi.DrawRectOL(190, 220, 132, 40,Color(20,20,20),3,Color(230,230,230))
					draw.SimpleText("ENTER","Metrostroi_PAM30",256, 240,Color(2,2,2),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
				
		end
		surface.SetAlphaMultiplier(1)
	end
	function TRAIN_SYSTEM:ClientThink()
	end
end

function TRAIN_SYSTEM:UpdateUPO()
	for k,v in pairs(self.Train.WagonList) do
		v.UPO:SetStations(self.Line,self.FirstStation,self.LastStation,v == self.Train)
		v:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
	end
end

function TRAIN_SYSTEM:Trigger(name,nosnd)
	--self.Pass = "A"
	--self.State = 0
	local Announcer = self.Train.Announcer
	self.Pitches = {
		B1 = 166,
		B2 = 155 ,
		B3 = 144,
		B4 = 160,
		B5 = 150,
		B6 = 140,
		B7 = 150,
		B8 = 145,
		B9 = 140,
		BEsc = 140,
		B0 = 135,
		BEnter = 130,
		BLeft = 125,
		BDown = 120,
		BRight = 115,
		BF = 130,
		BUp = 125,
		BM = 120,
	}
	if not nosnd then self.Train:PlayOnce("paksd","cabin",0.75,self.Pitches[name] or 120.0) end
	if self.State == 3 and name == "BEnter" then
		self:SetState(4)
	elseif self.State == 4 then
		if name == "BEnter" then
			if self.EnteredPass == "31173" then
				self:SetState(-2)
			elseif self.Pass ~= self.EnteredPass then
				self.EnteredPass = "/"
			else
				self:SetState(5)
			end
		else
			if self.EnteredPass == "/" then self.EnteredPass = "" end
			local Char = tonumber(name:sub(2,2))
			if Char and #self.EnteredPass < 11 then self.EnteredPass = self.EnteredPass..tonumber(name:sub(2,2)) end
		end
	elseif self.State == 5 then
		if name == "BDown" then
			self.State5Choose = math.min(self.Train:GetNWBool("PAM:Restart") and 2 or 1,(self.State5Choose or 1) + 1)
		end
		if name == "BUp" then
			self.State5Choose = math.max(1,(self.State5Choose or 1) - 1)
		end
		if name == "BEnter" then
			if self.State5Choose == 1 then
				self:SetState(6)
			else
				self:SetState(7)
			end
		end
	elseif self.State == 6 then
		if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
		if name == "BDown" then
			self.State6Choose = math.min(5,(self.State6Choose or 1) + 1)
		end
		if name == "BUp" then
			self.State6Error = false
			self.State6Choose = math.max(1,(self.State6Choose or 1) - 1)
		end
		if name == "BEsc" then
			if self.State6Choose == 2 then
				self.FirstStation= self.FirstStation:sub(1,-2)
			end
			if self.State6Choose == 3 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State6Choose == 4 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEnter" and self.State6Choose == 5 then
			if not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] or
				not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][tonumber(self.FirstStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][tonumber(self.LastStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
				self.State6Error = not self.State6Error
			else
				self:SetState(8)
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State6Choose == 1 then
				self.Line = Char
				if Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
					self.FirstStation = tostring(Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][Routelength])
				end
			end
			if self.State6Choose == 2 and #self.FirstStation < 3 and (Char ~= 0 or #self.FirstStation > 0) then
				self.FirstStation= self.FirstStation..tostring(Char)
			end
			if self.State6Choose == 3 and #self.LastStation < 3 and (Char ~= 0 or #self.LastStation > 0) then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State6Choose == 4 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 7 then
		if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
		if name == "BDown" then
			self.State6Choose = math.min(4,(self.State6Choose or 1) + 1)
		end
		if name == "BUp" then
			self.State6Error = false
			self.State6Choose = math.max(1,(self.State6Choose or 1) - 1)
		end
		if name == "BEsc" then
			if self.State6Choose == 2 then
				self.LastStation= self.LastStation:sub(1,-2)
			end
			if self.State6Choose == 3 then
				self.RouteNumber= self.RouteNumber:sub(1,-2)
			end
			self:UpdateUPO()
		end
		if name == "BEnter" and self.State6Choose == 4 then
			if not Metrostroi.EndStations[Announcer.AnnMap][self.Line] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.FirstStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.LastStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.LastStation)] or
				#self.RouteNumber < 3 or self.LastStation == self.FirstStation then
				self.State6Error = not self.State6Error
			else
				self:SetState(9)
				for k,v in pairs(self.Train.WagonList) do
					if v ~= self.Train and v["PA-M"] then
						v["PA-M"]:SetState(9)
					end
				end
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State6Choose == 1 then
				self.Line = Char
				if Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
					self.FirstStation = self.FirstStation ~= "" and self.FirstStation or tostring(Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][Routelength])
					if tonumber(self.LastStation) < tonumber(self.FirstStation) then
						local temp = self.FirstStation
						self.FirstStation = self.LastStation
						self.LastStation = temp
					end
				end
			end
			if self.State6Choose == 2 and #self.LastStation < 3 and (Char ~= 0 or #self.LastStation > 0) then
				self.LastStation= self.LastStation..tostring(Char)
			end
			if self.State6Choose == 3 and #self.RouteNumber < 3 then
				self.RouteNumber= self.RouteNumber..tostring(Char)
			end
			self:UpdateUPO()
		end
	elseif self.State == 8 then
		if name == "BEnter" and self.Check == false then
			self:SetState(9)
		end
	elseif self.State == 9 then
		if name == "BF" then
			if self.MenuChoosed == 0 and self.AnnChoosed == 0 and not self.Zon and not self.Fix then
				self.MenuChoosed = 1
			end
		end
		if name == "BDown" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.min(7,self.MenuChoosed + 1)

				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BDown",true)
				elseif self.MenuChoosed == 6 then
					if self.LastStation == tostring(self.Train.UPO.Station) then
						self:Trigger("BDown",true)
					end
				elseif self.MenuChoosed == 7 then
					if self.FirstStation == tostring(self.Train.UPO.Station) then
						self:Trigger("BDown",true)
					end
				end
			end
			if self.AnnChoosed ~= 0 and not self.Zon and not self.Fix then
				self.AnnChoosed = math.min(4,self.AnnChoosed + 1)
			end
		end
		if name == "BUp" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.max(1,self.MenuChoosed - 1)
				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BUp",true)
				end
			end
			if self.MenuChoosed == 0 and self.AnnChoosed == 0 then
				self.AnnChoosed = 1
			end
			if self.AnnChoosed ~= 0 then
				self.AnnChoosed = math.max(1,self.AnnChoosed - 1)
			end
		end
		if name == "BEsc" then
			--if self.MenuChoosed ~= 0 then
				if (not self.NeedConfirm or self.NeedConfirm == 0) then self.MenuChoosed = 0 end
				self.AnnChoosed = 0
			--end
		end
		if (self.NeedConfirm and self.NeedConfirm > 0) then
			if name == "BEnter" then
				if self.NeedConfirm == 1 and self.Train.Speed < 0.5 then
					self.Nakat = true
				end
				if (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80) then
					self.VRD = true
				end
				if self.NeedConfirm == 6 then
					self.Zon = 1
					self.FStation = ""
					self.FLine = self.Line
					self.State6Error = false
				end
				if self.NeedConfirm == 7 then
					self.Fix = 0
					self.FStation = ""
					self.FLine = nil
					self.State6Error = false
				end
				self.NeedConfirm = 0
				self.MenuChoosed = 0
			end
			if name == "BEsc" then
				self.NeedConfirm = 0
			end
		end
		if self.MenuChoosed ~= 0 and not self.Nakat and not self.Fix and not self.Zon then
			if name == "BEnter" and (not self.NeedConfirm or self.NeedConfirm == 0) then
				if self.MenuChoosed == 1 and self.Train.Speed < 0.5 then
					self.NeedConfirm = 1
				elseif self.MenuChoosed == 2 then
					self.KD = not self.KD
				elseif self.MenuChoosed == 3 then
					self.LPT = not self.LPT
				elseif self.MenuChoosed == 4 then
					self.Transit = not self.Transit
					self.AutodriveWorking = false
				elseif self.MenuChoosed == 5 then
					self.NeedConfirm = 5
				elseif self.MenuChoosed == 6 then
					self.NeedConfirm = 6
				elseif self.MenuChoosed == 7 then
					self.NeedConfirm = 7
				elseif self.MenuChoosed == 8 and not self.Arrived then
					--self.Arrived = true
					--if self.Train.R_UPO.Value > 0 then
--						local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
						--self.UPO:PlayArriving(self.Train.UPO.Station,tbl[tbl[self.Train.UPO.Station] + (self.Train.UPO.Path == 1 and 1 or -1)],self.Train.UPO.Path)
					--end
				end
				if self.NeedConfirm == 0 then self.MenuChoosed = 0 end
				--if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
		end
		if self.AnnChoosed ~= 0 and not self.Nakat and not self.Fix and not self.Zon then
			if name == "BEnter" then
				if self.Train.R_UPO.Value > 0 then self.Train.UPO:II(self.AnnChoosed) end
				self.AnnChoosed = 0
			end
			local Char = tonumber(name:sub(2,2))
			if Char and Char > 0 and Char < 5 and self.Train.R_UPO.Value > 0 then
				self.Train.UPO:II(Char)
				self.AnnChoosed = 0
			end
		end

		if name == "BEsc" and self.Nakat then
			self.Nakat = false
			if self.Train:ReadTrainWire(1) < 1 then
				self.Train.ALS_ARS.Nakat = false
			end
		end
		if self.Fix then
			if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
			if name == "BEsc" then
				if self.Fix == 1 and self.EnteredStation then
					self.EnteredStation = nil
				end
			end
			if name == "BEnter" and self.Fix == 2 then
				if not Metrostroi.WorkingStations[Announcer.AnnMap][self.FLine] or
					not Metrostroi.WorkingStations[Announcer.AnnMap][self.FLine][tonumber(self.FStation)] or 
					not Metrostroi.AnnouncerData[tonumber(self.FStation)] or tonumber(self.FStation) == self.FirstStation then
					self.State6Error = not self.State6Error
				else
					self.FirstStation = self.FStation
					self.Line = self.FLine
					self.Fix = nil
					self:UpdateUPO()
				end
			end
			if name == "BEnter" and self.Fix == 1 then
				self.FStation = self.EnteredStation
				self.EnteredStation = nil
			end
			if name == "BDown" and not self.EnteredStation then
				self.Fix = math.min(2,self.Fix + 1)
			end
			if name == "BUp" and not self.EnteredStation then
				self.State6Error = false
				self.Fix = math.max(0,self.Fix - 1)
			end
			local Char = tonumber(name:sub(2,2))
			if Char then
				if self.Fix == 0 then
					self.FLine = Char
				end
				if self.Fix == 1 and not self.EnteredStation then
					self.EnteredStation = ""
				end
				if self.Fix == 1 and #self.EnteredStation < 3 and (Char ~= 0 or #self.EnteredStation > 0) then
					self.EnteredStation= self.EnteredStation..tostring(Char)
				end
			end
		end
		if self.Zon then
			if self.State6Error then if name == "BEnter" then self.State6Error = false end return end
			if name == "BEsc" then
				if self.Zon == 1 and self.EnteredStation then
					self.EnteredStation = nil
				end
			end
			if name == "BEnter" and self.Zon == 2 then
				if not Metrostroi.WorkingStations[Announcer.AnnMap][self.FLine] or
					not Metrostroi.WorkingStations[Announcer.AnnMap][self.FLine][tonumber(self.FStation)] or 
					not Metrostroi.AnnouncerData[tonumber(self.FStation)] or tonumber(self.FStation) == self.LastStation then
					self.State6Error = not self.State6Error
				else
					self.Zon = nil
					self.LastStation = self.FStation
					self:UpdateUPO()
				end
			end
			if name == "BEnter" and self.Zon == 1 then
				self.FStation = self.EnteredStation
				self.EnteredStation = nil
			end
			if name == "BDown" and not self.EnteredStation then
				self.Zon = math.min(2,self.Zon + 1)
			end
			if name == "BUp" and not self.EnteredStation then
				self.State6Error = false
				self.Zon = math.max(1,self.Zon - 1)
			end
			local Char = tonumber(name:sub(2,2))
			if Char then
				if self.Zon == 0 then
					self.FLine = Char
				end
				if self.Zon == 1 and not self.EnteredStation then
					self.EnteredStation = ""
				end
				if self.Zon == 1 and #self.EnteredStation < 3 and (Char ~= 0 or #self.EnteredStation > 0) then
					self.EnteredStation= self.EnteredStation..tostring(Char)
				end
			end
		end
	end
end
function TRAIN_SYSTEM:GetTimer(val)
	return self.TimerMod and (CurTime() - self.Timer) > val
end
function TRAIN_SYSTEM:SetTimer(mod)
	if mod then
		if self.TimerMod == mod then return end
		self.TimerMod = mod
	else
		self.TimerMod = nil
	end
	self.Timer = CurTime()
end

function TRAIN_SYSTEM:SetState(state,add,state9)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
	if state and self.State ~= state then
		self.State = state
		if state == 1 then
			self.NextState = add
		end
		self:SetTimer()
	elseif not state then
		state = self.NextState
		self.State = self.NextState
	end
	if state == 4 then
		self.EnteredPass = ""
	end
	if state == 5 then
		self.State5Choose = 1
	end
	if state == 6 then
		self.State6Choose = 1
		self.Line = 1
		if Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] then
			local Routelength = #Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
			--self.FirstStation = tostring(self.Train.UPO.Path == 2 and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][Routelength] or Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][1])
			--self.LastStation = tostring(self.Train.UPO.Path == 1 and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][Routelength] or Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][1])
		else
			--self.FirstStation = "111"
			--self.LastStation = "123"
		end
		self:UpdateUPO()
		self.FirstStation = ""
		self.LastStation = ""
		self.State6Error = false
	end
	if state == 7 then
		self.State6Choose = 1
		self.State6Error = false
	end
	if state == 8 then
		self.Check = nil
		ARS:TriggerInput("Ring",1)
		for k,v in pairs(self.Train.WagonList) do
			v.ENDis:TriggerInput("Set",1)
		end
		if not state9 then
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v["PA-M"] then
					v["PA-M"]:SetState(8,nil,true)
				end
			end
		end
	else
		for k,v in pairs(self.Train.WagonList) do
			v.ENDis:TriggerInput("Set",0)
		end
	end
	if state == 9 then
		if not state9 then
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v["PA-M"] then
					v["PA-M"]:SetState(9,nil,true)
				end
			end
		end
		self.AnnChoosed = 0
		self.NeedConfirm = 0
		self.MenuChoosed = 0
		self.Fix = nil
		self.Zon = nil
		Train.UPO.BoardTime = nil
		self.ODZ = nil
	end
	if state == 0 then
		self.Train:PlayOnce("paksd","cabin",0.75,200.0)
		self.Train.ALS_ARS:TriggerInput("Ring",0)
		self.EnteredPass = ""
	end
	if state == 3 then
		if IsValid(self.Train.DriverSeat) then
			self.Train.DriverSeat:EmitSound("subway_announcer/00_05.mp3", 73, 100)
		end
	end
end
function TRAIN_SYSTEM:Think(dT)
	if self.Train.Blok ~= 3 then self:SetState(-1) return end
	--print(self.Train.Owner)
	local Train = self.Train
	local ARS = Train.ALS_ARS
	local Announcer = Train.Announcer
--	self.Train.UPO.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
--	self.Train.UPO.Path = Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
--	self.Train.UPO.Distance = math.min(9999,self.Train:ReadCell(49165) + (Train.Autodrive.Corrections[self.Train.UPO.Station] or 0) - 4.3)
	if Train.VAU.Value < 0.5 or Train.Panel["V1"] < 0.5 then self:SetState(-1) end
	if Train.VAU.Value > 0.5 and self.State == -1 and Train.Panel["V1"] > 0.5 then self:SetState(0) end
	if Train.VB.Value > 0.5 and Train.Battery.Voltage > 55 and self.State > -1  then
		for k,v in pairs(self.TriggerNames) do
			if Train[v] and (Train[v].Value > 0.5) ~= self.Triggers[v] then
				if Train[v].Value > 0.5 then
					self:Trigger(v)
				end
				--print(v,self.Train[v].Value > 0.5)
				self.Triggers[v] = Train[v].Value > 0.5
			end
		end
	end
	if self.Train.KV.ReverserPosition == 0 and self.State > 3 and self.State < 8 and self.State ~= -9 then self:SetState(3) end
	if self.State == 0 and self.RealState ~= 0 then
	elseif self.State == 0 then
		self:SetTimer(0.5)
		if self:GetTimer(4) then
			self:SetState(1,2)
		end
	elseif self.State == 1 then
		self:SetTimer(1)
		if self:GetTimer(0.4) then
			self:SetState()
		end
	elseif self.State == 2 then
		self:SetTimer(0.5)
		if self:GetTimer(6) then
			self:SetState(1,3)
		end
	elseif self.State == 8 then
		--print(ARS.KVT)
		if ARS.KVT and self.Check == nil then
			self.Check = true
			self:SetTimer(4)
		end
		if not ARS.KVT and self.Check ~= false then
			self.Check = nil
			self:SetTimer()
		end
		if ARS.KVT and self:GetTimer(1) then
			self.Check = false
			ARS:TriggerInput("Ring",0)
			for k,v in pairs(self.Train.WagonList) do
				if v ~= self.Train and v.ALS_ARS then
					v.ALS_ARS:TriggerInput("Ring",0)
				end
			end
			self:SetTimer()
		end
	elseif self.State == 9 then
		if (self.Train.UPO:GetSTNum(self.LastStation) > self.Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 2) or (self.Train.UPO:GetSTNum(self.FirstStation) > self.Train.UPO:GetSTNum(self.LastStation)  and self.Train.UPO.Path == 1) then
			local old = self.LastStation
			self.LastStation = self.FirstStation
			self.FirstStation = old
		end
		if self.VRD and (not ARS.Signal0 or ARS.Signal0 and (ARS.Signal40 or ARS.Signal60 or ARS.Signal70 or ARS.Signal80)) then self.VRD = false end
		self.State9 = (Train.UPO:End(self.Train.UPO.Station,self.Train.UPO.Path,true) or Train.UPO:GetSTNum(self.LastStation) > Train.UPO:GetSTNum(self.Train.UPO.Station) and self.Train.UPO.Path == 2 or Train.UPO:GetSTNum(self.Train.UPO.Station) < Train.UPO:GetSTNum(self.FirstStation) and self.Train.UPO.Path == 1) and 0 or 1--self.Arrived ~= nil and 1 or 2
		if self.State9 ~= 0 and self.Train.KV.ReverserPosition ~= 0 then
			if not self.Trainsit then
				if self.Train.UPO.Distance < 100 and self.Train.Speed > 55 then
					self.StopTrain = true
				end
				if self.Train.UPO.Distance < 10 and self.Train.Speed > 20 then
					self.StopTrain = true
				end
				if self.Train.Speed < 0.5 and self.StopTrain then
					self.StopTrain = false
				end
				if self.StopTrain then
				end
			elseif self.StopTrain then
				self.StopTrain = false
			end
				
			if self.RealState == 8 and not self.Transit then
				if self.Train.UPO.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Train.UPO.Station] and ARS.Speed <= 1 then
					self.Arrived = true
				end
			end
			--[[
			if not self.Transit and 45 < self.Train.UPO.Distance and self.Train.UPO.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Train.UPO.Station] then
				self.Arrived = true
				if self.Train.R_UPO.Value > 0 then
					local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
					self.UPO:PlayArriving(self.Train.UPO.Station,tbl[tbl[self.Train.UPO.Station] + (self.Train.UPO.Path == 1 and 1 or -1)],self.Train.UPO.Path)
				end
			end
			]]
			if self.Transit then self.Arrived = nil end
			if self.Train.UPO.Distance > 75 then
				self.Arrived = nil
			else
				--if self.Train.Panel.SD < 0.5 then self.Arrived = true end
			end
			--if (self.Ring == nil or self.Ring == 0) and self.Train.Panel.SD < 0.5 then
				--self.Ring = false
			--end
			if self.Arrived then
				if Train.UPO.BoardTime and math.floor((Train.UPO.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
					self.Arrived = false
				end
			end
			if (self.Train:ReadCell(1) > 0 or ARS.Speed > 1) and self.Arrived == false then self.Arrived = nil end
		end
		if self.Nakat then
			if not self.Meters then self.Meters = 0 end
			self.Meters = self.Meters + ARS.Speed*self.Train.SpeedSign/3600*1000*dT
			if math.abs(self.Meters) > 2.5 then
				self.Nakat = false
				if self.Train:ReadTrainWire(1) < 1 then
					ARS.Nakat = self.Meters < 0
				end
			end
		else
			self.Meters = nil
		end
	end
	if self.State ~= self.RealState then
		self.RealState = self.State
		self.TimeOverride = true
	end

	self.Time = self.Time or CurTime()
	if (CurTime() - self.Time) > 0.1 or self.TimeOverride then
		self.TimeOverride = nil
		--print(1)
		self.Time = CurTime()
		Train:SetNWInt("PAM:State",self.State)
		if self.State == 3 then
			Train:SetNWBool("PAM:RR",self.Train.KV.ReverserPosition ~= 0)
		elseif self.State == 4 then
			Train:SetNWInt("PAM:Pass",self.EnteredPass ~= "/" and #self.EnteredPass or -1)
		elseif self.State == 5 then
			Train:SetNWBool("PAM:Restart",self.FirstStation ~= "" and self.LastStation ~= "")
			Train:SetNWInt("PAM:State5",self.State5Choose)
		elseif self.State == 6 then
			Train:SetNWInt("PAM:State6",self.State6Choose)
			Train:SetNWBool("PAM:State6Error",self.State6Error)
			Train:SetNWInt("PAM:LastStation",tonumber(self.LastStation) or -1)
			Train:SetNWInt("PAM:FirstStation",tonumber(self.FirstStation) or -1)
			Train:SetNWInt("PAM:Line",self.Line)
			Train:SetNWInt("PAM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 7 then
			Train:SetNWInt("PAM:State6",self.State6Choose)
			Train:SetNWBool("PAM:State6Error",self.State6Error)
			Train:SetNWInt("PAM:LastStation",tonumber(self.LastStation) or -1)
			Train:SetNWInt("PAM:Line",self.Line)
			Train:SetNWInt("PAM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
			--Train:SetNWInt("PAM:LastStation",tonumber(self.LastStation) or -1)
			--Train:SetNWInt("PAM:Line",self.Line)
			--Train:SetNWInt("PAM:RouteNumber",tonumber(self.RouteNumber ~= "" and self.RouteNumber or -1))
		elseif self.State == 9 then
			Train:SetNWInt("PAM:Line",self.Line)
			Train:SetNWInt("PAM:Path",self.Train.UPO.Path)
			Train:SetNWInt("PAM:Station",self.State9 == 0 and 0 or self.Train.UPO.Station)
			Train:SetNWInt("PAM:LastStation",self.LastStation)
			Train:SetNWInt("PAM:Distance",math.Round(self.Train.UPO.Distance,2))
			Train:SetNWString("PAM:SName",ARS.Signal and ARS.Signal.RealName or "ERR")
			Train:SetNWBool("PAM:RR",self.Train.KV.ReverserPosition ~= 0)
			Train:SetNWInt("PAM:Type",(self.Train.Pneumatic.EmergencyValveEPK and 0 or self.Train.ALS_ARS.UAVAContacts and 4 or self.UOS and 5 or self.VRD and 2 or (self.Train.Autodrive.AutodriveEnabled or self.Train.UPO.StationAutodrive) and 1 or 3))
			Train:SetNWInt("PAM:KV",self.Train.Autodrive.AutodriveEnabled and (self.Rotating and -3 or self.Brake and -1 or self.Accelerate and 3 or 0) or (ARS["33G"] > 0 or (self.UOS and (ARS["8"] + (1-self.Train.RPB.Value)) > 0)) and 5 or self.Train.KV.RealControllerPosition)
			Train:SetNWBool("PAM:VZ1", self.Train:ReadTrainWire(29) > 0)
			Train:SetNWBool("PAM:VZ2", self.Train.PneumaticNo2.Value > 0)
			Train:SetNWBool("PAM:Menu", self.MenuChoosed or 0)
			Train:SetNWBool("PAM:Ann",self.AnnChoosed)
			Train:SetNWInt("PAM:NeedConfirm",self.NeedConfirm)
			Train:SetNWInt("PAM:BoardTime",math.floor((Train.UPO.BoardTime or CurTime()) - CurTime()))
			Train:SetNWBool("PAM:KD",self.KD)
			Train:SetNWBool("PAM:LPT",self.LPT)
			self.Train:SetNWBool("PAM:Nakat",self.Nakat)
			if self.Nakat then
				self.Train:SetNWFloat("PAM:Meters",math.Round(math.abs(self.Meters or 0),2))
				self.Train:SetNWBool("PAM:Sign",ARS.Speed > 0.5 and self.Train.SpeedSign < 0)
			end
			self.Train:SetNWInt("PAM:Fix",self.Fix or -1)
			self.Train:SetNWInt("PAM:Zon",self.Zon or -1)
			if self.Fix or self.Zon then
				Train:SetNWInt("PAM:FLine",self.FLine or -1)
				Train:SetNWInt("PAM:FStation",tonumber(self.EnteredStation) or -1)
				Train:SetNWInt("PAM:FAc",tonumber(self.FStation) or -1)
				Train:SetNWBool("PAM:State6Error",self.State6Error)
			end
				
		else
		end
	end
	if Train.VZP.Value > 0.5 then
		Train.Autodrive:Enable()
	end
	self.RouteNumber = string.gsub(Train.RouteNumber or "","^(0+)","")
	self.Line = Train.UPO.Line
	self.FirstStation = tostring(Train.UPO.FirstStation or "")
	self.LastStation = tostring(Train.UPO.LastStation or "")
	self.RealState = self.State
end
