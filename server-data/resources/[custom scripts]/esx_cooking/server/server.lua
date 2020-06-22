ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Order Menu Stuff
--Bread Price
ESX.RegisterServerCallback("checkMoney", function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= 8 then
        xPlayer.removeAccountMoney("bank", 8)
        cb(true)
    else
        cb(false)
    end
end)

--Cheese/Ham Price
ESX.RegisterServerCallback("checkMoney1", function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= 5 then
        xPlayer.removeAccountMoney("bank", 5)
        cb(true)
    else
        cb(false)
    end
end)

--Meat Price
ESX.RegisterServerCallback("checkMoney2", function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= 20 then
        xPlayer.removeAccountMoney("bank", 20)
        cb(true)
    else
        cb(false)
    end
end)

--Sausage Price
ESX.RegisterServerCallback("checkMoney3", function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= 15 then
        xPlayer.removeAccountMoney("bank", 15)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("esx_cooking:giveItem")
AddEventHandler("esx_cooking:giveItem", function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
   
    xPlayer.addInventoryItem(item, 1)
end)

--Kitchen Menu Stuff
ESX.RegisterServerCallback("esx_cooking:checkItem", function (source, cb1, item1, item2, item3)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ingredient1 = xPlayer.getInventoryItem(item1).count
    local ingredient2 = xPlayer.getInventoryItem(item2).count
    local ingredient3 = xPlayer.getInventoryItem(item3).count

    if ingredient1 > 0 and ingredient2 > 0 and ingredient3 > 0 then
        xPlayer.removeInventoryItem(item1, 1)
        xPlayer.removeInventoryItem(item2, 1)
        xPlayer.removeInventoryItem(item3, 1)
        cb1(true)
    else
        cb1(false)
    end
end)

ESX.RegisterServerCallback("esx_cooking:checkItem1", function (source, cb1, item1, item2)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ingredient1 = xPlayer.getInventoryItem(item1).count
    local ingredient2 = xPlayer.getInventoryItem(item2).count

    if ingredient1 > 0 and ingredient2 > 0 then
        xPlayer.removeInventoryItem(item1, 1)
        xPlayer.removeInventoryItem(item2, 1)
        cb1(true)
    else
        cb1(false)
    end
end)

RegisterServerEvent("esx_cooking:giveItem1")
AddEventHandler("esx_cooking:giveItem1", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem("burger", 1)
end)

RegisterServerEvent("esx_cooking:giveItem2")
AddEventHandler("esx_cooking:giveItem2", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem("sandwich", 1)
end)

RegisterServerEvent("esx_cooking:giveitem3")
AddEventHandler("esx_cooking:giveitem3", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem("hotdog", 1)
end)

--WildOatsDrive
ESX.RegisterServerCallback("checkProperty", function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local found = false
    MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
        ['@owner'] = identifier
    }, function(result)
        for k,v in pairs(result) do
            if v.name == 'WildOatsDrive' then
                found = true
            end
        end
        cb(found)
    end)
end)

--WhispymoundDrive
ESX.RegisterServerCallback("checkProperty1", function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local found = false
    MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
        ['@owner'] = identifier
    }, function(result)
        for k,v in pairs(result) do
            if v.name == 'WhispymoundDrive' then
                found = true
            end
        end
        cb(found)
    end)
end)


--RichardMajesticApt2
ESX.RegisterServerCallback("checkProperty2", function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    local found = false
    MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
        ['@owner'] = identifier
    }, function(result)
        for k,v in pairs(result) do
            if v.name == 'RichardMajesticApt2' then
                found = true
            end
        end
        cb(found)
    end)
end)
