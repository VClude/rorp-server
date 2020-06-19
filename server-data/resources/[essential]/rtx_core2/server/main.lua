ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('rtx_core:buy', function(source, cb, price)
    local player = ESX.GetPlayerFromId(source)
    if player.getMoney() >= price then
        player.removeMoney(price)
        cb(1)
    else
        cb(0)
    end
end)

RegisterServerEvent('rtx_core:givePlayerItem')
AddEventHandler('rtx_core:givePlayerItem', function(item, count)
    local player = ESX.GetPlayerFromId(source)
    player.addInventoryItem(item, count)
end)

ESX.RegisterServerCallback('rtx_core:takePlayerItem', function(source, cb, item, count)
    local player = ESX.GetPlayerFromId(source)
    local invItem = player.getInventoryItem(item)
    if invItem.count - count < 0 then
        cb(false)
    else
        player.removeInventoryItem(item, count)
        cb(true)
    end
end)

RegisterServerEvent('rtx_core:givePlayerDirtyMoney')
AddEventHandler('rtx_core:givePlayerDirtyMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addAccountMoney('black_money', amount)
end)

RegisterServerEvent('rtx_core:givePlayerMoney')
AddEventHandler('rtx_core:givePlayerMoney', function(amount)
    local player = ESX.GetPlayerFromId(source)
    player.addMoney(amount)
end)

ESX.RegisterServerCallback('rtx_core:takePlayerMoney', function(source, cb, amount)
    local player = ESX.GetPlayerFromId(source)
    local money = player.getMoney()
    if money - amount < 0 then
        cb(false)
    else
        player.removeMoney(amount)
        cb(true)
    end
end)
