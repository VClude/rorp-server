-- Local
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

local carInstance = {}

local hargakeluar = Config.Price

-- Fin Local

-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		end)
	end
end)


--Menu function

function OpenMenuGarage(garage, KindOfVehicle, garage_name, vehicle_type)
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('vip:isVip', function(yes)
		if yes then
			hargakeluar = Config.Price * 0.6
		end
	end)
	ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
		local elements, vehiclePropsList = {}, {}
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do

				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel

				if v.vehiclename then
					vehicleName = v.vehiclename					
				else
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				end

				if v.pound then
					vehicleLabel = vehicleName..' '..'('..vehicleProps.plate..' ) - <span style="color:red;">Sita Polisi</span>'
					table.insert(elements, {label = vehicleLabel, action = 'fourrieremecano'})

				elseif v.stored == false and v.pound == false then

					vehicleLabel = vehicleName..' '..'('..vehicleProps.plate..' ) - <span style="color:red;">$'..hargakeluar..'</span>'
					table.insert(elements, {
						label = vehicleLabel,
						plate = vehicleProps.plate,
						action = 'store'
					})		
				
				elseif vehicleProps.stored ~= nil then

					table.insert(elements, {label = _U('no_vehicle_out'), action = 'nothing'})

				end			

			end

		else
			table.insert(elements, {label = _U('no_vehicle_out'), action = 'nothing'})
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = 'Garasi Refound',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]
			if data.current.action == 'fourrieremecano' then
				ESX.ShowNotification('Silahkan ke Kanpol')
			elseif data.current.action == 'nothing' then
				return
			elseif data.current.action ~= nil then
				local doesVehicleExist = false
				for k,v in pairs (carInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(carInstance, k)
							doesVehicleExist = false
						end
					end
				end
				if not doesVehicleExist and not DoesAPlayerDrivesCar(data.current.plate) then
					ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then
							menu.close()
							SpawnVehicle(vehicleProps, garage, KindOfVehicle)
							ESX.ShowNotification('Kamu telah membayar: ~y~$'..hargakeluar)
						else
							ESX.ShowNotification(_U('not_enough_money'))						
						end
					end, hargakeluar)
				else
					ESX.ShowNotification(_U('cannot_take_out'))
				end				
			end
		end,
		function(data, menu)
			menu.close()
		end
		)
	end, KindOfVehicle, garage_name, vehicle_type)
end

-- Display vehicle lists
function ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)
	local elements, vehiclePropsList = {}, {}
	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do
				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel
								
				if v.vehiclename then
					vehicleName = v.vehiclename					
				else
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				end

				if v.fourrieremecano then
					vehicleLabel = vehicleName..' ( ' .. _U('pound_name')
				elseif v.stored and v.garage_name ~= nil then
					vehicleLabel = vehicleName..' ( ' .. vehicleProps.plate .. ' ) - <span style="color:green;">'..v.garage_name..'</span>' 
					table.insert(elements, {
						label = vehicleLabel,
						vehicleName = vehicleName,
						stored = v.stored,
						plate = vehicleProps.plate,
						fourrieremecano = v.fourrieremecano,
						garage_name = v.garage_name
					})
				end
				
			end
		else
			table.insert(elements, {label = _U('no_cars_stored'), value = "nocar"})
		end
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'Garasi Umum',
			align    = 'bottom-right',
			elements = elements,
		},
		function(data, menu)
			if data.current.value ~= "nocar" then
				local CarProps = vehiclePropsList[data.current.plate]
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_menu', {
					title    =  data.current.vehicleName,
					align    = 'bottom-right',
					elements = {
						{label = _U('take_out_car') , value = 'get_vehicle_out'},
				}}, function(data2, menu2)
						if data2.current.value == "get_vehicle_out" then
							if garage_name == data.current.garage_name then
								local doesVehicleExist = false
								for k,v in pairs (carInstance) do
									if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
										if DoesEntityExist(v.vehicleentity) then
											doesVehicleExist = true
										else
											table.remove(carInstance, k)
											doesVehicleExist = false
										end
									end
								end
								if (doesVehicleExist) or DoesAPlayerDrivesCar(data.current.plate) then
									ESX.ShowNotification(_U('cannot_take_out'))
								elseif (data.current.fourrieremecano) then
									ESX.ShowNotification(_U('vehicle_in_pound'))
								elseif (data.current.stored) then
									SpawnVehicle(CarProps, garage, KindOfVehicle)
									ESX.UI.Menu.CloseAll()
								else
									ESX.ShowNotification(_U('vehicle_already_out'))
								end
							else
								ESX.ShowNotification('Silahkan ambil di garasi tersebut')
							end
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
			else
				return
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
	end, KindOfVehicle, garage_name, vehicle_type)
