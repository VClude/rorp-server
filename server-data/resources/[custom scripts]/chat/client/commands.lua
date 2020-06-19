-- StarBlazt Chat

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = ESX.GetPlayerData()
	end
end)

-- ======================= Chat Untuk EMS ===========================

RegisterCommand('emsreport', function(source, args, rawCommand)
    if PlayerData.job.name == 'ambulance' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(4)
        TriggerServerEvent('chat:server:emsreportsource', source, msg)
        TriggerServerEvent('emsreport', source, msg)
    end
end, false)

RegisterNetEvent('chat:ReportSendEms')
AddEventHandler('chat:ReportSendEms', function(fal, caller, msg)
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">[ EMS ] {0} : {2} </div>',
        args = {caller, fal, msg}
        });
end)

--==================================================================

-- ======================= Chat Untuk EMS ===========================

RegisterCommand('polisreport', function(source, args, rawCommand)
    if PlayerData.job.name == 'police' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(12)
        TriggerServerEvent('chat:server:polisreportsource', source, msg)
        TriggerServerEvent('polisreport', source, msg)
    end
end, false)

RegisterNetEvent('chat:ReportSendPolisi')
AddEventHandler('chat:ReportSendPolisi', function(fal, caller, msg)
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message polisi">[ POLISI ] {0} : {2} </div>',
        args = {caller, fal, msg}
        });
end)

--==================================================================

RegisterCommand('911', function(source, args, rawCommand)
    if PlayerData.job.name == 'ambulance' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local caller = GetPlayerServerId(PlayerId())
        local msg = rawCommand:sub(4)
        TriggerServerEvent('chat:server:911source', source, caller, msg)
        TriggerServerEvent('911', source, caller, msg)
    end
end, false)

RegisterNetEvent('chat:EmergencySend911')
AddEventHandler('chat:EmergencySend911', function(fal, caller, msg)
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message emergency">911 {0} ({1}): {2} </div>',
        args = {caller, fal, msg}
        });
end)

-- RegisterCommand('911r', function(target, args, rawCommand)
--     if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
--         local source = GetPlayerServerId(PlayerId())
--         local target = tonumber(args[1])
--         local msg = rawCommand:sub(8)
--         TriggerServerEvent(('chat:server:911r'), target, source, msg)
--         TriggerServerEvent('911r', target, source, msg)
--     end
-- end, false)



-- RegisterNetEvent('chat:EmergencySend911r')
-- AddEventHandler('chat:EmergencySend911r', function(fal, caller, msg)
--     if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
--         TriggerEvent('chat:addMessage', {
--         template = '<div class="chat-message emergency">911r {0} ({1}): {2} </div>',
--         args = {caller, fal, msg}
--         });
--     end
-- end)
