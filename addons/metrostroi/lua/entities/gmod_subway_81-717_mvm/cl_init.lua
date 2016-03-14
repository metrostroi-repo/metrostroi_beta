include("shared.lua")


--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}

-- Main panel
ENT.ButtonMap["Main"] = {
	pos = Vector(457.5,14.0,4.7), --446 -- 14 -- -0,5
	ang = Angle(0,-90,44),
	width = 460,
	height = 230,
	scale = 0.0625,

	buttons = {
		{ID = "R_UNchToggle",	x=39+28*0, y=37, radius=20, tooltip="УНЧ: Усилитель низких частот\nUNCh: Low frequency amplifier"},
		{ID = "R_ZSToggle",		x=36+28*1, y=37, radius=20, tooltip="ЗС: Звук в салоне\nZS: Sound in wagons enable"},
		{ID = "R_GToggle",		x=38+28*2, y=37, radius=20, tooltip="Громкоговоритель\nLoudspeaker: Sound in cabin enable"},
		{ID = "R_RadioToggle",	x=38+28*3, y=37, radius=20, tooltip="Радиоинформатор (встроеный)\nRadioinformator: Announcer (built-in)"},
		{ID = "R_ProgramToggle",x=41+28*4, y=37, radius=0, },
		{ID = "R_Program1Set",  x=27+28*3.5, y=37-10,  w=28,h=20, tooltip="Программа 1\nProgram 1"},
		{ID = "R_Program2Set",  x=27+28*4.5, y=37-10, w=28,h=20, tooltip="Программа 2\nProgram 2"},

		--{ID = "1:KVTSet",			x=247, y=33, radius=20, tooltip="КВТ: Кнопка восприятия торможения\nKVT: ARS Brake cancel button"},
		{ID = "2:KVTSet",		x=295, y=33, radius=20, tooltip="КБ: Кнопка Бдительности\nKB: Attention button"},
		{ID = "VZ1Set",			x=355, y=33, radius=20, tooltip="ВЗ1: Вентиль замещения №1\nVZ1: Pneumatic valve #1"},

		--{ID = "AutodriveToggle",x=420, y=92, radius=20, tooltip="Автоматическая остановка\nAutomatic stop"},

		{ID = "VUD1Toggle",		x=54, y=102, radius=40, tooltip="ВУД: Выключатель управления дверьми\nVUD: Door control toggle (close doors)"},
		{ID = "KDLSet",			x=50, y=180, radius=20, tooltip="КДЛ: Кнопка левых дверей\nKDL: Left doors open"},
		{ID = "KDLKToggle",			x=30, y=190, w=40,h=20, tooltip="Крышечка"},
		{ID = "KDLRSet",			x=153, y=180, radius=20, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
		{ID = "KDLRKToggle",			x=133, y=190, w=40,h=20, tooltip="Крышечка"},
		{ID = "DoorSelectToggle",x=105, y=183, radius=20, tooltip="Выбор стороны открытия дверей\nSelect side on which doors will open"},
		{ID = "KRZDSet",		x=153, y=83, radius=20, tooltip="КРЗД: Кнопка резервного закрытия дверей\nKRZD: Emergency door closing"},
		{ID = "R_VPRToggle",		x=105, y=83, radius=20, tooltip="ВПР: Включение поездной радиосвязи\nVPR: Radiostation enable "},
		{ID = "VozvratRPSet",	x=105, y=132, radius=20, tooltip="Возврат реле перегрузки\nReset overload relay"},

		{ID = "GreenRPLight",	x=153, y=135, radius=20, tooltip="РП: Зелёная лампа реле перегрузки\nRP: Green overload relay light (overload relay open on current train)"},
		{ID = "AVULight",		x=326, y=92, radius=20, tooltip="АВУ: Автоматический выключатель управления\nAVU: Automatic control disabler active"},
		{ID = "KVPLight",		x=372, y=92, radius=20, tooltip="КВП: Контроль высоковольного преобразователя\nKVP: High-voltage converter control"},
		{ID = "SPLight",		x=413, y=30, radius=20, tooltip="ЛСП: Лампа сигнализации пожара\nLSP: Fire emergency (rheostat overheat)"},

		{ID = "ConverterProtectionSet",			x=330, y=130, radius=20, tooltip="Converter protection"},
		{ID = "KSNSet",			x=375, y=130, radius=20, tooltip="КСН: Кнопка сигнализации неисправности\nKSN: Failure indication button"},
		{ID = "DIPoffSet",		x=420, y=130, radius=20, tooltip="Звонок\nRing"},

		{ID = "ARSToggle",		x=239, y=130, radius=20, tooltip="АРС: Включение системы автоматического регулирования скорости\nARS: Automatic speed regulation"},
		{ID = "ALSToggle",		x=268, y=130, radius=20, tooltip="АЛС: Включение системы автоматической локомотивной сигнализации\nALS: Automatic locomotive signalling"},

		{ID = "OtklAVUToggle",	x=283, y=183, radius=20, tooltip="Отключение автоматического выключения управления (неисправность АВУ)\nTurn off automatic control disable relay (failure of AVU)"},
		{ID = "OtklAVUPl",x=283, y=210, radius=20, tooltip="Пломба крышки ОтклАВУ\nOtklAVU plomb"},
		{ID = "TormATToggle",			x=238, y=183, radius=20, tooltip="(placeholder) Emergency brake toggle"},
		{ID = "TormATPl",x=238, y=210, radius=20, tooltip="(placeholder) Пломба крышки Торможение АТ\nEmergency brake toggle plomb"},
		{ID = "L_1Toggle",		x=321, y=183, radius=20, tooltip="Освещение салона\nWagon lighting"},
		{ID = "L_2Toggle",		x=357, y=183, radius=20, tooltip="Освещение кабины\nCabin lighting"},
		{ID = "L_3Toggle",		x=399, y=183, radius=20, tooltip="Освещение пульта\nPanel lighting"},

		{ID = "ParkingBrakeSignToggle",	x=203,y=113, radius=20, tooltip="Табличка \"ОТПУСТИ СТОЯНОЧНЫЙ ТОРМОЗ\"\nSign \"RELEASE PARKING BRAKE\""},
	}
}

-- Front panel
ENT.ButtonMap["Front"] = {
	pos = Vector(455.3,-15.3,7.1),
	ang = Angle(0,-90,56.5),
	width = 220,
	height = 250,
	scale = 0.0625,

	buttons = {
		{ID = "VUSToggle",x=90, y=200, radius=20, tooltip="ВУС: Выключатель усиленого света ходовых фар\nVUS: Head lights bright/dim"},
		{ID = "VAHToggle",x=170, y=200, radius=20, tooltip="ВАХ: Включение аварийного хода (неисправность реле педали безопасности)\nVAH: Emergency driving mode (failure of RPB relay)"},
		{ID = "VAHPl",x=170, y=227, radius=20, tooltip="Пломба кнопки ВАХ\nVAH plomb"},
		{ID = "VADToggle",x=127, y=200, radius=20, tooltip="ВАД: Включение аварийного закрытия дверей (неисправность реле контроля дверей)\nVAD: Emergency door close override (failure of KD relay)"},
		{ID = "VADPl",x=127, y=227, radius=20, tooltip="Пломба кнопки ВАД\nVAD plomb"},
		--{ID = "RezMKSet",x=53,  y=98, radius=20, tooltip="Резервное включение мотор-компрессора\nEmergency motor-compressor startup"},
		{ID = "KAHSet",x=53,  y=98, radius=20, tooltip="КАХ: Кнопка аварийного хода\nEmergency drive button"},
		{ID = "KAHPl",x=37, y=68, radius=20, tooltip="Пломба крышки КАХ\nKAH plomb"},
		{ID = "KAHKToggle",			x=33, y=108, w=40,h=20, tooltip="Крышечка"},
		{ID = "KRPSet",x=53, y=33, radius=20, tooltip="КРП: Кнопка резервного пуска\nKRP: Emergency start button"},

		{ID = "L_4Toggle",x=53, y=200, radius=20, tooltip="Выключатель фар\nHeadlights toggle"},
		{ID = "CabinHeatLight",x=90, y=145, radius=20, tooltip="Контроль печи\nCabin heater active"},
		{ID = "KDPSet",x=130, y=145, radius=20, tooltip="КДП: Кнопка правых дверей\nKDP: Right doors open"},
		{ID = "KDPKToggle",			x=110, y=155, w=40,h=20, tooltip="Крышечка"},

		{ID = "PneumoLight",x=170, y=145, radius=20, tooltip="Контроль пневмотормоза\nPneumatic brake control"},
	}
}

-- BPSN panel
ENT.ButtonMap["BPSNFront"] = {
	pos = Vector(459.4,31.0,13.2),
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
	pos = Vector(455.5,31.0,7.2),
	ang = Angle(0,-90,57.0),
	width = 265,
	height = 245,
	scale = 0.0625,

	buttons = {
		{ID = "DURASelectMain", x=159, y=200, radius=20, tooltip="DURA Select Main"}, -- NEEDS TRANSLATING
		{ID = "DURASelectAlternate", x=198, y=200, radius=20, tooltip="DURA Select Alternate"}, -- NEEDS TRANSLATING
		{ID = "DURAToggleChannel", x=110, y=217, radius=20, tooltip="DURA Toggle Channel"}, -- NEEDS TRANSLATING
		{ID = "DURAPowerToggle", x=110, y=187, radius=20, tooltip="DURA Power"}, -- NEEDS TRANSLATING

		{ID = "CustomCToggle", x=220, y=45, radius=20, tooltip="C"},

		{ID = "Custom1Set", x=95+40*0, y=84+45*0, radius=20, tooltip="1"},
		{ID = "Custom2Set", x=95+40*1, y=84+45*0, radius=20, tooltip="2"},
		{ID = "Custom3Set", x=95+40*2, y=84+45*0, radius=20, tooltip="3"},

		{ID = "CustomD", x=95+29*0, y=18, radius=20, tooltip="D"},
		{ID = "CustomE", x=95+29*1, y=18, radius=20, tooltip="E"},
		{ID = "CustomF", x=95+29*2, y=18, radius=20, tooltip="F"},
		{ID = "CustomG", x=95+29*3, y=18, radius=20, tooltip="G"},
	}
}
-- Announcer panel
ENT.ButtonMap["AnnouncerDisplay"] = {
	pos = Vector(455.51,30.83,7.03),
	ang = Angle(-.4,-90.5,57.0),
	width = 265,
	height = 245,
	scale = 0.0186,
	props = {},
}

ENT.ARSMap = {}
-- ARS/Speedometer panel
ENT.ARSMap[1] = {
	pos = Vector(459.50,10.98,13.08),
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
	pos = Vector(459.49,10.98,13.09),
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
	pos = Vector(459.49,10.98,13.09),
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

		{x=2005,y=291 + 85*1,w = 85, h = 45,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)"},

		{x=2093,y=291 + 85*1,w = 90, h = 45,tooltip="ЛСН: Лампа сигнализации неисправности\nLSN: Failure indicator light (power circuits failed to assemble)"},
		{x=2093,y=291 + 88*2,w = 90, h = 45,tooltip="ЛКВД: Контроль выключения двигателей\nLKVD: ARS engine shutdown indicator"},
		{x=2093,y=291 + 88*3,w = 90, h = 45,tooltip="ЛКТ: Контроль тормоза\nLKT: ARS braking indicator"},
	}
}
ENT.ButtonMap["OldARS"] = {
	pos = Vector(459.49,10.98,13.09),
	ang = Angle(0,-90-0.2,56.3),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,

	buttons = {
		{x=1110,y=200,w = 800, h = 440,tooltip="Индикатор скорости\nSpeed indicator"},

		{ID = "LSD",x=370 +170*0,y=130 + 177*0,w = 340, h = 150,tooltip="ЛСД: Сигнализация дверей\nLSD: Door state light (doors are closed)"},
		{ID = "LOCh",x=370 +170*0,y=130 + 177*1 + 2,w = 340/2, h = 130,tooltip="ОЧ: Отсутствие частоты АРС\nNCh: No ARS frequency"},
		{ID = "L0",x=370 +170*1,y=130 + 177*1 + 2,w = 340/2, h = 130,tooltip="0: Сигнал АРС остановки\n0: ARS stop signal"},
		{ID = "LRS",x=370 +170*0,y=130 + 177*2 + 3,w = 340/2, h = 130,tooltip="ЛРС: Лампа равенства скоростей\nLRS: Speed equality light (next segment speed limit equal or greater to current)"},
		{ID = "L40",x=370 +170*1,y=130 + 177*2 + 3,w = 340/2, h = 130,tooltip="40: Ограничение скорости 40 км/ч\nSpeed limit 40 kph"},
		{ID = "L60",x=370 +170*0,y=130 + 177*3 - 6,w = 340/2, h = 130,tooltip="60: Ограничение скорости 60 км/ч\nSpeed limit 60 kph"},
		{ID = "L80",x=370 +170*1,y=130 + 177*3 - 6,w = 340/2, h = 130,tooltip="80: Ограничение скорости 80 км/ч\nSpeed limit 80 kph"},
		{ID = "L70",x=370 +170*0,y=130 + 177*4 + 1,w = 340/2, h = 110,tooltip="70: Ограничение скорости 70 км/ч\nSpeed limit 60 kph"},
		{ID = "LRK",x=370 +170*1,y=130 + 177*4 + 1,w = 340/2, h = 110,tooltip="РК: Лампа хода реостатного контроллера\nRK: Rheostat controller motion light"},

		{ID = "LEKK",x=2300 + 200*0,y=145 + 260*0,radius = 100,tooltip=""},
		{ID = "LPU",x=2300 + 200*0,y=145 + 260*1,radius = 100,tooltip=""},
		{ID = "LKVD",x=2300 + 200*0,y=145 + 260*2,radius = 100,tooltip="ЛКВД: Контроль выключения двигателей\nLKVD: ARS engine shutdown indicator"},
		{ID = "LKT",x=2300 + 200*0,y=145 + 260*3,radius = 100,tooltip="ЛКТ: Контроль тормоза\nLKT: ARS braking indicator"},

		{ID = "LRP",x=2300 + 475*1,y=145 + 260*0,radius = 100,tooltip="РП: Красная лампа реле перегрузки\nRP: Red overload relay light (power circuits failed to assemble)"},
		{ID = "LKVC",x=2300 + 475*1,y=145 + 260*1,radius = 100,tooltip="ЛКВЦ: Лампа контактора высоковольтных цепей\nLKVC: High voltage not available"},
		{ID = "LVD",x=2300 + 475*1,y=145 + 260*2,radius = 100,tooltip="ЛВД: Лампа включения двигателей\nLVD: Engines engaged"},
		{ID = "LST",x=2300 + 475*1,y=145 + 260*3,radius = 100,tooltip="ЛСТ: Лампа сигнализации торможения\nLST: Brakes engaged"},
	}
}
-- ARS/Speedometer panel (Kyiv version)
ENT.ButtonMap["ARSKyiv"] = {
	pos = Vector(459.51,10.98,13.10),
	ang = Angle(0,-90,56.8),
	width = 300*10,
	height = 110*10,
	scale = 0.0625/10,
}
-- Parking Brake Sign
ENT.ButtonMap["ParkingBrakeSign"] = {
	pos = Vector(458.8,10.9,13),
	ang = Angle(0,-90-0.2,56.3),
	width = 300,
	height = 110,
	scale = 0.0625,
	visivle=0,
}

