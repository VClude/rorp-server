ESX = nil

local playerCoords
local currentPlant = 1
local spawnedCorps = 0
local FarmerBlip					  = {}
local plants 						  = {}

local jobStatus = {
	onDuty = false,
	crop   = nil,
	plantBlip = nil,
	vehicle = nil,
	maxCrops = nil
}

Citizen.CreateThread(function()
	local count = 0
	for _, v in ipairs(Config.CropLocations) do
		count = count + 1
	end
	jobStatus.maxCrops = count
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()

	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	deleteBlips()
	refreshBlips()
end)

Citizen.CreateThread(function()
	while true do
	playerCoords = GetEntityCoords(PlayerPedId())
	Citizen.Wait(250)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 	if ESX ~= nil then
-- 	playerJob = ESX.GetPlayerData().job.name
-- 	Citizen.Wait(60000)
-- 	end
-- 	Citizen.Wait(5)
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if playerCoords ~= nil and jobStatus.onDuty and ESX.PlayerData.job.name == Config.JobName then
			local distance = #(playerCoords - Config.PlantMarkers[currentPlant])
			if  distance < 20.0 then
				DrawGameMarker(Config.PlantMarkers[currentPlant], 2, {0, 250, 0, 50})
				if distance < 3.0 then
					currentPlant = currentPlant + 1
					RemoveBlip(jobStatus.plantBlip)
					jobStatus.plantBlip = MissionMarker(Config.PlantMarkers[currentPlant], 1, _U("plant_blip"), 2)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if currentPlant > 3 then
			currentPlant = 1
			ESX.Game.DeleteVehicle(jobStatus.vehicle)
			RemoveBlip(jobStatus.plantBlip)
			jobStatus = {
				onDuty    = false,
				crop      = jobStatus.crop,
				plantBlip = nil,
				vehicle   = nil
			}
			PlantCrops()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if not jobStatus.onDuty and jobStatus.crop then 
			if IsControlJustReleased(0, 38) and DoesObjectOfTypeExistAtCoords(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_veg_corn_01'), 0) then
			local plant = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_veg_corn_01'), 0, 1, 1)
			TriggerEvent("mythic_progressbar:client:progress", {
				name = "harvesting_crop",
				duration = 5000,
				label = _U("harvesting_crop"),
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "amb@world_human_gardener_plant@male@idle_a",
					anim = "idle_a",
				}
			}, function(status)
				if not status then
					DeleteEntity(plant)
					TriggerServerEvent('zythos-farming:GiveCrop', jobStatus.crop)
				end
			end)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
			local distance = #(playerCoords - Config.SellCrops)
			if  distance < 10.0 then
				DrawGameMarker(Config.SellCrops, Config.BlipID, {0, 250, 0, 50})
				if distance < 2.0 then
					ESX.ShowHelpNotification(_U('sell_crops'))
					if IsControlJustReleased(0, 38) then
						OpenCropMenu()
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if playerCoords ~= nil and not jobStatus.onDuty and ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
			local distance = #(playerCoords - Config.Management)
			if  distance < 10.0 then
				DrawGameMarker(Config.Management, Config.BlipID, {0, 250, 0, 50})
				if distance < 2.0 then
					ESX.ShowHelpNotification(_U('civ_clothes'))
					if IsControlJustReleased(0, 38) then
						CivClothing()
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if playerCoords ~= nil and not jobStatus.onDuty and ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
			local distance = #(playerCoords - Config.StartJob.pos)
			if  distance < 10.0 then
				DrawGameMarker(Config.StartJob.pos, Config.BlipID, {0, 250, 0, 50})
				if distance < 2.0 then
					ESX.ShowHelpNotification(_U('start_job'))
					if IsControlJustReleased(0, 38) then
						OpenJobMenu()
					end
				end
			end
		end
	end
end)

-- Blips
-- Citizen.CreateThread(function()
-- 	if playerJob == "farmer" then
-- 		DrawBlip(Config.Management, 304, _U('civ_clothing_blip'), 2)
-- 		DrawBlip(Config.SellCrops, 431, _U('sell_crops_blip'), 2)
-- 		DrawBlip(Config.StartJob.pos, 210, _U('start_job_blip'), 2)
-- 	end
-- end)

function DrawGameMarker(coords, id, colour)
	DrawMarker(id, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, colour[1], colour[2], colour[3], colour[4], false, true, 2, nil, nil, false)
end

