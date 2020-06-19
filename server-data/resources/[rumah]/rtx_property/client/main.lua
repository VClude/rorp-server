ESX = nil
local propertyData = {}
local propertyOwners = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    ESX.TriggerServerCallback('rtx_property:getPropertyData', function(data, owners)
        propertyData = data
        propertyOwners = owners
    end)
end)

RegisterNetEvent('rtx_property:updatePropertyData')
AddEventHandler('rtx_property:updatePropertyData', function(updatePropertyData, updateOwners)
    propertyData = updatePropertyData
    propertyOwners = updateOwners
end)

RegisterNetEvent('rtx_property:forceUpdatePropertyData')
AddEventHandler('rtx_property:forceUpdatePropertyData', function()
    ESX.TriggerServerCallback('rtx_property:getPropertyData', function(data, owners)
        propertyData = data
        propertyOwners = owners
    end)
end)

Citizen.CreateThread(function()
    for propertyIndex, property in pairs(Config.Properties) do

        local marker = {
            name = property.name .. '_prop_enter' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 3,
            coords = property.outside.coords,
            colour = { r = 55, b = 55, g = 255 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro vstup do  ' .. property.name,
            action = function()
                EnterProperty(property)
            end,
            property = property,
            shouldDraw = function()
                return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)

        local marker = {
            name = property.name .. '_prop_view' .. propertyIndex,
            type = 29,
			show3D = true,
			radius = 3,
            coords = property.view.coords,
            colour = { r = 55, b = 55, g = 255 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro zobrazeni ' .. property.name,
            action = function()
                ShowViewProperty(property)
            end,
            property = property,
            shouldDraw = function()
                return not IsPropertySold(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)

        local marker = {
            name = property.name .. '_prop_exit' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 3,
            coords = property.inside.coords,
            colour = { r = 0, b = 0, g = 0 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro odchod z ' .. property.name,
            action = function()
                ExitProperty(property)
            end,
            property = property,
            shouldDraw = function()
                return true
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)

        local marker = {
            name = property.name .. '_prop_kitchen' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 3,
            coords = property.kitchen.coords,
            colour = { r = 0, b = 0, g = 0 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro otevření kuchyně',
            action = function()
                OpenKitchen(property)
            end,
            property = property,
            shouldDraw = function()
                return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)
		
        local marker = {
            name = property.name .. '_prop_makeup' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 3,
            coords = property.makeup.coords,
            colour = { r = 0, b = 0, g = 0 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro líčení',
            action = function()
                TriggerServerEvent('rtx_makeupproperty:checksada')
            end,
            property = property,
            shouldDraw = function()
                return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)
		
        local marker = {
            name = property.name .. '_prop_sprcha' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 3,
            coords = property.sprcha.coords,
            colour = { r = 0, b = 0, g = 0 },
            size = vector3(1.0, 1.0, 1.0),
            msg = 'Stisknite [E] pro osprchování',
            action = function()
                TriggerEvent('rtx_property:sprchastart', GetPlayerServerId(PlayerId()))
            end,
            property = property,
            shouldDraw = function()
                return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)

        local marker = {
            name = property.name .. '_prop_garage_open' .. propertyIndex,
            type = -1,
			show3D = true,
			radius = 100,
            coords = property.garage.coords,
            colour = { r = 0, b = 0, g = 0 },
            size = vector3(3.0, 3.0, 3.0),
            msg = 'Stisknite [E] pro otevření garáže',
            action = function()
                OpenGarage(property)
            end,
            property = property,
            shouldDraw = function()
                return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
            end
        }
        TriggerEvent('rtx_core:registerMarker', marker)

        for roomIndex, room in pairs(property.rooms) do

            if room.clothes ~= nil then
                local marker = {
                    name = property.name .. '_prop_room_clothes' .. roomIndex,
                    type = -1,
					radius = 3,
					show3D = true,
                    coords = room.clothes.coords,
                    colour = { r = 0, b = 0, g = 0 },
                    size = vector3(1.0, 1.0, 1.0),
                    msg = 'Stisknite [E] pro změnu oblečení',
                    action = function()
                        OpenClothes(room)
                    end,
                    room = room,
                    shouldDraw = function()
                        return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
                    end
                }
                TriggerEvent('rtx_core:registerMarker', marker)
            end

            local marker = {
                name = property.name .. '_prop_room_items' .. roomIndex,
                type = -1,
				radius = 3,
				show3D = true,
                coords = room.cupboard.coords,
                colour = { r = 0, b = 0, g = 0 },
                size = vector3(1.0, 1.0, 1.0),
                msg = 'Stisknite [E] pro otevření skřínky',
                action = function()
                    OpenCupboard(property.name .. '_prop_room_items' .. roomIndex)
                end,
                room = room,
                shouldDraw = function()
                    return IsPropertySold(property) and DoesPlayerHaveKeysOf(property)
                end
            }
            TriggerEvent('rtx_core:registerMarker', marker)
        end

    end
end)

Citizen.CreateThread(function()
    for _, property in pairs(Config.Properties) do
        Citizen.Wait(0)
        local blip = {
            id = property.name,
            name = property.name,
            coords = property.outside.coords,
            scale = 0.8,
            color = 0,
            sprite = 40
        }
        TriggerEvent('rtx_core:registerBlip', blip)
    end
    while true do
        for _, property in pairs(propertyData) do
			local propertyownering = IsPlayerOwnerOf(property)
            if property.sold and propertyownering == true then
                local blip = {
                    id = property.name,
					name = property.name,
					scale = 0.8,
					color = 26,						
                    sprite = 40
                }
                TriggerEvent('rtx_core:updateBlip', blip)
            elseif not property.sold then
                local blip = {
                    id = property.name,
					name = property.name,
                    sprite = 350
                }
                TriggerEvent('rtx_core:updateBlip', blip)
            end
        end
        Citizen.Wait(5000)
    end
end)

function GetPropertyDataForProperty(property)
    for k, v in pairs(propertyData) do
        if v.name == property.name then
            return v
        end
    end
end

function GetPropertyOwnersForProperty(property)
    local owners = {}
    for k, v in pairs(propertyOwners) do
        if v.name == property.name then
            table.insert(owners, v)
        end
    end
    return owners
end

function DoesPlayerHaveKeysOf(property)
    local owners = GetPropertyOwnersForProperty(property)
    if owners then
        for k, v in pairs(owners) do
            if ESX.PlayerData.identifier == v.identifier then
                return true
            end
        end
    end
    return false
end

function IsPlayerOwnerOf(property)
    local owners = GetPropertyOwnersForProperty(property)
    if owners then
        for k, v in pairs(owners) do
            if ESX.PlayerData.identifier == v.identifier and v.owner then
                return true
            end
        end
    end
    return false
end

function IsPropertySold(property)
    local pd = GetPropertyDataForProperty(property)
    if pd == nil then
        return
    end
    if pd then
        return pd.sold
    else
        return false
    end
end

function IsUnlocked(property)
    local pd = GetPropertyDataForProperty(property)
    return not pd.locked
end

function EnterProperty(property)
    TriggerEvent('rtx_core:hasExitedMarker')
    local x, y, z = table.unpack(property.inside.coords)
    TeleportPlayerTo(x, y, z, property.inside.heading)
end

function ExitProperty(property)
    TriggerEvent('rtx_core:hasExitedMarker')
    local x, y, z = table.unpack(property.outside.coords)
    TeleportPlayerTo(x, y, z, property.outside.heading)
end

function TeleportPlayerTo(x, y, z, heading)
    DoScreenFadeOut(200)
    Citizen.Wait(200)
    SetEntityCoords(PlayerPedId(), x, y, z)
    SetEntityHeading(PlayerPedId(), heading)
    Citizen.Wait(700)
    DoScreenFadeIn(200)
end






