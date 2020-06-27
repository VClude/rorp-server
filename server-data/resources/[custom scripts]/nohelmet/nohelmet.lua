Citizen.CreateThread( function()
	while true do
		Citizen.Wait(0)		--Edit this if the resource is using too much resources.  
		local player = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsUsing(player)
		if playerVeh ~= 0 then SetPedConfigFlag(player, 35, false) end
	end	
end)