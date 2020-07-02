ESX = nil

local jobBlips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	-- onDuty = false
	-- myPlate = {} -- loosing vehicle caution in case player changes job.
	-- spawner = 0
	deleteBlips()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

function deleteBlips()
	for k,v in ipairs(jobBlips) do
		RemoveBlip(v)
		jobBlips[k] = nil
	end
end

function refreshBlips()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "miner" then
        for k,v in pairs(Config.Blips) do
            if v.Pos then
                local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

                SetBlipSprite  (blip, v.Sprite)
                SetBlipScale   (blip, v.Scale)
                SetBlipCategory(blip, 3)
                SetBlipColour  (blip, v.Colour)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(v.Name)
                EndTextCommandSetBlipName(blip)

                table.insert(jobBlips, blip)
            end
        end
    end
end