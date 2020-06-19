Citizen.CreateThread(function()
    TriggerEvent('rtx_inventoryhud:RegisterInventory', {
        name = 'cupboard',
        label = 'Storage',
        slots = 20,
		maxweight = 200
    })
end)