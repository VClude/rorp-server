local currentWeapon
local currentWeaponSlot

RegisterNetEvent('rtx_inventoryhud:useWeapon')
AddEventHandler('rtx_inventoryhud:useWeapon', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('rtx_inventoryhud:removeCurrentWeapon')
AddEventHandler('rtx_inventoryhud:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        ClearPedTasks(PlayerPedId())
    end
end)

function RemoveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    TriggerServerEvent('rtx_inventoryhud:updateAmmoCount', hash, ammoCount)
    RemoveWeaponFromPed(playerPed, hash)
end

function GiveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    ESX.TriggerServerCallback('rtx_inventoryhud:getAmmoCount', function(ammoCount)
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        if checkh[weapon] == hash then
            SetPedAmmo(playerPed, hash, 1)
        elseif Config.FuelCan == hash and ammoCount == nil then
            SetPedAmmo(playerPed, hash, 1000)
        else
            SetPedAmmo(playerPed, hash, ammoCount or 0)
        end
    end, hash)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local player = PlayerPedId()
        if IsPedShooting(player) then
            for k, v in pairs(Config.Throwables) do
                if k == currentWeapon then
                    ESX.TriggerServerCallback('rtx_core:takePlayerItem', function(removed)
                        if removed then
                            TriggerEvent('rtx_inventoryhud:removeCurrentWeapon')
                        end
                    end, currentWeapon, 1)
                end
            end
        end
    end
end)