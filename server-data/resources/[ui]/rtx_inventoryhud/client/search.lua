local secondarySearchInventory = {
    type = 'player',
    owner = '',
    seize = true
}
local secondaryStealInventory = {
    type = 'player',
    owner = '',
    steal = true
}


RegisterNetEvent('rtx_inventoryhud:search')
AddEventHandler('rtx_inventoryhud:search', function()
    local player = ESX.GetPlayerData()
    if player.job.name == 'police' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local searchPlayerPed = GetPlayerPed(closestPlayer)
            if IsEntityPlayingAnim(searchPlayerPed, 'mp_arresting', 'idle', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 then
				 TriggerServerEvent("rtx_inventoryhud:SearchingSynchroSend", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
            end
        end
    end
end)

RegisterNetEvent('rtx_inventoryhud:steal')
AddEventHandler('rtx_inventoryhud:steal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local searchPlayerPed = GetPlayerPed(closestPlayer)
		if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) then
			TriggerServerEvent("rtx_inventoryhud:StealingSynchroSend", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
		end
    end
end)

RegisterNetEvent('rtx_inventoryhud:StealingSynchro')
AddEventHandler('rtx_inventoryhud:StealingSynchro', function(stealingidentifer)
    secondaryStealInventory.owner = stealingidentifer
    openInventory({
		type = 'player',
		owner = stealingidentifer
	})   
    Citizen.Wait(100)
	ESX.TriggerServerCallback('rtx_inventoryhud:getSecondaryInventory', function(data)
		SendNUIMessage(
				{ action = "setSecondInventoryItems",
				  itemList = data.inventory,
				  invOwner = data.invId,
				  invTier = data.invTier,
				  money = {
					  cash = data.cash,
					  black_money = data.black_money
				  }
				}
		)
		SendNUIMessage(
				{
					action = "show",
					type = 'secondary'
				}
        )
		TriggerServerEvent('rtx_inventoryhud:openInventory', secondaryStealInventory)
	end, secondaryStealInventory.type, secondaryStealInventory.owner)
end)

RegisterNetEvent('rtx_inventoryhud:SearchingSynchro')
AddEventHandler('rtx_inventoryhud:SearchingSynchro', function(searchingidentifer)
    secondarySearchInventory.owner = searchingidentifer
    openInventory({
		type = 'player',
		owner = searchingidentifer
	})   
    Citizen.Wait(100)
	ESX.TriggerServerCallback('rtx_inventoryhud:getSecondaryInventory', function(data)
		SendNUIMessage(
				{ action = "setSecondInventoryItems",
				  itemList = data.inventory,
				  invOwner = data.invId,
				  invTier = data.invTier,
				  money = {
					  cash = data.cash,
					  black_money = data.black_money
				  }
				}
		)
		SendNUIMessage(
				{
					action = "show",
					type = 'secondary'
				}
        )
		TriggerServerEvent('rtx_inventoryhud:openInventory', secondarySearchInventory)
	end, secondarySearchInventory.type, secondarySearchInventory.owner)
end)