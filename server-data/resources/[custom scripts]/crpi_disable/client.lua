local crouched = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end


local gates = {
	"p_barier_test_s",
	"prop_sec_barier_01a",
	"prop_sec_barier_02a",
	"prop_sec_barier_02b",
	"prop_sec_barier_03a",
	"prop_sec_barier_03b",
	"prop_sec_barier_04a",
	"prop_sec_barier_04b",
	"prop_sec_barier_base_01",
	"prop_sec_barrier_ld_01a",
	"prop_sec_barrier_ld_02a"
}

RegisterCommand('stuck', function(source)
	ESX.UI.Menu.CloseAll()
	SetNuiFocus(false, false)
end,false)

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

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(100)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    end
end)

-- Citizen.CreateThread(function()

--     while true do
--         if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
--             SetUserRadioControlEnabled(false)
--         end
--         Citizen.Wait(0)
--     end

-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)

Citizen.CreateThread(function()
   while true do
		for a = 1, #gates do
			local player = PlayerId()
			local plyPed = GetPlayerPed(player)
			local plyPos = GetEntityCoords(plyPed, false)
			local gate = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 100.0, GetHashKey(gates[a]), 0, 0, 0)
			if gate ~= 0 then
				SetEntityAsMissionEntity(gate, 1, 1)
				DeleteObject(gate)
				SetEntityAsNoLongerNeeded(gate)
			end
		end
	   Citizen.Wait(5000)
   end
end)

----------------------------------------------------------------------------
--DANO ARMAS (E SOCO) MELEE ///// MELEE AND WEAPONS DAMAGE 
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.1) 
    	Wait(0)
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.1) 
    	Wait(0)
    end
end)
----------------------------------------------------------------------------
--DANO CORONHADA //// PISTOL WHIPPING
----------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)
