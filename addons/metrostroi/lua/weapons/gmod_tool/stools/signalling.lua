TOOL.Category   = "Metro"
TOOL.Name       = "Signalling Tool"
TOOL.Command    = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["signaldata"] = ""
TOOL.ClientConVar["signdata"] = ""
TOOL.ClientConVar["type"] = 1
TOOL.ClientConVar["routetype"] = 1

if SERVER then util.AddNetworkString "metrostroi-stool-signalling" end


local Types = {"Signal","Sign",[0] = "Choose type"}
local TypesOfSignal = {"Inside","Outside big","Outside small"}
local TypesOfSign = {"NF","40","60","70","80","Station border","C(horn) Street","STOP Street","Dangerous","Deadlock","Stop marker","!(stop)","T","T Start","T End","T Sbor(engage)","Engines off","Engines on","C(horn)","Stop rail T","Stop rail","Left doors"}
local RouteTypes = {"Auto", "Manual","Repeater"}
local Type = 0
local RouteType = 1
local Signal-- = {}
local Sign-- = {}

--Signal.Type = 1

if CLIENT then
	language.Add("Tool.signalling.name", "Signalling Tool")
	language.Add("Tool.signalling.desc", "Adds and modifies signalling equipment (ARS/ALS) or signs")
	language.Add("Tool.signalling.0", "Primary: Spawn/update selected signalling entity (point at the inner side of rail)\nReload: Copy ARS/light settings\nSecondary: Remove")
	language.Add("Undone_signalling", "Undone ARS/signalling equipment")
end

