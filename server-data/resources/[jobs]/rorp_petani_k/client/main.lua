ESX 						= nil

local playerCoords
local currentPlant 			= 1
local currentPlants 		= 1
local cropsCounter 			= 0
local cropsThreshold 		= 10
local spawnedCrops 			= 1
local FarmerBlip			= {}
local cropsObj		 		= {}
local isPickingUp 			= false
local jobStatus = {
	onDuty = false,
	crop   = nil,
	plantBlip = nil,
	vehicle = nil,
}

-- Citizen.CreateThread(function()
-- 	local count = 0
-- 	for _, v in ipairs(Config.CropLocations) do
-- 		count = count + 1
-- 	end
-- 	jobStatus.maxCrops = count
-- end)

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
			spawnCrops()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #cropsObj, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cropsObj[i]), false) < 1 then
				nearbyObject, nearbyID = cropsObj[i], i
			end
		end

		if not jobStatus.onDuty and jobStatus.crop then 
			
			if nearbyObject and IsPedOnFoot(playerPed) then

				if not isPickingUp then
					ESX.ShowHelpNotification("Tekan ~INPUT_CONTEXT~ untuk mengambil")
				end

				if IsControlJustReleased(0, 38) and DoesObjectOfTypeExistAtCoords(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_cs_plant_01'), 0) then
				isPickingUp = true
				local plant = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_cs_plant_01'), 0, 1, 1)
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
							cropsCounter = cropsCounter + 1
							if cropsCounter == cropsThreshold then
								currentPlants = 0
								cropsCounter = 0
								ESX.ShowNotification("anda sudah memanen semua Tebu, Silahkan Anda perlu Membajak kebun lagi")
							end
							isPickingUp = false
							ESX.Game.DeleteObject(nearbyObject)
							table.remove(cropsObj, nearbyID)
							TriggerServerEvent('rorp_petani:GiveCrop', jobStatus.crop)
						end
				end)
			end
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

function DrawGameMarker(coords, id, colour)
	DrawMarker(id, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, colour[1], colour[2], colour[3], colour[4], false, true, 2, nil, nil, false)
end

function spawnCrops()
	while currentPlants < Config.TotalSpawnedCorps do
		Citizen.Wait(0)
		local tC = GenerateCrops()

		ESX.Game.SpawnLocalObject('prop_cs_plant_01', tC, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(cropsObj, obj)
			currentPlants = currentPlants + 1
		end)
	end
end

function GenerateCrops()
	while true do
		Citizen.Wait(1)

		local cX, cY

		math.randomseed(GetGameTimer())
		local modX = math.random(-46, 36)

		Citizen.Wait(100)

		-- math.randomseed(GetGameTimer())
		-- local modY = math.random(-21, 29)
		local bY = modX / 2
		local modY = 0 - bY
		cX = Config.FarmFields.x + modX
		cY = Config.FarmFields.y + modY

		local coordZ = GetZ(cX, cY)
		local coord = vector3(cX, cY, coordZ)

		if ValidateCrops(coord) then
			return coord
		end
	end
end

function ValidateCrops(plantCoord)
	if currentPlants > 0 then
		local validate = true

		for k, v in pairs(cropsObj) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < Config.TotalSpawnedCorps then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.FarmFields, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GetZ(x, y)
	local groundCheckHeights = {148.0, 149.0, 150.0, 151.0, 152.0, 153.0, 154.0, 155.0, 156.0, 157.0, 158.0, 159.0, 160.0, 161.0, 162.0, 163.0, 164.0, 165.0, 166.0, 167.0, 168.0, 169.0, 170.0, 171.0, 172.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 30
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

function deleteBlips()
	for _,v in ipairs(FarmerBlip) do
		RemoveBlip(v)
	end
end

function refreshBlips()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
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
			TriggerServerEvent('rorp_petani:SellCrop', data.current.value, data.current.price)
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