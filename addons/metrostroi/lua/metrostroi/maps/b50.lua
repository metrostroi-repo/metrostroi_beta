local Map = game.GetMap() or ""

if Map:find("gm_metrostroi") and not Map:find("lite") then
	Metrostroi.PlatformMap = "metrostroi"
	Metrostroi.CurrentMap = "gm_metrostroi"
else
	return
end
Metrostroi.Skins["717_schemes"]["p"] = {
	adv = "metrostroi_skins/81-717_schemes/int_b50_spb_adv",
	clean = "metrostroi_skins/81-717_schemes/int_b50_spb_clean",
}
Metrostroi.Skins["717_schemes"]["m"] = {
	adv = "metrostroi_skins/81-717_schemes/int_b50_msk_adv",
	clean = "metrostroi_skins/81-717_schemes/int_b50_msk_noadv",
}
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
	[115] = {"Komsomol'skaya",        		true ,false ,false,true ,false,{1215,0234,1215}},
	[116] = {"Elektrosila",             			false,true,false  ,false,false,0   },
	[117] = {"Teatral'naya Ploshad'",		false,false,0       ,false,false,0   },
	[118] = {"Park Pobedy",             		true ,false,false ,true ,false,0   },
	[119] = {"Sineozernaya",            		false,true ,false ,false,false,0   },
	[120] = { },
	[121] = {"Minskaya",                			false,false,1       ,false,false,0   },
	[122] = {"Tsarskiye Vorota",        		false,true ,0       ,true ,false,0   ,1},
	[123] = {"Mezhdustroyskaya",        	true ,false,1       ,false,false,0   },
	[321] = {"Muzey Skulptur",		    		false,false,1       ,true ,false,0   },
	[322] = {"Avtostanciya Yuzhnaya",		false,true ,0       ,false,false,0   },
	[1215] = {"Leninskaya" },
}

Metrostroi.WorkingStations = {
	{108,109,110,111,112,113,114,115,116,117,118,119,121,122,123},
	{108,109,110,111,112,113,114,115,116,117,118,119,121,122,321,322},
}
for k, v in pairs(Metrostroi.WorkingStations) do
	for k1, v1 in pairs(v) do
		Metrostroi.WorkingStations[k][v1] = k1
	end
end

Metrostroi.EndStations = {
	{108,111,114,121,123},
	{108,111,114,121,322},
}
for k, v in pairs(Metrostroi.EndStations) do
	for k1, v1 in pairs(v) do
		Metrostroi.EndStations[k][v1] = k1
	end
end