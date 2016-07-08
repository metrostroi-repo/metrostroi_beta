local Map = game.GetMap() or ""

if Map:find("gm_mus_loop") then
	Metrostroi.PlatformMap = "loop"
	Metrostroi.CurrentMap = "gm_loop"
else
	return
end
Metrostroi.Skins["717_schemes"]["p"] = {
	adv = "metrostroi_skins/81-717_schemes/int_loop_spb_adv",
	clean = "metrostroi_skins/81-717_schemes/int_loop_spb_clean",
}
Metrostroi.Skins["717_schemes"]["m"] = {
	adv = "metrostroi_skins/81-717_schemes/int_loop_msk_adv",
	clean = "metrostroi_skins/81-717_schemes/int_loop_msk_clean",
}
--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
Metrostroi.AnnouncerData =
{
	[651] = {"First april",     false,true  ,0   ,false,false,0},
	[652] = {"Park",           	false,false,false,true ,false,{799,235,799}},
	[653] = {"Metrostroiteley",	false,false,1    ,false,false,{699,236,699}},
	[654] = {"Marine",          false,true ,false,true ,false,0   },
  [654] = {},
	[655] = {"Glorious country",false,false,0    ,false,false,{799,235,799}},
	[656] = {"Pionerskaya",     false,false,false,false,false,{699,236,699}},
  loop = true,
}
Metrostroi.AnnouncerTranslate =
{
	[651] = "Первоапрельская",
	[652] = "Парк",
	[653] = "Метростроителей",
	--[654] = "Морская",
	[655] = "Славная страна",
	[656] = "Пионерская",
}
--[=[ НЕ ТРОГАТЬ, информатор не готов!
Metrostroi.WorkingStations = {
	{651,652,653--[[,654]],655,656},
	{656,655--[[,654]],653,652,651},
}

Metrostroi.EndStations = {
	--{652,654,656},
  {652,653,656},
  {656,655,652,651},
}

	if Metrostroi.WorkingStations then
		for k, v in pairs(Metrostroi.WorkingStations) do
			for k1, v1 in pairs(v) do
				Metrostroi.WorkingStations[k][v1] = k1
			end
		end
	end

	if Metrostroi.EndStations then
		for k, v in pairs(Metrostroi.EndStations) do
			for k1, v1 in pairs(v) do
				Metrostroi.EndStations[k][v1] = k1
			end
		end
	end
	]=]
