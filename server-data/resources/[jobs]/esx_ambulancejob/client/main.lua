isDead = false
ESX = nil
local radarEsteso = false
local mostrablip = false
local mostranomi = false
local firstSpawn, PlayerLoaded = true, false
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

isSearched = false
medic =  0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
	print(ESX.PlayerData.job.name)
	if ESX.PlayerData.job.name == 'ambulance' then
		mostrablip = true
	else
		mostrablip = false
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if ESX.PlayerData.job.name == 'ambulance' then
	mostrablip = true
	else
	mostrablip = false
	end
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

		if Config.AntiCombatLog then
			while not PlayerLoaded do
				Citizen.Wait(1000)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
				if shouldDie then
					Citizen.Wait(1000)
					exports['mythic_notify']:DoCustomHudText('inform', _U('combatlog_message'), 5000)
					SetEntityHealth(GetPlayerPed(-1),0)
					-- RemoveItemsAfterRPDeath()					
				end
			end)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForRadius(v.Blip.coords, 50.0)
		
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 2)
		SetBlipAlpha (blip, 128)

		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('blip_hospital'))
		EndTextCommandSetBlipName(blip)
	end
end)


-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isDead then
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)
		else
			Citizen.Wait(500)
		end
	end
end)

function OnPlayerDeath()
	isDead = true
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)

	StartDeathTimer()
	StartDistressSignal()

	StartScreenEffect('DeathFailOut', 0, false)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('esx_ambulancejob:server:LeaveBed', bedOccupying)

    FreezeEntityPosition(bedObject, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isDead and isSearched then
			local playerPed = PlayerPedId()
			local ped = GetPlayerPed(GetPlayerFromServerId(medic))
			isSearched = false

			AttachEntityToEntity(playerPed, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			Citizen.Wait(1000)
			DetachEntity(playerPed, true, false)
			ClearPedTasksImmediately(playerPed)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:clsearch')
AddEventHandler('esx_ambulancejob:clsearch', function(medicId)
	local playerPed = PlayerPedId()

	if isDead then
		local coords = GetEntityCoords(playerPed)
		local playersInArea = ESX.Game.GetPlayersInArea(coords, 50.0)

		for i=1, #playersInArea, 1 do
			local player = playersInArea[i]
			if player == GetPlayerFromServerId(medicId) then
				medic = tonumber(medicId)
				isSearched = true
				break
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			--ESX.ShowNotification(_U('used_medikit'))
			exports['mythic_notify']:DoCustomHudText('inform', _U('used_medikit'), 5000)
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			--ESX.ShowNotification(_U('used_bandage'))
			exports['mythic_notify']:DoCustomHudText('inform', _U('used_bandage'), 5000)
		end)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and isDead do
			Citizen.Wait(0)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlJustReleased(0, 47) then
				SendDistressSignal()
				break
			end
		end
	end)
end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	exports['mythic_notify']:DoCustomHudText('inform', _U('distress_sent'), 5000)

    TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format('%02.f', math.floor(seconds / 3600))
		local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, 38) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, 38) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine')
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local playerpos = Config.RespawnPoint.coords
				
			ESX.SetPlayerData('lastPosition', playerpos)
			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), playerpos, Config.RespawnPoint.heading)

			TriggerServerEvent('esx:updateLastPosition', playerpos)
			Citizen.Wait(10)
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
			-- ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
		end)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAABp5JREFUWIW1l21sFNcVhp/58npn195de23Ha4Mh2EASSvk0CPVHmmCEI0RCTQMBKVVooxYoalBVCVokICWFVFVEFeKoUdNECkZQIlAoFGMhIkrBQGxHwhAcChjbeLcsYHvNfsx+zNz+MBDWNrYhzSvdP+e+c973XM2cc0dihFi9Yo6vSzN/63dqcwPZcnEwS9PDmYoE4IxZIj+ciBb2mteLwlZdfji+dXtNU2AkeaXhCGteLZ/X/IS64/RoR5mh9tFVAaMiAldKQUGiRzFp1wXJPj/YkxblbfFLT/tjq9/f1XD0sQyse2li7pdP5tYeLXXMMGUojAiWKeOodE1gqpmNfN2PFeoF00T2uLGKfZzTwhzqbaEmeYWAQ0K1oKIlfPb7t+7M37aruXvEBlYvnV7xz2ec/2jNs9kKooKNjlksiXhJfLqf1PXOIU9M8fmw/XgRu523eTNyhhu6xLjbSeOFC6EX3t3V9PmwBla9Vv7K7u85d3bpqlwVcvHn7B8iVX+IFQoNKdwfstuFtWoFvwp9zj5XL7nRlPXyudjS9z+u35tmuH/lu6dl7+vSVXmDUcpbX+skP65BxOOPJA4gjDicOM2PciejeTwcsYek1hyl6me5nhNnmwPXBhjYuGC699OpzoaAO0PbYJSy5vgt4idOPrJwf6QuX2FO0oOtqIgj9pDU5dCWrMlyvXf86xsGgHyPeLos83Brns1WFXLxxgVBorHpW4vfQ6KhkbUtCot6srns1TLPjNVr7+1J0PepVc92H/Eagkb7IsTWd4ZMaN+yCXv5zLRY9GQ9xuYtQz4nfreWGdH9dNlkfnGq5/kdO88ekwGan1B3mDJsdMxCqv5w2Iq0khLs48vSllrsG/Y5pfojNugzScnQXKBVA8hrX51ddHq0o6wwIlgS8Y7obZdUZVjOYLC6e3glWkBBVHC2RJ+w/qezCuT/2sV6Q5VYpowjvnf/iBJJqvpYBgBS+w6wVB5DLEOiTZHWy36nNheg0jUBs3PoJnMfyuOdAECqrZ3K7KcACGQp89RAtlysCphqZhPtRzYlcPx+ExklJUiq0le5omCfOGFAYn3qFKS/fZAWS7a3Y2wa+GJOEy4US+B3aaPUYJamj4oI5LA/jWQBt5HIK5+JfXzZsJVpXi/ac8+mxWIXWzAG4Wb4g/jscNMp63I4U5FcKaVvsNyFALokSA47Kx8PVk83OabCHZsiqwAKEpjmfUJIkoh/R+L9oTpjluhRkGSPG4A7EkS+Y3HZk0OXYpIVNy01P5yItnptDsvtIwr0SunqoVP1GG1taTHn1CloXm9aLBEIEDl/IS2W6rg+qIFEYR7+OJTesqJqYa95/VKBNOHLjDBZ8sDS2998a0Bs/F//gvu5Z9NivadOc/U3676pEsizBIN1jCYlhClL+ELJDrkobNUBfBZqQfMN305HAgnIeYi4OnYMh7q/AsAXSdXK+eH41sykxd+TV/AsXvR/MeARAttD9pSqF9nDNfSEoDQsb5O31zQFprcaV244JPY7bqG6Xd9K3C3ALgbfk3NzqNE6CdplZrVFL27eWR+UASb6479ULfhD5AzOlSuGFTE6OohebElbcb8fhxA4xEPUgdTK19hiNKCZgknB+Ep44E44d82cxqPPOKctCGXzTmsBXbV1j1S5XQhyHq6NvnABPylu46A7QmVLpP7w9pNz4IEb0YyOrnmjb8bjB129fDBRkDVj2ojFbYBnCHHb7HL+OC7KQXeEsmAiNrnTqLy3d3+s/bvlVmxpgffM1fyM5cfsPZLuK+YHnvHELl8eUlwV4BXim0r6QV+4gD9Nlnjbfg1vJGktbI5UbN/TcGmAAYDG84Gry/MLLl/zKouO2Xukq/YkCyuWYV5owTIGjhVFCPL6J7kLOTcH89ereF1r4qOsm3gjSevl85El1Z98cfhB3qBN9+dLp1fUTco+0OrVMnNjFuv0chYbBYT2HcBoa+8TALyWQOt/ImPHoFS9SI3WyRajgdt2mbJgIlbREplfveuLf/XXemjXX7v46ZxzPlfd8YlZ01My5MUEVdIY5rueYopw4fQHkbv7/rZkTw6JwjyalBCHur9iD9cI2mU0UzD3P9H6yZ1G5dt7Gwe96w07dl5fXj7vYqH2XsNovdTI6KMrlsAXhRyz7/C7FBO/DubdVq4nBLPaohcnBeMr3/2k4fhQ+Uc8995YPq2wMzNjww2X+vwNt1p00ynrd2yKDJAVN628sBX1hZIdxXdStU9G5W2bd9YHR5L3f/CNmJeY9G8WAAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}
	TriggerEvent('skeletalsystem:HealBones',"all")

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	ClearTimecycleModifier()

	StopGameplayCamShaking(true)
	-- ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
	ResetPedMovementClipset(playerPed, 0.0)
	
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	RequestIpl('Coroner_Int_on') -- Morgue
end

