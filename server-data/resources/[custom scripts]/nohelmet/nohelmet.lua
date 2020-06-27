Citizen.CreateThread( function()
	while true do	
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsUsing(playerPed)
			if playerVeh ~= 0 then
				print(playerVeh)
			end
	end
end)