--------------------------------------------------------------------------------
-- Assign train IDs
--------------------------------------------------------------------------------
if not Metrostroi.WagonID then
	Metrostroi.WagonID = 1
end
function Metrostroi.NextWagonID()
	local id = Metrostroi.WagonID
	Metrostroi.WagonID = Metrostroi.WagonID + 1
	if Metrostroi.WagonID > 99 then Metrostroi.WagonID = 1 end
	return id
end

if not Metrostroi.EquipmentID then
	Metrostroi.EquipmentID = 1
end
function Metrostroi.NextEquipmentID()
	local id = Metrostroi.EquipmentID
	Metrostroi.EquipmentID = Metrostroi.EquipmentID + 1
	return id
end




--------------------------------------------------------------------------------
-- Custom drop to floor that only checks origin and not bounding box
--------------------------------------------------------------------------------
function Metrostroi.DropToFloor(ent)
	local result = util.TraceLine({
		start = ent:GetPos(),
		endpos = ent:GetPos() - Vector(0,0,256),
		mask = -1,
		filter = { ent },
	})
	if result.Hit then ent:SetPos(result.HitPos) end
end




--------------------------------------------------------------------------------
-- Get random number that is same over a period of 1 minute
--------------------------------------------------------------------------------
local randomPeriodStart = 0
local randomPeriodNumber = math.random()
function Metrostroi.PeriodRandomNumber()
	if (CurTime() - randomPeriodStart) > 60 then
		randomPeriodNumber = math.random()
	end

	-- Refresh the period
	randomPeriodStart = CurTime()

	-- Return number
	return randomPeriodNumber
end




--------------------------------------------------------------------------------
-- Joystick controls
-- Author: HunterNL
--------------------------------------------------------------------------------
if not Metrostroi.JoystickValueRemap then
	Metrostroi.JoystickValueRemap = {}
	Metrostroi.JoystickSystemMap = {}
end

function Metrostroi.RegisterJoystickInput (uid,analog,desc,min,max)
	if not joystick then
		Error("Joystick Input registered without joystick addon installed, get it at https://github.com/MattJeanes/Joystick-Module")
	end
	--If this is only called in a JoystickRegister hook it should never even happen

	if #uid > 20 then
		print("Metrostroi Joystick UID too long, trimming")
		local uid = string.Left(uid,20)
	end


	local atype
	if analog then
		atype = "analog"
	else
		atype = "digital"
	end

	local temp = {
		uid = uid,
		type = atype,
		description = desc,
		category = "Metrostroi" --Just Metrostroi for now, seperate catagories for different trains later?
		--Catergory is also checked in subway base, don't just change
	}


	--Joystick addon's build-in remapping doesn't work so well, so we're doing this instead
	if min ~= nil and max ~= nil and analog then
		Metrostroi.JoystickValueRemap[uid]={min,max}
	end

	jcon.register(temp)
end

-- Wrapper around joystick get to implement our own remapping
function Metrostroi.GetJoystickInput(ply,uid)
	local remapinfo = Metrostroi.JoystickValueRemap[uid]
	local jvalue = joystick.Get(ply,uid)
	if remapinfo == nil then
		return jvalue
	elseif jvalue ~= nil then
		return math.Remap(joystick.Get(ply,uid),0,255,remapinfo[1],remapinfo[2])
	else
		return jvalue
	end
end




--------------------------------------------------------------------------------
-- Player meta table magic
-- Author: HunterNL
--------------------------------------------------------------------------------
local Player = FindMetaTable("Player")

function Player:CanDriveTrains()
	return IsValid(self:GetWeapon("train_kv_wrench")) or self:IsAdmin()
end

function Player:GetTrain()
	local seat = self:GetVehicle()
	if seat then
		return seat:GetNW2Entity("TrainEntity")
	end
end




