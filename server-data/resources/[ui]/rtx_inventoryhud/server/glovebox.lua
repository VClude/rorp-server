Citizen.CreateThread(function()
    TriggerEvent('rtx_inventoryhud:RegisterInventory', {
        name = 'glovebox',
        label = _U('glove'),
        slots = 15,
        maxweight = Config.GloveboxMaxWeight
    })
end)