-- AV panel
ENT.ButtonMap["AV"] = {
	pos = Vector(398.0,-11.3,49.7),
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
		{ID = "A5Pl",  x=13+52*2,  y=95+167*2, radius=30, tooltip="A5 Plomb"},
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
		for _,v2 in pairs(v) do
			v2.ID = "1:"..v2.ID
		end
	end
end
ENT.ButtonMap["AV_1"].pos = Vector(398.0,-11.3,50.5) + Vector(12,-47,0.5)
ENT.ButtonMap["Battery"] = {
	pos = Vector(410.0,-54.5,37),
	ang = Angle(0,90,90),
	width = 270,
	height = 375,
	scale = 0.0625,

	buttons = {
		{ID = "BPSToggle", x=68, y=71, radius=70, tooltip="РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"},
		{ID = "RC1Toggle", x=68, y=180, radius=70, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect"},
		{ID = "RC1Pl",x=49, y=220, radius=20, tooltip="Пломба РЦ-1\nRC-1 plomb"},
		{ID = "UOSToggle", x=189, y=180, radius=70, tooltip="РЦ-УОС: Устройство ограничения скорости\nRC-UOS: Speed Limitation Device"},
		{ID = "UOSPl",x=169, y=220, radius=20, tooltip="Пломба РЦ-УОС\nRC-UOS plomb"},
		{ID = "VBToggle", x=68, y=294, radius=70, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
	}
}
ENT.ButtonMap["Battery_2"] = {
	pos = Vector(410.0,-51.5,12.2),
	ang = Angle(0,90,90),
	width = 415,
	height = 275,
	scale = 0.0625,

	buttons = {
		{ID = "RC1Toggle", x=64, y=68, radius=70, tooltip="РЦ-1: Разъединитель цепей АРС\nRC-1: ARS circuits disconnect"},
		{ID = "1:RC1Pl",x=45, y=108, radius=20, tooltip="Пломба РЦ-1\nRC-1 plomb"},
		{ID = "VBToggle", x=220, y=68, radius=70, tooltip="ВБ: Выключатель батареи\nVB: Battery on/off"},
		{ID = "BPSToggle", x=356, y=68, radius=70, tooltip=" РЦ-БПС: Блок ПротивоСкатывания\nRC-BPS: Against Rolling System"},
		{ID = "UOSToggle", x=215, y=215, radius=70, tooltip="РЦ-УОС: Устройство ограничения скорости\nRC-UOS: Speed Limitation Device"},
		{ID = "1:UOSPl",x=195, y=255, radius=20, tooltip="Пломба РЦ-УОС\nRC-UOS plomb"},
	}
}
-- Help panel
ENT.ButtonMap["Help"] = {
	pos = Vector(410,-40,2),
	ang = Angle(90,0,0),
	width = 20,
	height = 20,
	scale = 1,

	buttons = {
		{ID = "ShowHelp", x=10, y=10, radius=8, tooltip="Помощь в вождении поезда\nShow help on driving the train"},
	}
}

-- Train driver helpers panel
ENT.ButtonMap["HelperPanel"] = {
	pos = Vector(450.4,60,21.3),
	ang = Angle(0,0,90),
	width = 96,
	height = 192,
	scale = 0.0625,

	buttons = {
		{ID = "VUD2Toggle", x=32, y=42, radius=32, tooltip="ВУД2: Выключатель управления дверьми\nVUD2: Door control toggle (close doors)"},
		{ID = "VDLSet",     x=32, y=125, radius=32, tooltip="ВДЛ: Выключатель левых дверей\nVDL: Left doors open"},
		{ID = "R_Program2Helper",  x=24, y=180, radius=20, tooltip="Программа 2\nProgram 2"},
		{ID = "R_Program1Helper",  x=72, y=180,  radius=20, tooltip="Программа 1\nProgram 1"},
	}
}

-- Pneumatic instrument panel
ENT.ButtonMap["PneumaticPanels"] = {
	pos = Vector(459.6,-9.0,13.4),
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
	pos = Vector(421.0,-24,-32),
	ang = Angle(0,0,0),
	width = 200,
	height = 90,
	scale = 0.0625,

	buttons = {
		{ID = "DriverValveDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Клапан разобщения\nDriver valve disconnect valve"},
		{ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="Кран двойной тяги тормозной магистрали\nTrain line disconnect valve"},
	}
}
ENT.ButtonMap["ParkingBrake"] = {
	pos = Vector(448.0,-25,-26),
	ang = Angle(0,180,90),
	width = 200,
	height = 120,
	scale = 0.0625,

	buttons = {
		{ID = "ParkingBrakeToggle", x=0, y=0, w=200, h=120, tooltip="Стояночный тормоз\nParking brake"},
		{ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=120, tooltip="Кран двойной тяги напорной магистрали\nBrake line disconnect valve"},
	}
}
ENT.ButtonMap["ParkingBrake2"] = {
	pos = Vector(456.777527,5,-30),
	ang = Angle(0,-90,90),
	width = 200,
	height = 120,
	scale = 0.0625,

	buttons = {
		{ID = "1:ParkingBrakeToggle", x=0, y=0, w=200, h=120, tooltip="Стояночный тормоз\nParking brake"},
	}
}
ENT.ClientProps["ParkingBrake2"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(456.777527,-1.680647,-34.931717),
	ang = Angle(0.000000,-90.000000,0.000000),
}
ENT.ButtonMap["EPKDisconnect"] = {
	pos = Vector(439.0,-43.3,-33),
	ang = Angle(0,-90,0),
	width = 200,
	height = 120,
	scale = 0.0625,

	buttons = {
		{ID = "EPKToggle", x=0, y=0, w=200, h=120, tooltip="Кран ЭПВ\nEPK disconnect valve"},
	}
}

ENT.ButtonMap["Reverser"] = {
	pos = Vector(446.0,-30.1,-3),
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
	pos = Vector(459.8,-29.0,32.0),
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
	pos = Vector(431.0,-55.3,-7.0),
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

local rowamount = 20 -- How many rows to show (total)
ENT.ButtonMap["Schedule"] = {
	pos = Vector(462.0,32.0,33),
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
	pos = Vector(460.8,-27.0,37.0),
	ang = Angle(0,-125,90),
	width = 440,
	height = 190,
	scale = 0.024,
}

-- Temporary panels (possibly temporary)
ENT.ButtonMap["FrontPneumatic"] = {
	pos = Vector(465.0,-45.0,-46.5),
	ang = Angle(0,90,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "FrontBrakeLineIsolationToggle",x=182, y=57, radius=32, tooltip="Концевой кран тормозной магистрали"},
		{ID = "FrontTrainLineIsolationToggle",x=710, y=60, radius=32, tooltip="Концевой кран напорной магистрали"},
	}
}
ENT.ButtonMap["RearPneumatic"] = {
	pos = Vector(-472.0,45.0,-45.5),
	ang = Angle(0,270,90),
	width = 900,
	height = 100,
	scale = 0.1,
	buttons = {
		{ID = "RearBrakeLineIsolationToggle",x=710, y=60, radius=32, tooltip="Концевой кран тормозной магистрали"},
		{ID = "RearTrainLineIsolationToggle",x=182, y=57, radius=32, tooltip="Концевой кран напорной магистрали"},
	}
}
ENT.ButtonMap["GV"] = {
	pos = Vector(128,66,-52),
	ang = Angle(0,180,90),
	width = 170,
	height = 150,
	scale = 0.1,
	buttons = {
		{ID = "GVToggle",x=0, y=0, w= 170,h = 150, tooltip="Главный выключатель"},
	}
}
ENT.ButtonMap["AirDistributor"] = {
	pos = Vector(-168,68.6,-50),
	ang = Angle(0,180,90),
	width = 170,
	height = 80,
	scale = 0.1,
	buttons = {
		{ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 80, tooltip="Выключение воздухораспределителя"},
	}
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

ENT.ButtonMap["InfoTableSelect"] = {
	pos = Vector(464.0,27.0,22.0),
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
	pos = Vector(461.7,42.2,12.2),
	ang = Angle(0,103.6,90),
	width = 100,
	height = 100,
	scale = 0.1,
}
ENT.ButtonMap["CabinDoor"] = {
	pos = Vector(414.5,64,56.7),
	ang = Angle(0,0,90),
	width = 642,
	height = 2000,
	scale = 0.1/2,
	buttons = {
		{ID = "CabinDoor",x=0,y=0,w=642,h=2000, tooltip="Дверь в кабину машиниста\nCabin door"},
	}
}

ENT.ButtonMap["PassengerDoor"] = {
	pos = Vector(390,40.6,50.6), --28
	ang = Angle(0,90,90),
	width = 642-220,
	height = 2000,
	scale = 0.1/2,
	buttons = {
		{ID = "PassengerDoor",x=0,y=0,w=642-220,h=2000, tooltip="Дверь в кабину машиниста из салона\nPass door"},
	}
}
ENT.ButtonMap["Wiper"] = {
	pos = Vector(455.80,7,57.5),
	ang = Angle(180,90,0.0),
	width = 750,
	height = 300,
	scale = 0.0185,
	buttons = {
		{ID = "WiperToggle",x=0,y=0,w=750,h=300, tooltip="Дворник\nWiper"},
	}
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
ENT.ClientProps["brake013"] = {
	model = "models/metrostroi/81-717/brake.mdl",
	pos = Vector(437.5,-24.0+1.5,-4.0),
	ang = Angle(0,180,0)
}
ENT.ClientProps["brake334"] = {
	model = "models/metrostroi_train/81/334cran.mdl",
	pos = Vector(438.4,-20.75,-0.6),
	ang = Angle(0,90-30,0)
}
ENT.ClientProps["controller"] = {
	model = "models/metrostroi/81-717/controller.mdl",
	pos = Vector(442.2,17.0+1.4,-8.2),
	ang = Angle(0,180,0)
}

ENT.ClientProps["controller_old"] = {
	model = "models/metrostroi_train/81/kv2.mdl",
	pos = Vector(442.2,17.0+0.6,-8.2),
	ang = Angle(0,0,0)
}

ENT.ClientProps["reverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(445.5,-32+1.7,-7.5),
	ang = Angle(93,0,0)
}
ENT.ClientProps["ParkingBrake"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(436.6,-24,-34.8),
	ang = Angle(0,180,0),
}
ENT.ClientProps["brake_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(431.8,-24.1+1.5,-33.7),
	ang = Angle(0,180,0)
}
ENT.ClientProps["brake_disconnect2"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(431.8,-24.1+1.5,-33.7),
	ang = Angle(0,180,0),
}
ENT.ClientProps["EPK_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(437.2,-53.1,-32.0),
	ang = Angle(0,90,-90),
}
ENT.ClientProps["train_disconnect"] = {
	model = "models/metrostroi/81-717/uava.mdl",
	pos = Vector(436.6,-24,-34.8),
	ang = Angle(0,180,0),
	color = Color(0,212,255),
}
ENT.ClientProps["krureverser"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(452.3,-24.0,4.0),
	ang = Angle(180,90,-30)
}
--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(460.25,-16.0+1.75,8.7),
	ang = Angle(90+33,0,180+36.0)
}
ENT.ClientProps["brake_line"] = {
	model = "models/metrostroi/81-717/red_arrow.mdl",
	pos = Vector(460.25,-16.0+1.75,8.7),
	ang = Angle(90+33,0,180+36.0)
}
ENT.ClientProps["brake_cylinder"] = {
	model = "models/metrostroi/81-717/black_arrow.mdl",
	pos = Vector(460.15,-24.15+1.55,8.57),
	ang = Angle(90+33,0,180+36.0)
}
--------------------------------------------------------------------------------
ENT.ClientProps["ampermeter"] = {--24.2 0.2 5.3
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(458.30,-34.0+2.25,23.2),
	ang = Angle(90,0,-35+360+70)
}
ENT.ClientProps["voltmeter"] = {--
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(458.30,-34.0+2.25,26.85),
	ang = Angle(90,0,-35+360+70)
}
ENT.ClientProps["volt1"] = {--
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(459.3,15.4+1.1,7.9),
	ang = Angle(90+30,0,360-36.5)
}
ENT.ClientProps["speed1"] = {--
	model = "models/metrostroi/81-717/volt_arrow.mdl",
	pos = Vector(456.933,1.51,9.322),
	ang = Angle(90+34,0,0)
}
--[[
"LSD"
"LOCh"
"L0"
"LRS"
"L40"
"L60"
"L70"
"L80"
"LRK"
]]
Metrostroi.ClientPropForButton("LSD",{
	panel = "OldARS",
	button = "LSD",
	model = "models/metrostroi_train/81/lamplsd.mdl",
	z = 70,
	ang = 0,
})
Metrostroi.ClientPropForButton("LOCh",{
	panel = "OldARS",
	button = "LOCh",
	model = "models/metrostroi_train/81/lampoch.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("L0",{
	panel = "OldARS",
	button = "L0",
	model = "models/metrostroi_train/81/lamp0.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("LRS",{
	panel = "OldARS",
	button = "LRS",
	model = "models/metrostroi_train/81/lamprs.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("L40",{
	panel = "OldARS",
	button = "L40",
	model = "models/metrostroi_train/81/lamp40.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("L60",{
	panel = "OldARS",
	button = "L60",
	model = "models/metrostroi_train/81/lamp60.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("L80",{
	panel = "OldARS",
	button = "L80",
	model = "models/metrostroi_train/81/lamp80.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("L70",{
	panel = "OldARS",
	button = "L70",
	model = "models/metrostroi_train/81/lamp70.mdl",
	z = 68,
	ang = 0,
})
Metrostroi.ClientPropForButton("LRK",{
	panel = "OldARS",
	button = "LRK",
	model = "models/metrostroi_train/81/lamprk.mdl",
	z = 68,
	ang = 0,
})

Metrostroi.ClientPropForButton("LEKK",{
	panel = "OldARS",
	button = "LEKK",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 3,
	z = -3
})
Metrostroi.ClientPropForButton("LPU",{
	panel = "OldARS",
	button = "LPU",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 2,
	z = -3
})
Metrostroi.ClientPropForButton("LKVD",{
	panel = "OldARS",
	button = "LKVD",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LKT",{
	panel = "OldARS",
	button = "LKT",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 2,
	z = -3
})
Metrostroi.ClientPropForButton("LRP",{
	panel = "OldARS",
	button = "LRP",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LKVC",{
	panel = "OldARS",
	button = "LKVC",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LVD",{
	panel = "OldARS",
	button = "LVD",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 0,
	z = -3
})
Metrostroi.ClientPropForButton("LST",{
	panel = "OldARS",
	button = "LST",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 4	,
	z = -3
})

Metrostroi.ClientPropForButton("LEKK_light",{
	panel = "OldARS",
	button = "LEKK",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 3,
	z = -3
})
Metrostroi.ClientPropForButton("LPU_light",{
	panel = "OldARS",
	button = "LPU",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 2,
	z = -3
})
Metrostroi.ClientPropForButton("LKVD_light",{
	panel = "OldARS",
	button = "LKVD",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LKT_light",{
	panel = "OldARS",
	button = "LKT",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 2,
	z = -3
})
Metrostroi.ClientPropForButton("LRP_light",{
	panel = "OldARS",
	button = "LRP",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LKVC_light",{
	panel = "OldARS",
	button = "LKVC",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 1,
	z = -3
})
Metrostroi.ClientPropForButton("LVD_light",{
	panel = "OldARS",
	button = "LVD",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 0,
	z = -3
})
Metrostroi.ClientPropForButton("LST_light",{
	panel = "OldARS",
	button = "LST",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	skin = 4	,
	z = -3
})


--------------------------------------------------------------------------------
Metrostroi.ClientPropForButton("headlights",{
	panel = "Front",
	button = "VUSToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
--------------------------------------------------------------------------------

Metrostroi.ClientPropForButton("R_UNch",{
	panel = "Main",
	button = "R_UNchToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("R_ZS",{
	panel = "Main",
	button = "R_ZSToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("R_G",{
	panel = "Main",
	button = "R_GToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("R_VPR",{
	panel = "Main",
	button = "R_VPRToggle",
	model = "models/metrostroi_train/81/tumbler2.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("R_Radio",{
	panel = "Main",
	button = "R_RadioToggle",
	model = "models/metrostroi_train/81/tumbler4.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("R_Program",{
	panel = "Main",
	button = "R_ProgramToggle",
	model = "models/metrostroi_train/81/tumbler3.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("BPSNon",{
	panel = "BPSNFront",
	button = "BPSNonToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("VozvratRP",{
	panel = "Main",
	button = "VozvratRPSet",
	model = "models/metrostroi_train/81/button2.mdl",
	skin = 4,
	z = 1,
})
Metrostroi.ClientPropForButton("VMK",{
	panel = "BPSNFront",
	button = "VMKToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("RezMK",{
	panel = "BPSNFront",
	button = "RezMKSet",
	model = "models/metrostroi_train/81/button.mdl",
})
Metrostroi.ClientPropForButton("KAH",{
	panel = "Front",
	button = "KAHSet",
	model = "models/metrostroi_train/81/button2.mdl",
	skin = 1,
	z = 3,
})
Metrostroi.ClientPropForButton("KAHPl",{
	panel = "Front",
	button = "KAHPl",
	model = "models/metrostroi_train/81/plomb_b.mdl",
	ang = 110,
	z = -3,
})
Metrostroi.ClientPropForButton("KAHK",{
	panel = "Front",
	button = "KAHKToggle",
	model = "models/metrostroi_train/81/krishka.mdl",
	ang = 0,
	z = -2
})
Metrostroi.ClientPropForButton("VAH",{
	panel = "Front",
	button = "VAHToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("VAHPl",{
	panel = "Front",
	button = "VAHPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
})

Metrostroi.ClientPropForButton("VAD",{
	panel = "Front",
	button = "VADToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("VADPl",{
	panel = "Front",
	button = "VADPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
})
Metrostroi.ClientPropForButton("ALS",{
	panel = "Main",
	button = "ALSToggle",
	model = "models/metrostroi_train/81/tumbler2.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("ARS",{
	panel = "Main",
	button = "ARSToggle",
	model = "models/metrostroi_train/81/tumbler2.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("OtklAVU",{
	panel = "Main",
	button = "OtklAVUToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("OtklAVUPl",{
	panel = "Main",
	button = "OtklAVUPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -5,
})
Metrostroi.ClientPropForButton("KRZD",{
	panel = "Main",
	button = "KRZDSet",
	model = "models/metrostroi_train/81/button2.mdl",
	skin = 4,
	z = 3,
})
Metrostroi.ClientPropForButton("VUD1",{
	panel = "Main",
	button = "VUD1Toggle",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z=-5,
})
Metrostroi.ClientPropForButton("DoorSelect",{
	panel = "Main",
	button = "DoorSelectToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("KDL",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 7,
})
Metrostroi.ClientPropForButton("KDL_light",{
	panel = "Main",
	button = "KDLSet",
	model = "models/metrostroi_train/81/button_light.mdl",
	ignorepanel = true,
	skin = 1,
})
Metrostroi.ClientPropForButton("KDLK",{
	panel = "Main",
	button = "KDLKToggle",
	model = "models/metrostroi_train/81/krishka.mdl",
	ang = 0,
	z = -6
})
Metrostroi.ClientPropForButton("KDP",{
	panel = "Front",
	button = "KDPSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 7,
})
Metrostroi.ClientPropForButton("KDP_light",{
	panel = "Front",
	button = "KDPSet",
	model = "models/metrostroi_train/81/button_light.mdl",
	ignorepanel = true,
	skin = 1,
})
Metrostroi.ClientPropForButton("KDPK",{
	panel = "Front",
	button = "KDPKToggle",
	model = "models/metrostroi_train/81/krishka.mdl",
	ang = 0,
	z = -2
})
Metrostroi.ClientPropForButton("VZ1",{
	panel = "Main",
	button = "VZ1Set",
	model = "models/metrostroi_train/81/button2.mdl",
	z=2
})
Metrostroi.ClientPropForButton("KSN",{
	panel = "Main",
	button = "KSNSet",
	model = "models/metrostroi_train/81/button2.mdl"
})
Metrostroi.ClientPropForButton("KRP",{
	panel = "Front",
	button = "KRPSet",
	model = "models/metrostroi_train/81/button2.mdl",
	skin = 4
})
Metrostroi.ClientPropForButton("KDLR",{
	panel = "Main",
	button = "KDLRSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 7,
	z=2
})
Metrostroi.ClientPropForButton("KDLR_light",{
	panel = "Main",
	button = "KDLRSet",
	model = "models/metrostroi_train/81/button_light.mdl",
	ignorepanel = true,
	skin = 1,
	z=2
})
Metrostroi.ClientPropForButton("KDLRK",{
	panel = "Main",
	button = "KDLRKToggle",
	model = "models/metrostroi_train/81/krishka.mdl",
	ang = 0,
	z = -5
})
Metrostroi.ClientPropForButton("VDL",{
	panel = "HelperPanel",
	button = "VDLSet",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	z=-5,
})
Metrostroi.ClientPropForButton("VUD2",{
	panel = "HelperPanel",
	button = "VUD2Toggle",
	model = "models/metrostroi_train/switches/vudwhite.mdl",
	ang=90,
	z=-5,
})
Metrostroi.ClientPropForButton("Program1",{
	panel = "HelperPanel",
	button = "R_Program1Helper",
	model = "models/metrostroi_train/81/button.mdl",
})
Metrostroi.ClientPropForButton("Program2",{
	panel = "HelperPanel",
	button = "R_Program2Helper",
	model = "models/metrostroi_train/81/button.mdl",
})

Metrostroi.ClientPropForButton("SelectMain",{
	panel = "Announcer",
	button = "DURASelectMain",
	model = "models/metrostroi_train/81/button.mdl",
})
Metrostroi.ClientPropForButton("SelectAlternate",{
	panel = "Announcer",
	button = "DURASelectAlternate",
	model = "models/metrostroi_train/81/button.mdl",
})
Metrostroi.ClientPropForButton("SelectChannel",{
	panel = "Announcer",
	button = "DURAToggleChannel",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("DURAPower",{
	panel = "Announcer",
	button = "DURAPowerToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("GreenRPLight",{
	panel = "Main",
	button = "GreenRPLight",
	model = "models/metrostroi_train/81/lamp.mdl",
	z = -10,
})
Metrostroi.ClientPropForButton("GreenRPLight_light",{
	panel = "Main",
	button = "GreenRPLight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	z = -10,
})
Metrostroi.ClientPropForButton("AVULight",{
	panel = "Main",
	button = "AVULight",
	model = "models/metrostroi/81-717/light02.mdl",
})
Metrostroi.ClientPropForButton("AVULight",{
	panel = "Main",
	button = "AVULight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("AVULight_light",{
	panel = "Main",
	button = "AVULight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("KVPLight",{
	panel = "Main",
	button = "KVPLight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 3,
	z = -10,
})
Metrostroi.ClientPropForButton("KVPLight_light",{
	panel = "Main",
	button = "KVPLight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 3,
	z = -10,
})
Metrostroi.ClientPropForButton("SPLight",{
	panel = "Main",
	button = "SPLight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("SPLight_light",{
	panel = "Main",
	button = "SPLight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 1,
	z = -10,
})
Metrostroi.ClientPropForButton("CabinHeatLight",{
	panel = "Front",
	button = "CabinHeatLight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 2,
	z = -10,
})
Metrostroi.ClientPropForButton("CabinHeatLight_light",{
	panel = "Front",
	button = "CabinHeatLight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 2,
	z = -10,
})
Metrostroi.ClientPropForButton("PneumoLight",{
	panel = "Front",
	button = "PneumoLight",
	model = "models/metrostroi_train/81/lamp.mdl",
	skin = 4,
	z = -10,
})
Metrostroi.ClientPropForButton("PneumoLight_light",{
	panel = "Front",
	button = "PneumoLight",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	skin = 4,
	z = -10,
})

-- Placeholders
Metrostroi.ClientPropForButton("L_4",{
	panel = "Front",
	button = "L_4Toggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("TormAT",{
	panel = "Main",
	button = "TormATToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("TormATPl",{
	panel = "Main",
	button = "TormATPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -5,
})
Metrostroi.ClientPropForButton("L_1",{
	panel = "Main",
	button = "L_1Toggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("L_2",{
	panel = "Main",
	button = "L_2Toggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("L_3",{
	panel = "Main",
	button = "L_3Toggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("ConverterProtection",{
	panel = "Main",
	button = "ConverterProtectionSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 2,
})
Metrostroi.ClientPropForButton("ConverterProtection_light",{
	panel = "Main",
	button = "ConverterProtectionSet",
	model = "models/metrostroi_train/81/button_light.mdl",
	ignorepanel = true,
})
Metrostroi.ClientPropForButton("DIPoff",{
	panel = "Main",
	button = "DIPoffSet",
	model = "models/metrostroi_train/81/button.mdl"
})
Metrostroi.ClientPropForButton("KB",{
	panel = "Main",
	button = "2:KVTSet",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 5,
})
Metrostroi.ClientPropForButton("ARS13",{
	panel = "BPSNFront",
	button = "ARS13Set",
	model = "models/metrostroi_train/81/button.mdl"
})
--[[
Metrostroi.ClientPropForButton("Radio13",{
	panel = "BPSNFront",
	button = "Radio13Set",
	model = "models/metrostroi_train/81/button.mdl"
})
]]

-- Customs
Metrostroi.ClientPropForButton("Custom1",{
	panel = "Announcer",
	button = "Custom1Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 5,
})
Metrostroi.ClientPropForButton("Custom2",{
	panel = "Announcer",
	button = "Custom2Set",
	model = "models/metrostroi_train/81/button.mdl",
	skin = 5,
})
Metrostroi.ClientPropForButton("Custom3",{
	panel = "Announcer",
	button = "Custom3Set",
	model = "models/metrostroi_train/81/button.mdl"
})

Metrostroi.ClientPropForButton("CustomC",{
	panel = "Announcer",
	button = "CustomCToggle",
	model = "models/metrostroi_train/81/tumbler1.mdl",
	ang = 90
})
Metrostroi.ClientPropForButton("CustomD",{
	panel = "Announcer",
	button = "CustomD",
	model = "models/metrostroi_train/81/lamp.mdl",
	z = -10,
	skin = 1,
})
Metrostroi.ClientPropForButton("CustomE",{
	panel = "Announcer",
	button = "CustomE",
	model = "models/metrostroi_train/81/lamp.mdl",
	z = -10,
	skin = 2,
})
Metrostroi.ClientPropForButton("CustomF",{
	panel = "Announcer",
	button = "CustomF",
	model = "models/metrostroi_train/81/lamp.mdl",
	z = -10,
	skin = 4,
})
Metrostroi.ClientPropForButton("CustomG",{
	panel = "Announcer",
	button = "CustomG",
	model = "models/metrostroi_train/81/lamp.mdl",
	z = -10,
})

Metrostroi.ClientPropForButton("CustomD_light",{
	panel = "Announcer",
	button = "CustomD",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	z = -10,
	skin = 1,
})
Metrostroi.ClientPropForButton("CustomE_light",{
	panel = "Announcer",
	button = "CustomE",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	z = -10,
	skin = 2,
})
Metrostroi.ClientPropForButton("CustomF_light",{
	panel = "Announcer",
	button = "CustomF",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	z = -10,
	skin = 4,
})
Metrostroi.ClientPropForButton("CustomG_light",{
	panel = "Announcer",
	button = "CustomG",
	model = "models/metrostroi_train/81/lamp_on.mdl",
	ignorepanel = true,
	z = -10,
})
--Metrostroi.ClientPropForButton("Autodrive",{
--	panel = "Main",
--	button = "AutodriveToggle",
--	model = "models/metrostroi/81-717/switch04.mdl",
--})

--------------------------------------------------------------------------------
ENT.ClientProps["gv"] = {
	model = "models/metrostroi/81-717/gv.mdl",
	pos = Vector(120,62.0+0.0,-60),
	ang = Angle(-90,0,-90)
}
ENT.ClientProps["gv_wrench"] = {
	model = "models/metrostroi/81-717/reverser.mdl",
	pos = Vector(120,62.0+0.0,-60),
	ang = Angle(0,0,0)
}
--------------------------------------------------------------------------------
for x=0,11 do
	for y=0,3 do
		if (x+12*y) == 37 then continue end
		ENT.ClientProps["a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(398.4,-10.5+x*3.26,46-y*10.4),
			ang = Angle(90,0,0)
		}
		Metrostroi.InsertHide("AV","a"..(x+12*y))
	end
end

ENT.ClientProps["L_5"] ={
	model = "models/metrostroi/81-717/circuit_breaker.mdl",
	pos = Vector(398.4,-10.5+1*3.26,46-3*10.4), --407.3
	ang = Angle(90,0,0)
}
ENT.ClientProps["A5Pl"] ={
	model = "models/metrostroi_train/81/plomb_b.mdl",
	pos = Vector(399.5,-10.5+2*3.26,43.75-2*10.4),
	ang = Angle(42,0,0)
}

Metrostroi.InsertHide("AV","L_5")
Metrostroi.InsertHide("AV","A5Pl")

for x=0,11 do
	for y=0,3 do
		if (x+12*y) == 37 then continue end
		ENT.ClientProps["1_a"..(x+12*y)] = {
			model = "models/metrostroi/81-717/circuit_breaker.mdl",
			pos = Vector(398.4,-10.5+x*3.26,47-y*10.4)+ Vector(11,-47,0.5),
			ang = Angle(90,0,0)
		}
		Metrostroi.InsertHide("AV_1","1_a"..(x+12*y))
	end
end

ENT.ClientProps["L_5_1"] ={
	model = "models/metrostroi/81-717/circuit_breaker.mdl",
	pos = Vector(398.4,-10.5+1*3.26,47-3*10.4)+ Vector(11,-47,0.5),
	ang = Angle(90,0,0)
}
ENT.ClientProps["A5Pl_1"] ={
	model = "models/metrostroi_train/81/plomb_b.mdl",
	pos = Vector(399.5,-10.4+2*3.26,44.55-2*10.4)+ Vector(11,-47.05,0.65),
	ang = Angle(42,0,0)
}
Metrostroi.InsertHide("AV_1","L_5_1")
Metrostroi.InsertHide("AV_1","A5Pl_1")
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
Metrostroi.ClientPropForButton("RC1Pl",{
	panel = "Battery",
	button = "RC1Pl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
})

Metrostroi.ClientPropForButton("UOSPl",{
	panel = "Battery",
	button = "UOSPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
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
Metrostroi.ClientPropForButton("RC1Pl_2",{
	panel = "Battery_2",
	button = "1:RC1Pl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
})

Metrostroi.ClientPropForButton("UOSPl_2",{
	panel = "Battery_2",
	button = "1:UOSPl",
	model = "models/metrostroi_train/81/plomb.mdl",
	z = -3,
})

Metrostroi.ClientPropForButton("BPS_2",{
	panel = "Battery_2",
	button = "BPSToggle",
	model = "models/metrostroi/81-717/rc.mdl",
})
--------------------------------------------------------------------------------
ENT.ClientProps["book"] = {
	model = "models/props_lab/clipboard.mdl",
	pos = Vector(410.5,-50,-8),
	ang = Angle(85,0,0)
}

ENT.ClientProps["FrontBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(450, -26.0, -52.3),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["FrontTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(450, 25.7, -52.8),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["RearBrake"] = {--
	model = "models/metrostroi_train/81/tmiso.mdl",
	pos = Vector(-455, -25.8, -52.5),
	ang = Angle(0,90,0)
}
ENT.ClientProps["RearTrain"] = {--
	model = "models/metrostroi_train/81/nmsio.mdl",
	pos = Vector(-455, 26, -52.0),
	ang = Angle(0,90,0)
}
ENT.ClientProps["PB"] = {--
	model = "models/metrostroi_train/81/pb.mdl",
	pos = Vector(451.5, 22.5, -27.5),
	ang = Angle(0,-90,40)
}

--------------------------------------------------------------------------------
-- Add doors
local function GetDoorPosition(i,k,j)
	if j == 0
	then return Vector(359.0 - 35.0*k     - 229.5*i,-65*(1-2*k),7.5)
	else return Vector(359.0 - 35.0*(1-k) - 229.5*i,-65*(1-2*k),7.5)
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
	pos = Vector(-469.0,16.2,6),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door2"] = {
	model = "models/metrostroi_train/81/passdoor.mdl",
	pos = Vector(380.0,28.0,6.5),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["door3"] = {
	model = "models/metrostroi_train/81/cabindoor.mdl",
	pos = Vector(446.6,65.0,7.1),
	ang = Angle(0,-90,0)
}
ENT.ClientProps["UAVALever"] = {
	model = "models/metrostroi_train/81/uavalever.mdl",
	pos = Vector(429.6,-60.8,-15.9),
	ang = Angle(180,0,-65)
}
ENT.ClientProps["wiper"] = {
	model = "models/metrostroi_train/81/wiper.mdl",
	pos = Vector(463.8,0,53.8),
	ang = Angle(0,-90,0)
}
for i = 0,22 do
	ENT.ClientProps["lamp1_"..i+1] = {
		model = "models/metrostroi_train/81/lamp1.mdl",
		pos = Vector(-420.76 + 34.7985*i, 0, 77),
		ang = Angle(180,0,0),
		color = Color(255,175,100),
	}
end
for i = 1,12 do
	ENT.ClientProps["lamp2_"..i] = {
		model = "models/metrostroi_train/81/lamp2.mdl",
		pos = Vector(-462.9 + 66.12*i, 0, 76.7),
		ang = Angle(180,0,0),
		color = Color(240,240,255),
	}
	ENT.ClientProps["lamp3_"..i] = {
		model = "models/metrostroi_train/81/lamp3.mdl",
		pos = Vector(-462.9 + 66.12*i, 0, 77.5),
		ang = Angle(180,0,0),
	}
end

--ENT.AutoPos = {Vector(407.3,-10.5,47),Vector(419.3,-57.5,47.5)}
--local X = Material( "metrostroi_skins/81-717/6.png")

function ENT:Initialize()
	self.BaseClass.Initialize(self)
end

function ENT:UpdateTextures()
	local texture = Metrostroi.Skins["train"][self:GetNW2String("texture")]
	local passtexture = Metrostroi.Skins["pass"][self:GetNW2String("passtexture")]
	local cabintexture = Metrostroi.Skins["cab"][self:GetNW2String("cabtexture")]
	for _,ent in pairs(self.ClientEnts) do
		if not IsValid(ent) then continue end
		for k,v in pairs(ent:GetMaterials()) do
			local tex = string.Explode("/",v)
			tex = tex[#tex]
			if cabintexture and cabintexture.textures[tex] then
				ent:SetSubMaterial(k-1,cabintexture.textures[tex])
			end
			if passtexture and passtexture.textures[tex] then
				ent:SetSubMaterial(k-1,passtexture.textures[tex])
			end
			if texture and texture.textures[tex] then
				ent:SetSubMaterial(k-1,texture.textures[tex])
			end
		end
	end
end
--------------------------------------------------------------------------------
function ENT:Think()
	self.BaseClass.Think(self)
	if self.Texture ~= self:GetNW2String("texture") then
		self.Texture = self:GetNW2String("texture")
		self:UpdateTextures()
	end
	if self.PassTexture ~= self:GetNW2String("passtexture") then
		self.PassTexture = self:GetNW2String("passtexture")
		self:UpdateTextures()
	end
	if self.CabinTexture ~= self:GetNW2String("cabtexture") then
		self.CabinTexture = self:GetNW2String("cabtexture")
		self:UpdateTextures()
	end
	--if self.Breakers == nil then self.Breakers = false end
	if self.Breakers ~= self:GetNW2Bool("Breakers") then
		self.Breakers = self:GetNW2Bool("Breakers")
		self:HidePanel("Battery",self.Breakers)
		self:HidePanel("Battery_2",not self.Breakers)
		self:HidePanel("AV",self.Breakers)
		self:HidePanel("AV_1",not self.Breakers)
		self:ShowHide("UOS",not self.Breakers)
		self:ShowHide("UOS_2",self.Breakers)
		self:ShowHide("UOSPl",not self.Breakers)
		self:ShowHide("UOSPl_2",self.Breakers)
	end
	if self.OldARS ~= self:GetNW2Int("ARSType",1) then
		self:HidePanel("OldARS",self:GetNW2Int("ARSType",1) ~= 4)
		self:ShowHide("speed1",self:GetNW2Int("ARSType",1) == 4)
		self.OldARS = self:GetNW2Int("ARSType",1)
	end
	if self.ClientProps["KVPLight_light"] and self.ClientProps["KVPLight_light"].skin ~= self:GetNW2Int("KVPType") then
		self.ClientProps["KVPLight_light"].skin = self:GetNW2Int("KVPType")
		if IsValid(self.ClientEnts["KVPLight_light"]) then self.ClientEnts["KVPLight_light"]:SetSkin(self:GetNW2Int("KVPType")) end
	end
	if self.ClientProps["KVPLight"] and self.ClientProps["KVPLight"].skin ~= self:GetNW2Int("KVPType") then
		self.ClientProps["KVPLight"].skin = self:GetNW2Int("KVPType")
		if IsValid(self.ClientEnts["KVPLight"]) then self.ClientEnts["KVPLight"]:SetSkin(self:GetNW2Int("KVPType")) end
	end
	-- Distance cull
	local distance = self:GetPos():Distance(LocalPlayer():GetPos())
	if distance > 8192 then return end
--[[
	self:SetBodygroup(0,(self.ARSType or 1)-1)
	self:SetBodygroup(1,(self.LampType or 1)-1)
	self:SetBodygroup(3,(self.MaskType or 1)-1)
	self:SetBodygroup(4,(self.SeatType or 1)-1)
	self:SetBodygroup(5,(self.HandRail or 1)-1)
	self:SetBodygroup(6,self.MVM and (self.MaskType > 2 and 1 or 0) or 2)
	self:SetBodygroup(7,(self.BortLampType or 1)-1)
	]]
	if (self.Transient or 0) ~= 0.0 then self.Transient = 0.0 end
	self.KRUPos = self.KRUPos or 0
	if self:GetPackedBool(27)
	then self.KRUPos = self.KRUPos + (0.0 - self.KRUPos)*8.0*self.DeltaTime
	else self.KRUPos = 1.0
	end
	if not self.WiperValue then self.WiperValue = 0 end
	if self:GetPackedBool("Wiper") then
		self.WiperValue = self.WiperValue + 3.14*self.DeltaTime*(self:GetPackedRatio(5)*2)
	end
	if self.WiperValue > math.pi*2 then self.WiperValue = 0 end
	-- Simulate pressure gauges getting stuck a little
	self:Animate("brake334", 		1-self:GetPackedRatio(0), 			0.00, 0.65,  256,24)
	self:Animate("wiper", 		(math.sin(self.WiperValue-math.pi/2)+2)/2 - 0.5, 			0, 0.34,  256,24)
	self:Animate("brake013", 		self:GetPackedRatio(0)^0.5,			0.00, 0.65,  256,24)
	--print(self:GetPackedBool(163))
	self:Animate("controller",		1-self:GetPackedRatio(1),			0.38, 0.78,  2,false)
	self:Animate("controller_old",		self:GetPackedRatio(1),	0, 1.17,  2,false)
	self:Animate("reverser",		self:GetPackedRatio(2),				0.46, 0.54,  4,false)
	self:Animate("volt1", 			self:GetPackedRatio(10),			0.381, 0.645,				nil, nil,  256,2,0.01)
	self:Animate("speed1", 			self:GetPackedRatio("Speed"),			0.42-0.06, 0.627+0.06,				nil, nil,  256,2,0.01)
	self:ShowHide("reverser",		self:GetPackedBool(0))
	self:Animate("krureverser",		0.5+(0.5-self.KRUPos*0.5)-0.5*(self:GetPackedRatio(2)/2),		0.05, 1,  3,false)
	self:ShowHide("krureverser",	self:GetPackedBool(27))

	self:ShowHide("brake013",		self:GetPackedBool(22))
	self:ShowHide("brake334",		not self:GetPackedBool(22))

	self:Animate("brake_disconnect",self:GetPackedBool(6) and 1 or 0, 	1,0.5, 3, false)
	self:Animate("ParkingBrake",	self:GetPackedBool(160) and 0 or 1,0,0.5, 3, false)

	self:Animate("brake_disconnect2",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0, 	0,0.5, 3, false)
	self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0, 	0,0.5, 3, false)

	self:Animate("ParkingBrake2",	self:GetPackedBool(160) and 0 or 1,0.5,1, 3, false)
	self:ShowHide("brake_disconnect", self:GetPackedBool(22))
	self:ShowHide("ParkingBrake", self:GetPackedBool(22))
	self:ShowHide("brake_disconnect2", not self:GetPackedBool(22))
	self:ShowHide("train_disconnect", not self:GetPackedBool(22))
	self:ShowHide("ParkingBrake2", not self:GetPackedBool(22))
	self:ShowHide("DriverValveDisconnectToggle", self:GetPackedBool(22))
	self:ShowHide("ParkingBrakeToggle", self:GetPackedBool(22))
	self:ShowHide("DriverValveTLDisconnect", not self:GetPackedBool(22))
	self:ShowHide("DriverValveBLDisconnect", not self:GetPackedBool(22))
	self:ShowHide("1:ParkingBrakeToggle", not self:GetPackedBool(22))

	self:ShowHide("controller",		self:GetNW2Bool("NewKV"))
	self:ShowHide("controller_old",		not self:GetNW2Bool("NewKV"))
	--print(self:GetPackedRatio(6))
	self:Animate("brake_line",		self:GetPackedRatio(4),				0.21, 0.865,  256,2)--,0.01)
	self:Animate("train_line",		self:GetPackedRatio(5),	0.21, 0.865,  4096,0)--,0.01)
	self:Animate("brake_cylinder",	self:GetPackedRatio(6),	 			0.215, 0.86,  256,2)--,0.03)
	--print(self:GetPackedRatio(7))
	--print((math.sin(CurTime()%4/4/math.pi*30)+2)/2-0.5)
	self:Animate("voltmeter",		self:GetPackedRatio(7),				0.419, 0.620,				nil, nil)--,  256,2,0.01)
	self:Animate("ampermeter",		self:GetPackedRatio(8),				0.42, 0.627,				nil, nil,  256,2,0.01)

	self:Animate("headlights",		self:GetPackedBool(1) and 1 or 0, 	0,1, 8, false)
	self:Animate("VozvratRP",		self:GetPackedBool(2) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPon",			self:GetPackedBool(3) and 1 or 0, 	0,1, 16, false)
	self:Animate("DIPoff",			self:GetPackedBool(4) and 1 or 0, 	0,1, 16, false)
	self:Animate("battery",			self:GetPackedBool(7) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("battery_2",			self:GetPackedBool(7) and 0.87 or 1, 	0,1, 1, false)
	self:Animate("RezMK",			self:GetPackedBool(8) and 1 or 0, 	0,1, 16, false)
	self:Animate("VMK",				self:GetPackedBool(9) and 1 or 0, 	0,1, 16, false)
	self:Animate("VAH",				self:GetPackedBool(10) and 1 or 0, 	0,1, 16, false)
	local VAD = self:Animate("VAD",				self:GetPackedBool(11) and 1 or 0, 	0,1, 16, false)
	self:Animate("VUD1",			(self:GetPackedBool(12) and 1 or 0), 	0,1, 8, false)
	self:Animate("VUD2",			self:GetPackedBool(13) and 1 or 0, 	0,1, 8, false)
	self:Animate("VDL",				self:GetPackedBool(14) and 1 or 0, 	0,1, 8, false)
	self:Animate("VZ1",				self:GetPackedBool("VZ1") and 1 or 0, 	0,1, 16, false)
	self:Animate("KDLR",				self:GetPackedBool("KDLR") and 1 or 0, 	0,1, 16, false)	self:AnimateFrom("KDLR_light","KDLR")
	self:Animate("KDL",				self:GetPackedBool(15) and 1 or 0, 	0,1, 16, false)	self:AnimateFrom("KDL_light","KDL")
	self:Animate("KDP",				self:GetPackedBool(16) and 1 or 0, 	0,1, 16, false)	self:AnimateFrom("KDP_light","KDP")
	self:Animate("KDLK",				self:GetPackedBool("KDLK") and 1 or 0, 	0.32,0.67, 8,false)
	self:Animate("KDLRK",				self:GetPackedBool("KDLRK") and 1 or 0, 	0.32,0.67, 8, false)
	self:Animate("KDLRK",				self:GetPackedBool("KDLRK") and 1 or 0, 	0.32,0.67, 8, false)
	self:Animate("KDPK",				self:GetPackedBool("KDPK") and 1 or VAD*0.17, 	0.34,0.69, 8, false)
	self:Animate("KAHK",				self:GetPackedBool("KAHK") and 1 or 0, 	0.32,0.68, 8, false)
	self:HideButton("KDLSet",self:GetPackedBool("KDLK"))
	self:HideButton("KDLRSet",self:GetPackedBool("KDLRK"))
	self:HideButton("KDPSet",self:GetPackedBool("KDPK"))
	self:HideButton("KAHSet",self:GetPackedBool("KAHK"))

	self:SetCSBodygroup("UOSPl",1,self:GetPackedBool("UOSPl") and 0 or 1)
	self:SetCSBodygroup("OtklAVUPl",1,self:GetPackedBool("OtklAVUPl") and 0 or 1)
	self:SetCSBodygroup("TormATPl",1,self:GetPackedBool("TormATPl") and 0 or 1)
	self:SetCSBodygroup("RC1Pl",1,self:GetPackedBool("RC1Pl") and 0 or 1)
	self:SetCSBodygroup("KAHPl",1,self:GetPackedBool("KAHPl") and 0 or 1)
	self:SetCSBodygroup("VAHPl",1,self:GetPackedBool("VAHPl") and 0 or 1)
	self:SetCSBodygroup("VADPl",1,self:GetPackedBool("VADPl") and 0 or 1)
	self:SetCSBodygroup("A5Pl",1,self:GetPackedBool("A5Pl") and 0 or 1)
	self:SetCSBodygroup("RC1Pl_2",1,self:GetPackedBool("RC1Pl") and 0 or 1)
	self:SetCSBodygroup("UOSPl_2",1,self:GetPackedBool("UOSPl") and 0 or 1)

	self:HideButton("UOS",self:GetPackedBool("UOSPl"))
	self:HideButton("TormAT",self:GetPackedBool("TormATPl"))
	self:HideButton("VAH",self:GetPackedBool("VAHPl"))
	self:HideButton("VAD",self:GetPackedBool("VADPl"))
	self:HideButton("OtklAVU",self:GetPackedBool("OtklAVUPl"))
	self:HideButton("RC1",self:GetPackedBool("RC1Pl"))
	self:HideButton("KAH",self:GetPackedBool("KAHPl"))
	self:HideButton("KAHK",self:GetPackedBool("KAHPl"))
	self:HideButton("1:A5Toggle",self:GetPackedBool("A5Pl"))
	self:HideButton("RC1_2",self:GetPackedBool("RC1Pl"))
	self:HideButton("UOS_2",self:GetPackedBool("UOSPl"))
	self:HideButton("2:A5Toggle",self:GetPackedBool("A5Pl"))

	self:HideButton("UOSPl",not self:GetPackedBool("UOSPl"))
	self:HideButton("TormATPl",not self:GetPackedBool("TormATPl"))
	self:HideButton("VAHPl",not self:GetPackedBool("VAHPl"))
	self:HideButton("VADPl",not self:GetPackedBool("VADPl"))
	self:HideButton("OtklAVUPl",not self:GetPackedBool("OtklAVUPl"))
	self:HideButton("RC1Pl",not self:GetPackedBool("RC1Pl"))
	self:HideButton("KAHPl",not self:GetPackedBool("KAHPl"))
	self:HideButton("1:A5Pl",not self:GetPackedBool("A5Pl"))
	self:HideButton("RC1Pl_2",not self:GetPackedBool("RC1Pl"))
	self:HideButton("UOSPl_2",not self:GetPackedBool("UOSPl"))
	self:HideButton("2:A5Pl",not self:GetPackedBool("A5Pl"))


	local An = self:Animate("KDLRr",self:GetPackedBool("Left") and 1 or 0,0,1,10,false)
	self:ShowHideSmooth("KDL_light",An)
	self:ShowHideSmooth("KDLR_light",An)
	self:ShowHideSmooth("KDP_light",self:Animate("KDPr",self:GetPackedBool("Right") and 1 or 0,0,1,10,false))

	self:Animate("KRZD",			self:GetPackedBool(17) and 1 or 0, 	0,1, 16, false)
	self:Animate("KSN",				self:GetPackedBool(18) and 1 or 0, 	0,1, 16, false)
	self:Animate("OtklAVU",			self:GetPackedBool(19) and 1 or 0, 	0,1, 16, false)
	self:Animate("TormAT",			self:GetPackedBool("TormAT") and 1 or 0, 	0,1, 16, false)
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
	self:Animate("R_ZS",			self:GetPackedBool(127) and 1 or 0, 0,1, 16, false)
	self:Animate("R_VPR",		self:GetPackedBool("VPR") and 1 or 0, 0,1, 16, false)
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
	self:Animate("ConverterProtection",self:GetPackedBool("ConverterProtection") and 1 or 0,0,1,8,false)
	self:Animate("ConverterProtection_light",self:GetPackedBool("ConverterProtection") and 1 or 0,0,1,8,false)
	if self:GetPackedBool(156) and not self.Door1 then self.Door1 = 0.99 end
	if self:GetPackedBool(158) and not self.Door2 then self.Door2 = 0.99 end
	if self:GetPackedBool(159) and not self.Door3 then self.Door3 = 0.99 end
	if not self:GetPackedBool(156) and self.Door1 then self.Door1 = false end
	if not self:GetPackedBool(158) and self.Door2 then self.Door2 = false end
	if not self:GetPackedBool(159) and self.Door3 then self.Door3 = false end

	self:ShowHideSmooth("GreenRPLight_light",self:Animate("GreenRPl",self:GetPackedBool(36) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("AVULight_light",self:Animate("AVUl",self:GetPackedBool(38) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("CabinHeatLight_light",self:Animate("Heatl",self:GetPackedBool(37) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("KVPLight_light",self:Animate("KVPl",self:GetPackedBool(52) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("SPLight_light",self:Animate("SPl",self:GetPackedBool("LSP") and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("PneumoLight_light",self:Animate("Pneumol",self:GetPackedBool("PN") and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("ConverterProtection_light",self:Animate("ConverterProtectionl",self:GetPackedBool("RZP") and 1 or 0,0,1,10,false))

	self:ShowHideSmooth("CustomD_light",self:Animate("CustomD",(self:GetPackedBool("CustomD") or self.ASNP.End) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("CustomE_light",self:Animate("CustomE",(self:GetPackedBool("CustomE") or self.ASNP.Right) and 1 or 0,0,1,10,false))
	local State = self:GetNW2Int("Announcer:State",-1)
	self:ShowHideSmooth("CustomF_light",self:Animate("CustomF",(self:GetPackedBool("CustomF") or State > 0 and State < 7) and 1 or 0,0,1,10,false))
	self:ShowHideSmooth("CustomG_light",self:Animate("CustomG",(self:GetPackedBool("CustomG") or self:GetNW2Bool("Announcer:Playing",false)) and 1 or 0,0,1,10,false))

	if self:GetNW2Int("ARSType",1) == 4 then
		self:ShowHideSmooth("LRP_light",self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,12,false) + self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,0.3,12,false))
		self:ShowHideSmooth("LKT_light",self:Animate("light_KT",self:GetPackedBool(47) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LKVD_light",self:Animate("light_KVD",self:GetPackedBool(48) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LST_light",self:Animate("light_LST",self:GetPackedBool(49) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LVD_light",self:Animate("light_LVD",self:GetPackedBool(50) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LKVC_light",1-self:Animate("light_LKVC",self:GetPackedBool(34) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LEKK_light",0)
		self:ShowHideSmooth("LPU_light",0)
		self:ShowHideSmooth("LSD",self:Animate("light_SD",self:GetPackedBool(40)and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LOCh",self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("L0",self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LRS",self:Animate("light_LRS",self:GetPackedBool(54) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("L40",self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("L60",self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("L80",self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("L70",self:Animate("light_70",self:GetPackedBool(45) and 1 or 0,0,1,8,false))
		self:ShowHideSmooth("LRK",self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,8,false))
	end
--[[
	local accel = self:GetNW2Float("Accel")
	if math.abs(accel) > 0.1 then
		if self.Door1 then self.Door1 = math.min(0.99,math.max(0,self.Door1+accel*self.DeltaTime)) end
		if self.Door2 then self.Door2 = math.min(0.99,math.max(0,self.Door2+accel*self.DeltaTime)) end
		if self.Door3 then self.Door3 = math.min(0.99,math.max(0,self.Door3+accel*self.DeltaTime)) end
	end
	if self.Door1 == 0.99 then
		sendButtonMessage({ID = "BackDoor",state = true})
		sendButtonMessage({ID = "BackDoor",state = false})
	end
	if self.Door2 == 0.99 then
		sendButtonMessage({ID = "PassDoor",state = true})
		sendButtonMessage({ID = "PassDoor",state = false})
	end
	if self.Door3 == 0.99 then
		sendButtonMessage({ID = "CabinDoor",state = true})
		sendButtonMessage({ID = "CabinDoor",state = false})
	end
	]]
	if self.LampType ~= self:GetNW2Int("LampType",0) then
		self.LampType = self:GetNW2Int("LampType",1)
		for i = 1,23 do
			self:ShowHide("lamp1_"..i,self.LampType == 1)
			if i < 13 then
				self:ShowHide("lamp2_"..i,self.LampType == 2)
				self:ShowHide("lamp3_"..i,self.LampType == 3)
			end
		end
	end
	if self.LampType == 1 then
		for i = 1,23 do
			self:ShowHideSmooth("lamp1_"..i,self:Animate("Lamp1_"..i,	(self:GetPackedBool("lightsActive"..i) or self:GetPackedBool("lightsActiveB"..i) and CurTime()%math.random()*2 > 0.8) and 1 or 0,0,1,6,false))
		end
	else
		for i = 1,12 do
			if self.LampType == 2 then
				self:ShowHideSmooth("lamp2_"..i,self:Animate("Lamp2_"..i,	(self:GetPackedBool("lightsActive"..i) or self:GetPackedBool("lightsActiveB"..i) and CurTime()%math.random()*2 > 0.8) and 1 or 0,0,1,6,false))
			else
				self:ShowHideSmooth("lamp3_"..i,self:Animate("Lamp3_"..i,	(self:GetPackedBool("lightsActive"..i) or self:GetPackedBool("lightsActiveB"..i) and CurTime()%math.random()*2 > 0.8) and 1 or 0,0,1,6,false))
			end
		end
	end
	self:Animate("door1",	self:GetPackedBool(156) and (self.Door1 or 0.99) or 0,0,0.54, 1024, 1)
	self:Animate("door2",	self:GetPackedBool(158) and (self.Door2 or 0.99) or 0,0,0.51, 1024, 1)
	self:Animate("door3",	self:GetPackedBool(159) and (self.Door3 or 0.99) or 0,0,0.54, 1024, 1)

	self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,0.35, 3, false)
	self:Animate("FrontTrain",	self:GetNW2Bool("FtI") and 0 or 1,0,0.35, 3, false)
	self:Animate("RearBrake",	self:GetNW2Bool("RbI") and 1 or 0,0,0.35, 3, false)
	self:Animate("RearTrain",	self:GetNW2Bool("RtI") and 1 or 0,0,0.35, 3, false)

	self:Animate("PB",	self:GetPackedBool(165) and 1 or 0,0,0.2,  8,false)
	-- Animate AV switches
	for i in ipairs(self.Panel.AVMap) do
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
	-- Animate doors
	for i=0,3 do
		for k=0,1 do
			local n_l = "door"..i.."x"..k.."a"
			local n_r = "door"..i.."x"..k.."b"
			self:Animate(n_l,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
			self:Animate(n_r,self:GetPackedBool(21+(1-k)*4) and 1 or 0,0,1, 0.8 + (-0.2+0.4*math.random()),0)
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
	then self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*(0-self.BrakeLineRamp1)*dT
	else self.BrakeLineRamp1 = self.BrakeLineRamp1 + 4.0*((-0.6*brakeLinedPdT)-self.BrakeLineRamp1)*dT
	end
	self.BrakeLineRamp1 = math.Clamp(self.BrakeLineRamp1,0,1)
	self:SetSoundState("release2",self.BrakeLineRamp1^1.65,1.0)

	self.BrakeLineRamp2 = self.BrakeLineRamp2 or 0
	if (brakeLinedPdT < 0.001)
	then self.BrakeLineRamp2 = self.BrakeLineRamp2 + 4.0*(0-self.BrakeLineRamp2)*dT
	else self.BrakeLineRamp2 = self.BrakeLineRamp2 + 8.0*(0.1*brakeLinedPdT-self.BrakeLineRamp2)*dT
	end
	self.BrakeLineRamp2 = math.Clamp(self.BrakeLineRamp2,0,1)
	self:SetSoundState("release3",self.BrakeLineRamp2 + math.max(0,self.BrakeLineRamp1/2-0.15),1.0)

	self:SetSoundState("cran1",math.min(1,self:GetPackedRatio(4)/50*(self:GetPackedBool(6) and 1 or 0)),1.0)

	-- Compressor
	local state = self:GetPackedBool(20)
	self.PreviousCompressorState = self.PreviousCompressorState or false
	if self.PreviousCompressorState ~= state then
		self.PreviousCompressorState = state
		if 	state then
			self:SetSoundState("compressor_717",1,1)
		else
			self:SetSoundState("compressor_717",0,1)
			self:SetSoundState("compressor_717_end",0,1)
			self:SetSoundState("compressor_717_end",1,1)
			--self:PlayOnce("compressor_e_end",nil,1,nil,true)
		end
	end
	-- ARS/ringer alert
	state = self:GetPackedBool(39)
	self.PreviousAlertState = self.PreviousAlertState or false
	if self.PreviousAlertState ~= state then
		self.PreviousAlertState = state
		if state then
			self:SetSoundState("ring2",0.20,1)
		else
			self:SetSoundState("ring2",0,0)
			self:SetSoundState("ring2_end",0,1.02)
			self:SetSoundState("ring2_end",0.20,1.02)
		end
	end

	state = self:GetPackedBool("VPR")
	self.PreviousVPRState = self.PreviousVPRState or false
	if self.PreviousVPRState ~= state then
		self.PreviousVPRState = state
		if state then
			self:SetSoundState("vpr",1,1)
		else
			self:SetSoundState("vpr",0,0)
			self:PlayOnce("vpr_end","cabin",1)
		end
	end

	-- RK rotation
	if self:GetPackedBool(112) then self.RKTimer = CurTime() end
	state = (CurTime() - (self.RKTimer or 0)) < 0.2
	self.PreviousRKState = self.PreviousRKState or false
	if self.PreviousRKState ~= state then
		self.PreviousRKState = state
		if state then
			self:SetSoundState("rk_spin",0.7,1,nil,0.75)
		else
			self:SetSoundState("rk_spin",0,0,nil,0.75)
			self:SetSoundState("rk_stop",0,1,nil,0.75)
			self:SetSoundState("rk_stop",0.7,1,nil,0.75)
		end
	end

	-- IGLA alert
	--local state = true --self:GetPackedBool(39)
	--self:SetSoundState("ring2",0.20,1)

	-- BPSN sound
	self.BPSNType = self:GetNW2Int("BPSNType",7)
	if not self.OldBPSNType then self.OldBPSNType = self.BPSNType end
	if self.BPSNType ~= self.OldBPSNType then
		if self.OldBPSNType ~= 7 then
			self:SetSoundState("bpsn"..self.OldBPSNType,0,1.0)
		else
			self:SetSoundState("bpsn2",0,1.0)
			self:SetSoundState("bpsn3",0,1.0)
			self:SetSoundState("bpsn6",0,1.0)
		end
	end

	state = self:GetPackedBool(52)
	--self.PreviousBPSNState = self.PreviousBPSNState or false
	--
	if state then
		if self.BPSNType ~= 7 then
			self:SetSoundState("bpsn"..self.BPSNType,2,1.0,nil,0.9)
		else
			self:SetSoundState("bpsn2",0.2,1.0)
			self:SetSoundState("bpsn3",0.4,1)
			self:SetSoundState("bpsn6",1,1)
		end
		if self.PreviousBPSNState ~= state then self.BPSNOff = nil end
	else
		if self.BPSNOff == nil then self.BPSNOff = CurTime() + 2 end
	end
	self.PreviousBPSNState = state
	--end
	if self.BPSNOff and self.BPSNOff - CurTime() < 0 then self.BPSNOff = false end
	--if self.BPSNOff then print(1-math.cos((self.BPSNOff - CurTime()) / 2 * math.pi/2),(self.BPSNOff - CurTime()) / 2) end
	if self.BPSNOff then
		if self.BPSNType ~= 7 then
			self:SetSoundState("bpsn"..self.BPSNType,1-math.cos((self.BPSNOff - CurTime()) / 2 * math.pi/2),1)
		else
			self:SetSoundState("bpsn2",1-math.cos((self.BPSNOff - CurTime()) / 2 * math.pi/2),1)
			self:SetSoundState("bpsn3",1-math.cos((self.BPSNOff - CurTime()) / 2 * math.pi/2),1)
			self:SetSoundState("bpsn6",1-math.cos((self.BPSNOff - CurTime()) / 2 * math.pi/2),1)
		end
	elseif self.BPSNOff == false then
		if self.BPSNType ~= 7 then
			self:SetSoundState("bpsn"..self.BPSNType,0,0)
		else
			self:SetSoundState("bpsn2",0,1.0)
			self:SetSoundState("bpsn3",0,1)
			self:SetSoundState("bpsn6",0,1)
		end
	end
	self.OldBPSNType = self.BPSNType
end

ENT.ParkingBrakeMaterial = Material( "models/metrostroi_train/parking_brake.png", "vertexlitgeneric unlitgeneric mips" )
function ENT:Draw()
	self.BaseClass.Draw(self)
end
function ENT:DrawPost(special)
	--local dc = render.GetLightColor(self:LocalToWorld(Vector(460.0,0.0,5.0)))

	if self.InfoTableTimeout and (CurTime() < self.InfoTableTimeout) then
		self:DrawOnPanel("InfoTableSelect",function()
			local text = self:GetNW2String("FrontText","")
			local col = text:find("ЗЕЛ") and Color(100,200,0) or text:find("СИН") and Color(0,100,200) or text:find("МАЛ") and Color(200,100,200) or text:find("ОРА") and Color(200,200,0) or text:find("БИР") and Color(48,213,200) or Color(255,0,0)
			draw.DrawText(self:GetNW2String("RouteNumber","") .. " " .. text,"MetrostroiSubway_InfoPanel",260, -100,col,TEXT_ALIGN_CENTER)
			--[[
			draw.Text({
				text = self:GetNW2String("RouteNumber","") .. " " .. self:GetNW2String("FrontText",""),
				font = "MetrostroiSubway_InfoPanel",--..self:GetNW2Int("Style",1),
				pos = { 260, -100 },
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = Color(255,0,0,255)})
			]]
		end)
	end

	self:DrawOnPanel("InfoRoute",function()
		surface.SetAlphaMultiplier(1)
		surface.SetDrawColor(255,255,255) --255*dc.x,250*dc.y,220*dc.z)
		--surface.DrawRect(0,100,88,70)
		local rn = self:GetNW2String("RouteNumber","00")
		surface.SetMaterial(Metrostroi.RouteTextures.m[rn[1]])
		surface.DrawTexturedRect(0,100,44,70)
		surface.SetMaterial(Metrostroi.RouteTextures.m[rn[2]])
		surface.DrawTexturedRect(44,100,44,70)
		--[[
		draw.Text({
			text = self:GetNW2String("RouteNumber","00"),
			font = "MetrostroiSubway_InfoRoute",--..self:GetNW2Int("Style",1),
			pos = { 44, 135 },
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = Color(0,0,0,255)})
			]]
	end)

	local distance = self:GetPos():Distance(LocalPlayer():GetPos())
	if distance > 1024 or special then return end
	self.ButtonMap["ARS"] = self.ARSMap[math.max(1,math.min(4,self:GetNW2Int("ARSType",1)))]
	if self:GetNW2Int("ARSType",1) ~= 4 then
		self:DrawOnPanel("ARS",function()
			if self:GetNW2Int("ARSType",1) ~= 2 then return end
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
			if self:GetNW2Int("ARSType",1) ~= 3 then return end
			if not self:GetPackedBool(32) then return end

			local speed = self:GetPackedRatio(3)*100.0
			local d1 = math.floor(speed) % 10
			local d2 = math.floor(speed / 10) % 10
			self:DrawDigit((136+0) *10,	26*10, d2, 1.00, 0.85)
			self:DrawDigit((136+20)*10,	26*10, d1, 1.00, 0.85)

			------------------------------------------------------------------------
			local speedValue = math.floor(speed/5 + 0.5)
			for i=1,speedValue do
				--if i > speedValue then break end
				surface.SetAlphaMultiplier(1.0)
				surface.SetDrawColor(150,255,50)
				surface.DrawRect((127.5+2.20*i)*10,70.5*10,(i==20) and 6 or 14,44)
			end
			------------------------------------------------------------------------
			local b = self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,60,60)
				surface.DrawRect(210.4*10-9,39*10-4,8*10,4*10-4)
				draw.DrawText("ЛСН","MetrostroiSubway_VerySmallText",210.3*10+0-9,39*10-5-4,Color(0,0,0,255))
			end
			b = self:Animate("light_rRP",self:GetPackedBool(35) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,60,60)
				surface.DrawRect(201.3*10-9,39*10-4,8.2*10,4*10-4)
				draw.DrawText("РП","MetrostroiSubway_VerySmallText", 201.3*10+15-9,39*10-5-4,Color(0,0,0,255))
			end

			b = self:Animate("light_KT",self:GetPackedBool(47) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,160,20)
				surface.DrawRect(210.4*10-10,56*10+2,8*10,4*10)
				draw.DrawText("ЛКТ","MetrostroiSubway_VerySmallText",210.4*10+0-10,56*10-5+2,Color(0,0,0,255))
			end
			b = self:Animate("light_KVD",self:GetPackedBool(48) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,160,20)
				surface.DrawRect(210*10-9,47.5*10+2,8*10,4*10)
				draw.DrawText("ЛКВД","MetrostroiSubway_VerySmallText2",210*10-4-9,48*10-5+2,Color(0,0,0,255))
			end

			b = self:Animate("light_LhRK",self:GetPackedBool(33) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,160,20)
				surface.DrawRect(184*10-4,47*10,8.2*10,4*10+3)
				draw.DrawText("2","MetrostroiSubway_VerySmallText",184*10+32-4,47*10-5,Color(0,0,0,255))
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
				surface.DrawRect(184.2*10-3,56.2*10,8*10,4*10+1)
				draw.DrawText("6","MetrostroiSubway_VerySmallText",184.2*10+32-3,56.2*10-5,Color(0,0,0,255))
			end

			b = self:Animate("light_LVD",self:GetPackedBool(50) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(150,255,50)
				surface.DrawRect(184.1*10-5,38*10,8*10,4*10+1)
				draw.DrawText("1","MetrostroiSubway_VerySmallText",184.1*10+32-5,38*10-5,Color(0,0,0,255))
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
				surface.DrawRect(184.0*10-8,28.9*10+4,16.3*10+4,4*10)
				draw.DrawText("ЛСД","MetrostroiSubway_VerySmallText",184.5*10+32-8,28.9*10-5+4,Color(0,0,0,255))
			end

			------------------------------------------------------------------------
			b = self:Animate("light_OCh",self:GetPackedBool(41) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,60,60)
				surface.DrawRect(98.6*10+17,27*10+7,8*10,8.8*10)
				surface.DrawPoly({
					{ x = 1390-18,	y = 838+0 },
					{ x = 1390+0,	y = 838-30 },
					{ x = 1390+18,	y = 838+0 },
				})
				draw.DrawText("НЧ","MetrostroiSubway_LargeText3",98.6*10-1+17,27*10+5+7,Color(0,0,0,255))
			end

			b = self:Animate("light_0",self:GetPackedBool(42) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,60,60)
				surface.DrawRect(88*10+17,(27+10*0)*10+7,8*10,8.8*10)
				surface.DrawPoly({
					{ x = 1390-18,	y = 838+0 },
					{ x = 1390+0,	y = 838-30 },
					{ x = 1390+18,	y = 838+0 },
				})
				draw.DrawText("0","MetrostroiSubway_LargeText2",88*10+20+17,(27+11.3*0)*10-5+7,Color(0,0,0,255))
			end

			b = self:Animate("light_40",self:GetPackedBool(43) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(255,170,20)
				surface.DrawRect(88*10+17,(27+11.3*1)*10+7,8*10,8.8*10)
				surface.DrawPoly({
					{ x = 1480-18,	y = 838+0 },
					{ x = 1480+0,	y = 838-30 },
					{ x = 1480+18,	y = 838+0 },
				})
				draw.DrawText("40","MetrostroiSubway_LargeText2",88*10-2+17,(27.5+11.3*1)*10-5+7,Color(0,0,0,255))
			end

			b = self:Animate("light_60",self:GetPackedBool(44) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(150,255,50)
				surface.DrawRect(88*10+17,(28+11*2)*10,8*10,8.8*10)
				surface.DrawPoly({
					{ x = 1566-18,	y = 838+0 },
					{ x = 1566+0,	y = 838-30 },
					{ x = 1566+18,	y = 838+0 },
				})
				draw.DrawText("60","MetrostroiSubway_LargeText2",88*10-2+17,(28+11.3*2)*10-5,Color(0,0,0,255))
			end

			b = self:Animate("light_70",self:GetPackedBool(45) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(150,255,50)
				surface.DrawRect(88*10+17,(28.4+11*3)*10,8*10,8.7*10)
				surface.DrawPoly({
					{ x = 1611-18,	y = 838+0 },
					{ x = 1611+0,	y = 838-30 },
					{ x = 1611+18,	y = 838+0 },
				})
				draw.DrawText("70","MetrostroiSubway_LargeText2",88*10-1+17,(29+11*3)*10-5,Color(0,0,0,255))
			end

			b = self:Animate("light_80",self:GetPackedBool(46) and 1 or 0,0,1,15,false)
			if b > 0.0 then
				surface.SetAlphaMultiplier(b)
				surface.SetDrawColor(150,255,50)
				surface.DrawRect(88*10+17,(28+11.3*4)*10-5,8*10,8.7*10)
				surface.DrawPoly({
					{ x = 1660-18,	y = 838+0 },
					{ x = 1660+0,	y = 838-30 },
					{ x = 1660+18,	y = 838+0 },
				})

				draw.DrawText("80","MetrostroiSubway_LargeText2",88*10-2+16,(28+11.5*4)*10-5-5,Color(0,0,0,255))
				surface.SetAlphaMultiplier(1.0)
			end
		end)
		self:DrawOnPanel("ARS",function()
			if self:GetNW2Int("ARSType",1) ~= 1 then return end

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

			b = self:Animate("light_rLSN",self:GetPackedBool(131) and 1 or 0,0,1,15,false)
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
	end
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
	self:DrawOnPanel("AnnouncerDisplay",function(...)if not self:GetPackedBool(32) then return end
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
		self.ASNP:AnnDisplay(self,false)
	end)

	self:DrawOnPanel("FrontPneumatic",function()
		draw.DrawText(self:GetNW2Bool("FbI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("FtI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("RearPneumatic",function()
		draw.DrawText(self:GetNW2Bool("RtI") and "Isolated" or "Open","Trebuchet24",150,30,Color(0,0,0,255))
		draw.DrawText(self:GetNW2Bool("RbI") and "Isolated" or "Open","Trebuchet24",650,30,Color(0,0,0,255))
	end)
	self:DrawOnPanel("AirDistributor",function()
		draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
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
