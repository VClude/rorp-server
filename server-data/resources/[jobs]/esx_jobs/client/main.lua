local menuIsShowed, hintIsShowed, hintToDisplay, hasAlreadyEnteredMarker, isInMarker, vehicleObjInCaseofDrop, vehicleInCaseofDrop, vehicleMaxHealth
local PlayerData, Blips, JobBlips, myPlate, onDuty, spawner = {}, {}, {}, {}, true, 0

ESX = nil

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = {
			{label = _U('job_wear'),     value = 'job_wear'},
			{label = _U('citizen_wear'), value = 'citizen_wear'}
	}}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'job_wear' then
			onDuty = true
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function MiningEvent()
	
	currentlyMining = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
	
	local pickaxe = GetHashKey("prop_tool_pickaxe")
	
	-- Loads model
	RequestModel(pickaxe)
    while not HasModelLoaded(pickaxe) do
      Wait(1)
    end
	
	local anim = "melee@hatchet@streamed_core_fps"
	local action = "plyr_front_takedown"
	
	 -- Loads animation
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
      Wait(1)
    end
	
	local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
	AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
	
	exports['progressBars']:startUI((10000), "MINING")
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	Citizen.Wait(2000)
	
	TriggerServerEvent("esx_jobs:reward",'stone',7)
	
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, false)
    DeleteObject(object)
	currentlyMining = false

end

-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		for k,v in pairs(Config.WasherLocation) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
-- 			if distance <= 20.0 and not currentlyWashing then
-- 				DrawMarker(Config.WasherMarker, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.WasherMarkerScale.x, Config.WasherMarkerScale.y, Config.WasherMarkerScale.z, Config.WasherMarkerColor.r,Config.WasherMarkerColor.g,Config.WasherMarkerColor.b,Config.WasherMarkerColor.a, false, true, 2, true, false, false, false)					
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.2 and not currentlyWashing then
-- 				DrawText3Ds(v.x, v.y, v.z, Config.DrawWasher3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartWashing) then
-- 					ESX.RegisterServerCallback("esx_jobs:getPickaxe",function(isMiner)
-- 						if isMiner then
-- 							WasherEvent()
-- 						else
-- 							ESX.ShowNotification('Kamu bukan penambang batu')
-- 						end
-- 					end)					
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- end)

function WasherEvent()
	
	currentlyWashing = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
	
	ESX.TriggerServerCallback("esx_jobs:removeStone", function(stoneCount)
		if stoneCount then
			exports['progressBars']:startUI((10000), "WASHING STONE")
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.Wait(10000)
			TriggerServerEvent("esx_jobs:reward",'washed_stone',7)	
		else
			ESX.ShowNotification("Kamu membutuhkan ~y~7x Batu~s~ serta Menjadi Penambang untuk ~b~Mencuci~s~ disini!")
		end
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)
		currentlyWashing = false
	end)
end



-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		for k,v in pairs(Config.SmelterSpots) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
-- 			if distance <= 20.0 and not currentlySmelting then
-- 				DrawMarker(Config.SmelterMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.SmelterMarkerScale.x, Config.SmelterMarkerScale.y, Config.SmelterMarkerScale.z, Config.SmelterMarkerColor.r,Config.SmelterMarkerColor.g,Config.SmelterMarkerColor.b,Config.SmelterMarkerColor.a, false, true, 2, true, false, false, false)					
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.0 and not currentlySmelting then
-- 				DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawSmelter3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartSmelting) then
-- 					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--                     if closestPlayer == -1 or closestDistance >= 0.7 then
-- 						ESX.TriggerServerCallback("esx_jobs:getWashedStone", function(WashedStone)
-- 							SmeltingEvent()
-- 						end)
-- 					else
-- 						ESX.ShowNotification("Kamu terlalu dekat dengan yang lain")
-- 					end
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- end)

function SmeltingEvent()
	
	currentlySmelting = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
		
	exports['progressBars']:startUI((10000), "SMELTING WASHED STONE")
	Citizen.Wait(10000)
	
	TriggerServerEvent("esx_jobs:rewardSmelting")
	
	FreezeEntityPosition(playerPed, false)
	currentlySmelting = false

