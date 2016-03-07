local Map = game.GetMap() or ""

if Map:find("gm_mus_crimson") then
	return
elseif Map:find("gm_mus") and Map:find("metro") then
	Metrostroi.PlatformMap = "orange"
	Metrostroi.CurrentMap = "gm_orange"
elseif Map:find("gm_mus") then
	Metrostroi.PlatformMap = "orange"
	Metrostroi.CurrentMap = "gm_orange_lite"
else
	return
end
Metrostroi.Skins["717_schemes"]["p"] = {
	adv = "metrostroi_skins/81-717_schemes/int_orange_spb_adv",
	clean = "metrostroi_skins/81-717_schemes/int_orange_spb_clean",
}
Metrostroi.Skins["717_schemes"]["m"] = {
	adv = "metrostroi_skins/81-717_schemes/int_orange_msk_adv",
	clean = "metrostroi_skins/81-717_schemes/int_orange_msk_noadv",
}
--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
Metrostroi.AnnouncerData =
{
	[401] = {"Aeroport",               			true ,true  ,0       ,false  ,false,{699,0236,699}},
	[402] = {"Slavnaya Strana",           	false,false,false ,false,false,0   },
	[403] = {"Litievaya",          					false,false,1       ,false ,false,{699,0236,699}},
	[404] = {"Park",          						true ,true ,false ,true,false,0   },
	[405]= {"GCFScape",          				true ,false,0      ,false,false,0,2},
	[406] = {"Im. Uollesa Brina",           	false,false,false,false ,true,0   },
	[407] = {"VHE'",   								false,true ,1       ,true,false,0   },
	[408] = {"Truzennikov Garry's mod'a",false,false,false,true ,true,0   ,nil ,1},

	[501] = {"Aeroport",               			true ,true,0       ,false  ,false,{799,0235,799}},
	[502] = {"Pionerskaya",        				true ,false,false,true   ,false,0   },
	[503] = {"Litievaya",        					false,true,false,false   ,false,{799,0235,799}},
	[504] = {"Metrostroiteley",        			false,false,false,true   ,false,0},
	
	[601] = {"Brateyevo",        					false,false,false,true   ,false,0},
}
Metrostroi.WorkingStations = {
	{401,402,403,404,405,406,407,408},
	{501,502,503,504},
	{601,405,406,407,408},
}

Metrostroi.EndStations = {
	{401,404,406,408},
	{501,504},
	{601,406,408},
}