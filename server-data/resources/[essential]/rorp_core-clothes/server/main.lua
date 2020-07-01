ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'skinc', 'user', function(source, args, user)
	TriggerClientEvent('esx_clotheskin:openSaveableMenuClothe', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('skin')})

RegisterServerEvent('rorp_core-clothes:saveclothe')
AddEventHandler('rorp_core-clothes:saveclothe', function(torso, torsotext, leg, legtext, shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat, prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches, prop_watches_text, prop_mask, prop_mask_text, prop_bracelets, prop_bracelets_text, prop_bag, prop_bag_text, prop_chain, prop_chain_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
    		skin["arms"] = torso
			skin["arms_2"] = torsotext
			skin['pants_1'] = leg
			skin['pants_2'] = legtext
			skin["shoes_1"] = shoes
			skin["shoes_2"] = shoestext
			skin["chain_1"] = accessory
			skin["chain_2"] = accessorytext
			skin["tshirt_1"] = undershirt
			skin["tshirt_2"] = undershirttext
			skin["torso_1"] = torso2
			skin["torso_2"] = torso2text
			skin["helmet_1"] = prop_hat
			skin["helmet_2"] = prop_hat_text
			skin["glasses_1"] = prop_glasses
			skin["glasses_2"] = prop_glasses_text
			skin["ears_1"] = prop_earrings
			skin["ears_2"] = prop_earrings_text
			skin["watches_1"] = prop_watches
			skin["watches_2"] = prop_watches_text
			skin["mask_1"] = prop_mask
			skin["mask_2"] = prop_mask_text
			skin["bracelets_1"] = prop_bracelets
			skin["bracelets_2"] = prop_bracelets_text
			skin["bags_1"] = prop_bag
			skin["bags_2"] = prop_bag_text
			skin["chain_1"] = prop_chain
			skin["chain_2"] = prop_chain_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)