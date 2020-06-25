ESX                = nil
local Vehicles = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'pedagang', _U('pedagang'), true, true)
TriggerEvent('esx_society:registerSociety', 'pedagang', 'Pedagang', 'society_pedagang', 'society_pedagang', 'society_pedagang', {type = 'public'})