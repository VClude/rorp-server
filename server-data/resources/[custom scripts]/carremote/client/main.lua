ESX	= nil

local playerKeys = {}
local keysGiven  = {}
local vehicleClass, lockStatus, engineStatus, alarmStatus, savedVehicle, alarmTriggering, tryingToEnterActive

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
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

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
      if not tryingToEnterActive then
        tryingToEnterActive = true
        local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())

        if vehicle then
          local locked = GetVehicleDoorLockStatus(vehicle)

          if locked == 2 or locked == 7 then
            if not alarmTriggering and not IsVehicleAlarmActivated(vehicle) then
              local vehicleClass = GetVehicleClass(vehicle)

              if vehicleClass == 8 then
                local vehicleNetId = VehToNet(vehicle)

                if vehicleNetId then
                  TriggerServerEvent("carremote:stolenMotorcycleAlarm", vehicleNetId)
                  alarmTriggering = true
                end
              else
                local vehicleNetId = VehToNet(vehicle)

                if vehicleNetId then
                  TriggerServerEvent("carremote:triggerCarAlarm", vehicleNetId)
                  alarmTriggering = true
                end
              end
            end
          else
            alarmTriggering = false
          end
        end

        tryingToEnterActive = false
        Citizen.Wait(1000)
      else
        Citizen.Wait(1000)
      end
    else
      alarmTriggering     = false
      tryingToEnterActive = false
      Citizen.Wait(1000)
    end
  end
end)