--------------------------------------------------------------------------------
-- Train count
--------------------------------------------------------------------------------
function Metrostroi.TrainCount(...)
	local classnames = {...}
	if #classnames == 1 then
		return #ents.FindByClass(classnames[1])
	end

	local N = 0
	for k,v in pairs(#classnames > 0 and classnames or Metrostroi.TrainClasses) do
		if not baseclass.Get(v).SubwayTrain then continue end
		N = N + #ents.FindByClass(v)
	end
	return N
end

function Metrostroi.TrainCountOnPlayer(ply ,...)
	local classnames = {...}
	local typ
	if type(classnames[1]) == "number" then
		typ = classnames[1]
		classnames = {}
	end
	if CPPI then
		local N = 0
		for k,v in pairs(#classnames > 0 and classnames or Metrostroi.TrainClasses) do
			if not baseclass.Get(v).SubwayTrain then continue end
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do
				if ply == v2:CPPIGetOwner() and (not typ or v2.SubwayTrain.WagType == typ) then
					N = N + 1
				end
			end
		end
		return N
	end
	return 0
end

concommand.Add("metrostroi_train_count", function(ply, _, args)
	print("Trains on server: "..Metrostroi.TrainCount())
	if CPPI then
		local N = {}
		for k,v in pairs(Metrostroi.TrainClasses) do
			if  v == "gmod_subway_base" then continue end
			local ents = ents.FindByClass(v)
			for k2,v2 in pairs(ents) do
				N[v2:CPPIGetOwner() or "(disconnected)"] = (N[v2:CPPIGetOwner() or "(disconnected)"] or 0) + 1
			end
		end
		for k,v in pairs(N) do
			print(k,"Trains count: "..v)
		end
	end
end)

concommand.Add("metrostroi_time", function(ply, _, args)
	if IsValid(ply) then
		ply:PrintMessage(HUD_PRINTCONSOLE, "Time on server is "..
			Format("%02d:%02d:%02d",
				math.floor(os.time()/3600)%24,
				math.floor(os.time()/60)%60,
				math.floor(os.time())%60))

		local t = (os.time()/60)%(60*24)
		local printed = false
		local train = ply:GetTrain()
		if IsValid(train) and train.Schedule then
			for k,v in ipairs(train.Schedule) do
				local prefix = ""
				if (not printed) and (t < v[3]) then
					prefix = ">>>>"
					printed = true
				end
				ply:PrintMessage(HUD_PRINTCONSOLE,
					Format(prefix.."\t[%03d][%s] %02d:%02d:%02d",v[1],
						Metrostroi.StationNames[v[1]] or "N/A",
						math.floor(v[3]/60)%24,
						math.floor(v[3])%60,
						math.floor(v[3]*60)%60))

			end
		end
	end
end)




--------------------------------------------------------------------------------
-- Simple hack to get a driving schedule
--------------------------------------------------------------------------------
concommand.Add("metrostroi_schedule", function(ply, _, args)
	if not IsValid(ply) then return end
	local train = ply:GetTrain()

	local pos = Metrostroi.TrainPositions[train]
	if pos and pos[1] then
		local line = tonumber(args[1]) or 1
		local path = tonumber(args[2]) or 2
		local starts = tonumber(args[3])
		local ends = tonumber(args[4])

		train.Schedule = Metrostroi.GenerateSchedule("Line"..line.."_Platform"..path,starts,ends)
		if train.Schedule then
			train:SetNW2Int("_schedule_id",train.Schedule.ScheduleID)
			train:SetNW2Int("_schedule_duration",train.Schedule.Duration)
			train:SetNW2Int("_schedule_interval",train.Schedule.Interval)
			train:SetNW2Int("_schedule_N",#train.Schedule)
			train:SetNW2Int("_schedule_path",path)
			for k,v in ipairs(train.Schedule) do
				train:SetNW2Int("_schedule_"..k.."_1",v[1])
				train:SetNW2Int("_schedule_"..k.."_2",v[2])
				train:SetNW2Int("_schedule_"..k.."_3",v[3])
				train:SetNW2Int("_schedule_"..k.."_4",v[4])
				train:SetNW2String("_schedule_"..k.."_5",Metrostroi.StationNames[v[1]] or v[1])
			end
		end
	end
end)




--------------------------------------------------------------------------------
-- Failures related stuff
--------------------------------------------------------------------------------
concommand.Add("metrostroi_failures", function(ply, _, args)
	local i = 0
	for _,class in pairs(Metrostroi.TrainClasses) do
		local trains = ents.FindByClass(class)
		for _,train in pairs(trains) do
			timer.Simple(0.1+i*0.2,function()
				print("Failures for train "..train:EntIndex())
				train:TriggerInput("FailSimStatus",1)
			end)
			i = i + 1
		end
	end
end)

concommand.Add("metrostroi_fail", function(ply, _, args)
	local trainList = {}
	if not IsValid(ply) then
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				table.insert(trainList,train)
			end
		end
	else
		local train = ply:GetTrain()
		if IsValid(train) then
			train:UpdateWagonList()
			for k,v in pairs(train.WagonList) do
				trainList[k] = v
			end
		end
	end

	local train = table.Random(trainList)
	if train then
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"Generating random failure in your train!")
			print("Player "..tostring(ply).." generated random failure in train "..train:EntIndex())
		else
			print("Generating random failure in train "..train:EntIndex())
		end
		train:TriggerInput("FailSimFail",1)
	else
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train to generate a failure!")
		end
	end
end)

concommand.Add("metrostroi_fail_reset", function(ply, _, args)
	local trainList = {}
	if not IsValid(ply) then
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				table.insert(trainList,train)
			end
		end
	else
		local train = ply:GetTrain()
		if IsValid(train) then
			train:UpdateWagonList()
			for k,v in pairs(train.WagonList) do
				trainList[k] = v
			end
		end
	end

	if #trainList > 0 then
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"Reset all failures in your train!")
			print("Player "..tostring(ply).." reset all failures in train "..trainList[1]:EntIndex())
		else
			print("Reset all failures in train "..trainList[1]:EntIndex())
		end
		for _,v in pairs(trainList) do v:TriggerInput("FailSimReset") end
	else
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train to reset all failures!")
		end
	end
end)

concommand.Add("metrostroi_wire", function(ply, _, args)
	local trainList = {}
	if not IsValid(ply) then
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				table.insert(trainList,train)
			end
		end
	else
		local train = ply:GetTrain()
		if IsValid(train) then
			--train:UpdateWagonList()
			for k,v in pairs(train.WagonList) do
				trainList[k] = v
			end
		end
	end

	local train = table.Random(trainList)
	if train then
		if IsValid(ply) then
			args[1] = tonumber(args[1])
			if not args[1] then ply:PrintMessage(HUD_PRINTCONSOLE,"Argument must be a number") return end
			ply:PrintMessage(HUD_PRINTCONSOLE,"sets outside power in train wire"..args[1].."!")
			print("Player "..tostring(ply).." sets outside power in train "..args[1].." wire failure in train "..train:EntIndex())
		else
			print("sets outside power in train wire "..train:EntIndex())
		end
		if train.WriteTrainWire then train:WriteTrainWire(args[1],1) end
		train.TrainWireOutside[args[1]] = 1
		if train.WriteTrainWire then train:WriteTrainWire(args[1],1) end
	else
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train!")
		end
	end
end)
concommand.Add("metrostroi_wire_reset", function(ply, _, args)
	local trainList = {}
	if not IsValid(ply) then
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				table.insert(trainList,train)
			end
		end
	else
		local train = ply:GetTrain()
		if IsValid(train) then
			--train:UpdateWagonList()
			for k,v in pairs(train.WagonList) do
				trainList[k] = v
			end
		end
	end

	if #trainList > 0 then
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"reset wire outside power in train!")
			print("Player "..tostring(ply).." reset outside power in train ")
		else
			print("Reset outside power in trains ")
		end
		for _,v in pairs(trainList) do v.TrainWireOutside = {} end
	else
		if IsValid(ply) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"You must be inside a train!")
		end
	end
