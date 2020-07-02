ESX = nil

local jobBlips = {}
local menuIsShowed, hintIsShowed, hintToDisplay, hasAlreadyEnteredMarker, isInMarker, vehicleObjInCaseofDrop, vehicleInCaseofDrop, vehicleMaxHealth
local PlayerData, Blips, JobBlips, myPlate, onDuty, spawner = {}, {}, {}, {}, false, 0

local PlayerData = nil
local currentlyMining = false
local currentlyWashing = false
local currentlySmelting = false
local currentlySelling = false
local onWork = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	-- onDuty = false
	-- myPlate = {} -- loosing vehicle caution in case player changes job.
	-- spawner = 0
	deleteBlips()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

AddEventHandler('rorp_miner:hasExitedMarker', function()
	hintToDisplay = nil
	menuIsShowed = false
	hintIsShowed = false
	isInMarker = false
end)

-- Show top left hint
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if hintIsShowed and hintToDisplay then
			ESX.ShowHelpNotification(hintToDisplay)
		else
			Citizen.Wait(500)
		end
	end
end)

-- Draw markers (only if on duty and the player's job ones)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local zones, currentZone, currentZoneIndex, isInMarker = {}
		local letSleep, playerPed = true, PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
	    if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil then

            local zones = Config.Miner.Zones

			for k,v in pairs(zones) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Coords.x, v.Coords.y, v.Coords.z, true)

				if onDuty or v.Type == 'cloakroom' then
					if(v.Marker ~= -1 and distance < Config.DrawDistance) then
						letSleep = false
						DrawMarker(v.Marker, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					end
				end

				if distance < v.Size.x then
					letSleep, isInMarker, currentZone, currentZoneIndex = false, true, v, k
					break
				end
			end

			if IsControlJustReleased(0, 38) and not menuIsShowed and isInMarker then
                if onDuty or currentZone.Type == 'cloakroom' then
					TriggerEvent('esx_jobs:action', PlayerData.job.name, currentZone, currentZoneIndex)
				end
			end

			-- hide or show top left zone hints
			if isInMarker and not menuIsShowed then
				hintIsShowed = true
				if (onDuty or currentZone.Type == 'cloakroom') and currentZone.Type ~= 'vehdelete' then
					hintToDisplay = currentZone.Hint
					hintIsShowed = true
				elseif currentZone.Type == 'vehdelete' and onDuty then
					-- local playerPed = PlayerPedId()

					-- if IsPedInAnyVehicle(playerPed, false) then
					-- 	local vehicle = GetVehiclePedIsIn(playerPed, false)
					-- 	local driverPed = GetPedInVehicleSeat(vehicle, -1)
					-- 	local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

					-- 	if playerPed == driverPed then
					-- 		if myPlate[plate] then
					-- 			hintToDisplay = currentZone.Hint
					-- 		end
					-- 	else
					-- 		hintToDisplay = _U('not_your_vehicle')
					-- 	end
					-- else
					-- 	hintToDisplay = _U('in_vehicle')
					-- end
					-- hintIsShowed = true
				-- elseif onDuty and currentZone.Spawner ~= spawner then
				-- 	hintToDisplay = _U('wrong_point')
				-- 	hintIsShowed = true
				else
					hintToDisplay = nil
					hintIsShowed = false
				end
			end

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('rorp_miner:hasExitedMarker')
			end
        end
        
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

function deleteBlips()
	for _,v in ipairs(jobBlips) do
		RemoveBlip(v)
	end
end

function refreshBlips()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "miner" then
        for k,v in pairs(Config.Miner.Zones) do
            local blip = AddBlipForCoord(v.Coords)

            SetBlipSprite  (blip, Config.BlipSprite)
            SetBlipScale   (blip, Config.BlipScale)
            SetBlipCategory(blip, 3)
            SetBlipColour  (blip, Config.BlipColour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.BlipName)
            EndTextCommandSetBlipName(blip)

            table.insert(jobBlips, blip)
        end
    end
end

-- end function custom miner
AddEventHandler('esx_jobs:action', function(job, zone, zoneIndex)
	menuIsShowed = true
	if zone.Type == 'cloakroom' then
		OpenMenu()
	-- elseif zone.Type == 'work' then
	-- 	hintToDisplay = nil
	-- 	hintIsShowed = false
	-- 	local playerPed = PlayerPedId()
		
	-- 	if IsPedOnFoot(playerPed) then

	-- 		onWork = true
	-- 		local playerPed = PlayerPedId()
	-- 		local coords = GetEntityCoords(playerPed)
			
	-- 		-- FreezeEntityPosition(playerPed, true)
	-- 		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	-- 		Citizen.Wait(200)

	-- 		TriggerEvent("mythic_progressbar:client:progress", {
	-- 			name = "on_working",
	-- 			duration = zone.Duration,
	-- 			label = "Tekan 'X' Untuk Cancel",
	-- 			useWhileDead = false,
	-- 			canCancel = true,
	-- 			controlDisables = {
	-- 				disableMovement = true,
	-- 				disableCarMovement = true,
	-- 				disableMouse = false,
	-- 				disableCombat = true,
	-- 			},
	-- 			animation = {
	-- 				task = "CODE_HUMAN_MEDIC_TIME_OF_DEATH",
	-- 			},
	-- 			prop = {

	-- 			},
	-- 		}, function(status)
	-- 			if not status then
	-- 				for k,v in pairs(zone.Item) do
	-- 					TriggerServerEvent("esx_jobs:alljobReward",v.db_name,v.add, v.requires, v.remove)
	-- 					onWork = false
	-- 				end
	-- 			end
	-- 		end)
	-- 	else
	-- 		ESX.ShowNotification(_U('foot_work'))
	-- 	end
	-- elseif zone.Type == 'vehspawner' then
	-- 	local jobObject, spawnPoint, vehicle = Config.Jobs[PlayerData.job.name]

	-- 	print (Config.Jobs[PlayerData.job.name])

	-- 	if jobObject then
	-- 		for k,v in pairs(jobObject.Zones) do
	-- 			if v.Type == 'vehspawnpt' and v.Spawner == zone.Spawner then
	-- 				spawnPoint = v
	-- 				spawner = v.Spawner
	-- 				break
	-- 			end
				
	-- 		end

	-- 		for k,v in pairs(jobObject.Vehicles) do
	-- 			if v.Spawner == zone.Spawner then
	-- 				vehicle = v
	-- 				break
	-- 			end
	-- 		end
	-- 	end

	-- 	if jobObject and spawnPoint and vehicle and ESX.Game.IsSpawnPointClear(spawnPoint.Pos, 5.0) then
	-- 		spawnVehicle(spawnPoint, vehicle, zone.Caution)
	-- 	else
	-- 		ESX.ShowNotification(_U('spawn_blocked'))
	-- 	end

	-- elseif zone.Type == 'vehdelete' then
	-- 	local jobObject = Config.Jobs[PlayerData.job.name]

	-- 	if jobObject then
	-- 		for k,v in pairs(jobObject.Zones) do
	-- 			if v.Type == 'vehdelete' and v.Spawner == zone.Spawner then
	-- 				local playerPed = PlayerPedId()

	-- 				if IsPedInAnyVehicle(playerPed, false) then
	-- 					local vehicle = GetVehiclePedIsIn(playerPed, false)
	-- 					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	-- 					local driverPed = GetPedInVehicleSeat(vehicle, -1)

	-- 					if playerPed == driverPed then
	-- 						if myPlate[plate] then
	-- 							myPlate[plate] = nil

	-- 							local vehicleHealth = GetVehicleEngineHealth(vehicleInCaseofDrop)

	-- 							-- fix for people using cheat engine to modify engine health
	-- 							if vehicleHealth > vehicleMaxHealth then
	-- 								vehicleHealth = vehicleMaxHealth
	-- 							end

	-- 							local giveBack = ESX.Math.Round(vehicleHealth / vehicleMaxHealth, 2)

	-- 							TriggerServerEvent('esx_jobs:caution', 'give_back', giveBack, 0, 0)
	-- 							DeleteVehicle(GetVehiclePedIsIn(playerPed, false))

	-- 							if v.Teleport ~= 0 then
	-- 								ESX.Game.Teleport(playerPed, v.Teleport)
	-- 							end

	-- 							if vehicleObjInCaseofDrop.HasCaution then
	-- 								vehicleInCaseofDrop, vehicleObjInCaseofDrop, vehicleMaxHealth = nil, nil, nil
	-- 							end
	-- 						end
	-- 					else
	-- 						ESX.ShowNotification(_U('not_your_vehicle'))
	-- 					end

	-- 				end

	-- 				break
	-- 			end
	-- 		end
	-- 	end
	-- elseif zone.Type == 'delivery' then
	-- 	if Blips.delivery then
	-- 		RemoveBlip(Blips.delivery)
	-- 		Blips.delivery = nil
	-- 	end

	-- 	hintToDisplay = nil
	-- 	hintIsShowed = false
	-- 	onWork = true
	-- 	local playerPed = PlayerPedId()
	-- 	local coords = GetEntityCoords(playerPed)

	-- 	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	-- 	Citizen.Wait(200)

	-- 	TriggerEvent("mythic_progressbar:client:progress", {
	-- 		name = "on_delivery",
	-- 		duration = 20000,
	-- 		label = "Tekan 'X' Untuk Cancel",
	-- 		useWhileDead = false,
	-- 		canCancel = true,
	-- 		controlDisables = {
	-- 			disableMovement = true,
	-- 			disableCarMovement = true,
	-- 			disableMouse = false,
	-- 			disableCombat = true,
	-- 		},
	-- 		animation = {
	-- 			task = "WORLD_HUMAN_CLIPBOARD",
	-- 		},
	-- 		prop = {
				
	-- 		},
	-- 	}, function(status)
	-- 		if not status then
	-- 			for k,v in pairs(zone.Item) do
	-- 				TriggerServerEvent("esx_jobs:alljobPayout",v.requires,v.price)
	-- 				onWork = false
	-- 			end
	-- 		end
	-- 	end)
	end

	--nextStep(zone.GPS)
end)

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = 'Cloakroom',
		align    = 'bottom-right',
		elements = {
			{label = 'Baju Kerja',     value = 'job_wear'},
			{label = 'Baju Sipil', value = 'citizen_wear'}
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'job_wear' then
			onDuty = true
			-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			-- 	if skin.sex == 0 then
			-- 		TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
			-- 	else
			-- 		TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
			-- 	end
            -- end)
            print ('ONDUTY WOI')
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end