RegisterNetEvent('esx_ambulancejob:client:SendToBed')
AddEventHandler('esx_ambulancejob:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()

        exports['mythic_notify']:SendAlert('inform', 'Dokter sedang menyembuhkan anda.')
        Citizen.Wait(5000)
        TriggerServerEvent('esx_ambulancejob:server:EnteredBed')
    end)
end)

RegisterNetEvent('esx_ambulancejob:client:FinishServices')
AddEventHandler('esx_ambulancejob:client:FinishServices', function()
	local player = PlayerPedId()
	
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
	end
	
	SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    TriggerEvent('esx_ambulancejob:revive')
    exports['mythic_notify']:SendAlert('inform', 'Kamu telah di sembuhkan.')
    LeaveBed()
end)

RegisterNetEvent('mostraBlips')
AddEventHandler('mostraBlips', function()
    mostrablip = not mostrablip
    if mostrablip then
        mostrablip = true
    else
        mostrablip = false
    end
end)

Citizen.CreateThread(function()
    while true do
    Wait(1)
    -- controllo del giocatore, se esiste e ha un id.
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1) then
            ped = GetPlayerPed(i)
            blip = GetBlipFromEntity(ped)
            -- Crea il nome sulla testa del giocatore
            idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(i), false, false, "", false)
			-- if IsPedDeadOrDying(ped, 0) then
			-- 	RemoveBlip(blip)
			-- end
            if mostrablip and IsPedDeadOrDying(ped, 1) then
                if not DoesBlipExist(blip) then -- Con questo aggiungo i blip sulla testa dei giocatori.
                    blip = AddBlipForEntity(ped)
                    SetBlipSprite(blip, 1) -- imposto il blip sulla posizione "blip" con l'id 1
                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                else -- se il blip esiste, allora lo aggiorno
                    veh = GetVehiclePedIsIn(ped, false) -- questo lo uso per aggiornare ogni volta il veicolo su cui il ped è salito
                    blipSprite = GetBlipSprite(blip)
                    if not GetEntityHealth(ped) then -- controllo se il giocatore è morto o no
                        if blipSprite ~= 274 then
                            SetBlipSprite(blip, 274)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                        end
                    elseif veh then -- controllo se il giocatore è su un veicolo.
                        calsseVeicolo = GetVehicleClass(veh)
                        modelloVeicolo = GetEntityModel(veh)
                        if calsseVeicolo == 15 then -- La classe 15 indica un veicolo volante
                            if blipSprite ~= 422 then -- controllo se il blip non è il 422, ovvero l'aereo
                                SetBlipSprite(blip, 422) -- se true lo imposto.
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif calsseVeicolo == 16 then -- controllo se il ped sta su un aereo
                            if modelloVeicolo == GetHashKey("besra") or modelloVeicolo == GetHashKey("hydra") or modelloVeicolo == GetHashKey("lazer") then -- controllo se il modello è un jet militare
                                if blipSprite ~= 424 then
                                    SetBlipSprite(blip, 424)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif blipSprite ~= 423 then
                                SetBlipSprite(blip, 423)
                                Citizen.InvokeNative (0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif calsseVeicolo == 14 then -- boat
                            if blipSprite ~= 427 then
                                SetBlipSprite(blip, 427)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif modelloVeicolo == GetHashKey("insurgent") or modelloVeicolo == GetHashKey("insurgent2") or modelloVeicolo == GetHashKey("limo2") then
                                if blipSprite ~= 426 then
                                    SetBlipSprite(blip, 426)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif modelloVeicolo == GetHashKey("rhino") then -- tank
                                if blipSprite ~= 421 then
                                    SetBlipSprite(blip, 421)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif blipSprite ~= 1 then -- default blip
                                SetBlipSprite(blip, 1)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                            end
                            -- Show number in case of passangers
                            passengers = GetVehicleNumberOfPassengers(veh)
                            if passengers then
                                if not IsVehicleSeatFree(veh, -1) then
                                    passengers = passengers + 1
                                end
                                ShowNumberOnBlip(blip, passengers)
                            else
                                HideNumberOnBlip(blip)
                            end
                        else
                            -- Se nessuno degli else per le auto viene verificato, allora setto il blip normale.
                            HideNumberOnBlip(blip)
                            if blipSprite ~= 1 then -- il blip default è 1
                                SetBlipSprite(blip, 1)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                            end
                        end
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(veh))) -- con questo aggiorno la rotazione a seconda del veicolo
                        SetBlipNameToPlayerName(blip, i) -- aggirono il blip del giocatore
                        SetBlipScale(blip, 0.85) -- dimensione
                        -- se il menù con la mappa grande è aperto, allora setto il blip con un alpha massimo
                        -- con questo poi controllo la distanza dal giocatore per il nome sulla testa
                        if IsPauseMenuActive() then
                            SetBlipAlpha(blip, 255)
                        else -- se la prima non è confermata
                            x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) -- non ho messo la z perché non mi serve
                            x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(i), true)) -- uguale qua sotto
                            distanza = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                            -- lo ho fatto così perché si....
                            if distanza < 0 then
                                distanza = 0
                            elseif distanza > 255 then
                                distanza = 255
                            end
                            SetBlipAlpha(blip, distanza)
                        end
                    end
                else
                    RemoveBlip(blip)
                end
            end
		end

    end
end)