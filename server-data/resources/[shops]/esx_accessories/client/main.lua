ESX	= nil
local HasAlreadyEnteredMarker, isDead, hasPaid = false, false, false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData	= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory', {
		title = _U('set_unset'),
		align = 'top-left',
		elements = {
			{label = _U('helmet'), value = 'Helmet'},
			{label = _U('ears'), value = 'Ears'},
			{label = _U('mask'), value = 'Mask'},
			{label = _U('glasses'), value = 'Glasses'},
			{label = _U('put_clothes'), value = 'restore'},
			{label = _U('remove_shirt'), value = 'shirt'},
			{label = _U('remove_pants'), value = 'pants'},
			{label = _U('remove_shoes'), value = 'shoes'},
		}}, function(data, menu)
		menu.close()
		if data.current.value ~= 'Helmet' and data.current.value ~= 'Ears' and data.current.value ~= 'Mask' and data.current.value ~= 'Glasses' then
			if data.current.value == 'restore' then			
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				ESX.UI.Menu.CloseAll()	
			elseif data.current.value == 'shirt' then
				TriggerEvent('esx_accessories:shirt')
				ESX.UI.Menu.CloseAll()	
			elseif data.current.value == 'pants' then
				TriggerEvent('esx_accessories:pants')
				ESX.UI.Menu.CloseAll()	
			elseif data.current.value == 'shoes' then
				TriggerEvent('esx_accessories:shoes')
				ESX.UI.Menu.CloseAll()	
			end
		else
			SetUnsetAccessory(data.current.value)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
					if _accessory ~= "ears" then
						TriggerEvent(_accessory, true)
						Wait(500)
					end
				else
					if _accessory ~= "ears" then
						TriggerEvent(_accessory, false)
						Wait(500)
					end
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end
	end, accessory)
end

function OpenShopMenu(accessory)
	hasPaid = false
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'}
			}}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
					if hasEnoughMoney then
						TriggerServerEvent('esx_accessories:pay')
						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_accessories:save', skin, accessory)
						end)
						hasPaid = true
					else
						TriggerEvent('esx_skin:getLastSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			end

			if data.current.value == 'no' then
				local player = PlayerPedId()
				TriggerEvent('esx_skin:getLastSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				if accessory == "Ears" then
					ClearPedProp(player, 2)
				elseif accessory == "Mask" then
					SetPedComponentVariation(player, 1, 0 ,0, 2)
				elseif accessory == "Helmet" then
					ClearPedProp(player, 0)
				elseif accessory == "Glasses" then
					SetPedPropIndex(player, 1, -1, 0, 0)
				end
			end
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
AddEventHandler('esx:onPlayerDeath', function() isDead = true end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not hasPaid then
		local player = PlayerPedId()
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		if accessory == "Ears" then
			ClearPedProp(player, 2)
		elseif accessory == "Mask" then
			SetPedComponentVariation(player, 1, 0 ,0, 2)
		elseif accessory == "Helmet" then
			ClearPedProp(player, 0)
		elseif accessory == "Glasses" then
			SetPedPropIndex(player, 1, -1, 0, 0)
		end
	end
end)

-- Create Blips --
Citizen.CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos ~= nil then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i])

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.8)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i], true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone = nil
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if GetDistanceBetweenCoords(coords, v.Pos[i], true) < Config.Size.x then
					isInMarker  = true
					currentZone = k
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		elseif CurrentAction and not Config.EnableControls then
			Citizen.Wait(500)
		end

		if Config.EnableControls then
			if IsControlJustReleased(0, 311) and IsInputDisabled(0) and not isDead then
				OpenAccessoryMenu()
			end
		end
	end
end)

