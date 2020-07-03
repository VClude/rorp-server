Citizen.CreateThread(function()
local blips = AddBlipForRadius(355.28, 5623.84, 700.15 , 3500.0) 

SetBlipHighDetail(blips, true)
SetBlipColour(blips, 1)
SetBlipAlpha (blips, 128)
end)

Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(728565169982275636) --Discord app id
		SetDiscordRichPresenceAsset('webps') --Big picture asset name
		SetDiscordRichPresenceAssetText('Republic of Roleplay') --Big picture hover text
		SetDiscordRichPresenceAssetSmall('webps')
		Citizen.Wait(600000) --How often should this script check for updated assets? (in MS)
	end
end)
--No Need to mess with anything pass this point!
Citizen.CreateThread(function()
    while true do
        SetRichPresence(GetNumberOfPlayers() .. "/64 Online")
		Citizen.Wait(10000)
	end
end)