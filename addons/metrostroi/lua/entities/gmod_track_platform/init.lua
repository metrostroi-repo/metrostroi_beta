AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:PlayAnnounce(arriving,Ann)
	if not arriving then
		if self.MustPlayAnnounces then
			local Announce = Sound( "subway_stations_test1/"..Metrostroi.PlatformMap.."_"..(math.random(6))..".mp3" )
			sound.Play(Announce,self:LocalToWorld(Vector(0,-1200,200)),90,100,1)
			sound.Play(Announce,self:LocalToWorld(Vector(0,1200,200)),90,100,1)
			timer.Adjust( "metrostroi_station_announce_"..self:EntIndex(), math.random(45,150),0,function() self:PlayAnnounce() end)
			if self.SyncAnnounces then
				local ent = Metrostroi.Stations[self.StationIndex][self.PlatformIndex == 2 and 1 or 2].ent
				if IsValid(ent) then
					ent:PlayAnnounce(nil,Announce)
				end
			end
		else
			timer.Destroy("metrostroi_station_announce_"..self:EntIndex())
		end
	elseif arriving == 1 then
		local Announce = Sound( "subway_stations_test1/tritone.mp3" )
		sound.Play(Announce,self:LocalToWorld(Vector(0,-1200,200)),120,self.TritonePitch,1)
		sound.Play(Announce,self:LocalToWorld(Vector(0,1200,200)),120,self.TritonePitch,1)
	elseif arriving == 2 then
		local Announce = Sound( "subway_stations_test1/no_enter.mp3" )
		sound.Play(Announce,self:LocalToWorld(Vector(0,-1200,200)),120,100,1)
		sound.Play(Announce,self:LocalToWorld(Vector(0,1200,200)),120,100,1)
	end
	if Ann then
		local Announce = Sound(Ann)
		sound.Play(Announce,self:LocalToWorld(Vector(0,-1200,200)),90,100,1)
		sound.Play(Announce,self:LocalToWorld(Vector(0,1200,200)),90,100,1)
	end
end
--------------------------------------------------------------------------------
-- Initialize the platform data
--------------------------------------------------------------------------------
function ENT:Initialize()
	-- Get platform parameters
	self.VMF = self.VMF or {}
	self.PlatformStart		= ents.FindByName(self.VMF.PlatformStart or "")[1]
	self.SignOff		= tonumber(self.VMF.Sign or "0") == 1
	self.PlatformEnd		= ents.FindByName(self.VMF.PlatformEnd or "")[1]
	self.StationIndex		= tonumber(self.VMF.StationIndex) or 100
	self.PlatformIndex		= tonumber(self.VMF.PlatformIndex) or 1
	self.PopularityIndex	= self.VMF.PopularityIndex or 1.0
	self.PlatformLast		= (self.VMF.PlatformLast == "yes")
	self.PlatformX0			= self.VMF.PlatformX0 or 0.80
	self.PlatformSigma		= self.VMF.PlatformSigma or 0.25
	self.HorliftStation		= tonumber(self.VMF.HorliftStation) or 0
	self.HorliftHaveSignal		= (tonumber(self.VMF.HorliftHaveSignal) or 0) > 0
	self.TritonePitch = math.random(90,110)
	if not self.PlatformStart then
		self.VMF.PlatformStart 	= "station"..self.StationIndex.."_"..(self.VMF.PlatformStart or "")
		self.PlatformStart		= ents.FindByName(self.VMF.PlatformStart or "")[1]
	end
	if not self.PlatformEnd then
		self.VMF.PlatformEnd 	= "station"..self.StationIndex.."_"..(self.VMF.PlatformEnd or "")
		self.PlatformEnd		= ents.FindByName(self.VMF.PlatformEnd or "")[1]
	end

	-- Drop to floor
	self:DropToFloor()
	if IsValid(self.PlatformStart) then self.PlatformStart:DropToFloor() end
	if IsValid(self.PlatformEnd) then self.PlatformEnd:DropToFloor() end

	-- Positions
	if IsValid(self.PlatformStart) then
		self.PlatformStart = self.PlatformStart:GetPos()
	else
		self.PlatformStart = Vector(0,0,0)
	end
	if IsValid(self.PlatformEnd) then
		self.PlatformEnd = self.PlatformEnd:GetPos()
	else
		self.PlatformEnd = Vector(0,0,0)
	end

	-- Initial platform pool configuration
	self.WindowStart = 0  -- Increases when people board train
	self.WindowEnd = 0 -- Increases naturally over time
	self.PassengersLeft = 0 -- Number of passengers that left trains

	-- Send things to client
	self:SetNW2Float("X0",self.PlatformX0)
	self:SetNW2Float("Sigma",self.PlatformSigma)
	self:SetNW2Int("WindowStart",self.WindowStart)
	self:SetNW2Int("WindowEnd",self.WindowEnd)
	self:SetNW2Int("PassengersLeft",self.PassengersLeft)
	self:SetNW2Vector("PlatformStart",self.PlatformStart)
	self:SetNW2Vector("PlatformEnd",self.PlatformEnd)
	self:SetNW2Vector("StationCenter",self:GetPos())

	-- FIXME make this nicer
	for i=1,32 do self:SetNW2Vector("TrainDoor"..i,Vector(0,0,0)) end
	self:SetNW2Int("TrainDoorCount",0)
	local ars_ents = ents.FindInSphere(self.PlatformEnd,768)
	for k,v in pairs(ars_ents) do
		local delta_z = math.abs(self.PlatformEnd.z-v:GetPos().z)
		if (v:GetClass() == "gmod_track_pui") and (delta_z < 160) then
			self.PUI = v
			v.Horlift = self.HorliftStation > 0
		end
	end
