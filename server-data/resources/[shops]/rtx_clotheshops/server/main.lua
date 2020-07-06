ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rtx_clotheshops:buyclothes')
AddEventHandler('rtx_clotheshops:buyclothes', function (price)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getAccount('money').money >= price then
    xPlayer.removeMoney(price)
    TriggerClientEvent('esx_clotheskin:openSaveableMenuClothe', source)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
  end
end)

TriggerEvent('es:addGroupCommand', 'skinc', 'user', function(source, args, user)
	TriggerClientEvent('esx_clotheskin:openSaveableMenuClothe', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('skin')})