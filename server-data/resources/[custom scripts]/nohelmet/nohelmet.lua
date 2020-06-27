Citizen.CreateThread( function()
	for i = 0, i <= 10 do
		print(PlayerPedId())
		i = i + 1
	end
	
	-- local playerPed = GetPlayerPed(-1)
	-- local playerVeh = GetVehiclePedIsUsing(playerPed)
	-- 	if playerVeh ~= 0 then 
	-- 		RemovePedHelmet(playerPed,true) 

	-- 	end
end)