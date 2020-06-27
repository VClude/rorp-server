ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('zythos-farming:GiveCrop')
AddEventHandler('zythos-farming:GiveCrop', function(crop)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(crop, 1)
end)

RegisterServerEvent('zythos-farming:SellCrop')
AddEventHandler('zythos-farming:SellCrop', function(crop, price)
    local xPlayer = ESX.GetPlayerFromId(source)

    local itemCount = xPlayer.getInventoryItem(crop).count

    if itemCount > 0 then
        local sellValue = price * itemCount
        xPlayer.addMoney(sellValue)
        xPlayer.showNotification(_U('sold_crops', itemCount .. " " .. crop, sellValue))
        xPlayer.removeInventoryItem(crop, itemCount)
    else
        xPlayer.showNotification(_U('no_crop', crop))
    end
end)