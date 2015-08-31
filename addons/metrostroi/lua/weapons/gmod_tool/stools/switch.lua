TOOL.Category   = "Metro"
TOOL.Name       = "Switch Tool"
TOOL.Command    = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["lock"] = 0
if CLIENT then
	language.Add("Tool.switch.name", "Switch Tool")
	language.Add("Tool.switch.desc", "Sets switch tool channel")
	language.Add("Tool.switch.0", "Primary: Set channel 1\nSecondary: Set channel 2\nReload: Lock switch")
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end
	
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			v:SetChannel(1)
			print("Set channel 1")
		end
	end
	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
	
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			v:SetChannel(2)
			print("Set channel 2")
		end
	end	
	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end
	
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_switch" then
			if self:GetClientNumber("lock") == 1 then
				if v.LockedSignal then v.LockedSignal = nil else v.LockedSignal = v.LastSignal end
				print("Locked switch signal",v.LockedSignal)
			else
				v.NotChangePos = not v.NotChangePos
				print(v.NotChangePos and "Disabled" or "Enabled")
			end
		end
	end
	return true
end

function TOOL.BuildCPanel(panel)
	panel = panel or controlpanel.Get("switch")
	panel:AddControl("Header", { Text = "#Tool.switch.name", Description = "#Tool.switch.desc" })
	panel:AddControl("Checkbox", { Label = "Lock", Command = "switch_lock" })
end