end

function ENT:OnRemove()
	timer.Destroy("metrostroi_station_announce_"..self:EntIndex())
end

--------------------------------------------------------------------------------
-- Load key-values defined in VMF
--------------------------------------------------------------------------------
function ENT:KeyValue(key, value)
	self.VMF = self.VMF or {}
	self.VMF[key] = value
end


--------------------------------------------------------------------------------
-- Process platform logic
--------------------------------------------------------------------------------
function erf(x)
	local a1 =  0.254829592
	local a2 = -0.284496736
	local a3 =  1.421413741
	local a4 = -1.453152027
	local a5 =  1.061405429
	local p  =  0.3275911

	-- Save the sign of x
	sign = 1
	if x < 0 then sign = -1 end
	x = math.abs(x)

	-- A&S formula 7.1.26
	t = 1.0/(1.0 + p*x)
	y = 1.0 - (((((a5*t + a4)*t) + a3)*t + a2)*t + a1)*t*math.exp(-x*x)

    return sign*y
end
local function CDF(x,x0,sigma) return 0.5 * (1 + erf((x - x0)/math.sqrt(2*sigma^2))) end
local function merge(t1,t2) for k,v in pairs(t2) do table.insert(t1,v) end end

function ENT:PopulationCount()
	local totalCount = self.WindowEnd - self.WindowStart
	if self.WindowStart > self.WindowEnd then totalCount = (self:PoolSize() - self.WindowStart) + self.WindowEnd end
	return totalCount
end

local empty_checked = {}
local function getTrainDriver(train,checked)
	if not checked then
		for k,v in pairs(empty_checked) do empty_checked[k] = nil end
		checked = empty_checked
	end
	if not IsValid(train) then return end
	if checked[train] then return end
	checked[train] = true

	local ply = train:GetDriver()
	if IsValid(ply) then -- and (train.KV.ReverserPosition ~= 0)
		return ply
	end

	return getTrainDriver(train.RearTrain,checked) or getTrainDriver(train.FrontTrain,checked)
end

function ENT:FireHorliftDoors(input)
	if not self.Doors then
		self.Doors = {}
		local doors = ents.FindByName("station"..self.StationIndex.."_platform"..self.PlatformIndex.."_door")
		for _,v in pairs(doors) do
			table.insert(self.Doors,v)
		end
	end
	for _,v in pairs(self.Doors) do
		v:Fire(input,"","1")
	end
end
function ENT:GetDoorState()
	if not self.Doors then
		self.Doors = {}
		local doors = ents.FindByName("station"..self.StationIndex.."_platform"..self.PlatformIndex.."_door")
		for _,v in pairs(doors) do
			table.insert(self.Doors,v)
		end
	end
	for _,v in pairs(self.Doors) do
		if v:GetSaveTable().m_toggle_state ~= 1 then return true end
	end
	return false
end

