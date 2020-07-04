local spawnedVehicles = {}
local isInShopMenu

function OpenVehicleSpawnerMenu(type)
	local playerCoords = GetEntityCoords(PlayerPedId())

    PlayerData = ESX.GetPlayerData()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top',
		elements = {
			{label = 'Garasi bennys', action = 'garage'},
			{label = 'Simpan di garasi', action = 'store_garage'},
			{label = 'Beli kendaraan', action = 'buy_vehicle'}
	}}, function(data, menu)
		if data.current.action == 'buy_vehicle' then
            local shopElements, shopCoords = {}
            if type == 'car' then
                shopCoords = Config.Zones.Vehicles.InsideShop
                local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

                if #authorizedVehicles > 0 then
                    for k,vehicle in ipairs(authorizedVehicles) do
                        if IsModelInCdimage(vehicle.model) then
                            local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))

                            table.insert(shopElements, {
                                -- label = vehicle.label .. ' - <span style="color:green;">Zakoupit za $' .. ESX.Math.GroupDigits(vehicle.price) .. "</span>",
                                label = ('%s - <span style="color:green;">%s</span>'):format(vehicleLabel, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
                                name  = vehicleLabel,
                                model = vehicle.model,
                                price = vehicle.price,
                                props = vehicle.props,
                                type  = type
                            })
                        end                             
                    end

                    if #shopElements > 0 then
                        OpenVehicleShopMenu(shopElements, playerCoords, shopCoords)
                    else
                        ESX.ShowNotification('BACOT')
                    end
                else
                    ESX.ShowNotification('BACOT')
                end
            else
                ESX.ShowNotification('BACOT')
            end
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('t1ger_cardealer:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					local allVehicleProps = {}

					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)

						if IsModelInCdimage(props.model) then
							local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
							local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

							if v.stored then
								label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
							else
								label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
							end

							table.insert(garage, {
								label = label,
								stored = v.stored,
								model = props.model,
								plate = props.plate
							})

							allVehicleProps[props.plate] = props
						end
					end

					if #garage > 0 then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
							title    = _U('garage_title'),
							align    = 'top',
							elements = garage
						}, function(data2, menu2)
							if data2.current.stored then
								local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint()

								if foundSpawn then
									menu2.close()

									ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
										local vehicleProps = allVehicleProps[data2.current.plate]
										ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

										TriggerServerEvent('t1ger_cardealer:setJobVehicleState', data2.current.plate, false)
										exports['mythic_notify']:DoCustomHudText('success', _U('garage_released'), 2500)
									end)
								end
							else
								exports['mythic_notify']:DoCustomHudText('error', _U('garage_notavailable'), 2500)
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					else
						exports['mythic_notify']:DoCustomHudText('error', _U('garage_empty'), 2500)
					end
				else
					exports['mythic_notify']:DoCustomHudText('error', 'Tidak ada kendaraan', 2500)
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end


function OpenVehicleShopMenu(elements, restoreCoords, shopCoords)
    local playerPed = PlayerPedId()
    isInShopMenu = true
	ESX.UI.Menu.Open("default",GetCurrentResourceName(),"vehicle_shop",
		{
			title = "Buy Company Car",
			align = "bottom-right",
			elements = elements
		},
		function(data, menu)
			DeleteSpawnedVehicles()
			WaitForVehicleToLoad(data.current.model)
            ESX.Game.SpawnLocalVehicle(data.current.model,shopCoords,0.0,
            
            function(vehicle)

                table.insert(spawnedVehicles, vehicle)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                FreezeEntityPosition(vehicle, true)

                if data.current.livery then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleLivery(vehicle, data.current.livery)
                end
			end)

			ESX.UI.Menu.Open("default",GetCurrentResourceName(),"vehicle_shop_confirm",
				{
					title = "Really buy a vehicle " .. data.current.name .. " for $" .. data.current.price .. "?",
					align = "bottom-right",
					elements = {
						{label = "No", value = "no"},
						{label = "Yes", value = "yes"}
					}
				},

				function(data2, menu2)
					if data2.current.value == "yes" then
						local newPlate = exports['t1ger_cardealer']:ProduceNumberPlate()
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						local props = ESX.Game.GetVehicleProperties(vehicle)
						props.plate = newPlate

						ESX.TriggerServerCallback("rorp_bennys:buyJobVehicle",function(bought)
                            if bought then
                                exports['mythic_notify']:SendAlert('success', 'You bought a vehicle ' .. data.current.name .. ' for $' .. ESX.Math.GroupDigits(data.current.price) .. '.', 5000)
                                isInShopMenu = false
                                ESX.UI.Menu.CloseAll()
                                DeleteSpawnedVehicles()
                                FreezeEntityPosition(playerPed, false)
                                SetEntityVisible(playerPed, true)

                                ESX.Game.Teleport(playerPed, restoreCoords)
                            else
                                exports['mythic_notify']:SendAlert('error', 'Nemáš dostatek peněz na zakoupení vozidla.', 5000)
                                menu2.close()
                            end

						end,props,data.current.type)
					else
						menu2.close()
					end
                end,
                
				function(data2, menu2)
					menu2.close()
                end)
        end,
        
		function(data, menu)

			isInShopMenu = false
			ESX.UI.Menu.CloseAll()
			DeleteSpawnedVehicles()
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			ESX.Game.Teleport(playerPed, restoreCoords)
		end,

		function(data, menu)
			DeleteSpawnedVehicles()
			WaitForVehicleToLoad(data.current.model)
			ESX.Game.SpawnLocalVehicle(data.current.model,shopCoords,0.0,

				function(vehicle)
					table.insert(spawnedVehicles, vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					FreezeEntityPosition(vehicle, true)

					if data.current.livery then
						SetVehicleModKit(vehicle, 0)
						SetVehicleLivery(vehicle, data.current.livery)
					end
				end
			)
        end
    )


    WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model,shopCoords,0.0,

		function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)

			if elements[1].livery then
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, elements[1].livery)
			end
		end

	)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == "number" and modelHash or GetHashKey(modelHash))
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableControlAction(0, Keys["TOP"], true)
			DisableControlAction(0, Keys["DOWN"], true)
			DisableControlAction(0, Keys["LEFT"], true)
			DisableControlAction(0, Keys["RIGHT"], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys["BACKSPACE"], true)
			drawLoadingText("Loading vehicle model...", 255, 255, 255, 255)
		end
	end
end

function GetAvailableVehicleSpawnPoint()
	local spawnPoints = Config.Zones.Vehicles.SpawnPoints
	local found, foundSpawnPoint = false, nil
	for i = 1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		exports['mythic_notify']:SendAlert('error', 'All parking spaces are occupied.', 5000)
		return false
	end
end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		exports['mythic_notify']:SendAlert('error', 'No storage vehicle was found nearby.', 5000)
		return
	end

	ESX.TriggerServerCallback('rorp_bennys:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(
					function()
						while IsBusy do
							Citizen.Wait(0)
							drawLoadingText("We are removing vehicles ...", 255, 255, 255, 255)
						end
					end
            )

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			exports['mythic_notify']:SendAlert('success', 'The vehicle was stored in the garage.', 5000)
		else
			exports['mythic_notify']:SendAlert('error', 'The vehicle could not be stored.', 5000)
		end
	end, vehiclePlates)
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(6)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isInShopMenu then
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Citizen.Wait(500)
        end
    end
end)