local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy 		  = false, false
local holdingPackage          = false
local disabledWeapons         = false
local APPbone	= 0
local APPx 		= 0.0
local APPy 		= 0.0
local APPz 		= 0.0
local APPxR 	= 0.0
local APPyR 	= 0.0
local APPzR 	= 0.0

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function NotifInformasi(text)

	exports['mythic_notify']:SendAlert('inform', text, 5000)

end

function NotifSukses(text)

	exports['mythic_notify']:SendAlert('success', text, 5000)

end

function NotifError(text)

	exports['mythic_notify']:SendAlert('error', text, 5000)

end

-- function SelectRandomTowable()
-- 	local index = GetRandomIntInRange(1,  #Config.Towables)

-- 	for k,v in pairs(Config.Zones) do
-- 		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
-- 			return k
-- 		end
-- 	end
-- end

-- function StartNPCJob()
-- 	NPCOnJob = true

-- 	NPCTargetTowableZone = SelectRandomTowable()
-- 	local zone       = Config.Zones[NPCTargetTowableZone]

-- 	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
-- 	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

-- 	ESX.ShowNotification(_U('drive_to_indicated'))
-- end

-- function StopNPCJob(cancel)
-- 	if Blips['NPCTargetTowableZone'] then
-- 		RemoveBlip(Blips['NPCTargetTowableZone'])
-- 		Blips['NPCTargetTowableZone'] = nil
-- 	end

-- 	if Blips['NPCDelivery'] then
-- 		RemoveBlip(Blips['NPCDelivery'])
-- 		Blips['NPCDelivery'] = nil
-- 	end

-- 	Config.Zones.VehicleDelivery.Type = -1

-- 	NPCOnJob                = false
-- 	NPCTargetTowable        = nil
-- 	NPCTargetTowableZone    = nil
-- 	NPCHasSpawnedTowable    = false
-- 	NPCHasBeenNextToTowable = false

-- 	if cancel then
-- 		ESX.ShowNotification(_U('mission_canceled'))
-- 	else
-- 		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
-- 	end
-- end

function OpenCloakRoomsMenu()
	local elements = {
		{label = "Baju kerja", value = "working"},
		{label = "Baju Sipil", value = "citizen"}
	}

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"bennys_cloakrooms",
		{
			title = "Locker rooms",
			align = "top-left",
			elements = elements

		},

		function(data, menu)
			if data.current.value == "citizen" then
				menu.close()
				ESX.TriggerServerCallback(
					"esx_skin:getPlayerSkin",
					function(skin, jobSkin)
						TriggerEvent("skinchanger:loadSkin", skin)
					end
				)
			else
				menu.close()
				setUniform(data.current.value, PlayerPedId())
			end
		end)
end

