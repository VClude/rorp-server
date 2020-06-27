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

-- ======================= Report EMS ===========================

RegisterCommand('emsr', function(source, args, rawCommand)
    if PlayerData.job.name == 'ambulance' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(4)
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

-- ======================= Report Polisi ===========================

RegisterCommand('polisir', function(source, args, rawCommand)
    if PlayerData.job.name == 'police' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(12)
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

-- ======================= Report Pedagang ===========================

RegisterCommand('pedagangr', function(source, args, rawCommand)
    if PlayerData.job.name == 'pedagang' then   
        local source = GetPlayerServerId(PlayerId())
        local name = GetPlayerName(PlayerId())
        local msg = rawCommand:sub(12)
        TriggerServerEvent('pedagangreport', source, msg)
    end
end, false)

RegisterNetEvent('chat:ReportSendPedagang')
AddEventHandler('chat:ReportSendPedagang', function(fal, caller, msg)
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message pedagang">[ PEDAGANG ] {0} : {2} </div>',
        args = {caller, fal, msg}
        });
end)

--==================================================================

-- ======================= Report Bennys ===========================

RegisterCommand('bennysr', function(source, args, rawCommand)
    if PlayerData.job.name == 'bennys' then   
        local source = GetPlayerServerId(PlayerId())
        local msg = rawCommand:sub(12)
        TriggerServerEvent('bennysreport', source, msg)
    end
end, false)

RegisterNetEvent('chat:ReportSendBennys')
AddEventHandler('chat:ReportSendBennys', function(fal, caller, msg)
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message bennys">[ BENNYS ] {0} : {2} </div>',
        args = {caller, fal, msg}
        });
end)

--==================================================================

