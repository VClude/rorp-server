local drops = {}

Citizen.CreateThread(function()
    TriggerEvent('rtx_inventoryhud:RegisterInventory', {
        name = 'drop',
        label = _U('drop'),
        slots = 50,
        maxweight = 1000
    })
end)

MySQL.ready(function()
    if Config.DeleteDropsOnStart then
        MySQL.Async.execute('DELETE FROM rtx_inventory WHERE type = \'drop\'')
    end
end)

function updateDrops()
    MySQL.Async.fetchAll('SELECT * FROM rtx_inventory WHERE type = \'drop\'', {}, function(results)
        drops = {}
        for k, v in pairs(results) do
            drops[v.owner] = json.decode(v.data)
        end
        TriggerClientEvent('rtx_inventoryhud:updateDrops', -1, drops)
    end)
end

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    updateDrops()
end)

AddEventHandler('esx:playerLoaded', function(data)
    Citizen.Wait(0)
    updateDrops()
end)

RegisterServerEvent('rtx_inventoryhud:modifiedInventory')
AddEventHandler('rtx_inventoryhud:modifiedInventory', function(identifier, type, data)
    if type == 'drop' then
        drops[identifier] = data
        TriggerClientEvent('rtx_inventoryhud:updateDrops', -1, drops)
    end
end)

RegisterServerEvent('rtx_inventoryhud:savedInventory')
AddEventHandler('rtx_inventoryhud:savedInventory', function(identifier, type, data)
    if type == 'drop' then
        drops[identifier] = data
        TriggerClientEvent('rtx_inventoryhud:updateDrops', -1, drops)
    end
end)

RegisterServerEvent('rtx_inventoryhud:createdInventory')
AddEventHandler('rtx_inventoryhud:createdInventory', function(identifier, type, data)
    if type == 'drop' then
        drops[identifier] = data
        TriggerClientEvent('rtx_inventoryhud:updateDrops', -1, drops)
    end
end)

RegisterServerEvent('rtx_inventoryhud:deletedInventory')
AddEventHandler('rtx_inventoryhud:deletedInventory', function(identifier, type)
    if type == 'drop' then
        drops[identifier] = nil
        TriggerClientEvent('rtx_inventoryhud:updateDrops', -1, drops)
    end
end)