end

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- end function custom miner
AddEventHandler('esx_jobs:action', function(job, zone, zoneIndex)
	menuIsShowed = true
	if zone.Type == 'cloakroom' then
		OpenMenu()
	elseif zone.Type == 'work' then
		hintToDisplay = nil
		hintIsShowed = false
		local playerPed = PlayerPedId()
		
		if IsPedOnFoot(playerPed) then

			onWork = true
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			
			-- FreezeEntityPosition(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
			Citizen.Wait(200)

			TriggerEvent("mythic_progressbar:client:progress", {
				name = "on_working",
				duration = zone.Duration,
				label = "Tekan 'X' Untuk Cancel",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					task = "CODE_HUMAN_MEDIC_TIME_OF_DEATH",
				},
				prop = {

				},
			}, function(status)
				if not status then
					for k,v in pairs(zone.Item) do
						TriggerServerEvent("esx_jobs:alljobReward",v.db_name,v.add, v.requires, v.remove)
						onWork = false
					end
				end
			end)
		else
			ESX.ShowNotification(_U('foot_work'))
		end
	elseif zone.Type == 'vehspawner' then
		local jobObject, spawnPoint, vehicle = Config.Jobs[PlayerData.job.name]

		print (Config.Jobs[PlayerData.job.name])

		if jobObject then
			for k,v in pairs(jobObject.Zones) do
				if v.Type == 'vehspawnpt' and v.Spawner == zone.Spawner then
					spawnPoint = v
					spawner = v.Spawner
					break
				end
				
			end

			for k,v in pairs(jobObject.Vehicles) do
				if v.Spawner == zone.Spawner then
					vehicle = v
					break
				end
			end
		end

		if jobObject and spawnPoint and vehicle and ESX.Game.IsSpawnPointClear(spawnPoint.Pos, 5.0) then
			spawnVehicle(spawnPoint, vehicle, zone.Caution)
		else
			ESX.ShowNotification(_U('spawn_blocked'))
		end

	elseif zone.Type == 'vehdelete' then
		local jobObject = Config.Jobs[PlayerData.job.name]

		if jobObject then
			for k,v in pairs(jobObject.Zones) do
				if v.Type == 'vehdelete' and v.Spawner == zone.Spawner then
					local playerPed = PlayerPedId()

					if IsPedInAnyVehicle(playerPed, false) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
						local driverPed = GetPedInVehicleSeat(vehicle, -1)

						if playerPed == driverPed then
							if myPlate[plate] then
								myPlate[plate] = nil

								local vehicleHealth = GetVehicleEngineHealth(vehicleInCaseofDrop)

								-- fix for people using cheat engine to modify engine health
								if vehicleHealth > vehicleMaxHealth then
									vehicleHealth = vehicleMaxHealth
								end

								local giveBack = ESX.Math.Round(vehicleHealth / vehicleMaxHealth, 2)

								TriggerServerEvent('esx_jobs:caution', 'give_back', giveBack, 0, 0)
								DeleteVehicle(GetVehiclePedIsIn(playerPed, false))

								if v.Teleport ~= 0 then
									ESX.Game.Teleport(playerPed, v.Teleport)
								end

								if vehicleObjInCaseofDrop.HasCaution then
									vehicleInCaseofDrop, vehicleObjInCaseofDrop, vehicleMaxHealth = nil, nil, nil
								end
							end
						else
							ESX.ShowNotification(_U('not_your_vehicle'))
						end

					end

					break
				end
			end
		end
	elseif zone.Type == 'delivery' then
		if Blips.delivery then
			RemoveBlip(Blips.delivery)
			Blips.delivery = nil
		end

		hintToDisplay = nil
		hintIsShowed = false
		onWork = true
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
		Citizen.Wait(200)

		TriggerEvent("mythic_progressbar:client:progress", {
			name = "on_delivery",
			duration = 20000,
			label = "Tekan 'X' Untuk Cancel",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				task = "WORLD_HUMAN_CLIPBOARD",
			},
			prop = {
				
			},
		}, function(status)
			if not status then
				for k,v in pairs(zone.Item) do
					TriggerServerEvent("esx_jobs:alljobPayout",v.requires,v.price)
					onWork = false
				end
			end
		end)
	end

	--nextStep(zone.GPS)
end)

function nextStep(gps)
	if gps ~= 0 then
		if Blips.delivery then
			RemoveBlip(Blips.delivery)
			Blips.delivery = nil
		end

		Blips.delivery = AddBlipForCoord(gps.x, gps.y, gps.z)
		SetBlipRoute(Blips.delivery, true)
		ESX.ShowNotification(_U('next_point'))
	end
end

AddEventHandler('esx_jobs:hasExitedMarker', function(zone)
	TriggerServerEvent('esx_jobs:stopWork')
	hintToDisplay = nil
	menuIsShowed = false
	hintIsShowed = false
	isInMarker = false
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	myPlate = {} -- loosing vehicle caution in case player changes job.
	spawner = 0
	deleteBlips()
	refreshBlips()
end)

function deleteBlips()
	for k,v in ipairs(JobBlips) do
		RemoveBlip(v)
		JobBlips[k] = nil
	end
end

