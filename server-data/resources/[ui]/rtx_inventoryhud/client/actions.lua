isHotKeyCoolDown = false
RegisterNUICallback('UseItem', function(data)
    if isWeapon(data.item.id) then
        currentWeaponSlot = data.slot
    end
    TriggerServerEvent('rtx_inventoryhud:notifyImpendingRemoval', data.item, 1)
    TriggerServerEvent("esx:useItem", data.item.id)
    TriggerEvent('rtx_inventoryhud:refreshInventory')
    data.item.msg = _U('used')
    data.item.qty = 1
    TriggerEvent('rtx_inventoryhud:showItemUse', {
        data.item
    })
end)

local keys = {
    157, 158, 160, 164, 165
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        BlockWeaponWheelThisFrame()
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(17)
        DisableControlAction(0, 37, true) --Disable Tab
        for k, v in pairs(keys) do
            if IsDisabledControlJustReleased(0, v) then
                UseItem(k)
            end
        end
        if IsDisabledControlJustReleased(0, 37) then
            ESX.TriggerServerCallback('rtx_inventoryhud:GetItemsInSlotsDisplay', function(items)
                SendNUIMessage({
                    action = 'showActionBar',
                    items = items
                })
            end)
        end
    end
end)

function UseItem(slot)
    if isHotKeyCoolDown then
        return
    end
    Citizen.CreateThread(function()
        isHotKeyCoolDown = true
        Citizen.Wait(Config.HotKeyCooldown)
        isHotKeyCoolDown = false
    end)
    ESX.TriggerServerCallback('rtx_inventoryhud:UseItemFromSlot', function(item)
        if item then
            if isWeapon(item.id) then
                currentWeaponSlot = slot
            end
            TriggerServerEvent('rtx_inventoryhud:notifyImpendingRemoval', item, 1)
            TriggerServerEvent("esx:useItem", item.id)
            item.msg = _U('used')
            item.qty = 1
            TriggerEvent('rtx_inventoryhud:showItemUse', {
                item,
            })
        end
    end
    , slot)
end

RegisterNetEvent('rtx_inventoryhud:showItemUse')
AddEventHandler('rtx_inventoryhud:showItemUse', function(items)
    local data = {}
    for k, v in pairs(items) do
        table.insert(data, {
            item = {
                label = v.label,
                itemId = v.id
            },
            qty = v.qty,
            message = v.msg
        })
    end
    SendNUIMessage({
        action = 'itemUsed',
        alerts = data
    })
end)
