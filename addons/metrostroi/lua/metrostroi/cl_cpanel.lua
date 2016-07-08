--Helper function for common use
local function AddBox(panel,cmd,str)
	panel:AddControl("CheckBox",{Label=str, Command=cmd})
end

-- Build admin panel
local function AdminPanel(panel)
	if not LocalPlayer():IsAdmin() then return end
	AddBox(panel,"metrostroi_train_requirethirdrail","Trains require 3rd rail")
	--panel:AddControl("CheckBox",{Label="Trains require 3rd rail", Command = "metrostroi_train_requirethirdrail"})

end


-- Build regular client panel
local function ClientPanel(panel)
	AddBox(panel,"metrostroi_drawdebug","Draw debugging info")
	AddBox(panel,"metrostroi_disablecamaccel","Disable cam acceleration")
	AddBox(panel,"metrostroi_disablehovertext","Disable hover text")
	--panel:AddControl("Checkbox",{Label="Draw debugging info", Command = "metrostroi_drawdebug"})
end

hook.Add("PopulateToolMenu", "Metrostroi cpanel", function()
	spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_admin_panel", "Admin", "", "", AdminPanel)
	spawnmenu.AddToolMenuOption("Utilities", "Metrostroi", "metrostroi_client_panel", "Client", "", "", ClientPanel)
end)
