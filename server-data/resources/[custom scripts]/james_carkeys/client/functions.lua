Init = function()
    ESX.UI.Menu.CloseAll()

    ESX.TriggerServerCallback("james_carkeys:fetchKeys", function(fetchedKeys)
        if fetchedKeys then
            cachedData["keys"] = fetchedKeys
        end
    end)
end

AddTemporaryKey = function(vehiclePlate)
    cachedData["tempKeys"][vehiclePlate] = true
end

HasVehicleAccess = function(vehiclePlate)
    if cachedData["tempKeys"][vehiclePlate] then 
        return true 
    end

    return false
end

HotwireVehicle = function(vehicleEntity)
    if cachedData["hotwiring"] then return end

    local vehiclePlate = GetVehicleNumberPlateText(vehicleEntity)

    if cachedData["hotwiredVehicles"][vehiclePlate] then return ESX.ShowNotification("You've already hotwired this vehicle, you failed.") end

    cachedData["hotwiring"] = true

    Citizen.CreateThread(function()
        local ped = PlayerPedId()

        LoadAnimDict("mini@repair")

        local startedHotwiring = GetGameTimer()

        TaskPlayAnim(ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 17, 0, 0, 0, 0)

        DrawBusySpinner("Hotwiring...")

        while cachedData["hotwiring"] do
            Citizen.Wait(5)

            if not IsEntityPlayingAnim(ped, "mini@repair", "fixing_a_player", 3) then
                break
            end

            if GetGameTimer() - startedHotwiring > Config.HotwireTimer then
                local randomLuck = math.random(5)

                if randomLuck >= 3 then
                    SetVehicleEngineOn(vehicleEntity, true, true, false)

                    ESX.ShowNotification("Hotwire succeded, remember dont halt the engine.")
                else
                    cachedData["hotwiredVehicles"][vehiclePlate] = true

                    ESX.ShowNotification("Hotwire failed...")
                end

                break
            end
        end

        SetVehicleAlarm(vehicleEntity, true)
        SetVehicleAlarmTimeLeft(vehicleEntity, 60000)

        RemoveLoadingPrompt()

        RemoveAnimDict("mini@repair")

        ClearPedTasks(ped)

        cachedData["hotwiring"] = false
    end)
end

