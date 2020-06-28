ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rorp_petani:GiveCrop')
AddEventHandler('rorp_petani:GiveCrop', function(crop)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- local titem = math.random(1,3)
    xPlayer.addInventoryItem(crop, 1)
end)

RegisterServerEvent('rorp_petani:SellCrop')
AddEventHandler('rorp_petani:SellCrop', function(crop, price)
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