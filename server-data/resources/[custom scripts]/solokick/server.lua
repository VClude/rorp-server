RegisterServerEvent('sendSession:PlayerNumber')
AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber)
	if source ~= nil then
		local serverPlayerNumber = #GetPlayers()
		if serverPlayerNumber-clientPlayerNumber > 5 then 
			DropPlayer(source, '[Kick] Solo Session') -- Kick player
			print("^1[SOLO-KICK] Server-"..serverPlayerNumber.." / Client-"..clientPlayerNumber.."^0") -- Debug
		end
	end
end)

-- Check for update
local CurrentVersion = [[5.0
]]
PerformHttpRequest('https://raw.githubusercontent.com/chaixshot/fivem/master/solokick/version', function(Error, NewestVersion, Header)
	if CurrentVersion ~= NewestVersion then
		print('\n')
		print('##')
		print('## Solo Kick')
		print('##')
		print('## Current Version: ' .. CurrentVersion)
		print('## Newest Version: ' .. NewestVersion)
		print('##')
		print('## Download')
		print('## https://github.com/chaixshot/fivem/tree/master/solokick')
		print('##')
		print('\n')
	end
end)
