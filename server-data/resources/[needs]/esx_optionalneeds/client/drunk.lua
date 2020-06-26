local DRUNK_ACTIVE = false

AddEventHandler('playerSpawned', function()
    
    if STRESS_ACTIVE == false then
        exports.trew_hud_ui:createStatus({
            status = 'drunk',
            color = '#FF00EA',
            icon = '<i class="fas fa-brain"></i>'
        });
        DRUNK_ACTIVE = true
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        local DRUNK_STATUS

        TriggerEvent('esx_status:getStatus', 'drunk', function(status)
            DRUNK_STATUS = status.getPercent()
        end)

        exports.trew_hud_ui:setStatus({
            name = 'drunk',
            value = DRUNK_STATUS
        });
    end
end)