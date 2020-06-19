Citizen.CreateThread(function()
    for k, v in pairs(Config.VehicleLimit) do
        TriggerEvent('rtx_inventoryhud:RegisterInventory', {
            name = 'trunk-' .. string.upper(k),
            label = k,
            slots = v,
            maxweight = Config.VehicleWeight2[k]
        })
    end
    for k,v in pairs(Config.VehicleSlot) do
        TriggerEvent('rtx_inventoryhud:RegisterInventory', {
            name = 'trunk-' .. k,
            label = _U('trunk') .. k,
            slots = v,
            maxweight = Config.VehicleWeight[k]
        })
    end
end)
