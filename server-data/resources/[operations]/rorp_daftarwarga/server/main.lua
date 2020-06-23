ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('rorp_daftarwarga:giftCar', function(source, cb, plate, model)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored, garage_name) VALUES (@owner, @plate, @vehicle, @type, @stored, @garage_name)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate,
		['@vehicle'] = json.encode({modPlateHolder = -1, modDashboard = -1, modAerials = -1, modTrunk = -1, modTrimA = -1, modSteeringWheel = -1, modDoorSpeaker = -1, modBrakes = 2, modSpeakers = -1, plate = plate , modGrille = -1, modFrame = 0, modShifterLeavers = -1, modStruts = -1, modRearBumper = -1, modAirFilter = -1, modTransmission = -1, windowTint = -1, modFrontBumper = -1, modAPlate = -1, modFender = -1, modTank = -1, modSeats = -1, modExhaust = -1, modEngine = -1, modHood = -1, modEngineBlock = -1, modSuspension = 3, modSideSkirt = -1, modelName = fiat600, modSmokeEnabled = 1, modSpoilers = -1, modRoof = -1, modHorns = -1, modHydrolic = -1, modFrontWheels = -1, modVanityPlate = -1, modOrnaments = -1, modWindows = -1, modDial = -1, modArchCover = -1, modRightFender = -1, modArmor = -1, modXenon = false, modBackWheels = -1, modTurbo = 1, modTrimB = -1, modLivery = -1, model = GetHashKey(model)}),
		['@type'] = 'car',
		['@stored'] = 1,
		['@garage_name'] = 'Garasi_Walkot'
	}, function(rowsChanged)
		if rowsChanged then
			TriggerEvent('rorp_daftarwarga:removeStatWargaBaru')
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('rorp_daftarwarga:cekWargabaru', function(source, cb)
	local _source = source
	local identifier = ESX.GetPlayerFromId(_source).identifier

	MySQL.Async.fetchAll('SELECT wargaBaru FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		local user = result[1]
		local wargaBaru = user['wargaBaru']
		if wargaBaru == true then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent('rorp_daftarwarga:addKTP')
AddEventHandler('rorp_daftarwarga:addKTP', function(source, type,jmlhUang)
	local _source = source
	local xPlayer = GetPlayerFromId(_source)

	TriggerEvent('esx_license:addLicense', _source, type)
	TriggerClientEvent('esx:showNotification', _source, (_U('test_berhasil')))
	Citizen.Wait(2000)
	xPlayer.addMoney(jmlhUang)
	TriggerClientEvent('esx:showNotification', _source, (_U('uang_subsidi', ESX.Math.GroupDigits(jmlhUang))))

end)

ESX.RegisterServerCallback('rorp_daftarwarga:removeStatWargaBaru', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET wargaBaru = @wargaBaru where identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@wargaBaru'] = 0
	})
end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[rorp_daftarwarga] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end
end)

ESX.RegisterServerCallback('rorp_daftarwarga:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)