function OpenMechanicActionsMenu()
	local elements = {
		-- {label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = ('Cloakroom'), value = 'cloakroom_menu'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom_menu' then
			OpenCloakRoomsMenu()
		-- elseif data.current.value == 'put_stock' then
		-- 	OpenPutStocksMenu()
		-- elseif data.current.value == 'get_stock' then
		-- 	OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

function OpenMechanicHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' and ESX.PlayerData.job.grade_name ~= 'novice' then
		local elements = {
			-- {label = _U('gas_can'), value = 'gaz_bottle'},
			{label = _U('repair_tools'), value = 'fix_tool'}
			-- {label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_harvest', {
			title    = _U('harvest'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('esx_mechanicjob:startHarvest')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest2')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest3')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'mechanic_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' and ESX.PlayerData.job.grade_name ~= 'novice' then
		local elements = {
			-- {label = _U('blowtorch'),  value = 'blow_pipe'},
			{label = _U('repair_kit'), value = 'fix_kit'}
			-- {label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('esx_mechanicjob:startCraft')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft2')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'bottom-right',
		elements = {
			{label = _U('billing'),       value = 'billing'},
			-- {label = _U('hijack'),        value = 'hijack_vehicle'},
			{label = _U('repair'),        value = 'fix_vehicle'},
			{label = _U('tyre'),          value = 'tyre_change'},
			{label = _U('clean'),         value = 'clean_vehicle'},
			-- {label = _U('ecu'),           value = 'ecu_tuning'},
			-- {label = _U('imp_veh'),       value = 'del_vehicle'},
			-- {label = _U('flat_bed'),      value = 'dep_vehicle'},
			{label = _U('place_objects'), value = 'object_spawner'}
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', _U('mechanic'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		-- elseif data.current.value == 'hijack_vehicle' then
		-- 	local playerPed = PlayerPedId()
		-- 	local vehicle   = ESX.Game.GetVehicleInDirection()
		-- 	local coords    = GetEntityCoords(playerPed)

		-- 	if IsPedSittingInAnyVehicle(playerPed) then
		-- 		ESX.ShowNotification(_U('inside_vehicle'))
		-- 		return
		-- 	end

		-- 	if DoesEntityExist(vehicle) then
		-- 		isBusy = true
		-- 		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
		-- 		Citizen.CreateThread(function()
		-- 			TriggerEvent("mythic_progbar:client:progress",
		-- 				{
		-- 					name = "repair_vehicle",
		-- 					duration = 10000,
		-- 					label = "Hijack Kendaraan..",
		-- 					useWhileDead = false,
		-- 					canCancel = true,
		-- 					controlDisables = {
		-- 						disableMovement = true,
		-- 						disableCarMovement = true,
		-- 						disableMouse = false,
		-- 						disableCombat = true
		-- 					}
		-- 				},
		-- 				function(status)
		-- 					if not status then

		-- 						SetVehicleDoorsLocked(vehicle, 1)
		-- 						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
		-- 						ClearPedTasksImmediately(playerPed)
			
		-- 						NotifSukses(_U('vehicle_unlocked'))
		-- 						isBusy = false

		-- 					end
		-- 				end)
		-- 		end)
		-- 	else
		-- 		ESX.ShowNotification(_U('no_vehicle_nearby'))
		-- 	end
		elseif data.current.value == 'fix_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					TriggerEvent("mythic_progbar:client:progress",
						{
							name = "repair_vehicle",
							duration = 15000,
							label = "Memperbaiki Kendaraan..",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},
						function(status)
							if not status then
								SetVehicleFixed(vehicle)
								SetVehicleDeformationFixed(vehicle)
								SetVehicleBodyHealth(vehicle, 1000.00)
								SetVehicleEngineHealth(vehicle, 1000.00)
								SetVehicleUndriveable(vehicle, false)
								SetVehicleEngineOn(vehicle, true, true)
								ClearPedTasksImmediately(playerPed)

								NotifSukses(_U('vehicle_repaired'))
								isBusy = false
							end
						end)
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end

		elseif data.current.value == 'tyre_change' then

			menu.close()
			changeTyre()

		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					TriggerEvent("mythic_progbar:client:progress",
						{
							name = "clean_vehicle",
							duration = 15000,
							label = "Membersihkan Kendaraan..",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},
						function(status)
							if not status then
								SetVehicleDirtLevel(vehicle, 0)
								ClearPedTasksImmediately(playerPed)
			
								NotifSukses(_U('vehicle_cleaned'))
								isBusy = false
							end
						end)
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		-- elseif data.current.value == 'ecu_tuning' then

		-- 	local ped = GetPlayerPed(-1)
		-- 		if IsPedInAnyVehicle(ped, false) then
		-- 			menu.close()
		-- 			TriggerEvent("tuning:useLaptop", GetPlayerServerId(PlayerId()))
		-- 		else
		-- 			ESX.ShowNotification("Anda harus di dalam kendaraan.")
		-- 		end

		-- elseif data.current.value == 'del_vehicle' then
		-- 	local playerPed = PlayerPedId()

		-- 	if IsPedSittingInAnyVehicle(playerPed) then
		-- 		local vehicle = GetVehiclePedIsIn(playerPed, false)

		-- 		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
		-- 			ESX.ShowNotification(_U('vehicle_impounded'))
		-- 			ESX.Game.DeleteVehicle(vehicle)
		-- 		else
		-- 			ESX.ShowNotification(_U('must_seat_driver'))
		-- 		end
		-- 	else
		-- 		local vehicle = ESX.Game.GetVehicleInDirection()

		-- 		if DoesEntityExist(vehicle) then
		-- 			ESX.ShowNotification(_U('vehicle_impounded'))
		-- 			ESX.Game.DeleteVehicle(vehicle)
		-- 		else
		-- 			ESX.ShowNotification(_U('must_near'))
		-- 		end
		-- 	end
		-- elseif data.current.value == 'dep_vehicle' then
		-- 	local playerPed = PlayerPedId()
		-- 	local vehicle = GetVehiclePedIsIn(playerPed, true)

		-- 	local towmodel = GetHashKey('flatbed')
		-- 	local isVehicleTow = IsVehicleModel(vehicle, towmodel)

		-- 	if isVehicleTow then
		-- 		local targetVehicle = ESX.Game.GetVehicleInDirection()

		-- 		if CurrentlyTowedVehicle == nil then
		-- 			if targetVehicle ~= 0 then
		-- 				if not IsPedInAnyVehicle(playerPed, true) then
		-- 					if vehicle ~= targetVehicle then
		-- 						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
		-- 						CurrentlyTowedVehicle = targetVehicle
		-- 						ESX.ShowNotification(_U('vehicle_success_attached'))

		-- 						if NPCOnJob then
		-- 							if NPCTargetTowable == targetVehicle then
		-- 								ESX.ShowNotification(_U('please_drop_off'))
		-- 								Config.Zones.VehicleDelivery.Type = 1

		-- 								if Blips['NPCTargetTowableZone'] then
		-- 									RemoveBlip(Blips['NPCTargetTowableZone'])
		-- 									Blips['NPCTargetTowableZone'] = nil
		-- 								end

		-- 								Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
		-- 								SetBlipRoute(Blips['NPCDelivery'], true)
		-- 							end
		-- 						end
		-- 					else
		-- 						ESX.ShowNotification(_U('cant_attach_own_tt'))
		-- 					end
		-- 				end
		-- 			else
		-- 				ESX.ShowNotification(_U('no_veh_att'))
		-- 			end
		-- 		else
		-- 			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
		-- 			DetachEntity(CurrentlyTowedVehicle, true, true)

		-- 			if NPCOnJob then
		-- 				if NPCTargetDeleterZone then

		-- 					if CurrentlyTowedVehicle == NPCTargetTowable then
		-- 						ESX.Game.DeleteVehicle(NPCTargetTowable)
		-- 						TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
		-- 						StopNPCJob()
		-- 						NPCTargetDeleterZone = false
		-- 					else
		-- 						ESX.ShowNotification(_U('not_right_veh'))
		-- 					end

		-- 				else
		-- 					ESX.ShowNotification(_U('not_right_place'))
		-- 				end
		-- 			end

		-- 			CurrentlyTowedVehicle = nil
		-- 			ESX.ShowNotification(_U('veh_det_succ'))
		-- 		end
		-- 	else
		-- 		ESX.ShowNotification(_U('imp_flatbed'))
		-- 	end
		elseif data.current.value == 'object_spawner' then
			-- menu.close()
			-- openMechanicPropsMenu()
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions_spawn', {
				title    = _U('objects'),
				align    = 'bottom-right',
				elements = {
					{label = _U('roadcone'), value = 'prop_roadcone02a'},
					{label = _U('toolbox'),  value = 'prop_toolchest_01'}
			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- function OpenGetStocksMenu()
-- 	ESX.TriggerServerCallback('esx_mechanicjob:getStockItems', function(items)
-- 		local elements = {}

-- 		for i=1, #items, 1 do
-- 			table.insert(elements, {
-- 				label = 'x' .. items[i].count .. ' ' .. items[i].label,
-- 				value = items[i].name
-- 			})
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
-- 			title    = _U('mechanic_stock'),
-- 			align    = 'top-left',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			local itemName = data.current.value

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
-- 				title = _U('quantity')
-- 			}, function(data2, menu2)
-- 				local count = tonumber(data2.value)

-- 				if count == nil then
-- 					ESX.ShowNotification(_U('invalid_quantity'))
-- 				else
-- 					menu2.close()
-- 					menu.close()
-- 					TriggerServerEvent('esx_mechanicjob:getStockItem', itemName, count)

-- 					Citizen.Wait(1000)
-- 					OpenGetStocksMenu()
-- 				end
-- 			end, function(data2, menu2)
-- 				menu2.close()
-- 			end)
-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- 	end)
-- end

-- function OpenPutStocksMenu()
-- 	ESX.TriggerServerCallback('esx_mechanicjob:getPlayerInventory', function(inventory)
-- 		local elements = {}

-- 		for i=1, #inventory.items, 1 do
-- 			local item = inventory.items[i]

-- 			if item.count > 0 then
-- 				table.insert(elements, {
-- 					label = item.label .. ' x' .. item.count,
-- 					type  = 'item_standard',
-- 					value = item.name
-- 				})
-- 			end
-- 		end

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
-- 			title    = _U('inventory'),
-- 			align    = 'top-left',
-- 			elements = elements
-- 		}, function(data, menu)
-- 			local itemName = data.current.value

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
-- 				title = _U('quantity')
-- 			}, function(data2, menu2)
-- 				local count = tonumber(data2.value)

-- 				if count == nil then
-- 					ESX.ShowNotification(_U('invalid_quantity'))
-- 				else
-- 					menu2.close()
-- 					menu.close()
-- 					TriggerServerEvent('esx_mechanicjob:putStockItems', itemName, count)

-- 					Citizen.Wait(1000)
-- 					OpenPutStocksMenu()
-- 				end
-- 			end, function(data2, menu2)
-- 				menu2.close()
-- 			end)
-- 		end, function(data, menu)
-- 			menu.close()
-- 		end)
-- 	end)
-- end

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'CarLift' then
		CurrentAction     = 'lift_actions'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'CarLift2' then
		CurrentAction     = 'lift2_actions'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'Harvest' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	-- elseif zone == 'VehicleDeleter' then
	-- 	local playerPed = PlayerPedId()

	-- 	if IsPedInAnyVehicle(playerPed, false) then
	-- 		local vehicle = GetVehiclePedIsIn(playerPed,  false)

	-- 		CurrentAction     = 'delete_vehicle'
	-- 		CurrentActionMsg  = _U('veh_stored')
	-- 		CurrentActionData = {vehicle = vehicle}
	-- 	end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Harvest' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- -- Pop NPC mission vehicle when inside area
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local zone   = Config.Zones[NPCTargetTowableZone]

-- 			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
-- 				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

-- 				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
-- 					NPCTargetTowable = vehicle
-- 				end)