function TOOL:SpawnSignal(ply,trace,param)
	local pos = trace.HitPos
  
	-- Use some code from rerailer --
	local tr = Metrostroi.RerailGetTrackData(pos,ply:GetAimVector())
	if not tr then return end
	-- Create signal entity
	local ent
	local found = false
	local entlist = ents.FindInSphere(pos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_signal" then
			ent = v
			found = true
		end
	end
	if param == 2 then
		if not ent then return end
		Signal.Type = ent.SignalType + 1
		Signal.Name = ent.Name
		Signal.Lenses = ent.LensesStr
		Signal.RouteNumber =	ent.RouteNumber
		Signal.IsolateSwitches = ent.IsolateSwitches
		Signal.Approve0 = ent.Approve0
		Signal.Depot = ent.Depot
		Signal.ARSOnly = ent.ARSOnly
		Signal.Routes = ent.Routes
		Signal.Left = ent.Left
		net.Start("metrostroi-stool-signalling")
			net.WriteBool(false)
			net.WriteTable(Signal)
		net.Send(self:GetOwner())
	else
		if not ent then ent = ents.Create("gmod_track_signal") end
		if IsValid(ent) then
			if param ~= 2 then 
				ent:SetPos(tr.centerpos - tr.up * 9.5)
				ent:SetAngles((-tr.right):Angle() + Angle(0,Signal.Left and 180 or 0,0))
			end
			if not found then ent:Spawn() end
			ent.SignalType = Signal.Type-1
			ent.ARSOnly = Signal.ARSOnly
			ent.Name = Signal.Name
			ent.LensesStr = Signal.Lenses
			ent.RouteNumber =	Signal.RouteNumber
			ent.IsolateSwitches = Signal.IsolateSwitches
			ent.Approve0 = Signal.Approve0
			ent.Depot = Signal.Depot
			ent.Routes = Signal.Routes
			ent.Left = Signal.Left
			ent.Lenses = string.Explode("-",ent.LensesStr)
			ent.InS = nil
			ent:SendUpdate()
			for i = 1,#ent.Lenses do
				if ent.Lenses[i]:find("W") then
					ent.InS = i
				end
			end
			Metrostroi.UpdateSignalEntities()
			Metrostroi.PostSignalInitialize()
		end
		return ent
	end
end

function TOOL:SpawnSign(ply,trace,param)
	local pos = trace.HitPos
  
	-- Use some code from rerailer --
	local tr = Metrostroi.RerailGetTrackData(pos,ply:GetAimVector())
	if not tr then return end
	-- Create sign entity
	local ent
	local found = false
	local entlist = ents.FindInSphere(pos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_signs" then
			ent = v
			found = true
		end
	end
	if param == 2 then
		if not ent then return end
		Sign.Type = ent.SignType
		Sign.YOffset = ent.YOffset
		Sign.ZOffset = ent.ZOffset
		net.Start("metrostroi-stool-signalling")
			net.WriteBool(true)
			net.WriteTable(Sign)
		net.Send(self:GetOwner())
	else
		if not ent then ent = ents.Create("gmod_track_signs") end
		if IsValid(ent) then
			if param ~= 2 then 
				ent:SetPos(tr.centerpos - tr.up * 9.5)
				ent:SetAngles((-tr.right):Angle() + Angle(0,90,0))
			end
			if not found then ent:Spawn() end
			ent.SignType = Sign.Type
			ent.YOffset = Sign.YOffset
			ent.ZOffset = Sign.ZOffset
			ent:SendUpdate()
		end
		return ent
	end
end

function TOOL:LeftClick(trace)
	if CLIENT then
		return true
	end
	
	--Signal = util.JSONToTable(self:GetClientInfo("signaldata"):replace("''","\""))	
	--if not Signal then return end
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local ent 
	if Type == 1 then
		ent = self:SpawnSignal(ply,trace)
	elseif Type == 2 then
		ent = self:SpawnSign(ply,trace)
	end

	-- Add to undo
	undo.Create("signalling")
		undo.AddEntity(ent)
		undo.SetPlayer(ply)
	undo.Finish()
	return true
end


function TOOL:RightClick(trace)
	if CLIENT then
		return true
	end

	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local entlist = ents.FindInSphere(trace.HitPos,64)
	for k,v in pairs(entlist) do
		if v:GetClass() == "gmod_track_signal" then
			if IsValid(v) then SafeRemoveEntity(v) end
		end
		if v:GetClass() == "gmod_track_switch" then
			if IsValid(v) then SafeRemoveEntity(v) end
		end
		if v:GetClass() == "gmod_track_signs" then
			if IsValid(v) then SafeRemoveEntity(v) end
		end
	end	
	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end
	--Signal = util.JSONToTable(self:GetClientInfo("signaldata"):replace("''","\""))								
	
	local ply = self:GetOwner()
	--if not (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end
	local ent 
	if Type == 1 then
		ent = self:SpawnSignal(ply,trace,2)
	elseif Type == 2 then
		ent = self:SpawnSign(ply,trace,2)
	end
	return true
end

function TOOL:SendSettings()
	if Type == 1 then
		if not Signal then return end
		RunConsoleCommand("signalling_signaldata",util.TableToJSON(Signal))
		net.Start "metrostroi-stool-signalling"
			net.WriteBool(false)
			--net.WriteEntity(self)
			net.WriteTable(Signal)
		net.SendToServer()

	elseif Type == 2 then
		if not Sign then return end
		RunConsoleCommand("signalling_signdata",util.TableToJSON(Sign))
		net.Start "metrostroi-stool-signalling"
			net.WriteBool(true)
			--net.WriteEntity(self)
			net.WriteTable(Sign)
		net.SendToServer()
	end
end

net.Receive("metrostroi-stool-signalling", function()
	if net.ReadBool() then
		Sign = net.ReadTable()
		if CLIENT then
			RunConsoleCommand("signalling_signdata",util.TableToJSON(Sign))
			NeedUpdate = true
		else
			Type = 2
		end
	else
		Signal = net.ReadTable()
		if CLIENT then
			RunConsoleCommand("signalling_signaldata",util.TableToJSON(Signal))
			NeedUpdate = true
		else
			Type = 1
		end
	end
end)

function TOOL:BuildCPanelCustom()
	local tool = self
	local CPanel = controlpanel.Get("signalling")
	if not CPanel then return end
	--("signalling_signaldata",util.TableToJSON(Signal))
	--Type = GetConVarNumber("signalling_type") or 1
	RouteType = GetConVarNumber("signalling_routetype") or 1
	CPanel:ClearControls()
	CPanel:SetPadding(0)
	CPanel:SetSpacing(0)
	CPanel:Dock( FILL )
	local VType = vgui.Create("DComboBox")
		VType:ChooseOption(Types[Type],Type)
		VType:SetColor(color_black)
		for i = 1,#Types do
			VType:AddChoice(Types[i])
		end
		VType.OnSelect = function(_, index, name)
			VType:SetValue(name)
			Type = index
			tool:SendSettings()
			tool:BuildCPanelCustom()
		end
	CPanel:AddItem(VType)
	if Type == 1 then
		local VSType = vgui.Create("DComboBox")
			VSType:ChooseOption(TypesOfSignal[Signal.Type or 1],Signal.Type or 1)
			VSType:SetColor(color_black)
			for i = 1,#TypesOfSignal do
				VSType:AddChoice(TypesOfSignal[i])
			end
			VSType.OnSelect = function(_, index, name)
				VSType:SetValue(name)
				Signal.Type = index
				tool:SendSettings()
			end
		CPanel:AddItem(VSType)
		local VNameT,VNameN = CPanel:TextEntry("Name:")
				VNameT:SetTooltip("Name. Letters or digits!\nFor example:IND2")
				VNameT:SetValue(Signal.Name or "")
				VNameT:SetEnterAllowed(false)
				function VNameT:OnChange()
					local oldval = self:GetValue()
					local pos = self:GetCaretPos()
					local NewValue = ""
					for i = 1,10 do
						NewValue = NewValue..((oldval[i] or ""):upper():match("[%u%d%s]") or "")
					end
					self:SetText(NewValue)
					self:SetCaretPos(pos < #NewValue and pos or #NewValue)
				end
				function VNameT:OnLoseFocus()
					Signal.Name = self:GetValue()
					tool:SendSettings()
				end
		if not Signal.ARSOnly then
			local VLensT,VLensN = CPanel:TextEntry("Lenses:")
				VLensT:SetTooltip("G - Green, Y - Yellow, R - Red, 	B - Blue, W - White, M - Routing Pointer\nExample: GYG-RW-M")
				VLensT:SetValue(Signal.Lenses or "")
				VLensT:SetEnterAllowed(false)
				function VLensT:OnChange()
					local NewValue = ""
					for i = 1,#self:GetValue() do
						NewValue = NewValue..((self:GetValue()[i] or ""):upper():match("[RYGWBM-]") or "")
					end
					local NewValueT = string.Explode("-",NewValue)
					for id,text in ipairs(NewValueT) do
						if id > 4 then
							for i = 5,#NewValueT do
								table.remove(NewValueT,i)
							end
							break
						end
						if text:find("M") then
							if text[1] == "M" then
								NewValueT[id] = "M"
							else
								NewValueT[id] = text:gsub("M","")
								id = id + 1
								NewValueT[id] = "M"
							end							
							for i = id+1,#NewValueT do
								table.remove(NewValueT, i)
							end
							break
						end
						text = text:match("[RYGWB]+") or ""
						local WFind = id==3 and text:find("W") or nil
						--print(MFind,id)
						if WFind then
							if text:find("M") then
								NewValueT[#NewValueT+1] = "M"
							end
								
							NewValueT[id] = "W"
						else
							NewValueT[id] = text:sub(1,3)
							if #text > 3 then
								NewValueT[#NewValueT+1] = text:sub(4,#text)
							end
						end
						--[[
						if MID > 0 then
							for i = MID,#NewValueT do
								table.remove(NewValueT,i)
							end
							break
						end]]
					end
					local NewValue = table.concat(NewValueT,"-")
					self:SetText(NewValue)
					self:SetCaretPos(#NewValue)
				end
				function VLensT:OnLoseFocus()
					Signal.Lenses = self:GetValue()
					tool:SendSettings()
				end
		end
			local VLeftC = CPanel:CheckBox("Left side")
					VLeftC:SetTooltip("Left side")
					VLeftC:SetValue(Signal.Left or false)
					function VLeftC:OnChange()
						Signal.Left = self:GetChecked()
						tool:SendSettings()
					end
		local VRouT,VRouN = CPanel:TextEntry("Route number:")
				VRouT:SetTooltip("Route number. Can be empty. One digit or D.\nFor example:D")
				VRouT:SetValue(Signal.RouteNumber or "")
				VRouT:SetEnterAllowed(false)
				function VRouT:OnChange()
					local oldval = self:GetValue()
					local NewValue = ""
					for i = 1,#oldval do
						if #NewValue > 0 then break end
						NewValue = NewValue..((oldval[i] or ""):upper():match("[%dD]") or "")
					end
					self:SetText(NewValue)
					self:SetCaretPos(0)
				end
				function VRouT:OnLoseFocus()
					Signal.RouteNumber = self:GetValue()
					tool:SendSettings()
				end
		local VIsoSC = CPanel:CheckBox("Isolating switches")
				VIsoSC:SetTooltip("Is signal isolate switch signals")
				VIsoSC:SetValue(Signal.IsolateSwitches or false)
				function VIsoSC:OnChange()
					Signal.IsolateSwitches = self:GetChecked()
					tool:SendSettings()
				end
		local VAppC = CPanel:CheckBox("325Hz on 0")
				VAppC:SetTooltip("Is signal will be issuse 325Hz(for PA-KSD) on zero?")
				VAppC:SetValue(Signal.Approve0 or false)
				function VAppC:OnChange()
					Signal.Approve0 = self:GetChecked()
					tool:SendSettings()
				end
		local VDepC = CPanel:CheckBox("Depot signal")
				VDepC:SetTooltip("Is signal go to depot?")
				VDepC:SetValue(Signal.Depot or false)
				function VDepC:OnChange()
					Signal.Depot = self:GetChecked()
					tool:SendSettings()
				end
		local VARSOC = CPanel:CheckBox("ARS Only")
				VARSOC:SetTooltip("ARS Box")
				VARSOC:SetValue(Signal.ARSOnly or false)
				function VARSOC:OnChange()
					Signal.ARSOnly = self:GetChecked()
					tool:SendSettings()
					tool:BuildCPanelCustom()
				end
		for i = 1,(Signal.Routes and #Signal.Routes or 0) do
			local CollCat = vgui.Create("DForm")
			CollCat:SetLabel(RouteTypes[Signal.Routes[i].Manual and 2 or Signal.Routes[i].Repeater and 3 or 1])
			CollCat:SetExpanded(1)
				local VTypeOfRouteI = vgui.Create("DComboBox")
					--VType:SetValue("Choose type")
					VTypeOfRouteI:ChooseOption(RouteTypes[Signal.Routes[i].Manual and 2 or Signal.Routes[i].Repeater and 3 or 1],Signal.Routes[i].Manual and 2 or Signal.Routes[i].Repeater and 3 or 1)
					for i1 = 1,#RouteTypes do
						VTypeOfRouteI:AddChoice(RouteTypes[i1])
					end
					VTypeOfRouteI.OnSelect = function(_, index, name)
						VTypeOfRouteI:SetValue(name)
						Signal.Routes[i].Manual = index == 2
						Signal.Routes[i].Repeater = index == 3
						tool:SendSettings()
						self:BuildCPanelCustom()
					end
				CollCat:AddItem(VTypeOfRouteI)
				local VRNT,VRNN = CollCat:TextEntry("Route name:")
					VRNT:SetText(Signal.Routes[i].RouteName or "")
					VRNT:SetTooltip("Route name.\nIt uses for !sopen or !sclose")
					function VRNT:OnLoseFocus()
						Signal.Routes[i].RouteName = self:GetValue()
						tool:SendSettings()
					end
				local VNexT,VNexN = CollCat:TextEntry("Next signal:")
					VNexT:SetText(Signal.Routes[i].NextSignal or "")
					VNexT:SetTooltip("Next signal. Name of the next signal.\nFor example:[113]IND2") 
					function VNexT:OnChange()
						local oldval = self:GetValue()
						local pos = self:GetCaretPos()
						local NewValue = ""
						for i = 1,10 do
							NewValue = NewValue..((oldval[i] or ""):upper():match("[%u%d%s]") or "")
						end
						self:SetText(NewValue)
						self:SetCaretPos(pos < #NewValue and pos or #NewValue)
					end
					function VNexT:OnLoseFocus()
						Signal.Routes[i].NextSignal = self:GetValue()
						tool:SendSettings()
					end
				if not Signal.ARSOnly then
					local VLighT,VLighN = CollCat:TextEntry("Lights:")
						VLighT:SetText(Signal.Routes[i].Lights or "")
						VLighT:SetTooltip("Numbers of lenses.\nFor example: for RGY:1-13-3-32-2 (R-RY-Y-YG-G)")
						function VLighT:OnLoseFocus()
							Signal.Routes[i].Lights = self:GetValue()
							tool:SendSettings()
						end
				end
				if not Signal.Routes[i].Repeater then
					local VARST,VARSN = CollCat:TextEntry("ARSCodes:")
						VARST:SetText(Signal.Routes[i].ARSCodes or "")
						VARST:SetTooltip("ARS Codes:0 - AS, 1 - OCh, 2 - 0, 4 - 40, 6 - 60, 7 - 70, 8 - 80\nFor example: 004678(0-0-40-60-70-80)") 
						function VARST:OnLoseFocus()
							Signal.Routes[i].ARSCodes = self:GetValue()
							tool:SendSettings()
						end
				end
				local VSwiT,VSwiN = CollCat:TextEntry("Switches:")
					VSwiT:SetText(Signal.Routes[i].Switches or "")
					VSwiT:SetTooltip("Switches. Next Switches + State. Can be empty(if no switches to next signal).\nFor example: 112+,114-,116+") 
					function VSwiT:OnLoseFocus()
						Signal.Routes[i].Switches = self:GetValue()
						tool:SendSettings()
					end
				local VRemoveR = CollCat:Button("Remove route")
				VRemoveR.DoClick = function()
					table.remove(Signal.Routes,i)
					tool:SendSettings()
					self:BuildCPanelCustom()
				end
			CPanel:AddItem(CollCat)
		end
		CPanel:AddItem(VAddPanel)
		local VTypeOfRoute = vgui.Create("DComboBox")
			--VType:SetValue("Choose type")
			VTypeOfRoute:ChooseOption(RouteTypes[RouteType],RouteType)
			VTypeOfRoute:SetColor(color_black)
			for i = 1,#RouteTypes do
				VTypeOfRoute:AddChoice(RouteTypes[i])
			end
			VTypeOfRoute.OnSelect = function(_, index, name)
				VTypeOfRoute:SetValue(name)
				RouteType = index
			end
		CPanel:AddItem(VTypeOfRoute)
		local VAddR = CPanel:Button("Add route")
		VAddR.DoClick = function()
			if not Signal.Routes then Signal.Routes = {} end
			table.insert(Signal.Routes,{Manual = RouteType==2, Repeater = RouteType == 3, RouteName = ""})
			tool:SendSettings()
			self:BuildCPanelCustom()
		end
	elseif Type == 2 then
		--local VNotF = vgui.Create("DLabel") VNotF:SetText("Not Finished yet!!")
		local VSType = vgui.Create("DComboBox")
			VSType:ChooseOption(TypesOfSign[Sign.Type or 1],Sign.Type or 1)
			VSType:SetColor(color_black)
			for i = 1,#TypesOfSign do
				VSType:AddChoice(TypesOfSign[i])
			end
			VSType.OnSelect = function(_, index, name)
				VSType:SetValue(name)
				Sign.Type = index
				tool:SendSettings()
			end
		CPanel:AddItem(VSType)
		local VYOffT = CPanel:NumSlider("Y Offset:",nil,-100,100,0)
			VYOffT:SetValue(Sign.YOffset or 0)
			VYOffT.OnValueChanged = function(num)
				Sign.YOffset = VYOffT:GetValue()
				tool:SendSettings()
			end
		local VZOffT = CPanel:NumSlider("Z Offset:",nil,-50,50,0)
			VZOffT:SetValue(Sign.ZOffset or 0)
			VZOffT.OnValueChanged = function(num)
				Sign.ZOffset = VZOffT:GetValue()
				tool:SendSettings()
			end
	end
end

TOOL.NotBuilt = true
function TOOL:Think()
	if CLIENT and (self.NotBuilt or NeedUpdate) then
		Signal = Signal or util.JSONToTable(string.Replace(GetConVarString("signalling_signaldata"),"'","\"")) or {}
		print(Signal)
		Sign = Sign or util.JSONToTable(string.Replace(GetConVarString("signalling_signdata"),"'","\"")) or {}
		self:SendSettings()
		self:BuildCPanelCustom()
		self.NotBuilt = nil
		NeedUpdate = nil
	end
end
function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", { Text = "#Tool.signalling.name", Description = "#Tool.signalling.desc" })
	if not self then return end
	self:BuildCPanelCustom()
end
