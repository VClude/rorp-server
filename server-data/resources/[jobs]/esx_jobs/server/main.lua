local playersWorking = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local timeNow = os.clock()

		for playerId,data in pairs(playersWorking) do
			Citizen.Wait(10)
			local xPlayer = ESX.GetPlayerFromId(playerId)

			-- is player still online?
			if xPlayer then
				local distance = #(xPlayer.getCoords(true) - data.zoneCoords)

				-- player still within zone limits?
				if distance <= data.zoneMaxDistance then
					-- calculate the elapsed time
					local timeElapsed = timeNow - data.time

					if timeElapsed > data.jobItem[1].time then
						data.time = os.clock()

						for k,v in ipairs(data.jobItem) do
							local itemQtty, requiredItemQtty = 0, 0

							if v.name ~= _U('delivery') then
								itemQtty = xPlayer.getInventoryItem(v.db_name).count
							end

							if data.jobItem[1].requires ~= 'nothing' then
								requiredItemQtty = xPlayer.getInventoryItem(data.jobItem[1].requires).count
							end
			
							if v.name ~= _U('delivery') and itemQtty >= v.max then
								xPlayer.showNotification(_U('max_limit', v.name))
								playersWorking[playerId] = nil
							elseif v.requires ~= 'nothing' and requiredItemQtty <= 0 then
								xPlayer.showNotification(_U('not_enough', data.jobItem[1].requires_name))
								playersWorking[playerId] = nil
							else
								if v.name ~= _U('delivery') then
									-- chances to drop the item
									if v.drop == 100 then
										xPlayer.addInventoryItem(v.db_name, v.add)
									else
										local chanceToDrop = math.random(100)
										if chanceToDrop <= v.drop then
											xPlayer.addInventoryItem(v.db_name, v.add)
										end
									end
								else
									xPlayer.addMoney(v.price)
								end
							end
						end
			
						if data.jobItem[1].requires ~= 'nothing' then
							local itemToRemoveQtty = xPlayer.getInventoryItem(data.jobItem[1].requires).count
							if itemToRemoveQtty > 0 then
								xPlayer.removeInventoryItem(data.jobItem[1].requires, data.jobItem[1].remove)
							end
						end
					end
				else
					playersWorking[playerId] = nil
				end
			else
				playersWorking[playerId] = nil
			end
		end
	end
end)

RegisterServerEvent('esx_jobs:startWork')
AddEventHandler('esx_jobs:startWork', function(zoneIndex)
	if not playersWorking[source] then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer then
			local jobObject = Config.Jobs[xPlayer.job.name]

			if jobObject then
				local jobZone = jobObject.Zones[zoneIndex]

				if jobZone and jobZone.Item then
					playersWorking[source] = {
						jobItem = jobZone.Item,
						zoneCoords = vector3(jobZone.Pos.x, jobZone.Pos.y, jobZone.Pos.z),
						zoneMaxDistance = jobZone.Size.x,
						time = os.clock()
					}
				end
			end
		end
	end
end)

RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	if playersWorking[source] then
		playersWorking[source] = nil
	end
end)

RegisterNetEvent('esx_jobs:caution')
AddEventHandler('esx_jobs:caution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == 'take' then
		if cautionAmount <= Config.MaxCaution and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				if xPlayer.getAccount('bank').money >= cautionAmount then
					xPlayer.removeAccountMoney('bank', cautionAmount)
					account.addMoney(cautionAmount)
					xPlayer.showNotification(_U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
					TriggerClientEvent('esx_jobs:spawnJobVehicle', xPlayer.source, spawnPoint, vehicle)
				else
					xPlayer.showNotification(_U('caution_afford', ESX.Math.GroupDigits(cautionAmount)))
				end
			end)
		end
	elseif cautionType == 'give_back' then
		if cautionAmount <= 1 and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				local caution = account.money
				local toGive = ESX.Math.Round(caution * cautionAmount)
	
				xPlayer.addAccountMoney('bank', toGive)
				account.removeMoney(toGive)
				TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
			end)
		end
	end
end)

