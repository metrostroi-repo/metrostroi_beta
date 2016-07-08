local CATEGORY_NAME = "Metrostroi"

------------------------------ Wagons ------------------------------
local waittime = 10
local lasttimeusage = -waittime
function ulx.wagons( calling_ply )
	if lasttimeusage + waittime > CurTime() then
		ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
		return
	end

	lasttimeusage = CurTime()

	ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
	if CPPI then
		local N = {}
		for k,v in pairs(Metrostroi.TrainClasses) do
			if  v == "gmod_subway_base" then continue end
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do
				N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] = (N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] or 0) + 1
			end
		end
		for k,v in pairs(N) do
			ulx.fancyLog("#s wagons have #s",v,(type(k) == "Player" and IsValid(k)) and k:GetName() or k)
		end
	end
	ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local wagons = ulx.command( CATEGORY_NAME, "ulx trains", ulx.wagons, "!trains" )
wagons:defaultAccess( ULib.ACCESS_ALL )
wagons:help( "Shows you the current wagons." )

function ulx.routes( calling_ply )
	--if lasttimeusage + waittime > CurTime() then
		--ULib.tsayError( calling_ply, "Please wait " .. math.Round(lasttimeusage + waittime - CurTime()) .. " seconds before using this command again", true )
		--return
	--end

	--lasttimeusage = CurTime()

	--ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
	if CPPI then
		--local N = {}
		for k,v in pairs(Metrostroi.TrainClasses) do
			if  v == "gmod_subway_base" then continue end
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do
				--N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] = (N[v2:CPPIGetOwner() or v2:GetNetworkedEntity("Owner", "N/A") or "(disconnected)"] or 0) + 1
				if v2.GetDriverName and v2.RouteNumber then ulx.fancyLog("#s have a route:#d",v2:GetDriverName(),v2.RouteNumber) else ulx.fancyLog("#s don't have a route",v2:GetDriverName()) end
			end
		end
	end
	--ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local routes = ulx.command( CATEGORY_NAME, "ulx routes", ulx.routes, "!routes" )
