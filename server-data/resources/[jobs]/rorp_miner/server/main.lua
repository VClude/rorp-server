local playersWorking = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rorp_miner:caution')
AddEventHandler('rorp_miner:caution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == 'take' then
		if cautionAmount <= Config.MaxCaution and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				if xPlayer.getAccount('bank').money >= cautionAmount then
					xPlayer.removeAccountMoney('bank', cautionAmount)
					account.addMoney(cautionAmount)
                    -- xPlayer.showNotification(_U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
                    xPlayer.showNotification(cautionAmount)
					TriggerClientEvent('rorp_miner:spawnJobVehicle', xPlayer.source, spawnPoint, vehicle)
				else
                    -- xPlayer.showNotification(_U('caution_afford', ESX.Math.GroupDigits(cautionAmount)))
                    xPlayer.showNotification(cautionAmount)
				end
			end)
		elseif cautionAmount == 0 then
			TriggerClientEvent('rorp_miner:spawnJobVehicle', xPlayer.source, spawnPoint, vehicle)
		end
	elseif cautionType == 'give_back' then
		if cautionAmount <= 1 and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				local caution = account.money
				local toGive = ESX.Math.Round(caution * cautionAmount)
	
				xPlayer.addAccountMoney('bank', toGive)
				account.removeMoney(toGive)
                -- TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
                TriggerClientEvent('esx:showNotification', source, toGive)
			end)
		end
	end
end)


-- Function to reward player after mining/washing:
RegisterServerEvent("rorp_miner:reward")
AddEventHandler("rorp_miner:reward", function(itemName,itemAmount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.canCarryItem(itemName,itemAmount) then
		xPlayer.addInventoryItem(itemName, itemAmount)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
	else
		TriggerClientEvent("esx:showNotification",source,"Inventory sudah penuh")
	end
end)

ESX.RegisterServerCallback("rorp_miner:ReqItem",function(source,cb,reqItem,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(reqItem).count >= amount then
		if xPlayer.canCarryItem(reqItem, amount) then
			xPlayer.removeInventoryItem(reqItem, amount)
			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)