-- Server Callback to get inventory pickaxe:
ESX.RegisterServerCallback("esx_jobs:getPickaxe",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("pickaxe").count >= 1 and xPlayer.getJob().name == 'miner' then
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get inventory washing pan:
ESX.RegisterServerCallback("esx_jobs:getWashPan",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("washpan").count >= 1  and xPlayer.getJob().name == 'miner' then
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get washed stone:
ESX.RegisterServerCallback("esx_jobs:getWashedStone",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("washed_stone").count >= 10  and xPlayer.getJob().name == 'miner' then
		xPlayer.removeInventoryItem("washed_stone", 10)
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get stone count & remove stone:
ESX.RegisterServerCallback("esx_jobs:removeStone",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("stone").count >= 10  and xPlayer.getJob().name == 'miner' then
		xPlayer.removeInventoryItem("stone", 10)
		cb(true)
	else
		cb(false)
	end
end)

-- ESX.RegisterServerCallback("esx_jobs:preCheck",function(source,cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.canCarryItem('petrol', 24) then
-- 		cb(true)
-- 	else
-- 		cb(false)
-- 	end
-- end)

-- ESX.RegisterServerCallback("esx_jobs:Postcheck",function(source,cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.canCarryItem('ban', 1) then
-- 		cb(true)
-- 	else
-- 		cb(false)
-- 	end
-- end)

-- fungsi global reward buat semua job
RegisterServerEvent("esx_jobs:alljobReward")
AddEventHandler("esx_jobs:alljobReward", function(itemName,itemAmount,itemRequired, itemRequiredAmount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if itemRequired == 'nothing' then
		if xPlayer.canCarryItem(itemName, itemAmount) then
			xPlayer.addInventoryItem(itemName, itemAmount)
			TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
		else
			TriggerClientEvent("esx:showNotification",source,"anda tidak bisa membawa lebih banyak "..itemName.."")
		end
	else 
		if xPlayer.getInventoryItem(itemRequired).count >= itemRequiredAmount then
			if xPlayer.canCarryItem(itemName, itemAmount) then
				xPlayer.removeInventoryItem(itemRequired, itemRequiredAmount)
				xPlayer.addInventoryItem(itemName, itemAmount)
				TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
			else
				TriggerClientEvent("esx:showNotification",source,"anda tidak bisa membawa lebih banyak barang")
			end
		else
			TriggerClientEvent("esx:showNotification",source,"Anda tidak memiliki barang")
		end	
	end
end)

-- jual emas
RegisterServerEvent("esx_jobs:payGold")
AddEventHandler("esx_jobs:payGold", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local goldQty = ESX.getInventoryItem(gold).count
	local amount = goldQty * 3000
	xPlayer.addMoney(amount)
	TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..amount.."~s~x ~y~"..itemLabel.."~s~")
end)

-- Function to reward player after mining/washing:
RegisterServerEvent("esx_jobs:reward")
AddEventHandler("esx_jobs:reward", function(itemName,itemAmount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	xPlayer.addInventoryItem(itemName, itemAmount)
	TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
end)

-- Function to reward player after smelting:
RegisterServerEvent("esx_jobs:rewardSmelting")
AddEventHandler("esx_jobs:rewardSmelting", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local rewardChance = math.random(1,10)
	
	if rewardChance == 1 then
		xPlayer.addInventoryItem("diamond", 1)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~1x~s~ ~y~Berlian~s~")
	elseif rewardChance == 2 then
		xPlayer.addInventoryItem("ruby", 1)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~1x~s~ ~y~Ruby~s~")
	elseif rewardChance == 3 or rewardChance == 4 or rewardChance == 5 then
		local firstChance = math.random(1,2)
		if firstChance == 1 then
			xPlayer.addInventoryItem("gold", 1)
			TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~1x~s~ ~y~Emas~s~")
		else
			xPlayer.addInventoryItem("silver", 2)
			TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~2x~s~ ~y~Perak~s~")
		end
	elseif rewardChance == 6 or rewardChance == 7 or rewardChance == 8 or rewardChance == 9 or rewardChance == 10 then
		local secondChance = math.random(1,2)
		if secondChance == 1 then
			xPlayer.addInventoryItem("copper", 3)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~3x~s~ ~y~Tembaga~s~")
		else
			xPlayer.addInventoryItem("iron", 7)
		TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~7x~s~ ~y~Besi~s~")
		end
	end
	
end)


