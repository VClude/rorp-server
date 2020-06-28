local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinField.coords, true) < 50 then
			SpawnPoppyPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinProcessing.coords, true) < 5 then
-- 			if not isProcessing then
-- 				ESX.ShowHelpNotification(_U('heroin_processprompt'))
-- 			end

-- 			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
-- 				if not IsPedInAnyVehicle(playerPed, true) then
-- 					if Config.RequireCopsOnline then
-- 						ESX.TriggerServerCallback('esx_illegal:EnoughCops', function(cb)
-- 							if cb then
-- 								ProcessHeroin()
-- 							else
-- 								ESX.ShowNotification(_U('cops_notenough'))
-- 							end
-- 						end, Config.Cops.Heroin)
-- 					else
-- 						ProcessHeroin()
-- 					end
-- 				else
-- 					ESX.ShowNotification(_U('need_on_foot'))
-- 				end
-- 			end
-- 		else
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #PoppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = PoppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('heroin_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				if Config.RequireCopsOnline then
					ESX.TriggerServerCallback('esx_illegal:EnoughCops', function(cb)
						if cb then
							PickUpPoppy(playerPed, coords, nearbyObject, nearbyID)
						else
							ESX.ShowNotification(_U('cops_notenough'))
						end
					end, Config.Cops.Heroin)
				else
					PickUpPoppy(playerPed, coords, nearbyObject, nearbyID)
				end
			end

		else
			Citizen.Wait(500)
		end

	end

end)

function PickUpPoppy(playerPed, coords, nearbyObject, nearbyID)
	isPickingUp = true

	ESX.TriggerServerCallback('esx_illegal:canPickUp', function(canPickUp)

		if canPickUp then
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

			Citizen.Wait(2000)
			ClearPedTasks(playerPed)
			Citizen.Wait(1500)

			ESX.Game.DeleteObject(nearbyObject)

			table.remove(PoppyPlants, nearbyID)


			TriggerServerEvent('esx_illegal:pickedUpPoppy')
			Citizen.Wait(5000)
			spawnedPoppys = spawnedPoppys - 1
		else
			ESX.ShowNotification(_U('poppy_inventoryfull'))
		end

		isPickingUp = false

	end, 'poppyresin')
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(PoppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppys < 5 do
		Citizen.Wait(0)
		local heroinCoords = GenerateHeroinCoords()

		ESX.Game.SpawnLocalObject('prop_cs_plant_01', heroinCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(PoppyPlants, obj)
			spawnedPoppys = spawnedPoppys + 1
		end)
	end
end

function ValidateHeroinCoord(plantCoord)
	if spawnedPoppys > 0 then
		local validate = true

		for k, v in pairs(PoppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HeroinField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHeroinCoords()
	while true do
		Citizen.Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		heroinCoordX = Config.CircleZones.HeroinField.coords.x + modX
		heroinCoordY = Config.CircleZones.HeroinField.coords.y + modY

		local coordZ = GetCoordZHeroin(heroinCoordX, heroinCoordY)
		local coord = vector3(heroinCoordX, heroinCoordY, coordZ)

		if ValidateHeroinCoord(coord) then
			return coord
		end
	end
end

function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 12.64
end