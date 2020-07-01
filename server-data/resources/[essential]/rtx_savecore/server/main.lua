ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--esx_skin---
RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('rtx_barbershops:saveBarber')
AddEventHandler('rtx_barbershops:saveBarber', function(hair, haircolor, haircolor2, eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, lipstick, lipstickcolor, lipstickopacity, blush, blushcolor, blushopacity, makeup, makeupcolor, makeupcolor2, makeupopacity)
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
RegisterServerEvent('rtx_doplnky:saveBryle')
AddEventHandler('rtx_doplnky:saveBryle', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_bryle', xPlayer.identifier, function(store)
		local doplnekbryle = store.get('doplnekbryle')

		if doplnekbryle == nil then
			doplnekbryle = {}
		end

		table.insert(doplnekbryle, {
			label = label,
			skin  = skin
		})

		store.set('doplnekbryle', doplnekbryle)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkBryleDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_bryle', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getBryle', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_bryle', xPlayer.identifier, function(store)
        local count = store.count('doplnekbryle')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekbryle', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeBryle')
AddEventHandler('rtx_doplnky:removeBryle', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_bryle', xPlayer.identifier, function(store)
        local count = store.count('doplnekbryle')
        local doplnekbryle = store.get('doplnekbryle')
        for i = 1, count, 1 do
            local entry = store.get('doplnekbryle', i)
            if entry.label == label then
                table.remove(doplnekbryle, i)
            end
        end
        store.set('doplnekbryle', doplnekbryle)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnibryle')
AddEventHandler('rtx_doplnky:saveaktualnibryle', function(prop_glasses, prop_glasses_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["glasses_1"] = prop_glasses
			skin["glasses_2"] = prop_glasses_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveHodinky')
AddEventHandler('rtx_doplnky:saveHodinky', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_hodinky', xPlayer.identifier, function(store)
		local doplnekhodinky = store.get('doplnekhodinky')

		if doplnekhodinky == nil then
			doplnekhodinky = {}
		end

		table.insert(doplnekhodinky, {
			label = label,
			skin  = skin
		})

		store.set('doplnekhodinky', doplnekhodinky)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkHodinkyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_hodinky', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getHodinky', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_hodinky', xPlayer.identifier, function(store)
        local count = store.count('doplnekhodinky')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekhodinky', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeHodinky')
AddEventHandler('rtx_doplnky:removeHodinky', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_hodinky', xPlayer.identifier, function(store)
        local count = store.count('doplnekhodinky')
        local doplnekhodinky = store.get('doplnekhodinky')
        for i = 1, count, 1 do
            local entry = store.get('doplnekhodinky', i)
            if entry.label == label then
                table.remove(doplnekhodinky, i)
            end
        end
        store.set('doplnekhodinky', doplnekhodinky)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnihodinky')
AddEventHandler('rtx_doplnky:saveaktualnihodinky', function(prop_watches, prop_watches_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["watches_1"] = prop_watches
			skin["watches_2"] = prop_watches_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveMasky')
AddEventHandler('rtx_doplnky:saveMasky', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_masky', xPlayer.identifier, function(store)
		local doplnekmasky = store.get('doplnekmasky')

		if doplnekmasky == nil then
			doplnekmasky = {}
		end

		table.insert(doplnekmasky, {
			label = label,
			skin  = skin
		})

		store.set('doplnekmasky', doplnekmasky)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkMaskyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_masky', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getMasky', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_masky', xPlayer.identifier, function(store)
        local count = store.count('doplnekmasky')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekmasky', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeMasky')
AddEventHandler('rtx_doplnky:removeMasky', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_masky', xPlayer.identifier, function(store)
        local count = store.count('doplnekmasky')
        local doplnekmasky = store.get('doplnekmasky')
        for i = 1, count, 1 do
            local entry = store.get('doplnekmasky', i)
            if entry.label == label then
                table.remove(doplnekmasky, i)
            end
        end
        store.set('doplnekmasky', doplnekmasky)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnimasky')
AddEventHandler('rtx_doplnky:saveaktualnimasky', function(prop_mask, prop_mask_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["mask_1"] = prop_mask
			skin["mask_2"] = prop_mask_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveUsi')
AddEventHandler('rtx_doplnky:saveUsi', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_usi', xPlayer.identifier, function(store)
		local doplnekusi = store.get('doplnekusi')

		if doplnekusi == nil then
			doplnekusi = {}
		end

		table.insert(doplnekusi, {
			label = label,
			skin  = skin
		})

		store.set('doplnekusi', doplnekusi)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkUsiDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_usi', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getUsi', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_usi', xPlayer.identifier, function(store)
        local count = store.count('doplnekusi')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekusi', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeUsi')
AddEventHandler('rtx_doplnky:removeUsi', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_usi', xPlayer.identifier, function(store)
        local count = store.count('doplnekusi')
        local doplnekusi = store.get('doplnekusi')
        for i = 1, count, 1 do
            local entry = store.get('doplnekusi', i)
            if entry.label == label then
                table.remove(doplnekusi, i)
            end
        end
        store.set('doplnekusi', doplnekusi)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualniusi')
AddEventHandler('rtx_doplnky:saveaktualniusi', function(prop_earrings, prop_earrings_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["ears_1"] = prop_earrings
			skin["ears_2"] = prop_earrings_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveCepice')
AddEventHandler('rtx_doplnky:saveCepice', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_cepice', xPlayer.identifier, function(store)
		local doplnekcepice = store.get('doplnekcepice')

		if doplnekcepice == nil then
			doplnekcepice = {}
		end

		table.insert(doplnekcepice, {
			label = label,
			skin  = skin
		})

		store.set('doplnekcepice', doplnekcepice)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkCepiceDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_cepice', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getCepice', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_cepice', xPlayer.identifier, function(store)
        local count = store.count('doplnekcepice')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekcepice', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeCepice')
AddEventHandler('rtx_doplnky:removeCepice', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_cepice', xPlayer.identifier, function(store)
        local count = store.count('doplnekcepice')
        local doplnekcepice = store.get('doplnekcepice')
        for i = 1, count, 1 do
            local entry = store.get('doplnekcepice', i)
            if entry.label == label then
                table.remove(doplnekcepice, i)
            end
        end
        store.set('doplnekcepice', doplnekcepice)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnicepice')
AddEventHandler('rtx_doplnky:saveaktualnicepice', function(prop_hat, prop_hat_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["helmet_1"] = prop_hat
			skin["helmet_2"] = prop_hat_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveNaramek')
AddEventHandler('rtx_doplnky:saveNaramek', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_naramky', xPlayer.identifier, function(store)
		local doplneknaramek = store.get('doplneknaramek')

		if doplneknaramek == nil then
			doplneknaramek = {}
		end

		table.insert(doplneknaramek, {
			label = label,
			skin  = skin
		})

		store.set('doplneknaramek', doplneknaramek)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkNaramekDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_naramky', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getNaramek', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_naramky', xPlayer.identifier, function(store)
        local count = store.count('doplneknaramek')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplneknaramek', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeNaramek')
AddEventHandler('rtx_doplnky:removeNaramek', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_naramky', xPlayer.identifier, function(store)
        local count = store.count('doplneknaramek')
        local doplneknaramek = store.get('doplneknaramek')
        for i = 1, count, 1 do
            local entry = store.get('doplneknaramek', i)
            if entry.label == label then
                table.remove(doplneknaramek, i)
            end
        end
        store.set('doplneknaramek', doplneknaramek)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualninaramek')
AddEventHandler('rtx_doplnky:saveaktualninaramek', function(prop_bracelets, prop_bracelets_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["bracelets_1"] = prop_bracelets
			skin["bracelets_2"] = prop_bracelets_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveTaska')
AddEventHandler('rtx_doplnky:saveTaska', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_tasky', xPlayer.identifier, function(store)
		local doplnektaska = store.get('doplnektaska')

		if doplnektaska == nil then
			doplnektaska = {}
		end

		table.insert(doplnektaska, {
			label = label,
			skin  = skin
		})

		store.set('doplnektaska', doplnektaska)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkTaskaDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_tasky', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getTaska', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_tasky', xPlayer.identifier, function(store)
        local count = store.count('doplnektaska')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnektaska', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeTaska')
AddEventHandler('rtx_doplnky:removeTaska', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_tasky', xPlayer.identifier, function(store)
        local count = store.count('doplnektaska')
        local doplnektaska = store.get('doplnektaska')
        for i = 1, count, 1 do
            local entry = store.get('doplnektaska', i)
            if entry.label == label then
                table.remove(doplnektaska, i)
            end
        end
        store.set('doplnektaska', doplnektaska)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnitaska')
AddEventHandler('rtx_doplnky:saveaktualnitaska', function(prop_bag, prop_bag_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
			skin["bags_1"] = prop_bag
			skin["bags_2"] = prop_bag_text
    		skin = json.encode(skin)
    		MySQL.Sync.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
    			['@skin'] = skin,
	    		['@identifier'] = xPlayer.identifier
	    	})
    	end
    end)
end)

RegisterServerEvent('rtx_doplnky:saveKrk')
AddEventHandler('rtx_doplnky:saveKrk', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_krk', xPlayer.identifier, function(store)
		local doplnekkrk = store.get('doplnekkrk')

		if doplnekkrk == nil then
			doplnekkrk = {}
		end

		table.insert(doplnekkrk, {
			label = label,
			skin  = skin
		})

		store.set('doplnekkrk', doplnekkrk)
	end)
end)

ESX.RegisterServerCallback('rtx_doplnky:checkKrkDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'doplnky_krk', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

ESX.RegisterServerCallback('rtx_doplnky:getKrk', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'doplnky_krk', xPlayer.identifier, function(store)
        local count = store.count('doplnekkrk')
        local clothes = {}

        for i = 1, count, 1 do
            local entry = store.get('doplnekkrk', i)
            table.insert(clothes, entry)
        end
        cb(clothes)
    end)
end)

RegisterServerEvent('rtx_doplnky:removeKrk')
AddEventHandler('rtx_doplnky:removeKrk', function(label)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'doplnky_krk', xPlayer.identifier, function(store)
        local count = store.count('doplnekkrk')
        local doplnekkrk = store.get('doplnekkrk')
        for i = 1, count, 1 do
            local entry = store.get('doplnekkrk', i)
            if entry.label == label then
                table.remove(doplnekkrk, i)
            end
        end
        store.set('doplnekkrk', doplnekkrk)
    end)
end)

RegisterServerEvent('rtx_doplnky:saveaktualnikrk')
AddEventHandler('rtx_doplnky:saveaktualnikrk', function(prop_chain, prop_chain_text)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT skin FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
    	if result[1] then
    		local skin = json.decode(result[1].skin)
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
