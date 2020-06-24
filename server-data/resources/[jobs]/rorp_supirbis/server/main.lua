ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rorp_supirbis:finishRoute')
AddEventHandler('rorp_supirbis:finishRoute', function(amount)
    updateMoney(source, function(player) player.addMoney(amount) end)
end)

RegisterNetEvent('rorp_supirbis:passengersLoaded')
AddEventHandler('rorp_supirbis:passengersLoaded', function(amount)
    updateMoney(source, function(player) player.addMoney(amount) end)
end)

RegisterNetEvent('rorp_supirbis:abortRoute')
AddEventHandler('rorp_supirbis:abortRoute', function(amount)
    updateMoney(source, function(player) player.removeMoney(amount) end)
end)

function updateMoney(_source, updateMoneyCallback)
    local player = ESX.GetPlayerFromId(_source)
    
    if player.job.name ~= 'busdriver' then
        print(_('exploit_attempted_log_message', player.identifier))
        player.kick(_U('exploit_attempted_kick_message'))
        return
    end

    updateMoneyCallback(player)
end