ESX = nil

cachedData = {
	["keys"] = {},
	["tempKeys"] = {},
	["hotwiredVehicles"] = {}
}

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end

	if ESX.IsPlayerLoaded() then
		Init()
	end

	if Config.VehicleMenu then
		while true do
			Citizen.Wait(5)

			if IsControlJustPressed(0, Config.VehicleMenuButton) then
				OpenVehicleMenu()
			end
		end
	end
end)

RegisterCommand("keymenu", function()
	ShowKeyMenu()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData

	Init()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)

	local CanStartVehicle = function(vehicleEntity)
		return HasKey("veh-" .. GetVehicleNumberPlateText(vehicleEntity)) or HasVehicleAccess(GetVehicleNumberPlateText(vehicleEntity))
 	end

	while true do
		local sleepThread = 500

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped, false) then
			sleepThread = 5

			local vehicleEntity = GetVehiclePedIsUsing(ped)

			if GetPedInVehicleSeat(vehicleEntity, -1) == ped then
				if GetIsVehicleEngineRunning(vehicleEntity) then
					if not cachedData["notified"] then
						ESX.ShowHelpNotification("~INPUT_WEAPON_WHEEL_NEXT~ to halt the engine.")

						cachedData["notified"] = true
					end

					if IsControlJustPressed(0, 14) then
						SetVehicleEngineOn(vehicleEntity, false, true, false)

						ESX.ShowNotification("Engine halted.", "error", 2000)
					end

					if IsControlPressed(0, 75) and not IsEntityDead(ped) then
						Citizen.Wait(250)

						SetVehicleEngineOn(vehicleEntity, true, true, false)
			
						TaskLeaveVehicle(ped, vehicleEntity, 0)
					end
				else
					SetVehicleEngineOn(vehicleEntity, false, true, false)

					if CanStartVehicle(vehicleEntity) then
						ESX.ShowHelpNotification("~INPUT_WEAPON_WHEEL_PREV~ to ignite the engine.")

						if IsControlJustPressed(0, 15) then
							SetVehicleEngineOn(vehicleEntity, true, true, false)

							ESX.ShowNotification("Engine started.", "warning", 2000)
						end
					else
						local textOffset = GetOffsetFromEntityInWorldCoords(vehicleEntity, 0.0, 2.0, 1.0)

						DrawScriptText(textOffset, "[~g~H~s~] Hotwire")

						if IsControlJustPressed(0, 104) then
							HotwireVehicle(vehicleEntity)
						end
					end
				end
			end
		else
			if cachedData["notified"] then
				cachedData["notified"] = false
			end
		end

		Citizen.Wait(sleepThread)
	end
end)