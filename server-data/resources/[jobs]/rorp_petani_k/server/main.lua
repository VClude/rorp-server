ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rorp_petani:GiveCrop')
AddEventHandler('rorp_petani:GiveCrop', function(crop)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem(crop, 1) then
        xPlayer.addInventoryItem(crop, 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Tas kamu sudah penuh', duration = 2500})
    end
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


ESX.RegisterServerCallback('rorp_petani:checkBahan', function(source,cb,bahan1,bahan2)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(bahan1).count >= 4 and xPlayer.getInventoryItem(bahan2).count >= 1 then
        xPlayer.removeInventoryItem(bahan1, 4)
        xPlayer.removeInventoryItem(bahan2, 1)
        cb(true)
    else
        cb(false)
end)

RegisterServerEvent('rorp_petani:GivePackagedCrop')
AddEventHandler('rorp_petani:GivePackagedCrop', function(PackagedCrop)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(PackagedCrop, 1) then
        xPlayer.addInventoryItem(PackagedCrop, 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Tas kamu sudah penuh', duration = 2500)
    end  
end)
