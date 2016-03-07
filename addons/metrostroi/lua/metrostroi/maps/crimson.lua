local Map = game.GetMap() or ""

if Map:find("gm_mus_crimson") and not Map:find("tox") then
	Metrostroi.PlatformMap = "crimson"
	Metrostroi.CurrentMap = "gm_orange_crimson"
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
	[501] = {"Aeroport",               			true ,true,0       ,false  ,false,{799,0235,799}},
	[502] = {"Pionerskaya",        				true ,false,false,true   ,false,0   },
	[503] = {"Litievaya",        					false,true,false,false   ,false,{799,0235,799}},
	[504] = {"Metrostroiteley",        			false,false,false,true   ,false,0},
}
Metrostroi.WorkingStations = {
	{501,502,503,504},
}

Metrostroi.EndStations = {
	{501,504},
}