OpenVehicleMenu = function()
    local menuElements = {}

    local gameVehicles = ESX.Game.GetVehicles()
    local pedCoords = GetEntityCoords(PlayerPedId())

    for _, vehicle in ipairs(gameVehicles) do
        if DoesEntityExist(vehicle) then
            local vehiclePlate = GetVehicleNumberPlateText(vehicle)
            
            if HasKey("veh-" .. vehiclePlate) then
                local dstCheck = math.floor(#(pedCoords - GetEntityCoords(vehicle)))

                table.insert(menuElements, {
                    ["label"] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. " with plate - " .. vehiclePlate .. " - " .. dstCheck .. " meters away.",
                    ["vehicleData"] = vehicleData,
                    ["vehicleEntity"] = vehicle
                })
            end
        end
    end

    if #menuElements == 0 then
        table.insert(menuElements, {
            ["label"] = "You don't have any vehicle in the world."
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_vehicle_menu", {
        ["title"] = "Current vehicles.",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentVehicle = menuData["current"]["vehicleEntity"]

        if currentVehicle then
            ChooseVehicleAction(currentVehicle, function(actionChosen)
                VehicleAction(currentVehicle, actionChosen)
            end)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end, function(menuData, menuHandle)
        local currentVehicle = menuData["current"]["vehicle"]

        if currentVehicle then
            SpawnLocalVehicle(currentVehicle["props"])
        end
    end)
end

ChooseVehicleAction = function(vehicleEntity, callback)
    if not cachedData["blips"] then cachedData["blips"] = {} end

    local menuElements = {
        {
            ["label"] = (GetVehicleDoorLockStatus(vehicleEntity) == 1 and "Lock" or "Unlock") .. " vehicle.",
            ["action"] = "change_lock_state"
        },
        {
            ["label"] = "Turn " .. (GetIsVehicleEngineRunning(vehicleEntity) and "off" or "on") .. " the engine.",
            ["action"] = "change_engine_state"
        },
        {
            ["label"] = "Turn " .. (DoesBlipExist(cachedData["blips"][vehicleEntity]) and "off" or "on") .. " gps tracker.",
            ["action"] = "change_gps_state"
        },
        {
            ["label"] = "Control doors.",
            ["action"] = "change_door_state"
        },
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "second_vehicle_menu", {
        ["title"] = "Choose an action for - " .. GetVehicleNumberPlateText(vehicleEntity),
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentAction = menuData["current"]["action"]

        if currentAction then
            menuHandle.close()

            callback(currentAction)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

VehicleAction = function(vehicleEntity, action)
    local dstCheck = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicleEntity))

    while not NetworkHasControlOfEntity(vehicleEntity) do
        Citizen.Wait(0)
    
        NetworkRequestControlOfEntity(vehicleEntity)
    end

    if action == "change_lock_state" then
        if dstCheck >= Config.RangeCheck then return ESX.ShowNotification("Too far away from the vehicle to control it.") end

        PlayAnimation(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click", {
            ["speed"] = 8.0,
            ["speedMultiplier"] = 8.0,
            ["duration"] = 1820,
            ["flag"] = 49,
            ["playbackRate"] = false
        })

        for index = 1, 4 do
            if (index % 2 == 0) then
                SetVehicleLights(vehicleEntity, 2)
            else
                SetVehicleLights(vehicleEntity, 0)
            end

            Citizen.Wait(300)
        end

        StartVehicleHorn(vehicleEntity, 50, 1, false)
        
        local vehicleLockState = GetVehicleDoorLockStatus(vehicleEntity)

        if vehicleLockState == 1 then
            SetVehicleDoorsLocked(vehicleEntity, 2)
            PlayVehicleDoorCloseSound(vehicleEntity, 1)
        elseif vehicleLockState == 2 then
            SetVehicleDoorsLocked(vehicleEntity, 1)
            PlayVehicleDoorOpenSound(vehicleEntity, 0)

            local oldCoords = GetEntityCoords(PlayerPedId())
            local oldHeading = GetEntityHeading(PlayerPedId())

            if not IsPedInVehicle(PlayerPedId(), vehicleEntity) and not DoesEntityExist(GetPedInVehicleSeat(vehicleEntity, -1)) then
                SetPedIntoVehicle(PlayerPedId(), vehicleEntity, -1)
                TaskLeaveVehicle(PlayerPedId(), vehicleEntity, 16)
                SetEntityCoords(PlayerPedId(), oldCoords - vector3(0.0, 0.0, 0.99))
                SetEntityHeading(PlayerPedId(), oldHeading)
            end
        end

        ESX.ShowNotification(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))) .. " with plate - " .. GetVehicleNumberPlateText(vehicleEntity) .. " is now " .. (vehicleLockState == 1 and "LOCKED" or "UNLOCKED"))
    elseif action == "change_door_state" then
        if dstCheck >= Config.RangeCheck then return ESX.ShowNotification("Too far away from the vehicle to control it.") end

        ChooseDoor(vehicleEntity, function(doorChosen)
            if doorChosen then
                if GetVehicleDoorAngleRatio(vehicleEntity, doorChosen) == 0 then
                    SetVehicleDoorOpen(vehicleEntity, doorChosen, false, false)
                else
                    SetVehicleDoorShut(vehicleEntity, doorChosen, false, false)
                end
            end
        end)
    elseif action == "change_engine_state" then
        if dstCheck >= Config.RangeCheck then return ESX.ShowNotification("Too far away from the vehicle to control it.") end

        if GetIsVehicleEngineRunning(vehicleEntity) then
            SetVehicleEngineOn(vehicleEntity, false, false)

            cachedData["engineState"] = true

            Citizen.CreateThread(function()
                while cachedData["engineState"] do
                    Citizen.Wait(5)

                    SetVehicleUndriveable(vehicleEntity, true)
                end

                SetVehicleUndriveable(vehicleEntity, false)
            end)
        else
            cachedData["engineState"] = false

            SetVehicleEngineOn(vehicleEntity, true, true)
        end
    elseif action == "change_gps_state" then
        if DoesBlipExist(cachedData["blips"][vehicleEntity]) then
            RemoveBlip(cachedData["blips"][vehicleEntity])
        else
            cachedData["blips"][vehicleEntity] = AddBlipForEntity(vehicleEntity)
    
            SetBlipSprite(cachedData["blips"][vehicleEntity], GetVehicleClass(vehicleEntity) == 8 and 226 or 225)
            SetBlipScale(cachedData["blips"][vehicleEntity], 1.05)
            SetBlipColour(cachedData["blips"][vehicleEntity], 30)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Personal vehicle - " .. GetVehicleNumberPlateText(vehicleEntity))
            EndTextCommandSetBlipName(cachedData["blips"][vehicleEntity])
        end
    end
end

ChooseDoor = function(vehicleEntity, callback)
    local menuElements = {
        {
            ["label"] = "Front left.",
            ["door"] = 0
        },
        {
            ["label"] = "Front right.",
            ["door"] = 1
        },
        {
            ["label"] = "Back left.",
            ["door"] = 2
        },
        {
            ["label"] = "Back right.",
            ["door"] = 3
        },
        {
            ["label"] = "Hood.",
            ["door"] = 4
        },
        {
            ["label"] = "Trunk.",
            ["door"] = 5
        }
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "door_vehicle_menu", {
        ["title"] = "Choose a door",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentDoor = menuData["current"]["door"]

        if currentDoor then
            callback(currentDoor)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        return ESX.ShowNotification("This model does not exist ingame.")
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end

LoadAnimDict = function(animDict)
    if HasAnimDictLoaded(animDict) then return end

    RequestAnimDict(animDict)

    while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(0)
	end
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

UUID = function()
    math.randomseed(GetGameTimer() * math.random())

    return math.random(100000, 999999)
end