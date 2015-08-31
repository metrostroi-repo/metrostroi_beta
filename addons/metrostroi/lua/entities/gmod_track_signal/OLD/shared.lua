ENT.Type			= "anim"
ENT.PrintName		= "Signalling Element"
ENT.Category		= "Metrostroi (utility)"

ENT.Spawnable		= true
ENT.AdminSpawnable	= false

ENT.TrafficLightModels = {}
ENT.RenderOffset = {}
ENT.BasePosition = Vector(-112,32,0)

-- Light indexes
local L_R	= 0
local L_Y	= 1
local L_G	= 2
local L_B	= 3
local L_W	= 4

-- Lamp indexes
-- 0 Red
-- 1 Yellow
-- 2 Green
-- 3 Blue
-- 4 Second yellow (flashing yellow)
-- 5 White


--------------------------------------------------------------------------------
-- Inside
--------------------------------------------------------------------------------
ENT.RenderOffset[0] = Vector(0,0,112+32)
ENT.TrafficLightModels[0] = {
	["m1"]	= "models/metrostroi/signals/box.mdl",
	["m2"]	= "models/metrostroi/signals/pole_2.mdl",
	[L_RG]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[0] = { Vector(8,5,25), Color(255,0,0) },
				[2] = { Vector(8,5,14), Color(0,255,0) }, } },
	[L_RY]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[0] = { Vector(8,5,25), Color(255,0,0) },
				[2] = { Vector(8,5,14), Color(255,255,0) }, } },
	[L_GY]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[1] = { Vector(8,5,25), Color(255,255,0) },
				[2] = { Vector(8,5,14), Color(0,255,0) }, } },
	[L_BY]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[1] = { Vector(8,5,14), Color(255,255,0) },
				[3] = { Vector(8,5,25), Color(32,0,255) }, } },
	[L_RY2]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[0] = { Vector(8,5,25), Color(255,0,0) },
				[4] = { Vector(8,5,14), Color(255,255,0) }, } },
	[L_Y2R]	= { 32, "models/metrostroi/signals/light_2.mdl", {
				[0] = { Vector(8,5,14), Color(255,0,0) },
				[4] = { Vector(8,5,25), Color(255,255,0) }, } },
	[L_RYG]	= { 40, "models/metrostroi/signals/light_3.mdl", {
				[0] = { Vector(8,5,35), Color(255,0,0) },
				[1] = { Vector(8,5,25), Color(255,255,0) },				
				[2] = { Vector(8,5,14), Color(0,255,0) }, } },
	[L_BYG]	= { 40, "models/metrostroi/signals/light_3.mdl", {
				[3] = { Vector(8,5,35), Color(32,0,255) },
				[1] = { Vector(8,5,25), Color(255,255,0) },				
				[2] = { Vector(8,5,14), Color(0,255,0) }, } },

	--[3] = { 24, "models/metrostroi/signals/light_path.mdl" },
}


--------------------------------------------------------------------------------
-- Outside
--------------------------------------------------------------------------------
ENT.RenderOffset[1] = Vector(-2,0,264)
ENT.TrafficLightModels[1] = {
	["m1"]	= "models/metrostroi/signals/pole_1.mdl",
	[L_RG]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[0] = { Vector(0,15,20), Color(255,0,0) },
				[2] = { Vector(0,15, 9), Color(0,255,0) }, } },
	[L_RY]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[0] = { Vector(0,15,20), Color(255,0,0) },
				[1] = { Vector(0,15, 9), Color(255,255,0) }, } },
	[L_GY]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[1] = { Vector(0,15,20), Color(255,255,0) },
				[2] = { Vector(0,15, 9), Color(0,255,0) }, } },
	[L_BY]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[1] = { Vector(0,15, 9), Color(255,255,0) },
				[3] = { Vector(0,15,20), Color(32,0,255) }, } },
	[L_RY2]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[0] = { Vector(0,15,20), Color(255,0,0) },
				[4] = { Vector(0,15, 9), Color(255,255,0) }, } },
	[L_Y2R]	= { 52, "models/metrostroi/signals/light_outside_2.mdl", {
				[0] = { Vector(0,15, 9), Color(255,0,0) },
				[4] = { Vector(0,15,20), Color(255,255,0) }, } },
	[L_RYG]	= { 64, "models/metrostroi/signals/light_outside_3.mdl", {
				[0] = { Vector(0,15,31), Color(255,0,0) },
				[1] = { Vector(0,15,20), Color(255,255,0) },				
				[2] = { Vector(0,15, 9), Color(0,255,0) }, } },
	[L_BYG]	= { 64, "models/metrostroi/signals/light_outside_3.mdl", {
				[3] = { Vector(0,15,31), Color(32,0,255) },
				[1] = { Vector(0,15,20), Color(255,255,0) },				
				[2] = { Vector(0,15, 9), Color(0,255,0) }, } },

	--[3] = { 24, "models/metrostroi/signals/light_path.mdl" },
}


