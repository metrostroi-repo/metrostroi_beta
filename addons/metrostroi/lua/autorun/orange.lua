local MapName = "orange"

hook.Add("Think","LoadMap_"..MapName,function()
	if not Metrostroi then return end
	Metrostroi.CurrentMap = ""
	local Map = game.GetMap() or ""

	if Map:find("gm_mus") and Map:find("metro") then
		Metrostroi.CurrentMap = "gm_orange"
	elseif Map:find("gm_mus") then
		Metrostroi.CurrentMap = "gm_orange_lite"
	else
		hook.Remove("Think","LoadMap_"..MapName)
		return
	end
	--[НОМЕР] = {НАЗВАНИЕ,ПРАВАЯ СТОРОНА,ВЕЖЛИВОСТЬ,ВЕЩИ,ПРИСЛНОЯТЬСЯ К ДВЕРЯМ,ИМЕЕТ В НАЗВАНИИ "СТАНЦИЯ",СТАНЦИЯ ПЕРЕХОДА,СТАНЦИЯ РАЗДЕЛЕНИЯ,НЕ КОНЕЧНАЯ(развернуть информатор)}
	Metrostroi.AnnouncerData =
	{
		[401] = {"Aeroport",               			true ,true,true,false  ,false,{699,0236,699}},
		[402] = {"Slavnaya Strana",           	false,false,false ,false,false,0   },
		[403] = {"Litievaya",          				false,true,true,false ,false,{699,0236,699}},
		[404] = {"Park",          						true ,false ,false ,true,false,0   },
		[405]= {"GFCScape",          				true ,false ,true,false,false,0,2},
		[406] = {"Im. Uollesa Brina",           	false,false,false,false ,true,0   },
		[407] = {"VHE'",   							false,false,true ,true,false,0   },
		[408] = {"Truzennikov Garry's mod'a",  false,true,false,true ,true,0   ,nil ,1},

		[501] = {"Aeroport",               			true ,true,true,false  ,false,{799,0235,799}},
		[502] = {"Pionerskaya",        			true ,false,false,true   ,false,0   },
		[503] = {"Litievaya",        					false,true,false,false   ,false,{799,0235,799}},
		[504] = {"Metrostroiteley",        					false,false,false,true   ,false,0},
		
		[601] = {"Brateyevo",        					false,false,false,true   ,false,0},
	}
	Metrostroi.PathConverter = {
		--[1] = 1,
		--[2] = 2,
		--[29] = 2,
		--[30] = 1,
	}
	Metrostroi.WorkingStations = {
		{401,402,403,404,405,406,407,408},
		{501,502,503,504},
		{601,405,406,407,408},
	}
	for k, v in pairs(Metrostroi.WorkingStations) do
		for k1, v1 in pairs(v) do
			Metrostroi.WorkingStations[k][v1] = k1
		end
	end

	Metrostroi.EndStations = {
		{401,404,406,408},
		{501,504},
		{601,406,408},
	}
	for k, v in pairs(Metrostroi.EndStations) do
		for k1, v1 in pairs(v) do
			Metrostroi.EndStations[k][v1] = k1
		end
	end

	hook.Remove("Think","LoadMap_"..MapName)
end)
--[[
Metrostroi.WorkingStations = {
	["gm_metrostroi"] = {
		{108,109,110,111,112,113,114,115,116,117,118,119,121,122,123},
		{108,109,110,111,112,113,114,115,116,117,118,119,121,122,321,322},
	},
	["gm_metrostroi_lite"] = {
		{108,109,110,111,112,113,114},
	},
	["gm_orange"] = {
		{401,402,403,404,405,406,407,408},
		{501,502,503,504},
		{601,405,406,407,408},
	},
	["gm_orange_lite"] = {
		{403,404,405,406,407,408},
	},
}
Metrostroi.EndStations = {
	["gm_metrostroi"] = {
		{108,111,114,121,123},
		{108,111,114,121,322},
	},
	["gm_metrostroi_lite"] = {
		{108,111,114},
	},
	["gm_orange"] = {
		{401,404,406,408},
		{501,504},
		{601,406,408},
	},
	["gm_orange_lite"] = {
		{403,406,408},
	},
}
]]