-- 				NPCHasSpawnedTowable = true
-- 			end
-- 		end

-- 		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			local zone   = Config.Zones[NPCTargetTowableZone]

-- 			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
-- 				ESX.ShowNotification(_U('please_tow'))
-- 				NPCHasBeenNextToTowable = true
-- 			end
-- 		end
-- 	end
-- end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.8)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, true, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
			end

		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then

				if CurrentAction == 'mechanic_actions_menu' then
					OpenMechanicActionsMenu()
				elseif CurrentAction == 'mechanic_harvest_menu' then
					OpenMechanicHarvestMenu()
				elseif CurrentAction == 'mechanic_craft_menu' then
					OpenMechanicCraftMenu()
				-- elseif CurrentAction == 'delete_vehicle' then

				-- 	if Config.EnableSocietyOwnedVehicles then

				-- 		local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
				-- 		TriggerServerEvent('esx_society:putVehicleInGarage', 'mechanic', vehicleProps)

				-- 	else

				-- 		if
				-- 			GetEntityModel(vehicle) == GetHashKey('flatbed')   or
				-- 			GetEntityModel(vehicle) == GetHashKey('towtruck2') or
				-- 			GetEntityModel(vehicle) == GetHashKey('slamvan3')
				-- 		then
				-- 			TriggerServerEvent('esx_service:disableService', 'mechanic')
				-- 		end

				-- 	end

				-- 	ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			OpenMobileMechanicActionsMenu()
		end

		-- if IsControlJustReleased(0, 178) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
		-- 	if NPCOnJob then
		-- 		if GetGameTimer() - NPCLastCancel > 5 * 60000 then
		-- 			StopNPCJob(true)
		-- 			NPCLastCancel = GetGameTimer()
		-- 		else
		-- 			ESX.ShowNotification(_U('wait_five'))
		-- 		end
		-- 	else
		-- 		local playerPed = PlayerPedId()

		-- 		if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey('flatbed')) then
		-- 			StartNPCJob()
		-- 		else
		-- 			ESX.ShowNotification(_U('must_in_flatbed'))
		-- 		end
		-- 	end
		-- end

	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

