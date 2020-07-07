-- RegisterServerEvent('sendSession:PlayerNumber')
-- AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber)
-- 	if source ~= nil then
-- 		local serverPlayerNumber = #GetPlayers()
-- 		if serverPlayerNumber-clientPlayerNumber > 5 then 
-- 			DropPlayer(source, '[Kick] Solo Session') -- Kick player
-- 			print("^1[SOLO-KICK] Server-"..serverPlayerNumber.." / Client-"..clientPlayerNumber.."^0") -- Debug
-- 		end
-- 	end
-- end)

-- -- Check for update
-- local CurrentVersion = [[5.0
-- ]]
-- PerformHttpRequest('https://raw.githubusercontent.com/chaixshot/fivem/master/solokick/version', function(Error, NewestVersion, Header)
-- 	if CurrentVersion ~= NewestVersion then
-- 		print('\n')
-- 		print('##')
-- 		print('## Solo Kick')
-- 		print('##')
-- 		print('## Current Version: ' .. CurrentVersion)
-- 		print('## Newest Version: ' .. NewestVersion)
-- 		print('##')
-- 		print('## Download')
-- 		print('## https://github.com/chaixshot/fivem/tree/master/solokick')
-- 		print('##')
-- 		print('\n')
-- 	end
-- end)

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()

    -- mandatory wait!
    Wait(0)

    deferrals.update(string.format("Hello %s. Your Steam ID is being checked.", name))

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    -- mandatory wait!
    Wait(0)

    if not steamIdentifier then
        deferrals.done("You are not connected to Steam.")
    else
        deferrals.done()
    end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)