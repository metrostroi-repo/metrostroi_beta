if CLIENT then return end
local workshopid = {
	261801217,
	489006102,
	596708362,
	625762942,
}
print("-Starting adding metrostroi workshop addons...")
print("-Workshop addons in base:"..#workshopid)
for k,v in pairs(workshopid) do
	resource.AddWorkshop(tostring(v))
	print("--Added a "..v.." workshop addon.")
end
print("-End of adding workshop addons...")
