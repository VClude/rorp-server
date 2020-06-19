ESX = nil
InvType = {
    ['unknown'] = { slots = 1, label = 'Unknown' },
}

RegisterServerEvent('rtx_inventoryhud:RegisterInventory')
AddEventHandler('rtx_inventoryhud:RegisterInventory', function(inventory)
    if inventory.name == nil then
        return
    end
    
    if inventory.slots == nil then
        inventory.slots = 5
    end

    if inventory.getInventory == nil then
        inventory.getInventory = function(identifier, cb)
            getInventory(identifier, inventory.name, cb)
        end
    end

    if inventory.applyToInventory == nil then
        inventory.applyToInventory = function(identifier, f)
            applyToInventory(identifier, inventory.name, f)
        end
    end

    if inventory.saveInventory == nil then
        inventory.saveInventory = function(identifier, toSave)
            if table.length(toSave) > 0 then
                saveInventory(identifier, inventory.name, toSave)
            else
                deleteInventory(identifier, inventory.name)
            end
        end
    end

    if inventory.getDisplayInventory == nil then
        inventory.getDisplayInventory = function(identifier, cb, source)
            getDisplayInventory(identifier, inventory.name, cb, source)
        end
    end

    InvType[inventory.name] = inventory
    loadedInventories[inventory.name] = {}
end)

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('rtx_inventoryhud:doesInvTypeExists', function(source, cb, type)
    cb(InvType[type] ~= nil)
end)

RegisterCommand('reloadinv', function(source)
    local owner = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.fetchAll('DELETE FROM rtx_inventory WHERE data = @data AND owner = @owner', { ['@data'] = "null", ['@owner'] = owner })  -- Tgiann "Null" Fix
    ensureInventories(source)
end)

RegisterCommand('fixinv', function(source)
    local owner = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.fetchAll('DELETE FROM rtx_inventory WHERE data = @data AND owner = @owner', { ['@data'] = "null", ['@owner'] = owner })  -- Tgiann "Null" Fix
    ensureInventories(source)
end)

RegisterCommand('inv', function(source)
    local owner = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.fetchAll('DELETE FROM rtx_inventory WHERE data = @data AND owner = @owner', { ['@data'] = "null", ['@owner'] = owner })  -- Tgiann "Null" Fix
    ensureInventories(source)
end)

RegisterServerEvent('rtx_inventoryhud:ClearInventory')
AddEventHandler('rtx_inventoryhud:ClearInventory', function(source)
	local owner = ESX.GetPlayerFromId(source).identifier
    MySQL.Async.fetchAll('DELETE FROM rtx_inventory WHERE data = @data AND owner = @owner', { ['@data'] = "null", ['@owner'] = owner })  -- Tgiann "Null" Fix
    ensureInventories(source)
end)

function ensureInventories(source)
    local player = ESX.GetPlayerFromId(source)
    ensurePlayerInventory(player)
    TriggerClientEvent('rtx_inventoryhud:refreshInventory', source)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        saveInventories()
    end
end)

AddEventHandler('esx:playerLoaded', function(data)
    local player = ESX.GetPlayerFromId(data)
    ensurePlayerInventory(player)
end)

Citizen.CreateThread(function()
    local players = ESX.GetPlayers()
    for k, v in ipairs(players) do
        ensurePlayerInventory(ESX.GetPlayerFromId(v))
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local player = ESX.GetPlayerFromId(source)
    saveInventory(player.identifier, 'player')
    closeAllOpenInventoriesForSource(source)
end)