-- ======================================================================

-- Prop list, you can add as much as you want
attachPropList = {

	-- ["prop_roadcone02a"] = { 
    --     ["model"] = "prop_roadcone02a", ["bone"] = 28422, ["x"] = 0.6,["y"] = -0.15,["z"] = -0.1,["xR"] = 315.0,["yR"] = 288.0, ["zR"] = 0.0 
    -- },
    -- ["prop_cs_trolley_01"] = { 
    --     ["model"] = "prop_cs_trolley_01", ["bone"] = 28422, ["x"] = 0.0,["y"] = -0.6,["z"] = -0.8,["xR"] = -180.0,["yR"] = -165.0, ["zR"] = 90.0 
    -- },
	-- ["prop_cs_cardbox_01"] = { 
    --     ["model"] = "prop_cs_cardbox_01", ["bone"] = 28422, ["x"] = 0.01,["y"] = 0.01,["z"] = 0.0,["xR"] = -255.0,["yR"] = -120.0, ["zR"] = 40.0 
    -- },
	["prop_tool_box_04"] = { 
        ["model"] = "prop_tool_box_04", ["bone"] = 28422, ["x"] = 0.4,["y"] = -0.1,["z"] = -0.1,["xR"] = 315.0,["yR"] = 288.0, ["zR"] = 0.0
    }
	-- ["prop_engine_hoist"] = { 
    --     ["model"] = "prop_engine_hoist", ["bone"] = 28422, ["x"] = 0.0,["y"] = -0.5,["z"] = -1.3,["xR"] = -195.0,["yR"] = -180.0, ["zR"] = 180.0 
    -- }
}
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function DrawText3Ds(x, y, z, text)

	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextFont(6)
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 240
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 255, 102, 255, 150)

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local vehicle = Nearbywheelvehicle()
		if vehicle ~= 0 then
			local closestTire = Nearbywheel(vehicle)
			if closestTire ~= nil then
				if IsVehicleTyreBurst(vehicle, closestTire.tireIndex, 0) == false then
					Citizen.Wait(1500)
				end
			end
		end
	end
