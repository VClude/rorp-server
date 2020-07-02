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

				-- if distance < v.Size.x then
				-- 	letSleep, isInMarker, currentZone, currentZoneIndex = false, true, v, k
				-- 	break
				-- end
			end

			-- if IsControlJustReleased(0, 38) and not menuIsShowed and isInMarker then
			-- 	if onDuty or currentZone.Type == 'cloakroom' or PlayerData.job.name == 'reporter' then
			-- 		TriggerEvent('esx_jobs:action', PlayerData.job.name, currentZone, currentZoneIndex)
			-- 	end
			-- end

			-- -- hide or show top left zone hints
			-- if isInMarker and not menuIsShowed then
			-- 	hintIsShowed = true
			-- 	if (onDuty or currentZone.Type == 'cloakroom' or PlayerData.job.name == 'reporter') and currentZone.Type ~= 'vehdelete' then
			-- 		hintToDisplay = currentZone.Hint
			-- 		hintIsShowed = true
			-- 	elseif currentZone.Type == 'vehdelete' and (onDuty or PlayerData.job.name == 'reporter') then
			-- 		local playerPed = PlayerPedId()

			-- 		if IsPedInAnyVehicle(playerPed, false) then
			-- 			local vehicle = GetVehiclePedIsIn(playerPed, false)
			-- 			local driverPed = GetPedInVehicleSeat(vehicle, -1)
			-- 			local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

			-- 			if playerPed == driverPed then
			-- 				if myPlate[plate] then
			-- 					hintToDisplay = currentZone.Hint
			-- 				end
			-- 			else
			-- 				hintToDisplay = _U('not_your_vehicle')
			-- 			end
			-- 		else
			-- 			hintToDisplay = _U('in_vehicle')
			-- 		end
			-- 		hintIsShowed = true
			-- 	elseif onDuty and currentZone.Spawner ~= spawner then
			-- 		hintToDisplay = _U('wrong_point')
			-- 		hintIsShowed = true
			-- 	else
			-- 		hintToDisplay = nil
			-- 		hintIsShowed = false
			-- 	end
			-- end

			-- if isInMarker and not hasAlreadyEnteredMarker then
			-- 	hasAlreadyEnteredMarker = true
			-- end

			-- if not isInMarker and hasAlreadyEnteredMarker then
			-- 	hasAlreadyEnteredMarker = false
			-- 	TriggerEvent('esx_jobs:hasExitedMarker', currentZone)
			-- end
		end

		-- for k,v in pairs(Config.PublicZones) do
		-- 	local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)

		-- 	if v.Marker ~= -1 and distance < Config.DrawDistance then
		-- 		DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
		-- 		letSleep = false
		-- 	end

		-- 	if distance < v.Size.x / 2 then
		-- 		letSleep, isInPublicMarker = false, true
		-- 		ESX.ShowHelpNotification(v.Hint)

		-- 		if IsControlJustReleased(0, 38) then
		-- 			ESX.Game.Teleport(playerPed, v.Teleport)
		-- 		end
		-- 	end
		-- end

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