routes:defaultAccess( ULib.ACCESS_ALL )
routes:help( "Shows you the current routes." )
--[[
------------------------------ Checkwags ------------------------------
function ulx.checkwags( calling_ply )
	ulx.fancyLog("Wagons on server: #s", Metrostroi.TrainCount())
	if CPPI then
		local N = {}
		for k,v in pairs(Metrostroi.TrainClasses) do
			if  v == "gmod_subway_81-717" or v == "gmod_subway_ezh3" then
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do

			end
		end
		for k,v in pairs(N) do
			ulx.fancyLog("#s wagons have #s",v,(type(k) == "Player" and IsValid(k)) and k:GetName() or k)
		end
	end
	ulx.fancyLog("Max trains: #s.\nMax wagons: #s.\nMax trains per player: #s", GetConVarNumber("metrostroi_maxtrains"), GetConVarNumber("metrostroi_maxwagons"), GetConVarNumber("metrostroi_maxtrains_onplayer"))
end
local wagons = ulx.command( CATEGORY_NAME, "ulx trains", ulx.wagons, "!trains" )
wagons:defaultAccess( ULib.ACCESS_ALL )
wagons:help( "Shows you the current wagons." )
]]
------------------------------ Trainfuck ------------------------------
local Models = {
	"models/metrostroi/81/81-7036.mdl",
	"models/metrostroi/81/81-7037.mdl",
	"models/metrostroi/81/81-714.mdl",
	"models/metrostroi/81/81-717a.mdl",
	"models/metrostroi/81/81-717b.mdl",
	"models/metrostroi/81/ema508t.mdl",
	"models/metrostroi/e/em508.mdl",
	"models/metrostroi/tatra_t3/tatra_t3.mdl",
	"models/props_trainstation/train001.mdl",
	"models/props_combine/CombineTrain01a.mdl",
	"models/props_combine/combine_train02a.mdl",
}
local function SpawnTrain( Pos, Direction )
        local train = ents.Create( "prop_physics" )
        local random = math.random(1,#Models)
        train:SetModel(Models[random])
        train:SetAngles( Direction:Angle() + Angle(0,string.find(Models[random],"metrostroi") and 0 or 270,0) )
        train:SetPos( Pos )
        if math.random() > 0.6 then train:SetColor( Color(math.random(0,255),math.random(0,255),math.random(0,255)) ) end
        train:SetSkin(math.random(0,2))
        train:Spawn()
        train:Activate()
        train:EmitSound( "ambient/alarms/train_horn2.wav", 100, 100 )
        train:GetPhysicsObject():SetVelocity( Direction * math.random(1e7,1e9) )

        --timer.Create( "TrainRemove_"..CurTime(), 5, 1, function( train ) train:Remove() end, train )
        timer.Simple( 5, function() train:Remove() end )
end

function ulx.trainfuck(calling_ply, target_plys)
	local affected_plys = {}

	local gm = GetConVarNumber("sbox_godmode")
	if gm > 0 then RunConsoleCommand("sbox_godmode",0) end
	for i=1, #target_plys do
		local v = target_plys[ i ]

		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		elseif not v:Alive() then
			ULib.tsayError( calling_ply, v:Nick() .. " is already dead!", true )
		elseif v:IsFrozen() then
			ULib.tsayError( calling_ply, v:Nick() .. " is frozen!", true )
		else
			v:SetMoveType( MOVETYPE_WALK )
			v:GodDisable()
			SpawnTrain( v:GetPos() + v:GetForward() * 1000 + Vector(0,0,120), v:GetForward() * -1 )
			table.insert( affected_plys, v )
		end
	end
	timer.Simple(1,function()
		RunConsoleCommand("sbox_godmode",gm)
	end)

	ulx.fancyLogAdmin( calling_ply, "#A trainfucked #T", affected_plys )
end
local traunfuck = ulx.command( "Fun", "ulx trainfuck", ulx.trainfuck, "!trainfuck", true )
traunfuck:addParam{ type=ULib.cmds.PlayersArg }
traunfuck:defaultAccess( ULib.ACCESS_ADMIN )
traunfuck:help( "Trainfucks a player." )


local StationNames = {}
local StationNumbers = {}
StationNames["gm_metrostroi_lite"] = {
        ["avtozavodskaya"] = Vector(4820.791992, 5585.694336, -1603.769043),
        ["industrial'naya"] = Vector(-15276.645508, 6032.157715, 640),
        ["moskovskaya"] = Vector(7205.387695, 7826.301758, 235.031235),
        ["oktyabrs'kaya"] = Vector(14950.475586, 929.608032, -345.968750),
        ["ploschad' myra"] = Vector(8964.811523, -1026.779419, -2196.968750),
        ["novoarmeyskaya"] = Vector(519.362549, -1849.162720, -2708.968750),
        ["vokzalnaya"] = Vector(-10384.938477, -769.048767, -2708.968750),
        ["pto"] = Vector(-3049.407959, -5360.429688, -11565.102539)
}
StationNumbers["gm_metrostroi_lite"] = {
		["108"] = "avtozavodskaya",
		["109"] = "industrial'naya",
		["110"] = "moskovskaya",
		["111"] = "oktyabrs'kaya",
		["112"] = "ploschad' myra",
		["113"] = "novoarmeyskaya",
		["114"] = "vokzalnaya",
}

StationNames["gm_metrostroi"] = {
        ["avtozavodskaya"] = Vector(4820.791992, 5585.694336, -1603.769043),
        ["industrial'naya"] = Vector(-15276.645508, 6032.157715, 640),
        ["moskovskaya"] = Vector(7205.387695, 7826.301758, 235.031235),
        ["oktyabrs'kaya"] = Vector(14950.475586, 929.608032, -345.968750),
        ["ploschad' myra"] = Vector(8964.811523, -1026.779419, -2196.968750),
        ["novoarmeyskaya"] = Vector(519.362549, -1849.162720, -2708.968750),
        ["vokzalnaya"] = Vector(-10384.938477, -769.048767, -2708.968750),
        ["komsomol'skaya"] = Vector(-10550.576172, -2059.577148, -3732.968750),
        ["elektrosila"] = Vector(7315.029785, -1850.208008, -4244.968750),
        ["teatral'naya ploshad"] = Vector(-372.223755, -15192.013672, -4757.968750),
        ["park pobedy"] = Vector(-898.368103, -2030.919312, -7456.968750),
        ["sineozernaya"] = Vector(-3195.315430, 9382.029297, -8467.968750),
        ["lesnaya"] = Vector(-9699.606445, -10039.349609, -9990.968750),
        ["minskaya"] = Vector(-7236.259277, 632.344849, -10355),
        ["tsarskiye vorota"] = Vector(-1507.229248, 14172.663086, -14281.968750),
        ["mezhdustroyskaya"] = Vector(15273.905273, 1011.733582, -16056.282227),
        ["muzey skulptur"] = Vector(1514.049316, -10277.442383, -14801.968750),
        ["avtostanciya yuzhnaya"] = Vector(7203.874512, -3788.718506, -13259.068359),
        ["depot"] = Vector(-3049.407959, -5360.429688, -11565.102539),
				["sokol"] = Vector(671,3219,-12741),
				["ohotniy ryad"] = Vector(15487,4007,-12741),
				["kirovskaya"] = Vector(-2588,5431,-11109),
				["profsoyuznaya"] = Vector(-3219,6296 -8975),
				["leninskaya"] = Vector(-9390,2248,-5318),
}
StationNumbers["gm_metrostroi"] = {
		["108"] = "avtozavodskaya",
		["109"] = "industrial'naya",
		["110"] = "moskovskaya",
		["111"] = "oktyabrs'kaya",
		["112"] = "ploschad' myra",
		["113"] = "novoarmeyskaya",
		["114"] = "vokzalnaya",
		["115"] = "komsomol'skaya",
		["116"] = "elektrosila",
		["117"] = "teatral'naya ploshad",
		["118"] = "park pobedy",
		["119"] = "sineozernaya",
		["120"] = "lesnaya",
		["121"] = "minskaya",
		["122"] = "tsarskiye vorota",
		["123"] = "mezhdustroyskaya",
		["321"] = "muzey skulptur",
		["322"] = "avtostanciya yuzhnaya",
}

StationNames["gm_mus_orange_line"] = {
        ["garry's mod workers"] = Vector(3966.741943, -11455.978516, -1909.968750),
        ["vhe"] = Vector(10667, -48, -1399),
        ["wallace breen"] = Vector(13499.752930, -953.988647, -509.968750),
        ["gcfscape"] = Vector(-14204.804688, -4290.349609, -327.968750),
        ["workshop"] = Vector(3043.999023, -13884.423828, 0.031250),
        ["park"] = Vector(-4590.005371, 3595.914063, 450.031250),
        ["lithium"] = Vector(-14376.360352, -3967.319336, 610.031250),
        ["glorious country"] = Vector( 13122.869141, 1406.863159, 1026.031250),
        ["sent factory station"] = Vector(12402.533203, -1158.344604, 2196.031250),
        ["airport"] = Vector(-9926.367188, -1108.362793, 2194.031250),
        ["depot"] = Vector(-1638.838257, 12994.800781, -1465.968750),
        ["console"] = Vector(-4980, -6841, 2085)--Пульт диспетчера
}
StationNumbers["gm_mus_orange_line"] = {
		["110"] = "garry's mod workers",
		["111"] = "vhe",
		["112"] = "wallace breen",
		["113"] = "gcfscape",
		["114"] = "workshop",
		["115"] = "park",
		["116"] = "lithium",
		["117"] = "glorious country",
		["200"] = "lithium",
		["201"] = "sent factory station",
		["202"] = "airport",
}

StationNames["gm_mus_orange_line_short"] = {
        ["garry's mod workers"] = Vector(3966.741943, -11455.978516, -1909.968750),
        ["vhe"] = Vector(10667, -48, -1399),
        ["wallace breen"] = Vector(13499.752930, -953.988647, -509.968750),
        ["gcfscape"] = Vector(-14204.804688, -4290.349609, -327.968750),
        ["workshop"] = Vector(3043.999023, -13884.423828, 0.031250),
        ["park"] = Vector(-4590.005371, 3595.914063, 450.031250),
        ["console"] = Vector(5871.823730, 13372.527344, -1471.968750)--Пульт диспетчера
}
StationNumbers["gm_mus_orange_line"] = {
		["110"] = "garry's mod workers",
		["111"] = "vhe",
		["112"] = "wallace breen",
		["113"] = "gcfscape",
		["114"] = "workshop",
		["115"] = "park",
}
StationNames["gm_mus_orange"] = {
	 ["airport"] = Vector(-10812,1140,2290),
	 ["wallace breen"] = Vector(13511,-945.446716,-509),
	 ["glorious country"] = Vector(13128,1518,1026),
	 ["lithium"] = Vector(-14376,-3979,610),
	 ["depot"] = Vector(-5377,11990,-1466),
	 ["pto"] = Vector(197,-11813,2185),
	 ["disp"] = Vector(360,12839,-1200),
	 ["gcfscape"] = Vector(-14547,-4216,-511),
	 ["garry's mod workers"] = Vector(-14345,-8462,-2147),
	 ["vhe"] = Vector(10549,-264,-1399),
	 ["brateevo"] = Vector(11900,-14527,-2980),
	 ["park"] = Vector(-3372,4093,514),
	 ["pionerskaya"] = Vector(11466,-1168,2196.031250),
	 ["metro builders"] = Vector(110,2633,983),
}
StationNumbers["gm_mus_orange"] = {
	 --Оранжевая
	 ["401"] = "airport",
	 ["402"] = "glorious country",
	 ["403"] = "lithium",
	 ["404"] = "park",
	 ["405"] = "gcfscape",
	 ["406"] = "wallace breen",
	 ["407"] = "vhe",
	 ["408"] = "garry's mod workers",
	 --Малина
	 ["501"] = "airport",
	 ["502"] = "pionerskaya",
	 ["503"] = "lithium",
	 ["504"] = "metro builders",
	 --Оранжевая малина:d
	 ["601"] = "brateevo",
}
StationNames["gm_loop"] = {
["pto"] = Vector(-4539,5624,-4597),
["depot"] = Vector(-9315,-8450,918),
["first april"] = Vector(-1655,-390,-497),
["park"] = Vector(2675,10622,-1004),
["metrobuilder station"] = Vector(3544,-8880,-2034),
["marine"] = Vector(14950, 4282, -5105),
["the glorious country"] = Vector(-10223,3444,-3057.97),
["pioneer station"] = Vector(-15200,7954,-1010),
}
StationNumbers["gm_loop"] = {
["651"]= "First april",
["652"] = "Park",
["653"] = "Metrobuilder station",
["654"] = "Marine",
["655"] = "The glorious country",
["656"] = "Pioneer station",
}
function ulx.tps( calling_ply,station )
		station = station:lower()
		local map = Metrostroi.CurrentMap
		local tbl = StationNames[map]
		if StationNumbers[map][station] then
			station = StationNumbers[map][station]:lower()
		else
			local st = {}
			for k,v in pairs(tbl) do
				if k:find(station) then
					table.insert(st,k)
				end
			end
			if #st > 1 then
				local err = "Found "
				for k,v in pairs(st) do
					err = err..v.." "
				end
				ULib.tsayError( calling_ply, err, true )
				return
			end
			station = st[1] or station
		end

        if not StationNames[map][station] then ULib.tsayError( calling_ply, "Station not found "..station, true ) return end

        if calling_ply:InVehicle() then
                calling_ply:ExitVehicle()
        end
        calling_ply.ulx_prevpos = calling_ply:GetPos()--ulx return
        calling_ply.ulx_prevang = calling_ply:EyeAngles()

        calling_ply:SetPos(StationNames[map][station])

		ulx.fancyLogAdmin( calling_ply, "#A teleported to #s", station:gsub("^%l", string.upper))
end
local tps = ulx.command( "Metrostroi", "ulx station", ulx.tps, "!station" )
tps:addParam{ type=ULib.cmds.StringArg, hint="Станция или номер станции", ULib.cmds.takeRestOfLine }
tps:defaultAccess( ULib.ACCESS_ALL )
tps:help( "Телепорт на станцию." )
