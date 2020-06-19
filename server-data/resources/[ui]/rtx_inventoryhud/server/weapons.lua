Citizen.CreateThread(function()
    Citizen.Wait(0)
    MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
        for k, v in pairs(results) do
            ESX.RegisterUsableItem(v.name, function(source)
                TriggerClientEvent('rtx_inventoryhud:useWeapon', source, v.name)
            end)
        end
    end)
end)

RegisterServerEvent('rtx_inventoryhud:updateAmmoCount')
AddEventHandler('rtx_inventoryhud:updateAmmoCount', function(hash, count)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE rtx_ammo SET count = @count WHERE hash = @hash AND owner = @owner', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash,
        ['@count'] = count
    }, function(results)
        if results == 0 then
            MySQL.Async.execute('INSERT INTO rtx_ammo (owner, hash, count) VALUES (@owner, @hash, @count)', {
                ['@owner'] = player.identifier,
                ['@hash'] = hash,
                ['@count'] = count
            })
        end
    end)
end)

ESX.RegisterServerCallback('rtx_inventoryhud:getAmmoCount', function(source, cb, hash)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM rtx_ammo WHERE owner = @owner and hash = @hash', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results == 0 then
            cb(nil)
        else
            cb(results[1].count)
        end
    end)
end)


