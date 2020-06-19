secondInventory = nil

RegisterNUICallback('MoveToEmpty', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:MoveToEmpty', data)
    TriggerEvent('rtx_inventoryhud:MoveToEmpty', data)
    cb('OK')
end)

RegisterNUICallback('EmptySplitStack', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:EmptySplitStack', data)
    TriggerEvent('rtx_inventoryhud:EmptySplitStack', data)
    cb('OK')
end)

RegisterNUICallback('SplitStack', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:SplitStack', data)
    TriggerEvent('rtx_inventoryhud:SplitStack', data)
    cb('OK')
end)

RegisterNUICallback('CombineStack', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:CombineStack', data)
    TriggerEvent('rtx_inventoryhud:CombineStack', data)
    cb('OK')
end)

RegisterNUICallback('TopoffStack', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:TopoffStack', data)
    TriggerEvent('rtx_inventoryhud:TopoffStack', data)
    cb('OK')
end)

RegisterNUICallback('SwapItems', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:SwapItems', data)
    TriggerEvent('rtx_inventoryhud:SwapItems', data)
    cb('OK')
end)

RegisterNUICallback('GiveItem', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:GiveItem', data)
    cb('OK')
end)

RegisterNUICallback('GiveCash', function(data, cb)
    TriggerServerEvent('rtx_inventoryhud:GiveCash', data)
    cb('OK')
end)

RegisterNUICallback('CashStore', function(data, cb)
    print(data.type)
    TriggerServerEvent('rtx_inventoryhud:CashStore', data)
    cb('OK')
end)

RegisterNUICallback('CashTake', function(data, cb)
    print(data.owner)
    TriggerServerEvent('rtx_inventoryhud:CashTake', data)
    cb('OK')
end)

RegisterNUICallback('WeightError', function()
    --exports['mythic_notify']:DoHudText('error', 'Insufficient bag space!')
    TriggerEvent("pNotify:SendNotification", {layout = "centerLeft", type = "info", progressBar = true, theme = "mint", text = 'Insufficient bag space!', timeout=3500})
    PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
end)
RegisterNUICallback('MoneyError', function()
    --exports['mythic_notify']:DoHudText('error', 'Insufficient resources!')
    TriggerEvent("pNotify:SendNotification", {layout = "centerLeft", type = "info", progressBar = true, theme = "mint", text = 'Insufficient resources!', timeout=3500})
    PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
end)

RegisterNUICallback('GetNearPlayers', function(data, cb)
    if data.action == 'give' then
        SendNUIMessage({
            action = "nearPlayersGive",
            players = GetNeareastPlayers(),
            originItem = data.originItem
        })
    end
    if data.action == 'pay' then
        SendNUIMessage({
            action = "nearPlayersPay",
            players = GetNeareastPlayers(),
            originItem = data.originItem
        })
    end
    cb('OK')
end)

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 2.0)

    local players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            found_players = true
            table.insert(players_clean, { name = GetPlayerName(players[i]), id = GetPlayerServerId(players[i]) })
        end
    end
    return players_clean
end

RegisterNetEvent('rtx_inventoryhud:refreshInventory')
AddEventHandler('rtx_inventoryhud:refreshInventory', function()
    Citizen.Wait(250)
    refreshPlayerInventory()
    if secondInventory ~= nil then
        refreshSecondaryInventory()
    end
    SendNUIMessage({
        action = "unlock"
    })
end)

function refreshPlayerInventory()
    ESX.TriggerServerCallback('rtx_inventoryhud:getPlayerInventory', function(data)
        SendNUIMessage(
                { action = "setItems",
                  itemList = data.inventory,
                  invOwner = data.invId,
                  invTier = data.invTier,
                  money = {
                      cash = data.cash,
                      bank = data.bank,
                      black_money = data.black_money
                  }
                }
        )
        TriggerServerEvent('rtx_inventoryhud:openInventory', {
            type = 'player',
            owner = ESX.GetPlayerData().identifier
        })
    end, 'player', ESX.GetPlayerData().identifier)
