Citizen.CreateThread( function()
	while true do
	  Citizen.Wait(100)		
	  local playerPed = GetPlayerPed(-1)
	  local playerVeh = GetVehiclePedIsUsing(playerPed)
  
	  if playerVeh ~= 0 then 
		RemovePedHelmet(playerPed,true) end
	end	
  end)