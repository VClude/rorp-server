Citizen.CreateThread( function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		print('Local player is in a vehicle!')
	end
	-- local playerPed = GetPlayerPed(-1)
	-- local playerVeh = GetVehiclePedIsUsing(playerPed)
	-- 	if playerVeh ~= 0 then 
	-- 		RemovePedHelmet(playerPed,true) 

	-- 	end
end)