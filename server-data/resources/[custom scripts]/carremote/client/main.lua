ESX	= nil
local currentVehicle, vehicleClass, lockStatus, engineStatus, alarmStatus, lastVehicle, alarmTriggering
local vehicles = {}

function checkOwner(vehicle)
	local plate = ESX.Game.GetVehicleProperties(vehicle).plate
	ESX.TriggerServerCallback('carremote:checkOwnedVehicle', function(result)
		if result then
			return true
		else
			return false
		end
	end, plate)
end

function unlockMotorcycle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		exports.pNotify:SendNotification({

			text = _U('unlocked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		TriggerServerEvent("carremote:playSound", 4, "unlock-inside", 0.10)
		lockStatus = 1
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehicleAlarm(vehicle, 0)
		exports.pNotify:SendNotification({

			text = _U('unlocked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "unlock-inside", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 1
	end
end

function lockMotorcycle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 7)
		SetVehicleNeedsToBeHotwired(vehicle, true)
		exports.pNotify:SendNotification({

			text = _U('locked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		TriggerServerEvent("carremote:playSound", 4, "lock-inside", 0.10)
		lockStatus = 2
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 7)
		SetVehicleNeedsToBeHotwired(vehicle, true)
		exports.pNotify:SendNotification({

			text = _U('locked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "lock-outside", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 2
	end
end

function unlockVehicle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 1)
		exports.pNotify:SendNotification({

			text = _U('unlocked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		TriggerServerEvent("carremote:playSound", 4, "unlock-inside", 0.10)
		lockStatus = 1
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleAlarm(vehicle, 0)
		exports.pNotify:SendNotification({

			text = _U('unlocked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "unlock-inside", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 1
	end
end

function lockVehicle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 2)
		exports.pNotify:SendNotification({

			text = _U('locked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		TriggerServerEvent("carremote:playSound", 4, "lock-inside", 0.10)
		lockStatus = 2
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 2)
		exports.pNotify:SendNotification({

			text = _U('locked'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "lock-outside", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 2
	end
end

function engineOn(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		exports.pNotify:SendNotification({

			text = _U('engine_on'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		SetVehicleEngineOn(vehicle, true, true, false)
	else
		ClearPedTasks(ply)
		playAnimation()
		SetVehicleEngineOn(vehicle, true, true, false)
	end
end

function flashLights(vehicle)
	Citizen.Wait(200)
	SetVehicleLights(vehicle, 2)
	Citizen.Wait(100)
	SetVehicleLights(vehicle, 0)
	Citizen.Wait(200)
	SetVehicleLights(vehicle, 2)
	Citizen.Wait(100)
	SetVehicleLights(vehicle, 0)
end

function engineOff(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		exports.pNotify:SendNotification({

			text = _U('engine_off'),
			type = 'info',
			layout = 'centerRight',
			timeout = 700,
			theme = 'mint'


		})
		SetVehicleEngineOn(vehicle, false, false, true)
	else
		ClearPedTasks(ply)
		playAnimation()
		SetVehicleEngineOn(vehicle, false, false, false)
	end
end

function getVehicleNetId(vehID)
	return NetToVeh(NetworkGetNetworkIdFromEntity(vehID))
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function playAnimation()
	local ply = GetPlayerPed(-1)
	local lib = "anim@mp_player_intmenu@key_fob@"
	local anim = "fob_click"

	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(ply, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end


function runCheckPedNotInVehicle(ply)
	local coordA = GetEntityCoords(ply, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, 5.0, 0.0)
	local vehicle = ESX.Game.GetClosestVehicle(coordA)

	if vehicle then
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)
		
		if vehicleDistance < Config.SwitchDistance then
			if ESX.Game.GetVehicleProperties(vehicle).plate ~= nil then
				local plate = ESX.Game.GetVehicleProperties(vehicle).plate
				local playerJob = ESX.GetPlayerData().job.name
				local model = GetEntityModel(vehicle)
				local modelName = tostring(model)
				for job,veh in pairs(Config.JobVehicles) do
					if string.lower(playerJob) == string.lower(job) then
						for i = 1,#veh, 1 do
							if tostring(modelName) == tostring(GetHashKey(veh[i])) then
								jobVehicle = true
								break
							end
						end
					end
				end

				if jobVehicle then
					lastVehicle = vehicle
					ESX.ShowNotification(_U('now_connected', plate))
					local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)
				
					if Config.UseBattery then
						if Config.MaxRemoteRange >= vehicleDistance then
							local range = vehicleDistance / Config.MaxRemoteRange 
							range = 100 - (math.floor((range * 10) + 0.5) * 10)
							battery = 'battery-' .. tostring(range)
							SendNUIMessage({type = tostring(battery)})
						else
							SendNUIMessage({type = 'battery-0'})
						end
					else
						SendNUIMessage({type = 'battery-100'})
					end
				
					engineStatus = GetIsVehicleEngineRunning(vehicle)
				
					if engineStatus then
						SendNUIMessage({type = 'engineOn'})
					else
						SendNUIMessage({type = 'engineOff'})
					end
				
					lockStatus = GetVehicleDoorLockStatus(vehicle)
				
					if lockStatus then
						if lockStatus == 2 then
							SendNUIMessage({type = 'locked'})
						else
							SendNUIMessage({type = 'unlocked'})
						end
					else
						SendNUIMessage({type = 'unlocked'})
					end
				
					SendNUIMessage({type = 'carConnected'})
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
					SendNUIMessage({type = 'enableButtons'})
					SendNUIMessage({type = 'openKeyFob'})
				else
					ESX.TriggerServerCallback('carremote:checkOwnedVehicle', function(result)
						if result then
							lastVehicle = vehicle
							ESX.ShowNotification(_U('now_connected', plate))
							local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)
						
							if Config.UseBattery then
								if Config.MaxRemoteRange >= vehicleDistance then
									local range = vehicleDistance / Config.MaxRemoteRange 
									range = 100 - (math.floor((range * 10) + 0.5) * 10)
									battery = 'battery-' .. tostring(range)
									SendNUIMessage({type = tostring(battery)})
								else
									SendNUIMessage({type = 'battery-0'})
								end
							else
								SendNUIMessage({type = 'battery-100'})
							end
						
							engineStatus = GetIsVehicleEngineRunning(vehicle)
						
							if engineStatus then
								SendNUIMessage({type = 'engineOn'})
							else
								SendNUIMessage({type = 'engineOff'})
							end
						
							lockStatus = GetVehicleDoorLockStatus(vehicle)
						
							if lockStatus then
								if lockStatus == 2 then
									SendNUIMessage({type = 'locked'})
								else
									SendNUIMessage({type = 'unlocked'})
								end
							else
								SendNUIMessage({type = 'unlocked'})
							end
						
							SendNUIMessage({type = 'carConnected'})
							SetNuiFocus(true, true)
							SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
							SendNUIMessage({type = 'enableButtons'})
							SendNUIMessage({type = 'openKeyFob'})
						else
							if lastVehicle then
								if DoesEntityExist(lastVehicle) then
									vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
							
									if Config.UseBattery then
										if Config.MaxRemoteRange >= vehicleDistance then
											local range = vehicleDistance / Config.MaxRemoteRange 
											range = 100 - (math.floor((range * 10) + 0.5) * 10)
											battery = 'battery-' .. tostring(range)
											SendNUIMessage({type = tostring(battery)})
										else
											SendNUIMessage({type = 'battery-0'})
										end
									else
										SendNUIMessage({type = 'battery-100'})
									end
							
									engineStatus = GetIsVehicleEngineRunning(lastVehicle)
							
									if engineStatus then
										SendNUIMessage({type = 'engineOn'})
									else
										SendNUIMessage({type = 'engineOff'})
									end
							
									lockStatus = GetVehicleDoorLockStatus(lastVehicle)
							
									if lockStatus then
										if lockStatus == 2 then
											SendNUIMessage({type = 'locked'})
										else
											SendNUIMessage({type = 'unlocked'})
										end
									else
										SendNUIMessage({type = 'unlocked'})
									end
							
									SendNUIMessage({type = 'carConnected'})
									SetNuiFocus(true, true)
									SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
									SendNUIMessage({type = 'enableButtons'})
									SendNUIMessage({type = 'openKeyFob'})
								else
									SendNUIMessage({type = 'carDisconnected'})
									SendNUIMessage({type = 'unlocked'})
									SendNUIMessage({type = 'engineOff'})
									if Config.UseBattery then
										SendNUIMessage({type = 'battery-0'})
									else
										SendNUIMessage({type = 'battery-100'})
									end		
									SetNuiFocus(true, true)
									SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
									SendNUIMessage({type = 'enableButtons'})
									SendNUIMessage({type = 'openKeyFob'})
								end
							else
								SendNUIMessage({type = 'carDisconnected'})
								SendNUIMessage({type = 'unlocked'})
								SendNUIMessage({type = 'engineOff'})
								if Config.UseBattery then
									SendNUIMessage({type = 'battery-0'})
								else
									SendNUIMessage({type = 'battery-100'})
								end		
								SetNuiFocus(true, true)
								SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
								SendNUIMessage({type = 'enableButtons'})
								SendNUIMessage({type = 'openKeyFob'})
							end
						end
					end, plate)
				end
			else
				ESX.ShowNotification(_U('no_plate'))
			end
		else
			if lastVehicle then
				if DoesEntityExist(lastVehicle) then
					vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
			
					if Config.UseBattery then
						if Config.MaxRemoteRange >= vehicleDistance then
							local range = vehicleDistance / Config.MaxRemoteRange 
							range = 100 - (math.floor((range * 10) + 0.5) * 10)
							battery = 'battery-' .. tostring(range)
							SendNUIMessage({type = tostring(battery)})
						else
							SendNUIMessage({type = 'battery-0'})
						end
					else
						SendNUIMessage({type = 'battery-100'})
					end
			
					engineStatus = GetIsVehicleEngineRunning(lastVehicle)
			
					if engineStatus then
						SendNUIMessage({type = 'engineOn'})
					else
						SendNUIMessage({type = 'engineOff'})
					end
			
					lockStatus = GetVehicleDoorLockStatus(lastVehicle)
			
					if lockStatus then
						if lockStatus == 2 then
							SendNUIMessage({type = 'locked'})
						else
							SendNUIMessage({type = 'unlocked'})
						end
					else
						SendNUIMessage({type = 'unlocked'})
					end
			
					SendNUIMessage({type = 'carConnected'})
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
					SendNUIMessage({type = 'enableButtons'})
					SendNUIMessage({type = 'openKeyFob'})
				else
					SendNUIMessage({type = 'carDisconnected'})
					SendNUIMessage({type = 'unlocked'})
					SendNUIMessage({type = 'engineOff'})
					if Config.UseBattery then
						SendNUIMessage({type = 'battery-0'})
					else
						SendNUIMessage({type = 'battery-100'})
					end		
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
					SendNUIMessage({type = 'enableButtons'})
					SendNUIMessage({type = 'openKeyFob'})
				end
			else
				SendNUIMessage({type = 'carDisconnected'})
				SendNUIMessage({type = 'unlocked'})
				SendNUIMessage({type = 'engineOff'})
				if Config.UseBattery then
					SendNUIMessage({type = 'battery-0'})
				else
					SendNUIMessage({type = 'battery-100'})
				end		
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
				SendNUIMessage({type = 'enableButtons'})
				SendNUIMessage({type = 'openKeyFob'})
			end
		end
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end

function runCurrentVehicleKeyFob(vehicle)
	lastVehicle = vehicle
	ESX.ShowNotification(_U('now_connected', plate))
	local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)

	if Config.UseBattery then
		if Config.MaxRemoteRange >= vehicleDistance then
			local range = vehicleDistance / Config.MaxRemoteRange 
			range = 100 - (math.floor((range * 10) + 0.5) * 10)
			battery = 'battery-' .. tostring(range)
			SendNUIMessage({type = tostring(battery)})
		else
			SendNUIMessage({type = 'battery-0'})
		end
	else
		SendNUIMessage({type = 'battery-100'})
	end

	engineStatus = GetIsVehicleEngineRunning(vehicle)

	if engineStatus then
		SendNUIMessage({type = 'engineOn'})
	else
		SendNUIMessage({type = 'engineOff'})
	end

	lockStatus = GetVehicleDoorLockStatus(vehicle)

	if lockStatus then
		if lockStatus == 2 then
			SendNUIMessage({type = 'locked'})
		else
			SendNUIMessage({type = 'unlocked'})
		end
	else
		SendNUIMessage({type = 'unlocked'})
	end

	SendNUIMessage({type = 'carConnected'})
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
	SendNUIMessage({type = 'enableButtons'})
	SendNUIMessage({type = 'openKeyFob'})
end

function runLastVehicleKeyFob()
	if DoesEntityExist(lastVehicle) then
		vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)

		if Config.UseBattery then
			if Config.MaxRemoteRange >= vehicleDistance then
				local range = vehicleDistance / Config.MaxRemoteRange 
				range = 100 - (math.floor((range * 10) + 0.5) * 10)
				battery = 'battery-' .. tostring(range)
				SendNUIMessage({type = tostring(battery)})
			else
				SendNUIMessage({type = 'battery-0'})
			end
		else
			SendNUIMessage({type = 'battery-100'})
		end

		engineStatus = GetIsVehicleEngineRunning(lastVehicle)

		if engineStatus then
			SendNUIMessage({type = 'engineOn'})
		else
			SendNUIMessage({type = 'engineOff'})
		end

		lockStatus = GetVehicleDoorLockStatus(lastVehicle)

		if lockStatus then
			if lockStatus == 2 then
				SendNUIMessage({type = 'locked'})
			else
				SendNUIMessage({type = 'unlocked'})
			end
		else
			SendNUIMessage({type = 'unlocked'})
		end

		SendNUIMessage({type = 'carConnected'})
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
		SendNUIMessage({type = 'enableButtons'})
		SendNUIMessage({type = 'openKeyFob'})
	else
		SendNUIMessage({type = 'carDisconnected'})
		SendNUIMessage({type = 'unlocked'})
		SendNUIMessage({type = 'engineOff'})
		if Config.UseBattery then
			SendNUIMessage({type = 'battery-0'})
		else
			SendNUIMessage({type = 'battery-100'})
		end		
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
		SendNUIMessage({type = 'enableButtons'})
		SendNUIMessage({type = 'openKeyFob'})
	end
end

function runEngineCheckPedInVehicle(ply)
	currentVehicle = GetVehiclePedIsIn(ply, false)
	engineStatus   = GetIsVehicleEngineRunning(currentVehicle)
	if engineStatus == 1 then
		engineOff(currentVehicle)
	else
		engineOn(currentVehicle)
	end
end

function runEngineCheckPedNotInVehicle(ply)
	local coordA = GetEntityCoords(ply, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, 5.0, 0.0)
	local vehicle = getVehicleInDirection(coordA, coordB)
	if vehicle ~= 0 and vehicle ~= nil then
		if checkOwner(vehicle) then
			runToggleEngine(vehicle)
		else
			if lastVehicle then
				runToggleEngine(lastVehicle)
			end
		end
	else
		if lastVehicle then
			runToggleEngine(lastVehicle)
		end
	end
end

function runToggleEngine(vehicle)
	local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)
	if Config.UseRemoteRange then
		if Config.MaxRemoteRange >= vehicleDistance then
			engineStatus = GetIsVehicleEngineRunning(vehicle)
			if engineStatus == 1 then
				engineOff(vehicle)
				SendNUIMessage({type = 'engineOff'})
			else
				engineOn(vehicle)
				SendNUIMessage({type = 'engineOn'})
			end
		else
			ESX.ShowNotification(_U('out_of_range'))
		end
	else
		engineStatus = GetIsVehicleEngineRunning(vehicle)
		if engineStatus == 1 then
			engineOff(lastVehicle)
			SendNUIMessage({type = 'engineOff'})
		else
			engineOn(lastVehicle)
			SendNUIMessage({type = 'engineOn'})
		end
	end
end

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType   = 'playSound',
            transactionFile   = soundFile,
            transactionVolume = soundVolume
        })
    end
end)

RegisterNetEvent('carremote:startCarAlarm')
AddEventHandler('carremote:startCarAlarm', function(vehNetId)
	local vehicle = NetToVeh(vehNetId)
	SetVehicleAlarm(vehicle, 1)
	StartVehicleAlarm(vehicle)
	SetVehicleAlarmTimeLeft(vehicle, 180000)
end)

RegisterNetEvent('carremote:stopCarAlarm')
AddEventHandler('carremote:stopCarAlarm', function(vehNetId)
	local vehicle = NetToVeh(vehNetId)
	SetVehicleAlarm(vehicle, 0)
end)

RegisterNetEvent('carremote:startMotorcycleAlarm')
AddEventHandler('carremote:startMotorcycleAlarm', function(vehNetId)
	local vehicle = NetToVeh(vehNetId)
	SetVehicleAlarm(vehicle, 1)
	StartVehicleAlarm(vehicle)
	SetVehicleAlarmTimeLeft(vehicle, 180000)
	SetVehicleDoorsLocked(vehicle, 1)
end)

RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(playerNetId, maxDistance, soundFile, maxVolume, sourceEntity)
	local distPerc = nil
	local volume = maxVolume
	local lCoords = GetEntityCoords(GetPlayerPed(-1))
	local eCoords = GetEntityCoords(NetToVeh(sourceEntity), true)
	local distIs  = tonumber(string.format("%.1f", GetDistanceBetweenCoords(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z, true)))
	if (distIs <= maxDistance) then
		distPerc = distIs / maxDistance
		volume = (1-distPerc) * maxVolume
		SendNUIMessage({
			transactionType   = 'playSound',
			transactionFile   = soundFile,
			transactionVolume = volume
		})
	end
end)

-- NUICallback for Turning The Menu Off
RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

-- NUICallback For Locking Vehicle
RegisterNUICallback('NUILock', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				lockStatus   = GetVehicleDoorLockStatus(lastVehicle)
				vehicleClass = GetVehicleClass(lastVehicle)
				if Config.StealableMotorcycles then
					if vehicleClass == 8 then
						if lockStatus < 2 then
							lockMotorcycle(lastVehicle)
							SendNUIMessage({type = 'locked'})
							flashLights(lastVehicle)		
						else
							ESX.ShowNotification(_U('already_locked'))
						end
					else
						if lockStatus < 2 then
							lockVehicle(lastVehicle)
							SendNUIMessage({type = 'locked'})
							flashLights(lastVehicle)		
						else
							ESX.ShowNotification(_U('already_locked'))
						end
					end
				else
					if lockStatus < 2 then
						lockVehicle(lastVehicle)
						SendNUIMessage({type = 'locked'})
						flashLights(lastVehicle)		
					else
						ESX.ShowNotification(_U('already_locked'))
					end
				end
			else
				ESX.ShowNotification(_U('out_of_range'))
			end
		else
			if Config.StealableMotorcycles then

			else
				lockStatus = GetVehicleDoorLockStatus(lastVehicle)
				if lockStatus < 2 then
					lockVehicle(lastVehicle)
					SendNUIMessage({type = 'locked'})
					flashLights(lastVehicle)	
				else
					ESX.ShowNotification(_U('already_locked'))
				end
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Unlocking Vehicle
RegisterNUICallback('NUIUnlock', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				lockStatus   = GetVehicleDoorLockStatus(lastVehicle)
				vehicleClass = GetVehicleClass(lastVehicle)
				if Config.StealableMotorcycles then
					if vehicleClass == 8 then
						lockStatus = GetVehicleDoorLockStatus(lastVehicle)
						if lockStatus >= 2 then
							unlockMotorcycle(lastVehicle)
							SendNUIMessage({type = 'unlocked'})
							flashLights(lastVehicle)
						else
							ESX.ShowNotification(_U('already_unlocked'))
						end
					else
						if lockStatus >= 2 then
							unlockVehicle(lastVehicle)
							SendNUIMessage({type = 'unlocked'})
							flashLights(lastVehicle)
						else
							ESX.ShowNotification(_U('already_unlocked'))
						end
					end
				else
					if lockStatus >= 2 then
						unlockVehicle(lastVehicle)
						SendNUIMessage({type = 'unlocked'})
						flashLights(lastVehicle)
					else
						ESX.ShowNotification(_U('already_unlocked'))
					end
				end
			else
				ESX.ShowNotification(_U('out_of_range'))
			end
		else
			if Config.StealableMotorcycles then

			else
				lockStatus = GetVehicleDoorLockStatus(lastVehicle)
				if lockStatus >= 2 then
					unlockVehicle(lastVehicle)
					SendNUIMessage({type = 'unlocked'})
					flashLights(lastVehicle)
				else
					ESX.ShowNotification(_U('already_unlocked'))
				end
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Engine
RegisterNUICallback('NUIToggleEngine', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				engineStatus   = GetIsVehicleEngineRunning(lastVehicle)
				if engineStatus == 1 then
					engineOff(lastVehicle)
					SendNUIMessage({type = 'engineOff'})
				else
					engineOn(lastVehicle)
					SendNUIMessage({type = 'engineOn'})
				end
			else
				ESX.ShowNotification(_U('out_of_range'))
			end
		else
			engineStatus   = GetIsVehicleEngineRunning(lastVehicle)
			if engineStatus == 1 then
				engineOff(lastVehicle)
				SendNUIMessage({type = 'engineOff'})
			else
				engineOn(lastVehicle)
				SendNUIMessage({type = 'engineOn'})
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

	Citizen.Wait(500)
	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Alarm
RegisterNUICallback('NUIPanic', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				playAnimation()
				Citizen.Wait(250)
				if not alarmStatus then
					print('Vehicle = ' .. tostring(lastVehicle))
					local vehicleNetId = VehToNet(lastVehicle)
					TriggerServerEvent("carremote:triggerCarAlarm", vehicleNetId)
					alarmStatus = true
				else
					print('Vehicle = ' .. tostring(lastVehicle))
					local vehicleNetId = VehToNet(lastVehicle)
					TriggerServerEvent("carremote:killCarAlarm", vehicleNetId)
					alarmStatus = false
				end
			else
				ESX.ShowNotification(_U('out_of_range'))
			end
		else
			playAnimation()
			Citizen.Wait(250)
			if not alarmStatus then
				print('Vehicle = ' .. tostring(lastVehicle))
				local vehicleNetId = VehToNet(lastVehicle)
				TriggerServerEvent("carremote:triggerCarAlarm", vehicleNetId)
				alarmStatus = true
			else
				print('Vehicle = ' .. tostring(lastVehicle))
				local vehicleNetId = VehToNet(lastVehicle)
				TriggerServerEvent("carremote:killCarAlarm", vehicleNetId)
				alarmStatus = false
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

	Citizen.Wait(250)
	SendNUIMessage({type = 'enableButtons'})
end)

RegisterNetEvent("carremote:hotkeyUIPressed")
AddEventHandler("carremote:hotkeyUIPressed", function()
	local ply = GetPlayerPed(-1)

	if (IsPedInAnyVehicle(ply, true)) then
		currentVehicle = GetVehiclePedIsIn(ply, false)
		lockStatus     = GetVehicleDoorLockStatus(currentVehicle)
		vehicleClass = GetVehicleClass(currentVehicle)
		if vehicleClass == 8 then
			if lockStatus >= 2 then
				unlockMotorcycle(currentVehicle)
			else
				lockMotorcycle(currentVehicle)
			end
		else
			if lockStatus == 2 then
				unlockVehicle(currentVehicle)
			else
				lockVehicle(currentVehicle)
			end
		
			Citizen.Wait(1000)
		end
	else
		runCheckPedNotInVehicle(ply)
	end
end)

RegisterCommand('carengine',

	function(source,args,raw)
		TriggerEvent('carremote:hotkeyEnginePressed')
	end
)

RegisterNetEvent("carremote:hotkeyEnginePressed")
AddEventHandler("carremote:hotkeyEnginePressed", function()
	local ply = GetPlayerPed(-1)
	if (IsPedInAnyVehicle(ply, true)) then
		runEngineCheckPedInVehicle(ply)
	else
		runEngineCheckPedNotInVehicle(ply)
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(1)

		if IsControlJustPressed(0, Config.HotkeyUI) then
        	TriggerEvent("carremote:hotkeyUIPressed")
		end

		if IsControlJustPressed(0, Config.HotkeyEngine) then
			TriggerEvent("carremote:hotkeyEnginePressed")
		end
	end
end)

if Config.StealableMotorcycles then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
				local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
				local locked  = GetVehicleDoorLockStatus(vehicle)
				if locked == 7 then
					if not alarmTriggering then
						local vehicleNetId = VehToNet(vehicle)
						TriggerServerEvent("carremote:stolenMotorcycleAlarm", vehicleNetId)
						alarmTriggering = true
					end
				end
			else
				alarmTriggering = false
			end
		end
	end)
end
