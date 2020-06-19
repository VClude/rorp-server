local showerprotectspam = false
RegisterNetEvent('rtx_property:sprchasyncclient')
AddEventHandler('rtx_property:sprchasyncclient', function(ped, need, sex)  
    SprchaON(ped, sex)
end)


RegisterNetEvent('rtx_property:sprchasyncremoveclient')
AddEventHandler('rtx_property:sprchasyncremoveclient', function(ped, posx, posy, posz)  
    RemoveParticleFxInRange(posx, posy, posz, 5.0)
end)

function SprchaON(ped, sex)
    local Player = ped
    local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
	local pos = GetEntityCoords(PlayerPed)
    local particleDictionary = "scr_mp_house"
    local particleName = "ent_amb_shower"	
    RequestNamedPtfxAsset(particleDictionary)

    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Citizen.Wait(0)
    end

    SetPtfxAssetNextCall(particleDictionary)

	local effect = StartParticleFxLoopedAtCoord(particleName, pos.x, pos.y, pos.z+2, -50.00, 0.0, 0.0, 2.0, true, false, false, 0)
end


RegisterNetEvent('rtx_property:sprchastart')
AddEventHandler('rtx_property:sprchastart', function(ped) 
	if not showerprotectspam == true then
		local Player = ped
		local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
		local pos = GetEntityCoords(PlayerPed)
		showerprotectspam = true
		exports['mythic_notify']:SendAlert('inform', 'You started taking a shower', 5000)
		TriggerServerEvent('rtx_property:sprchasync', GetPlayerServerId(PlayerId()), 'sprcha', 'female')
		exports['mythic_progbar']:Progress({
			name = "sprchaaction",
			duration = 10000,
			label = "You are showering ...",
			useWhileDead = true,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mp_safehouseshower@female@",
				anim = "shower_idle_a",
				flags = 49,
			},
			prop = {
				model = "prop_toilet_soap_01",
				bone = 57005,
				coords = { x = 0.10, y = 0.02, z = -0.01 },
				rotation = { x = 200.0, y = -20.0, z = 90.0 },
			},
		}, function(cancelled)
			if not cancelled then
				showerprotectspam = false
				TriggerServerEvent('rtx_property:sprchasyncremove', GetPlayerServerId(PlayerId()), pos.x, pos.y, pos.z)
				TriggerServerEvent('esx_propertymakeupskinsprcha:savePropertymakeupSprcha')
				SetPedHeadOverlay       	(GetPlayerPed(-1), 4, 0, 0.0)   	-- Lipstick
				SetPedHeadOverlay       	(GetPlayerPed(-1), 8, 0, 0.0) 		-- Makeup
				SetPedHeadOverlayColor  	(GetPlayerPed(-1), 4, 1, 0, 0)      -- Makeup Color
				SetPedHeadOverlayColor  	(GetPlayerPed(-1), 8, 1, 0, 0)      -- Lipstick Color
				SetPedHeadOverlay			(GetPlayerPed(-1), 5, 0, 0.0)			-- Blush + opacity
				SetPedHeadOverlayColor		(GetPlayerPed(-1), 5, 2, 0)	-- Blush Color
				Citizen.Wait(1000)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			else
				showerprotectspam = false
				TriggerServerEvent('rtx_property:sprchasyncremove', GetPlayerServerId(PlayerId()), pos.x, pos.y, pos.z)
				RemoveParticleFxInRange(pos.x, pos.y, pos.z, 5.0)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'You are already taking a shower', 5000)
	end
end)

