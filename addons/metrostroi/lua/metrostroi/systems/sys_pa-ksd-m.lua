--------------------------------------------------------------------------------
-- ПА-М Поездная Аппаратура Модифицированная
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("PA-KSD-M")
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
	self.Pass = "987123"
	self.EnteredPass = ""
	self.Timer = CurTime()
	self.Line = 1
	self.State = 0
	self.RealState = 99
	self.RouteNumber = ""
	self.FirstStation = ""
	self.LastStation = ""
	self.AutodriveEnabled = false
	self.KSZD = false
	self.AutoTimer = false
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
		[4]  = "RR0",
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
		[1] = "проверка наката",
		[5] = "движение с Vф=0"
	}
	self.AutodriveEnabled = false
	self.KSZD = false
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
end

if TURBOSTROI then return end
function TRAIN_SYSTEM:Inputs()
	return {  "Press" }
end

if CLIENT then
	surface.CreateFont("Metrostroi_PAMBig", {
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
	surface.CreateFont("Metrostroi_PAMBig1", {
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
	surface.CreateFont("Metrostroi_PAMSpeed", {
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
	
	surface.CreateFont("Metrostroi_PAMInd", {
	  font = "Arial",
	  size = 30,
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
	surface.CreateFont("Metrostroi_PAMSmall", {
	  font = "Arial",
	  size = 30,
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
	surface.CreateFont("Metrostroi_PAMSmall1", {
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
	surface.CreateFont("Metrostroi_PAMSmall2", {
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
	surface.CreateFont("Metrostroi_PAMSmall3", {
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
	
	surface.CreateFont("Metrostroi_PAMPass", {
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
		surface.DrawRect(x+2,y+2,w-5,h-5)
	end

	function TRAIN_SYSTEM:PAM(train)
		local Announcer = self.Train.Announcer
		surface.SetAlphaMultiplier(1)
		draw.NoTexture()

		if train:GetNWInt("PAM:State",-1) ~= -1 then
			surface.SetDrawColor(Color(225,225,225,2))
			surface.DrawRect(0,0,512,425)
		end
		if train:GetNWInt("PAM:State",-1) == -2 then
			if not self.BSODTimer then self.BSODTimer = CurTime() end
			surface.SetDrawColor(Color(0,0,172))
			surface.DrawRect(0,0,512,425)
			
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
			if CurTime()%0.4 > 0.2 then draw.SimpleText("_","Metrostroi_PAMBig",5, 0,Color(150,150,150,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM) end
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
			
			draw.SimpleText("НИИ Фабрики SENT","Metrostroi_PAMBig",256, 100,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Терминал машиниста (ПА-М)","Metrostroi_PAMBig",256, 130,Color(0,155,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
		end
			
		if train:GetNWInt("PAM:State",-1) == 3 then
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			
			draw.SimpleText("НАЧАЛЬНЫЙ ТЕСТ ЗАКОНЧЕН","Metrostroi_PAMBig",256, 30,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			Metrostroi.DrawRectOutline(10, 80, 492, 210,Color(20,20,20),3 )

			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(17,70,180,20)
			draw.SimpleText("РЕЗУЛЬТАТЫ","Metrostroi_PAMBig",22, 80,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			draw.SimpleText("Начальный тест","Metrostroi_PAMBig",60, 125,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("норма","Metrostroi_PAMBig",480, 125,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Начальная установка","Metrostroi_PAMBig",60, 165,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("норма","Metrostroi_PAMBig",480, 165,Color(110,172,95),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Версия ПО БЦВМ     =     0.3","Metrostroi_PAMBig",80, 245,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			if not train:GetNWBool("PAM:RR",false) then
				draw.SimpleText("Вставьте реверсивную рукоятку","Metrostroi_PAMBig",10, 320,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Для ввода кода доступа","Metrostroi_PAMBig",10, 320,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(100, 345, 75, 30,Color(20,20,20),3 ,Color(230,230,2300))
				draw.SimpleText("нажми Enter","Metrostroi_PAMBig",10, 360,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
		end
		if train:GetNWInt("PAM:State",-1) == 4 then
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 80, 492, 170,Color(20,20,20),3 )
			if train:GetNWInt("PAM:Pass",0) == -1 then
				draw.SimpleText("ОШИБКА ДОСТУПА","Metrostroi_PAMBig",256, 160,Color(200,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("Введи код доступа в систему","Metrostroi_PAMBig",256, 130,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				if train:GetNWInt("PAM:Pass",0) > 0 then
					Metrostroi.DrawRectOL(241 - train:GetNWInt("PAM:Pass",0)*12, 165, 30 + train:GetNWInt("PAM:Pass",0)*24, 40,Color(20,20,20),3,Color(230,230,2300))
					draw.SimpleText(string.rep("*",train:GetNWInt("PAM:Pass",0)),"Metrostroi_PAMPass",256, 200,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
			
			Metrostroi.DrawRectOL(190, 330, 135, 40,Color(20,20,20),3,Color(230,230,2300) )
			draw.SimpleText("Для ввода нажми","Metrostroi_PAMBig",256, 300,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("ENTER","Metrostroi_PAMBig",256, 350,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
		end
		if train:GetNWInt("PAM:State",-1) == 5 then
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			draw.SimpleText("Депо. Начальное меню.","Metrostroi_PAMBig",256, 30,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 80, 492, 333,Color(20,20,20),3)
			
			Metrostroi.DrawRectOL(40, 166 + (not train:GetNWBool("PAM:Restart") and 40 or 0), 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State5",1) == 1 and Color(150,255,248) or Color(230,230,230))

			draw.SimpleText("Выход на линию","Metrostroi_PAMBig",60, 186 + (not train:GetNWBool("PAM:Restart") and 40 or 0),Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:Restart") then
				Metrostroi.DrawRectOL(40, 216, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State5",1) == 2 and Color(150,255,248) or Color(230,230,230))
				draw.SimpleText("Перезапуск","Metrostroi_PAMBig",60, 236,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			end
			
		end
		if train:GetNWInt("PAM:State",-1) == 6 then
			local Line = self.Train:GetNWInt("PAM:Line",0)
			local FirstStation = self.Train:GetNWInt("PAM:FirstStation",-1)
			local LastStation = self.Train:GetNWInt("PAM:LastStation",-1)
			local RouteNumber = self.Train:GetNWInt("PAM:RouteNumber",-1)
			local tbl = Metrostroi.EndStations
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			draw.SimpleText("Ввод исходных данных","Metrostroi_PAMBig",256, 30,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 50, 492, 367,Color(20,20,20),3 )
			
			Metrostroi.DrawRectOL(40, 60, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State6",1) == 1 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Линия","Metrostroi_PAMBig",45, 80,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Line,"Metrostroi_PAMBig",457, 80,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)

			Metrostroi.DrawRectOL(40, 110, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State6",1) == 2 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Нач. ст.","Metrostroi_PAMBig",45, 130,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][FirstStation] and Metrostroi.AnnouncerData[FirstStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[FirstStation][1]:sub(1,10).." "..FirstStation,"Metrostroi_PAMBig",457, 130,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif FirstStation ~= -1 then
				draw.SimpleText(FirstStation,"Metrostroi_PAMBig",457, 130,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end

			Metrostroi.DrawRectOL(40, 160, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State6",1) == 3 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Кон. ст.","Metrostroi_PAMBig",45, 180,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1]:sub(1,10).." "..LastStation,"Metrostroi_PAMBig",457, 180,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif LastStation ~= -1 then
				draw.SimpleText(LastStation,"Metrostroi_PAMBig",457, 180,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			Metrostroi.DrawRectOL(40, 210, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State6",1) == 4 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Маршрут","Metrostroi_PAMBig",45, 230,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAMBig",457, 230,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			
			Metrostroi.DrawRectOL(40, 260, 432, 40,Color(20,20,20),3,train:GetNWBool("PAM:State6",1) == 5 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Ввод данных","Metrostroi_PAMBig",45, 280,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:State6Error",false) then
				Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText("Ошибка при","Metrostroi_PAMBig",256, 150,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("вводе данных","Metrostroi_PAMBig",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190, 220, 132, 40,Color(20,20,20),3,Color(230,230,230))
				draw.SimpleText("ENTER","Metrostroi_PAMBig",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
				
			
			if train:GetNWInt("PAM:State6",1) == 2 and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
						i = i + 1
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 155, 391, -9 + i*22,Color(20,20,20),3,Color(230,230,230))
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(FirstStation) or FirstStation == -1) then
							draw.SimpleText(v,"Metrostroi_PAMSmall",86, 150+i*22,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAMSmall",465, 150+i*22,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							
							i = i + 1
						end
					end
					Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
				end
			end
			if train:GetNWInt("PAM:State6",1) == 3 and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 205, 391, -9 + i*22,Color(20,20,20),3,Color(230,230,230))
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
							draw.SimpleText(v,"Metrostroi_PAMSmall",86, 200+i*22,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAMSmall",465, 200+i*22,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							
							i = i + 1
						end
					end
					Metrostroi.DrawLine(140, 205, 140, 195 + i*22,Color(20,20,20),3 )
				end
			end
		end
		if train:GetNWInt("PAM:State",-1) == 7 then
			local Line = self.Train:GetNWInt("PAM:Line",0)
			local LastStation = self.Train:GetNWInt("PAM:LastStation",-1)
			local RouteNumber = self.Train:GetNWInt("PAM:RouteNumber",-1)
			local tbl = Metrostroi.EndStations
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			draw.SimpleText("Перезапуск.","Metrostroi_PAMBig",110, 30,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 50, 492, 367,Color(20,20,20),3 )
			
			Metrostroi.DrawRectOL(40, 60, 432, 40,Color(20,20,20),3,train:GetNWInt("PAM:State6",1) == 1 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Линия","Metrostroi_PAMBig",45, 80,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText(Line,"Metrostroi_PAMBig",457, 80,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)


			Metrostroi.DrawRectOL(40, 110, 432, 40,Color(20,20,20),3,train:GetNWInt("PAM:State6",1) == 2 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Кон. ст.","Metrostroi_PAMBig",45, 130,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if tbl[Announcer.AnnMap][Line] and tbl[Announcer.AnnMap][Line][LastStation] and Metrostroi.AnnouncerData[LastStation] then
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1]:sub(1,10).." "..LastStation,"Metrostroi_PAMBig",457, 130,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			elseif LastStation ~= -1 then
				draw.SimpleText(LastStation,"Metrostroi_PAMBig",457, 130,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end

			Metrostroi.DrawRectOL(40, 160, 432, 40,Color(20,20,20),3,train:GetNWInt("PAM:State6",1) == 3 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Маршрут","Metrostroi_PAMBig",45, 180,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if RouteNumber > -1 then draw.SimpleText(RouteNumber,"Metrostroi_PAMBig",457, 180,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			

			Metrostroi.DrawRectOL(40, 210, 432, 40,Color(20,20,20),3,train:GetNWInt("PAM:State6",1) == 4 and Color(150,255,248) or Color(230,230,230))
			draw.SimpleText("Ввод данных","Metrostroi_PAMBig",45, 230,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:State6Error",false) then
				Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText("Ошибка при","Metrostroi_PAMBig",256, 150,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("вводе данных","Metrostroi_PAMBig",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOutline(190, 220, 132, 40,Color(20,20,20),3 )
				draw.SimpleText("ENTER","Metrostroi_PAMBig",256, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end

			if train:GetNWInt("PAM:State6",1) == 2 and tbl[Announcer.AnnMap][Line] then
				local i = 1
				for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
					if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
						i = i + 1
					end
				end
				if i > 1 then
					Metrostroi.DrawRectOL(80, 155, 391, -9 + i*22,Color(20,20,20),3,Color(230,230,230) )
					local i = 1
					for k,v in pairs(tbl[Announcer.AnnMap][Line]) do
						if Metrostroi.AnnouncerData[v] and (tostring(v):find(LastStation) or LastStation == -1) then
							draw.SimpleText(v,"Metrostroi_PAMSmall",86, 150+i*22,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
							draw.SimpleText(Metrostroi.AnnouncerData[v][1],"Metrostroi_PAMSmall",465, 150+i*22,Color(0,0,0,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
							
							i = i + 1
						end
					end
					Metrostroi.DrawLine(140, 155, 140, 145 + i*22,Color(20,20,20),3 )
				end
			end
		end
		if train:GetNWInt("PAM:State",-1) == 8 then
			surface.SetDrawColor(Color(180,180,180))
			surface.DrawRect(0,0,512,425)
			draw.SimpleText("Проверка состава","Metrostroi_PAMBig",10, 30,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("перед выходом на линию","Metrostroi_PAMBig",10, 70,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--elf.Train:GetNWInt("PAM:Pass",0) ~= -1 and string.rep("*",self.Train:GetNWInt("PAM:Pass",0)) or "ACCESS ERROR"
			Metrostroi.DrawRectOutline(10, 100, 492, 210,Color(20,20,20),3 )
			draw.SimpleText("Для перехода в рабочий режим","Metrostroi_PAMBig",60, 170,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			Metrostroi.DrawRectOL(240, 225, 100, 30,Color(20,20,20),3,Color(230,230,230))
			draw.SimpleText("нажми              ENTER","Metrostroi_PAMBig",60, 240,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Проверка состава разрешена","Metrostroi_PAMBig",256, 365,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
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
			draw.SimpleText(Format("%02d:%02d:%02d",date.hour,date.min,date.sec),"Metrostroi_PAMSmall1",59, 30,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("Линия "..Line,"Metrostroi_PAMSmall",120, 30,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			if Station > 0 then
				draw.SimpleText("до "..Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAMSmall1",508, 10,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				if Metrostroi.AnnouncerData[Station] then draw.SimpleText(Metrostroi.AnnouncerData[Station][1],"Metrostroi_PAMSmall1",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER) end
			else
				draw.SimpleText("выход на линию","Metrostroi_PAMSmall1",508, 13,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Metrostroi.AnnouncerData[LastStation][1],"Metrostroi_PAMSmall1",508, 30,Color(212,212,212),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText("Путь "..Path,"Metrostroi_PAMSmall",240, 30,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
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
				if i%2 == 0 then
					draw.SimpleText(i*10,"Metrostroi_PAMSmall",10 + i*40, 135,Color(74,74,74),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				end
			end
			draw.SimpleText(speed,"Metrostroi_PAMBig1",480, 85,Color(110,172,95),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText(spd,"Metrostroi_PAMBig1",480, 120,(spd == "НЧ" and 20 or spd) > 20 and Color(254,237,142) or  Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			draw.SimpleText("S = "..S,"Metrostroi_PAMBig",6, 401,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Рц = "..train:GetNWString("PAM:SName",""),"Metrostroi_PAMBig",240, 401,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			
			surface.SetDrawColor(Color(180,180,180))
			if not train:GetNWBool("PAM:RR",false) then
				surface.DrawRect(6,295,490,21)
				draw.SimpleText("Установи РР","Metrostroi_PAMInd",251, 305,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			surface.DrawRect(6,320,100,24)  surface.DrawRect(171,320,36,24) surface.DrawRect(212,320,54,24) --surface.DrawRect(266,320,40,20)
			draw.SimpleText(self.Types[train:GetNWBool("PAM:Type",false)].."="..self.Positions[train:GetNWBool("PAM:KV",false)],"Metrostroi_PAMInd",56, 330,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			if train:GetNWBool("PAM:VZ1",false) or train:GetNWBool("PAM:VZ2",false) then
				surface.DrawRect(111,320,55,24)
				draw.SimpleText(train:GetNWBool("PAM:VZ1",false) and (train:GetNWBool("PAM:VZ2",false) and "В12" or "В1") or "В2","Metrostroi_PAMInd",111 + 55/2, 330,Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			draw.SimpleText("КД","Metrostroi_PAMInd",171+35/2, 330,train:GetPackedBool(40) and Color(20,20,20) or Color(200,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			draw.SimpleText("ЛПТ","Metrostroi_PAMInd",239, 330,train:GetPackedBool("PN") and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

			surface.DrawRect(6,355,100,21)-- surface.DrawRect(111,355,100,20) surface.DrawRect(215,355,50,20)
			draw.SimpleText("КВ АРС","Metrostroi_PAMInd",56, 365,train:GetPackedBool(48) and Color(200,0,0) or Color(20,20,20),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			
			Metrostroi.DrawRectOutline(370, 320, 130, 60,Color(110,172,95),3 )
			draw.SimpleText("Тпр. "..(self.Train:GetPackedRatio(3)*100.0 > 0.25 and math.min(999,math.floor(S/(speed*1000/3600))) or "inf"),"Metrostroi_PAMSmall2",375, 330,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			--draw.SimpleText("Na   =","Metrostroi_PAMSmall2",375, 347.5,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
			draw.SimpleText("Тост = "..train:GetNWInt("PAM:BoardTime",0),"Metrostroi_PAMSmall2",375, 365,Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			if train:GetNWInt("PAM:Menu",0) > 0 then
				Metrostroi.DrawRectOutline(50, 150, 385, 24*8,Color(160,160,160), 3)
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(51,151,382,24*8-4)
				surface.SetDrawColor(Color(200,200,200))
				surface.DrawRect(51,127 + train:GetNWInt("PAM:Menu",0)*24,382,23)
				
				for i = 1,7 do
					Metrostroi.DrawLine(50,150+24*i,435,150+24*i,Color(160,160,160),3)
				end
				draw.SimpleText("Проверка наката","Metrostroi_PAMSmall3",256, 162,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(train:GetNWBool("PAM:KD") and "Движение с КД" or "Движение без КД","Metrostroi_PAMSmall3",256, 186,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Смена настроек","Metrostroi_PAMSmall3",256, 210,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Движение транзитом","Metrostroi_PAMSmall3",256, 234,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Движение с  Vд = 0","Metrostroi_PAMSmall3",256, 258,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Зонный оборот","Metrostroi_PAMSmall3",256, 282,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Фиксация станции","Metrostroi_PAMSmall3",256, 306,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Station mode","Metrostroi_PAMSmall3",256, 330,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
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
				draw.SimpleText("Просьба выйти из вагонов","Metrostroi_PAMSmall3",256, 162,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Заходите и выходите быстрее","Metrostroi_PAMSmall3",256, 186,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Отпустите двери","Metrostroi_PAMSmall3",256, 210,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Поезд скоро отправится","Metrostroi_PAMSmall3",256, 234,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWInt("PAM:NeedConfirm",0) > 0 then
				Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText("ПОДТВЕРДИ","Metrostroi_PAMBig",256, 150,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.Questions[train:GetNWInt("PAM:NeedConfirm",0)].."?","Metrostroi_PAMBig",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190-70, 220, 132, 40,Color(20,20,20),2,Color(230,230,230))
				draw.SimpleText("ENTER","Metrostroi_PAMBig",256-70, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				Metrostroi.DrawRectOL(190+70, 220, 132, 40,Color(20,20,20),2,Color(230,230,230))
				draw.SimpleText("ESC","Metrostroi_PAMBig",256+70, 240,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			if train:GetNWBool("PAM:Nakat") then
				Metrostroi.DrawRectOutline(106, 125, 300, 150,Color(20,20,20),3 )
				surface.SetDrawColor(Color(180,180,180))
				surface.DrawRect(108, 127, 295, 146 )
				draw.SimpleText("Проверка наката","Metrostroi_PAMBig",256, 140,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("Расстояние: ","Metrostroi_PAMBig",111, 170,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(Format("%.2f",self.Train:GetNWFloat("PAM:Meters",0)),"Metrostroi_PAMBig",300, 170,Color(254,237,142),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText("Направление: ","Metrostroi_PAMBig",111, 200,Color(0,0,0,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				draw.SimpleText(self.Train:GetNWBool("PAM:Sign",false) and "Назад" or "Вперёд","Metrostroi_PAMBig",300, 200,self.Train:GetNWBool("PAM:Sign",false) and Color(200,0,0) or Color(110,172,95),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
				--draw.SimpleText(self.Questions[train:GetNWInt("PAM:NeedConfirm",0)].."?","Metrostroi_PAMBig",256, 180,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
				
		end
		surface.SetAlphaMultiplier(1)
	end
	function TRAIN_SYSTEM:ClientThink()
	end
end

function TRAIN_SYSTEM:AnnNotLast(path)
	local Announcer = self.Train.Announcer
    return 	self:GetSTNum(self.Last) > 1
end
function TRAIN_SYSTEM:GetSTNum(station)
	local Announcer = self.Train.Announcer
	local station = tonumber(station)
	if not Metrostroi.WorkingStations[Announcer.AnnMap] then return 0 end
	if not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line] then return 0 end
	if not Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][station] and station ~= 120 then return 0 end
	return station == 120 and 12 or Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][station]
end
function TRAIN_SYSTEM:AnnEnd(station,path,next)
	if not station or station == 0 then return true end
	if next then
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) > self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) > self:GetSTNum(self.LastStation)) and path == 1)),Metrostroi.AnnouncerData[station][9]
	else
		return (not Metrostroi.AnnouncerData[station][9])
			and (((self:GetSTNum(self.LastStation) >= self:GetSTNum(station) or self:GetSTNum(station) > self:GetSTNum(self.FirstStation)) and path == 2)
			or ((self:GetSTNum(self.FirstStation) < self:GetSTNum(station) and self:GetSTNum(station) >= self:GetSTNum(self.LastStation)) and path == 1))
	end
end

function TRAIN_SYSTEM:AnnPlayArriving(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if self:AnnEnd(station,path) then
		Announcer:PlayInfQueueSounds(0230,0222,0002,0221,station)
		if Metrostroi.AnnouncerData[station][2] then
			Announcer:PlayInfQueueSounds(0215)
		end
		--Announcer:PlayInfQueueSounds(0006)
		self.AnnState = 7
		Announcer:PlayInfQueueSounds(0006)
		return
	end

	Announcer:PlayInfQueueSounds(Metrostroi.AnnouncerData[station][6] and 0220 or nil,station)
	if Metrostroi.AnnouncerData[station][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[station][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[station][7]] and 0203 or nil,Metrostroi.AnnouncerData[station][7])
	end

	if Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end

	if nextNonWorkingStation then
		Announcer:PlayInfQueueSounds(0230,nextNonWorkingStation)
	end
	Announcer:PlayInfQueueSounds(0002,0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end

	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:PlayInfQueueSounds(0006)
end

function TRAIN_SYSTEM:AnnPlayDepeate(station,next,path)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if self:AnnNotLast(path) then
		Announcer:PlayInfQueueSounds(0210,path == 1 and self.LastStation or self.FirstStation,0002)
	elseif Metrostroi.AnnouncerData[station][8] and path == Metrostroi.AnnouncerData[station][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation,0002)
	end
	Announcer:PlayInfQueueSounds(0218)

	if self.NextNonWorkingStation then
		Announcer:PlayInfQueueSounds(0230,self.NextNonWorkingStation)
	end
	Announcer:PlayInfQueueSounds(0219,next)
	if Metrostroi.AnnouncerData[next][2] then
		Announcer:PlayInfQueueSounds(0215)
	end

	if Metrostroi.AnnouncerData[next][7] > 0 then
		Announcer:PlayInfQueueSounds(0202,Metrostroi.AnnouncerData[Metrostroi.AnnouncerData[next][7]] and 0203 or nil,Metrostroi.AnnouncerData[next][7])
	end
	if Metrostroi.AnnouncerData[next][8] and path == Metrostroi.AnnouncerData[next][8] then
		Announcer:PlayInfQueueSounds(0230,0233,0210,path == 1 and self.LastStation or self.FirstStation)
	end
    Announcer:PlayInfQueueSounds(0006)
end
function TRAIN_SYSTEM:AnnII(ann)
	local Announcer = self.Train.Announcer
    Announcer:PlayInfQueueSounds(0005,0003)
	if ann == 1 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0207 or 0206)
	elseif ann == 2 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0209 or 0208)
	elseif ann == 3 then
		Announcer:PlayInfQueueSounds(math.random() > 0.5 and 0204 or 0205)
	else
		if not self.AnnIIalr then
			Announcer:PlayInfQueueSounds(self.Type == 1 and 0229 or 0217)
			self.AnnIIalr = true
		else
			Announcer:PlayInfQueueSounds(0228)
			self.AnnIIalr = false
		end
	end
    Announcer:PlayInfQueueSounds(0006)
end

local function GetStationRK(mu,dX)
	-- Calculate RK position based on distance and autodrive profile
	local TargetBrakeRKPosition = 1
	if dX < 160+35*mu   then TargetBrakeRKPosition = 1 end
	if dX < 70+35+25*mu then TargetBrakeRKPosition = 3 end
	if dX < 50+30+20*mu then TargetBrakeRKPosition = 5 end
	if dX < 20+25+15*mu then TargetBrakeRKPosition = 9 end
	if dX < 10+20+10*mu then TargetBrakeRKPosition = 12 end
	if dX < 15          then TargetBrakeRKPosition = 13 end
	if dX < 12    	    then TargetBrakeRKPosition = 15 end
	if dX <  8          then TargetBrakeRKPosition = 16 end
	if dX <  5          then TargetBrakeRKPosition = 17 end
	if dX <  1          then TargetBrakeRKPosition = 18 end
	return TargetBrakeRKPosition
end

local mu = -0.25
function TRAIN_SYSTEM:Autodrive(StationBraking)
	local Train= self.Train
	-- Calculate distance to station
	local dX = Train:ReadCell(49165) + (self.Corrections[self.Station] or 0) - 4.3
	local speedLimit = (Train.ALS_ARS.Signal0 or Train.ALS_ARS.RealNoFreq) and 0 or Train.ALS_ARS.Signal40 and 40 or Train.ALS_ARS.Signal60 and 60 or Train.ALS_ARS.Signal70 and 70 or Train.ALS_ARS.Signal80 and 80 or 0
	local OnStation = dX < (160+35*mu - (speedLimit == 40 and 30 or 0)) and not self.StartMoving and Metrostroi.AnnouncerData[self.Station]and Metrostroi.AnnouncerData[self.Station][1]
	if StationBraking and (dX >= (160+35*mu - (speedLimit == 40 and 30 or 0)) or not OnStation) then self.StationAutodrive = false return end
	--print(Train:ReadCell(49165) + (Corrections[self.Station] or 0) - 4.3)
	-- Target and real RK position (0 if not braking)
	local TargetBrakeRKPosition = 0

	local RKPosition = math.floor(Train.RheostatController.Position+0.5)

	-- Calculate next speed limit

	-- Get angle
	local Slope = Train:GetAngles().pitch

	-- Check speed constraints
	if Train.ALS_ARS.Speed > (speedLimit - 6) then self.NoAcceleration = true end
	if Train.ALS_ARS.Speed < (speedLimit - 10) then self.NoAcceleration = false end

	local Brake = false
	local Accelerate = false

	local threshold = 1.0 + (Slope > 1 and 1 or 0)

	-- Slow down on slopes
	if Train.ALS_ARS.Speed > speedLimit - 5 - (self.NoAcceleration and 4 or 7) then
		if Slope > 1 then
			if speedLimit == 40 then
				TargetBrakeRKPosition = 7
			elseif speedLimit > 40  then
				TargetBrakeRKPosition = 1
				Brake = (Train.ALS_ARS.Speed > speedLimit - 4)
			end
		end
	end

	-- Slow down if overspeeding soon
	if (Train.ALS_ARS.Speed > (speedLimit - threshold)) then
		TargetBrakeRKPosition = 18
	end

	-- How smooth braking should be (higher mu = more gentle braking)
	-- Full stop command
	if Train.ALS_ARS.SpeedLimit < 30 then TargetBrakeRKPosition = 18 Brake = true end

	-- Calculate RK position based on distance and autodrive profile
	if OnStation then
		TargetBrakeRKPosition = GetStationRK(mu, dX)
	else
		if dX > (160+35*mu - (speedLimit == 40 and 30 or 0)) then self.StartMoving = nil end
	end

	-- Generate commands
	local ElectricBrakeActive = FullStop or TargetBrakeRKPosition > 0
	local AcceleratingActive = not ElectricBrakeActive and not self.NoAcceleration and Slope <  1

	-- Generate brake rheostat rotation
	local RheostatBrakeRotating = Brake or RKPosition < TargetBrakeRKPosition
	-- Generate accel rheostat rotation
	local PP = math.floor(Train.PositionSwitch.Position + 0.5) == 2
	--print(Train.Electric.Itotal,RKPosition)
	local AmpNorm = true --Train.Electric.Itotal < (350 - (Train:GetPhysicsObject():GetMass()-30000)/24) * math.floor(Train.PositionSwitch.Position + 0.5)
	local RheostatAccelRotating = AcceleratingActive
	--	print(math.floor(Train.PositionSwitch.Position + 0.5) , RKPosition , Train.Electric.Itotal)
	if Slope < -2 and (math.floor(Train.PositionSwitch.Position + 0.5) == 2 and RKPosition == 10 and Train.Electric.Itotal > 500) then
		--if PP and (8 <= RKPosition and RKPosition <= 12) then
			RheostatAccelRotating = false
		--end
	end
	local PneumaticValve1 = ((dX < 1.55) and (Train.ALS_ARS.Speed > 0.1) and OnStation and TargetBrakeRKPosition == 18) or (Train.ALS_ARS.Speed > (Train.ALS_ARS.SpeedLimit - threshold))
	--or (Train:ReadCell(6) > 0 and Train:ReadCell(18) < 1 and Slope > 1)

	--Disable autodrive on end of station brake
	--local StatID = Metrostroi.WorkingStations[self.Station] or Metrostroi.WorkingStations[self.Station + (self.Path == 1 and 1 or -1)] or 0

	if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) or (self.StartMoving and 10 < dX and dX < 160) then
		if (TargetBrakeRKPosition == 18 and Train.ALS_ARS.Speed < 0.1 and not self.StartMoving and OnStation) then
			self.StationAutodrive = false
			--print("Stopped on "..Curr[1]..", "..(Curr[2] and "right side" or "left side")..", next station is "..(Next and (Next[1]..", "..(Next[2] and "right side" or "left side")) or "nil"))

			--
			--self.VUDOverride = true

			--local self.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
			if self.Station == 0 then return end
			--local StatID = Metrostroi.WorkingStations[self.Station] or Metrostroi.WorkingStations[self.Station + (self.Path == 1 and 1 or -1)] or 0
			if GetConVarNumber("metrostroi_paksd_autoopen",0) > 0 and not StationBraking then
				local Curr = Metrostroi.AnnouncerData[self.Station]
				if Curr[2] then
					Train:WriteCell(32,1)
				else
					Train:WriteCell(31,1)
				end
				timer.Simple(0.1,function()
					if not IsValid(Train) then return end
					Train:WriteCell(32,0)
					Train:WriteCell(31,0)
				end)
				Train.PAKSD_DOOR:TriggerInput("Set",1)
			end
		end
		self.AutodriveReset = true
		return
	end

	-- Enter commands
	--Train:WriteCell(1, AcceleratingActive and 1 or 0) --Engage engines
	--Train:WriteCell(2, (RheostatAccelRotating or (ElectricBrakeActive and (RheostatBrakeRotating or RKPosition == 18 and not OnStation))) and 1 or 0) --X2/T2
	--Train:WriteCell(3, (Train.ALS_ARS.Speed > 30 and RheostatAccelRotating) and 1 or 0) --X3
	--Train:WriteCell(6, ElectricBrakeActive and 1 or 0) --Engage brakes
	--Train:WriteCell(20,(ElectricBrakeActive or not self.NoAcceleration) and 1 or 0) -- Engage power circuits
	local KVPos = 0
	if ElectricBrakeActive then
		if (RheostatBrakeRotating or RKPosition == 18 and not OnStation) and not Train:GetPackedBool(35) then
			KVPos = -3
		else
			KVPos = -1
		end
	elseif AcceleratingActive then
		if Train.ALS_ARS.Speed > 30 and RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 3
		elseif RheostatAccelRotating and not Train:GetPackedBool(35) then
			KVPos = 2
		else
			KVPos = 1
		end
	end
	if (KVPos == -1) and Train:GetPackedBool(35) then
		if not self.VZTimer1 then self.VZTimer1 = CurTime() + 1 end
	else
		self.VZTimer1 = nil
	end
	if self.VZTimer1 and self.VZTimer1 < CurTime() then
		PneumaticValve1 = true
	end
	if OnStation then
		self.Train.R25p:TriggerInput("Set",self.OldRheostatBrakeRotating ~= RheostatBrakeRotating)
		self.OldRheostatBrakeRotating = RheostatBrakeRotating	
	end
	Train:WriteCell(29, PneumaticValve1 and 1 or 0) -- Engage PN1
	Train:TriggerInput("KVControllerAutodriveSet",KVPos)
	--Train:WriteCell(25,(ElectricBrakeActive and self.TargetBrakeRKPosition > 17) and 1 or 0) -- Engage power circuits
	Train:WriteCell(17,1)
	timer.Simple(0.1,function()
		if not IsValid(Train) then return end
		Train:WriteCell(17,0)
	end)
	self.Brake = ElectricBrakeActive
	self.Accelerate = AcceleratingActive
	self.Rotating = RheostatBrakeRotating and true or RheostatAccelRotating and false or nil
end

function TRAIN_SYSTEM:ReloadSigns()
	self.Train:PrepareSigns()
	if self.Train.SignsList[tonumber(self.LastStation)] then
		self.Train.SignsIndex = self.Train.SignsList[tonumber(self.LastStation)] or 1
		self.Train:SetNWString("FrontText",self.Train.SignsList[self.Train.SignsIndex])
	end
	if #self.Train.WagonList > 1 then
		local LastTrain = self.Train.Announcer:GetLastWagon()
		LastTrain:PrepareSigns()
		if LastTrain.SignsList[tonumber(self.FirstStation)] then
			LastTrain.SignsIndex = self.Train.SignsList[tonumber(self.FirstStation)] or 1
			LastTrain:SetNWString("FrontText",self.Train.SignsList[self.Train.SignsIndex])
		end
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
			if Char and #self.EnteredPass < 6 then self.EnteredPass = self.EnteredPass..tonumber(name:sub(2,2)) end
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
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		if name == "BEnter" and self.State6Choose == 5 then
			if not Metrostroi.EndStations[Announcer.AnnMap][self.Line] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.FirstStation)] or 
				not Metrostroi.AnnouncerData[tonumber(self.FirstStation)] or
				not Metrostroi.EndStations[Announcer.AnnMap][self.Line][tonumber(self.LastStation)] or 
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
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][self.Line]
					self.FirstStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength])
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
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		self:ReloadSigns()
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
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
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
						v["PA-M"].Line = self.Line 
						v["PA-M"].RouteNumber = self.RouteNumber
						v["PA-M"].FirstStation = self.FirstStation
						v["PA-M"].LastStation = self.LastStation
					end
				end
			end
		end
		local Char = tonumber(name:sub(2,2))
		if Char then
			if self.State6Choose == 1 then
				self.Line = Char
				if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
					local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][self.Line]
					self.FirstStation = self.FirstStation ~= "" and self.FirstStation or tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
					self.LastStation = tostring(Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength])
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
				self.Train:OnButtonPress("RouteNumberUpdate",self.RouteNumber)
			end
		end
		self:ReloadSigns()
	elseif self.State == 8 then
		if name == "BEnter" and self.Check == false then
			self:SetState(9)
		end
	elseif self.State == 9 then
		if name == "BF" then
			if self.MenuChoosed == 0 and self.AnnChoosed == 0 then
				self.MenuChoosed = 1
			end
		end
		if name == "BDown" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.min(8,self.MenuChoosed + 1)

				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BDown",true)
				elseif self.MenuChoosed == 6 then
					if self.LastStation == tostring(self.Station) then
						self:Trigger("BDown",true)
					end
				elseif self.MenuChoosed == 7 then
					if self.FirstStation == tostring(self.Station) then
						self:Trigger("BDown",true)
					end
				end
			end
			if self.AnnChoosed ~= 0 then
				self.AnnChoosed = math.min(4,self.AnnChoosed + 1)
			end
		end
		if name == "BUp" then
			if self.MenuChoosed ~= 0 and (not self.NeedConfirm or self.NeedConfirm == 0) then
				self.MenuChoosed = math.max(1,self.MenuChoosed - 1)
				if self.MenuChoosed == 5 and (self.VRD or not (self.Train.ALS_ARS.Signal0 and not self.Train.ALS_ARS.RealNoFreq and not self.Train.ALS_ARS.Signal40 and not self.Train.ALS_ARS.Signal60 and not self.Train.ALS_ARS.Signal70 and not self.Train.ALS_ARS.Signal80)) then
					self:Trigger("BUp",true)
				elseif self.MenuChoosed == 6 then
					if self.LastStation == tostring(self.Station) then
						self:Trigger("BUp",true)
					end
				elseif self.MenuChoosed == 7 then
					if self.FirstStation == tostring(self.Station) then
						self:Trigger("BUp",true)
					end
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
				self.NeedConfirm = 0
				self.MenuChoosed = 0
			end
			if name == "BEsc" then
				self.NeedConfirm = 0
			end
		end
		if self.MenuChoosed ~= 0  then
			if name == "BEnter" and (not self.NeedConfirm or self.NeedConfirm == 0) then
				if self.MenuChoosed == 1 and self.Train.Speed < 0.5 then
					self.NeedConfirm = 1
				elseif self.MenuChoosed == 2 then
					self.KD = not self.KD
				elseif self.MenuChoosed == 4 then
					self.Transit = not self.Transit
					self.AutodriveWorking = false
				elseif self.MenuChoosed == 5 then
					self.NeedConfirm = 5
				elseif self.MenuChoosed == 6 then
				elseif self.MenuChoosed == 7 then
				elseif self.MenuChoosed == 8 and not self.Arrived then
					--self.Arrived = true
					--if self.Train.R_UPO.Value > 0 then
--						local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
						--self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
					--end
				end
				if self.NeedConfirm == 0 then self.MenuChoosed = 0 end
				--if self.State > 6 and self.State ~= 76 and self.State ~= 77 then self.State = 7 end
			end
		end
		if self.AnnChoosed ~= 0 then
			if name == "BEnter" then
				if self.Train.R_UPO.Value > 0 then self:AnnII(self.AnnChoosed) end
				self.AnnChoosed = 0
			end
			local Char = tonumber(name:sub(2,2))
			if Char and Char > 0 and Char < 5 and self.Train.R_UPO.Value > 0 then
				self:AnnII(Char)
				self.AnnChoosed = 0
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
		if Metrostroi.EndStations[Announcer.AnnMap][self.Line] then
			local Routelength = #Metrostroi.EndStations[Announcer.AnnMap][self.Line]
			self.FirstStation = tostring(self.Path == 2 and Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength] or Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
			self.LastStation = tostring(self.Path == 1 and Metrostroi.EndStations[Announcer.AnnMap][self.Line][Routelength] or Metrostroi.EndStations[Announcer.AnnMap][self.Line][1])
		else
			self.FirstStation = "111"
			self.LastStation = "123"
		end
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
					v["PA-M"].Line = self.Line 
					v["PA-M"].RouteNumber = self.RouteNumber
					v["PA-M"].FirstStation = self.FirstStation
					v["PA-M"].LastStation = self.LastStation
				end
			end
		end
		self.AnnChoosed = 0
		self.NeedConfirm = 0
		self.MenuChoosed = 0
		self.BoardTime = nil
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
	self.Station = self.Train:ReadCell(49160) > 0 and self.Train:ReadCell(49160) or self.Train:ReadCell(49161)
	self.Path = Metrostroi.PathConverter[self.Train:ReadCell(65510)] or 0
	self.Distance = math.min(9999,self.Train:ReadCell(49165) + (self.Corrections[self.Station] or 0) - 4.3)
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
	if self.Train.KV.ReverserPosition == 0 and self.State > 3 and self.State < 9 and self.State ~= -9 then self.State = 3 end
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
			self:SetTimer()
		end
	elseif self.State == 9 then
		if self.VRD and (not ARS.Signal0 or ARS.Signal0 and (ARS.Signal40 or ARS.Signal60 or ARS.Signal70 or ARS.Signal80)) then self.VRD = false end
		if self.Distance > 40 and (self.Distance + (self.Corrections[self.Station] or 0) - 4.3) < (160+35*mu - (ARS.SpeedLimit == 40 and 30 or 0)) then
			self.StationAutodrive = true
		end
		if ARS["33G"] > 0.5 then
			self.AutodriveReset = true
			self.AutodriveWorking = false
		end
		if (self:GetSTNum(self.LastStation) > self:GetSTNum(self.FirstStation) and self.Path == 2) or (self:GetSTNum(self.FirstStation) > self:GetSTNum(self.LastStation)  and self.Path == 1) then
			local old = self.LastStation
			self.LastStation = self.FirstStation
			self.FirstStation = old
			self:ReloadSigns()
		end
		self.State9 = (self:AnnEnd(self.Station,self.Path,true) or self:GetSTNum(self.LastStation) > self:GetSTNum(self.Station) and self.Path == 2 or self:GetSTNum(self.Station) < self:GetSTNum(self.FirstStation) and self.Path == 1) and 0 or 1--self.Arrived ~= nil and 1 or 2
		if self.State9 ~= 0 and self.Train.KV.ReverserPosition ~= 0 then
			if self.RealState == 8 and not self.Transit then
				if self.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Station] and ARS.Speed <= 1 then
					self.Arrived = true
					if self.Train.R_UPO.Value > 0 then
						local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
						self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
					end
				end
			end
			if not self.Transit and 45 < self.Distance and self.Distance < 75 and not self.Arrived and Metrostroi.WorkingStations[Announcer.AnnMap][self.Line][self.Station] then
				self.Arrived = true
				if self.Train.R_UPO.Value > 0 then
					local tbl = Metrostroi.WorkingStations[Announcer.AnnMap][self.Line]
					self:AnnPlayArriving(self.Station,tbl[tbl[self.Station] + (self.Path == 1 and 1 or -1)],self.Path)
				end
			end
			if self.Transit then self.Arrived = nil end
			if self.Distance > 75 then
				self.Arrived = nil
			else
				--if self.Train.Panel.SD < 0.5 then self.Arrived = true end
			end
			if self.Arrived and 	self.Train.Panel.SD < 0.5 and not self.BoardTime then
				self.BoardTime = CurTime() + (self.Train.BoardTime or 0) + (20-(#self.Train.WagonList)*4)  + (self.Train.Horlift and 7 or 0)
				self.Ring = false
			end
			if (self.Arrived == nil or self.Train.Panel.SD > 0.5) and self.BoardTime then
				self.BoardTime = nil
				--self.Ring = nil
			end
			--if (self.Ring == nil or self.Ring == 0) and self.Train.Panel.SD < 0.5 then
				--self.Ring = false
			--end
			if self.Arrived then
				if self.BoardTime and math.floor((self.BoardTime or CurTime()) - CurTime()) < (self.Train.Horlift and 15 or 8) and self.Arrived then
					if not self:AnnEnd(self.Station,self.Path) then

					else
						self.Ring = 2
					end
					self.Arrived = false
				end
			elseif self.Arrived == nil then
				self.Ring = nil
			end
			if self.Ring == false and self.Train.Panel.SD > 0.5 then 
				self.Ring = 1
			end
			if (self.Train:ReadCell(1) > 0 or ARS.Speed > 1) and self.Arrived == false then self.Arrived = nil end
			if self.Train:ReadCell(48) == 218  then
				self.ODZ = true
			end
			if self.ODZ and self.Train:ReadCell(48) ~= 218  then
				self.ODZ = false
				self.Ring = 2
			end
			if self.Ring == 2 and self.Train.Panel.SD > 0.5 then
				self.Ring = 0
			end
			if (self.Ring or self.Ring ~= 0) and ARS.KVT then
				self.Ring = 0
			end
			if self.Ring == 0 and self.Arrived == nil then
				self.Ring = nil
			end
			if (self.Ring and self.Ring > 0) and not ARS.Ring then	
				ARS:TriggerInput("Ring",1)
			end
			if (not self.Ring or self.Ring == 0) and ARS.Ring then	
				ARS:TriggerInput("Ring",0)
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
			Train:SetNWInt("PAM:Path",self.Path)
			Train:SetNWInt("PAM:Station",self.State9 == 0 and 0 or self.Station)
			Train:SetNWInt("PAM:LastStation",self.LastStation)
			Train:SetNWInt("PAM:Distance",math.Round(self.Distance,2))
			Train:SetNWString("PAM:SName",ARS.Signal and ARS.Signal.RealName or "ERR")
			Train:SetNWBool("PAM:RR",self.Train.KV.ReverserPosition ~= 0)
			Train:SetNWInt("PAM:Type",(self.Train.Pneumatic.EmergencyValveEPK and 0 or self.Train.ALS_ARS.UAVAContacts and 4 or self.UOS and 5 or self.VRD and 2 or (self.AutodriveEnabled or self.StationAutodrive) and 1 or 3))
			Train:SetNWInt("PAM:KV",self.Train.KV.ReverserPosition == 0 and 4 or self.AutodriveEnabled and (self.Rotating and -3 or self.Brake and -1 or self.Accelerate and 3 or 0) or (ARS["33G"] > 0 or (self.UOS and (ARS["8"] + (1-self.Train.RPB.Value)) > 0)) and 5 or self.Train.KV.RealControllerPosition)
			Train:SetNWBool("PAM:VZ1", self.Train:ReadTrainWire(29) > 0)
			Train:SetNWBool("PAM:VZ2", self.Train.PneumaticNo2.Value > 0)
			Train:SetNWBool("PAM:Menu", self.MenuChoosed or 0)
			Train:SetNWBool("PAM:Ann",self.AnnChoosed)
			Train:SetNWInt("PAM:NeedConfirm",self.NeedConfirm)
			Train:SetNWInt("PAM:BoardTime",math.floor((self.BoardTime or CurTime()) - CurTime()))
			Train:SetNWBool("PAM:KD",self.KD)
			if self.Nakat then
				self.Train:SetNWFloat("PAM:Meters",math.Round(math.abs(self.Meters or 0),2))
				self.Train:SetNWBool("PAM:Sign",ARS.Speed > 0.5 and self.Train.SpeedSign < 0)
			end
			self.Train:SetNWBool("PAM:Nakat",self.Nakat)
		else
		end
	end
	if Train.VZP then
		if Train.BCCD.Value > 0 then
			Train.PAKSD_DOOR:TriggerInput("Set",0)
		end
		--[[if Train:CPPIGetOwner() and Train:CPPIGetOwner():GetName() ~= "glebqip(RUS)" and (self.AutodriveEnabled or not self.AutodriveReset) then
			self.AutodriveReset = true
		else]]

		if self.AutodriveReset then
			Train:TriggerInput("KVControllerAutodriveSet",4)
			self.NoAcceleration = nil
			if Train.KV.ControllerPosition <= 0.0 then
				Train:WriteCell(1,0)
			end
			if Train.KV.ControllerPosition == 0.0 then
				Train:WriteCell(20,0)
			end
			if Train.KV.ControllerPosition <= 1.5 and Train.KV.ControllerPosition >= -1.5  then
				Train:WriteCell(2,0)
			end
			if Train.KV.ControllerPosition <= 2.5  then
				Train:WriteCell(3,0)
			end
			if Train.KV.ControllerPosition >= 0.0 then
				Train:WriteCell(6,0)
			end
			Train:WriteCell(29, 0)
			Train:WriteCell(32,0)
			self.AutodriveEnabled = false
		end

		if Train.VZP.Value < 0.5 and self.AutodriveReset then
			self.AutodriveReset = false
		end
		self.AutodriveWorking = true
		--Disable autodrive, if KV pos is not zero, ARS or ALS not enabled, Reverser position is not forward or Driver value pos is > 2
		if not self.AutodriveWorking and not self.VRD or Train.KV.ControllerPosition ~= 0.0 or not Train.ALS_ARS.EnableARS or Train.KV.ReverserPosition ~= 1.0 or Train.Pneumatic.DriverValvePosition > 2 or self.Train.Panel.SD < 0.5 then
			self.AutodriveReset = true
		end

		if false and self.StationAutodrive and self.AutodriveWorking and not self.VRD and Train.ALS_ARS.EnableARS and Train.KV.ReverserPosition == 1.0 and Train.Pneumatic.DriverValvePosition <= 2 and self.Train.Panel.SD > 0.5 then
			self:Autodrive(true)
		elseif self.StationAutodrive then
			self.StationAutodrive = false
		end
		if Train.VZP.Value > 0.5 and not self.AutodriveEnabled and not self.AutodriveReset then
			--[[
			if Train.Schedule then
				for k,v in pairs(Train.Schedule) do
					for k1,v1 in pairs(v) do
					end
				end
			end
			]]
			self.AutodriveEnabled = true
			self.StartMoving = true
		end
		if self.AutodriveEnabled then
			self:Autodrive()
		end
		--end
	end
	self.RealState = self.State
end
