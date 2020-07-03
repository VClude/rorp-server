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
	PlayerData.job = job
	onDuty = false
	myPlate = {} -- loosing vehicle caution in case player changes job.
	spawner = 0
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

-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		for k,v in pairs(Config.MiningSpots) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
-- 			if distance <= 20.0 and not currentlyMining then
-- 				DrawMarker(Config.MiningMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MiningMarkerScale.x, Config.MiningMarkerScale.y, Config.MiningMarkerScale.z, Config.MiningMarkerColor.r,Config.MiningMarkerColor.g,Config.MiningMarkerColor.b,Config.MiningMarkerColor.a, false, true, 2, true, false, false, false)					
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.0 and not currentlyMining then
-- 				DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawMining3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartMining) then
-- 					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--                     if closestPlayer == -1 or closestDistance >= 1 then
-- 						ESX.TriggerServerCallback("esx_MinerJob:getPickaxe", function(pickaxe)
-- 							if pickaxe then
-- 								MiningEvent()	
-- 							else
-- 								ESX.ShowNotification("You need a ~y~pickaxe~s~ to ~b~mine~s~ here!")
-- 							end
--                         end)
--                         print('Menambang')
-- 					else
-- 						ESX.ShowNotification("You are too close to another player")
-- 					end
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- end)

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
        
        if PlayerData ~= nil and PlayerData.job.name == 'miner' then

            local zones = Config.Miner.Zones

			for k,v in pairs(zones) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Coords.x, v.Coords.y, v.Coords.z, true)

				if onDuty or v.Type == 'cloakroom' then
					if(v.Marker ~= -1 and distance < Config.DrawDistance) then
						letSleep = false
						DrawMarker(v.Marker, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					end
				end

				if distance < v.Size.x and v.Marker ~= -1 then
					letSleep, isInMarker, currentZone, currentZoneIndex = false, true, v, k
					break
				end
			end

			if IsControlJustReleased(0, 38) and not menuIsShowed and isInMarker then
                if onDuty or currentZone.Type == 'cloakroom' then
					TriggerEvent('rorp_miner:action', PlayerData.job.name, currentZone, currentZoneIndex)
				end
			end

			-- hide or show top left zone hints
			if isInMarker and not menuIsShowed then
				hintIsShowed = true
				if (onDuty or currentZone.Type == 'cloakroom') and currentZone.Type ~= 'vehdelete' then
					hintToDisplay = currentZone.Hint
					hintIsShowed = true
				elseif currentZone.Type == 'vehdelete' and onDuty then
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
				TriggerEvent('rorp_miner:hasExitedMarker')
			end
        end
        
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

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


function deleteBlips()
	for _,v in ipairs(jobBlips) do
		RemoveBlip(v)
	end
end

function refreshBlips()
    if PlayerData.job then
        if PlayerData.job.name == 'miner' then
            for k,v in pairs(Config.Miner.Zones) do
                if v.Blip then
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
    end
end

-- end function custom miner
AddEventHandler('rorp_miner:action', function(job, zone, zoneIndex)
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
	elseif zone.Type == 'wash' then
		hintToDisplay = nil
		hintIsShowed = false
		WasherEvent()
	elseif zone.Type == 'vehspawner' then
		local jobObject, spawnPoint, vehicle = Config.Miner

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

		if jobObject and spawnPoint and vehicle and ESX.Game.IsSpawnPointClear(spawnPoint.Coords, 5.0) then
            spawnVehicle(spawnPoint, vehicle, zone.Caution)
		else
			ESX.ShowNotification('Spawn Blocked')
		end

	elseif zone.Type == 'vehdelete' then
		local jobObject = Config.Miner

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

function spawnVehicle(spawnPoint, vehicle, vehicleCaution)
	hintToDisplay = nil
	hintIsShowed = false
	TriggerServerEvent('rorp_miner:caution', 'take', vehicleCaution, spawnPoint, vehicle)
end

RegisterNetEvent('rorp_miner:spawnJobVehicle')
AddEventHandler('rorp_miner:spawnJobVehicle', function(spawnPoint, vehicle)
	local playerPed = PlayerPedId()
    ESX.Game.SpawnVehicle(vehicle.Hash, spawnPoint.Coords, spawnPoint.Heading, function(spawnedVehicle)

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

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if PlayerData ~= nil and PlayerData.job.name == 'miner' then
			for k,v in pairs(Config.MiningSpots) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if distance <= 20.0 and not currentlyMining and onDuty then
					DrawMarker(Config.MiningMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MiningMarkerScale.x, Config.MiningMarkerScale.y, Config.MiningMarkerScale.z, Config.MiningMarkerColor.r,Config.MiningMarkerColor.g,Config.MiningMarkerColor.b,Config.MiningMarkerColor.a, false, true, 2, true, false, false, false)					
				else
					Citizen.Wait(1000)
				end	
				if distance <= 1.0 and not currentlyMining and onDuty then
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawMining3DText)
					if IsControlJustPressed(0, Config.KeyToStartMining) then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance >= 1 then
							MiningEvent()
						else
							ESX.ShowNotification("You are too close to another player")
						end
						Citizen.Wait(300)
					end
				end
			end	
		end	
	end
end)

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
	
	TriggerServerEvent("rorp_miner:reward",'stone',1)
	
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, false)
    DeleteObject(object)
	currentlyMining = false

end

function WasherEvent()
	
	currentlyWashing = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
	
	ESX.TriggerServerCallback("rorp_miner:ReqItem", function(stoneCount)
		if stoneCount then
			exports['progressBars']:startUI((10000), "WASHING STONE")
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			Citizen.Wait(10000)
			TriggerServerEvent("rorp_miner:reward",'washed_stone',1)	
		else
			ESX.ShowNotification("You need a ~y~1x Stone~s~ to ~b~Wash~s~ here!")
		end
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)
		currentlyWashing = false
	end,'stone',1)
end