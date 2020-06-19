-- --------------------------------
-- ------- Created by Hamza -------
-- -------------------------------- 

-- ESX = nil

-- local PlayerData = nil
-- local currentlyMining = false
-- local currentlyWashing = false
-- local currentlySmelting = false

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- 	while ESX.GetPlayerData().job == nil do
-- 		Citizen.Wait(10)
-- 	end
-- 	PlayerData = ESX.GetPlayerData()
-- end)

-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		-- if PlayerData.job.name ~= 'miner' then
-- 		-- 	ESX.ShowNotification("lu bukan penambang gblk")
-- 		-- else
-- 		for k,v in pairs(Config.MiningSpots) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
-- 			if distance <= 20.0 and not currentlyMining then
				
-- 			DrawMarker(Config.MiningMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MiningMarkerScale.x, Config.MiningMarkerScale.y, Config.MiningMarkerScale.z, Config.MiningMarkerColor.r,Config.MiningMarkerColor.g,Config.MiningMarkerColor.b,Config.MiningMarkerColor.a, false, true, 2, true, false, false, false)
									
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.0 and not currentlyMining then
-- 				DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawMining3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartMining) then
-- 					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--                     if closestPlayer == -1 or closestDistance >= 1 then
-- 						ESX.TriggerServerCallback("esx_MinerJob:getPickaxe", function(pickaxe)
-- 							if pickaxe then
-- 								MiningEvent()	
-- 							else
-- 								ESX.ShowNotification("Kamu membutuhkan ~y~pickaxe~s~ untuk ~b~Menambang~s~ disini!")
-- 							end
-- 						end)
-- 					else
-- 						ESX.ShowNotification("Kamu terlalu dekat dengan yang lain")
-- 					end
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- -- end
-- end)

-- function MiningEvent()
	
-- 	currentlyMining = true
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
	
-- 	FreezeEntityPosition(playerPed, true)
-- 	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
-- 	Citizen.Wait(200)
	
-- 	local pickaxe = GetHashKey("prop_tool_pickaxe")
	
-- 	-- Loads model
-- 	RequestModel(pickaxe)
--     while not HasModelLoaded(pickaxe) do
--       Wait(1)
--     end
	
-- 	local anim = "melee@hatchet@streamed_core_fps"
-- 	local action = "plyr_front_takedown"
	
-- 	 -- Loads animation
--     RequestAnimDict(anim)
--     while not HasAnimDictLoaded(anim) do
--       Wait(1)
--     end
	
-- 	local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
-- 	AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
	
-- 	exports['progressBars']:startUI((10000), "MINING")
-- 	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
-- 	Citizen.Wait(2000)
-- 	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
-- 	Citizen.Wait(2000)
-- 	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
-- 	Citizen.Wait(2000)
-- 	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
-- 	Citizen.Wait(2000)
-- 	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
-- 	Citizen.Wait(2000)
	
-- 	TriggerServerEvent("esx_MinerJob:reward",'stone',5)
	
-- 	ClearPedTasks(PlayerPedId())
-- 	FreezeEntityPosition(playerPed, false)
--     DeleteObject(object)
-- 	currentlyMining = false

-- end

-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		for k,v in pairs(Config.WasherLocation) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
-- 			if distance <= 20.0 and not currentlyWashing then
-- 				DrawMarker(Config.WasherMarker, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.WasherMarkerScale.x, Config.WasherMarkerScale.y, Config.WasherMarkerScale.z, Config.WasherMarkerColor.r,Config.WasherMarkerColor.g,Config.WasherMarkerColor.b,Config.WasherMarkerColor.a, false, true, 2, true, false, false, false)					
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.2 and not currentlyWashing then
-- 				DrawText3Ds(v.x, v.y, v.z, Config.DrawWasher3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartWashing) then
-- 					ESX.TriggerServerCallback("esx_MinerJob:getWashPan", function(washPan)
-- 						if washPan then
-- 							WasherEvent()
-- 						else
-- 							ESX.ShowNotification("Kamu membutuhkan ~y~wash pan~s~ untuk ~b~Mencuci~s~ disini!")
-- 						end
-- 					end)
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- end)

