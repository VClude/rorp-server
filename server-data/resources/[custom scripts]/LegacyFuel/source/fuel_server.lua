ESX = nil

if Config.UseESX then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	RegisterServerEvent("fuel:GiveItem") 
	AddEventHandler("fuel:GiveItem", function()
		  local _source = source
		  local xPlayer = ESX.GetPlayerFromId(_source)
		xPlayer.addInventoryItem('WEAPON_PETROLCAN', 1)
	end)
	

	-- ESX.RegisterServerCallback("fuel:checkItem",function(source,cb)
	-- 	local _source = source
	-- 	local xPlayer = ESX.GetPlayerFromId(_source)
	-- 	local xv = xPlayer.getInventoryItem('WEAPON_PETROLCAN')
	-- 	if xv then
	-- 		cb(true)
	-- 	else
	-- 		cb(false)
	-- 	end
	-- end)

	-- ESX.RegisterServerCallback("fuel:checkItem",function(source,cb)
	-- 	local _source = source
	-- 	local identifier = GetPlayerIdentifiers(source)
	-- 	local xv = MySQL.Sync.fetchScalar("SELECT inventory FROM users WHERE identifier = @username AND inventory like '%WEAPON_PETROLCAN%'", {['@username'] = identifier})
	-- 	if xv then
	-- 		cb(true)
	-- 	else
	-- 		cb(false)
	-- 	end
	-- end)
	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)

		if price > 0 then
			xPlayer.removeMoney(amount)
		end
	end)
end
