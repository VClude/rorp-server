ESX.RegisterServerCallback("james_carkeys:addKey", function(source, callback, keyData)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    local sqlQuery = [[
        INSERT
            INTO
        world_keys
            (uuid, owner, keyData)
        VALUES
            (@uuid, @owner, @data)
        ON DUPLICATE KEY UPDATE
            keyData = @data
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@uuid"] = keyData["uuid"],
        ["@owner"] = player["identifier"],
        ["@data"] = json.encode(keyData)
    }, function(rowsChanged)
        if rowsChanged > 0 then
            callback(true)
        else
            callback(false)
        end
    end)
end)

ESX.RegisterServerCallback("james_carkeys:removeKey", function(source, callback, keyUUID)
    local player = ESX.GetPlayerFromId(source)

    if not player then return callback(false) end

    local sqlQuery = [[
        DELETE
            FROM
        world_keys
            WHERE
        uuid = @uuid
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@uuid"] = keyUUID
    }, function(rowsChanged)
        if rowsChanged > 0 then
            callback(true)
        else
            callback(false)
        end
    end)
end)

ESX.RegisterServerCallback("james_carkeys:transferKey", function(source, callback, keyData, receivePlayer)
    local player = ESX.GetPlayerFromId(source)
    local receivePlayer = ESX.GetPlayerFromId(receivePlayer)

    if not player then return callback(false) end

    local sqlQuery = [[
        UPDATE
            world_keys
        SET
            owner = @newOwner
        WHERE
            uuid = @uuid
    ]]

    MySQL.Async.execute(sqlQuery, {
        ["@uuid"] = keyData["uuid"],
        ["@newOwner"] = receivePlayer["identifier"]
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent("james_carkeys:keyTransfered", receivePlayer["source"], keyData)

            callback(true)
        else
            callback(false)
        end
    end)
end)