--------------------------------------------------------------------------------
-- Add skins function
-- 	category - a skin category(pass, cab, train)
-- 	name - name of skin(must be unique) or skin table(table must have a name)
-- 	tbl - skin table
-- Skin table:
-- {
--		typ = "81-717_lvz", (it's a gmod_subway_*(gmod_subway_81-717_lvz))
--		name = "NAME",(or you can send name to function)
-- 	textures = {
--			texture_name = "path_to_texture",
--			b01a = "myskin/mycoolskin",
-- 	}
-- }
-- List of trains and manufacturers:
-- 81-717_mvm
-- 81-717_lvz
-- Ezh3
-- Em
-- E
--------------------------------------------------------------------------------
Metrostroi.AddSkin("train","EmOld",{
	name = "Old",
	typ = "em",
	textures = {
	}
})
Metrostroi.AddSkin("train","EmNew",{
	name = "New",
	typ = "em",
	textures = {
		em_body = "metrostroi_skins/em/em_piter",
		ema_doors = "metrostroi_skins/em/em_piter_doors",
		ema_doorsvar = "metrostroi_skins/em/em_piter_doorsvar",
	}
})
Metrostroi.AddSkin("train","Green-Blue",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/1",
	}
})
Metrostroi.AddSkin("train","Light sky blue-Blue",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/2",
	}
})
Metrostroi.AddSkin("train","Light blue-Dark blue",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/3",
	}
})
Metrostroi.AddSkin("train","Light blue-Blue1",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/4",
	}
})
Metrostroi.AddSkin("train","Light blue-Blue2",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/5",
	}
})
Metrostroi.AddSkin("train","Light blue-Blue3",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/6",
	}
})
Metrostroi.AddSkin("train","Light blue-Blue4",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/7",
	}
})
Metrostroi.AddSkin("train","St. Petersburg",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/8",
	}
})
Metrostroi.AddSkin("train","Parad",{
	typ = "ezh3",
	textures = {
		ewagon_003 = "metrostroi_skins/ezh3/9",
	}
})
--[[RANDOM
Metrostroi.AddSkin("train","ezh3",{
	typ = "ezh3",
	name = "Random",
	textures = {
		ewagon_003 = "RND",
	}
})
]]

Metrostroi.AddSkin("train","Moscow1",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/1",
	}
})
Metrostroi.AddSkin("train","Moscow2",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/2",
	}
})
Metrostroi.AddSkin("train","Moscow3",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/3",
	}
})
Metrostroi.AddSkin("train","Old",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/4",
	}
})
Metrostroi.AddSkin("train","DarkBlue",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/5",
	}
})
Metrostroi.AddSkin("train","LightBlue",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/6",
	}
})
Metrostroi.AddSkin("train","Kiyv1",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/7",
	}
})
Metrostroi.AddSkin("train","Moscow4",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/8",
	}
})	
Metrostroi.AddSkin("train","Red Arrow",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/12",
	}
})
Metrostroi.AddSkin("train","Kiyv2",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/14",
	}
})
Metrostroi.AddSkin("train","Minsk",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/13",
	}
})
Metrostroi.AddSkin("train","Very old1",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/15",
	}
})
Metrostroi.AddSkin("train","Very old2",{
	typ = "81-717_mvm",
	textures = {
		b01a = "metrostroi_skins/81-717/16",
	}
})

Metrostroi.AddSkin("train","St.Petersburg1",{
	typ = "81-717_lvz",
	textures = {
		b01a = "metrostroi_skins/81-717/9",
	}
})
Metrostroi.AddSkin("train","St.Petersburg",{
	typ = "81-717_lvz",
	textures = {
		b01a = "metrostroi_skins/81-717/10",
	}
})
Metrostroi.AddSkin("train","St.Petersburg3",{
	typ = "81-717_lvz",
	textures = {
		b01a = "metrostroi_skins/81-717/11",
	}
})

Metrostroi.AddSkin("pass","Blue",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/1",
	}
})
Metrostroi.AddSkin("pass","White-Blue",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/2",
	}
})
Metrostroi.AddSkin("pass","White",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/3",
	}
})
Metrostroi.AddSkin("pass","Light wood",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/4",
	}
})
Metrostroi.AddSkin("pass","Dark wood",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/5",
	}
})
Metrostroi.AddSkin("pass","Red Arrow",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/10",
	}
})
Metrostroi.AddSkin("pass","SL-Wood",{
	typ = "81-717_mvm",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/11",
	}
})


Metrostroi.AddSkin("pass","SGreen",{
	name = "Green",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/6",
	}
})
Metrostroi.AddSkin("pass","SBlue",{
	name = "Blue",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/7",
	}
})
Metrostroi.AddSkin("pass","SRed1",{
	name = "Red1",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/8",
	}
})
Metrostroi.AddSkin("pass","SRed2",{
	name = "Red2",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/9",
	}
})
Metrostroi.AddSkin("pass","SBlue2",{
	name = "Blue2",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/12",
	}
})
Metrostroi.AddSkin("pass","SWhite",{
	name = "White",
	typ = "81-717_lvz",
	textures = {
		int01 = "metrostroi_skins/81-717_pass/13",
	}
})



-- A St.Petersburg skins have a some additional in textures for each autodrive system
Metrostroi.AddSkin("cab","SYellow",{
	name = "Yellow",
	typ = "81-717_lvz",
	textures = {
		puav = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_yellow",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_yellow",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_yellow_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		pam = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_yellow",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_yellow",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_yellow_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		paksd = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_yellow",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_yellow",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_yellow_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
		paksdm = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_yellow",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_yellow",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_yellow_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
	},
})
Metrostroi.AddSkin("cab","SBlue",{
	name = "Blue",
	typ = "81-717_lvz",
	textures = {
		puav = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_blue",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_blue",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_blue_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		pam = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_blue",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_blue",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_blue_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		paksd = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_blue",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_blue",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_blue_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
		paksdm = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_blue",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_blue",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_blue_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
	},
})
Metrostroi.AddSkin("cab","SGray",{
	name = "Gray",
	typ = "81-717_lvz",
	textures = {
		puav = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_gray",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_gray",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_gray_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		pam = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_gray",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_gray",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_gray_ars",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_ars",
		},
		paksd = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_gray",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_gray",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_gray_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
		paksdm = {
			cabin717_016 = "metrostroi_skins/81-540_cab/cabin717_016_gray",
			cabin717_020 = "metrostroi_skins/81-540_cab/cabin717_020_gray",
			cabin717_023 = "metrostroi_skins/81-540_cab/cabin717_023_gray_vpa",
			cabin717_026 = "metrostroi_skins/81-540_cab/cabin717_026_vpa",
		},
	},
})