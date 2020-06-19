function OpenCupboard(room)
    TriggerEvent('rtx_inventoryhud:openInventory', {
        type = 'cupboard',
        owner = room
    })
end
