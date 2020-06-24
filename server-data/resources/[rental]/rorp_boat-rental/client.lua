local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX          = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local haveboat = false

Citizen.CreateThread(function()

	if not Config.EnableBlips then return end
	
	for _, info in pairs(Config.BlipZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, 410)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.2)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerZones) do
			DrawMarker(Config.TypeMarker, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0, 0, 0, 0, 0, 0, 1.000, 2.000, 1.000, 255, 120, 255, 100, 0, false, 2, true,false,false,false)	
		end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.40 then
				if haveboat == false then

					helptext(_U('press_e'))
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBoatsMenu()
					end 
				elseif haveboat == true then

					-- helptext(_U('storeboat'))

					if IsControlJustPressed(0, Keys['E']) then

						ESX.ShowNotification('Tolong kembalikan perahu sebelumnya')
						-- if IsPedOnVehicle(ped) then

						-- 	TriggerEvent('esx:deleteVehicle')
						-- 	ESX.ShowNotification(_U('boatmessage'))
						-- 	haveboat = false

						-- else
							
						-- end
					end 		
				end
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerReturnZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerReturnZones[k].x, Config.MarkerReturnZones[k].y, Config.MarkerReturnZones[k].z)
            if distance <= 1.40 then
				if haveboat == true then
					helptext(_U('storeboat'))

					if IsControlJustPressed(0, Keys['E']) then						
						if IsPedOnVehicle(ped) then

							TriggerEvent('esx:deleteVehicle')
							ESX.ShowNotification(_U('boatmessage'))
							haveboat = false
							
						end
					end 		
				end
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)



function OpenBoatsMenu()
	
	local elements = {}
	
	table.insert(elements, {label = _U('boat'), value = 'boat'}) 
	table.insert(elements, {label = _U('boat2'), value = 'boat2'}) 
	table.insert(elements, {label = _U('boat3'), value = 'boat3'}) 
	table.insert(elements, {label = _U('boat4'), value = 'boat4'})
	table.insert(elements, {label = _U('boat5'), value = 'boat5'}) 
	
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = _U('boattitle'),
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)

	if data.current.value == 'boat' then
		TriggerServerEvent("rorp_boat-rental:lowmoney", Config.Seashark)
		ESX.ShowNotification('Anda telah membayar : Rp. ~y~'..Config.Seashark)
		local veh = CreateVehicle("seashark",-712.24,-1339.78,-0.41,136.88,true,false)
		SetPedIntoVehicle (PlayerPedId(-1),veh,-1)
	end
	
	if data.current.value == 'boat2' then
		TriggerServerEvent("rorp_boat-rental:lowmoney", Config.Dinghy)
		ESX.ShowNotification('Anda telah membayar : Rp. ~y~'..Config.Dinghy)
		local veh = CreateVehicle("dinghy",-712.24,-1339.78,-0.41,136.88,true,false)
		SetPedIntoVehicle (PlayerPedId(-1),veh,-1)
	end

	if data.current.value == 'boat3' then
		TriggerServerEvent("rorp_boat-rental:lowmoney", Config.Jetmax)
		ESX.ShowNotification('Anda telah membayar : Rp. ~y~'..Config.Jetmax)
		local veh = CreateVehicle("jetmax",-712.24,-1339.78,-0.41,136.88,true,false)
		SetPedIntoVehicle (PlayerPedId(-1),veh,-1)
	end
	
	if data.current.value == 'boat4' then
		TriggerServerEvent("rorp_boat-rental:lowmoney", Config.Marquis)
		ESX.ShowNotification('Anda telah membayar : Rp. ~y~'..Config.Marquis)
		local veh = CreateVehicle("marquis",-712.24,-1339.78,-0.41,136.88,true,false)
		SetPedIntoVehicle (PlayerPedId(-1),veh,-1)
	end
	
	if data.current.value == 'boat5' then
		TriggerServerEvent("rorp_boat-rental:lowmoney", Config.Tug)
		ESX.ShowNotification('Anda telah membayar : Rp. ~y~'..Config.Tug)
		local veh = CreateVehicle("tug",-712.24,-1339.78,-0.41,136.88,true,false)
		SetPedIntoVehicle (PlayerPedId(-1),veh,-1)
	end

	ESX.UI.Menu.CloseAll()
	haveboat = true	
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end


function helptext(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end