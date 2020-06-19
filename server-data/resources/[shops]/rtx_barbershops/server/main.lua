ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rtx_barbershops:buycosmetics')
AddEventHandler('rtx_barbershops:buycosmetics', function (price)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getAccount('money').money >= price then
    xPlayer.removeMoney(price)
    TriggerClientEvent('esx_barberskin:openSaveableMenuBarber', source)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
  end
end)