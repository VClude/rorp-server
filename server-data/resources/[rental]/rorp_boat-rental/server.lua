ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("rorp_boat-rental:lowmoney")
AddEventHandler("rorp_boat-rental:lowmoney", function(money)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	local ver = "1.0"
	print("RORP Boat Rental started v"..ver)
end)
