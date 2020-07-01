ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rorp_barbershop:buycosmetics')
AddEventHandler('rorp_barbershop:buycosmetics', function (price)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getAccount('money').money >= price then
    xPlayer.removeMoney(price)
    TriggerClientEvent('rorp_barbershop:openSaveableMenuBarber', source)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
  end
end)

RegisterServerEvent('rorp_barbershop:saveBarber')
AddEventHandler('rorp_barbershop:saveBarber', function(hair, haircolor, haircolor2, eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, lipstick, lipstickcolor, lipstickopacity, blush, blushcolor, blushopacity, makeup, makeupcolor, makeupcolor2, makeupopacity)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
    		skin["hair_1"] = hair
			skin["hair_color_1"] = haircolor
			skin["hair_color_2"] = haircolor2
			skin["eyebrows_1"] = eyebrow
			skin["eyebrows_2"] = eyebrowopacity
			skin["beard_1"] = beard
			skin["beard_2"] = beardopacity
			skin["beard_3"] = beardcolor
			skin["lipstick_1"] = lipstick
			skin["lipstick_2"] = lipstickopacity
			skin["lipstick_3"] = lipstickcolor
			skin["lipstick_4"] = lipstickcolor
			skin["blush_1"] = blush
			skin["blush_2"] = blushopacity
			skin["blush_3"] = blushcolor
			skin["makeup_1"] = makeup
			skin["makeup_2"] = makeupopacity
			skin["makeup_3"] = makeupcolor
			skin["makeup_4"] = makeupcolor2
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)