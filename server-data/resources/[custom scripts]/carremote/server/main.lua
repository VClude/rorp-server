ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carremote:checkOwnedVehicle', function(source, cb, plate)
  local xPlayer  = ESX.GetPlayerFromId(source)
  MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
    ['@owner'] = xPlayer.identifier,
    ['@plate'] = plate
  }, function(result)
    if result[1] then
      if result[1].plate then
        cb(true)
      else
        cb(false)
      end
    else
      cb(false)
    end                
  end)
end)

RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(maxDistance, soundFile, maxVolume, vehicleNetId)
  TriggerClientEvent('carremote:playSoundFromVehicle', -1, source, maxDistance, soundFile, maxVolume, vehicleNetId)
end)

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(maxDistance, soundFile, soundVolume)
  TriggerClientEvent('carremote:playSound', -1, source, maxDistance, soundFile, soundVolume)
end)

RegisterNetEvent('carremote:triggerCarAlarm')
AddEventHandler('carremote:triggerCarAlarm', function(vehicleNetId)
  TriggerClientEvent('carremote:startCarAlarm', -1, vehicleNetId)
end)

RegisterNetEvent('carremote:killCarAlarm')
AddEventHandler('carremote:killCarAlarm', function(vehicleNetId)
  TriggerClientEvent('carremote:stopCarAlarm', -1, vehicleNetId)
end)

RegisterNetEvent('carremote:stolenMotorcycleAlarm')
AddEventHandler('carremote:stolenMotorcycleAlarm', function(vehicleNetId)
  TriggerClientEvent('carremote:startMotorcycleAlarm', -1, vehicleNetId)
end)

RegisterNetEvent('carremote:giveKeys')
AddEventHandler('carremote:giveKeys', function(playerId, vehicleNetId)
  TriggerClientEvent('carremote:receiveKeys', playerId, vehicleNetId)
end)

RegisterNetEvent('carremote:takeKeys')
AddEventHandler('carremote:takeKeys', function(playerId, vehicleNetId)
  TriggerClientEvent('carremote:loseKeys', playerId, vehicleNetId)
end)

RegisterNetEvent('carremote:serverLocks')
AddEventHandler('carremote:serverLocks', function(vehicleNetId, value)
  TriggerClientEvent('carremote:clientLocks', -1, vehicleNetId, value)
end)

RegisterNetEvent('carremote:serverEngines')
AddEventHandler('carremote:serverEngines', function(vehicleNetId, value)
  TriggerClientEvent('carremote:clientEngines', -1, vehicleNetId, value)
end)