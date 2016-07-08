AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/z-o-m-b-i-e/metro_2033/electro/m33_electro_box_08.mdl")
	self.Sig = ""
end

function ENT:OnRemove()
end

function ENT:Think()
	if not IsValid(self.SignalEntity) then
		self.SignalEntity = Metrostroi.GetSignalByName(self.Signal)
		if IsValid(self.SignalEntity) then
			print(Format("Metrostroi Signal Controller: Linked to signal %s",self.Signal))
			if not self.SignalEntity.Controllers then
				self.SignalEntity.Controllers = {}
				table.insert(self.SignalEntity.Controllers,self)
			end
			for k,v in pairs(self.SignalEntity.Controllers) do
				if v == self then
					self:NextThink(CurTime() + 1.0)
					return true
				end
			end
			table.insert(self.SignalEntity.Controllers,self)
		end
	end
	self:NextThink(CurTime() + 1.0)
	return true
end

function ENT:KeyValue(key ,value)
    if key == "targetsignal" then
			self.Signal = value
		elseif key == "LenseEnabled" then
			if not self.Entities then self.Entities = {} end
			local tbl = string.Explode(",",value)
			timer.Simple(0,function() table.insert(self.Entities,{ents.FindByName(tbl[1]),tbl[2]}) end)
			self:StoreOutput(key,value)
		elseif key == "LenseDisabled" then
			if not self.Entities then self.Entities = {} end
			local tbl = string.Explode(",",value)
			timer.Simple(0,function() table.insert(self.Entities,{ents.FindByName(tbl[1]),tbl[2],true}) end)
			self:StoreOutput(key,value)
		end
end

function ENT:TriggerOutput(output,_,data)
	if not self.Entities then return end
	for k,v in pairs(self.Entities) do
		if output == "LenseEnabled" and not v[3] or output == "LenseDisabled" and v[3] then
			for _,ent in pairs(v[1]) do
				ent:Fire(v[2],data)
			end
		end
	end
end
function ENT:AcceptInput( input, activator, called, data )
	if not IsValid(self.SignalEntity) then
		self.SignalEntity = Metrostroi.GetSignalByName(self.Signal)
		if not IsValid(self.SignalEntity) then
			if #ents.FindByClass("gmod_track_signal") > 0 then
				ErrorNoHalt(Format("\nMetrostroi Signal Controller: Can't find signal %s!\nCheck, that you use official verion of signal\n",self.Signal))
			else
				ErrorNoHalt("\nMetrostroi Signal Controller: Please, load a signals first!\n")
			end
		end
		return true
	end
	local sig = self.SignalEntity
	if input == "Open" then
		for k,v in pairs(sig.Routes) do
			if v.Manual then v.IsOpened = true end
		end
	elseif input == "Close" then
		for k,v in pairs(sig.Routes) do
			if v.Manual then v.IsOpened = false end
		end
	elseif input == "SetKGU" then
		sig.KGU = data == "1"
	elseif input == "SetIS" then
		sig.InvationSignal = data == "1"
	end
end
