local markers = {}
local drawingMarkers = {}
local CurrentMarker = nil
local blips = {}

local HasAlreadyEnteredMarker

RegisterCommand('clearmarkers', function()
    drawingMarkers = {}
    markers = {}
end)

RegisterNetEvent('rtx_core:registerMarker')
AddEventHandler('rtx_core:registerMarker', function(marker)
    if marker.coords == nil then
        print('Needs Coords for marker')
        return
    end
    if marker.shouldDraw == nil then
        marker.shouldDraw = function()
            return true
        end
    else
        marker.shouldDraw()
    end

    if marker.command then
        RegisterCommand(marker.command.key, function(src, args, raw)
            local command = marker.command.key
            if args and marker.command.args then
                command = command .. ' ' .. marker.command.args
            end
            if raw == command then
                TriggerEvent('rtx_core:triggerCurrentMarkerAction')
            end
        end)
    end

    if Config.Debug then
        print('[rtx_core] Registering Marker ' .. marker.name)
    end
    if markers[marker.name] ~= nil then
        marker.changed = true
        markers[marker.name] = marker
    elseif marker.name ~= nil then
        markers[marker.name] = marker
    else
        table.insert(marker.name)
    end

end)

RegisterNetEvent('rtx_core:removeMarker')
AddEventHandler('rtx_core:removeMarker', function(name)
    markers[name] = nil
    drawingMarkers[name] = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local isInMarker = false
        local lastMarker
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k, v in pairs(markers) do
            if v.shouldDraw() then
                local distance = #(coords - v.coords)
                if (drawingMarkers[k] == nil or v.changed) and distance <= Config.DrawDistance then
                    markers[k].changed = false
                    drawingMarkers[k] = v
                elseif drawingMarkers[k] ~= nil then
                    drawingMarkers[k].distance = distance
                    if distance > Config.DrawDistance then
                        drawingMarkers[k] = nil
                    end
                end
                if distance < v.size.x then
                    if v.enableE then
                        EnableControlAction(0, 38)
                    end
                    isInMarker = true
                    lastMarker = v
                end
            end
        end

        if isInMarker and not HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = true
            TriggerEvent('rtx_core:hasEnteredMarker', lastMarker)
        end
        if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('rtx_core:hasExitedMarker')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(drawingMarkers) do
            if v.show3D then
                if v.distance ~= nil and v.distance <= Config.Draw3DDistance then
                    TriggerEvent('rtx_core:draw3Dtext', v.coords, v.msg, v.radius)
                end
            elseif v.type ~= -1 then
                DrawMarker(v.type, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size.x, v.size.y, v.size.z, v.colour.r, v.colour.g, v.colour.b, 100, getOrElse(v.bob, false), true, 2, getOrElse(v.rotate, true), false, false, false)
            end
        end

    end
end)

AddEventHandler('rtx_core:hasExitedMarker', function()
    CurrentMarker = nil
    ESX.UI.Menu.CloseAll()
end)

AddEventHandler('rtx_core:hasEnteredMarker', function(marker)
    if marker.show3D then
        PlaySound(GetSoundId(), "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    end
    CurrentMarker = marker
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentMarker then
            if not CurrentMarker.show3D and CurrentMarker.msg then
                ESX.ShowHelpNotification(CurrentMarker.msg)
            end

            if IsControlJustReleased(0, 38) then
                if CurrentMarker.action ~= nil then
                    CurrentMarker.action(CurrentMarker)
                end
            end
        end
    end
end)

RegisterNetEvent('rtx_core:triggerCurrentMarkerAction')
AddEventHandler('rtx_core:triggerCurrentMarkerAction', function()
    if CurrentMarker and CurrentMarker.action ~= nil then
        CurrentMarker.action(CurrentMarker)
    end
end)

RegisterNetEvent('rtx_core:registerBlip')
AddEventHandler('rtx_core:registerBlip', function(blip)

    if blip.coords == nil then
        return
    end

    local _blip = AddBlipForCoord(blip.coords)
    SetBlipSprite(_blip, getOrElse(blip.sprite, 1))
    SetBlipAsShortRange(_blip, true)
    SetBlipDisplay(_blip, getOrElse(blip.display, 4))

    if blip.scale then
        SetBlipScale(_blip, getOrElse(blip.scale, 0.5))
    end
    SetBlipColour(_blip, getOrElse(blip.colour, 1))
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(getOrElse(blip.name, "Nezname jmeno"))
    EndTextCommandSetBlipName(_blip)
    blips[getOrElse(blip.id, #blips + 1)] = {
        _blip = _blip,
        blip = blip
    }
end)

RegisterNetEvent('rtx_core:updateBlip')
AddEventHandler('rtx_core:updateBlip', function(blip, debug)
    if blip.id == nil or blips[blip.id] == nil then
        return
    end
    local _blip = blips[blip.id]._blip

    if blip.coords then

        if _blip and GetBlipCoords(_blip) ~= blip.coords then
            RemoveBlip(_blip)
            local tempBlip = blips[blip.id].blip
            blips[blip.id] = nil
            tempBlip.coords = blip.coords
            tempBlip.display = blip.display
            TriggerEvent('rtx_core:registerBlip', tempBlip)
            return
        end

    end

    if blip.sprite then
        SetBlipSprite(_blip, blip.sprite)
    end
    if blip.display then
        SetBlipDisplay(_blip, blip.display)
    end
    if blip.scale then
        SetBlipScale(_blip, getOrElse(blip.scale, 0.5))
    end
    if blip.colour then
        SetBlipScale(_blip, blip.colour)
    end
    if blip.name then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blip.name)
        EndTextCommandSetBlipName(_blip)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource:find('rtx') then
        TriggerEvent('rtx_core:hasExitedMarker')
    end
end)
