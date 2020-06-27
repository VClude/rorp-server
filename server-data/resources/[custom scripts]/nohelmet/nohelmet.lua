Citizen.CreateThread( function()
	while true do
	  Citizen.Wait(100)		
	  local playerPed = GetPlayerPed(-1)
	  local playerVeh = GetVehiclePedIsUsing(playerPed)
	
		if playerVeh ~= 0 then 
			RemovePedHelmet(playerPed,true) 
			SetPedConfigFlag(GetPlayerPed(-1), 35, false)
		end
	end	
end)