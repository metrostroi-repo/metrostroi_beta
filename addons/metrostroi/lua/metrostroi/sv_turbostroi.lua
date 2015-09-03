--------------------------------------------------------------------------------
-- Simulation acceleration DLL support
--------------------------------------------------------------------------------
if not TURBOSTROI then
	local FPS = 1/FrameTime()
	local messageTimeout = 0
	local messageCounter = 0
	Metrostroi.dataCache = {}
	local inputCache = {}
	local id,system,name,index,value
	local function updateTrains(trains)
		--local recvMessage = Turbostroi.RecvMessage
		-- Get data packets from simulation
		for _,train in pairs(trains) do			
			while true do
				id,system,name,index,value = Turbostroi.RecvMessage(train)
				if id == 1 then
					if train.Systems[system] then
						train.Systems[system][name] = value
					end
				end
				if id == 2 then
					if name == "" then name = nil end
					if index == 0 then index = nil end
					if value == 0 then value = nil end
					train:PlayOnce(system,name,index,value)
				end
				if id == 3 then
					train:WriteTrainWire(index,value)
				end
				if id == 4 then
					if train.Systems[system] then
						train.Systems[system]:TriggerInput(name,value)
					end
				end
				--print(id,name)

				if not id then break end
				messageCounter = messageCounter + 1
			end
		end
		
		-- Send train wire values
		-- Output all system values
		for _,train in pairs(trains) do
			for i=1,32 do
				if not Metrostroi.dataCache[train] then Metrostroi.dataCache[train] = {} end
				if not Metrostroi.dataCache[train]["wires"] then Metrostroi.dataCache[train]["wires"] = {} end
				if Metrostroi.dataCache[train]["wires"][i] ~= train:ReadTrainWire(i) then
					Metrostroi.dataCache[train]["wires"][i] = train:ReadTrainWire(i)
					Turbostroi.SendMessage(train,3,"","",i,train:ReadTrainWire(i))
				end
			end
			for sys_name,system in pairs(train.Systems) do
				if system.OutputsList and system.DontAccelerateSimulation then
					for _,name in pairs(system.OutputsList) do
						local value = (system[name] or 0)
						if not Metrostroi.dataCache[train][sys_name] then Metrostroi.dataCache[train][sys_name] = {} end
						if Metrostroi.dataCache[train][sys_name][name] ~= value then
							Metrostroi.dataCache[train][sys_name][name] = value
							Turbostroi.SendMessage(train,1,sys_name,name,0,tonumber(value) or 0)
						end
					end
				end
			end
		end
		hook.Add("EntityRemoved","TurbostroiMetrostroi.DataCache1",function(ent)
			if Metrostroi.dataCache[ent] then
				Metrostroi.dataCache[ent] = nil
			end
		end)
	end

	if Turbostroi then
		function Turbostroi.TriggerInput(train,system,name,value)
			local v = value or 0
			if type(value) == "boolean" then v = value and 1 or 0 end
			if not Metrostroi.dataCache[train] then Metrostroi.dataCache[train] = {} end
			if not Metrostroi.dataCache[train][system] then Metrostroi.dataCache[train][system] = {} end
			if Metrostroi.dataCache[train][system][name] ~= value then
				Metrostroi.dataCache[train][system][name] = value
				Turbostroi.SendMessage(train,4,system,name,0,v)
			end
		end
		hook.Add("EntityRemoved","TurbostroiMetrostroi.DataCache2",function(ent)
			if Metrostroi.dataCache[ent] then
				Metrostroi.dataCache[ent] = nil
			end
		end)
		hook.Add("Think", "Turbostroi_Think", function()
			if not Turbostroi then return end
			
			-- Proceed with the think loop
			Turbostroi.SetSimulationFPS(FPS)
			Turbostroi.SetTargetTime(CurTime())
			Turbostroi.Think()
				
			-- Update all types of trains
			for k,v in pairs(Metrostroi.TrainClasses) do
				if v ~= "gmod_subway_ai" then
					updateTrains(ents.FindByClass(v))
				end
			end
				
			-- HACK
			GLOBAL_SKIP_TRAIN_SYSTEMS = nil
			
			-- Print stats
			if ((CurTime() - messageTimeout) > 1.0) then
				messageTimeout = CurTime()
				--RunConsoleCommand("say",Format("Metrostroi: %d messages per second (%d per tick)",messageCounter,messageCounter / FPS))
				messageCounter = 0
			end
		end)
	end
	return
end




--------------------------------------------------------------------------------
-- Turbostroi scripts
--------------------------------------------------------------------------------
Metrostroi = {}
Metrostroi.DataCache = {}
Metrostroi.BaseSystems = {} -- Systems that can be loaded
Metrostroi.Systems = {} -- Constructors for systems

LoadSystems = {} -- Systems that must be loaded/initialized
GlobalTrain = {} -- Train emulator
GlobalTrain.Systems = {} -- Train systems
GlobalTrain.TrainWires = {}
GlobalTrain.WriteTrainWires = {}

function CurTime() return CurrentTime end

