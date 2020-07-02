ESX = nil

local jobBlips = {}
local onDuty = false

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
	ESX.PlayerData.job = job
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
	for _,v in ipairs(jobBlips) do
		RemoveBlip(v)
	end
end

function refreshBlips()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "miner" then
        for k,v in pairs(Config.Miner) do
            local blip = AddBlipForCoord(v.Blip.Coords)

            SetBlipSprite  (blip, v.Blip.Sprite)
            SetBlipScale   (blip, v.Blip.Scale)
            SetBlipCategory(blip, 3)
            SetBlipColour  (blip, v.Blip.Colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.Blip.Name)
            EndTextCommandSetBlipName(blip)

            table.insert(jobBlips, blip)
        end
    end
end

