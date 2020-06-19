ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

TriggerEvent("es:addGroupCommand", "addveh", "admin", function(source, args)
	local vehPlate = string.upper(args[1])

	if not vehPlate then return end

	TriggerClientEvent("james_carkeys:addKey", source, {
		["id"] = "veh-" .. vehPlate,
		["label"] = "Vehicle key - " .. vehPlate
	})
end)

if Config.VehicleShop then
	RegisterServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
	AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, vehicleProps)
		local player = ESX.GetPlayerFromId(playerId)

		if not player then return end

		TriggerClientEvent("james_carkeys:addKey", source, {
			["id"] = "veh-" .. vehicleProps["plate"],
			["label"] = "Vehicle key - " .. vehicleProps["plate"]
		})
	end)
end

ESX.RegisterServerCallback("james_carkeys:fetchKeys", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local sqlQuery = [[
		SELECT
			keyData
		FROM
			world_keys
		WHERE
			owner = @owner
	]]

	MySQL.Async.fetchAll(sqlQuery, {
		["@owner"] = player["identifier"]
	}, function(response)
		local playerKeys = {}

		for keyIndex, keyData in ipairs(response) do
			local decodedData = json.decode(keyData["keyData"])

			table.insert(playerKeys, decodedData)
		end

		callback(playerKeys)
	end)
end)

ESX.RegisterServerCallback("james_carkeys:fetchPlayerVehicles", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local sqlQuery = [[
			SELECT
				garage, plate, vehicle
			FROM
				owned_vehicles
			WHERE
				owner = @cid
		]]

		MySQL.Async.fetchAll(sqlQuery, {
			["@cid"] = player["identifier"],
			["@garage"] = garage
		}, function(responses)
			local playerVehicles = {}

			for key, vehicleData in ipairs(responses) do
				table.insert(playerVehicles, {
					["plate"] = vehicleData["plate"],
					["garage"] = vehicleData["garage"],
					["props"] = json.decode(vehicleData["vehicle"])
				})
			end

			callback(playerVehicles)
		end)
	else
		callback(false)
	end
end)