end)

function createObject(model, x, y, z)
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Citizen.Wait(0)
	end
	return CreateObject(model, x, y, z, true, true, false)
end

function Nearbywheelvehicle()
	local plyPed = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 0.3
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function Nearbywheel(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.5
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end


function setUniform(job, playerPed)

	TriggerEvent(

		"skinchanger:getSkin",

		function(skin)

			if skin.sex == 0 then

				if Config.Uniforms[job].male then

					TriggerEvent("skinchanger:loadClothes", skin, Config.Uniforms[job].male)

				else

					NotifSuccessful("Clothes are not available for your gender!")

				end

			else

				if Config.Uniforms[job].female then

					TriggerEvent("skinchanger:loadClothes", skin, Config.Uniforms[job].female)

				else

					NotifSuccessful("Clothing is not available for your gender!")

				end

			end

		end

	)

end

function changeTyre()
	FreezeEntityPosition(GetPlayerPed(-1), false)
	bancadangan = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_rub_tyre_01'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.11, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while bancadangan do
		Citizen.Wait(250)
		local vehicle   = Nearbywheelvehicle()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		local playerPed = PlayerPedId()
		LoadDict('anim@heists@box_carry@')
	
		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and bancadangan == true then
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		if DoesEntityExist(vehicle) then
			bancadangan = false
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
			isBusy = true
			TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
			TriggerEvent("mythic_progbar:client:progress",
				{

					name = "wheelchange_vehicle",
					duration = 15000,
					label = "Mengganti ban..",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true
					}
				},

				function(status)
					ClearPedTasksImmediately(playerPed)
					isBusy = false
					if not status then
						local closestTire = Nearbywheel(vehicle)
						if closestTire ~= nil then
							SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
							ClearPedTasksImmediately(playerPed)
							NotifSukses("Ban telah diganti!")
						end

					end

				end)
		end
	end
end

RegisterNetEvent('esx_mechanicjob:attachProp')
AddEventHandler('esx_mechanicjob:attachProp', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    closestEntity = 0
    holdingPackage = true
    local attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
    local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(closestEntity, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, true, 2, 1)

    APPbone = bone
    APPx = x
    APPy = y
    APPz = z
    APPxR = xR
    APPyR = yR
    APPzR = zR
end)

attachedProp = 0
function removeAttachedProp()
    if DoesEntityExist(attachedProp) then
        DeleteEntity(attachedProp)
        attachedProp = 0
    end
end

RegisterNetEvent('esx_mechanicjob:drill')
AddEventHandler('esx_mechanicjob:drill', function()

	FreezeEntityPosition(GetPlayerPed(-1), false)
	bancadangan = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_rub_tyre_01'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.11, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while bancadangan do
		Citizen.Wait(250)
		local vehicle   = Nearbywheelvehicle()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		local playerPed = PlayerPedId()
		LoadDict('anim@heists@box_carry@')
	
		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and bancadangan == true then
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		if DoesEntityExist(vehicle) then
			bancadangan = false
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
			isBusy = true
			TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
			TriggerEvent("mythic_progbar:client:progress",
				{

					name = "wheelchange_vehicle",
					duration = 15000,
					label = "Mengganti ban..",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true
					}
				},

				function(status)
					ClearPedTasksImmediately(playerPed)
					isBusy = false
					if not status then
						local closestTire = Nearbywheel(vehicle)
						if closestTire ~= nil then
							SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
							ClearPedTasksImmediately(playerPed)
							NotifSukses("Ban telah diganti!")
						end

					end

				end)
		end
	end

end)

