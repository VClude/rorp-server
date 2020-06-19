local menuIsShowed, hasAlreadyEnteredMarker, isInMarker = false, false, false
ESX = nil
local PlayerData              = {}

local mbakajeng = {
	{type = 4, hash = 1167167044, x = -138.77, y = -634.05, z = 167.82, h = 5.14}
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
	end

	RequestModel(1167167044)
	while ( not HasModelLoaded( 1167167044 ) ) do
		Citizen.Wait( 1 )
	end

-- 	-- #### Spawners #### --
--   -- Spawn DJs
	  for _, item in pairs(mbakajeng) do
		mbakajeng =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.h, false, true)
		SetBlockingOfNonTemporaryEvents(mbakajeng, true)
		SetPedDiesWhenInjured(mbakajeng, false)
		SetPedCanPlayAmbientAnims(mbakajeng, false)
		SetPedCanRagdollFromPlayerImpact(mbakajeng, false)
		SetEntityInvincible(mbakajeng, true)
		FreezeEntityPosition(mbakajeng, true)
	end
	
	PlayerData = ESX.GetPlayerData()

	LoadMarkers()
	
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function LoadMarkers()
    Citizen.CreateThread(function()
    
        while true do
            Citizen.Wait(5)

            local plyCoords = GetEntityCoords(PlayerPedId())

            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 3.5 then

					DrawMarker(0, Enter['x'], Enter['y'], Enter['z'],0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 0, 100, false, true, 2, false, false, false, false)

					if dstCheckEnter <= 1.2 then
						ESX.ShowHelpNotification("Tekan ~INPUT_PICKUP~ Untuk Masuk")
						if IsControlJustPressed(0, 38) then
							Teleport(val, 'enter')
						end
					end

				end
				
				if dstCheckExit <= 3.5 then

					DrawMarker(1, Exit['x'], Exit['y'], Exit['z'],0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.2, 255, 255, 0, 100, false, true, 2, false, false, false, false)

					if dstCheckExit <= 1.2 then
						ESX.ShowHelpNotification("Tekan ~INPUT_PICKUP~ Untuk Keluar")
						if IsControlJustPressed(0, 38) then
							Teleport(val, 'exit')
						end

					end

                end

            end

        end

    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Exit'])

        DoScreenFadeIn(100)
    else
        DoScreenFadeOut(100)

        Citizen.Wait(750)

        ESX.Game.Teleport(PlayerPedId(), table['Enter'])

        DoScreenFadeIn(100)
    end
end

function ShowJobListingMenu()
	ESX.TriggerServerCallback('esx_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = 'List Pekerjaan',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_joblisting:setJob', data.current.job)
			ESX.ShowNotification(_U('new_job'))
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('esx_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for i=1, #Config.ZonesMarker, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.ZonesMarker[i], true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.ZonesMarker[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end

			if distance < (Config.ZoneSize.x / 2) then
				isInMarker = true
				ESX.ShowHelpNotification(_U('access_job_center'))
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_joblisting:hasExitedMarker')
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Zones, 1 do
		local blip = AddBlipForCoord(Config.Zones[i])

		SetBlipSprite (blip, 407)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 83)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 38) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
		end
	end
end)
