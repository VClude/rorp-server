local busy = false

function OpenGarage(property)

    local options = {
        { label = 'Store the vehicle in the garage', action = function()
            local playerPed = GetPlayerPed(-1)
            if IsPedInAnyVehicle(playerPed) then
                StoreVehicle(GetVehiclePedIsIn(playerPed), property.name)
            else
                exports['mythic_notify']:SendAlert('error', 'You are not in the vehicle')
            end
            ESX.UI.Menu.CloseAll()
        end },
        { label = 'Spawnout vehicle', action = function()
            if ESX.Game.IsSpawnPointClear(property.garage.coords, 3.0) then
                ESX.TriggerServerCallback('rtx_property:getStoredVehicles', function(results)
                    local options = {}
                    for k, v in pairs(results) do
                        local props = json.decode(v.props)
                        local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
                        local label = ('%s - <span style="color:#FFFFFF;">%s</span>'):format(vehicleName, props.plate)
                        table.insert(options, {
                            label = label,
                            action = function()
                                SpawnVehicle(property.garage.coords, property.garage.heading, props)
                                ESX.UI.Menu.CloseAll()
                            end
                        })
                    end
                    local menu = {
                        name = 'garage_vehicles',
                        title = 'Garage',
                        options = options
                    }
                    TriggerEvent('rtx_core:openMenu', menu)
                end, property.name)
            else
                exports['mythic_notify']:SendAlert('error', 'There is no space for a vehicle in front of the garage!')
            end
        end },
    }

    local menu = {
        name = 'garage',
        title = 'Garage',
        options = options
    }
    TriggerEvent('rtx_core:openMenu', menu)

end

function StoreVehicle(vehicle, propertyName)

    local props = ESX.Game.GetVehicleProperties(vehicle)
    ESX.TriggerServerCallback('rtx_property:storeVehicle', function(stored)
        if stored == 'stored' then
            local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
            local label = ('%s - <span style="color:FF66FF;;">%s</span>'):format(vehicleName, props.plate)
            ESX.Game.DeleteVehicle(vehicle)
            exports['mythic_notify']:SendAlert('success', 'Vehicle '..label.. ' stored in the garage')
        elseif stored == 'notowned' then
            exports['mythic_notify']:SendAlert('error', 'You do not own this vehicle')
        elseif stored == 'max' then
            exports['mythic_notify']:SendAlert('error', 'You have exceeded the capacity of the vehicles in the garage')
        end
        busy = false
    end, propertyName, props)
end

function SpawnVehicle(garageCoords, heading, props)

    local playerPed = GetPlayerPed(-1)
    local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
    local label = ('%s - <span style="color:#FF66FF;">%s</span>'):format(vehicleName, props.plate)
    ESX.TriggerServerCallback('rtx_property:spawnVehicle', function(spawned)
        if spawned then
            ESX.Game.SpawnVehicle(props.model, garageCoords, heading, function(vehicle)
                ESX.Game.SetVehicleProperties(vehicle, props)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                exports['mythic_notify']:SendAlert('success', 'vehicle  '.. label..' spawnout')
                busy = false
            end)
        end
    end
    , props.plate)
end
