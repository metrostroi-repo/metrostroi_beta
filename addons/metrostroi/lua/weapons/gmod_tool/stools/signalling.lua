TOOL.Category   = "Metro"
TOOL.Name       = "Signalling Tool"
TOOL.Command    = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["signaldata"] = ""
TOOL.ClientConVar["signdata"] = ""
TOOL.ClientConVar["type"] = 1
TOOL.ClientConVar["routetype"] = 1

if SERVER then util.AddNetworkString "metrostroi-stool-signalling" end


local Types = {"Signal","Sign",[0] = "Choose Type"}
local TypesOfSignal = {"Inside","Outside big","Outside small"}
local TypesOfSign = {"NF","40","60","70","80","Station border","C(horn) Street","STOP Street","Dangerous","Deadlock",
	"Stop marker","!(stop)","X","T Start","T End","T Sbor(engage)","Engines off","Engines on","C(horn)","T stop emer","Shod",
	"Left doors","Phone▲","Phone▼","1up","STOP Street cyka","NF outside","35 outside","40 outside","60 outside","70 outside","80 outside",
	"T Sbor(engage) outside","35","Dangerous 200","CR End","CR End(inv)","2up","3up","4up","5up","6up","X outside", "Metal"}
local RouteTypes = {"Auto", "Manual","Repeater","Emerg"}
TOOL.Type = 0
TOOL.RouteType = 1

--TOOL.Signal.Type = 1

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
	-- Create self.Signal entity
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
		self.Signal.Type = ent.SignalType + 1
		self.Signal.Name = ent.Name
		self.Signal.Lenses = ent.LensesStr
		self.Signal.RouteNumber =	ent.RouteNumber
		self.Signal.RouteNumberSetup =	ent.RouteNumberSetup
		self.Signal.IsolateSwitches = ent.IsolateSwitches
		self.Signal.Approve0 = ent.Approve0
		self.Signal.Depot = ent.Depot
		self.Signal.ARSOnly = ent.ARSOnly
		self.Signal.NonAutoStop = ent.NonAutoStop
		self.Signal.PassOcc = ent.PassOcc
		self.Signal.Routes = ent.Routes
		self.Signal.Left = ent.Left
		self.Signal.Double = ent.Double
		self.Signal.DoubleL = ent.DoubleL
		net.Start("metrostroi-stool-signalling")
			net.WriteBool(false)
			net.WriteTable(self.Signal)
		net.Send(self:GetOwner())
	else
		if not ent then ent = ents.Create("gmod_track_signal") end
		if IsValid(ent) then
			if param ~= 2 then
				ent:SetPos(tr.centerpos - tr.up * 9.5)
				ent:SetAngles((-tr.right):Angle() + Angle(0,0,0))
			end
			if not found then ent:Spawn() end
			ent.SignalType = self.Signal.Type-1
			ent.ARSOnly = self.Signal.ARSOnly
			ent.Name = self.Signal.Name
			ent.LensesStr = self.Signal.Lenses
			ent.RouteNumber =	self.Signal.RouteNumber
			ent.RouteNumberSetup =	self.Signal.RouteNumberSetup
			ent.IsolateSwitches = self.Signal.IsolateSwitches
			ent.Approve0 = self.Signal.Approve0
			ent.NonAutoStop = self.Signal.NonAutoStop
			ent.Depot = self.Signal.Depot
			ent.Routes = self.Signal.Routes
			ent.Left = self.Signal.Left
			ent.Double = self.Signal.Double
			ent.DoubleL = self.Signal.DoubleL
			ent.Lenses = string.Explode("-",ent.LensesStr)
			ent.PassOcc = self.Signal.PassOcc
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
	-- Create self.Sign entity
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
		self.Sign.Type = ent.SignType
		self.Sign.YOffset = ent.YOffset
		self.Sign.ZOffset = ent.ZOffset
		self.Sign.Left = ent.Left
		net.Start("metrostroi-stool-signalling")
			net.WriteBool(true)
			net.WriteTable(self.Sign)
		net.Send(self:GetOwner())
	else
		if not ent then ent = ents.Create("gmod_track_signs") end
		if IsValid(ent) then
			if param ~= 2 then
				ent:SetPos(tr.centerpos - tr.up * 9.5)
				ent:SetAngles((-tr.right):Angle() + Angle(0,90,0))
			end
			if not found then ent:Spawn() end
			ent.SignType = self.Sign.Type
			ent.YOffset = self.Sign.YOffset
			ent.ZOffset = self.Sign.ZOffset
			ent.Left = self.Sign.Left
			ent:SendUpdate()
		end
		return ent
	end
