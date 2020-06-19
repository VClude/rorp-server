function ShowViewProperty(property)

    local propData = GetPropertyDataForProperty(property)

    if propData == nil then
        return
    end

    local options = {
        { label = 'View property', action = function()
            EnterProperty(property)
        end, },
        { label = 'Buy a property for $' .. propData.price, action = function()
            ShowConfirmBuy(property)
        end }
    }

    local menu = {
        title = 'View property',
        name = 'view_property',
        options = options
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function ShowManageProperty(property)
    local options = {
        { label = 'Give the keys', action = function()
            ShowGiveKeys(property)
        end },
        { label = 'Take the keys', action = function()
            ShowKeyUsers(property)
        end },
        { label = 'Sell ​​real estate', action = function()
            ShowConfirmSell(property)
        end }
    }

    local menu = {
        name = 'property_management',
        title = 'Manage real estate',
        options = options
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function ShowConfirmSell(property)
    local options = {
        { label = 'Yes', action = function()
            SellProperty(property)
        end },
        { label = 'No', action = function()
            ESX.UI.Menu.Close('confirm_sell')
        end }
    }

    local menu = {
        name = 'confirm_sell',
        title = 'Confirm',
        options = options
    }

    TriggerEvent('rtx_core:openMenu', menu)
end

function SellProperty(property)
    TriggerServerEvent('rtx_property:sellProperty', property)
    ESX.UI.Menu.CloseAll()
    exports['mythic_notify']:SendAlert('success', 'Nemovitost prodána!')
    TriggerEvent('rtx_property:forceUpdatePropertyData')
end

function ShowConfirmBuy(property)
    local options = {
        { label = 'Yes', action = function()
            BuyProperty(property)
        end },
        { label = 'No', action = function()
            ESX.UI.Menu.Close('confirm_buy')
        end }
    }

    local menu = {
        name = 'confirm_buy',
        title = 'Confirm',
        options = options
    }

    TriggerEvent('rtx_core:openMenu', menu)
end

function BuyProperty(property)
    ESX.TriggerServerCallback('rtx_property:buyProperty', function(bought)
        if bought then
            ESX.UI.Menu.CloseAll()
            exports['mythic_notify']:SendAlert('success', 'Property purchased!')
            TriggerEvent('rtx_property:forceUpdatePropertyData')
        else
            exports['mythic_notify']:SendAlert('error', "You don't have enough money!")
        end
    end, property)
end

function ShowGiveKeys(property)
    local menu = {
        type = 'dialog',
        name = 'searching_users',
        title = 'Enter your first or last name',
        action = function(value)
            ShowSearchedUsers(value, property)
        end
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function ShowSearchedUsers(value, property)
    ESX.TriggerServerCallback('rtx_property:searchUsers', function(results)
        if #results == 0 then
            exports['mythic_notify']:SendAlert('error', 'No person found')
            return
        end
        local options = {}
        for k, v in pairs(results) do
            table.insert(options,
                    {
                        label = v.firstname .. ' ' .. v.lastname, action = function(value, m)
                        TriggerServerEvent('rtx_property:GiveKeys', property, v.identifier)
                        exports['mythic_notify']:SendAlert('success', 'You gave the keys to the person ' .. v.firstname .. ' ' .. v.lastname)
                        ESX.UI.Menu.CloseAll()
                    end
                    })
        end
        local menu = {
            type = 'default',
            name = 'property_civ_select',
            title = 'Select a person',
            options = options
        }
        TriggerEvent('rtx_core:openMenu', menu)
    end, value)
end

function ShowKeyUsers(property)
    ESX.TriggerServerCallback('rtx_property:getKeyUsers', function(results)
        if #results == 0 then
            exports['mythic_notify']:SendAlert('error', 'No person found')
            return
        end
        local options = {}
        for k, v in pairs(results) do
            table.insert(options,
                    {
                        label = v.firstname .. ' ' .. v.lastname, action = function(value, m)
                        TriggerServerEvent('rtx_property:TakeKeys', property, v.identifier)
                        exports['mythic_notify']:SendAlert('success', 'You took the keys to the person ' .. v.firstname .. ' ' .. v.lastname)
                        ESX.UI.Menu.CloseAll()
                    end
                    })
        end
        local menu = {
            type = 'default',
            name = 'property_civ_select',
            title = 'Select a person',
            options = options
        }
        TriggerEvent('rtx_core:openMenu', menu)
    end, property)
end
