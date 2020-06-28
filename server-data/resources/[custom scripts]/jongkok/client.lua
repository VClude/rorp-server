local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 1, 26, true ) -- INPUT_DUCK
	    DisableControlAction( 0, 36, true ) -- Disable Mode Sneaky     

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 1, 26 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0.2 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.50 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )