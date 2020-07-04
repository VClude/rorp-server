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
	if xPlayer.canCarryItem(itemName, itemAmount) then
		xPlayer.addInventoryItem(itemName, itemAmount)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
	end
end)

-- Server Callback to get stone count & remove stone:
 ESX.RegisterServerCallback("rorp_miner:required",function(source,cb,itemReq, itemReqAmount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(itemReq).count >= itemReqAmount  then
		xPlayer.removeInventoryItem(itemReq, itemReqAmount)
		cb(true)
	else
		cb(false)
	end
end)

-- Function to reward player after smelting:
RegisterServerEvent("rorp_miner:rewardSmelting")
AddEventHandler("rorp_miner:rewardSmelting", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local rewardChance = math.random(1,15)
	
	if rewardChance == 1 then
		if xPlayer.canCarryItem("diamond", 1) then
			xPlayer.addInventoryItem("diamond", 1)
			TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~1~s~x ~y~Berlian~s~")
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
		end
	elseif rewardChance == 2 then
		local firstChance = math.random(1,3)
		if firstChance == 1 then
			if xPlayer.canCarryItem("gold", 1) then
				xPlayer.addInventoryItem("gold", 1)
				TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~1~s~x ~y~Emas~s~")
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
			end
		elseif firstChance == 2 or firstChance == 3 then
			if xPlayer.canCarryItem("cooper", 2) then
				xPlayer.addInventoryItem("cooper", 2)
				TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~2~s~ x~y~Tembaga~s~")
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
			end
		end
	elseif rewardChance == 3 and or rewardChance == 4 or rewardChance == 5 or rewardChance == 6 or rewardChance == 7 or rewardChance == 8 or rewardChance == 9 or rewardChance == 10 or rewardChance == 11 or rewardChance == 12 or rewardChance == 13 or rewardChance == 14 or rewardChance == 15  then
		local secondChance = math.random(1,10)
		if secondChance == 1 or secondChance == 2 or secondChance == 3 then
			if xPlayer.canCarryItem("copper", 3) then
				xPlayer.addInventoryItem("copper", 3)
				TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~3~s~x ~y~Tembaga~s~")
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
			end
		elseif secondChance == 4 or secondChance == 5 or secondChance == 6 or secondChance == 7 or secondChance == 8 or secondChance == 9 or secondChance == 10 then
			if xPlayer.canCarryItem("iron", 5) then
				xPlayer.addInventoryItem("iron", 5)
				TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~5~s~x ~y~Besi~s~")
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Inventory kamu sudah penuh'})
			end
		end
	end	
end)

-- fungsi global reward buat semua job
RegisterServerEvent("rorp_miner:Payout")
AddEventHandler("rorp_miner:Payout", function(itemName, itemPrice)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	local itemAmount = xPlayer.getInventoryItem(itemName).count
	local price = itemPrice * itemAmount
	local name = itemName
	if itemAmount > 0 then
		xPlayer.removeInventoryItem(itemName, itemAmount)
		xPlayer.addMoney(price)
		TriggerClientEvent("esx:showNotification",source,"Kamu menjual ~r~"..itemAmount.."~s~x "..itemLabel.." dengan total penjualan ~g~$"..price)
	else
		TriggerClientEvent("esx:showNotification",source,"anda tidak mempunyai "..itemName.." untuk dijual")
	end
end)