end)



--------------------------------------------------------------------------------
-- Electric consumption stats
--------------------------------------------------------------------------------
-- Load total kWh
timer.Create("Metrostroi_TotalkWhTimer",5.00,0,function()
	file.Write("metrostroi_data/total_kwh.txt",Metrostroi.TotalkWh or 0)
end)
Metrostroi.TotalkWh = Metrostroi.TotalkWh or tonumber(file.Read("metrostroi_data/total_kwh.txt") or "") or 0
Metrostroi.TotalRateWatts = Metrostroi.TotalRateWatts or 0
Metrostroi.Voltage = 750
Metrostroi.Current = 0
Metrostroi.PeopleOnRails = 0
Metrostroi.VoltageRestoreTimer = 0

local prevTime
hook.Add("Think", "Metrostroi_ElectricConsumptionThink", function()
	-- Change in time
	prevTime = prevTime or CurTime()
	local deltaTime = (CurTime() - prevTime)
	prevTime = CurTime()

	-- Calculate total rate
	Metrostroi.TotalRateWatts = 0
	Metrostroi.Current = 0
	for _,class in pairs(Metrostroi.TrainClasses) do
		local trains = ents.FindByClass(class)
		for _,train in pairs(trains) do
			if train.Electric then
				Metrostroi.TotalRateWatts = Metrostroi.TotalRateWatts + math.max(0,(train.Electric.EnergyChange or 0))
				Metrostroi.Current = Metrostroi.Current  + math.max(0,(train.Electric.Itotal or 0)) + train.TR.DropByPeople
			end
		end
	end

	-- Ignore invalid values
	if Metrostroi.TotalRateWatts > 1e8 then Metrostroi.TotalRateWatts = 0 end

	-- Calculate total kWh
	Metrostroi.TotalkWh = Metrostroi.TotalkWh + (Metrostroi.TotalRateWatts/(3.6e6))*deltaTime

	-- Calculate total resistance of people on rails and current flowing through
	local Rperson = 0.613
	local Iperson = Metrostroi.Voltage / (Rperson/(Metrostroi.PeopleOnRails + 1e-9))
	Metrostroi.Current = Metrostroi.Current + Iperson

	-- Check if exceeded global maximum current
	if Metrostroi.Current > GetConVarNumber("metrostroi_current_limit") then
		Metrostroi.VoltageRestoreTimer = CurTime() + 7.0
		print(Format("[!] Power feed protection tripped: current peaked at %.1f A",Metrostroi.Current))
	end

	-- Calculate new voltage
	local Rfeed = 0.03 --25
	Metrostroi.Voltage = math.max(0,GetConVarNumber("metrostroi_voltage") - Metrostroi.Current*Rfeed)
	if CurTime() < Metrostroi.VoltageRestoreTimer then Metrostroi.Voltage = 0 end

	--print(Format("%5.1f v %.0f A",Metrostroi.Voltage,Metrostroi.Current))
end)

