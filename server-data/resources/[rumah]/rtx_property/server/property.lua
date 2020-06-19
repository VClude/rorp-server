RegisterServerEvent('rtx_property:sellProperty')
AddEventHandler('rtx_property:sellProperty', function(property)
    MySQL.Async.execute('UPDATE rtx_property SET sold = 0 WHERE name = @name', {
        ['@name'] = property.name
    })
    MySQL.Async.execute('DELETE FROM rtx_property_owners WHERE name = @name', {
        ['@name'] = property.name
    })
    local player = ESX.GetPlayerFromId(source)
    player.addMoney(property.price * Config.ResellPercentage)
end)

ESX.RegisterServerCallback('rtx_property:buyProperty', function(source, cb, property)
    local player = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT price FROM rtx_property WHERE name = @name', {
        ['@name'] = property.name
    }, function(result)
        if player.getMoney() >= result[1].price * Config.BuyPercentage then
        MySQL.Async.execute('UPDATE rtx_property SET sold = 1 WHERE name = @name', {
            ['@name'] = property.name
        })
        MySQL.Async.execute('INSERT INTO rtx_property_owners (name, identifier, active, owner) VALUES (@name, @identifier, 1, 1)', {
            ['@name'] = property.name,
            ['@identifier'] = player.identifier
        })
        player.removeMoney(property.price * Config.BuyPercentage)
        cb(true)
	else
		cb(false)
	end
    end)
end)

RegisterServerEvent('rtx_property:GiveKeys')
AddEventHandler('rtx_property:GiveKeys', function(property, identifier)
    MySQL.Async.execute('INSERT INTO rtx_property_owners (name, identifier, active, owner) VALUES (@name, @identifier, 1, 0)', {
        ['@name'] = property.name,
        ['@identifier'] = identifier
    })
end)

RegisterServerEvent('rtx_property:TakeKeys')
AddEventHandler('rtx_property:TakeKeys', function(property, identifier)
    MySQL.Async.execute('DELETE FROM rtx_property_owners WHERE name = @name and identifier = @identifier', {
        ['@name'] = property.name,
        ['@identifier'] = identifier
    })
end)

ESX.RegisterServerCallback('rtx_property:searchUsers', function(source, cb, value)
    local value = value
    MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE LOWER(firstname) LIKE LOWER(@firstname) or LOWER(lastname) LIKE LOWER(@lastname) ', {
                ['@firstname'] = '%' .. value .. '%',
                ['@lastname'] = '%' .. value .. '%'
            },
            function(results)
                cb(results)
            end)
end)

ESX.RegisterServerCallback('rtx_property:getKeyUsers', function(source, cb, property)

    MySQL.Async.fetchAll('SELECT rtx_property_owners.identifier, rtx_property_owners.name as houses,rtx_property_owners.owner, users.firstname,users.lastname FROM rtx_property_owners INNER JOIN users where rtx_property_owners.identifier = users.identifier and rtx_property_owners.owner = "0" and rtx_property_owners.name = @houses  '
    , {
                ["@houses"] = property.name

            },
            function(results)
                cb(results)
            end)
end)