end

function refreshSecondaryInventory()
    ESX.TriggerServerCallback('rtx_inventoryhud:canOpenInventory', function(canOpen)
        if canOpen or secondInventory.type == 'shop' or secondInventory.type == 'player' then
            ESX.TriggerServerCallback('rtx_inventoryhud:getSecondaryInventory', function(data)
                SendNUIMessage(
                        { action = "setSecondInventoryItems",
                          itemList = data.inventory,
                          invOwner = data.invId,
                          invTier = data.invTier,
                          money = {
                              cash = data.cash,
                              black_money = data.black_money
                          }
                        }
                )
                SendNUIMessage(
                        {
                            action = "show",
                            type = 'secondary'
                        }
                )
                TriggerServerEvent('rtx_inventoryhud:openInventory', secondInventory)
            end, secondInventory.type, secondInventory.owner)
        else
            SendNUIMessage(
                    {
                        action = "hide",
                        type = 'secondary'
                    }
            )
        end
    end, secondInventory.type, secondInventory.owner)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage({ action = "hide", type = 'primary' })
    SetNuiFocus(false, false)
    TriggerServerEvent('rtx_inventoryhud:closeInventory', {
        type = 'player',
        owner = ESX.GetPlayerData().identifier
    })
    if secondInventory ~= nil then
        TriggerServerEvent('rtx_inventoryhud:closeInventory', secondInventory)
    end
end

RegisterNetEvent('rtx_inventoryhud:openInventory')
AddEventHandler('rtx_inventoryhud:openInventory', function(sI)
    openInventory(sI)
end)

function openInventory(_secondInventory)
    isInInventory = true
    refreshPlayerInventory()
    SendNUIMessage({
        action = "display",
        type = "normal"
    })
    if _secondInventory ~= nil then
        secondInventory = _secondInventory
        refreshSecondaryInventory()
        SendNUIMessage({
            action = "display",
            type = 'secondary'
        })
    end
    SetNuiFocus(true, true)
end

RegisterNetEvent("rtx_inventoryhud:MoveToEmpty")
AddEventHandler("rtx_inventoryhud:MoveToEmpty", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("rtx_inventoryhud:EmptySplitStack")
AddEventHandler("rtx_inventoryhud:EmptySplitStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("rtx_inventoryhud:TopoffStack")
AddEventHandler("rtx_inventoryhud:TopoffStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("rtx_inventoryhud:SplitStack")
AddEventHandler("rtx_inventoryhud:SplitStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("rtx_inventoryhud:CombineStack")
AddEventHandler("rtx_inventoryhud:CombineStack", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

RegisterNetEvent("rtx_inventoryhud:SwapItems")
AddEventHandler("rtx_inventoryhud:SwapItems", function(data)
    playPickupOrDropAnimation(data)
    playStealOrSearchAnimation(data)
end)

function playPickupOrDropAnimation(data)
    if data.originTier.name == 'drop' or data.destinationTier.name == 'drop' then
        local playerPed = GetPlayerPed(-1)
        if not IsEntityPlayingAnim(playerPed, 'random@domestic', 'pickup_low', 3) then
            ESX.Streaming.RequestAnimDict('random@domestic', function()
                TaskPlayAnim(playerPed, 'random@domestic', 'pickup_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
            end)
        end
    end
end

function playStealOrSearchAnimation(data)
    if data.originTier.name == 'player' and data.destinationTier.name == 'player' then
        local playerPed = GetPlayerPed(-1)
        if not IsEntityPlayingAnim(playerPed, 'random@mugging4', 'agitated_loop_a', 3) then
            ESX.Streaming.RequestAnimDict('random@mugging4', function()
                --- TaskPlayAnim(playerPed, 'random@mugging4', 'agitated_loop_a', 8.0, -8, -1, 48, 0, 0, 0, 0)
            end)
        end
    end
end
