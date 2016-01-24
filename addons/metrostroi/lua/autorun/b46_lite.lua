local MapName = "b46"

hook.Add("Think","LoadMap_"..MapName,function()
	if not Metrostroi then return end
	local Map = game.GetMap() or ""

	if Map:find("gm_metrostroi") and Map:find("lite") then
		Metrostroi.PlatformMap = "metrostroi"
		Metrostroi.CurrentMap = "gm_metrostroi_lite"
	else
		hook.Remove("Think","LoadMap_"..MapName)
		return
	end

	--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
	Metrostroi.AnnouncerData =
	{
		[108] = {"Avtozavodskaya",          		false,false,false ,false ,false,0   },
		[109] = {"Industrial'naya",         			false,false ,false,true  ,false,0   },
		[110] = {"Moskovskaya",             		true ,true,false   ,false,false,0   },
		[111] = {"Oktyabrs'kaya",           		false,false,1       ,false,false,0   },
		[112] = {"Ploschad' Myra",          		false,false,false ,true ,false,0   },
		[113] = {"Novoarmeyskaya",          	false,true ,0       ,false,false,0   },
		[114] = {"Vokzalnaya",						false,false,1       ,false,false,0   },
	}
	Metrostroi.PathConverter = {
		--[1] = 1,
		--[2] = 2,
		--[29] = 2,
		--[30] = 1,
	}
	Metrostroi.WorkingStations = {
		{108,109,110,111,112,113,114},
	}
	for k, v in pairs(Metrostroi.WorkingStations) do
		for k1, v1 in pairs(v) do
			Metrostroi.WorkingStations[k][v1] = k1
		end
	end

	Metrostroi.EndStations = {
		{108,111,114},
	}
	for k, v in pairs(Metrostroi.EndStations) do
		for k1, v1 in pairs(v) do
			Metrostroi.EndStations[k][v1] = k1
		end
	end

	hook.Remove("Think","LoadMap_"..MapName)
end)