RegisterNetEvent('esx_mechanicjob:attachItem')
AddEventHandler('esx_mechanicjob:attachItem', function(item)
    TriggerEvent("esx_mechanicjob:attachProp",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)

--prop_tool_box_04
RegisterNetEvent('attach:prop_tool_box_04')
AddEventHandler('attach:prop_tool_box_04', function()
    TriggerEvent("esx_mechanicjob:attachItem","prop_tool_box_04")
end)

RegisterNetEvent('esx_mechanicjob:removeall')
AddEventHandler('esx_mechanicjob:removeall', function()
    TriggerEvent("disabledWeapons",false)
	ClearPedTasks(GetPlayerPed(-1))
	ClearPedSecondaryTask(GetPlayerPed(-1))
	Citizen.Wait(500)
	DetachEntity(closestEntity)
end)

RegisterNetEvent("disabledWeapons")
AddEventHandler("disabledWeapons", function(sentinfo)
    SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("weapon_unarmed"), 1)
    disabledWeapons = sentinfo
	removeAttachedProp()
	holdingPackage = false
end)

function openMechanicPropsMenu()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'bennysprops_actions',
	  {
		title    = 'Props',
		align    = 'bottom-right',
		  elements = {
			  -- {label = '1', value = 'prop1'},
			  -- {label = '2', value = 'prop2'},
			  {label = 'Roadcone', value = 'prop_roadcone02a'},
			  {label = 'Toolbox', value = 'prop3'},
			  {label = 'Batal', value = 'cancelprops'},
		  }
	  },
  
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'prop_roadcone02a' then
			  TriggerEvent("attach:prop_cs_trolley_01")
		  elseif val == 'prop3' then
			  TriggerEvent("attach:prop_tool_box_04")
		  elseif val == 'cancelprops' then
			  TriggerEvent("esx_mechanicjob:removeall")
			  DeleteEntity(closestEntity)
		  end
	  end,
	  function(data, menu)
		  menu.close()
		  OpenMobileMechanicActionsMenu()
	  end
  )
  end

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------

--------------------------- CAR LIFT -------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------

-- Coords for the first elevator prop (doesnt need heading)
local elevatorBaseX = -223.5853
local elevatorBaseY = -1327.158
local elevatorBaseZ = 29.8
----

-- Coords for the second elevator prop
local elevator2BaseX = -213.460
local elevator2BaseY = -1313.18
local elevator2BaseZ = 29.8
local elevator2BaseHeading = 270.0
-----


local elevatorProp = nil
local elevatorOn = false
local elevatorUp = false
local elevatorDown = false
local elevator2Prop = nil
local elevator2On = false
local elevator2Up = false
local elevator2Down = false
local la_nacelle_estelle_la = false -- la nacelle n'est pas là par defaut

Citizen.CreateThread(

	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end)
			Citizen.Wait(0)
		end

		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		ESX.PlayerData = ESX.GetPlayerData()
	end
)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		ESX.PlayerData = xPlayer
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		ESX.PlayerData.job = job
	end
)

function deleteObject(object)
	return Citizen.InvokeNative(0x539E0AE3E6634B9F, Citizen.PointerValueIntInitialized(object))
end

function createObject(model, x, y, z)
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Citizen.Wait(0)
	end
	return CreateObject(model, x, y, z, true, true, false)
end

function spawnProp(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevatorProp = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevatorProp)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevatorProp, 0xFFFF)
		SetEntityCollision(elevatorProp, true, true)
		FreezeEntityPosition(elevatorProp, true)
		SetEntityCoords(elevatorProp, x, y, z, false, false, false, false) -- Patch un bug pour certains props.

		la_nacelle_estelle_la = true -- la nacelle est là
		elevatorOn = true
	end
end

function spawnProp2(propName, x, y, z)
	local model = GetHashKey(propName)
	
	if IsModelValid(model) then
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	
		local forward = 5.0
		local heading = GetEntityHeading(GetPlayerPed(-1))
		local xVector = forward * math.sin(math.rad(heading)) * -1.0
		local yVector = forward * math.cos(math.rad(heading))
		
		elevator2Prop = createObject(model, x, y, z)
		local propNetId = ObjToNet(elevator2Prop)
		SetNetworkIdExistsOnAllMachines(propNetId, true)
		NetworkSetNetworkIdDynamic(propNetId, true)
		SetNetworkIdCanMigrate(propNetId, false)
		
		SetEntityLodDist(elevator2Prop, 0xFFFF)
		SetEntityCollision(elevator2Prop, true, true)
		FreezeEntityPosition(elevator2Prop, true)
		SetEntityCoords(elevator2Prop, x, y, z, false, false, false, false) -- Patch un bug pour certains props.
		SetEntityHeading(elevator2Prop, elevator2BaseHeading)

		la_nacelle_estelle_la = true -- la nacelle est là
		elevator2On = true
	end
end