function Metrostroi.DefineSystem(name)
	TRAIN_SYSTEM = {}
	Metrostroi.BaseSystems[name] = TRAIN_SYSTEM
	
	-- Create constructor
	Metrostroi.Systems[name] = function(train,...)
		local tbl = { _base = name }
		local TRAIN_SYSTEM = Metrostroi.BaseSystems[tbl._base]
		if not TRAIN_SYSTEM then print("No system: "..tbl._base) return end
		for k,v in pairs(TRAIN_SYSTEM) do
			if type(v) == "function" then
				tbl[k] = function(...) 
					if not Metrostroi.BaseSystems[tbl._base][k] then
						print("ERROR",k,tbl._base)
					end
					return Metrostroi.BaseSystems[tbl._base][k](...) 
				end
			else
				tbl[k] = v
			end
		end
		
		tbl.Initialize = tbl.Initialize or function() end
		tbl.Think = tbl.Think or function() end
		tbl.Inputs = tbl.Inputs or function() return {} end
		tbl.Outputs = tbl.Outputs or function() return {} end
		tbl.TriggerInput = tbl.TriggerInput or function() end
		tbl.TriggerOutput = tbl.TriggerOutput or function() end
		
		tbl.Train = train
		tbl:Initialize(...)
		tbl.OutputsList = tbl:Outputs()
		tbl.InputsList = tbl:Inputs()
		tbl.IsInput = {}
		for k,v in pairs(tbl.InputsList) do tbl.IsInput[v] = true end		
		return tbl
	end
end

function GlobalTrain.LoadSystem(self,a,b,...)
	local name
	local sys_name
	if b then
		name = b
		sys_name = a
	else
		name = a
		sys_name = a
	end
	
	if not Metrostroi.Systems[name] then error("No system defined: "..name) end
	if self.Systems[sys_name] then error("System already defined: "..sys_name)  end
	
	self[sys_name] = Metrostroi.Systems[name](self,...)
	if (name ~= sys_name) or (b) then self[sys_name].Name = sys_name end
	self.Systems[sys_name] = self[sys_name]
	
	-- Don't simulate on here
	local no_acceleration = Metrostroi.BaseSystems[name].DontAccelerateSimulation
	if no_acceleration then
		self.Systems[sys_name].Think = function() end
		self.Systems[sys_name].TriggerInput = function(self,name,value) print("ERR",self,name,value) end
	end
end

function GlobalTrain.PlayOnce(self,soundid,location,range,pitch)
	SendMessage(2,soundid or "",location or "",range or 0,pitch or 0)
end

function GlobalTrain.ReadTrainWire(self,n)
	return self.TrainWires[n] or 0
end

function GlobalTrain.WriteTrainWire(self,n,v)
	self.WriteTrainWires[n] = v
end




--------------------------------------------------------------------------------
-- Main train code (turbostroi side)
--------------------------------------------------------------------------------
print("[!] Train initialized!")
function Think()
	-- This is just blatant copy paste from init.lua of base train entity
	local self = GlobalTrain
	
	-- Perform data exchange
	DataExchange()
	
	----------------------------------------------------------------------------
	self.PrevTime = self.PrevTime or CurTime()
	self.DeltaTime = (CurTime() - self.PrevTime)
	self.PrevTime = CurTime()
	
	-- Is initialized?
	if not self.Initialized then return end
	
	-- Run iterations on systems simulation
	local iterationsCount = 1
	if (not self.Schedule) or (iterationsCount ~= self.Schedule.IterationsCount) then
		self.Schedule = { IterationsCount = iterationsCount }
		
		-- Find max number of iterations
		local maxIterations = 0
		for k,v in pairs(self.Systems) do maxIterations = math.max(maxIterations,(v.SubIterations or 1)) end

		-- Create a schedule of simulation
		for iteration=1,maxIterations do self.Schedule[iteration] = {} end

		-- Populate schedule
		for k,v in pairs(self.Systems) do
			local simIterationsPerIteration = (v.SubIterations or 1) / maxIterations
			local iterations = 0
			for iteration=1,maxIterations do
				iterations = iterations + simIterationsPerIteration
				while iterations >= 1 do
					table.insert(self.Schedule[iteration],v)
					iterations = iterations - 1
				end
			end
		end
	end
	
	-- Simulate according to schedule
	for i,s in ipairs(self.Schedule) do
		for k,v in ipairs(s) do
			v:Think(self.DeltaTime / (v.SubIterations or 1),i)
		end
	end
end

function Initialize()
	print("[!] Loading systems")
	for k,v in pairs(LoadSystems) do
		GlobalTrain:LoadSystem(k,v)
	end
	GlobalTrain.Initialized = true
end

function DataExchange()
	-- Get data packets
	local id,system,name,index,value
	while true do
		id,system,name,index,value = RecvMessage()
		if id == 1 then
			if GlobalTrain.Systems[system] then
				GlobalTrain.Systems[system][name] = value
			end
		end
		if id == 3 then
			GlobalTrain.TrainWires[index] = value
		end
		if id == 4 then
			if GlobalTrain.Systems[system] then
				GlobalTrain.Systems[system]:TriggerInput(name,value)
			end
		end
		if not id then break end
	end
	-- Output all variable values
	for sys_name,system in pairs(GlobalTrain.Systems) do
		if system.OutputsList and (not system.DontAccelerateSimulation) then
			for _,name in pairs(system.OutputsList) do
				local value = (system[name] or 0)
				if not Metrostroi.DataCache[sys_name] then Metrostroi.DataCache[sys_name] = {} end
				if Metrostroi.DataCache[sys_name][name] ~= value then
					Metrostroi.DataCache[sys_name][name] = value
					--print(sys_name,name,value)
					SendMessage(1,sys_name,name,0,tonumber(value) or 0)
				end
			end
		end
	end
	
	-- Output train wire writes
	if not Metrostroi.DataCache["wires"] then Metrostroi.DataCache["wires"] = {} end
	for twID,value in pairs(GlobalTrain.WriteTrainWires) do
		if Metrostroi.DataCache["wires"][twID] ~= value then
			Metrostroi.DataCache["wires"][twID] = value
			SendMessage(3,"","",tonumber(twID) or 0,tonumber(value) or 0)
		end
		--GlobalTrain.WriteTrainWires[twID] = nil
	end
end