RegisterCommand('engine',function()
  TriggerEvent("carremote:hotkeyEnginePressed")
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback('NUIGiveKeys', function()
  if savedVehicle then
    if DoesEntityExist(savedVehicle) then
      local vehicle      = savedVehicle
      local vehicleNetId = VehToNet(vehicle)
      local plate        = ESX.Game.GetVehicleProperties(vehicle).plate
      local model        = GetEntityModel(vehicle)
      local modelName    = tostring(model)
      if keysGiven[plate] then
        ESX.ShowNotification(_U('already_given'))
      else
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            ESX.ShowNotification(_U('no_player'))
        else
          if closestPlayer and vehicle and vehicleNetId then
            TriggerEvent('carremote:giveKeys', GetPlayerServerId(closestPlayer), vehicle, vehicleNetId)
          else
            ESX.ShowNotification("Error.")
          end
        end
      end
    else
      ESX.ShowNotification(_U('no_keys'))
    end
  else
    ESX.ShowNotification(_U('no_keys'))
  end
end)

RegisterNUICallback('NUITakeKeys', function()
  if savedVehicle then
    if DoesEntityExist(savedVehicle) then
      local vehicle      = savedVehicle
      local vehicleNetId = VehToNet(vehicle)
      local plate        = ESX.Game.GetVehicleProperties(vehicle).plate
      local model        = GetEntityModel(vehicle)
      local modelName    = tostring(model)
      if keysGiven[plate] then
        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
            ESX.ShowNotification(_U('no_player'))
        else
          TriggerEvent('carremote:takeKeys', GetPlayerServerId(closestPlayer))
        end
      else
        ESX.ShowNotification(_U('no_keys_given', plate))
      end
    else
      ESX.ShowNotification(_U('no_keys'))
    end
  else
    ESX.ShowNotification(_U('no_keys'))
  end
end)

-- NUICallback For Locking Vehicle
RegisterNUICallback('NUILock', function()
	SendNUIMessage({type = 'disableButtons'})

	if savedVehicle then
		local ped = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(savedVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				lockStatus   = GetVehicleDoorLockStatus(savedVehicle)
				vehicleClass = GetVehicleClass(savedVehicle)
				if Config.StealableMotorcycles then
					if vehicleClass == 8 then
						if lockStatus < 2 then
							lockMotorcycleOutside(savedVehicle)
							SendNUIMessage({type = 'locked'})
							flashLights(savedVehicle)		
						else
							ESX.ShowNotification(_U('already_locked'))
						end
					else
						if lockStatus < 2 then
							lockVehicleOutside(savedVehicle)
							SendNUIMessage({type = 'locked'})
							flashLights(savedVehicle)		
						else
							ESX.ShowNotification(_U('already_locked'))
						end
					end
				else
					if lockStatus < 2 then
						lockVehicleOutside(savedVehicle)
						SendNUIMessage({type = 'locked'})
						flashLights(savedVehicle)		
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
				lockStatus = GetVehicleDoorLockStatus(savedVehicle)
				if lockStatus < 2 then
					lockVehicleOutside(savedVehicle)
					SendNUIMessage({type = 'locked'})
					flashLights(savedVehicle)	
				else
					ESX.ShowNotification(_U('already_locked'))
				end
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

  Citizen.Wait(250)
	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Unlocking Vehicle
RegisterNUICallback('NUIUnlock', function()
	SendNUIMessage({type = 'disableButtons'})

	if savedVehicle then
		local ped = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(savedVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				lockStatus   = GetVehicleDoorLockStatus(savedVehicle)
				vehicleClass = GetVehicleClass(savedVehicle)
				if Config.StealableMotorcycles then
					if vehicleClass == 8 then
						lockStatus = GetVehicleDoorLockStatus(savedVehicle)
						if lockStatus >= 2 then
							unlockMotorcycleOutside(savedVehicle)
							SendNUIMessage({type = 'unlocked'})
							flashLights(savedVehicle)
						else
							ESX.ShowNotification(_U('already_unlocked'))
						end
					else
						if lockStatus >= 2 then
							unlockVehicleOutside(savedVehicle)
							SendNUIMessage({type = 'unlocked'})
							flashLights(savedVehicle)
						else
							ESX.ShowNotification(_U('already_unlocked'))
						end
					end
				else
					if lockStatus >= 2 then
						unlockVehicleOutside(savedVehicle)
						SendNUIMessage({type = 'unlocked'})
						flashLights(savedVehicle)
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
				lockStatus = GetVehicleDoorLockStatus(savedVehicle)
				if lockStatus >= 2 then
					unlockVehicleOutside(savedVehicle)
					SendNUIMessage({type = 'unlocked'})
					flashLights(savedVehicle)
				else
					ESX.ShowNotification(_U('already_unlocked'))
				end
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

  Citizen.Wait(250)
	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Engine
RegisterNUICallback('NUIToggleEngine', function()
	SendNUIMessage({type = 'disableButtons'})

	if savedVehicle then
		local ped = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(savedVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				engineStatus   = GetIsVehicleEngineRunning(savedVehicle)
				if engineStatus == 1 then
					engineOffOutside(savedVehicle)
					SendNUIMessage({type = 'engineOff'})
				else
					engineOnOutside(savedVehicle)
					SendNUIMessage({type = 'engineOn'})
				end
			else
				ESX.ShowNotification(_U('out_of_range'))
			end
		else
			engineStatus   = GetIsVehicleEngineRunning(savedVehicle)
			if engineStatus == 1 then
				engineOffOutside(savedVehicle)
				SendNUIMessage({type = 'engineOff'})
			else
				engineOnOutside(savedVehicle)
				SendNUIMessage({type = 'engineOn'})
			end
		end
	else
		ESX.ShowNotification(_U('not_connected'))
	end

	Citizen.Wait(250)
	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Alarm
RegisterNUICallback('NUIPanic', function()
	SendNUIMessage({type = 'disableButtons'})

	if savedVehicle then
		local ped = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(savedVehicle, false), true)
		if Config.UseRemoteRange then
			if Config.MaxRemoteRange >= vehicleDistance then
				playAnimation()
				Citizen.Wait(250)
				if not alarmStatus then
					local vehicleNetId = VehToNet(savedVehicle)
					TriggerServerEvent("carremote:triggerCarAlarm", vehicleNetId)
					alarmStatus = true
				else
					local vehicleNetId = VehToNet(savedVehicle)
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
				local vehicleNetId = VehToNet(savedVehicle)
				TriggerServerEvent("carremote:triggerCarAlarm", vehicleNetId)
				alarmStatus = true
			else
				local vehicleNetId = VehToNet(savedVehicle)
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
  if vehNetId then
    local vehicle = NetToVeh(vehNetId)
    if vehicle then
      SetVehicleAlarm(vehicle, 1)
      StartVehicleAlarm(vehicle)
      SetVehicleAlarmTimeLeft(vehicle, 180000)
    end
  end
end)

RegisterNetEvent('carremote:stopCarAlarm')
AddEventHandler('carremote:stopCarAlarm', function(vehNetId)
  if vehNetId then
    local vehicle = NetToVeh(vehNetId)
    if vehicle then
      SetVehicleAlarm(vehicle, 0)
    end
  end
end)

RegisterNetEvent('carremote:startMotorcycleAlarm')
AddEventHandler('carremote:startMotorcycleAlarm', function(vehNetId)
  if vehNetId then
    local vehicle = NetToVeh(vehNetId)
    if vehicle then
      SetVehicleAlarm(vehicle, 1)
      StartVehicleAlarm(vehicle)
      SetVehicleAlarmTimeLeft(vehicle, 180000)
      SetVehicleDoorsLocked(vehicle, 1)
    end
  end
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

RegisterNetEvent('carremote:giveKeys')
AddEventHandler('carremote:giveKeys', function(playerId, vehicle, vehNetId)
  if vehicle then
    if vehNetId then
      local vehicleNetId = VehToNet(vehicle)
      if vehicleNetId then
        local plate        = ESX.Game.GetVehicleProperties(vehicle).plate
        local model        = GetEntityModel(vehicle)
        local modelName    = tostring(model)

        TriggerServerEvent('carremote:giveKeys', playerId, vehicleNetId)
        keysGiven[plate] = modelName
        ESX.ShowNotification(_U('keys_given', plate))
      else
        ESX.ShowNotification("Error getting vehicleNetId.")
      end
    else
      ESX.ShowNotification("Error getting vehNetId")
    end
  else
    ESX.ShowNotification("You tried to give someone keys but there was an error.")
  end
end)

RegisterNetEvent('carremote:takeKeys')
AddEventHandler('carremote:takeKeys', function(playerId)
  if savedVehicle then
    local vehicle        = savedVehicle
    while not vehicle do
      Citizen.Wait(0)
    end

    if vehicle then
      local vehicleNetId = VehToNet(savedVehicle)
      local plate        = ESX.Game.GetVehicleProperties(vehicle).plate
      local model        = GetEntityModel(vehicle)
      local modelName    = tostring(model)

      TriggerServerEvent('carremote:takeKeys', playerId, vehicleNetId)
      keysGiven[plate] = nil
      ESX.ShowNotification(_U('keys_taken', plate))
    end
  end
end)

RegisterNetEvent('carremote:receiveKeys')
AddEventHandler('carremote:receiveKeys', function(vehicleNetId)
  if vehicleNetId then
    local vehicle = NetToVeh(vehicleNetId)
    if vehicle then
      local plate     = ESX.Game.GetVehicleProperties(vehicle).plate
      local model     = GetEntityModel(vehicle)
      local modelName = tostring(model)

      if not playerKeys[plate] then
        ESX.ShowNotification(_U('keys_received', plate))
        playerKeys[plate] = modelName
      end
    else
      ESX.ShowNotification("Someone tried to give you keys but there was an error.")
    end
  else
    ESX.ShowNotification("Someone tried to give you keys but there was an error.")
  end
end)

RegisterNetEvent('carremote:loseKeys')
AddEventHandler('carremote:loseKeys', function(vehicleNetId)
  if vehicleNetId then
    local vehicle   = NetToVeh(vehicleNetId)
    if vehicle then
      local plate     = ESX.Game.GetVehicleProperties(vehicle).plate
      local model     = GetEntityModel(vehicle)
      local modelName = tostring(model)

      if savedVehicle then
        local checkedVehicle   = savedVehicle
        local checkedPlate     = ESX.Game.GetVehicleProperties(checkedVehicle).plate
        local checkedModel     = GetEntityModel(checkedVehicle)
        local checkedModelName = tostring(checkedModel)

        if checkedPlate == plate then
          savedVehicle = nil
        end
      end

      if playerKeys[plate] then
        playerKeys[plate] = nil
        ESX.ShowNotification(_U('keys_lost', plate))
      end
    end
  end
end)


RegisterNetEvent("carremote:hotkeyUIPressed")
AddEventHandler("carremote:hotkeyUIPressed", function()
  local ped = GetPlayerPed(-1)

  if (IsPedInAnyVehicle(ped, true)) then
    local vehicle    = GetVehiclePedIsIn(ped, false)

    TriggerEvent("carremote:toggleLocksInside", vehicle)
  else
    TriggerEvent("carremote:keyUI")
  end
end)

RegisterNetEvent("carremote:hotkeyEnginePressed")
AddEventHandler("carremote:hotkeyEnginePressed", function()
  local ped = GetPlayerPed(-1)
  
  if (IsPedInAnyVehicle(ped, true)) then
    local vehicle = GetVehiclePedIsIn(ped, false)

    TriggerEvent("carremote:toggleEngineInside", vehicle)
  end
end)

RegisterNetEvent("carremote:toggleLocksInside")
AddEventHandler("carremote:toggleLocksInside", function(vehicle)
  local lockStatus   = GetVehicleDoorLockStatus(vehicle)
  local vehicleClass = GetVehicleClass(vehicle)

  if vehicleClass == 8 then
    if lockStatus >= 2 then
      unlockMotorcycleInside(vehicle)
    else
      lockMotorcycleInside(vehicle)
    end
  else
    if lockStatus >= 2 then
      unlockVehicleInside(vehicle)
    else
      lockVehicleInside(vehicle)
    end
  end
end)

RegisterNetEvent("carremote:toggleEngineInside")
AddEventHandler("carremote:toggleEngineInside", function(vehicle)
  local engineStatus = GetIsVehicleEngineRunning(vehicle)
  
	if engineStatus then
		engineOffInside(vehicle)
	else
		engineOnInside(vehicle)
	end

end)

RegisterNetEvent("carremote:clientLocks")
AddEventHandler("carremote:clientLocks", function(vehicleNetId, value)
  if vehicleNetId then
    local vehicle = NetToVeh(vehicleNetId)
    if vehicle then
      if DoesEntityExist(vehicle) then
        if value == 1 then
          SetVehicleDoorsLocked(vehicle, 1)
        else
          SetVehicleDoorsLocked(vehicle, 2)
        end
      end
    end
  end
end)

RegisterNetEvent("carremote:clientEngines")
AddEventHandler("carremote:clientEngines", function(vehicleNetId, value)
  if vehicleNetId then
    local vehicle = NetToVeh(vehicleNetId)
    if vehicle then
      if DoesEntityExist(vehicle) then
        if value == 1 then
          SetVehicleEngineOn(vehicle, true, true, true)
        else
          local engineStatus = GetIsVehicleEngineRunning(vehicle)
          if engineStatus then
            SetVehicleEngineOn(vehicle, false, true, true)
          end
        end
      end
    end
  end
end)

RegisterNetEvent("carremote:grantKeys")
AddEventHandler("carremote:grantKeys", function(vehicle)
  print("Received carremote:grantKeys")
  if vehicle then
    local plate     = ESX.Game.GetVehicleProperties(vehicle).plate
    local model     = GetEntityModel(vehicle)
    local modelName = tostring(model)

    if not playerKeys[plate] then
      ESX.ShowNotification(_U('keys_granted', plate))
      playerKeys[plate] = modelName
    end
  end
end)

RegisterNetEvent("carremote:keyUI")
AddEventHandler("carremote:keyUI", function()
  local ped = GetPlayerPed(-1)
  local coordA = GetEntityCoords(ped, 1)
  local vehicle = ESX.Game.GetClosestVehicle(coordA)
  if vehicle then
    local vehicleDistance = GetDistanceBetweenCoords(coordA, GetEntityCoords(vehicle, false), true)

    if vehicleDistance < Config.SwitchDistance then
      local plate     = ESX.Game.GetVehicleProperties(vehicle).plate
      local model     = GetEntityModel(vehicle)
      local modelName = tostring(model)

      if ESX.Game.GetVehicleProperties(vehicle).plate ~= nil then

        if checkKeys(plate, modelName) then

          if savedVehicle then
            if vehicle ~= savedVehicle then
              ESX.ShowNotification(_U('now_connected', plate))
              savedVehicle = vehicle
            end

            engineStatus          = GetIsVehicleEngineRunning(vehicle)
            lockStatus            = GetVehicleDoorLockStatus(vehicle)

            connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
          else
            ESX.ShowNotification(_U('now_connected', plate))

            savedVehicle          = vehicle
            engineStatus          = GetIsVehicleEngineRunning(vehicle)
            lockStatus            = GetVehicleDoorLockStatus(vehicle)

            connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
          end
        else
          ESX.TriggerServerCallback('carremote:checkOwnedVehicle', function(result)
            if result then
              ESX.ShowNotification(_U('now_connected', plate))

              savedVehicle          = vehicle
              engineStatus          = GetIsVehicleEngineRunning(vehicle)
              lockStatus            = GetVehicleDoorLockStatus(vehicle)

              if not playerKeys[plate] then
                ESX.ShowNotification(_U('keys_granted', plate))
                playerKeys[plate] = modelName
              end

              connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
            else
              if savedVehicle then
                if DoesEntityExist(savedVehicle) then
                  local vehicle2         = savedVehicle
                  engineStatus          = GetIsVehicleEngineRunning(vehicle2)
                  lockStatus            = GetVehicleDoorLockStatus(vehicle2)

                  connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
                else
                  disconnectedKeyFob()
                end
              else
                disconnectedKeyFob()
              end              
            end
          end, plate)
        end
      else
        if savedVehicle then
          if DoesEntityExist(savedVehicle) then
            local vehicle         = savedVehicle
            engineStatus          = GetIsVehicleEngineRunning(vehicle)
            lockStatus            = GetVehicleDoorLockStatus(vehicle)

            connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
          else
            disconnectedKeyFob()
          end
        else
          disconnectedKeyFob()
        end
      end
    else
      if savedVehicle then
        if DoesEntityExist(savedVehicle) then
          local vehicle         = savedVehicle
          engineStatus          = GetIsVehicleEngineRunning(vehicle)
          lockStatus            = GetVehicleDoorLockStatus(vehicle)

          connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
        else
          disconnectedKeyFob()
        end
      else
        disconnectedKeyFob()
      end
    end
  end
end)

function checkKeys(plate, modelName)
  if playerKeys[plate] then
    if tostring(playerKeys[plate]) == tostring(modelName) then
      return true
    else
      return false
    end
  else
    return false
  end
end

function connectedKeyFob(vehicleDistance, engineStatus, lockStatus)
  if Config.UseBattery then
    if Config.MaxRemoteRange >= vehicleDistance then
      local range = vehicleDistance / Config.MaxRemoteRange 
      range   = 100 - (math.floor((range * 10) + 0.5) * 10)
      battery = 'battery-' .. tostring(range)
      SendNUIMessage({type = tostring(battery)})
    else
      SendNUIMessage({type = 'battery-0'})
    end
  else
    SendNUIMessage({type = 'battery-100'})
  end

  if engineStatus then
    SendNUIMessage({type = 'engineOn'})
  else
    SendNUIMessage({type = 'engineOff'})
  end

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

function disconnectedKeyFob()
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

function unlockMotorcycleInside(vehicle)
  SetVehicleDoorsLocked(vehicle, 1)
  SetVehicleNeedsToBeHotwired(vehicle, false)
  ESX.ShowNotification(_U('unlocked'))
  TriggerServerEvent("carremote:playSound", 4, "unlock-inside", 0.10)
end

function lockMotorcycleInside(vehicle)
  SetVehicleDoorsLocked(vehicle, 7)
  SetVehicleNeedsToBeHotwired(vehicle, true)
  ESX.ShowNotification(_U('locked'))
  TriggerServerEvent("carremote:playSound", 4, "lock-inside", 0.10)
end

function unlockMotorcycleOutside(vehicle)
  playAnimation()
  SetVehicleDoorsLocked(vehicle, 1)
  SetVehicleNeedsToBeHotwired(vehicle, false)
  SetVehicleAlarm(vehicle, 0)
  ESX.ShowNotification(_U('unlocked')) 
  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "unlock-inside", Config.MaxFobBeepVolume, vehicleNetId)
end

function lockMotorcycleOutside(vehicle)
  playAnimation()
  SetVehicleDoorsLocked(vehicle, 7)
  SetVehicleNeedsToBeHotwired(vehicle, true)
  ESX.ShowNotification(_U('locked'))
  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "lock-outside", Config.MaxFobBeepVolume, vehicleNetId)
end

function unlockVehicleInside(vehicle)
  SetVehicleDoorsLocked(vehicle, 1)
  ESX.ShowNotification(_U('unlocked'))
  TriggerServerEvent("carremote:playSound", 4, "unlock-inside", 0.10)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverLocks", vehicleNetId, 1)
end

function lockVehicleInside(vehicle)
  SetVehicleDoorsLocked(vehicle, 2)
  ESX.ShowNotification(_U('locked'))
  TriggerServerEvent("carremote:playSound", 4, "lock-inside", 0.10)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverLocks", vehicleNetId, 2)
end

function unlockVehicleOutside(vehicle)
  playAnimation()
  SetVehicleDoorsLocked(vehicle, 1)
  SetVehicleAlarm(vehicle, 0)
  ESX.ShowNotification(_U('unlocked')) 
  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "unlock-inside", Config.MaxFobBeepVolume, vehicleNetId)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverLocks", vehicleNetId, 1)
end

function lockVehicleOutside(vehicle)
  playAnimation()
  SetVehicleDoorsLocked(vehicle, 2)
  ESX.ShowNotification(_U('locked'))
  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "lock-outside", Config.MaxFobBeepVolume, vehicleNetId)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverLocks", vehicleNetId, 2)
end

function engineOnInside(vehicle)
  ESX.ShowNotification(_U('engine_on'))
  SetVehicleEngineOn(vehicle, true, false, true)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverEngines", vehicleNetId, 1)
end

function engineOffInside(vehicle)
  ESX.ShowNotification(_U('engine_off'))
  SetVehicleEngineOn(vehicle, false, false, true)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverEngines", vehicleNetId, 0)
end

function engineOnOutside(vehicle)
  local ped = GetPlayerPed(-1)
  ClearPedTasks(ped)
  playAnimation()
  SetVehicleEngineOn(vehicle, true, true, true)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverEngines", vehicleNetId, 1)
end

function engineOffOutside(vehicle)
  local ped = GetPlayerPed(-1)
  ClearPedTasks(ped)
  playAnimation()
  SetVehicleEngineOn(vehicle, false, true, true)

  local vehicleNetId = VehToNet(vehicle)
  TriggerServerEvent("carremote:serverEngines", vehicleNetId, 0)
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

function playAnimation()
	local ped = GetPlayerPed(-1)
	local lib = "anim@mp_player_intmenu@key_fob@"
	local anim = "fob_click"

	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(ped, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end