-- Affichage menu du pont 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		--pont1
		local elevatorCoords = GetEntityCoords(elevatorProp, false)
		
		if elevatorUp then
			if elevatorCoords.z < Config.max then -- hauteur max de la nacelle
				if (elevatorCoords.z > Config.beforemax) then -- juste avant la hauteur max de la nacelle
					elevatorBaseZ = elevatorBaseZ + Config.speed_up_slow -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				else
					elevatorBaseZ = elevatorBaseZ + Config.speed_up -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				end
			end
		end
		
		if elevatorDown then
			if elevatorCoords.z > Config.min then -- hauteur min de la nacelle
				if (elevatorCoords.z < Config.beforemin) then -- juste avant la hauteur min de la nacelle
					elevatorBaseZ = elevatorBaseZ - Config.speed_down_slow -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				else
					elevatorBaseZ = elevatorBaseZ - Config.speed_down -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevatorProp, elevatorBaseX, elevatorBaseY, elevatorBaseZ, false, false, false, false)
				end 
			end
		end

		--pont2
		local elevator2Coords = GetEntityCoords(elevator2Prop, false)
		
		if elevator2Up then
			-- TriggerServerEvent('InteractSound_CL:PlayOnOne', 'PontMecano_Monte', 1.0)
			if elevator2Coords.z < Config.max then -- hauteur max de la nacelle
				if (elevator2Coords.z > Config.beforemax) then -- juste avant la hauteur max de la nacelle
					elevator2BaseZ = elevator2BaseZ + Config.speed_up_slow -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				else
					elevator2BaseZ = elevator2BaseZ + Config.speed_up -- de combien de Z on monte à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				end
			end
		elseif elevator2Down then
			-- TriggerServerEvent('InteractSound_CL:PlayOnOne', 'PontMecano_Descente', 1.0)
			if elevator2Coords.z > Config.min then -- hauteur min de la nacelle
				if (elevator2Coords.z < Config.beforemin) then -- juste avant la hauteur min de la nacelle
					elevator2BaseZ = elevator2BaseZ - Config.speed_down_slow -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				else
					elevator2BaseZ = elevator2BaseZ - Config.speed_up -- de combien de Z on descend à chaque fois (= vitesse de monte)
					SetEntityCoords(elevator2Prop, elevator2BaseX, elevator2BaseY, elevator2BaseZ, false, false, false, false)
				end
			end
		end
    end
end)

