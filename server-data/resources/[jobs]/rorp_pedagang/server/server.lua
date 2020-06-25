ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'pedagang', _U('Pedagang'), true, true)
TriggerEvent('esx_society:registerSociety', 'pedagang', 'Pedagang', 'society_pedagang', 'society_pedagang', 'society_pedagang', {type = 'public'})

RegisterServerEvent('rorp_pedagang:setJob')
AddEventHandler('rorp_pedagang:setJob', function(identifier,job,grade)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		
		if xTarget then
			xTarget.setJob(job, grade)
		end

end)

ESX.RegisterServerCallback('rorp_pedagang:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent('rorp_pedagang:putStockItems')
AddEventHandler('rorp_pedagang:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pedagang', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			xPlayer.showNotification(_U('invalid_quantity'))
		end

		xPlayer.showNotification(_U('have_deposited', count, item.label))
	end)
end)