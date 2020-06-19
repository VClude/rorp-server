--------------------------------
------- Created by Hamza -------
-------------------------------- 

local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Server Callback to get inventory pickaxe:
ESX.RegisterServerCallback("esx_MinerJob:getPickaxe",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("pickaxe").count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get inventory washing pan:
ESX.RegisterServerCallback("esx_MinerJob:getWashPan",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("washpan").count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get washed stone:
ESX.RegisterServerCallback("esx_MinerJob:getWashedStone",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("washed_stone").count >= 10 then
		xPlayer.removeInventoryItem("washed_stone", 10)
		cb(true)
	else
		cb(false)
	end
end)

-- Server Callback to get stone count & remove stone:
ESX.RegisterServerCallback("esx_MinerJob:removeStone",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("stone").count >= 10 then
		xPlayer.removeInventoryItem("stone", 10)
		cb(true)
	else
		cb(false)
	end
end)

-- Function to reward player after mining/washing:
RegisterServerEvent("esx_MinerJob:reward")
AddEventHandler("esx_MinerJob:reward", function(itemName,itemAmount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	xPlayer.addInventoryItem(itemName, itemAmount)
	TriggerClientEvent("esx:showNotification",source,"Kamu mendapatkan ~r~"..itemAmount.."~s~x ~y~"..itemLabel.."~s~")
end)

-- Function to reward player after smelting:
RegisterServerEvent("esx_MinerJob:rewardSmelting")
AddEventHandler("esx_MinerJob:rewardSmelting", function()
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

