ESX 						= nil

local playerCoords
local currentPlant 			= 1
local currentPlants 		= 1
local cropsCounter 			= 0
local spawnedCrops 			= 1
local FarmerBlip			= {}
local cropsObj		 		= {}
local isPickingUp 			= false
local isPackaging			= false
local spawnCounter			= 0
local jobStatus = {
	onDuty = false,
	crop   = nil,
	plantBlip = nil,
	vehicle = nil,
}

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
			if  distance < 40.0 then
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

				if IsControlJustReleased(0, 38) and DoesObjectOfTypeExistAtCoords(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_veg_crop_02'), 0) then
					isPickingUp = true
					local plant = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey('prop_veg_crop_02'), 0, 1, 1)
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
								isPickingUp = false
								ESX.Game.DeleteObject(nearbyObject)
								table.remove(cropsObj, nearbyID)
								TriggerServerEvent('rorp_petani:GiveCrop', jobStatus.crop)
								cropsCounter = cropsCounter + 1
								if cropsCounter == Config.cropsThreshold then
									cropsCounter = 0
									spawnCounter = spawnCounter + 1
									if spawnCounter < 10 then
										Citizen.Wait(2000)
										spawnCrops()
									else
										spawnCounter = 0
									end
								end
							end
						end
					)
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobName then
			local distance = #(playerCoords - Config.PackagingCrop.pos)
			if  distance < 5.0 then
				local coordPack = Config.PackagingCrop.pos
				DrawMarker(24, coordPack.x, coordPack.y, coordPack.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 250, 0, 50, false, true, 2, nil, nil, false)
				if distance < 2.0 then
					ESX.ShowHelpNotification(_U('pack_crops'))
					if IsControlJustReleased(0, 38) then
						if not isPackaging then
							OpenPackageMenu()
						end
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
			if  distance < 5.0 then
				local coordPos = Config.StartJob.pos
				DrawMarker(39, coordPos.x, coordPos.y, coordPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 250, 0, 50, false, true, 2, nil, nil, false)
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
	for k,v in ipairs(Config.CropLocations) do
		Citizen.Wait(1500, 3500)
		ESX.Game.SpawnLocalObject('prop_veg_crop_02', vector3(v.x, v.y, v.z - 1), function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(cropsObj, obj)
		end)
	end
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
		SetBlipSprite(blip, 140)
		SetBlipDisplay(blip, 2)
		SetBlipScale(blip, 0.6)
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

function OpenPackageMenu()
	local elements = {}

	for k,v in ipairs(Config.PackagingCrop) do
		table.insert(elements, {label = v.label, value = v.DBname, req1 = v.bahan1, req2 = v.bahan2})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_packaging',
	{
		title  = _U('packaging_menu'),
		elements = elements,
		align = 'left'
	},
	function(data, menu)
		if data.current.value then
			ESX.TriggerServerCallback('rorp_petani:checkBahan', function(hasAllReq)		
				if hasAllReq then
					packagingEvent(data.current.value)
					isPackaging = true
					menu.close()
				else
					exports['mythic_notify']:SendAlert('error', 'kamu membutuhkan '..data.current.req1..' x4 dan '..data.current.req2.. ' x1')
				end	
			end,data.current.req1,data.current.req2)
		end
	end,
	function(data, menu)
		menu.close()
	end
	)
end

function packagingEvent(packaged)
	local _packaged = packaged

	TriggerEvent("mythic_progressbar:client:progress", {
		name = "packaging_crop",
		duration = 5000,
		label = _U("packaging_crop"),
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {

		}
	}, function(status)
			if not status then								
				TriggerServerEvent('rorp_petani:GivePackagedCrop', _packaged)
				isPackaging = false
			end
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