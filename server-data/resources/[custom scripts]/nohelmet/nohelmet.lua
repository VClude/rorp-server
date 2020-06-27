Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)		--Edit this if the resource is using too much resources.   
    local playerVeh = GetVehiclePedIsUsing(player)
    if PlayerVeh ~= 0 then SetPedConfigFlag(player, 35, false) end
  end	
end)