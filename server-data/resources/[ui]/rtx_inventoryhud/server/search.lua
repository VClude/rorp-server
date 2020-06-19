RegisterCommand('search', function(source, args, raw)
    TriggerClientEvent('rtx_inventoryhud:search', source)
end)

RegisterCommand('steal', function(source, args, raw)
    TriggerClientEvent('rtx_inventoryhud:steal', source)
end)

ESX.RegisterServerCallback('rtx_inventoryhud:getIdentifier', function(source, cb, serverid)
    cb(GetPlayerIdentifier(serverid))
end)

RegisterServerEvent('rtx_inventoryhud:StealingSynchroSend')
AddEventHandler('rtx_inventoryhud:StealingSynchroSend', function(sourcesender, sourceplayersended)
	local player = ESX.GetPlayerFromId(sourcesender)
	local player2 = ESX.GetPlayerFromId(sourceplayersended)
	TriggerClientEvent("rtx_inventoryhud:StealingSynchro", player.source, player2.identifier)
end)

RegisterServerEvent('rtx_inventoryhud:SearchingSynchroSend')
AddEventHandler('rtx_inventoryhud:SearchingSynchroSend', function(sourcesender, sourceplayersended)
	local player = ESX.GetPlayerFromId(sourcesender)
	local player2 = ESX.GetPlayerFromId(sourceplayersended)
	TriggerClientEvent("rtx_inventoryhud:SearchingSynchro", player.source, player2.identifier)
end)
	
	