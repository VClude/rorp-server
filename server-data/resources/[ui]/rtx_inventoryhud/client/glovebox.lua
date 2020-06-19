local gloveBoxSecondaryInventory = {
    type = 'glovebox',
    owner = 'XYZ123'
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsControlJustReleased(0, Config.TrunkOpenControl) and IsPedInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed)
            if DoesEntityExist(vehicle) then
                gloveBoxSecondaryInventory.owner = GetVehicleNumberPlateText(vehicle)
                openInventory(gloveBoxSecondaryInventory)
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "GloveBox", 00.90)
            end
        end
    end
end
)