ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentTest       = nil

local dataPakToto = {
	{type = 4, hash = 2705543429, x = -125.77, y = -640.9, z = 168.82, h = 92.94}
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

    for _, item in pairs(dataPakToto) do
		paktoto =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.h, false, true)
		SetBlockingOfNonTemporaryEvents(paktoto, true)
		SetPedDiesWhenInjured(paktoto, false)
		SetPedCanPlayAmbientAnims(paktoto, false)
		SetPedCanRagdollFromPlayerImpact(paktoto, false)
		SetEntityInvincible(paktoto, true)
		FreezeEntityPosition(paktoto, true)
	end
    
end)

function BukaMenuDaftarPenduduk()
    
    ESX.TriggerServerCallback('rorp_daftarwarga:cekWargabaru', function(wargabaru)

		if wargabaru == true then

	        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'daftar_warga_baru', {
                title    = 'Daftar Kependudukan',
                align    = 'bottom-right',
                elements = {
                    {label = 'Daftar warga Republic Of Roleplay', value = 'theory_test'},
                },
            }, function(data, menu)
                    StartTheoryTest()
                    menu.close()
                end
            )
		else
			ESX.ShowNotification('Kamu bukan warga baru')
		end
	end)

end

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
        local generatedPlate = GeneratePlate()
        local model = Config.ModelMobilWargaBaru
        ESX.TriggerServerCallback('rorp_daftarwarga:giftCar',function(success)
            if success then
                ESX.TriggerServerCallback('rorp_daftarwarga:removeStatWargaBaru')
                ESX.ShowNotification(_U('test_berhasil'))
                Citizen.Wait(2000)
                ESX.ShowNotification('Silahkan ambil mobil anda di ~b~Garasi Walikota~w~ dengan Plat No: ~g~'..generatedPlate)
                
            end
        end, generatedPlate, model)
	else
		ESX.ShowNotification(_U('test_gagal'))
	end
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
	end
end)

AddEventHandler('rorp_daftarwarga:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Blips, 1 do
		local blip = AddBlipForCoord(Config.Blips[i])
		SetBlipSprite (blip, 498)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.3)
		SetBlipColour (blip, 0)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('Daftar Kependudukan')
		EndTextCommandSetBlipName(blip)
	end
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