-- key controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		
		if (Vdist(-219.3204, -1326.43, 29.89041, pos.x, pos.y, pos.z - 1) < 1.5) then -- Si on est a moins de 1.5 de distance de cette coordonnée
			if IsControlJustReleased(1, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == "mechanic" then -- Si on appuis sur E
				garage_menu = not garage_menu -- on s'assure que le menu soit fermé
				LiftBennysMenu1() -- ouverture du menu
			end
		elseif (Vdist(-212.798, -1317.543, 30.890, pos.x, pos.y, pos.z - 1) < 1.5) then -- Si on est a moins de 1.5 de distance de cette coordonnée
			if IsControlJustReleased(1, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == "mechanic" then -- Si on appuis sur E
				garage_menu = not garage_menu -- on s'assure que le menu soit fermé
				LiftBennysMenu2() -- ouverture du menu
			end
		end

		-- On fait apparaitre la nacelle toute les demi seconde si jamais elle n'est pas là
	    if not la_nacelle_estelle_la and (Vdist(-219.3204, -1326.43, 29.89041, pos.x, pos.y, pos.z - 1) < Config.spawndistance) then
	    	spawnProp("nacelle", elevatorBaseX, elevatorBaseY, elevatorBaseZ)
	    	spawnProp2("nacelle", elevator2BaseX, elevator2BaseY, elevator2BaseZ)
	    	Wait(1000)
	    end
    end
end)
----------------------------
-- By K3rhos & DoluTattoo --
----------------------------
----------------------------
--       LIFT MENU        --
----------------------------

function LiftBennysMenu1()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'lift_actions',
	  {
		title    = 'Hydrolic',
		align    = 'bottom-right',
		  elements = {
			  {label = 'Naik', value = 'vytahup'},
			  {label = 'Berhenti', value = 'vytahstop'},
			  {label = 'Turun', value = 'vytahdown'},
			  {label = 'Pasang Hyrdolic', value = 'vytahzapnout'},
			  {label = 'Lepas Hyrdolic', value = 'vytahvypnout'},
		  }
	  },
  
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'vytahup' then
			  if elevatorProp ~= nil then
				  elevatorDown = false
				  elevatorUp = true
				  elevatorStop = false
			  end			
		  elseif val == 'vytahstop' then
			  if elevatorProp ~= nil then
				  elevatorUp = false
				  elevatorDown = false
			  end
		  elseif val == 'vytahdown' then
			  if elevatorProp ~= nil then
				  elevatorUp = false
				  elevatorDown = true
				  elevatorStop = false
			  end
		  elseif val == 'vytahzapnout' then
			  if elevatorOn == false then
				  spawnProp("nacelle", elevatorBaseX, elevatorBaseY, elevatorBaseZ)
				  elevatorOn = true
			  end
		  elseif val == 'vytahvypnout' then
			  if elevatorOn == true then
				  DeleteObject(elevatorProp)
				  elevatorOn = false
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end
  
  function LiftBennysMenu2()
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'lift2_actions',
	  {
		title    = 'Hyrdolic',
		align    = 'bottom-right',
		  elements = {
			  {label = 'Naik', value = 'vytahup'},
			  {label = 'Berhenti', value = 'vytahstop'},
			  {label = 'Turun', value = 'vytahdown'},
			  {label = 'Pasang Hyrdolic', value = 'vytahzapnout'},
			  {label = 'Lepas Hyrdolic', value = 'vytahvypnout'},
		  }
	  },
  
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'vytahup' then
			  if elevator2Prop ~= nil then
				  elevator2Down = false
				  elevator2Up = true
				  elevator2Stop = false
			  end			
		  elseif val == 'vytahstop' then
			  if elevator2Prop ~= nil then
				  elevator2Up = false
				  elevator2Down = false
			  end
		  elseif val == 'vytahdown' then
			  if elevator2Prop ~= nil then
				  elevator2Up = false
				  elevator2Down = true
				  elevator2Stop = false
			  end
		  elseif val == 'vytahzapnout' then
			  if elevator2On == false then
				  spawnProp2("nacelle", elevator2BaseX, elevator2BaseY, elevator2BaseZ)
				  elevator2On = true
			  end
		  elseif val == 'vytahvypnout' then
			  if elevator2On == true then
				  DeleteObject(elevator2Prop)
				  elevator2On = false
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end

--////////////////////////////////////////
-- USABLE ITEM
--///////////////////////////////////////
RegisterNetEvent('esx_mechanicjob:gantiban')
AddEventHandler('esx_mechanicjob:gantiban', function()

	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasrepairLicense)
		if hasrepairLicense then

			FreezeEntityPosition(GetPlayerPed(-1), false)
			bancadangan = true
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey('prop_rub_tyre_01'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.11, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			while bancadangan do
				Citizen.Wait(250)
				local vehicle   = Nearbywheelvehicle()
				local coords    = GetEntityCoords(GetPlayerPed(-1))
				local playerPed = PlayerPedId()
				LoadDict('anim@heists@box_carry@')
			
				if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and bancadangan == true then
					TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
				
				if DoesEntityExist(vehicle) then
					bancadangan = false
					ClearPedTasks(GetPlayerPed(-1))
					DeleteEntity(prop)
					isBusy = true
					TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
					TriggerEvent("mythic_progbar:client:progress",
						{

							name = "wheelchange_vehicle",
							duration = 15000,
							label = "Mengganti ban..",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},

						function(status)
							ClearPedTasksImmediately(playerPed)
							isBusy = false
							if not status then
								local closestTire = Nearbywheel(vehicle)
								if closestTire ~= nil then
									SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('esx_mechanicjob:removeBan','ban', 1)
									NotifSukses("Ban telah diganti!")
								end

							end
						end)
				end
			end		
		else
			ESX.ShowNotification('Missing License')
		end
	end, GetPlayerServerId(PlayerId()), 'repair')
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasrepairLicense)
		if hasrepairLicense then

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					TriggerEvent("mythic_progbar:client:progress",
						{
							name = "repair_vehicle",
							duration = 15000,
							label = "Memperbaiki Kendaraan..",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},
						function(status)
							if not status then
								SetVehicleFixed(vehicle)
								SetVehicleDeformationFixed(vehicle)
								SetVehicleBodyHealth(vehicle, 1000.00)
								SetVehicleEngineHealth(vehicle, 1000.00)
								SetVehicleUndriveable(vehicle, false)
								SetVehicleEngineOn(vehicle, true, true)
								ClearPedTasksImmediately(playerPed)
								NotifSukses(_U('vehicle_repaired'))
								TriggerServerEvent('esx_mechanicjob:removeFixkit')
								isBusy = false
							end
						end)
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		else

			ESX.ShowNotification('Missing License')

		end

	end, GetPlayerServerId(PlayerId()), 'repair')

end)