Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- Disable fungsi sneaking GTA 5
            DisableControlAction( 0, 140, true ) -- Disable fungsi pukul R
        end 
    end
end )
