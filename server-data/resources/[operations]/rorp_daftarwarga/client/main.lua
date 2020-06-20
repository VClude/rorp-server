ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

    if success then
        TriggerServerEvent('rorp_daftarwarga:giftCar', generatePlate, model)
	else
		ESX.ShowNotification(_U('test_gagal'))
	end
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function BukaMenuDaftarPenduduk()
    
    ESX.TriggerServerCallback('rorp_daftarwarga:cekWargabaru', function(wargabaru)

		if wargabaru == true then
            table.insert(elements, {
                label = (_U('bukan_warga_baru')),
                value = 'theory_test'
            })
		else

			table.insert(elements, {
                label = (_U('bukan_warga_baru')),
                value = 'bukan_warga_baru'
            })
		end
	end)

	local elements = {}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'daftar_warga_baru', {
		title    = _U('driving_school'),
		elements = elements,
		align    = 'bottom-right'
	}, function(data, menu)
		if data.current.value == 'theory_test' then
			menu.close()
            StartTheoryTest()
        else
            menu.close()
		end
		ESX.UI.Menu.CloseAll()
	end)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

AddEventHandler('rorp_daftarwarga:hasEnteredMarker', function(zone)
	if zone == 'TestKependudukan' then
		CurrentAction     = 'menu_testkependudukan'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('rorp_daftarwarga:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.TestKependudukan.Pos.x, Config.Zones.TestKependudukan.Pos.y, Config.Zones.TestKependudukan.Pos.z)

	SetBlipSprite (blip, 408)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('driving_school_blip'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(100)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('rorp_daftarwarga:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('rorp_daftarwarga:hasExitedMarker', LastZone)
		end
	end
end)

-- Block UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'menu_testkependudukan' then
					BukaMenuDaftarPenduduk()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)