function OpenKitchen(property)

    local options = {
        { label = 'Make Bread', action = MakeFood }
    }

    if IsPlayerOwnerOf(property) then
        table.insert(options, { label = 'manage', action = function()
            ShowManageProperty(property)
        end })
    end

    local menu = {
        name = 'kitchen',
        title = 'kitchen',
        options = options
    }

    TriggerEvent('rtx_core:openMenu', menu)
end

function MakeFood()
    TriggerServerEvent('rtx_core:givePlayerItem', 'bread', 1)
end
