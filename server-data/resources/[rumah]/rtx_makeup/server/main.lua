ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--esx_propertymakeupskin---
RegisterServerEvent('esx_propertymakeupskin:savePropertymakeup')
AddEventHandler('esx_propertymakeupskin:savePropertymakeup', function(lipstick, lipstickcolor, lipstickopacity, blush, blushcolor, blushopacity, makeup, makeupcolor, makeupcolor2, makeupopacity)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
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


RegisterServerEvent('esx_propertymakeupskin:responseSaveSkin')
AddEventHandler('esx_propertymakeupskin:responseSaveSkin', function(skin)

	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
				local file = io.open('resources/[esx]/esx_skin/skins.txt', "a")

				file:write(json.encode(skin) .. "\n\n")
				file:flush()
				file:close()
			else
				print(('esx_propertymakeupskin: %s attempted saving skin to file'):format(user.getIdentifier()))
			end
		end)
	end)

end)