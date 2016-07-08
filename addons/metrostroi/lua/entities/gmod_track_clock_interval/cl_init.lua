include("shared.lua")
ENT.DigitPositions = {
  {Vector(14,-8.5,0)},
  {Vector(-2,-8.5,0)},
  {Vector(-15,-8.5,0)},
  {Vector(7,-8.5,0),true},
}

function ENT:Initialize()
    self.Digits = {}
end

function ENT:Think()
	for k,v in pairs(self.DigitPositions) do
		if not IsValid(self.Digits[k]) then
      if v[2] then
        self.Digits[k] = ClientsideModel("models/metrostroi/mus_clock/ind_"..(self:GetNW2Bool("Type") and "spb" or "msk").."_type"..tostring(self:GetNW2Int("Light",1)).."_dot.mdl",RENDERGROUP_OPAQUE)
      else
        self.Digits[k] = ClientsideModel("models/metrostroi/mus_clock/ind_"..(self:GetNW2Bool("Type") and "spb" or "msk").."_type"..tostring(self:GetNW2Int("Light",1)).."_numb.mdl",RENDERGROUP_OPAQUE)
      end
			self.Digits[k]:SetPos(self:LocalToWorld(v[1]))
			self.Digits[k]:SetAngles(self:GetAngles())
			self.Digits[k]:SetSkin(10)
			self.Digits[k]:SetParent(self)
		end
	end


	local dT = Metrostroi.GetTimedT()
	local interval = -dT + os.time() - (self:GetIntervalResetTime()+1396011937)
	if (interval <= (9*60+59)) and (interval >= 0) then
		if IsValid(self.Digits[1]) then
			self.Digits[1]:SetSkin(math.floor(interval/60))
		end
		if IsValid(self.Digits[2]) then
			self.Digits[2]:SetSkin(math.floor((interval%60)/10))
		end
		if IsValid(self.Digits[3]) then
			self.Digits[3]:SetSkin(math.floor((interval%60)%10))
		end
	else
		for i = 1,3 do
			if IsValid(self.Digits[i]) then
				self.Digits[i]:SetSkin(10)
			end
		end
	end
end
function ENT:OnRemove()
    for _,v in pairs(self.Digits) do
			SafeRemoveEntity(v)
		end
end

function ENT:Draw()
	self:DrawModel()
end
