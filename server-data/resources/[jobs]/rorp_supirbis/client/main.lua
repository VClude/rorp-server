local E_KEY = 38

local playerPosition = nil
local playerPed = nil

local isBusDriver = false
local isOnDuty = false
local isRouteFinished = false
local isRouteJustStarted = false
local isRouteJustAborted = false

local activeRoute = nil
local activeRouteLine = nil
local busType = nil
local stopNumber = 1
local lastStopCoords = {}
local totalMoneyPaidThisRoute = 0

local pedsOnBus = {}
local pedsAtNextStop = {}
local pedsToDelete = {}
local numberDepartingPedsNextStop = 0

Citizen.CreateThread(function()
    waitForEsxInitialization()
    waitForPlayerJobInitialization()
    registerJobChangeListener()

    Overlay.Init()
    startAbortRouteThread()
    startMainLoop()
end)

function waitForEsxInitialization()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end

function waitForPlayerJobInitialization()
    while true do
        local playerData = ESX.GetPlayerData()
        if playerData.job ~= nil then
            handleJobChange(playerData.job)
            break
        end
        Citizen.Wait(10)
    end
end

function registerJobChangeListener()
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', handleJobChange)
end

function startAbortRouteThread()
    Citizen.CreateThread(function()
        while true do
            if isOnDuty and not isRouteFinished and not isRouteJustStarted and not isRouteJustAborted then
                handleAbortRoute()
                Citizen.Wait(15)
            else
                Citizen.Wait(1000)
            end
        end
    end)
end

function startMainLoop()
    while true do
        if isBusDriver and not isRouteJustAborted then
            playerPed = PlayerPedId()
            playerPosition = GetEntityCoords(playerPed)

            if not isOnDuty then
                for i = 1, #Config.Routes do
                    handleSpawnPoint(i)
                end
                Citizen.Wait(5)
            elseif isPlayerNotInBus() then
                ESX.ShowHelpNotification(_('get_back_in_bus'))
                Citizen.Wait(5)
            else
                handleActiveRoute()
                Citizen.Wait(100)
            end
        else
            Citizen.Wait(1000)
        end
    end
end

function isPlayerNotInBus()
    local vehiclePlayerIsIn = GetVehiclePedIsIn(playerPed, false)
    return vehiclePlayerIsIn ~= Bus.bus
end

function handleJobChange(job)
    local wasBusDriver = isBusDriver
    isBusDriver = job.name == 'busdriver'

    if isBusDriver ~= wasBusDriver then
        if isBusDriver then
            handleNowBusDriver()
        else
            handleNoLongerBusDriver()
        end
    end
end

function handleNowBusDriver()
    Markers.StartMarkers()
    Blips.StartBlips()
end

function handleNoLongerBusDriver()
    immediatelyEndRoute()
    Markers.StopMarkers()
    Blips.StopBlips()
end

function handleSpawnPoint(locationIndex)
    local route = Config.Routes[locationIndex]
    local coords = route.SpawnPoint;
    
    if playerDistanceFromCoords(coords) < Config.Markers.Size then
        ESX.ShowHelpNotification(_U('start_route', _(route.Name)))

        if IsControlJustPressed(1, E_KEY) then
            startRoute(locationIndex)
        end
    end
end

function startRoute(route)
    activeRouteLine = selectStartingLine(Config.Routes[route])
    if activeRouteLine == nil then
        ESX.ShowNotification(_U('route_selection_cancel'))
        return
    end

    handleSettingRouteJustStartedAsync()
    isOnDuty = true
    isRouteFinished = false
    activeRoute = Config.Routes[route]
    busType = getBusType(activeRoute, activeRouteLine)
    totalMoneyPaidThisRoute = 0
    ESX.ShowNotification(_U('route_assigned', _U(activeRouteLine.Name)))
    Events.RouteStarted(activeRouteLine.Name)
    Bus.CreateBus(activeRoute.SpawnPoint, busType.BusModel, activeRouteLine.BusColor)
    Blips.StartAbortBlip(activeRoute.Name, activeRoute.SpawnPoint)
    Markers.StartAbortMarker(activeRoute.SpawnPoint)
    Overlay.Start()

    stopNumber = 0
    setUpNextStop()
    stopNumber = 1

    local firstStopName = _U(activeRouteLine.Stops[1].name)
    ESX.ShowNotification(_U('drive_to_first_marker', firstStopName))
    updateOverlay(firstStopName)
end

function selectStartingLine(selectedRoute)
    if #selectedRoute.Lines == 1 then
        return selectedRoute.Lines[1]
    end

    return handleMultiLineRouteSelection(selectedRoute)
end