ENT.TESTTEST = false
local dT = 0.25
local trains  = {}
function ENT:Think()
	if not Metrostroi.Stations[self.StationIndex] then return end
		-- Rate of boarding

	-- Find all potential trains
	trains = {}
	for k,v in pairs(Metrostroi.TrainClasses) do
		merge(trains,ents.FindByClass(v))
	end

	-- Send update to client
	self:SetNW2Int("WindowStart",self.WindowStart)
	self:SetNW2Int("WindowEnd",self.WindowEnd)
	self:SetNW2Int("PassengersLeft",self.PassengersLeft)

	-- Check if any trains are at the platform
	local platformStart	= self.PlatformStart
	local platformEnd	= self.PlatformEnd
	local platformDir   = platformEnd-platformStart
	local platformNorm	= platformDir:GetNormalized()

	-- Platforms with tracks in middle
	local dot = (self:GetPos() - platformStart):Cross(platformEnd - platformStart)
	local swap_side = dot.z > 0.0
	if Metrostroi.Stations[self.StationIndex] and not self.SignOff then
		self.MustPlayAnnounces = (not Metrostroi.Stations[self.StationIndex][self.PlatformIndex == 2 and 1 or 2] or self.PlatformIndex == 1) and Metrostroi.AnnouncerData[self.StationIndex] and Metrostroi.AnnouncerData[self.StationIndex][1] ~= nil
		self:SetNW2Bool("MustPlaySpooky",(not Metrostroi.Stations[self.StationIndex][self.PlatformIndex == 2 and 1 or 2] or not Metrostroi.AnnouncerData[self.StationIndex] or not  Metrostroi.AnnouncerData[self.StationIndex][1]) and self.PlatformIndex == 1)
		if not timer.Exists("metrostroi_station_announce_"..self:EntIndex()) and self.MustPlayAnnounces then
			timer.Create("metrostroi_station_announce_"..self:EntIndex(),0,0,function() self:PlayAnnounce() end)
		end
		self.SyncAnnounces = swap_side and Metrostroi.Stations[self.StationIndex][self.PlatformIndex == 2 and 1 or 2]
		self:SetNW2Bool("MustPlayAnnounces",self.MustPlayAnnounces or swap_side)
	end
	local boardingDoorList = {}
	self.HasTrain = nil
	self.TrainArrived = nil
	local TrainArrivedDist = 0
	local PeopleGoing = false
	self.PUIStartGoing = self.PUIStartGoing or false
	for k,v in pairs(trains) do
		if not IsValid(v) then trains[k] = nil end
		if not IsValid(v) or v:GetPos():Distance(self:GetPos()) > platformStart:Distance(platformEnd) then continue end
		local platform_distance	= ((platformStart-v:GetPos()) - ((platformStart-v:GetPos()):Dot(platformNorm))*platformNorm):Length()

		local vertical_distance = math.abs(v:GetPos().z - platformStart.z)
		local train_start		= (v:LocalToWorld(Vector(480,0,0)) - platformStart):Dot(platformDir) / (platformDir:Length()^2)
		local train_end			= (v:LocalToWorld(Vector(-480,0,0)) - platformStart):Dot(platformDir) / (platformDir:Length()^2)
		local left_side			= train_start > train_end
		if swap_side then left_side = not left_side end
		local doors_open 		= (left_side and v.LeftDoorsOpen) or ((not left_side) and v.RightDoorsOpen)
		if vertical_distance > 192 then doors_open = false end
		if (train_start < 0) and (train_end < 0) then doors_open = false end
		if (train_start > 1) and (train_end > 1) then doors_open = false end
		if train_start > -0.2 and train_start < 1.2 and vertical_distance < 192 and platform_distance < 256  then
			self.HasTrain = v
			v.BoardTime = math.max((v.PassengersToLeave or 0)*dT,v.AnnouncementToLeaveWagon and 0 or self:PopulationCount()*dT)*1.1
			v.Horlift = self.HorliftStation > 0
		end
		if train_start > 0 and train_start < 1 and vertical_distance < 192 and platform_distance < 256 and TrainArrivedDist < train_start  then
			TrainArrivedDist = train_start
			self.TrainArrived = v
		end
		-- Check horizontal lift station logic
		local passengers_can_board = false
		if (platform_distance < 256) and (doors_open) then
			passengers_can_board = false
			if self.HorliftStation > 0 then
				-- Check fine stop
				local stopped_fine = false
				for i=0,4 do
					local x_s = 0.99086 - i*0.1929
					local x_e = 0.97668 - i*0.1929
					stopped_fine = stopped_fine or ((train_start < x_s) and (train_start > x_e))
				end

				-- Open doors on station
				if stopped_fine and v.SOSD then
					self.HorliftTimer1 = self.HorliftTimer1 or CurTime()
					if ((CurTime() - self.HorliftTimer1) > 0.5) and (stopped_fine) then
						if not self.HorliftTimer2 then
							self:FireHorliftDoors("Open")
						end
						self.HorliftTimer2 = CurTime()
					end
				end

				-- Allow boarding
				if self.HorliftTimer2 and self:GetDoorState() then
					passengers_can_board = true
				end
			else
				passengers_can_board = true
			end
		end
		-- Board passengers
		if passengers_can_board then
			-- Find player of the train
			local driver = getTrainDriver(v)

			-- Limit train to platform
			train_start = math.max(0,math.min(1,train_start))
			train_end = math.max(0,math.min(1,train_end))

			-- Check for announcement
			if (v.LastPlatform == self) and (v.AnnouncementToLeaveWagon == true) and
				(v.AnnouncementToLeaveWagonAcknowledged ~= true) then
				v.AnnouncementToLeaveWagonAcknowledged = true
				v.LastPlatform = nil
			end
			-- Check if this was the last stop
			if (v.LastPlatform ~= self) then
				v.LastPlatform = self

				-- How many passengers must leave on this station
				local proportion = math.random() * math.max(0,1.0 + math.log(self.PopularityIndex))
				if self.PlatformLast then proportion = 1 end
				if (v.AnnouncementToLeaveWagon == true) then proportion = 1 end
				-- Total count
				v.PassengersToLeave = math.floor(proportion * v:GetNW2Float("PassengerCount") + 0.5)
			end
			-- Calculate number of passengers near the train
			local passenger_density = math.abs(CDF(train_start,self.PlatformX0,self.PlatformSigma) - CDF(train_end,self.PlatformX0,self.PlatformSigma))
			local passenger_count = passenger_density * self:PopulationCount()
			-- Get number of doors
			local door_count = #v.LeftDoorPositions
			if not left_side then door_count = #v.RightDoorPositions end

			-- Get maximum boarding rate for normal russian subway train doors
			local max_boarding_rate = 1.0 * door_count * dT
			-- Get boarding rate based on passenger density
			local boarding_rate = math.min(max_boarding_rate,passenger_count)
			if self.PlatformLast then boarding_rate = 0 end
			-- Get rate of leaving
			local leaving_rate = 1.0 * door_count * dT
			if v.PassengersToLeave == 0 then leaving_rate = 0 end
			-- Board these passengers into train
			local boarded	= math.min(math.max(1,math.floor(boarding_rate+0.5)),v.AnnouncementToLeaveWagon and 0 or self:PopulationCount())
			local left		= math.min(math.max(1,math.floor(leaving_rate +0.5)),v.PassengersToLeave)
			if math.random() <= math.Clamp(17-passenger_count,0,17)/17*0.5 then boarded = 0 end
			if math.random() <= math.Clamp(17-v.PassengersToLeave,0,17)/17*0.5 then left = 0 end
			local passenger_delta = boarded - left
			-- People board from platform
			if boarded > 0 then
				PeopleGoing = true
				self.WindowStart = (self.WindowStart + boarded) % self:PoolSize()
			end
			-- People leave to
			if left > 0 then
				PeopleGoing = true
				if IsValid(driver) then
					driver:AddFrags(left)
					--driver:AddDeaths(-left)
				end

				-- Move passengers
				v.PassengersToLeave = v.PassengersToLeave - left
				self.PassengersLeft = self.PassengersLeft + left
			end
			-- People boarded train
			if boarded > 0 then
				if IsValid(driver) then
					--driver:AddDeaths(boarded)
				end
			end
			-- Change number of people in train
			v:BoardPassengers(passenger_delta)

			-- Keep list of door positions
			if left_side
			then for k,vec in pairs(v.LeftDoorPositions)  do table.insert(boardingDoorList,v:LocalToWorld(vec)) end
			else for k,vec in pairs(v.RightDoorPositions) do table.insert(boardingDoorList,v:LocalToWorld(vec)) end
			end
			-- Add doors to boarding list
			--print("BOARDING",boarding_rate,"DELTA = "..passenger_delta,self.PlatformLast,v:GetPassengerCount())
		end
		self.PUIStartGoing = self.PUIStartGoing or passengers_can_board
	end
	if IsValid(self.PUI) then
		local train = self.TrainArrived
		if IsValid(train) and Metrostroi.EndStations and Metrostroi.EndStations[1] and type(train.SignsIndex) == "number" then
			local id = Metrostroi.EndStations[1][1]
			for k,v in pairs(train.SignsList or {}) do
				if v == train.SignsIndex then id = k; break end
			end
			local ends = false
			for k,v in pairs(Metrostroi.EndStations) do
				if id == v[1] or id == v[#v] then
					ends = true
					break
				end
			end
			if ends then
				self.PUI.Last = 0
			else
				self.PUI.Last = id
			end
		else
			self.PUI.Last = 0
		end
		if IsValid(train) and IsValid(self.PUI) and self.PUIStartGoing then
			if not self.PUI.Work then
				self.PUI.BoardTime = CurTime()+train.BoardTime + (20-(#train.WagonList)*4)  + self.HorliftStation*7
				self.PUI.Work = true
			end
		else
			self.PUIStartGoing = false
			self.PUI.Work = false
		end
	end
	if self.HasTrain and not self.SignOff then
		if not self.TritonePlayed then
			if self.HasTrain.SignsList and (self.HasTrain.SignsList[self.HasTrain.SignsIndex] == "" or self.HasTrain.SignsList[self.HasTrain.SignsIndex] and self.HasTrain.SignsList[self.HasTrain.SignsIndex][3]) then
				self:PlayAnnounce(2)
			else
				self:PlayAnnounce(1)
			end
			self.TritonePlayed = true
		end
	else
		self.TritonePlayed = nil
	end
	-- Add passengers
	if (not self.PlatformLast) and (#boardingDoorList == 0) then
		local target = GetConVarNumber("metrostroi_passengers_scale",50)*self.PopularityIndex --300
		-- then target = target*0.1 end

		if target <= 0 then
			self.WindowEnd = self.WindowStart
		else
			local growthDelta = math.max(0,(target-self:PopulationCount())*0.005)
			if growthDelta < 1.0 then -- Accumulate fractional rate
				self.GrowthAccumulation = (self.GrowthAccumulation or 0) + growthDelta
				if self.GrowthAccumulation > 1.0 then
					growthDelta = 1
					self.GrowthAccumulation = self.GrowthAccumulation - 1.0
				end
			end
			self.WindowEnd = (self.WindowEnd + math.floor(growthDelta+0.5)) % self:PoolSize()
		end
	end

	if self.HorliftStation > 0 then
		if self.HorliftTimer2 then
			if (CurTime() - self.HorliftTimer2) > 1 then
				self:FireHorliftDoors("Close")
				self.HorliftTimer1 = nil
				self.HorliftTimer2 = nil
				self.HorliftTimer3 = CurTime()
			end
		end
		if self.HorliftTimer3 and (CurTime() - self.HorliftTimer3) > 2.5 then
			self.HorliftTimer3 = nil
		end
	end
	if self.OldOpened ~= self:GetDoorState() or self.OldPeopleGoing ~= PeopleGoing then
		self.ARSOverride = true
		self.OldOpened = self:GetDoorState()
		self.OldPeopleGoing = PeopleGoing
	end
	-- Block local ARS sections
	if self.ARSOverride ~= nil then
		-- Signal override to all signals
		local ars_ents = ents.FindInSphere(self.PlatformEnd,768)
		for k,v in pairs(ars_ents) do
			local delta_z = math.abs(self.PlatformEnd.z-v:GetPos().z)
			if (v:GetClass() == "gmod_track_signal") and (delta_z < 128) then
				v.OverrideTrackOccupied = self:GetDoorState()
			end
			if (v:GetClass() == "gmod_track_horlift_signal") and (delta_z < 90 and v:GetNWInt("Type") == 0 or v:GetNWInt("Type") == 1) then
				v.WhiteSignal = self:GetDoorState()
				v.YellowSignal = not self:GetDoorState()
					print(v,v.YellowSignal)
				v.PeopleGoing = PeopleGoing
			end
		end

		-- Finish override
		self.ARSOverride = nil
	end

	-- Send boarding list FIXME make this nicer
	for k,v in ipairs(boardingDoorList) do
		self:SetNW2Vector("TrainDoor"..k,v)
	end
	self:SetNW2Int("TrainDoorCount",#boardingDoorList)
	self:NextThink(CurTime() + dT)
	return true
end
