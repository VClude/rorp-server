ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            ESX.SavePlayer(xPlayer, function(rowsChanged)
                if rowsChanged == 0 then
                    print("Failed saving player " .. tostring(xPlayers[i]))
                end
            end)
        end
        print("Succesfully saved all players.")
        Citizen.Wait(300000)
    end
end)