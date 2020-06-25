local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

  ESX                                     = nil
  local HasAlreadyEnteredMarker, LastZone = false, nil
  local isInShopMenu                      = false
  local currentlyCooking                  = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()

end)

AddEventHandler("rorp_pedagang:hasEnteredMarker",function(zone)

    if zone == "Cloakrooms" then

        CurrentAction = "cloakrooms_menu"

        CurrentActionMsg = _U('cloakroom')

        CurrentActionData = {}

    elseif zone == "BossMenu" then

        CurrentAction = "boss_menu"

        CurrentActionMsg = _U('bossmenu')

        CurrentActionData = {}

    elseif zone == "InventoryMenu" then

        CurrentAction = "pedagang_inventory_menu"

        CurrentActionMsg = _U('inventory')

        CurrentActionData = {}
        
    elseif zone == "Cooking" then

        CurrentAction = "cooking"

        CurrentActionMsg = _U('cooking')

        CurrentActionData = {}

    elseif zone == "Distributor" then

        CurrentAction = "distributor"

        CurrentActionMsg = _U('distri')

        CurrentActionData = {}

    end

end)

AddEventHandler("rorp_pedagang:hasExitedMarker", function(zone)
    CurrentAction = nil
    if not isInShopMenu then
        ESX.UI.Menu.CloseAll()
    end
end)

function DrawText3Ds(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextFont(6)
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 240
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 150)
end

-- Create Blips

Citizen.CreateThread(function()
    for _,v in pairs(Config.Blips) do
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, v.Sprite)
        SetBlipDisplay(blip, v.Display)
        SetBlipScale(blip, v.Scale)
        SetBlipColour(blip, v.Colour)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- Display markers

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "pedagang" then
            local coords, letSleep = GetEntityCoords(PlayerPedId()), true
            for k, v in pairs(Config.Zones) do
                if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
                    if ESX.PlayerData.grade_name == "juragan" then
                        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
                    end
                    letSleep = false
                end
            end

            if letSleep then
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

-- Enter / Exit marker events

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "pedagang" then
            local coords = GetEntityCoords(PlayerPedId())
            local isInMarker = false
            local currentZone = nil
            for k, v in pairs(Config.Zones) do
                if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
                    isInMarker = true
                    CurrentActionPos = v.Pos
                    currentZone = k
                end
            end

            if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                HasAlreadyEnteredMarker = true
                LastZone = currentZone
                TriggerEvent("rorp_pedagang:hasEnteredMarker", currentZone)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                TriggerEvent("rorp_pedagang:hasExitedMarker", LastZone)
            end
        end
    end
end)

function NotifInformasi(text)
	exports['mythic_notify']:SendAlert('inform', text, 5000)
end

function NotifSukses(text)
	exports['mythic_notify']:SendAlert('success', text, 5000)
end

function NotifError(text)
	exports['mythic_notify']:SendAlert('error', text, 5000)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)

        if ESX.PlayerData.job and ESX.PlayerData.job.name == "pedagang" then
            if CurrentAction then
                DrawText3Ds(CurrentActionPos.x, CurrentActionPos.y, CurrentActionPos.z, CurrentActionMsg)

                if IsControlJustReleased(0, Keys["E"]) then
                    if CurrentAction == "cloakrooms_menu" then
                        OpenCloakRoomsMenu()

                    elseif CurrentAction == "boss_menu" then
                        if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name == 'boss' then
                            OpenBossMenu()
                        else
                            NotifInformasi('Anda bukan BOSS')
                        end						
                    elseif CurrentAction == "bennys_inventory_menu" then
                        if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name ~= 'magang' and ESX.PlayerData.job.grade_name ~= 'karyawan_bengkel' then						
                            OpenBennysInventoryMenu()
                        else
                            NotifInformasi('Anda tidak memiliki akses membuka inventory')
                        end							
                    elseif CurrentAction == 'ls_custom' then
                        if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name ~= 'magang' then						
                            OpenLSAction()
                        else
                            NotifInformasi('Pengalaman anda kurang untuk modifikasi kendaraan')
                        end
                    end

                    CurrentAction = nil

                end

            end

            if ( IsControlJustReleased( 0, 167 ) or IsDisabledControlJustReleased( 0, 167 ) ) and GetLastInputMethod( 0 ) and not IsDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'mobile_mechanic_actions') and (GetGameTimer() - GUI.Time) > 150 then
                OpenMobileMechanicActionsMenu()
            end

        else

            Citizen.Wait(500)

        end

    end

end)