function refreshBlips()
	if PlayerData.job then
		local jobObject = Config.Jobs[PlayerData.job.name]
		if jobObject then
			for k,v in pairs(jobObject.Zones) do
				if v.Blip then
					local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

					SetBlipSprite  (blip, jobObject.BlipInfos.Sprite)
					SetBlipScale   (blip, 1.0)
					SetBlipCategory(blip, 3)
					SetBlipColour  (blip, jobObject.BlipInfos.Color)
					SetBlipAsShortRange(blip, true)

					BeginTextCommandSetBlipName('STRING')
					AddTextComponentSubstringPlayerName(v.Name)
					EndTextCommandSetBlipName(blip)

					table.insert(JobBlips, blip)
				end
			end
		end
	end
end

function spawnVehicle(spawnPoint, vehicle, vehicleCaution)
	hintToDisplay = nil
	hintIsShowed = false
	TriggerServerEvent('esx_jobs:caution', 'take', vehicleCaution, spawnPoint, vehicle)
end

RegisterNetEvent('esx_jobs:spawnJobVehicle')
AddEventHandler('esx_jobs:spawnJobVehicle', function(spawnPoint, vehicle)
	local playerPed = PlayerPedId()
	ESX.Game.SpawnVehicle(vehicle.Hash, spawnPoint.Pos, spawnPoint.Heading, function(spawnedVehicle)

		if vehicle.Trailer ~= 'none' then
			ESX.Game.SpawnVehicle(vehicle.Trailer, spawnPoint.Pos, spawnPoint.Heading, function(trailer)
				AttachVehicleToTrailer(spawnedVehicle, trailer, 1.1)
			end)
		end

		-- save & set plate
		local plate = 'WORK' .. math.random(100, 900)
		SetVehicleNumberPlateText(spawnedVehicle, plate)
		myPlate[plate] = true
		TriggerEvent("carremote:grantKeys", spawnedVehicle)

		TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

		if vehicle.HasCaution then
			vehicleInCaseofDrop = spawnedVehicle
			vehicleObjInCaseofDrop = vehicle
			vehicleMaxHealth = GetVehicleEngineHealth(spawnedVehicle)
		end
	end)
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
		if PlayerData == nil then

		elseif PlayerData.job == nil then

		else
			if Config.Jobs[PlayerData.job.name] then
				zones = Config.Jobs[PlayerData.job.name].Zones
			end

			for k,v in pairs(zones) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)

				if onDuty or v.Type == 'cloakroom' or PlayerData.job.name == 'reporter' then
					if(v.Marker ~= -1 and distance < Config.DrawDistance) then
						letSleep = false
						DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					end
				end

				if distance < v.Size.x then
					letSleep, isInMarker, currentZone, currentZoneIndex = false, true, v, k
					break
				end
			end

			if IsControlJustReleased(0, 38) and not menuIsShowed and isInMarker then
				if onDuty or currentZone.Type == 'cloakroom' or PlayerData.job.name == 'reporter' then
					TriggerEvent('esx_jobs:action', PlayerData.job.name, currentZone, currentZoneIndex)
				end
			end

			-- hide or show top left zone hints
			if isInMarker and not menuIsShowed then
				hintIsShowed = true
				if (onDuty or currentZone.Type == 'cloakroom' or PlayerData.job.name == 'reporter') and currentZone.Type ~= 'vehdelete' then
					hintToDisplay = currentZone.Hint
					hintIsShowed = true
				elseif currentZone.Type == 'vehdelete' and (onDuty or PlayerData.job.name == 'reporter') then
					local playerPed = PlayerPedId()

					if IsPedInAnyVehicle(playerPed, false) then
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						local driverPed = GetPedInVehicleSeat(vehicle, -1)
						local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

						if playerPed == driverPed then
							if myPlate[plate] then
								hintToDisplay = currentZone.Hint
							end
						else
							hintToDisplay = _U('not_your_vehicle')
						end
					else
						hintToDisplay = _U('in_vehicle')
					end
					hintIsShowed = true
				elseif onDuty and currentZone.Spawner ~= spawner then
					hintToDisplay = _U('wrong_point')
					hintIsShowed = true
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
				TriggerEvent('esx_jobs:hasExitedMarker', currentZone)
			end
		end

		for k,v in pairs(Config.PublicZones) do
			local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)

			if v.Marker ~= -1 and distance < Config.DrawDistance then
				DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < v.Size.x / 2 then
				letSleep, isInPublicMarker = false, true
				ESX.ShowHelpNotification(v.Hint)

				if IsControlJustReleased(0, 38) then
					ESX.Game.Teleport(playerPed, v.Teleport)
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	-- Slaughterer
	RemoveIpl('CS1_02_cf_offmission')
end)