end

function TOOL:LeftClick(trace)
	if CLIENT then
		return true
	end

	--self.Signal = util.JSONToTable(self:GetClientInfo("signaldata"):replace("''","\""))
	--if not self.Signal then return end
	local ply = self:GetOwner()
	if (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end

	local ent
	if self.Type == 1 then
		ent = self:SpawnSignal(ply,trace)
	elseif self.Type == 2 then
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
	--self.Signal = util.JSONToTable(self:GetClientInfo("signaldata"):replace("''","\""))

	local ply = self:GetOwner()
	--if not (ply:IsValid()) and (not ply:IsAdmin()) then return false end
	if not trace then return false end
	if trace.Entity and trace.Entity:IsPlayer() then return false end
	local ent
	if self.Type == 1 then
		ent = self:SpawnSignal(ply,trace,2)
	elseif self.Type == 2 then
		ent = self:SpawnSign(ply,trace,2)
	end
	return true
end

function TOOL:SendSettings()
	if self.Type == 1 then
		if not self.Signal then return end
		RunConsoleCommand("signalling_signaldata",util.TableToJSON(self.Signal))
		net.Start "metrostroi-stool-signalling"
			net.WriteBool(false)
			--net.WriteEntity(self)
			net.WriteTable(self.Signal)
		net.SendToServer()

	elseif self.Type == 2 then
		if not self.Sign then return end
		RunConsoleCommand("signalling_signdata",util.TableToJSON(self.Sign))
		net.Start "metrostroi-stool-signalling"
			net.WriteBool(true)
			--net.WriteEntity(self)
			net.WriteTable(self.Sign)
		net.SendToServer()
	end
end

net.Receive("metrostroi-stool-signalling", function(_, ply)
	local TOOL = LocalPlayer and LocalPlayer():GetTool("signalling") or ply:GetTool("signalling")
	if net.ReadBool() then
		TOOL.Sign = net.ReadTable()
		if CLIENT then
			RunConsoleCommand("signalling_signdata",util.TableToJSON(TOOL.Sign))
			NeedUpdate = true
		else
			TOOL.Type = 2
		end
	else
		TOOL.Signal = net.ReadTable()
		if CLIENT then
			RunConsoleCommand("signalling_signaldata",util.TableToJSON(TOOL.Signal))
			NeedUpdate = true
		else
			TOOL.Type = 1
		end
	end
end)

function TOOL:BuildCPanelCustom()
	local tool = self
	local CPanel = controlpanel.Get("signalling")
	if not CPanel then return end
	--("signalling_signaldata",util.TableToJSON(tool.Signal))
	--tool.Type = GetConVarNumber("signalling_type") or 1
	tool.RouteType = GetConVarNumber("signalling_routetype") or 1
	CPanel:ClearControls()
	CPanel:SetPadding(0)
	CPanel:SetSpacing(0)
	CPanel:Dock( FILL )
	local VType = vgui.Create("DComboBox")
		VType:ChooseOption(Types[tool.Type],tool.Type)
		VType:SetColor(color_black)
		for i = 1,#Types do
			VType:AddChoice(Types[i])
		end
		VType.OnSelect = function(_, index, name)
			VType:SetValue(name)
			tool.Type = index
			tool:SendSettings()
			tool:BuildCPanelCustom()
		end
	CPanel:AddItem(VType)
	if tool.Type == 1 then
		local VSType = vgui.Create("DComboBox")
			VSType:ChooseOption(TypesOfSignal[tool.Signal.Type or 1],tool.Signal.Type or 1)
			VSType:SetColor(color_black)
			for i = 1,#TypesOfSignal do
				VSType:AddChoice(TypesOfSignal[i])
			end
			VSType.OnSelect = function(_, index, name)
				VSType:SetValue(name)
				tool.Signal.Type = index
				tool:SendSettings()
			end
		CPanel:AddItem(VSType)
		local VNameT,VNameN = CPanel:TextEntry("Name:")
				VNameT:SetTooltip("Name. Letters or digits!\nFor example:IND2")
				VNameT:SetValue(tool.Signal.Name or "")
				VNameT:SetEnterAllowed(false)
				function VNameT:OnChange()
					local oldval = self:GetValue()
					local pos = self:GetCaretPos()
					local NewValue = ""
					for i = 1,10 do
						NewValue = NewValue..((oldval[i] or ""):upper():match("^[%u%d%s/]+") or "")
					end
					self:SetText(NewValue)
					self:SetCaretPos(pos < #NewValue and pos or #NewValue)
				end
				function VNameT:OnLoseFocus()
					tool.Signal.Name = self:GetValue()
					tool:SendSettings()
				end
		if not tool.Signal.ARSOnly then
			local VLensT,VLensN = CPanel:TextEntry("Lenses:")
				VLensT:SetTooltip("G - Green, Y - Yellow, R - Red, 	B - Blue, W - White, M - Routing Pointer\nExample: GYG-RW-M")
				VLensT:SetValue(tool.Signal.Lenses or "")
				VLensT:SetEnterAllowed(false)
				function VLensT:OnChange()
					local NewValue = ""
					for i = 1,#self:GetValue() do
						NewValue = NewValue..((self:GetValue()[i] or ""):upper():match("[RYGWBM-]") or "")
					end
					local NewValueT = string.Explode("-",NewValue)
					local maxval = tool.Signal.Type == 3 and 4 or 3
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
						--[[local WFind = id==3 and text:find("W") or nil
						--print(MFind,id)
						if WFind then
							if text:find("M") then
								NewValueT[#NewValueT+1] = "M"
							end

							NewValueT[id] = "W"
						else]]
							NewValueT[id] = text:sub(1,maxval)
							if #text > maxval then
								NewValueT[#NewValueT+1] = text:sub(maxval+1,#text)
							end
						--end
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
					tool.Signal.Lenses = self:GetValue()
					tool:SendSettings()
				end
		end
		if tool.Signal.Type == 1 then
			local VRoutT,VRoutN = CPanel:TextEntry("Custom route number:")
				VRoutT:SetTooltip("Custom routte number. Can be empty. For example:12WK")
				VRoutT:SetValue(tool.Signal.RouteNumberSetup or "")
				VRoutT:SetEnterAllowed(false)
				function VRoutT:OnChange()
					local oldval = self:GetValue()
					local NewValue = ""
					for i = 1,#oldval do
						NewValue = NewValue..((oldval[i] or ""):upper():match("[1-4DWKFLRX]+") or "")
					end
					local oldpos = self:GetCaretPos()
					self:SetText(NewValue:sub(1,5))
					self:SetCaretPos(math.min(5,oldpos))
				end
				function VRoutT:OnLoseFocus()
					tool.Signal.RouteNumberSetup = self:GetValue()
					tool:SendSettings()
				end
			end
			local VLeftC = CPanel:CheckBox("Left side")
					VLeftC:SetTooltip("Left side")
					VLeftC:SetValue(tool.Signal.Left or false)
					function VLeftC:OnChange()
						tool.Signal.Left = self:GetChecked()
						tool:SendSettings()
					end
			local VDoubleC = CPanel:CheckBox("Double side")
			if tool.Signal.Double then
				local VDoubleLC = CPanel:CheckBox("Double light")
					VDoubleLC:SetTooltip("DoubleL light")
					VDoubleLC:SetValue(tool.Signal.DoubleL or false)
					function VDoubleLC:OnChange()
						tool.Signal.DoubleL = self:GetChecked() and tool.Signal.Double
						self:SetChecked(tool.Signal.DoubleL)
						tool:SendSettings()
					end
			end
					VDoubleC:SetTooltip("Double side")
					VDoubleC:SetValue(tool.Signal.Double or false)
					function VDoubleC:OnChange()
						tool.Signal.Double = self:GetChecked()
						tool.Signal.DoubleL = tool.Signal.DoubleL and self:GetChecked()
						tool:BuildCPanelCustom()
						--if tool.Signal.Double then VDoubleLC:SetChecked(tool.Signal.DoubleL and tool.Signal.Double) end
						tool:SendSettings()
					end
		local VRouT,VRouN = CPanel:TextEntry("Route number:")
				VRouT:SetTooltip("Route number. Can be empty. One digit or D.\nFor example:D")
				VRouT:SetValue(tool.Signal.RouteNumber or "")
				VRouT:SetEnterAllowed(false)
				function VRouT:OnChange()
					local oldval = self:GetValue()
					local NewValue = ""
					for i = 1,#oldval do
						if #NewValue > 0 then break end
						NewValue = NewValue..((oldval[i] or ""):upper():match(tool.Signal.Type == 1 and "[%dDFLR]" or "[%dD]") or "")
					end
					self:SetText(NewValue)
					self:SetCaretPos(0)
				end
				function VRouT:OnLoseFocus()
					tool.Signal.RouteNumber = self:GetValue()
					tool:SendSettings()
				end
		local VIsoSC = CPanel:CheckBox("Isolating switches")
				VIsoSC:SetTooltip("Is tool.Signal isolate switch signals")
				VIsoSC:SetValue(tool.Signal.IsolateSwitches or false)
				function VIsoSC:OnChange()
					tool.Signal.IsolateSwitches = self:GetChecked()
					tool:SendSettings()
				end
		local VAppC = CPanel:CheckBox("325Hz on 0")
				VAppC:SetTooltip("Is tool.Signal will be issuse 325Hz(for PA-KSD) on zero?")
				VAppC:SetValue(tool.Signal.Approve0 or false)
				function VAppC:OnChange()
					tool.Signal.Approve0 = self:GetChecked()
					tool:SendSettings()
				end
		local VAuStC = CPanel:CheckBox("Autostop")
				VAuStC:SetTooltip("Is autostop present or no?")
				if tool.Signal.NonAutoStop ~= nil then
					VAuStC:SetValue(not tool.Signal.NonAutoStop)
				else
					VAuStC:SetValue(true)
				end
				function VAuStC:OnChange()
					tool.Signal.NonAutoStop = not self:GetChecked()
					tool:SendSettings()
				end
		local VDepC = CPanel:CheckBox("Depot Signal")
				VDepC:SetTooltip("Is Signal go to depot?")
				VDepC:SetValue(tool.Signal.Depot or false)
				function VDepC:OnChange()
					tool.Signal.Depot = self:GetChecked()
					tool:SendSettings()
				end
		local VARSOC = CPanel:CheckBox("ARS Only")
				VARSOC:SetTooltip("ARS Box")
				VARSOC:SetValue(tool.Signal.ARSOnly or false)
				function VARSOC:OnChange()
					tool.Signal.ARSOnly = self:GetChecked()
					tool:SendSettings()
					tool:BuildCPanelCustom()
				end
		local VPassOccC = CPanel:CheckBox("Pass occupation singal")
				VPassOccC:SetTooltip("Pass occupation singal")
				VPassOccC:SetValue(tool.Signal.PassOcc or false)
				function VPassOccC:OnChange()
					tool.Signal.PassOcc = self:GetChecked()
					tool:SendSettings()
					--tool:BuildCPanelCustom()
				end

		for i = 1,(tool.Signal.Routes and #tool.Signal.Routes or 0) do
			local CollCat = vgui.Create("DForm")
			local rou = tool.Signal.Routes[i].Manual and 2 or tool.Signal.Routes[i].Repeater and 3 or tool.Signal.Routes[i].Emer and 4 or 1
			CollCat:SetLabel(RouteTypes[rou])
			CollCat:SetExpanded(1)
				local VTypeOfRouteI = vgui.Create("DComboBox")
					--VType:SetValue("Choose tool.Type")
					VTypeOfRouteI:ChooseOption(RouteTypes[rou],rou)
					for i1 = 1,#RouteTypes do
						VTypeOfRouteI:AddChoice(RouteTypes[i1])
					end
					VTypeOfRouteI.OnSelect = function(_, index, name)
						VTypeOfRouteI:SetValue(name)
						tool.Signal.Routes[i].Manual = index == 2
						tool.Signal.Routes[i].Repeater = index == 3
						tool.Signal.Routes[i].Emer = index == 4
						tool:SendSettings()
						self:BuildCPanelCustom()
					end
				CollCat:AddItem(VTypeOfRouteI)
				local VRNT,VRNN = CollCat:TextEntry("Route name:")
					VRNT:SetText(tool.Signal.Routes[i].RouteName or "")
					VRNT:SetTooltip("Route name.\nIt uses for !sopen or !sclose")
					function VRNT:OnLoseFocus()
						tool.Signal.Routes[i].RouteName = self:GetValue()
						tool:SendSettings()
					end
				local VNexT,VNexN = CollCat:TextEntry("Next Signal:")
					VNexT:SetText(tool.Signal.Routes[i].NextSignal or "")
					VNexT:SetTooltip("Next Signal. Name of the next Signal.\nFor example:[113]IND2")
					function VNexT:OnChange()
						local oldval = self:GetValue()
						local pos = self:GetCaretPos()
						local NewValue = ""
						for i = 1,10 do
							NewValue = NewValue..((oldval[i] or ""):upper():match("[%u%d%s%*]") or "")
						end
						self:SetText(NewValue)
						self:SetCaretPos(pos < #NewValue and pos or #NewValue)
					end
					function VNexT:OnLoseFocus()
						tool.Signal.Routes[i].NextSignal = self:GetValue()
						tool:SendSettings()
					end
				if not tool.Signal.ARSOnly then
					local VLighT,VLighN = CollCat:TextEntry("Lights:")
						VLighT:SetText(tool.Signal.Routes[i].Lights or "")
						VLighT:SetTooltip("Numbers of lenses.\nFor example: for RGY:1-13-3-32-2 (R-RY-Y-YG-G)")
						function VLighT:OnLoseFocus()
							tool.Signal.Routes[i].Lights = self:GetValue()
							tool:SendSettings()
						end
				end
				if not tool.Signal.Routes[i].Repeater then
					local VARST,VARSN = CollCat:TextEntry("ARSCodes:")
						VARST:SetText(tool.Signal.Routes[i].ARSCodes or "")
						VARST:SetTooltip("ARS Codes:0 - AS, 1 - OCh, 2 - 0, 4 - 40, 6 - 60, 7 - 70, 8 - 80\nFor example: 004678(0-0-40-60-70-80)")
						function VARST:OnLoseFocus()
							tool.Signal.Routes[i].ARSCodes = self:GetValue()
							tool:SendSettings()
						end
				end
				local VSwiT,VSwiN = CollCat:TextEntry("Switches:")
					VSwiT:SetText(tool.Signal.Routes[i].Switches or "")
					VSwiT:SetTooltip("Switches. Next Switches + State. Can be empty(if no switches to next tool.Signal).\nFor example: 112+,114-,116+")
					function VSwiT:OnLoseFocus()
						tool.Signal.Routes[i].Switches = self:GetValue()
						tool:SendSettings()
					end
				local VEnRouC = CollCat:CheckBox("Enable route number")
						VEnRouC:SetTooltip("Enable route number(when disabled route number enables only with invation signal)")
						VEnRouC:SetValue(tool.Signal.Routes[i].EnRou or false)
						function VEnRouC:OnChange()
							tool.Signal.Routes[i].EnRou = self:GetChecked()
							tool:SendSettings()
							--tool:BuildCPanelCustom()
						end
				local VRemoveR = CollCat:Button("Remove route")
				VRemoveR.DoClick = function()
					table.remove(tool.Signal.Routes,i)
					tool:SendSettings()
					self:BuildCPanelCustom()
				end
			CPanel:AddItem(CollCat)
		end
		CPanel:AddItem(VAddPanel)
		local VTypeOfRoute = vgui.Create("DComboBox")
			--VType:SetValue("Choose tool.Type")
			VTypeOfRoute:ChooseOption(RouteTypes[tool.RouteType],tool.RouteType)
			VTypeOfRoute:SetColor(color_black)
			for i = 1,#RouteTypes do
				VTypeOfRoute:AddChoice(RouteTypes[i])
			end
			VTypeOfRoute.OnSelect = function(_, index, name)
				VTypeOfRoute:SetValue(name)
				tool.RouteType = index
			end
		CPanel:AddItem(VTypeOfRoute)
		local VAddR = CPanel:Button("Add route")
		VAddR.DoClick = function()
			if not tool.Signal.Routes then tool.Signal.Routes = {} end
			table.insert(tool.Signal.Routes,{Manual = tool.RouteType==2, Repeater = tool.RouteType == 3, Emer = tool.RouteType == 4, RouteName = ""})
			tool:SendSettings()
			self:BuildCPanelCustom()
		end
	elseif tool.Type == 2 then
		--local VNotF = vgui.Create("DLabel") VNotF:SetText("Not Finished yet!!")
		local VSType = vgui.Create("DComboBox")
			VSType:ChooseOption(TypesOfSign[tool.Sign.Type or 1],tool.Sign.Type or 1)
			VSType:SetColor(color_black)
			for i = 1,#TypesOfSign do
				VSType:AddChoice(TypesOfSign[i])
			end
			VSType.OnSelect = function(_, index, name)
				VSType:SetValue(name)
				tool.Sign.Type = index
				tool:SendSettings()
			end
		CPanel:AddItem(VSType)
		local VYOffT = CPanel:NumSlider("Y Offset:",nil,-100,100,0)
			VYOffT:SetValue(tool.Sign.YOffset or 0)
			VYOffT.OnValueChanged = function(num)
				tool.Sign.YOffset = VYOffT:GetValue()
				tool:SendSettings()
			end
		local VZOffT = CPanel:NumSlider("Z Offset:",nil,-50,50,0)
			VZOffT:SetValue(tool.Sign.ZOffset or 0)
			VZOffT.OnValueChanged = function(num)
				tool.Sign.ZOffset = VZOffT:GetValue()
				tool:SendSettings()
			end
		local VLeftOC = CPanel:CheckBox("Left side(if can be left-side)")
				VLeftOC:SetTooltip("Left side")
				VLeftOC:SetValue(tool.Sign.Left or false)
				function VLeftOC:OnChange()
					tool.Sign.Left = self:GetChecked()
					tool:SendSettings()
					tool:BuildCPanelCustom()
				end
	end
end

TOOL.NotBuilt = true
function TOOL:Think()
	if CLIENT and (self.NotBuilt or NeedUpdate) then
		self.Signal = self.Signal or util.JSONToTable(string.Replace(GetConVarString("signalling_signaldata"),"'","\"")) or {}
		print(self.Signal)
		self.Sign = self.Sign or util.JSONToTable(string.Replace(GetConVarString("signalling_signdata"),"'","\"")) or {}
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
