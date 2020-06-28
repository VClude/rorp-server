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

--==================================================================

RegisterNetEvent('chat:bisik')
AddEventHandler('chat:bisik', function(fal, caller, msg)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    if pid == myId then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message bisik">[ BISIK ] {0} : {2} </div>',
        args = {caller, fal, msg}
        });
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 10.0 then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message bisik">[ BISIK ] {0} : {2} </div>',
            args = {caller, fal, msg}
            });
    end
end)


