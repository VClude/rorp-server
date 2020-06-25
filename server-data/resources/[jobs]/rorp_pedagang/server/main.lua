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

RegisterServerEvent('rorp_pedagang:cooking')
AddEventHandler('rorp_pedagang:cooking', function(ingredients)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = findRecipe(ingredients)
	if not item then
		TriggerClientEvent('esx:showNotification', _source, _U('RecipeNotFound'))
	else
		if xPlayer ~= nil then
			if hasAllIngredients(xPlayer.inventory, Config.Recipes[item]) then
				if xPlayer.canCarryItem(item, 5) then
	
					for _,ingredient in pairs(Config.Recipes[item]) do
						if (ingredient.remove ~= nil and ingredient.remove) or (ingredient.remove == nil) then
							xPlayer.removeInventoryItem(ingredient.item, ingredient.quantity)
						end
					end

					TriggerClientEvent('rorp_pedagang:CookingEvent',source, item)
				else
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('RecipeNotEnough'))
			end
		end
	end
end)

RegisterServerEvent('rorp_pedagang:reward')
AddEventHandler('rorp_pedagang:reward',function(_items)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local items = _items

	xPlayer.addInventoryItem(items, 5)
end)


function findRecipe(list)
	for item, ingredients in pairs(Config.Recipes) do
		if #ingredients == #list then
			-- same length, let's compare
			local found = 0
			for i=1, #ingredients, 1 do
				for j=1, #list, 1 do
					if ingredients[i].item == list[j].item and ingredients[i].quantity == list[j].quantity then
						found = found + 1
					end
				end
			end
			if found == #list then
				return item
			end
		end
	end
	return false
end

function hasAllIngredients(inventory, ingredients)
	for i=1, #ingredients, 1 do
		for j=1, #inventory, 1 do
			if ingredients[i].name == inventory[j].name then
				if inventory[j].count < ingredients[i].quantity then
					return false
				end
			end
		end
	end
	return true
end


function itemLabel(name, inventory)
    for i=1, #inventory, 1 do
        if inventory[i].name == name then
            return inventory[i].label
        end
    end
	return "unknown item"
end

RegisterServerEvent('rorp_pedagang:getPlayerInventory')
AddEventHandler('rorp_pedagang:getPlayerInventory', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		TriggerClientEvent('rorp_pedagang:openMenu', _source, xPlayer.inventory)
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

RegisterServerEvent('rorp_pedagang:getStockItems')
AddEventHandler('rorp_pedagang:getStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pedagang', function(inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, item.label))
			else
				xPlayer.showNotification(_U('player_cannot_hold'))
			end
		else
			xPlayer.showNotification(_U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('rorp_pedagang:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_pedagang', function(inventory)
		cb(inventory.items)
	end)
end)