function handleMultiLineRouteSelection(selectedRoute)
    local selectedIndex = nil

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'line_selector', {
        title = _U('route_selection_title', _U(selectedRoute.Name)),
        align = 'top-left', 
        elements = buildStartingLineMenuElements(selectedRoute)
    }, function (data, menu)
        menu.close()
        selectedIndex = data.current.value
    end, function (data, menu)
        menu.close()
        selectedIndex = -1
    end)

    while selectedIndex == nil do
       Citizen.Wait(1) 
    end

    if selectedIndex == -1 then
        return nil
    elseif selectedIndex == 0 then
        return selectedRoute.Lines[math.random(1, #selectedRoute.Lines)]
    end

    return selectedRoute.Lines[selectedIndex]
end

function buildStartingLineMenuElements(selectedRoute)
    local elements = {{label = _U('route_selection_random'), value = 0}}
    for i = 1, #selectedRoute.Lines do
        table.insert(elements, {label = _U(selectedRoute.Lines[i].Name), value = i})
    end
    return elements
end

function getBusType(route, line)
    return line.BusOverride or route.Bus or getBackwardsCompatibleBusType(route)
end

function getBackwardsCompatibleBusType(route)
    return {
        BusModel = route.BusModel,
        Capacity = route.Capacity,
        Doors = route.Doors,
        FirstSeat = route.FirstSeat
    }
end

function handleSettingRouteJustStartedAsync()
    isRouteJustStarted = true
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        isRouteJustStarted = false
    end)
end

function handleActiveRoute()
    if isRouteFinished then
        handleReturningBus()
    else
        handleNormalStop()
    end
end

function handleReturningBus()
    local coords = getReturnPointCoords(activeRoute, activeRouteLine)

    if playerDistanceFromCoords(coords) < Config.Markers.Size then
        Bus.DisplayMessageAndWaitUntilBusStopped(_U('stop_bus'))

        TriggerServerEvent('rorp_supirbis:finishRoute', activeRoute.Payment)
        Events.RouteEnded()
        immediatelyEndRoute()

        Markers.ResetMarkers()
        Blips.ResetBlips()
    end
end

function handleNormalStop()
    local currentStop = activeRouteLine.Stops[stopNumber]
    local currentStopNameKey = activeRouteLine.Stops[stopNumber].name

    if playerDistanceFromCoords(currentStop) < Config.Markers.Size then
        local nextStopNameKey = determineNextStopName()
        lastStopCoords = currentStop
        Events.ArrivedAtStop(currentStopNameKey, nextStopNameKey)
        handleUnloading(currentStop)
        handleLoading()
        payForEachStation()
        
        local nextStopName = _U(nextStopNameKey)
        if (isLastStop(stopNumber)) then
            local coords = getReturnPointCoords(activeRoute, activeRouteLine)
            isRouteFinished = true
            Markers.StopAbortMarker()
            Markers.SetMarkers({coords})
            Blips.SetBlipAndWaypoint(activeRoute.Name, coords.x, coords.y, coords.z)
            Blips.StopAbortBlip()
            ESX.ShowNotification(_U('return_to_terminal'))
        else
            ESX.ShowNotification(_U('drive_to_next_marker', nextStopName))
            setUpNextStop()
            stopNumber = stopNumber + 1
        end

        Events.DepartingStop(currentStopNameKey, nextStopNameKey)
        updateOverlay(nextStopName)
    end
end

function determineNextStopName()
    if (isLastStop(stopNumber)) then
        return 'terminal'
    end

    return activeRouteLine.Stops[stopNumber + 1].name
end

function getReturnPointCoords(route, line)
    return line.BusReturnPointOverride or activeRoute.BusReturnPoint or activeRoute.SpawnPoint
end

function handleUnloading(stopCoords)
    Bus.DisplayMessageAndWaitUntilBusStopped(_U('wait_for_passengers'))
    Bus.OpenDoorsAndActivateHazards(busType.Doors)
end

function handleLoading()
    Citizen.Wait(Config.DelayBetweenChanges)
    Bus.CloseDoorsAndDeactivateHazards()
end


function payForEachStation()
    local amountToPay = activeRoute.PaymentPerStation
    totalMoneyPaidThisRoute = totalMoneyPaidThisRoute + amountToPay
end

function setUpNextStop()
    local nextStop = activeRouteLine.Stops[stopNumber + 1]
    
    Markers.SetMarkers({nextStop})
    Blips.SetBlipAndWaypoint(activeRoute.Name, nextStop.x, nextStop.y, nextStop.z)
end

function isLastStop(stopNumber)
    return stopNumber == #activeRouteLine.Stops
end

function setUpLastStop()
    Log.debug('next stop is last, all peds should depart')
    return 0, #pedsOnBus
end

function setUpAllStop()
    Log.debug('next stop is All, all peds should unload, should spawn peds equal to capacity')
    return busType.Capacity, #pedsOnBus
end


function handleAbortRoute()
    if playerDistanceFromCoords(activeRoute.SpawnPoint) < Config.Markers.Size then
        ESX.ShowHelpNotification(_U('abort_route_help', totalMoneyPaidThisRoute))

        if IsControlJustPressed(1, E_KEY) then
            handleSettingRouteJustAbortedAsync()
            TriggerServerEvent('rorp_supirbis:abortRoute', totalMoneyPaidThisRoute)

            immediatelyEndRoute()
            Blips.ResetBlips()
            Markers.ResetMarkers()
        end
    end
end

function handleSettingRouteJustAbortedAsync()
    isRouteJustAborted = true
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        isRouteJustAborted = false
    end)
end

function immediatelyEndRoute()
    isOnDuty = false
    activeRoute = nil
    activeRouteLine = nil
    Bus.DeleteBus()
    Overlay.Stop()
end

function playerDistanceFromCoords(coords)
    return GetDistanceBetweenCoords(playerPosition, coords.x, coords.y, coords.z, true)
end

function updateOverlay(nextStopName)
    Overlay.Update(_U(activeRouteLine.Name), nextStopName, #activeRouteLine.Stops - stopNumber, totalMoneyPaidThisRoute)
end
