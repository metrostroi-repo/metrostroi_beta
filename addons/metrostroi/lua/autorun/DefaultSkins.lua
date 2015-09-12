local function LoadSkin()
	if not Metrostroi then timer.Simple(1,LoadSkin) end
	Metrostroi.Skins = {}
	if not Metrostroi.Skins["ezh3"] then Metrostroi.Skins["ezh3"] = {} end
	print("Metrostroi:Loading ezh3 skins...")
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Green-Blue",
		path = "metrostroi_skins/ezh3/1",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light sky blue-Blue",
		path = "metrostroi_skins/ezh3/2",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light blue-Dark blue",
		path = "metrostroi_skins/ezh3/3",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light blue-Blue1",
		path = "metrostroi_skins/ezh3/4",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light blue-Blue2",
		path = "metrostroi_skins/ezh3/5",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light blue-Blue3",
		path = "metrostroi_skins/ezh3/6",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Light blue-Blue4",
		path = "metrostroi_skins/ezh3/7",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "St. Petersburg",
		path = "metrostroi_skins/ezh3/8",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Parad",
		path = "metrostroi_skins/ezh3/9",
	})
	table.insert(Metrostroi.Skins["ezh3"],{
		name = "Random",
		path = "RND",
	})
	

	if not Metrostroi.Skins["717"] then Metrostroi.Skins["717"] = {} end
	print("Metrostroi:Loading 81-717 skins...")
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow1",
		path = "metrostroi_skins/81-717/1",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow2",
		path = "metrostroi_skins/81-717/2",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow3",
		path = "metrostroi_skins/81-717/3",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Old",
		path = "metrostroi_skins/81-717/4",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "DarkBlue",
		path = "metrostroi_skins/81-717/5",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "LightBlue",
		path = "metrostroi_skins/81-717/6",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Kiyv1",
		path = "metrostroi_skins/81-717/7",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow4",
		path = "metrostroi_skins/81-717/8",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St.Petersburg1",
		path = "metrostroi_skins/81-717/9",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St.Petersburg2",
		path = "metrostroi_skins/81-717/10",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St.Petersburg3",
		path = "metrostroi_skins/81-717/11",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Red Arrow",
		path = "metrostroi_skins/81-717/12",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Kiyv2",
		path = "metrostroi_skins/81-717/14",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Minsk",
		path = "metrostroi_skins/81-717/13",
	})
	--[[
	print("Metrostroi:Loading 81-717 skins...")	
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow1",
		path = "metrostroi_skins/81-717/1",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow2",
		path = "metrostroi_skins/81-717/2",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St. Petersburg1",
		path = "metrostroi_skins/81-717/3",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St. Petersburg2",
		path = "metrostroi_skins/81-717/4",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "St. Petersburg3",
		path = "metrostroi_skins/81-717/5",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "TKL Brended",
		path = "metrostroi_skins/81-717/6",
		special = {
			LED = true,
			Mask = 1,
			Cran = 2,
		}
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Samara",
		path = "metrostroi_skins/81-717/7",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Synergy",
		path = "metrostroi_skins/81-717/8",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Kiyv",
		path = "metrostroi_skins/81-717/9",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "N.Novgorod1",
		path = "metrostroi_skins/81-717/10",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "N.Novgorod2",
		path = "metrostroi_skins/81-717/11",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "N.Novgorod3",
		path = "metrostroi_skins/81-717/12",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Moscow3",
		path = "metrostroi_skins/81-717/13",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "RedArrow",
		path = "metrostroi_skins/81-717/14",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Prague",
		path = "metrostroi_skins/81-717/15",
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Хуёвый поезд",
		path = "metrostroi_skins/81-717/16",
		adminonly = true,
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Граффити",
		path = "metrostroi_skins/81-717/17",
		adminonly = true,
	})
	table.insert(Metrostroi.Skins["717"],{
		name = "Retro",
		path = "metrostroi_skins/81-717/18",
	})	
	]]

	print("Metrostroi:Loading 717 pass skins...")	
	if not Metrostroi.Skins["717_pass"] then Metrostroi.Skins["717_pass"] = {} end
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "Blue",
		path = "metrostroi_skins/81-717_pass/1",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "White-Blue",
		path = "metrostroi_skins/81-717_pass/2",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "White",
		path = "metrostroi_skins/81-717_pass/3",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "Light wood",
		path = "metrostroi_skins/81-717_pass/4",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "Dark wood",
		path = "metrostroi_skins/81-717_pass/5",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "(St.Petersburg) Green",
		path = "metrostroi_skins/81-717_pass/6",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "(St.Petersburg) Blue",
		path = "metrostroi_skins/81-717_pass/7",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "(St.Petersburg) Red1",
		path = "metrostroi_skins/81-717_pass/8",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "(St.Petersburg) Red2",
		path = "metrostroi_skins/81-717_pass/9",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "Red Arrow",
		path = "metrostroi_skins/81-717_pass/10",
	})
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "SL-Wood",
		path = "metrostroi_skins/81-717_pass/11",
	})
	Metrostroi.Skins["717_pass2"] = {}
	for i = 1,#Metrostroi.Skins["717_pass"] do
		Metrostroi.Skins["717_pass2"][Metrostroi.Skins["717_pass"][i].path] = Metrostroi.Skins["717_pass"][i].name
	end
	table.insert(Metrostroi.Skins["717_pass"],{
		name = "Random",
		path = "RND",
	})
	print("Metrostroi:Loading 717 advert skins...")	
	if not Metrostroi.Skins["717_schemes"] then Metrostroi.Skins["717_schemes"] = {} end
	Metrostroi.Skins["717_schemes"]["p_metrostroi"] = {
		path1 = "metrostroi_skins/81-717_schemes/int_b50_spb_adv",
		path2 = "metrostroi_skins/81-717_schemes/int_b50_spb_clean",
	}
	Metrostroi.Skins["717_schemes"]["p_orange"] = {
		path1 = "metrostroi_skins/81-717_schemes/int_orange_spb_adv",
		path2 = "metrostroi_skins/81-717_schemes/int_orange_spb_clean",
	}
	Metrostroi.Skins["717_schemes"]["m_metrostroi"] = {
		path1 = "metrostroi_skins/81-717_schemes/int_b50_msk_adv",
		path2 = "metrostroi_skins/81-717_schemes/int_b50_msk_noadv",
	}
	Metrostroi.Skins["717_schemes"]["m_orange"] = {
		path1 = "metrostroi_skins/81-717_schemes/int_orange_msk_adv",
		path2 = "metrostroi_skins/81-717_schemes/int_orange_msk_noadv",
	}
	Metrostroi.Skins["717_schemes"]["p_metrostroi_lite"] = Metrostroi.Skins["717_schemes"]["p_metrostroi"]
	Metrostroi.Skins["717_schemes"]["p_orange_lite"] = Metrostroi.Skins["717_schemes"]["p_orange"]
	Metrostroi.Skins["717_schemes"]["m_metrostroi_lite"] = Metrostroi.Skins["717_schemes"]["m_metrostroi"]
	Metrostroi.Skins["717_schemes"]["m_orange_lite"] = Metrostroi.Skins["717_schemes"]["m_orange"]
	Metrostroi.Skins["717_schemes"][""] = {
		path = "metrostroi_skins/81-717_schemes/int_blank",
	}
end
timer.Simple(1,LoadSkin)