--------------------------------------------------------------------------------
-- Outside box
--------------------------------------------------------------------------------
ENT.RenderOffset[2] = Vector(0,0,112+40)
ENT.TrafficLightModels[2] = {
	["m1"]	= "models/metrostroi/signals/box_outside.mdl",
	["m2"]	= "models/metrostroi/signals/pole_3.mdl",
	[L_RG]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[0] = { Vector(10,4,27), Color(255,0,0) },
				[2] = { Vector(10,4,16), Color(0,255,0) }, } },
	[L_RY]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[0] = { Vector(10,4,27), Color(255,0,0) },
				[1] = { Vector(10,4,16), Color(255,255,0) }, } },
	[L_GY]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[1] = { Vector(10,4,27), Color(255,255,0) },
				[2] = { Vector(10,4,16), Color(0,255,0) }, } },
	[L_BY]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[1] = { Vector(10,4,16), Color(255,255,0) },
				[3] = { Vector(10,4,27), Color(32,0,255) }, } },
	[L_RY2]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[0] = { Vector(10,4,27), Color(255,0,0) },
				[4] = { Vector(10,4,16), Color(255,255,0) }, } },
	[L_Y2R]	= { 40, "models/metrostroi/signals/light_outside2_2.mdl", {
				[0] = { Vector(10,4,16), Color(255,0,0) },
				[4] = { Vector(10,4,27), Color(255,255,0) }, } },
	[L_RYG]	= { 50, "models/metrostroi/signals/light_outside2_3.mdl", {
				[0] = { Vector(10,4,39), Color(255,0,0) },
				[1] = { Vector(10,4,27), Color(255,255,0) },				
				[2] = { Vector(10,4,16), Color(0,255,0) }, } },
	[L_BYG]	= { 50, "models/metrostroi/signals/light_outside2_3.mdl", {
				[3] = { Vector(10,4,39), Color(32,0,255) },
				[1] = { Vector(10,4,27), Color(255,255,0) },				
				[2] = { Vector(10,4,16), Color(0,255,0) }, } },

	--[3] = { 24, "models/metrostroi/signals/light_path.mdl" },
}




--------------------------------------------------------------------------------
function ENT:SetupDataTables()
	-- Bits which define ARS signals and behaviors of the current joint
	self:NetworkVar("Int", 0, "Settings" )

	-- Bits which define traffic lights in current joint
	self:NetworkVar("Int", 1, "TrafficLights" )

	-- Which lamps are shining for the traffic lamps, which ARS signals are active
	self:NetworkVar("Int", 2, "ActiveSignals")
	
	-- Style of the traffic lights
	self:NetworkVar("Int", 3, "LightsStyle" )	
end

local function addBitField(name)
	ENT["Set"..name.."Bit"] = function(self,idx,value)
		local packed_value = bit.lshift(value and 1 or 0,idx)
		local mask = bit.bnot(bit.lshift(1,idx))
		self["Set"..name](self,bit.bor(bit.band(self["Get"..name](self),mask),packed_value))
	end

	ENT["Get"..name.."Bit"] = function(self,idx)
		local mask = bit.lshift(1,idx)
		return bit.band(self["Get"..name](self),mask) ~= 0
	end
end

local function addBitParameter(name,field,bit)
	ENT["Set"..name] = function(self,value)
		self["Set"..field.."Bit"](self,bit,value)
	end

	ENT["Get"..name] = function(self)
		return self["Get"..field.."Bit"](self,bit)
	end
end


--------------------------------------------------------------------------------
addBitField("Settings")
addBitField("TrafficLights")
addBitField("ActiveSignals")
addBitField("NominalSignals")


--------------------------------------------------------------------------------
addBitParameter("AlwaysRed",		"Settings",8)
addBitParameter("RedWhenAlternate",	"Settings",9)
addBitParameter("RedWhenMain",		"Settings",10)
addBitParameter("InvertChannel1",	"Settings",11)
addBitParameter("InvertChannel2",	"Settings",12)
addBitParameter("NoARS",			"Settings",13)

addBitParameter("IsolatingLight",	"Settings",16)
addBitParameter("IsolatingSwitch",	"Settings",17)
addBitParameter("DontPropagate",	"Settings",18)
-- 19 Special logic 1
-- 20 Special logic 2

addBitParameter("Red",			"ActiveSignals",0)
addBitParameter("Yellow",		"ActiveSignals",1)
addBitParameter("Green",		"ActiveSignals",2)
addBitParameter("Blue",			"ActiveSignals",3)
addBitParameter("SecondYellow",	"ActiveSignals",4)
addBitParameter("White",		"ActiveSignals",5)