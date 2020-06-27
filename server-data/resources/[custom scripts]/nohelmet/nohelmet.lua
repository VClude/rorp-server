Citizen.CreateThread( function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		print('ada di dalam kendaraan')
	end
	-- local playerPed = GetPlayerPed(-1)
	-- local playerVeh = GetVehiclePedIsUsing(playerPed)
	-- 	if playerVeh ~= 0 then 
	-- 		RemovePedHelmet(playerPed,true) 

	-- 	end
end)