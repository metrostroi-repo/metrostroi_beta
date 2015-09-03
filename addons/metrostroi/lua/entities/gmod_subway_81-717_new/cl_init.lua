include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
			
-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(467.4,14.0,4.8), --446 -- 14 -- -0,5
	ang = Angle(0,-90,44),
	width = 460,
	height = 230,
	scale = 0.0625,
	
	buttons = {
		{ID = "R_UNchToggle",	x=39+28*0, y=37, radius=20, tooltip="УНЧ: Усилитель низких частот (информатор салона)\nUNCh: Low frequency amplifier(sound in wagons enable)"},
		{ID = "R_ZSToggle",		x=36+28*1, y=37, radius=20, tooltip="ЗС\nZS"},
		{ID = "R_GToggle",		x=38+28*2, y=37, radius=20, tooltip="Громкоговоритель\nLoudspeaker: Sound in cabin enable"},
		{ID = "R_RadioToggle",	x=38+28*3, y=37, radius=20, tooltip="Радиоинформатор (встроеный)\nRadioinformator: Announcer (built-in)"},
		{ID = "R_ProgramToggle",x=41+28*4, y=37, radius=0, },
		{ID = "R_Program1Set",  x=27+28*3.5, y=37-10,  w=28,h=20, tooltip="Программа 1\nProgram 1"},
		{ID = "R_Program2Set",  x=27+28*4.5, y=37-10, w=28,h=20, tooltip="Программа 2\nProgram 2"},
		
		--{ID = "1:KVTSet",			x=247, y=33, radius=20, tooltip="КВТ: Кнопка восприятия торможения\nKVT: ARS Brake cancel button"},
		{ID = "2:KVTSet",		x=295, y=33, radius=20, tooltip="КБ: Кнопка Бдительности\nKB: Attention button"},
		{ID = "VZ1Set",			x=355, y=33, radius=20, tooltip="ВЗ1: Вентиль замещения №1\nVZ1: Pneumatic valve #1"},
		
		--{ID = "AutodriveToggle",x=420, y=92, radius=20, tooltip="Автоматическая остановка\nAutomatic stop"},
		
		{ID = "VUD1Toggle",		x=49, y=105, radius=40, tooltip="ВУД: Выключатель управления дверьми\nVUD: Door control toggle (close doors)"},
		{ID = "KDLSet",			x=50, y=180, radius=20, tooltip="КДЛ: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "VDLSet",			x=153, y=180, radius=20, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
		{ID = "DoorSelectToggle",x=105, y=183, radius=20, tooltip="Выбор стороны открытия дверей\nSelect side on which doors will open"},
		{ID = "KRZDSet",		x=153, y=83, radius=20, tooltip="КРЗД: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},
		{ID = "VozvratRPSet",	x=105, y=132, radius=20, tooltip="Возврат реле перегрузки\nReset overload relay"},
		
		{ID = "GreenRPLight",	x=153, y=135, radius=20, tooltip="РП: Зелёная лампа реле перегрузки\nRP: Green overload relay light (overload relay open on current train)"},
		{ID = "AVULight",		x=326, y=92, radius=20, tooltip="АВУ: Автоматический выключатель управления\nAVU: Automatic control disabler active"},
		{ID = "KVPLight",		x=372, y=92, radius=20, tooltip="КВП: Контроль высоковольного преобразователя\nKVP: High-voltage converter control"},
		{ID = "SPLight",		x=413, y=30, radius=20, tooltip="ЛСП: Лампа сигнализации пожара\nLSP: Fire emergency (rheostat overheat)"},
		
		{ID = "PS6",			x=330, y=130, radius=20, tooltip="(placeholder) Converter protection"},
		{ID = "KSNSet",			x=375, y=130, radius=20, tooltip="КСН: Кнопка сигнализации неисправности\nKSN: Failure indication button"},
		{ID = "DIPoffSet",		x=420, y=130, radius=20, tooltip="Звонок\nRing"},

		{ID = "ARSToggle",		x=239, y=130, radius=20, tooltip="АРС: Включение системы автоматического регулирования скорости\nARS: Automatic speed regulation"},
		{ID = "ALSToggle",		x=268, y=130, radius=20, tooltip="АЛС: Включение системы автоматической локомотивной сигнализации\nALS: Automatic locomotive signalling"},
		
		{ID = "OtklAVUToggle",	x=283, y=183, radius=20, tooltip="Отключение автоматического выключения управления (неисправность АВУ)\nTurn off automatic control disable relay (failure of AVU)"},
		{ID = "PS2",			x=238, y=183, radius=20, tooltip="(placeholder) Emergency brake toggle"},
		{ID = "L_1Toggle",		x=321, y=183, radius=20, tooltip="Освещение салона\nWagon lighting"},
		{ID = "L_2Toggle",		x=357, y=183, radius=20, tooltip="Освещение кабины\nCabin lighting"},
		{ID = "L_3Toggle",		x=399, y=183, radius=20, tooltip="Освещение пульта\nPanel lighting"},

		{ID = "ParkingBrakeSignToggle",	x=203,y=113, radius=20, tooltip="Табличка \"ОТПУСТИ СТОЯНОЧНЫЙ ТОРМОЗ\"\nSign \"RELEASE PARKING BRAKE\""},
	}
}

-- Front panel
ENT.ButtonMap["Front"] = {
	pos = Vector(465.3,-15.9,7.1),
	ang = Angle(0,-90,56.5),
	width = 220,
	height = 250,
	scale = 0.0625,
	
	buttons = {
		{ID = "VUSToggle",x=90, y=200, radius=20, tooltip="ВУС: Выключатель усиленого света ходовых фар\nVUS: Head lights bright/dim"},
		{ID = "VAHToggle",x=170, y=200, radius=20, tooltip="ВАХ: Включение аварийного хода (неисправность реле педали безопасности)\nVAH: Emergency driving mode (failure of RPB relay)"},
		{ID = "VADToggle",x=127, y=200, radius=20, tooltip="ВАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nVAD: Emergency door close override (failure of KD relay)"},		
		--{ID = "RezMKSet",x=53,  y=98, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		{ID = "KAHSet",x=53,  y=98, radius=20, tooltip="КАХ: Кнопка аварийного хода\nEmergency drive button"},
		{ID = "KRPSet",x=53, y=33, radius=20, tooltip="КРП: Кнопка резервного пуска\nKRP: Emergency start button"},
		
		{ID = "L_4Toggle",x=53, y=200, radius=20, tooltip="Выключатель фар\nHeadlights toggle"},
		{ID = "CabinHeatLight",x=90, y=145, radius=20, tooltip="Контроль печи\nCabin heater active"},
		{ID = "KDPSet",x=130, y=145, radius=32, tooltip="КДП: Кнопка правых дверей\nKDP: Right doors open"},
		
		{ID = "PneumoLight",x=170, y=145, radius=20, tooltip="Контроль пневмотормоза\nPneumatic brake control"},
	}
}

-- BPSN panel
ENT.ButtonMap["BPSNFront"] = {
	pos = Vector(469.3,31.4,13.6),
	ang = Angle(0,-90,56.5),
	width = 310,
	height = 120,
	scale = 0.0625,
	
	buttons = {
		{x=245,y=60,tooltip="Напряжение цепей управления\nControl circuits voltage",radius=60},
		{ID = "VMKToggle",x=43,  y=28, radius=20, tooltip="Включение мотор-компрессора\nTurn motor-compressor on"},
		{ID = "BPSNonToggle",x=83,  y=28, radius=20, tooltip="БПСН: Блок питания собственных нужд\nBPSN: Train power supply"},
		--{ID = "L_5Toggle",x=126, y=28, radius=20, tooltip="Аварийное освещение\nEmergency lighting"},
		
		{ID = "RezMKSet",		x=126,  y=80, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		--{ID = "Radio13Set", x=83, y=80, radius=20, tooltip="Радио 13В: Проверка батареи радиостанции\nRadio 13V: Radiostation battery check"},
		{ID = "ARS13Set",x=83, y=80, radius=20, tooltip="АРС 13В: Проверка стабилизированого напряжения АРС\nARS 13V: ARS stabilized voltage check"},
	}
}

-- Announcer panel
ENT.ButtonMap["Announcer"] = {
	pos = Vector(465.3,31.4,7.0),
	ang = Angle(0,-90,57.0),
	width = 265,
	height = 245,
	scale = 0.0625,
	
	buttons = {
		{ID = "DURASelectMain", x=159, y=200, radius=20, tooltip="DURA Select Main"}, -- NEEDS TRANSLATING
		{ID = "DURASelectAlternate", x=198, y=200, radius=20, tooltip="DURA Select Alternate"}, -- NEEDS TRANSLATING
		{ID = "DURAToggleChannel", x=110, y=217, radius=20, tooltip="DURA Toggle Channel"}, -- NEEDS TRANSLATING
		{ID = "DURAPowerToggle", x=110, y=187, radius=20, tooltip="DURA Power"}, -- NEEDS TRANSLATING
		
		{ID = "CustomAToggle", x=40, y=100, radius=20, tooltip="A"},
		{ID = "CustomBToggle", x=40, y=135, radius=20, tooltip="B"},
		{ID = "CustomCToggle", x=220, y=45, radius=20, tooltip="C"},
		
		{ID = "CustomD", x=95+29*0, y=18, radius=20, tooltip="D"},
		{ID = "CustomE", x=95+29*1, y=18, radius=20, tooltip="E"},
		{ID = "CustomF", x=95+29*2, y=18, radius=20, tooltip="F"},
		{ID = "CustomG", x=95+29*3, y=18, radius=20, tooltip="G"},
		
		{ID = "Custom1Set", x=95+40*0, y=84+45*0, radius=20, tooltip="1"},
		{ID = "Custom2Set", x=95+40*1, y=84+45*0, radius=20, tooltip="2"},
		{ID = "Custom3Set", x=95+40*2, y=84+45*0, radius=20, tooltip="3"},
		{ID = "Custom4Set", x=95+40*3, y=84+45*0, radius=20, tooltip="4"},
		{ID = "Custom5Set", x=95+40*0, y=84+45*1, radius=20, tooltip="5"},
		{ID = "Custom6Set", x=95+40*1, y=84+45*1, radius=20, tooltip="6"},
		{ID = "Custom7Set", x=95+40*2, y=84+45*1, radius=20, tooltip="7"},
		{ID = "Custom8Set", x=95+40*3, y=84+45*1, radius=20, tooltip="8"},
	}
}
-- Announcer panel
ENT.ButtonMap["AnnouncerDisplay"] = {
	pos = Vector(465.4,31.4,7.18),
	ang = Angle(-.4,-90.5,57.0),
	width = 265,
	height = 245,
	scale = 0.0187,
	props = {},
}

--									
ENT.ButtonMap["PAKSD"] = {
	pos = Vector(465.3,31.4,7.0),
	ang = Angle(0,-90,57.0),
	width = 265,
	height = 245,
	scale = 0.0625,
	
	buttons = {
		{ID = "IndicateToggle", x=232, y=48, radius=20, tooltip="ПА-КСД:Индикация"},
		{ID = "BCCDSet", x=115, y=205, radius=20, tooltip="ПА-КСД:КСЗД"},
		{ID = "VZPToggle", x=166, y=210, radius=20, tooltip="ПА-КСД:ВЗП"},
		
		{ID = "B7Set", x=32 + 16.6*0, y=157 + 17.7*0, radius=10, tooltip="ПА-КСД:7"},
		{ID = "B8Set", x=32 + 16.6*1, y=157 + 17.7*0, radius=10, tooltip="ПА-КСД:8"},
		{ID = "B9Set", x=32 + 16.6*2, y=157 + 17.7*0, radius=10, tooltip="ПА-КСД:9"},
		{ID = "BLeftSet", x=32 + 16.6*3, y=157 + 17.7*0, radius=10, tooltip="ПА-КСД:Влево"},
		{ID = "B4Set", x=32 + 16.6*0, y=157 + 17.7*1, radius=10, tooltip="ПА-КСД:4"},
		{ID = "B5Set", x=32 + 16.6*1, y=157 + 17.7*1, radius=10, tooltip="ПА-КСД:5"},
		{ID = "B6Set", x=32 + 16.6*2, y=157 + 17.7*1, radius=10, tooltip="ПА-КСД:6"},
		{ID = "BUpSet", x=32 + 16.6*3, y=157 + 17.7*1, radius=10, tooltip="ПА-КСД:Вверх"},
		{ID = "B1Set", x=32 + 16.6*0, y=157 + 17.7*2, radius=10, tooltip="ПА-КСД:1"},
		{ID = "B2Set", x=32 + 16.6*1, y=157 + 17.7*2, radius=10, tooltip="ПА-КСД:2"},
		{ID = "B3Set", x=32 + 16.6*2, y=157 + 17.7*2, radius=10, tooltip="ПА-КСД:3"},
		{ID = "BDownSet", x=32 + 16.6*3, y=157 + 17.7*2, radius=10, tooltip="ПА-КСД:Вниз"},
		{ID = "B0Set", x=32 + 16.6*0, y=157 + 17.7*3, radius=10, tooltip="ПА-КСД:0"},
		{ID = "BMinusSet", x=32 + 16.6*1, y=157 + 17.7*3, radius=10, tooltip="ПА-КСД:-"},
		{ID = "BPlusSet", x=32 + 16.6*2, y=157 + 17.7*3, radius=10, tooltip="ПА-КСД:+"},
		{ID = "BEnterSet", x=32 + 16.6*3, y=157 + 17.7*3, radius=10, tooltip="ПА-КСД:Ввод"},
	}
}
ENT.ButtonMap["PAKSD1"] = {
	pos = Vector(464.55,29.0,5.7),
	ang = Angle(0,-90,57.0),
	width = 323,
	height = 113,
	scale = 0.0305,
	props = {},
}
ENT.ButtonMap["PAKSD2"] = {
	pos = Vector(461.80,25.1,1.50),
	ang = Angle(0,-90,57.0),
	width = 315,
	height = 103,
	scale = 0.0185,
	props = {},
}
ENT.ARSMap = {}
-- ARS/Speedometer panel
ENT.ARSMap[1] = {
	pos = Vector(469.48,11.05,13.3),
	ang = Angle(0,-90-0.2,56.3),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,

	buttons = {
		{x=1100+70,y=160+70,tooltip="Индикатор скорости\nSpeed indicator",radius=130},
		{x=1780+60,y=780+60,tooltip="ЛСН: Лампа сигнализации неисправности\nLSN: Failure indicator light (power circuits failed to assemble)",radius=120},
		{x=1520+60,y=780+60,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=120},
		{x=1110+60,y=780+60,tooltip="ЛхРК: Лампа хода реостатного контроллера\nLhRK: Rheostat controller motion light",radius=120},
		{x=2130+60,y=780+60,tooltip="ЛКТ: Контроль тормоза\nLKT: ARS braking indicator",radius=120},
		{x=2130+60,y=550+60,tooltip="ЛКВД: Контроль выключения двигателей\nLKVD: ARS engine shutdown indicator",radius=120},
		{x=2540+60,y=100+60,tooltip="ЛКВЦ: Лампа контактора высоковольтных цепей\nLKVC: High voltage not available",radius=120},
	
		{x=410+275*0+60+60,y=480,tooltip="ОЧ: Отсутствие частоты АРС\nOCh: No ARS frequency",radius=120},
		{x=410+275*1+60+60,y=480,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal",radius=120},
		{x=410+275*2+60+60,y=480,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph",radius=120},
		{x=410+275*3+60+60,y=480,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph",radius=120},
		{x=410+275*4+60+60,y=480,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph",radius=120},
		{x=410+275*5+60+60,y=480,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph",radius=120},

		{x=410+60,y=780+60,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)",radius=120},
		{x=690+60,y=780+60,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)",radius=120},
		
		{x=2540+60,y=780+60,tooltip="ЛСТ: Лампа сигнализации торможения\nLST: Brakes engaged",radius=120},
		{x=2540+60,y=330+60,tooltip="ЛВД: Лампа включения двигателей\nLVD: Engines engaged",radius=120},
		{x=2130+60,y=330+60,tooltip="ЛН: Лампа направления\nLN: Direction signal",radius=120},
		{x=2540+60,y=550+60,tooltip="ЛРС: Лампа равенства скоростей\nLRS: Speed equality light (next segment speed limit equal or greater to current)",radius=120},
	}
}
ENT.ARSMap[2] = {
	pos = Vector(469.48,11.15,13.4),
	ang = Angle(0,-90-0.2,56.3),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,

	buttons = {
		{x=600,y=343,tooltip="Индикатор скорости\nSpeed indicator",radius=130},
	
		{x=885+177*0,y=420 + 2*0,tooltip="ОЧ: Отсутствие частоты АРС\nOCh: No ARS frequency",radius=70},
		{x=885+177*1,y=420 + 2*1,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal",radius=70},
		{x=885+177*2,y=420 + 2*2,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph",radius=70},
		{x=885+177*3,y=420 + 2*3,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph",radius=70},
		{x=885+177*4,y=420 + 2*4,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph",radius=70},
		{x=885+177*5,y=420 + 2*5,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph",radius=70},
		
		{x=507,y=831,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)",radius=70},
		{x=687,y=831,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)",radius=70},

		{x=884,y=834,tooltip="ЛхРК: Лампа хода реостатного контроллера\nLhRK: Rheostat controller motion light",radius=70},

		{x=1235,y=838,tooltip="ЛСН: Лампа сигнализации неисправности\nLSN: Failure indicator light (power circuits failed to assemble)",radius=70},
		{x=1771,y=838,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)",radius=70},
		
		--{x=2031 + 2*0,y=223 + 192*0,tooltip="ЛН: Лампа направления\nLN: Direction signal",radius=10},
		{x=2033 + 2*1,y=233 + 192*1,tooltip="ЛН: Лампа направления\nLN: Direction signal",radius=70},
		{x=2033 + 2*2,y=233 + 200*2,tooltip="ЛКВД: Контроль выключения двигателей\nLKVD: ARS engine shutdown indicator",radius=70},
		{x=2033 + 2*3,y=233 + 200*3,tooltip="ЛКТ: Контроль тормоза\nLKT: ARS braking indicator",radius=70},
		{x=2570 + 2*0,y=224 + 192*0,tooltip="ЛКВЦ: Лампа контактора высоковольтных цепей\nLKVC: High voltage not available",radius=70},
		{x=2570 + 2*1,y=233 + 192*1,tooltip="ЛРС: Лампа равенства скоростей\nLRS: Speed equality light (next segment speed limit equal or greater to current)",radius=10},
		{x=2570 + 2*2,y=233 + 200*2,tooltip="ЛСТ: Лампа сигнализации торможения\nLST: Brakes engaged",radius=70},
		{x=2570 + 2*3,y=233 + 200*3,tooltip="ЛВД: Лампа включения двигателей\nLVD: Engines engaged",radius=70},
	}
}
ENT.ARSMap[3] = {
	pos = Vector(469.48,11.15,13.4),
	ang = Angle(0,-90-0.2,56.3),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,

	buttons = {
		{x=1332,y=240,w = 360, h = 216,tooltip="Индикатор скорости\nSpeed indicator"},
		{x=1301,y=680,w = 436, h = 88,tooltip="Индикатор скорости\nSpeed indicator"},

		{x=899,y=281 + 111*0,w = 80, h = 80,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal"},
		{x=999,y=281 + 111*0,w = 80, h = 80,tooltip="НЧ: Отсутствие частоты АРС\nNCh: No ARS frequency"},
		{x=899,y=281 + 111*1,w = 80, h = 80,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph"},
		{x=899,y=281 + 111*2,w = 80, h = 80,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph"},
		{x=899,y=281 + 111*3,w = 80, h = 80,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 70 kph"},
		{x=899,y=281 + 111*4,w = 80, h = 80,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph"},
		
		{x=1838,y=291 + 85*0,w = 165, h = 45,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)"},
		
		{x=1838,y=291 + 85*1,w = 80, h = 45,tooltip="1: Лампа первого провода (включение двигателей)\n1: 1st train wire lamp(engines engaged)"},
		{x=1838,y=291 + 86*2,w = 80, h = 45,tooltip="2: Лампа второго провода (ход реостатного контроллера)\n2: 2nd train wire lamp(rheostat controller motion)"},
		{x=1838,y=291 + 88*3,w = 80, h = 45,tooltip="6: Лампа шестого провода (сигнализация торможения)\n6: 6th train wire lamp(brakes engaged)"},
		{x=1838,y=291 + 88*4,w = 80, h = 45,tooltip="ЛРД: Лампа разрешения движения под 0\nLRD: Movement permission under 0 lamp"},
		
		{x=2005,y=291 + 85*1,w = 85, h = 45,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)"},
		
		{x=2093,y=291 + 85*1,w = 90, h = 45,tooltip="ЛСН: Лампа сигнализации неисправности\nLSN: Failure indicator light (power circuits failed to assemble)"},
		{x=2093,y=291 + 88*2,w = 90, h = 45,tooltip="ЛКВД: Контроль выключения двигателей\nLKVD: ARS engine shutdown indicator"},
		{x=2093,y=291 + 88*3,w = 90, h = 45,tooltip="ЛКТ: Контроль тормоза\nLKT: ARS braking indicator"},
		{x=2093,y=291 + 88*4,w = 90, h = 45,tooltip="ПА: Лампа работы поездной аппаратуры(ПА-КСД)\nPA: Train equipment work lamp(PA-KSD)"},
	}
}
-- ARS/Speedometer panel (Kyiv version)
ENT.ButtonMap["ARSKyiv"] = {
	pos = Vector(469.58,10.99,13.3),
	ang = Angle(0,-90-0.2,56.3),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,
}
-- Parking Brake Sign
ENT.ButtonMap["ParkingBrakeSign"] = {
	pos = Vector(469.0,10.9,13),
	ang = Angle(0,-90-0.2,56.3),
	width = 300,
	height = 110,
	scale = 0.0625,
	visivle=0,
}

-- AV panel
ENT.ButtonMap["AV"] = {
	pos = Vector(408.0,-11.3,50.5),
	ang = Angle(0,90,90),
	width = 590,
	height = 590,
	scale = 0.0625,
	
	buttons = {
		{ID = "A61Toggle", x=16+52*0,  y=60+167*0, radius=30, tooltip="A61 Управление 6ым поездным проводом\nTrain wire 6 control"},
		{ID = "A55Toggle", x=16+52*1,  y=60+167*0, radius=30, tooltip="A55 Управление проводом 10АС\nTrain wire 10AS control"},
		{ID = "A54Toggle", x=16+52*2,  y=60+167*0, radius=30, tooltip="A54 Управление проводом 10АК\nTrain wire 10AK control"},
		{ID = "A56Toggle", x=16+52*3,  y=60+167*0, radius=30, tooltip="A56 Включение аккумуляторной батареи\nTurn on battery power to control circuits"},
		{ID = "A27Toggle", x=16+52*4,  y=60+167*0, radius=30, tooltip="A27 Turn on DIP and lighting"},
		{ID = "A21Toggle", x=16+52*5,  y=60+167*0, radius=30, tooltip="A21 Door control"},
		{ID = "A10Toggle", x=16+52*6,  y=60+167*0, radius=30, tooltip="A10 Motor-compressor control"},
		{ID = "A53Toggle", x=16+52*7,  y=60+167*0, radius=30, tooltip="A53 KVC power supply"},
		{ID = "A43Toggle", x=16+52*8,  y=60+167*0, radius=30, tooltip="A43 ARS 12V power supply"},
		{ID = "A45Toggle", x=16+52*9,  y=60+167*0, radius=30, tooltip="A45 ARS train wire 10AU"},
		{ID = "A42Toggle", x=16+52*10, y=60+167*0, radius=30, tooltip="A42 ARS 75V power supply"},
		{ID = "A41Toggle", x=16+52*11, y=60+167*0, radius=30, tooltip="A41 ARS braking"},		
		------------------------------------------------------------------------
		{ID = "VUToggle",  x=16+52*0,  y=60+167*1, radius=30, tooltip="VU  Train control"},
		{ID = "A64Toggle", x=16+52*1,  y=60+167*1, radius=30, tooltip="A64 Cabin lighting"},
		{ID = "A63Toggle", x=16+52*2,  y=60+167*1, radius=30, tooltip="A63 IGLA/BIS"},
		{ID = "A50Toggle", x=16+52*3,  y=60+167*1, radius=30, tooltip="A50 Turn on DIP and lighting"},
		{ID = "A52Toggle", x=16+52*4,  y=60+167*1, radius=30, tooltip="A52 Turn off DIP and lighting"},
		{ID = "A23Toggle", x=16+52*5,  y=60+167*1, radius=30, tooltip="A23 Emergency motor-compressor turn on"},	
		{ID = "A14Toggle", x=16+52*6,  y=60+167*1, radius=30, tooltip="A14 Train wire 18"},
		{ID = "A75Toggle", x=16+52*7,  y=60+167*1, radius=30, tooltip="A75 Cabin heating"},
		{ID = "A1Toggle",  x=16+52*8,  y=60+167*1, radius=30, tooltip="A1  XOD-1"},
		{ID = "A2Toggle",  x=16+52*9,  y=60+167*1, radius=30, tooltip="A2  XOD-2"},
		{ID = "A3Toggle",  x=16+52*10, y=60+167*1, radius=30, tooltip="A3  XOD-3"},
		{ID = "A17Toggle", x=16+52*11, y=60+167*1, radius=30, tooltip="A17 Reset overload relay"},
		------------------------------------------------------------------------
		{ID = "A62Toggle", x=16+52*0,  y=60+167*2, radius=30, tooltip="A62 Radio communications"},
		{ID = "A29Toggle", x=16+52*1,  y=60+167*2, radius=30, tooltip="A29 Radio broadcasting"},
		{ID = "A5Toggle",  x=16+52*2,  y=60+167*2, radius=30, tooltip="A5 Interim wagon"},
		{ID = "A6Toggle",  x=16+52*3,  y=60+167*2, radius=30, tooltip="A6  T-1"},
		{ID = "A8Toggle",  x=16+52*4,  y=60+167*2, radius=30, tooltip="A8  Pneumatic valves #1, #2"},
		{ID = "A20Toggle", x=16+52*5,  y=60+167*2, radius=30, tooltip="A20 Drive/brake circuit control, train wire 20"},
		{ID = "A25Toggle", x=16+52*6,  y=60+167*2, radius=30, tooltip="A25 Manual electric braking"},
		{ID = "A22Toggle", x=16+52*7,  y=60+167*2, radius=30, tooltip="A22 Turn on KK"},
		{ID = "A30Toggle", x=16+52*8,  y=60+167*2, radius=30, tooltip="A30 Rheostat controller motor power"},
		{ID = "A39Toggle", x=16+52*9,  y=60+167*2, radius=30, tooltip="A39 Emergency control"},
		{ID = "A44Toggle", x=16+52*10, y=60+167*2, radius=30, tooltip="A44 Emergency train control"},
		{ID = "A80Toggle", x=16+52*11, y=60+167*2, radius=30, tooltip="A80 Power circuit mode switch motor power"},
		------------------------------------------------------------------------
		{ID = "A65Toggle", x=16+44*0,  y=60+167*3, radius=30, tooltip="A65 Interior lighting"},
		{ID = "L_5Toggle", x=16+52*1,  y=60+167*3, radius=30, tooltip="А49 Emergency lighting"},
		{ID = "A24Toggle", x=16+52*2,  y=60+167*3, radius=30, tooltip="A24 Battery charging"},
		{ID = "A32Toggle", x=16+52*3,  y=60+167*3, radius=30, tooltip="A32 Open right doors"},
		{ID = "A31Toggle", x=16+52*4,  y=60+167*3, radius=30, tooltip="A31 Open left doors"},
		{ID = "A16Toggle", x=16+52*5,  y=60+167*3, radius=30, tooltip="A16 Close doors"},
		{ID = "A13Toggle", x=16+52*6,  y=60+167*3, radius=30, tooltip="A13 Door alarm"},
		{ID = "A12Toggle", x=16+52*7,  y=60+167*3, radius=30, tooltip="A12 Emergency door close"},
		{ID = "A7Toggle",  x=16+52*8,  y=60+167*3, radius=30, tooltip="A7  Red lamp"},
		{ID = "A9Toggle",  x=16+52*9,  y=60+167*3, radius=30, tooltip="A9  Red lamp"},
		--{ID = "BPSToggle", x=16+52*9,  y=60+167*3+60, radius=30, tooltip="РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"}, 
		{ID = "A46Toggle", x=16+52*10, y=60+167*3, radius=30, tooltip="A46 White lamp"},
		{ID = "A47Toggle", x=16+52*11, y=60+167*3, radius=30, tooltip="A47 White lamp"},
	}
}
ENT.ButtonMap["AV_1"] = {}
for k,v in pairs(ENT.ButtonMap["AV"]) do
	ENT.ButtonMap["AV_1"][k] = v
	if k == "buttons" then
		for k2,v2 in pairs(v) do
			v2.ID = "1:"..v2.ID
		end
	end
end
ENT.ButtonMap["AV_1"].pos = Vector(408.0,-11.3,50.5) + Vector(12,-47,0.5)	
ENT.ButtonMap["Battery"] = {
	pos = Vector(419.0,-55.5,38),
	ang = Angle(0,90,90),
	width = 270,
	height = 375,
	scale = 0.0625,
	
	buttons = {
		{ID = "BPSToggle", x=64, y=71, radius=70, tooltip="РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"},
		{ID = "RC1Toggle", x=64, y=185, radius=70, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect"},
		{ID = "UOSToggle", x=185, y=185, radius=70, tooltip="РЦ-УОС: Устройство ограничения скорости\nRC-UOS: Speed Limitation Device"}, 
		{ID = "VBToggle", x=64, y=299, radius=70, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
		{ID = "VPAToggle",		x=185, y=185, radius=70, tooltip="ВПА: Включение поездной аппаратуры комплексной системы движения(АРС)\nVPA: Train equipment enable(ARS)"},
	}
}
ENT.ButtonMap["Battery_2"] = {
	pos = Vector(419.0,-52.5,12.7),
	ang = Angle(0,90,90),
	width = 415,
	height = 275,
	scale = 0.0625,
	
	buttons = {
		{ID = "RC1Toggle", x=64, y=68, radius=70, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect"},
		{ID = "VBToggle", x=220, y=68, radius=70, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
		{ID = "BPSToggle", x=356, y=68, radius=70, tooltip=" РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"},
		{ID = "UOSToggle", x=215, y=215, radius=70, tooltip="РЦ-УОС: Устройство ограничения скорости\nRC-UOS: Speed Limitation Device"},
		{ID = "VPAToggle",		x=215, y=215, radius=70, tooltip="ВПА: Включение поездной аппаратуры комплексной системы движения(АРС)\nVPA: Train equipment enable(ARS)"},
	}
}
-- Help panel
ENT.ButtonMap["Help"] = {
	pos = Vector(444.0,-34.3,1.8),
	ang = Angle(0,0,0),
	width = 20,
	height = 20,
	scale = 1,
	
	buttons = {
		{ID = "ShowHelp", x=10, y=10, radius=15, tooltip="Помощь в вождении поезда\nShow help on driving the train"},
	}
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
	pos = Vector(459.5,61,21.3),
	ang = Angle(0,0,90),
	width = 96,
	height = 192,
	scale = 0.0625,
	
	buttons = {
		{ID = "VUD2Toggle", x=32, y=42, radius=32, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)"},
		{ID = "VDLSet",     x=32, y=112, radius=32, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
		{ID = "R_Program2Helper",  x=24, y=180, radius=20, tooltip="Программа 2\nProgram 2"},
		{ID = "R_Program1Helper",  x=72, y=180,  radius=20, tooltip="Программа 1\nProgram 1"},
	}
}

-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(469,-9.0,13.6),
	ang = Angle(0,-90,56.5),
	width = 310,
	height = 120,
	scale = 0.0625,
	
	buttons = {
		{x=200,y=55,radius=55,tooltip="Давление в тормозных цилиндрах (ТЦ)\nBrake cylinder pressure"},
		{x=65,y=55,radius=55,tooltip="Давление в магистралях (красная: тормозной, чёрная: напорной)\nPressure in pneumatic lines (red: brake line, black: train line)"},
	}
}
ENT.ButtonMap["DriverValveDisconnect"] = {
	pos = Vector(431.0,-24,-32),
	ang = Angle(0,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,
	
	buttons = {
		{ID = "DriverValveDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Клапан разобщения\nDriver valve disconnect valve"},
	}
}
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(455.0,-25,-26),
	ang = Angle(0,180,90),
	width = 200,
	height = 120,
	scale = 0.0625,
	
	buttons = {
		{ID = "ParkingBrakeToggle", x=0, y=0, w=200, h=120, tooltip="Ствояночный тормоз\nParking brake"},
	}
}
ENT.ButtonMap["EPKDisconnect"] = {
	pos = Vector(449.0,-43.3,-33),
	ang = Angle(0,-90,0),
	width = 200,
	height = 120,
	scale = 0.0625,
	
	buttons = {
		{ID = "EPKToggle", x=0, y=0, w=200, h=120, tooltip="Кран ЭПВ\nEPK disconnect valve"},
	}
}
ENT.ButtonMap["Reverser"] = {
	pos = Vector(456.0,-30.5,-3),
	ang = Angle(0,180,90),
	width = 180,
	height = 150,
	scale = 0.0625,
	
	buttons = {
		{ID = "KVReverserDown",x=10,y=0,w=160,h=70, tooltip="Реверсор назад\nReversor back"},
		{ID = "KVReverserUp",x=10,y=80,w=160,h=70, tooltip="Реверсор вперёд\nReversor forward"},
	}
}

ENT.ButtonMap["Meters"] = {
	pos = Vector(470,-29.8,32.5),
	ang = Angle(0,-125,90),
	width = 95,
	height = 150,
	scale = 0.0625,
	
	buttons = {
		{x=22, y=24, w=55, h=45, tooltip="Вольтметр высокого напряжения (кВ)\nHV voltmeter (kV)"},
		{x=22, y=85, w=58, h=45, tooltip="Амперметр (А)\nTotal ampermeter (A)"},
	}
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
	pos = Vector(441.0,-55.3,-7.0),
	ang = Angle(0,180,90),
	width = 230,
	height = 170,
	scale = 0.0625,
	
	buttons = {
		{ID = "UAVAToggle",x=0, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа (отключение автостопа)\nUAVA: Universal Automatic Autostop Disabler (autostop disable)"},
		{ID = "UAVAContactSet",x=230/2, y=0, w=230/2, h=170, tooltip="УАВА: Универсальный Автоматический Выключатель Автостопа (восстановление контактов)\nUAVA: Universal Automatic Autostop Disabler(contacts reset)"},
	}
}


--These values should be identical to those drawing the schedule
local col1w = 80 -- 1st Column width
local col2w = 32 -- The other column widths
local rowtall = 30 -- Row height, includes -only- the usable space and not any lines

local rowamount = 16 -- How many rows to show (total)
ENT.ButtonMap["Schedule"] = {
	pos = Vector(472.0,32.5,30),
	ang = Angle(0,-60,90),
	width = (col1w + 2 + (1 + col2w) * 3),
	height = (rowtall+1)*rowamount+1,
	scale = 0.0625/2,
	
	buttons = {
		{x=1, y=1, w=col1w, h=rowtall, tooltip="М №\nRoute number"},
		{x=1, y=rowtall*2+3, w=col1w, h=rowtall, tooltip="П №\nPath number"},
		
		{x=col1w+2, y=1, w=col2w*3+2, h=rowtall, tooltip="ВРЕМЯ ХОДА\nTotal schedule time"},
		{x=col1w+2, y=rowtall+2, w=col2w*3+2, h=rowtall, tooltip="ИНТ\nTrain interval"},
		
		{x=col1w+2, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="ЧАС\nHour"},
		{x=col1w+col2w+3, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="МИН\nMinute"},
		{x=col1w+col2w*2+4, y=rowtall*2+3, w=col2w, h=rowtall, tooltip="СЕК\nSecond"},
		{x=col1w+2, y=rowtall*3+4, w=col2w*3+2, h=(rowtall+1)*(rowamount-3)-1, tooltip="Arrival times"}, -- NEEDS TRANSLATING
		
		{x=1, y=rowtall*3+4, w=col1w, h=(rowtall+1)*(rowamount-3)-1, tooltip="Station name"}, -- NEEDS TRANSLATING
	}
}
ENT.ButtonMap["IGLA"] = {
	pos = Vector(471,-27.5,37.8),
	ang = Angle(0,-125,90),
	width = 440,
	height = 190,
	scale = 0.024,
}

-- Temporary panels (possibly temporary)
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(475.0,-45.0,-47.0),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-482.0,45.0,-45.0),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-175,68.6,-50),
	ang = Angle(0,180,90),
	width = 80,
	height = 40,
	scale = 0.1,
}

-- Wagon numbers
ENT.ButtonMap["TrainNumber1"] = {
	pos = Vector(40,-68.6,-6),
	ang = Angle(0,0,90),
	width = 130,
	height = 55,
	scale = 0.20,
}
ENT.ButtonMap["TrainNumber2"] = {
	pos = Vector(40+28,68.6,-6),
	ang = Angle(0,180,90),
	width = 130,
	height = 55,
	scale = 0.20,
}

-- Front info table
ENT.ButtonMap["InfoTable"] = {
	pos = Vector(454.0,-27.0,2.0),
	ang = Angle(0,90,90),
	width = 540,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(474.0,27.0,22.0),
	ang = Angle(0,-90,90),
	width = 550,
	height = 100,
	scale = 0.1,
		
	
	buttons = {
		{ID = "PrevSign",x=0,y=0,w=50,h=100, tooltip="Предыдущая надпись\nPrevious sign"},
		{ID = "NextSign",x=50,y=0,w=50,h=100, tooltip="Следующая надпись\nNext sign"},

		{ID = "Num2P",x=450,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 2\nRoute: Increase 2nd number"},
		{ID = "Num2M",x=450,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 2\nRoute: Decrease 2nd number"},
		{ID = "Num1P",x=500,y=0,w=50,h=50, tooltip="Маршрут: Увеличить число 1\nRoute: Increase 1st number"},
		{ID = "Num1M",x=500,y=50,w=50,h=50, tooltip="Маршрут: Уменьшить число 1\nRoute: Decrease 1st number"},
	}
}

ENT.ButtonMap["InfoRoute"] = {
	pos = Vector(471.8,43,12.2),
	ang = Angle(0,103.6,90),
	width = 100,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["CabinDoor"] = {
	pos = Vector(423.8,64,56.7),
	ang = Angle(0,0,90),
	width = 642,
	height = 2000,
	scale = 0.1/2,
	buttons = {
		{ID = "CabinDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door"},
	}
}

ENT.ButtonMap["PassengerDoor"] = {
	pos = Vector(394,40.6,50.6), --28
	ang = Angle(0,90,90),
	width = 642-220,
	height = 2000,
	scale = 0.1/2,
	buttons = {
		{ID = "PassengerDoor",x=0,y=0,w=642-220,h=2000, tooltip="Дверь в кабину машиниста\nCabin door"},
	}
}

--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake013"] = {
	model = "models/metrostroi/81-717/brake.mdl",
	pos = Vector(446.9,-24.8+1.5,-4.0),
	ang = Angle(0,180,0)
}
ENT.ClientProps["brake334"] = {
	model = "models/metrostroi/81-717/brake334.mdl",
	pos = Vector(448.0,-23,-0),
	ang = Angle(0,270-30,0)
}
ENT.ClientProps["brake334_body"] = {
	model = "models/metrostroi/81-717/brake334_body.mdl",
	pos = Vector(447.6,-26,-3),
	ang = Angle(0,90,0)
}
ENT.ClientProps["controller"] = {
	model = "models/metrostroi/81-717/controller.mdl",
	pos = Vector(452,17.0+1.6,-8.3),
	ang = Angle(0,180,0)
}
ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(455.5,-32+1.5,-7.7),
	ang = Angle(93,0,0)
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(441.4,-24.1+1.5,-34.2),
	ang = Angle(0,180,0)
}
ENT.ClientProps["EPK_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(446.8,-54.2,-32.5),
	ang = Angle(0,90,-90),
}
ENT.ClientProps["ParkingBrake"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(446.0,-24,-35.8),
	ang = Angle(0,180,0),
}
ENT.ClientProps["krureverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(462.3,-24.5,4.0),
	ang = Angle(180,90,-30)
}
--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(470.2,-16.025+1.5,9),
	ang = Angle(90+33,0,180+36.0)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi/81-717/red_arrow.mdl",
	pos = Vector(470.2,-16.025+1.5,9),
	ang = Angle(90+33,0,180+36.0)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(470.25,-24.55+1.5,8.78),
	ang = Angle(90+33,0,180+36.0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {--24.2 0.2 5.3
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(468.35,-33.97+1.5,23.80),
	ang = Angle(90,0,-35+360+70)
}
ENT.ClientProps["voltmeter"] = {--
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(468.35,-34.0+1.5,27.45),
	ang = Angle(90,0,-35+360+70)
}
ENT.ClientProps["volt1"] = {--
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(469.2,15.4+1.5,8.1),
	ang = Angle(90+30,0,360-36.5)
}





--------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("headlights",{
	panel = "Front",
	button = "VUSToggle",	
	model = "models/metrostroi/81-717/switch04.mdl",
})
--------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("R_UNch",{
	panel = "Main",
	button = "R_UNchToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("R_ZS",{
	panel = "Main",
	button = "R_ZSToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("R_G",{
	panel = "Main",
	button = "R_GToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("R_Radio",{
	panel = "Main",
	button = "R_RadioToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("R_Program",{
	panel = "Main",
	button = "R_ProgramToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
	ang = 180,
})
Metrostroi.ClientPropForButton("BPSNon",{
	panel = "BPSNFront",
	button = "BPSNonToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi/81-717/button03.mdl",
	z = 3,
})
Metrostroi.ClientPropForButton("VMK",{
	panel = "BPSNFront",
	button = "VMKToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("RezMK",{
	panel = "BPSNFront",
	button = "RezMKSet",
	model = "models/metrostroi/81-717/button07.mdl",
})
Metrostroi.ClientPropForButton("KAH",{
	panel = "Front",
	button = "KAHSet",
	model = "models/metrostroi/81-717/button02.mdl",
	z = 3,
})
Metrostroi.ClientPropForButton("VAH",{
	panel = "Front",
	button = "VAHToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("VAD",{
	panel = "Front",
	button = "VADToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("ALS",{
	panel = "Main",
	button = "ALSToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("ARS",{
	panel = "Main",
	button = "ARSToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("OtklAVU",{
	panel = "Main",
	button = "OtklAVUToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("KRZD",{
	panel = "Main",
	button = "KRZDSet",	
	model = "models/metrostroi/81-717/button02.mdl",
	z = 3,
})
Metrostroi.ClientPropForButton("VUD1",{
	panel = "Main",
	button = "VUD1Toggle",
	model = "models/metrostroi/81-717/switch01.mdl",
})
Metrostroi.ClientPropForButton("DoorSelect",{
	panel = "Main",
	button = "DoorSelectToggle",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("KDL",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi/81-717/button08.mdl",
})
Metrostroi.ClientPropForButton("KDP",{
	panel = "Front",
	button = "KDPSet",
	model = "models/metrostroi/81-717/button08.mdl",
})
Metrostroi.ClientPropForButton("VZ1",{
	panel = "Main",
	button = "VZ1Set",
	model = "models/metrostroi/81-717/button02.mdl",
	z=2
})
Metrostroi.ClientPropForButton("KSN",{
	panel = "Main",
	button = "KSNSet",
	model = "models/metrostroi/81-717/button02.mdl"
})
Metrostroi.ClientPropForButton("KRP",{
	panel = "Front",
	button = "KRPSet",
	model = "models/metrostroi/81-717/button04.mdl",
	z=4
})
Metrostroi.ClientPropForButton("VDL_Main",{
	panel = "Main",
	button = "VDLSet",
	model = "models/metrostroi/81-717/button08.mdl",
	z=2
})
Metrostroi.ClientPropForButton("VDL",{
	panel = "HelperPanel",
	button = "VDLSet",
	model = "models/metrostroi/81-717/switch01.mdl"
})
Metrostroi.ClientPropForButton("VUD2",{
	panel = "HelperPanel",
	button = "VUD2Toggle",	
	model = "models/metrostroi/81-717/switch01.mdl",
})
Metrostroi.ClientPropForButton("Program1",{
	panel = "HelperPanel",
	button = "R_Program1Helper",	
	model = "models/metrostroi/81-717/button07.mdl",
})
Metrostroi.ClientPropForButton("Program2",{
	panel = "HelperPanel",
	button = "R_Program2Helper",	
	model = "models/metrostroi/81-717/button07.mdl",
})

Metrostroi.ClientPropForButton("SelectMain",{
	panel = "Announcer",
	button = "DURASelectMain",
	model = "models/metrostroi/81-717/button07.mdl",
})
Metrostroi.ClientPropForButton("SelectAlternate",{
	panel = "Announcer",
	button = "DURASelectAlternate",
	model = "models/metrostroi/81-717/button07.mdl",
})
Metrostroi.ClientPropForButton("SelectChannel",{
	panel = "Announcer",
	button = "DURAToggleChannel",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("DURAPower",{
	panel = "Announcer",
	button = "DURAPowerToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("GreenRPLight",{
	panel = "Main",
	button = "GreenRPLight",
	model = "models/metrostroi/81-717/light02.mdl",
})
Metrostroi.ClientPropForButton("AVULight",{
	panel = "Main",
	button = "AVULight",
	model = "models/metrostroi/81-717/light02.mdl",
})
Metrostroi.ClientPropForButton("KVPLight",{
	panel = "Main",
	button = "KVPLight",
	model = "models/metrostroi/81-717/light02.mdl",
})
Metrostroi.ClientPropForButton("SPLight",{
	panel = "Main",
	button = "SPLight",
	model = "models/metrostroi/81-717/light04.mdl",
})
Metrostroi.ClientPropForButton("CabinHeatLight",{
	panel = "Front",
	button = "CabinHeatLight",
	model = "models/metrostroi/81-717/light04.mdl",
})
Metrostroi.ClientPropForButton("PneumoLight",{
	panel = "Front",
	button = "PneumoLight",
	model = "models/metrostroi/81-717/light04.mdl",
})

-- Placeholders
Metrostroi.ClientPropForButton("L_4",{
	panel = "Front",
	button = "L_4Toggle",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("PS2",{
	panel = "Main",
	button = "PS2",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("L_1",{
	panel = "Main",
	button = "L_1Toggle",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("L_2",{
	panel = "Main",
	button = "L_2Toggle",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("L_3",{
	panel = "Main",
	button = "L_3Toggle",
	model = "models/metrostroi/81-717/switch04.mdl"
})
Metrostroi.ClientPropForButton("PS6",{
	panel = "Main",
	button = "PS6",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("KB",{
	panel = "Main",
	button = "2:KVTSet",
	model = "models/metrostroi/81-717/button10.mdl"
})
Metrostroi.ClientPropForButton("ARS13",{
	panel = "BPSNFront",
	button = "ARS13Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
--[[
Metrostroi.ClientPropForButton("Radio13",{
	panel = "BPSNFront",
	button = "Radio13Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
]]

-- Customs
Metrostroi.ClientPropForButton("Custom1",{
	panel = "Announcer",
	button = "Custom1Set",
	model = "models/metrostroi/81-717/button10.mdl"
})
Metrostroi.ClientPropForButton("Custom2",{
	panel = "Announcer",
	button = "Custom2Set",
	model = "models/metrostroi/81-717/button10.mdl"
})
Metrostroi.ClientPropForButton("Custom3",{
	panel = "Announcer",
	button = "Custom3Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("Custom4",{
	panel = "Announcer",
	button = "Custom4Set",
	model = "models/metrostroi/81-717/button09.mdl"
})

Metrostroi.ClientPropForButton("Custom5",{
	panel = "Announcer",
	button = "Custom5Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("Custom6",{
	panel = "Announcer",
	button = "Custom6Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("Custom7",{
	panel = "Announcer",
	button = "Custom7Set",
	model = "models/metrostroi/81-717/button07.mdl"
})
Metrostroi.ClientPropForButton("Custom8",{
	panel = "Announcer",
	button = "Custom8Set",
	model = "models/metrostroi/81-717/button09.mdl"
})

Metrostroi.ClientPropForButton("CustomA",{
	panel = "Announcer",
	button = "CustomAToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("CustomB",{
	panel = "Announcer",
	button = "CustomBToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("CustomC",{
	panel = "Announcer",
	button = "CustomCToggle",
	model = "models/metrostroi/81-717/switch04.mdl",
})

Metrostroi.ClientPropForButton("CustomD",{
	panel = "Announcer",
	button = "CustomD",
	model = "models/metrostroi/81-717/light01.mdl",
})
Metrostroi.ClientPropForButton("CustomE",{
	panel = "Announcer",
	button = "CustomE",
	model = "models/metrostroi/81-717/light03.mdl",
})
Metrostroi.ClientPropForButton("CustomF",{
	panel = "Announcer",
	button = "CustomF",
	model = "models/metrostroi/81-717/light04.mdl",
})
Metrostroi.ClientPropForButton("CustomG",{
	panel = "Announcer",
	button = "CustomG",
	model = "models/metrostroi/81-717/light02.mdl",
})
--Metrostroi.ClientPropForButton("Autodrive",{
--	panel = "Main",
--	button = "AutodriveToggle",
--	model = "models/metrostroi/81-717/switch04.mdl",
--})
--PA-KSD
Metrostroi.ClientPropForButton("Indicate",{
	panel = "PAKSD",
	button = "IndicateToggle",	
	model = "models/metrostroi_train/81/indikaciya.mdl",
	z = 6,
	ang = 125,
})
Metrostroi.ClientPropForButton("BCCD",{
	panel = "PAKSD",
	button = "BCCDSet",	
	model = "models/metrostroi/81-717/button07.mdl",
})
Metrostroi.ClientPropForButton("VZP",{
	panel = "PAKSD",
	button = "VZPToggle",	
	model = "models/metrostroi/81-717/switch04.mdl",
})
Metrostroi.ClientPropForButton("B7",{
	panel = "PAKSD",
	button = "B7Set",	
	model = "models/metrostroi_train/81/paksd7.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B8",{
	panel = "PAKSD",
	button = "B8Set",	
	model = "models/metrostroi_train/81/paksd8.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B9",{
	panel = "PAKSD",
	button = "B9Set",	
	model = "models/metrostroi_train/81/paksd9.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BLeft",{
	panel = "PAKSD",
	button = "BLeftSet",	
	model = "models/metrostroi_train/81/paksdLeft.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B4",{
	panel = "PAKSD",
	button = "B4Set",	
	model = "models/metrostroi_train/81/paksd4.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B5",{
	panel = "PAKSD",
	button = "B5Set",	
	model = "models/metrostroi_train/81/paksd5.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B6",{
	panel = "PAKSD",
	button = "B6Set",	
	model = "models/metrostroi_train/81/paksd6.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BUp",{
	panel = "PAKSD",
	button = "BUpSet",	
	model = "models/metrostroi_train/81/paksdUp.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B1",{
	panel = "PAKSD",
	button = "B1Set",	
	model = "models/metrostroi_train/81/paksd1.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B2",{
	panel = "PAKSD",
	button = "B2Set",	
	model = "models/metrostroi_train/81/paksd2.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B3",{
	panel = "PAKSD",
	button = "B3Set",	
	model = "models/metrostroi_train/81/paksd3.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BDown",{
	panel = "PAKSD",
	button = "BDownSet",	
	model = "models/metrostroi_train/81/paksdDown.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("B0",{
	panel = "PAKSD",
	button = "B0Set",	
	model = "models/metrostroi_train/81/paksd0.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BMinus",{
	panel = "PAKSD",
	button = "BMinusSet",	
	model = "models/metrostroi_train/81/paksdminus.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BPlus",{
	panel = "PAKSD",
	button = "BPlusSet",	
	model = "models/metrostroi_train/81/paksdPlus.mdl",
	ang = 0,
})
Metrostroi.ClientPropForButton("BEnter",{
	panel = "PAKSD",
	button = "BEnterSet",	
	model = "models/metrostroi_train/81/paksdEnter.mdl",
	ang = 0,
})

--------------------------------------------------------------------------------
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(123,62.5+1.0,-65),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(123,62.5+1.0,-65),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
function ENT:SetAutobreakersPos(ps)
	
end
for x=0,11 do
	for y=0,3 do
		if (x+12*y) == 37 then continue end
		ENT.ClientProps["a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(407.3,-10.5+x*3.26,47-y*10.6),
			ang = Angle(90,0,0)
		}
		Metrostroi.InsertHide("AV","a"..(x+12*y))
	end
end

ENT.ClientProps["L_5"] ={	
	model = "models/metrostroi/81-717/circuit_breaker.mdl",
	pos = Vector(407.3,-10.5+1*3.26,47-3*10.6),
	ang = Angle(90,0,0)
}
Metrostroi.InsertHide("AV","L_5")

for x=0,11 do
	for y=0,3 do
		if (x+12*y) == 37 then continue end
		ENT.ClientProps["1_a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(407.3,-10.5+x*3.26,47-y*10.6)+ Vector(12,-47,0.5),
			ang = Angle(90,0,0)
		}
		Metrostroi.InsertHide("AV_1","1_a"..(x+12*y))
	end
end

ENT.ClientProps["L_5_1"] ={	
	model = "models/metrostroi/81-717/circuit_breaker.mdl",
	pos = Vector(407.3,-10.5+1*3.26,47-3*10.6)+ Vector(12,-47,0.5),
	ang = Angle(90,0,0)
}
Metrostroi.InsertHide("AV_1","L_5_1")
--[[
]]
Metrostroi.ClientPropForButton("battery",{
	panel = "Battery",
	button = "VBToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})
Metrostroi.ClientPropForButton("RC1",{
	panel = "Battery",
	button = "RC1Toggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("UOS",{
	panel = "Battery",
	button = "UOSToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("VPA",{
	panel = "Battery",
	button = "VPAToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("BPS",{
	panel = "Battery",
	button = "BPSToggle",
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("battery_2",{
	panel = "Battery_2",
	button = "VBToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})
Metrostroi.ClientPropForButton("RC1_2",{
	panel = "Battery_2",
	button = "RC1Toggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("UOS_2",{
	panel = "Battery_2",
	button = "UOSToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})
Metrostroi.ClientPropForButton("VPA_2",{
	panel = "Battery_2",
	button = "VPAToggle",	
	model = "models/metrostroi/81-717/rc.mdl",
})

Metrostroi.ClientPropForButton("BPS_2",{
	panel = "Battery_2",
	button = "BPSToggle",
	model = "models/metrostroi/81-717/rc.mdl",
})
--------------------------------------------------------------------------------
ENT.ClientProps["book"] = {
	model = "models/props_lab/binderredlabel.mdl",
	pos = Vector(450.0,-40.0-1.5,0.8),
	ang = Angle(0,50,90)
}

ENT.ClientProps["FrontBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(460, -26.8, -53),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["FrontTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(460, 26, -53.7),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["RearBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(-465, -26.2, -53.7),
	ang = Angle(0,90,0)
}
ENT.ClientProps["RearTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(-465, 26, -53),
	ang = Angle(0,90,0)
}
ENT.ClientProps["PB"] = {--
	model = "models/metrostroi_train/81/pb.mdl",
	pos = Vector(461.5, 13.5, -29),
	ang = Angle(0,-90,40)
}

--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0 
	then return Vector(366.0 - 35.5*k     - 234.5*i,-67*(1-2*k),7.5)
	else return Vector(366.0 - 35.5*(1-k) - 234.5*i,-67*(1-2*k),7.5)
	end
end
for i=0,3 do
	for k=0,1 do
		ENT.ClientProps["door"..i.."x"..k.."a"] = {
			model = "models/metrostroi_train/81/leftdoor2.mdl",
			pos = GetDoorPosition(i,k,0),
			ang = Angle(0,90 +180*k,0)
		}
		ENT.ClientProps["door"..i.."x"..k.."b"] = {
			model = "models/metrostroi_train/81/leftdoor1.mdl",
			pos = GetDoorPosition(i,k,1),
			ang = Angle(0,90 +180*k,0)
		}
	end 
end
--24.2 0.2 5.3
ENT.ClientProps["door1"] = {
	model = "models/metrostroi_train/81/backdoor.mdl",
	pos = Vector(-479.0,16.4,6),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi_train/81/passdoor.mdl",
	pos = Vector(389.0,29.0,6.5),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi_train/81/cabindoor.mdl",
	pos = Vector(456.6,67.0,7.1),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["UAVA"] = {
	model = "models/metrostroi/81-717/uava_body.mdl",
	pos = Vector(435.0,-58.5,-11.0),
	ang = Angle(0,0,0)
}
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi/81-717/real_uava.mdl",
	pos = Vector(439.0,-58.8,-13.2),
	ang = Angle(215,90,270)
}

--ENT.AutoPos = {Vector(407.3,-10.5,47),Vector(419.3,-57.5,47.5)}
--local X = Material( "metrostroi_skins/81-717/6.png")

function ENT:Initialize()
	self.BaseClass.Initialize(self)
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
	--if self.Breakers == nil then self.Breakers = false end
	if self.Breakers ~= self:GetNWBool("Breakers") then
		self.Breakers = self:GetNWBool("Breakers")
		self:HidePanel("Battery",self.Breakers)
		self:HidePanel("Battery_2",not self.Breakers)
		self:HidePanel("AV",self.Breakers)
		self:HidePanel("AV_1",not self.Breakers)
		self:ShowHide("UOS",(not self.ARSType or self.ARSType < 3) and not self.Breakers)
		self:ShowHide("UOS_2",(not self.ARSType or self.ARSType < 3) and self.Breakers)
		self:ShowHide("VPA",self.ARSType and self.ARSType == 3 and not self.Breakers)
		self:ShowHide("VPA_2",self.ARSType and self.ARSType == 3 and self.Breakers)
	end
	if self.ARSType ~= self:GetNWInt("ARSType",1) then
		self.ARSType = self:GetNWInt("ARSType",1)
		self:ShowHide("ALS",self.ARSType < 3)
		self:ShowHide("R_Program",self.ARSType < 3)
		self:ShowHide("Program1",self.ARSType < 3)
		self:ShowHide("Program2",self.ARSType < 3)
		self:ShowHide("R_Program1Set",self.ARSType < 3)
		self:ShowHide("R_Program2Set",self.ARSType < 3)
		self:ShowHide("UOS",self.ARSType < 3 and not self.Breakers)
		self:ShowHide("UOS_2",self.ARSType < 3 and self.Breakers)
		self:ShowHide("VPA",self.ARSType == 3 and not self.Breakers)
		self:ShowHide("VPA_2",self.ARSType == 3 and self.Breakers)
		self:ShowHide("R_Radio",self.ARSType < 3)
		self:HidePanel("Announcer",self.ARSType == 3)
		self:HidePanel("AnnouncerDisplay",self.ARSType == 3)
		self:HidePanel("PAKSD",self.ARSType < 3)
		self:HidePanel("PAKSD1",self.ARSType < 3)
		self:HidePanel("PAKSD2",self.ARSType < 3)
	end
	--Vector(407.3,-10.5,47)+ps
	--Vector(417.3,-57.5,47.5)
	--[[
		self:RemoveCSEnts()
		self.Breakers = self:GetNWBool("Breakers")

		self:SetAutobreakersPos(self:GetNWBool("Breakers") and Vector(12,-47,0.5) or Vector())
	
		self.ButtonMap["Battery"] = self.BatteryMap[self.Breakers and 2 or 1]
		
		self:ClientPropForButton("battery",{
			panel = "Battery",
			button = "VBToggle",	
			model = "models/metrostroi/81-717/rc.mdl",
		})
		self:ClientPropForButton("RC1",{
			panel = "Battery",
			button = "RC1Toggle",	
			model = "models/metrostroi/81-717/rc.mdl",
		})

		self:ClientPropForButton("UOS",{
			panel = "Battery",
			button = "UOSToggle",	
			model = "models/metrostroi/81-717/rc.mdl",
		})

		self:ClientPropForButton("BPS",{
			panel = "Battery",
			button = "BPSToggle",	
			model = "models/metrostroi/81-717/rc.mdl",
		})
		--PrintTable(self.ButtonMap["Battery"])
		--self:ReloadCLPropPosAng("battery","Battery","VBToggle")
		--self:ReloadCLPropPosAng("RC1","Battery","RC1Toggle")
		--self:ReloadCLPropPosAng("UOS","Battery","UOSToggle")
		--self:ReloadCLPropPosAng("BPS","Battery","BPSToggle")
		self:CreateCSEnts()
		self.Reloaded = false
	end
	]]
	--self.ButtonMap["Battery"].pos = Vector(419.0,-55.5,38) + (self:GetNWBool("Breakers") and Vector(12,-47,0.5) or Vector())
	for i = 0,33 do
		--self:SetSubMaterial(i,"")
	end
	--[[
	if not self.Animate then self.BaseClass = baseclass.Get("gmod_subway_base") end
	if self.RearDoor < 90 and self:GetPackedBool(156) or self.RearDoor > 0 and not self:GetPackedBool(156) then
		local RearDoorData = self.ClientProps["door1"]
		--RearDoor:SetLocalPos(RearDoorData.pos + Vector(-2,-0,0))
		self.RearDoor = math.max(0,math.min(90,self.RearDoor + (self:GetPackedBool(156)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door1",Vector(0,16,0),Angle(0,self.RearDoor,0))
	end
	if not self.ClientPropsMatrix["door1"] or self.ClientPropsMatrix["door1"]:GetAngles().yaw ~= self.RearDoor then
		self:ApplyMatrix("door1",Vector(0,-16,0),Angle(0,self.RearDoor,0))
	end
	if self.PassengerDoor < 90 and self:GetPackedBool(158) or self.PassengerDoor > 0 and not self:GetPackedBool(158) then
		local PassengerDoorData = self.ClientProps["door1"]
		--PassengerDoor:SetLocalPos(PassengerDoorData.pos + Vector(-2,-0,0))
		self.PassengerDoor = math.max(0,math.min(90,self.PassengerDoor + (self:GetPackedBool(158)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door2",Vector(0,-16,0),Angle(0,self.PassengerDoor,0))
	end
	if not self.ClientPropsMatrix["door2"] or self.ClientPropsMatrix["door2"]:GetAngles().yaw ~= self.PassengerDoor then
		self:ApplyMatrix("door2",Vector(0,-16,0),Angle(0,self.PassengerDoor,0))
	end
	if self.CabinDoor < 90 and self:GetPackedBool(159) or self.CabinDoor > 0 and not self:GetPackedBool(159) then
		local CabinDoorData = self.ClientProps["door1"]
		--CabinDoor:SetLocalPos(CabinDoorData.pos + Vector(-2,-0,0))
		self.CabinDoor = math.max(0,math.min(90,self.CabinDoor + (self:GetPackedBool(159)  and 1 or -1)*self.DeltaTime*180))
		self:ApplyMatrix("door3",Vector(16,0,0),Angle(0,self.CabinDoor,0))
	end
	if not self.ClientPropsMatrix["door3"] or self.ClientPropsMatrix["door3"]:GetAngles().yaw ~= self.door3 then
		self:ApplyMatrix("door3",Vector(0,-16,0),Angle(0,self.CabinDoor,0))
	end
	]]
	-- Distance cull
	local distance = self:GetPos():Distance(LocalPlayer():GetPos())
	if distance > 8192 then return end
	for i = 0,8 do
		--print(i,self:GetBodygroupName(i))
	end
--[[
	self:SetBodygroup(0,(self.ARSType or 1)-1)
	self:SetBodygroup(1,(self.LampType or 1)-1)
	self:SetBodygroup(3,(self.MaskType or 1)-1)
	self:SetBodygroup(4,(self.SeatType or 1)-1)
	self:SetBodygroup(5,(self.HandRail or 1)-1)
	self:SetBodygroup(6,self.MVM and (self.MaskType > 2 and 1 or 0) or 2)
	self:SetBodygroup(7,(self.BortLampType or 1)-1)
	]]
	local transient = (self.Transient or 0)*0.05
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end
	self.KRUPos = self.KRUPos or 0
	if self:GetPackedBool(27) 
	then self.KRUPos = self.KRUPos + (0.0 - self.KRUPos)*8.0*self.DeltaTime
	else self.KRUPos = 1.0
	end

	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake334", 		1-self:GetPackedRatio(0), 			0.00, 0.65,  256,24)
	self:Animate("brake013", 		self:GetPackedRatio(0)^0.5,			0.00, 0.65,  256,24)
	--print(self:GetPackedBool(163))
	self:Animate("controller",		1-self:GetPackedRatio(1),			0.38 - (self:GetPackedBool(164) and 0.04 or 0), 0.78 - (self:GetPackedBool(164) and 0.1 or 0),  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.45, 0.56,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.385, 0.647,				nil, nil,  256,2,0.01)
	self:ShowHide("reverser",		self:GetPackedBool(0))
	self:Animate("krureverser",		0.5+(0.5-self.KRUPos*0.5)-0.5*(self:GetPackedRatio(2)/2),		0.10, 0.90,  3,false)
	self:ShowHide("krureverser",	self:GetPackedBool(27))

	self:ShowHide("brake013",		self:GetPackedBool(22))
	self:ShowHide("brake334",		not self:GetPackedBool(22))
	self:ShowHide("brake334_body",	not self:GetPackedBool(22))
	--print(self:GetPackedRatio(6))
	self:Animate("brake_line",		self:GetPackedRatio(4),				0.14, 0.835,  256,2)--,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5)-transient,	0.14, 0.835,  4096,0)--,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.185, 0.815,  256,2)--,0.03)
	--print(self:GetPackedRatio(7))
	--print((math.sin(CurTime()%4/4/math.pi*30)+2)/2-0.5)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.419, 0.620,				nil, nil)--,  256,2,0.01)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.42, 0.627,				nil, nil,  256,2,0.01)
	
	self:Animate("headlights",		self:GetPackedBool(1) and 1 or 0, 	0,1, 8, false)
	self:Animate("VozvratRP",		self:GetPackedBool(2) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPon",			self:GetPackedBool(3) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPoff",			self:GetPackedBool(4) and 1 or 0, 	0,1, 16, false)	
	self:Animate("brake_disconnect",self:GetPackedBool(6) and 1 or 0, 	1,0.5, 3, false)
	self:Animate("battery",			self:GetPackedBool(7) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("battery_2",			self:GetPackedBool(7) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("VPA",			self:GetPackedBool("VPA") and 0.87 or 1, 	0,1, 1, false)
	self:Animate("VPA_2",			self:GetPackedBool("VPA") and 0.87 or 1, 	0,1, 1, false)
	self:Animate("RezMK",			self:GetPackedBool(8) and 1 or 0, 	0,1, 16, false)
	self:Animate("VMK",				self:GetPackedBool(9) and 1 or 0, 	0,1, 16, false)
	self:Animate("VAH",				self:GetPackedBool(10) and 1 or 0, 	0,1, 16, false)
	self:Animate("VAD",				self:GetPackedBool(11) and 1 or 0, 	0,1, 16, false)
	self:Animate("VUD1",			1-(self:GetPackedBool(12) and 1 or 0), 	0,1, 16, false)
	self:Animate("VUD2",			self:GetPackedBool(13) and 1 or 0, 	0,1, 16, false)
	self:Animate("VDL",				self:GetPackedBool(14) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDL",				self:GetPackedBool(15) and 1 or 0, 	0,1, 16, false)
	self:Animate("KDP",				self:GetPackedBool(16) and 1 or 0, 	0,1, 16, false)
	self:Animate("KRZD",			self:GetPackedBool(17) and 1 or 0, 	0,1, 16, false)
	self:Animate("KSN",				self:GetPackedBool(18) and 1 or 0, 	0,1, 16, false)
	self:Animate("OtklAVU",			self:GetPackedBool(19) and 1 or 0, 	0,1, 16, false)
	self:Animate("DURAPower",		self:GetPackedBool(24) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectMain",		self:GetPackedBool(29) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectAlternate",	self:GetPackedBool(30) and 1 or 0, 	0,1, 16, false)
	self:Animate("SelectChannel",	self:GetPackedBool(31) and 1 or 0, 	0,1, 16, false)
	self:Animate("ARS",				self:GetPackedBool(56) and 1 or 0, 	0,1, 16, false)
	self:Animate("ALS",				self:GetPackedBool(57) and 1 or 0, 	0,1, 16, false)
	self:Animate("KVT",				self:GetPackedBool(28) and 1 or 0, 	0,1, 16, false)
	self:Animate("KB",			self:GetPackedBool(28) and 1 or 0, 	0,1, 16, false)
	self:Animate("BPSNon",			self:GetPackedBool(59) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_1",				self:GetPackedBool(60) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_2",				self:GetPackedBool(61) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_3",				self:GetPackedBool(62) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_4",				self:GetPackedBool(63) and 1 or 0, 	0,1, 16, false)
	self:Animate("L_5",				self:GetPackedBool(53) and 1 or 0,0,1,8,false)
	self:Animate("L_5_1",				self:GetPackedBool(53) and 1 or 0,0,1,8,false)
	self:Animate("DoorSelect",		self:GetPackedBool(55) and 1 or 0, 	0,1, 16, false)	
	self:Animate("KRP",				self:GetPackedBool(113) and 1 or 0, 0,1, 16, false)	
	self:Animate("Custom1",			self:GetPackedBool(114) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom2",			self:GetPackedBool(115) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom3",			self:GetPackedBool(116) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom4",			self:GetPackedBool(117) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom5",			self:GetPackedBool(118) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom6",			self:GetPackedBool(119) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom7",			self:GetPackedBool(120) and 1 or 0, 0,1, 16, false)
	self:Animate("Custom8",			self:GetPackedBool(121) and 1 or 0, 0,1, 16, false)
	self:Animate("CustomA",			self:GetPackedBool(122) and 1 or 0, 0,1, 16, false)
	self:Animate("CustomB",			self:GetPackedBool(123) and 1 or 0, 0,1, 16, false)
	self:Animate("CustomC",			self:GetPackedBool(124) and 1 or 0, 0,1, 16, false)
	self:Animate("R_G",				self:GetPackedBool(125) and 1 or 0, 0,1, 16, false)
	self:Animate("R_Radio",			self:GetPackedBool(126) and 1 or 0, 0,1, 16, false)
	self:Animate("R_UNch",			self:GetPackedBool(127) and 1 or 0, 0,1, 16, false)
	self:Animate("R_Program",		self:GetPackedBool(128) and 0 or (self:GetPackedBool(129) and 1 or 0.5), 0,1, 16, false)
	self:Animate("Program1",		self:GetPackedBool(128) and 1 or 0, 0,1, 16, false)
	self:Animate("Program2",		self:GetPackedBool(129) and 1 or 0, 0,1, 16, false)
	self:Animate("RC1",				self:GetPackedBool(130) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UOS",				self:GetPackedBool(134) and 1 or 0.87, 	0,1, 1, false)
	self:Animate("BPS",				self:GetPackedBool(135) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("RC1_2",				self:GetPackedBool(130) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("UOS_2",				self:GetPackedBool(134) and 1 or 0.87, 	0,1, 1, false)
	self:Animate("BPS_2",				self:GetPackedBool(135) and 0.87 or 1, 	0,1, 1, false)
	--self:Animate("Autodrive",		self:GetPackedBool(132) and 1 or 0,	0,1, 16, false)
	self:Animate("ARS13",			self:GetPackedBool(150) and 1 or 0, 0,1, 16, false)
	self:Animate("Radio13",			self:GetPackedBool(151) and 1 or 0, 0,1, 16, false)
	self:Animate("UAVALever",	self:GetPackedBool(152) and 1 or 0, 	0,0.25, 128,  3,false)
	self:Animate("EPK_disconnect",	self:GetPackedBool(155) and 0 or 1,0,0.5, 3, false)
	self:Animate("ParkingBrake",	self:GetPackedBool(160) and 0 or 1,0,0.5, 3, false)
	self:Animate("KAH",	self:GetPackedBool(163) and 1 or 0,0,1, 16, false)
	self:Animate("Indicate",self:GetPackedBool("Indicate3") and 0.4 or self:GetPackedBool("Indicate2") and 0.29 or self:GetPackedBool("Indicate1") and 0.17 or 0,0.0,1,2,false)
	self:Animate("BCCD",self:GetPackedBool("BCCD") and 1 or 0,0,1,8,false)
	self:Animate("VZP",self:GetPackedBool("VZP") and 1 or 0,0,1,8,false)
	self:Animate("B7",self:GetPackedBool("B7") and 1 or 0,0,1,8,false)
	self:Animate("B8",self:GetPackedBool("B8") and 1 or 0,0,1,8,false)
	self:Animate("B9",self:GetPackedBool("B9") and 1 or 0,0,1,8,false)
	self:Animate("BLeft",self:GetPackedBool("BLeft") and 1 or 0,0,1,8,false)
	self:Animate("B4",self:GetPackedBool("B4") and 1 or 0,0,1,8,false)
	self:Animate("B5",self:GetPackedBool("B5") and 1 or 0,0,1,8,false)
	self:Animate("B6",self:GetPackedBool("B6") and 1 or 0,0,1,8,false)
	self:Animate("BUp",self:GetPackedBool("BUp") and 1 or 0,0,1,8,false)
	self:Animate("B1",self:GetPackedBool("B1") and 1 or 0,0,1,8,false)
	self:Animate("B2",self:GetPackedBool("B2") and 1 or 0,0,1,8,false)
	self:Animate("B3",self:GetPackedBool("B3") and 1 or 0,0,1,8,false)
	self:Animate("BDown",self:GetPackedBool("BDown") and 1 or 0,0,1,8,false)
	self:Animate("B0",self:GetPackedBool("B0") and 1 or 0,0,1,8,false)
	self:Animate("BMinus",self:GetPackedBool("BMinus") and 1 or 0,0,1,8,false)
	self:Animate("BPlus",self:GetPackedBool("BPlus") and 1 or 0,0,1,8,false)
	self:Animate("BEnter",self:GetPackedBool("BEnter") and 1 or 0,0,1,8,false)
	if self:GetPackedBool(156) and not self.Door1 then self.Door1 = 0.99 end
	if self:GetPackedBool(158) and not self.Door2 then self.Door2 = 0.99 end
	if self:GetPackedBool(159) and not self.Door3 then self.Door3 = 0.99 end
	if not self:GetPackedBool(156) and self.Door1 then self.Door1 = false end
	if not self:GetPackedBool(158) and self.Door2 then self.Door2 = false end
	if not self:GetPackedBool(159) and self.Door3 then self.Door3 = false end
	
	local accel = self:GetNWFloat("Accel")
	
	if math.abs(accel) > 0.1 then
		--if self.Door1 then self.Door1 = math.min(0.99,math.max(0,self.Door1+accel*self.DeltaTime)) end
		--if self.Door2 then self.Door2 = math.min(0.99,math.max(0,self.Door2+accel*self.DeltaTime)) end
		--if self.Door3 then self.Door3 = math.min(0.99,math.max(0,self.Door3+accel*self.DeltaTime)) end
	end
	if self.Door1 == 0.99 then
		--sendButtonMessage({ID = "BackDoor",state = true})
		--sendButtonMessage({ID = "BackDoor",state = false})
	end
	if self.Door2 == 0.99 then
		--sendButtonMessage({ID = "PassDoor",state = true})
		--sendButtonMessage({ID = "PassDoor",state = false})
	end
	if self.Door3 == 0.99 then
		--sendButtonMessage({ID = "CabinDoor",state = true})
		--sendButtonMessage({ID = "CabinDoor",state = false})
	end
	
	self:Animate("door1",	self:GetPackedBool(156) and (self.Door1 or 0.99) or 0,0,0.54, 1024, 1)
	self:Animate("door2",	self:GetPackedBool(158) and (self.Door2 or 0.99) or 0,0,0.51, 1024, 1)
	self:Animate("door3",	self:GetPackedBool(159) and (self.Door3 or 0.99) or 0,0,0.54, 1024, 1)

	self:Animate("FrontBrake", self:GetNWBool("FbI") and 0 or 1,0,0.35, 3, false)
	self:Animate("FrontTrain",	self:GetNWBool("FtI") and 0 or 1,0,0.35, 3, false)
	self:Animate("RearBrake",	self:GetNWBool("RbI") and 1 or 0,0,0.35, 3, false)
	self:Animate("RearTrain",	self:GetNWBool("RtI") and 1 or 0,0,0.35, 3, false)

	self:Animate("PB",	self:GetPackedBool(165) and 1 or 0,0,0.2,  8,false)
	-- Animate AV switches
	for i,v in ipairs(self.Panel.AVMap) do
		local value = self:GetPackedBool(64+(i-1)) and 1 or 0
		self:Animate("a"..(i-1),value,0,1,8,false)
		self:Animate("1_a"..(i-1),value,0,1,8,false)
	end	
	--print(self.ClientProps["a0"])
	-- Main switch
	if self.LastValue ~= self:GetPackedBool(5) then
		self.ResetTime = CurTime()+1.5
		self.LastValue = self:GetPackedBool(5)
	end
	self:Animate("gv_wrench",	(self:GetPackedBool(5) and 1 or 0), 	0,0.51, 128,  1,false)
	self:ShowHide("gv_wrench",	CurTime() < self.ResetTime)
	self.TextureTime = self.TextureTime or CurTime()
	if (CurTime() - self.TextureTime) > 5.0 and self:GetNWString("texture",nil) then
		--print(1)
	--Vector(407.3,-10.5,47)+ps
	--Vector(417.3,-57.5,47.5)
	--[[
		if not self.ClientProps["a0"] or self.ClientProps["a0"].pos ~= self.AutoPos[self.Breakers and 2 or 1] then
			print(1)
			self:RemoveCSEnts()
			self.Breakers = self:GetNWBool("Breakers")

			self:SetAutobreakersPos(self:GetNWBool("Breakers") and Vector(12,-47,0.5) or Vector())
		
			self.ButtonMap["Battery"] = self.BatteryMap[self.Breakers and 2 or 1]
			
			self:ClientPropForButton("battery",{
				panel = "Battery",
				button = "VBToggle",	
				model = "models/metrostroi/81-717/rc.mdl",
			})
			self:ClientPropForButton("RC1",{
				panel = "Battery",
				button = "RC1Toggle",	
				model = "models/metrostroi/81-717/rc.mdl",
			})

			self:ClientPropForButton("UOS",{
				panel = "Battery",
				button = "UOSToggle",	
				model = "models/metrostroi/81-717/rc.mdl",
			})

			self:ClientPropForButton("BPS",{
				panel = "Battery",
				button = "BPSToggle",	
				model = "models/metrostroi/81-717/rc.mdl",
			})
			--PrintTable(self.ButtonMap["Battery"])
			--self:ReloadCLPropPosAng("battery","Battery","VBToggle")
			--self:ReloadCLPropPosAng("RC1","Battery","RC1Toggle")
			--self:ReloadCLPropPosAng("UOS","Battery","UOSToggle")
			--self:ReloadCLPropPosAng("BPS","Battery","BPSToggle")
			self:CreateCSEnts()
			self.Reloaded = false
		end
		]]
		self.TextureTime = CurTime()
		for tex,ent in pairs(self.ClientEnts) do
			if tex:find("door") then
				for k,v in pairs(ent:GetMaterials()) do
						--print(v)
					if v == "models/metrostroi_train/81/b01a" then
						ent:SetSubMaterial(k-1,self:GetNWString("texture"))
					elseif v == "models/metrostroi_train/81/int01" then
						ent:SetSubMaterial(k-1,self:GetNWString("passtexture"))
					else
						ent:SetSubMaterial(k-1,"")
					end
				end
			end
		end
	end
	-- Animate doors
	for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			--local animation = self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			--local offset_l = Vector(math.abs(31*animation),0,0)
			--local offset_r = Vector(math.abs(32*animation),0,0)
			self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			self:Animate(n_r,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			if self.ClientEnts[n_l] then
				
				--self.ClientEnts[n_l]:SetSkin(self:GetSkin())
			end
			if self.ClientEnts[n_r] then
				--self.ClientEnts[n_r]:SetPos(self:LocalToWorld(self.ClientProps[n_r].pos - (1.0 - 2.0*k)*offset_r))
				--self.ClientEnts[n_r]:SetSkin(self:GetSkin())
			end
		end
	end
	--if self.ClientEnts["door1"] then self.ClientEnts["door1"]:SetSkin(self:GetSkin()) end
	--if self.ClientEnts["door2"] then self.ClientEnts["door2"]:SetSkin(self:GetSkin()) end
	--if self.ClientEnts["door3"] then self.ClientEnts["door3"]:SetSkin(self:GetSkin()) end
	
	-- Door transient
	local door_state1 = self:GetPackedBool(21)
	local door_state2 = self:GetPackedBool(25)
	if door_state1 ~= self.PrevDoorState1 then
		self.PrevDoorState1 = door_state1
		self.Transient = 1.00
	end
	if door_state2 ~= self.PrevDoorState2 then
		self.PrevDoorState2 = door_state2
		self.Transient = 1.00
	end

	-- Brake-related sounds
	local brakeLinedPdT = self:GetPackedRatio(9)
	local dT = self.DeltaTime
	self.BrakeLineRamp1 = self.BrakeLineRamp1 or 0
	--print(brakeLinedPdT)

	if (brakeLinedPdT > -0.001)
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 2.0*((-0.4*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self:SetSoundState("release2",(self.BrakeLineRamp1^1.35)*0.75,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 2.0*(0.02*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self:SetSoundState("release3",self.BrakeLineRamp2,1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if not state then
			self:PlayOnce("compressor_end",nil,0.75)		
		end
	end
	self:SetSoundState("compressor",state and 1 or 0,1,nil,0.75)
	
	-- ARS/ringer alert
	local state = self:GetPackedBool(39)
	self.PreviousAlertState = self.PreviousAlertState or false
	if self.PreviousAlertState ~= state then
		self.PreviousAlertState = state
		if state then
			if self.ARSType == 3 then self:SetSoundState("ring3",0.20,1) else self:SetSoundState("ring2",0.20,1) end
		else
			self:SetSoundState("ring3",0,0)
			self:SetSoundState("ring2",0,0)
			if self.ARSType == 3 then self:PlayOnce("ring3_end","cabin",0.45) else self:PlayOnce("ring2_end","cabin",0.45) end
		end
	end
	
	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	local state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self.PreviousRKState = self.PreviousRKState or false
	if self.PreviousRKState ~= state then
		self.PreviousRKState = state
		if state then
			self:SetSoundState("rk_spin",0.67,1)
		else
			self:SetSoundState("rk_spin",0,0)
			self:PlayOnce("rk_stop",nil,0.67)
		end
	end
	
	-- IGLA alert
	--local state = true --self:GetPackedBool(39)
	--self:SetSoundState("ring2",0.20,1)
	
	-- DIP sound
	self.BPSNType = self:GetNWInt("BPSNType",6)
	if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
	if self.BPSNType ~= self.OldBPSNType then
		self:SetSoundState("bpsn"..self.OldBPSNType,0,1.0)
	end
	self:SetSoundState("bpsn"..self.BPSNType,self:GetPackedBool(52) and 2 or 0,1.0,nil,0.9)
	self.OldBPSNType = self.BPSNType
end

function ENT:Draw()
	self.BaseClass.Draw(self)
end
ENT.ParkingBrakeMaterial = Material( "models/metrostroi_train/parking_brake.png", "vertexlitgeneric unlitgeneric mips" )
function ENT:DrawPost()
	--local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))
	self:DrawOnPanel("InfoTable",function()
	end)
	self:DrawOnPanel("PAKSD1",function(...) self["PA-KSD"]:PAKSD1(self,...) end)
	self:DrawOnPanel("PAKSD2",function(...) self["PA-KSD"]:PAKSD2(self,...) end)

	if self.InfoTableTimeout and (CurTime() < self.InfoTableTimeout) then
		self:DrawOnPanel("InfoTableSelect",function()
			local text = self:GetNWString("FrontText","")
			local col = text:find("ЗЕЛ") and Color(100,200,0) or text:find("СИН") and Color(0,100,200) or text:find("МАЛ") and Color(200,100,200) or text:find("ОРА") and Color(200,200,0) or Color(255,0,0)
			draw.DrawText(self:GetNWString("RouteNumber","") .. " " .. text,"MetrostroiSubway_InfoPanel",260, -100,col,TEXT_ALIGN_CENTER)
			--[[
			draw.Text({
				text = self:GetNWString("RouteNumber","") .. " " .. self:GetNWString("FrontText",""),
				font = "MetrostroiSubway_InfoPanel",--..self:GetNWInt("Style",1),
				pos = { 260, -100 },
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = Color(255,0,0,255)})
			]]
		end)
	end

	self:DrawOnPanel("InfoRoute",function()
		surface.SetDrawColor(142,132,101) --255*dc.x,250*dc.y,220*dc.z)
		surface.DrawRect(0,100,88,70)
		draw.Text({
			text = self:GetNWString("RouteNumber",""),
			font = "MetrostroiSubway_InfoRoute",--..self:GetNWInt("Style",1),
			pos = { 44, 135 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
	end)
	
	-- Distance cull
	local distance = self:GetPos():Distance(LocalPlayer():GetPos())
	if distance > 1024 then return end
	self.ButtonMap["ARS"] = self.ARSMap[math.max(1,math.min(3,self:GetNWInt("ARSType",1)))]
	self:DrawOnPanel("ARS",function()
		if self:GetNWInt("ARSType",1) ~= 2 then return end
		surface.SetAlphaMultiplier(0.7)
		surface.SetDrawColor(0,0,0)
		surface.DrawRect(48*10,20*10,24*10,24*10)
		surface.SetAlphaMultiplier(1.0)
		if not self:GetPackedBool(32) then return end
		
		local speed = self:GetPackedRatio(3)*100.0
		local d1 = math.floor(speed) % 10
		local d2 = math.floor(speed / 10) % 10
		self:DrawDigit((51+0) *10,	29*10, d2, 0.75, 0.60)
		self:DrawDigit((51+11)*10,	29*10, d1, 0.75, 0.60)
		surface.SetAlphaMultiplier(1)
	end)

	self:DrawOnPanel("ARSKyiv",function()
		if self:GetNWInt("ARSType",1) ~= 3 then return end
		if not self:GetPackedBool(32) then return end
		
		local speed = self:GetPackedRatio(3)*100.0
		local d1 = math.floor(speed) % 10
		local d2 = math.floor(speed / 10) % 10
		self:DrawDigit((136+0) *10,	26*10, d2, 1.00, 0.85)
		self:DrawDigit((136+20)*10,	26*10, d1, 1.00, 0.85)

		------------------------------------------------------------------------
		local speedValue = math.floor(speed/5 + 0.5)
		for i=1,20 do
			if i > speedValue then break end
			surface.SetAlphaMultiplier(1.0)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect((127.5+2.20*i)*10,70.5*10,(i==20) and 6 or 14,44)
		end
		------------------------------------------------------------------------
		local b = self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(210.4*10,38*10,8*10,4*10)
			draw.DrawText("ЛСН","MetrostroiSubway_VerySmallText",210.3*10+0,38*10-5,Color(0,0,0,255))
		end
		local b = self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(201.3*10,38*10,8.2*10,4*10)
			draw.DrawText("РП","MetrostroiSubway_VerySmallText", 201.3*10+15,38*10-5,Color(0,0,0,255))
		end
		
		b = self:Animate("light_KT",self:GetPackedBool(47) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(210.4*10,56*10,8*10,4*10)
			draw.DrawText("ЛКТ","MetrostroiSubway_VerySmallText",210.4*10+0,56*10-5,Color(0,0,0,255))
		end
		b = self:Animate("light_PA",self:GetNWInt("PAKSD:State",-1) ~= 0 and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(210.4*10,65.2*10,8*10,4*10)
			draw.DrawText("ПА","MetrostroiSubway_VerySmallText",210.4*10+15,65.2*10-5,Color(0,0,0,255))
		end			
		b = self:Animate("light_KVD",self:GetPackedBool(48) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(210*10,47.5*10,8*10,4*10)
			draw.DrawText("ЛКВД","MetrostroiSubway_VerySmallText2",210*10-4,48*10-5,Color(0,0,0,255))
		end
		
		b = self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(184*10,47*10,8.2*10,4*10)
			draw.DrawText("2","MetrostroiSubway_VerySmallText",184*10+32,47*10-5,Color(0,0,0,255))
		end
		
		--[[b = self:Animate("light_LRS",self:GetPackedBool(54) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(254*10,55*10,17*10,4*10)
			draw.DrawText("РС","MetrostroiSubway_LargeText2",254*10+35,55*10-5,Color(0,0,0,255))
		end]]--
		
		b = self:Animate("light_LST",self:GetPackedBool(49) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(184.2*10,56.2*10,8*10,4*10)
			draw.DrawText("6","MetrostroiSubway_VerySmallText",184.2*10+32,56.2*10-5,Color(0,0,0,255))
		end
		
		b = self:Animate("light_LVD",self:GetPackedBool(50) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(184.1*10,38*10,8*10,4*10)
			draw.DrawText("1","MetrostroiSubway_VerySmallText",184.1*10+32,38*10-5,Color(0,0,0,255))
		end
		b = self:Animate("light_VRD",self:GetPackedBool("PAKSD:VRD") and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(155,255,50)
			surface.DrawRect(184*10,65*10,8*10,4*10)
			draw.DrawText("ЛРД","MetrostroiSubway_VerySmallText",184*10+0,65*10-5,Color(0,0,0,255))
		end	
		
		--[[b = self:Animate("light_LKVC",1-(self:GetPackedBool(34) and 1 or 0),0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(254*10,10*10,17*10,4*10)
			draw.DrawText("ЛКВЦ","MetrostroiSubway_LargeText3",254*10+5,10*10+5,Color(0,0,0,255))
		end]]--
		
		b = self:Animate("light_SD",(self:GetPackedBool(40) and 1 or 0),0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(184.0*10,28.9*10,16.3*10,4*10)
			draw.DrawText("ЛСД","MetrostroiSubway_VerySmallText",184.5*10+32,28.9*10-5,Color(0,0,0,255))
		end
	
		------------------------------------------------------------------------
		b = self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(98.6*10,27*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1405-18,	y = 840+0 },
				{ x = 1405+0,	y = 840-30 },
				{ x = 1405+18,	y = 840+0 },
			})
			draw.DrawText("НЧ","MetrostroiSubway_LargeText3",98.6*10-1,27*10+5,Color(0,0,0,255))
		end
		
		b = self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(88*10,(27+10*0)*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1405-18,	y = 840+0 },
				{ x = 1405+0,	y = 840-30 },
				{ x = 1405+18,	y = 840+0 },
			})
			draw.DrawText("0","MetrostroiSubway_LargeText2",88*10+20,(27+11.3*0)*10-5,Color(0,0,0,255))
		end
		
		b = self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(88*10,(27+11.3*1)*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1485-18,	y = 840+0 },
				{ x = 1485+0,	y = 840-30 },
				{ x = 1485+18,	y = 840+0 },
			})
			draw.DrawText("40","MetrostroiSubway_LargeText2",88*10-2,(27.5+11.3*1)*10-5,Color(0,0,0,255))
		end
			
		b = self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(88*10,(28+11*2)*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1570-18,	y = 840+0 },
				{ x = 1570+0,	y = 840-30 },
				{ x = 1570+18,	y = 840+0 },
			})
			draw.DrawText("60","MetrostroiSubway_LargeText2",88*10-2,(28+11.3*2)*10-5,Color(0,0,0,255))
		end
			
		b = self:Animate("light_70",self:GetPackedBool(45) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(88*10,(28.4+11*3)*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1615-18,	y = 840+0 },
				{ x = 1615+0,	y = 840-30 },
				{ x = 1615+18,	y = 840+0 },
			})
			draw.DrawText("70","MetrostroiSubway_LargeText2",88*10-1,(29+11*3)*10-5,Color(0,0,0,255))
		end
			
		b = self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(88*10,(28+11.3*4)*10,8*10,8.8*10)
			surface.DrawPoly({
				{ x = 1660-18,	y = 840+0 },
				{ x = 1660+0,	y = 840-30 },
				{ x = 1660+18,	y = 840+0 },
			})
				
			draw.DrawText("80","MetrostroiSubway_LargeText2",88*10-2,(28+11.3*4)*10-5,Color(0,0,0,255))
			surface.SetAlphaMultiplier(1.0)
		end
	end)
	self:DrawOnPanel("ARS",function()
		if self:GetNWInt("ARSType",1) ~= 1 then return end
		
		surface.SetAlphaMultiplier(0.7)
		surface.SetDrawColor(0,0,0)
		surface.DrawRect(108*10,13*10,24*10,24*10)
		surface.SetAlphaMultiplier(1.0)
		if not self:GetPackedBool(32) then return end
	
		local speed = self:GetPackedRatio(3)*100.0
		local d1 = math.floor(speed) % 10
		local d2 = math.floor(speed / 10) % 10
		self:DrawDigit((110+0) *10,	16*10, d2, 0.85, 0.70)
		self:DrawDigit((110+11)*10,	16*10, d1, 0.85, 0.70)

		local b = self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(152*10,78*10,17*10,9*10)
			surface.SetAlphaMultiplier(1)
			draw.DrawText("РП","MetrostroiSubway_LargeText2",152*10+30,78*10-5,Color(0,0,0,245))
		end
		
		local b = self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(178*10,78*10,17*10,9*10)
			draw.DrawText("ЛСН","MetrostroiSubway_LargeText2",178*10+5,78*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_KT",self:GetPackedBool(47) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(213*10,78*10,17*10,9*10)
			draw.DrawText("ЛКТ","MetrostroiSubway_LargeText2",213*10+5,78*10-5,Color(0,0,0,245))
		end			
		
		b = self:Animate("light_KVD",self:GetPackedBool(48) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(213*10,55*10,17*10,9*10)
			draw.DrawText("ЛКВД","MetrostroiSubway_LargeText3",213*10+5,55*10+5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect(111*10,78*10,17*10,9*10)
			--draw.DrawText("ЛхРК","MetrostroiSubway_LargeText3",111*10+5,78*10+5,Color(0,0,0,245))
			draw.DrawText("РК","MetrostroiSubway_LargeText2",111*10+30,78*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_LRS",self:GetPackedBool(54) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(254*10,55*10,17*10,9*10)
			draw.DrawText("РС","MetrostroiSubway_LargeText2",254*10+35,55*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_LST",self:GetPackedBool(49) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(254*10,78*10,17*10,9*10)
			draw.DrawText("ЛСТ","MetrostroiSubway_LargeText2",254*10+5,78*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_LVD",self:GetPackedBool(50) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(254*10,33*10,17*10,9*10)
			draw.DrawText("ЛВД","MetrostroiSubway_LargeText2",254*10+5,33*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_LKVC",1-(self:GetPackedBool(34) and 1 or 0),0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect(254*10,10*10,17*10,9*10)
			draw.DrawText("ЛКВЦ","MetrostroiSubway_LargeText3",254*10+5,10*10+5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_SD",(self:GetPackedBool(40) and 1 or 0),0,1,5,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect(41*10,78*10,17*10,9*10)
			surface.DrawRect(69*10,78*10,17*10,9*10)
			draw.DrawText("ЛСД","MetrostroiSubway_LargeText2",41*10+5,78*10-5,Color(0,0,0,245))
			draw.DrawText("ЛСД","MetrostroiSubway_LargeText2",69*10+5,78*10-5,Color(0,0,0,245))
		end
	
		------------------------------------------------------------------------
		b = self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect((41+27.5*0)*10,48*10,17*10,9*10)
			draw.DrawText("ОЧ","MetrostroiSubway_LargeText2",(41+27.5*0)*10+30,48*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			--surface.SetDrawColor(255,120,50)
			surface.SetDrawColor(255,60,60)
			surface.DrawRect((41+27.5*1)*10,48*10,17*10,9*10)
			draw.DrawText("0","MetrostroiSubway_LargeText",(41+27.5*1)*10+60,48*10-5,Color(0,0,0,245))
		end
		
		b = self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(255,160,20)
			surface.DrawRect((41+27.5*2)*10,48*10,17*10,9*10)
			draw.DrawText("40","MetrostroiSubway_LargeText",(41+27.5*2)*10+35,48*10-5,Color(0,0,0,245))
		end
			
		b = self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect((41+27.5*3)*10,48*10,17*10,9*10)
			draw.DrawText("60","MetrostroiSubway_LargeText",(41+27.5*3)*10+35,48*10-5,Color(0,0,0,245))
		end
			
		b = self:Animate("light_70",self:GetPackedBool(45) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect((41+27.5*4)*10,48*10,17*10,9*10)
			draw.DrawText("70","MetrostroiSubway_LargeText",(41+27.5*4)*10+35,48*10-5,Color(0,0,0,245))
		end
			
		b = self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,15,false)
		if b > 0.0 then
			surface.SetAlphaMultiplier(b)
			surface.SetDrawColor(150,255,50)
			surface.DrawRect((41+27.5*5)*10,48*10,17*10,9*10)
			draw.DrawText("80","MetrostroiSubway_LargeText",(41+27.5*5)*10+35,48*10-5,Color(0,0,0,245))
		end
		
		surface.SetAlphaMultiplier(1.0)
	end)
	self:DrawOnPanel("IGLA",function()
		if not self:GetPackedBool(32) or not self:GetPackedBool(78) then return end
		local text1 = ""
		local text2 = ""
		local C1 = Color(0,200,255,255)
		local C2 = Color(0,0,100,155)
		local flash = false
		local T = self:GetPackedRatio(11)
		local Ptrain = self:GetPackedRatio(5)*16.0
		local Pcyl = self:GetPackedRatio(6)*6.0
		local date = os.date("!*t",os_time)
		
		-- Default IGLA text
		text1 = "IGLA-01K     RK TEMP"
		text2 = Format("%02d:%02d:%02d       %3d C",date.hour,date.min,date.sec,T)
		
		-- Modifiers and conditions
		if self:GetPackedBool(25) then text1 = " !!  Right Doors !!" end
		if self:GetPackedBool(21) then text1 = " !!  Left Doors  !!" end
		
		if T > 300 then text1 = "Temperature warning!" end
		
		if self:GetPackedBool(50) and (Pcyl > 1.1) then
			text1 = "FAIL PNEUMATIC BRAKE"
			flash = true
		end
		if self:GetPackedBool(35) and
		   self:GetPackedBool(28) then
			text1 = "FAIL AVU/BRAKE PRESS"
			flash = true
		end
		if self:GetPackedBool(35) and
		   (not self:GetPackedBool(40)) then
			text1 = "FAIL SD/DOORS OPEN  "
			flash = true
		end
		if self:GetPackedBool(36) then
			text1 = "FAIL OVERLOAD RELAY "
			flash = true
		end
		if Ptrain < 5.5 then
			text1 = "FAIL TRAIN LINE LEAK"
			flash = true
		end
		
		if T > 400 then flash = true end
		if T > 500 then text1 = "!Disengage circuits!" end
		if T > 750 then text1 = " !! PIZDA POEZDU !! " end
		
		-- Draw text
		if flash and ((RealTime() % 1.0) > 0.5) then
			C2,C1 = C1,C2
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(42+(i-1)*17.7+1,42+4,16,22)			
			draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",42+(i-1)*17.7,42+0,C1)
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(42+(i-1)*17.7+1,42+24+4,16,22)
			draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",42+(i-1)*17.7,42+24,C1)
		end
		surface.SetAlphaMultiplier(1)
	end)
	self:DrawOnPanel("AnnouncerDisplay",function()
		-- Draw button labels
		for x=0,3 do
			for y=0,1 do
				draw.Text({
					text = string.Trim(self:GetNWString("CustomStr"..(2+x+y*4))),
					font = "MetrostroiSubway_VerySmallText3",
					pos = { 310+x*135,350+y*150},
					xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
			end
		end
		draw.Text({
			text = string.Trim(self:GetNWString("CustomStr10")),
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 140,385+0*120},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		draw.Text({
			text = string.Trim(self:GetNWString("CustomStr11")),
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 140,385+1*120},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		draw.Text({
			text = string.Trim(self:GetNWString("CustomStr12")),
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 735,200},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
		draw.Text({
			text = string.Trim(self:GetNWString("CustomStr13")),
			font = "MetrostroiSubway_VerySmallText3",
			pos = { 735,100},
			xalign = TEXT_ALIGN_CENTER,yalign = TEXT_ALIGN_CENTER,color = Color(0,0,0,255)})
			
		--draw.DrawText("SELFDESTRUCT","MetrostroiSubway_VerySmallText3",300,480,Color(0,0,0,255))		
		
		if not self:GetPackedBool(32) then return end
		if self:GetPackedBool(24) then
			local function GetColor(id, text)
				if text then
					return self:GetPackedBool(id) and Color(255,0,0) or Color(0,0,0)
				else
					return not self:GetPackedBool(id) and Color(255,255,255) or Color(0,0,0)
				end
			end
			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(255,255,255)
			surface.DrawRect(58,617,230,22) -- 120
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("DURA V 1.0","MetrostroiSubway_IGLA",60,613 + 22*0, Color(0,0,0,255))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(31)) surface.SetAlphaMultiplier(0.4)
			surface.DrawRect(58,617 + 22 * 1,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel:" .. (self:GetPackedBool(31) and "2" or "1"),"MetrostroiSubway_IGLA",60,613 + 22*1,GetColor(31, true))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(153)) surface.SetAlphaMultiplier(0.4)
			surface.DrawRect(58,617 + 22 * 2,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel1:" .. (self:GetPackedBool(153) and "Alt" or "Main"),"MetrostroiSubway_IGLA",60,613 + 22*2,GetColor(153, true))

			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(GetColor(154))
			surface.DrawRect(58,617 + 22 * 3,230,22)
			surface.SetAlphaMultiplier(1.0)
			draw.DrawText("Channel2:" .. (self:GetPackedBool(154) and "Alt" or "Main"),"MetrostroiSubway_IGLA",60,613 + 22*3,GetColor(154, true))
			surface.SetAlphaMultiplier(0.4)
			surface.SetDrawColor(255,255,255)
			surface.DrawRect(58,617 + 22 * 4,230, 120 - 88) -- 120
			surface.SetAlphaMultiplier(1)
		end

		-- Custom announcer display
		local C1 = Color(0,0,0,210)
		local C2 = Color(0,0,0,90)
		local flash = false
		text1 = self:GetNWString("CustomStr0")
		text2 = self:GetNWString("CustomStr1")
		
		-- Draw text
		if flash and ((RealTime() % 1.0) > 0.5) then
			C2,C1 = C1,C2
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(287+(i-1)*17.7+1,125+4,16,22)			
			draw.DrawText(string.upper(text1[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+0,C1)
		end
		for i=1,20 do
			surface.SetDrawColor(C2)
			surface.DrawRect(287+(i-1)*17.7+1,125+31+4,16,22)
			draw.DrawText(string.upper(text2[i] or ""),"MetrostroiSubway_IGLA",287+(i-1)*17.7,125+31,C1)
		end
	end)
	
	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNWBool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNWBool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNWBool("RtI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNWBool("RbI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNWBool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
	end)
	
	-- Draw train numbers
	local dc = render.GetLightColor(self:GetPos())
	self:DrawOnPanel("TrainNumber1",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	self:DrawOnPanel("TrainNumber2",function()
		draw.DrawText(Format("%04d",self:EntIndex()),"MetrostroiSubway_LargeText3",0,0,Color(255*dc.x,255*dc.y,255*dc.z,255))
	end)
	
	--dc = render.GetLightColor(self:LocalToWorld(Vector(453,14.4,1.8)))*render.GetAmbientLightColor()
	self:DrawOnPanel("ParkingBrakeSign",function()
		if not self:GetPackedBool(161) then return end
		surface.SetAlphaMultiplier(1.0)
		surface.SetMaterial(self.ParkingBrakeMaterial)
		--print(255*dc.x,255*dc.y,255*dc.z)
		surface.SetDrawColor(255,255,255)
		surface.DrawTexturedRect( 0, 0, 300, 90 )
	end)
	--self:DrawOnPanel("DURA",function()
		--surface.SetDrawColor(150,255,50)
		--surface.DrawRect(0,0,240,80)
	--end)
end

function ENT:OnButtonPressed(button)
	if button == "ShowHelp" then
		RunConsoleCommand("metrostroi_train_manual")
	end
	if button == "PrevSign" then
		self.InfoTableTimeout = CurTime() + 2.0
	end
	if button == "NextSign" then
		self.InfoTableTimeout = CurTime() + 2.0
	end

	if button and button:sub(1,3) == "Num" then
		self.InfoTableTimeout = CurTime() + 2.0
	end
end
