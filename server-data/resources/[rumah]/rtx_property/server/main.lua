ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('rtx_property:getPropertyData', function(_, cb)
    MySQL.Async.fetchAll('SELECT * FROM rtx_property', {}, function(propertyData)
        MySQL.Async.fetchAll('SELECT * FROM rtx_property_owners where active', {}, function(ownerData)
            cb(propertyData, ownerData)
        end)
    end)
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
        Citizen.Wait(1000)
        MySQL.Async.fetchAll('SELECT * FROM rtx_property', {}, function(propertyData)
            MySQL.Async.fetchAll('SELECT * FROM rtx_property_owners where active', {}, function(ownerData)
                TriggerClientEvent('rtx_property:updatePropertyData', -1, propertyData, ownerData)
            end)
        end)
    end
end)

RegisterServerEvent('rtx_makeupproperty:checksada')
AddEventHandler('rtx_makeupproperty:checksada', function ()
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local sada = xPlayer.getInventoryItem('kosmetickasada')

  if sada.count > 0 then
    TriggerClientEvent('esx_propertymakeupskin:openSaveableMenuPropertymakeup', source)
  else
    TriggerClientEvent('esx:showNotification', source, 'Nemůžete se nalíčit jelikož u sebe nemáte komsetickou sadu')
  end
end)

RegisterServerEvent('rtx_property:sprchasync')
AddEventHandler('rtx_property:sprchasync', function(player, need, gender)
    TriggerClientEvent('rtx_property:sprchasyncclient', -1, player, need, gender)
end)

RegisterServerEvent('rtx_property:sprchasyncremove')
AddEventHandler('rtx_property:sprchasyncremove', function(player, posx, posy, posz)
    TriggerClientEvent('rtx_property:sprchasyncremoveclient', -1, player, posx, posy, posz)
end)

RegisterServerEvent('esx_propertymakeupskinsprcha:savePropertymakeupSprcha')
AddEventHandler('esx_propertymakeupskinsprcha:savePropertymakeupSprcha', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["lipstick_1"] = 0
			skin["lipstick_2"] = 0
			skin["lipstick_3"] = 0
			skin["lipstick_4"] = 0
			skin["blush_1"] = 0
			skin["blush_2"] = 0
			skin["blush_3"] = 0
			skin["makeup_1"] = 0
			skin["makeup_2"] = 0
			skin["makeup_3"] = 0
			skin["makeup_4"] = 0
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)