RegisterCommand('shirt', function(source, args, raw)
	TriggerEvent('esx_accessories:shirt')
end)
RegisterCommand('pants', function(source, args, raw)
	TriggerEvent('esx_accessories:pants')
end)
RegisterCommand('shoes', function(source, args, raw)
	TriggerEvent('esx_accessories:shoes')
end)
RegisterCommand('restore', function(source, args, raw)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)
RegisterCommand('ears', function(source, args, raw)
	SetUnsetAccessory('Ears')
end)
RegisterCommand('mask', function(source, args, raw)
	SetUnsetAccessory('Mask')
end)
RegisterCommand('hat', function(source, args, raw)
	SetUnsetAccessory('Helmet')
end)
RegisterCommand('glasses', function(source, args, raw)
	SetUnsetAccessory('Glasses')
end)

RegisterNetEvent('esx_accessories:shirt')
AddEventHandler('esx_accessories:shirt', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 15, ['torso_2'] = 0,
			['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('esx_accessories:pants')
AddEventHandler('esx_accessories:pants', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
			['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('esx_accessories:shoes')
AddEventHandler('esx_accessories:shoes', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		--[[local clothesSkin = {
			['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)--]]
		if(skin.sex == 0) then
			local clothesSkin = {
				['shoes_1'] = 34, ['shoes_2'] = 0
			}
			TriggerEvent('shoes',true)
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			
		else
			local clothesSkin = {
				['shoes_1'] = 35, ['shoes_2'] = 0
			}
			TriggerEvent('shoes',true)
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)			
		end
	end)
end)

--
-- Animation Shoes
--
RegisterNetEvent('shoes')
AddEventHandler('shoes', function(putOn)
	local player = PlayerPedId()
	local dict   -- "take_off"
	local anim

	if putOn then
		dict = "random@domestic" --anim: take_off_helmet_stand
		anim = "pickup_low"
	else
		dict = "random@domestic" --anim: take_off_helmet_stand
		anim = "pickup_low"
	end

	loadAnimDict( dict )
	TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
	Wait (500)
	ClearPedSecondaryTask(player)
end)

--
-- Animation Glasses
--
RegisterNetEvent('glasses')
AddEventHandler('glasses', function(putOn)
	local player = PlayerPedId()
	local dict   -- "take_off"
	local anim

	if putOn then
		dict = "clothingspecs" --anim: take_off_helmet_stand
		anim = "take_off"
	else
		dict = "clothingspecs" --anim: take_off_helmet_stand
		anim = "take_off"
	end

	loadAnimDict( dict )
	TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
	Wait (500)
	ClearPedSecondaryTask(player)
end)

--
-- Animation Helmet
--
RegisterNetEvent('helmet')
AddEventHandler('helmet', function(putOn)
	local player = PlayerPedId()
	local dict -- = "missheist_agency2ahelmet" --anim: take_off_helmet_stand
	local anim  --= "take_off_helmet_stand"
	-- veh@bicycle@road_f@front@base --put_on_helmet_bike put_on_helmet_char
	-- veh@bicycle@roadfront@base --put_on_helmet
	-- veh@bike@chopper@front@base --put_on_helmet put_on_helmet_l
	-- missheistdockssetup1hardhat@ --put_on_hat
	--local test2 = "mp_masks@standard_car@ds@"
	if putOn then
		dict = "missheist_agency2ahelmet"--"anim@veh@bike@hemi_trike@front@base"--"veh@bicycle@roadfront@base" --anim: take_off_helmet_stand
		anim = "take_off_helmet_stand"
	else
		dict = "missheist_agency2ahelmet" --anim: take_off_helmet_stand
		anim = "take_off_helmet_stand"
	end
	loadAnimDict( dict )
	TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
	Wait (500)
	ClearPedSecondaryTask(player)
end)

--
-- Animation Mask
--
RegisterNetEvent('mask')
AddEventHandler('mask', function(putOn)
	local player = PlayerPedId()
	local dict
	local anim

	if putOn then
		dict = "misscommon@std_take_off_masks"--"misscommon@std_take_off_masks" --"mp_masks@standard_car@ds@"
		anim = "take_off_mask_ps"--"take_off_mask_ps" "put_on_mask"
	else
		dict = "missfbi4" --anim: take_off_helmet_stand
		anim = "takeoff_mask"
	end

	loadAnimDict( dict )
	TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
	Wait (500)
	ClearPedSecondaryTask(player)
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