concommand.Add("metrostroi_electric", function(ply, _, args) -- (%.2f$) Metrostroi.GetEnergyCost(Metrostroi.TotalkWh),
	local m = Format("[%25s] %010.3f kWh, %.3f kW (%5.1f v, %4.0f A)","<total>",
		Metrostroi.TotalkWh,Metrostroi.TotalRateWatts*1e-3,
		Metrostroi.Voltage,Metrostroi.Current)
	if IsValid(ply)
	then ply:PrintMessage(HUD_PRINTCONSOLE,m)
	else print(m)
	end

	if CPPI then
		local U = {}
		local D = {}
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				local owner = "(disconnected)"
				if train:CPPIGetOwner() then
					owner = train:CPPIGetOwner():GetName()
				end
				if train.Electric then
					U[owner] = (U[owner] or 0) + train.Electric.ElectricEnergyUsed
					D[owner] = (D[owner] or 0) + train.Electric.ElectricEnergyDissipated
				end
			end
		end
		for player,_ in pairs(U) do --, n=%.0f%%
			--local m = Format("[%20s] %08.1f KWh (lost %08.1f KWh)",player,U[player]/(3.6e6),D[player]/(3.6e6)) --,100*D[player]/U[player]) --,D[player])
			local m = Format("[%25s] %010.3f kWh (%.2f$)",player,U[player]/(3.6e6),Metrostroi.GetEnergyCost(U[player]/(3.6e6)))
			if IsValid(ply)
			then ply:PrintMessage(HUD_PRINTCONSOLE,m)
			else print(m)
			end
		end
	end
end)

timer.Create("Metrostroi_ElectricConsumptionTimer",0.5,0,function()
	if CPPI then
		local U = {}
		local D = {}
		for _,class in pairs(Metrostroi.TrainClasses) do
			local trains = ents.FindByClass(class)
			for _,train in pairs(trains) do
				local owner = train:CPPIGetOwner()
				if owner and (train.Electric) then
					U[owner] = (U[owner] or 0) + train.Electric.ElectricEnergyUsed
					D[owner] = (D[owner] or 0) + train.Electric.ElectricEnergyDissipated
				end
			end
		end
		for player,_ in pairs(U) do
			if IsValid(player) then
				player:SetDeaths(10*U[player]/(3.6e6))
			end
		end
	end
end)

local function murder(v)
	local positions = Metrostroi.GetPositionOnTrack(v:GetPos())
	for k2,v2 in pairs(positions) do
		local y,z = v2.y,v2.z
		y = math.abs(y)

		local y1 = 0.91-0.10
		local y2 = 1.78 ---0.50
		if (y > y1) and (y < y2) and (z < -1.70) and (z > -1.72) and (Metrostroi.Voltage > 40) then
			local pos = v:GetPos()

			util.BlastDamage(v,v,pos,64,3.0*Metrostroi.Voltage)

			local effectdata = EffectData()
			effectdata:SetOrigin(pos + Vector(0,0,-16+math.random()*(40+0)))
			util.Effect("cball_explode",effectdata,true,true)

			sound.Play("ambient/energy/zap"..math.random(1,3)..".wav",pos,75,math.random(100,150),1.0)
			Metrostroi.PeopleOnRails = Metrostroi.PeopleOnRails + 1

			--if math.random() > 0.85 then
				--Metrostroi.VoltageRestoreTimer = CurTime() + 7.0
				--print("[!] Power feed protection tripped: "..(tostring(v) or "").." died on rails")
			--end
		end
	end
end
--[[
timer.Create("Metrostroi_PlayerKillTimer",0.1,0,function()
	if true then return end
	Metrostroi.PeopleOnRails = 0
	for k,v in pairs(player.GetAll()) do
		murder(v)
	end
	for k,v in pairs(ents.FindByClass("npc_*")) do
		murder(v)
	end
end)
]]
timer.Remove("Metrostroi_PlayerKillTimer")


--------------------------------------------------------------------------------
-- Does current map have any sort of metrostroi support
--------------------------------------------------------------------------------
function Metrostroi.MapHasFullSupport()
	return (#Metrostroi.Paths > 0)
end