end
-- End Display vehicle lists

-- Function for entering a vehicle
function StockVehicleMenu(KindOfVehicle, garage_name, vehicle_type)
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = GetVehicleProperties(TrailerHandle)
				if trailerProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(trailerProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(TrailerHandle)
							TriggerServerEvent('eden_garage:modifystate', trailerProps.plate, true)
							TriggerServerEvent("esx_eden_garage:MoveGarage", trailerProps.plate, garage_name)
							ESX.ShowNotification(_U('trailer_in_garage'))
						else
							ESX.ShowNotification(_U('cannot_store_vehicle'))
						end
					end,trailerProps, KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			else
				local vehicleProps  = GetVehicleProperties(vehicle)
				if vehicleProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(vehicle)
							TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, true)
							TriggerServerEvent("esx_eden_garage:MoveGarage", vehicleProps.plate, garage_name)
							ESX.ShowNotification(_U('vehicle_in_garage'))
						else
							ESX.ShowNotification(_U('cannot_store_vehicle'))
						end
					end,vehicleProps, KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			end
		else
			ESX.ShowNotification(_U('not_driver'))
		end
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end
-- End of function which allows to enter a vehicle
--End of menu function


--Vehicle spawn function
function SpawnVehicle(vehicleProps, garage, KindOfVehicle)
	ESX.Game.SpawnVehicle(vehicleProps.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehicleProps)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			local carplate = GetVehicleNumberPlateText(callback_vehicle)
			table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
			if KindOfVehicle == 'brewer' or KindOfVehicle == 'biker' or KindOfVehicle == 'jewelry' or KindOfVehicle == 'farmer' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'winemakers' or KindOfVehicle == 'tobacco' then
				TriggerEvent('esx_jobs1:addplate', carplate)
				TriggerEvent('esx_jobs2:addplate', carplate)
			end	
		end)
	TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, false)
end
--End function for vehicle spawn

function exitmarker()
	ESX.UI.Menu.CloseAll()
end

function DoesAPlayerDrivesCar(plate)
	local isVehicleTaken = false
	local players  = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps.vehicleHeadLight then SetVehicleHeadlightsColour(vehicle, vehicleProps.vehicleHeadLight) end
	
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 9 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)

        return vehicleProps
	else
		return nil
    end
end

RegisterNetEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()
	-- INPOUND
	for k,v in pairs (Config.Inpounds) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage", {
			marker = {
				weight = v.Marker.w,
				height = v.Marker.h,
				red = v.Marker.r,
				green = v.Marker.g,
				blue = v.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							OpenMenuGarage(v, "personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = {
				text = v.Name,
				colorId = Config.InpoundBlip.color,
				imageId = Config.InpoundBlip.sprite,
			},
			locations = {
				v.Pos				
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint", {

			locations = {
				{
					x = v.SpawnPoint.Pos.x,
					y = v.SpawnPoint.Pos.y,
					z = v.SpawnPoint.Pos.z,
				},
			},
		})
	end
	-- END - INPOUND

	for k,v in pairs (Config.Garages) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint", {
			marker = {
				weight = v.SpawnPoint.Marker.w,
				height = v.SpawnPoint.Marker.h,
				red = v.SpawnPoint.Marker.r,
				green = v.SpawnPoint.Marker.g,
				blue = v.SpawnPoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.SpawnPoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesMenu(v, "personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.SpawnPoint.Pos.x,
					y = v.SpawnPoint.Pos.y,
					z = v.SpawnPoint.Pos.z,
				},
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint", {
			marker = {
				weight = v.DeletePoint.Marker.w,
				height = v.DeletePoint.Marker.h,
				red = v.DeletePoint.Marker.r,
				green = v.DeletePoint.Marker.g,
				blue = v.DeletePoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.DeletePoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleMenu("personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = {
				text = v.Name,
				colorId = Config.Blip.color,
				imageId = Config.Blip.sprite,
			},
			locations = {
				{
					x = v.DeletePoint.Pos.x,
					y = v.DeletePoint.Pos.y,
					z = v.DeletePoint.Pos.z,
				},
			},
		})
	end
end)

-- End key control

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

