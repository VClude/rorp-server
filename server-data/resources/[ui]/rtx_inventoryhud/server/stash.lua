Citizen.CreateThread(function()
    TriggerEvent('rtx_inventoryhud:RegisterInventory', {
        name = 'stash',
        label = _U('stash'),
        slots = 650,
        maxweight = Config.StashMaxWeight
    })
end)
