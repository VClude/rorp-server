ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("rorp_character:createsign")
AddEventHandler("rorp_character:createsign", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if result[1] then
        if xPlayer ~= nil then
            TriggerClientEvent("rorp_character:createsign", _source, (result[1].firstname .. " " .. result[1].lastname), xPlayer.job.label, ("Cash: " .. xPlayer.getAccount('money').money .. "$"))
        end
    end
end)    

RegisterServerEvent("charselect:select")
AddEventHandler("charselect:select", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier=@username", {['@username'] = player})
    if xPlayer ~= nil then
        if result[1] then   
            TriggerClientEvent("charselect:animation", _source, true)
        else
        end
    end
end)    

RegisterServerEvent("charselect:lastpos")
AddEventHandler("charselect:lastpos", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("charselect:lastpos", _source, json.decode(result[1].position))
        end
    end
end)