function PlantCrops()
	while spawnedCorps <= 10 do
		Citizen.Wait(0)
		local coordsPlants = GenerateCorpsCoords()
		Citizen.Wait(1500, 3500)
		ESX.Game.SpawnLocalObject('prop_veg_corn_01', vector3(v.x, v.y, v.z - 1), function(crop)
			PlaceObjectOnGroundProperly(crop)

			table.insert(plants, crop)
			spawnedCorps = spawnedCorps + 1			
		end)

		-- for k,v in ipairs(Config.CropLocations) do
		-- 	Citizen.Wait(1500, 3500)
		-- 	ESX.Game.SpawnLocalObject('prop_veg_corn_01', vector3(v.x, v.y, v.z - 1), function(crop)
		-- 		PlaceObjectOnGroundProperly(crop)

		-- 		table.insert(plants, crop)
		-- 		spawnedCorps = spawnedCorps + 1			
		-- 	end)
		-- end
	end
end

function ValidateCorpsCoord(plantCoord)
	if spawnedCorps > 0 then
		local validate = true

		for k, v in pairs(plants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

	
		if GetDistanceBetweenCoords(plantCoord, Config.CropLocations.coords, false) > 50 then
			validate = false
		end
	

		return validate
	else
		return true
	end
end

function GenerateCorpsCoords()
	while true do
		Citizen.Wait(1)

		local corps2CoordX, corps2CoordY

		math.randomseed(GetGameTimer())
		local modX2 = math.random(-7, 7)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY2 = math.random(-7, 7)

		weed2CoordX = Config.CropLocations.coords.x + modX2
		weed2CoordY = Config.CropLocations.coords.y + modY2

		local coordZ2 = GetCoordCorps(weed2CoordX, weed2CoordY)
		local coord2 = vector3(weed2CoordX, weed2CoordY, coordZ2)

		if ValidateHydrochloricAcidCoord(coord2) then
			return coord2
		end
	end
end

function GetCoordCorps(x, y)
	local groundCheckHeights = { 28.0, 29.0, 30.0, 31.0, 32.0 }

	for i, height in ipairs(groundCheckHeights) do
		local found2Ground, z = GetGroundZFor_3dCoord(x, y, height)

		if found2Ground then
			return z
		end
	end

	return 30.0
end

function MissionMarker(coords, sprite, title, colour)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(title)
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip, true)
	SetBlipRouteColour(blip, 2)
	return blip
end

-- function DrawBlip(coords, sprite, title, colour)
-- 	local blip = AddBlipForCoord(coords)
-- 	SetBlipSprite(blip, sprite)
-- 	SetBlipDisplay(blip, 4)
-- 	SetBlipScale(blip, 0.60)
-- 	SetBlipColour(blip, colour)
-- 	SetBlipAsShortRange(blip, true)
-- 	BeginTextCommandSetBlipName("STRING")
-- 	AddTextComponentString(title)
-- 	EndTextCommandSetBlipName(blip)
-- 	return blip
-- end

function deleteBlips()
	for _,v in ipairs(FarmerBlip) do
		RemoveBlip(v)
	end
end

function refreshBlips()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "farmer" then
		local blip = AddBlipForCoord(Config.StartJob.pos)
		SetBlipSprite(blip, 210)
		SetBlipDisplay(blip, 2)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 15)
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('start_job_blip'))
		EndTextCommandSetBlipName(blip)

		table.insert(FarmerBlip, blip)
	end
end

function OpenJobMenu()

	local elements = {}

	for k,v in ipairs(Config.Seeds) do
		table.insert(elements, {label = v.label, value = v.DBname})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_menu',
	{
		title  = _U('job_menu'),
		elements = elements,
		align = 'left'
	},
	function(data, menu)
		if data.current.value then
			menu.close()
			ESX.Game.SpawnVehicle(Config.WorkVehicle, Config.StartJob.pos, Config.StartJob.heading, function(veh)
				if DoesEntityExist(veh) then
					jobStatus = {
						onDuty = true,
						crop   = data.current.value,
						plantBlip = MissionMarker(Config.PlantMarkers[currentPlant], 1, _U("plant_blip"), 1),
						vehicle = veh
					}
					SetPedIntoVehicle(PlayerPedId(), veh, -1)
					setUniform()
				end
			end)
		end
	end,
	function(data, menu)
		menu.close()
	end
	)
end

function OpenCropMenu()

	local elements = {}

	for k,v in ipairs(Config.Crops) do
		table.insert(elements, {label = v.label .. ' - $' .. v.price, value = v.DBname, price = v.price})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_shop',
	{
		title  = _U('crop_menu'),
		elements = elements,
		align = 'left'
	},
	function(data, menu)
		if data.current.value then
			menu.close()
			TriggerServerEvent('zythos-farming:SellCrop', data.current.value, data.current.price)
		end
	end,
	function(data, menu)
		menu.close()
	end
	)
end

function setUniform()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniform

		if skin.sex == 0 then
			uniform = Config.Uniform.male
		else
			uniform = Config.Uniform.female
		end

		if uniform then
			TriggerEvent('skinchanger:loadClothes', skin, uniform)
		end
	end)
end

function CivClothing()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end