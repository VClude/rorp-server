local menuIsShowed, hasAlreadyEnteredMarker, isInMarker = false, false, false
ESX = nil
local PlayerData              = {}

local pakjoni = {
	{type = 4, hash = 2705543429, x = -145.18, y = -643.49, z = 167.82, h = 273.2}
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
	end

	RequestModel(2705543429)
	while ( not HasModelLoaded( 2705543429 ) ) do
		Citizen.Wait( 1 )
	end

-- 	-- #### Spawners #### --
--   -- Spawn DJs
	  for _, item in pairs(pakjoni) do
		pakjoni =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.h, false, true)
		SetBlockingOfNonTemporaryEvents(pakjoni, true)
		SetPedDiesWhenInjured(pakjoni, false)
		SetPedCanPlayAmbientAnims(pakjoni, false)
		SetPedCanRagdollFromPlayerImpact(pakjoni, false)
		SetEntityInvincible(pakjoni, true)
		FreezeEntityPosition(pakjoni, true)
	end
	
	PlayerData = ESX.GetPlayerData()
	
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Blips, 1 do
		local blip = AddBlipForCoord(Config.Blips[i])
		SetBlipSprite (blip, 304)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('VIP Service')
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


function ShowRewardListingMenu()
ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rewardmenu', {
	title    = 'Pengambilan Hadiah',
	align    = 'bottom-right',
	elements = {
		{label = 'Belum ada data', value = 'test'},
		},
}, function(data, menu)
	ESX.ShowNotification('Work In Progress')
	end)
end

AddEventHandler('rorp_vipservice:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end

			if distance < (Config.ZoneSize.x / 2) then
				isInMarker = true
				ESX.ShowHelpNotification(_U('access_reward_center'))
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('rorp_vipservice:hasExitedMarker')
		end
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, 38) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowRewardListingMenu()
		end
	end
end)