-- function WasherEvent()
	
-- 	currentlyWashing = true
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
	
-- 	FreezeEntityPosition(playerPed, true)
-- 	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
-- 	Citizen.Wait(200)
	
-- 	ESX.TriggerServerCallback("esx_MinerJob:removeStone", function(stoneCount)
-- 		if stoneCount then
-- 			exports['progressBars']:startUI((10000), "WASHING STONE")
-- 			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
-- 			Citizen.Wait(10000)
-- 			TriggerServerEvent("esx_MinerJob:reward",'washed_stone',10)	
-- 		else
-- 			ESX.ShowNotification("Kamu membutuhkan ~y~10x Batu~s~ untuk ~b~Mencuci~s~ disini!")
-- 		end
-- 		ClearPedTasks(playerPed)
-- 		FreezeEntityPosition(playerPed, false)
-- 		currentlyWashing = false
-- 	end)
-- end

-- -- Core Thread Function:
-- Citizen.CreateThread(function()
-- 	while true do
--         Citizen.Wait(5)
-- 		local coords = GetEntityCoords(GetPlayerPed(-1))
-- 		for k,v in pairs(Config.SmelterSpots) do
-- 			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
-- 			if distance <= 20.0 and not currentlySmelting then
-- 				DrawMarker(Config.SmelterMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.SmelterMarkerScale.x, Config.SmelterMarkerScale.y, Config.SmelterMarkerScale.z, Config.SmelterMarkerColor.r,Config.SmelterMarkerColor.g,Config.SmelterMarkerColor.b,Config.SmelterMarkerColor.a, false, true, 2, true, false, false, false)					
-- 			else
-- 				Citizen.Wait(1000)
-- 			end	
-- 			if distance <= 1.0 and not currentlySmelting then
-- 				DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawSmelter3DText)
-- 				if IsControlJustPressed(0, Config.KeyToStartSmelting) then
-- 					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--                     if closestPlayer == -1 or closestDistance >= 0.7 then
-- 						ESX.TriggerServerCallback("esx_MinerJob:getWashedStone", function(WashedStone)
-- 							if WashedStone then
-- 								SmeltingEvent()	
-- 							else
-- 								ESX.ShowNotification("Kamu membutuhkan sekiranya ~y~10x Batu Bersih~s~ untuk di ~b~Lebur~s~ disini!")
-- 							end
-- 						end)
-- 					else
-- 						ESX.ShowNotification("Kamu terlalu dekat dengan yang lain")
-- 					end
-- 					Citizen.Wait(300)
-- 				end
-- 			end
-- 		end		
-- 	end
-- end)

-- function SmeltingEvent()
	
-- 	currentlySmelting = true
-- 	local playerPed = PlayerPedId()
-- 	local coords = GetEntityCoords(playerPed)
	
-- 	FreezeEntityPosition(playerPed, true)
-- 	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
-- 	Citizen.Wait(200)
		
-- 	exports['progressBars']:startUI((10000), "SMELTING WASHED STONE")
-- 	Citizen.Wait(10000)
	
-- 	TriggerServerEvent("esx_MinerJob:rewardSmelting")
	
-- 	FreezeEntityPosition(playerPed, false)
-- 	currentlySmelting = false

-- end

-- -- Function for 3D text:
-- function DrawText3Ds(x,y,z, text)
--     local onScreen,_x,_y=World3dToScreen2d(x,y,z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())

--     SetTextScale(0.32, 0.32)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 255)
--     SetTextEntry("STRING")
--     SetTextCentre(1)
--     AddTextComponentString(text)
--     DrawText(_x,_y)
--     local factor = (string.len(text)) / 500
--     DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
-- end

-- -- Blip on map for Quarry Location:
