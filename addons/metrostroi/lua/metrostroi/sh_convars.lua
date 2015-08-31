-- FIXME hack
function Metrostroi.GetEnergyCost(kWh)
	return kWh*0.08
end


--Not sure about the quirks related to shared convars like this
CreateConVar("metrostroi_train_requirethirdrail",1,FCVAR_ARCHIVE,"Whether or not Metrostroi trains require power from the third rail")
CreateConVar("metrostroi_debugger_update_interval",1,FCVAR_ARCHIVE,"Seconds between debugger data messages")

CreateConVar("metrostroi_passengers_scale",50,FCVAR_ARCHIVE)
CreateConVar("metrostroi_arsmode",1,FCVAR_ARCHIVE)
CreateConVar("metrostroi_arsmode_nogreen",0,FCVAR_ARCHIVE)
CreateConVar("metrostroi_write_telemetry",0,FCVAR_ARCHIVE)

CreateConVar("metrostroi_voltage",750,FCVAR_ARCHIVE)
CreateConVar("metrostroi_current_limit",4000,FCVAR_ARCHIVE)
CreateConVar("metrostroi_ars_sfreq",1,FCVAR_ARCHIVE,"Enable second freq.")


if SERVER then
	CreateConVar("metrostroi_ars_printnext",0,FCVAR_NONE,"Prints next signal to console on wagon with entered number")
	return
end

CreateClientConVar("metrostroi_stop_helper",0,true)

CreateClientConVar("metrostroi_drawdebug",0,true)
CreateClientConVar("metrostroi_disablecamaccel",0,true)
CreateClientConVar("metrostroi_debugger_data_timeout",2,true,false)

CreateClientConVar("metrostroi_tooltip_delay",0,true)