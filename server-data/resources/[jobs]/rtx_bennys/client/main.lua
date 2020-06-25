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


ESX                           = nil
local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentlyTowedVehicle, Blips = nil, {}
local NPCTargetDeleterZone =  false
local isDead, isBusy = false, false
local PlayerData              = {}
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentTask             = {}
local isInMarker  = false
local registed = false
local inArea = false
local state = false
local currentZone = nil
local GUI           = {}
GUI.Time = 0

local currentlyItem = false
local currentlyCrafting = false
local currentlyGetTire = false

local CurrentAction, CurrentActionPos, CurrentActionMsg, CurrentActionData = nil, "", {}

local Blips = {}

local isDead, isBusy = false, false

local spawnedVehicles, isInShopMenu = {}, false

local Vehicles =		{}
local lsMenuIsShowed	= false
local isInLSMarker		= false
local myCar				= {}
local holdingPackage          = false
local disabledWeapons         = false
local APPbone	= 0
local APPx 		= 0.0
local APPy 		= 0.0
local APPz 		= 0.0
local APPxR 	= 0.0
local APPyR 	= 0.0
local APPzR 	= 0.0
local dropkey 	= 161 -- Key to drop/get the props
local closestEntity = 0

local Interior = GetInteriorAtCoords(-210.08, -1318.142, 30.89)

LoadInterior(Interior)

Citizen.CreateThread( function()
	while ESX == nil do 	
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)	
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
--------------------------------------- MECHANIC JOB ---------------------------------------
---------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("esx_bennysjob:hasEnteredMarker", function(zone)

	if zone == "Cloakrooms" then
		CurrentAction = "cloakrooms_menu"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Bennys Cloakroom"
		CurrentActionData = {}
	elseif zone == "BossMenu" then
		CurrentAction = "boss_menu"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Boss Menu"
		CurrentActionData = {}
	elseif zone == "InventoryMenu" then
		CurrentAction = "bennys_inventory_menu"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Inventory"
		CurrentActionData = {}											
	elseif zone == "ls1" then
		CurrentAction = "ls_custom"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk custom bodykit"
		CurrentActionData = {}		
	elseif zone == "ls2" then
		CurrentAction = "ls_custom"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk cat kendaraan"
		CurrentActionData = {}	
	elseif zone == "ls3" then
		CurrentAction = "ls_custom"
		CurrentActionMsg = "Tekan ~b~[E]~w~ untuk upgrade mesin"
		CurrentActionData = {}
	end
end)

AddEventHandler("esx_bennysjob:hasExitedMarker", function(zone)

		CurrentAction = nil
		if not isInShopMenu then
		  ESX.UI.Menu.CloseAll()
		end
end)



-- Create Blips

Citizen.CreateThread( function()

	local blip = AddBlipForCoord(-210.27520751953, -1320.5799560547, 29.890365600586)
	SetBlipSprite(blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.2)
	SetBlipColour(blip, 48)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Benny's Original Motor Works")
	EndTextCommandSetBlipName(blip)

end)



-- Display markers

Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true
			for k, v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					if k == "Vehicles" then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, true, false, false, false)
					else
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					end
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil

			for k, v in pairs(Config.Zones) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					CurrentActionPos = v.Pos
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent("esx_bennysjob:hasEnteredMarker", currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent("esx_bennysjob:hasExitedMarker", LastZone)
			end
		end
	end
end)

-- function openMechanicPropsMenu()

--   ESX.UI.Menu.Open(
--     'default', GetCurrentResourceName(), 'bennysprops_actions',
--     {
--       title    = 'Props',
--       align    = 'bottom-right',
-- 		elements = {
-- 			{label = '1', value = 'prop1'},
-- 			{label = '2', value = 'prop2'},
-- 			{label = '3', value = 'prop3'},
-- 			{label = 'Odstranit', value = 'odstraniitprop'},
-- 		}
--     },

-- 	function(data, menu)
-- 		local val = data.current.value
		
-- 		if val == 'prop1' then
-- 			TriggerEvent("attach:prop_cs_trolley_01")
-- 		elseif val == 'prop2' then
-- 			TriggerEvent("attach:prop_engine_hoist")
-- 		elseif val == 'prop3' then
-- 			TriggerEvent("attach:prop_tool_box_04")
-- 		elseif val == 'odstraniitprop' then
-- 			TriggerEvent("rtx_bennys:removeall")
-- 			DeleteEntity(closestEntity)
-- 		end
-- 	end,
-- 	function(data, menu)
-- 		menu.close()
-- 		OpenMobileMechanicActionsMenu()
-- 	end
-- )
-- end



function NotifInformasi(text)
	exports['mythic_notify']:SendAlert('inform', text, 5000)
end

function NotifSukses(text)
	exports['mythic_notify']:SendAlert('success', text, 5000)
end

function NotifError(text)
	exports['mythic_notify']:SendAlert('error', text, 5000)
end

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(2)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" then
			if CurrentAction then
				DrawText3Ds(CurrentActionPos.x, CurrentActionPos.y, CurrentActionPos.z, CurrentActionMsg)
				if IsControlJustReleased(0, Keys["E"]) then
					if CurrentAction == "cloakrooms_menu" then
						OpenCloakRoomsMenu()
					elseif CurrentAction == "boss_menu" then
						if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name == 'boss' then
							OpenBossMenu()
						else
							NotifInformasi('Tidak memiliki akses boss menu')
						end						
					elseif CurrentAction == "bennys_inventory_menu" then
						if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name ~= 'magang' and ESX.PlayerData.job.grade_name ~= 'karyawan_bengkel' then						
							OpenBennysInventoryMenu()
						else
							NotifInformasi('Anda tidak memiliki akses membuka inventory')
						end							
					elseif CurrentAction == 'ls_custom' then
						if  ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name ~= 'magang' then						
							OpenLSAction()
						else
							NotifInformasi('Pengalaman anda kurang untuk modifikasi kendaraan')
						end
					end
					CurrentAction = nil
				end
			end
			if ( IsControlJustReleased( 0, 167 ) or IsDisabledControlJustReleased( 0, 167 ) ) and GetLastInputMethod( 0 ) and not IsDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'mobile_mechanic_actions') and (GetGameTimer() - GUI.Time) > 150 then
				OpenMobileMechanicActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)



AddEventHandler("esx:onPlayerDeath",
	function(data)
		isDead = true
	end
)



AddEventHandler("playerSpawned",
	function(spawn)
		isDead = false
	end
)

function OpenBossMenu()

	local elements = {
		{label = "Manajemen Bennys", value = "bennys_manage"},
		{label = "Daftar Lisensi", value = "reg_license"}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"manajemen_bennys",
		{
			title = "Bennys Management",
			align = "top-left",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "bennys_manage" then
				TriggerEvent('esx_society:openBossMenu', 'bennys',function (data, menu)
					menu.close()
				end,{wash = false})
			elseif data.current.value == "reg_license" then
				OpenRegLicense()
			end
		end,
		function(data, menu)
			menu.close()
			CurrentAction = "boss_menu"
			CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Boss Menu"
			CurrentActionData = {}
		end)
end

function OpenRegLicense()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'register_license', {
		title = ('Player ID')
	}, function(data, menu)
			local count = tonumber(data.value)

			if count == nil then
				ESX.ShowNotification('Player tidak ada')
			else
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasRepairLicense)
					if hasRepairLicense then
						menu.close()
						ESX.ShowNotification('Player ini sudah memiliki ~b~Repair License')
						Citizen.Wait(1000)
					else
						menu.close()
						TriggerServerEvent('esx_license:addLicense', count, 'repair')
						NotifSukses('Berhasil memberikan Lisensi')
						Citizen.Wait(1000)
					end
				end, GetPlayerServerId(PlayerId(count)), 'repair')
			end
		end, function(data, menu)
			 menu.close()
	end)
end

function OpenBennysInventoryMenu()

	local elements = {
		{label = "Deposit Barang", value = "deposit"},
		{label = "Ambil Barang", value = "withdraw"}
	}
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"bennys_inventory",
		{
			title = "Bennys Inventory",
			align = "bottom-right",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "deposit" then
				OpenPutStocksMenu()
			elseif data.current.value == "withdraw" then
				OpenGetStocksMenu()
			end
		end,
		function(data, menu)
			menu.close()
			CurrentAction = "bennys_inventory_menu"
			CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Bennys Inventory"
			CurrentActionData = {}
		end)
end


function OpenCloakRoomsMenu()
	local elements = {
		{label = "Baju Kerja", value = "working"},
		{label = "Baju Sipil", value = "citizen"}
	}
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"bennys_cloakrooms",
		{
			title = "Bennys Cloakroom",
			align = "bottom-right",
			elements = elements
		},
		function(data, menu)
			if data.current.value == "citizen" then
				menu.close()
				ESX.TriggerServerCallback(
					"esx_skin:getPlayerSkin",
					function(skin, jobSkin)
						TriggerEvent("skinchanger:loadSkin", skin)
					end)
			else
				menu.close()
				setUniform(data.current.value, PlayerPedId())
			end

			CurrentAction = "cloakrooms_menu"
			CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Bennys Cloakroom"
			CurrentActionData = {}
		end,
		function(data, menu)
			menu.close()
			CurrentAction = "cloakrooms_menu"
			CurrentActionMsg = "Tekan ~b~[E]~w~ untuk membuka Bennys Cloakroom"
			CurrentActionData = {}
		end)
end



function setUniform(job, playerPed)

	TriggerEvent("skinchanger:getSkin", function(skin)

		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent("skinchanger:loadClothes", skin, Config.Uniforms[job].male)
			else
				NotifError("Pakaian tidak tersedia!")
			end
		else
			if Config.Uniforms[job].female then
				TriggerEvent("skinchanger:loadClothes", skin, Config.Uniforms[job].female)
			else
				NotifError("Pakaian tidak tersedia!")
			end
		end
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('rtx_bennys:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = 'Bennys Inventory',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('rtx_bennys:putStockItems', itemName, count)

					Citizen.Wait(1000)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('rtx_bennys:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = 'Bennys Inventory',
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('rtx_bennys:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end


function OpenMobileMechanicActionsMenu()

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open("default", GetCurrentResourceName(), "mobile_mechanic_actions",
		{
			title = "Menu Bennys",
			align = "bottom-right",
			elements = {
				{label = "Tagihan", value = "billing"},
				{label = "Perbaiki Kendaraan", value = "fix_vehicle"},
				{label = "Cuci Kendaraan", value = "clean_vehicle"},			
				{label = "Ganti Ban", value = "ganti_ban"},				
			}
		},

		function(data, menu)
			if isBusy then
				return
			end

			if data.current.value == "billing" then
				ESX.UI.Menu.Open( "dialog", GetCurrentResourceName(), "billing",
					{
						title = "Jumlah Tagihan"
					},
					function(data, menu)
						local amount = tonumber(data.value)

						if amount == nil or amount < 0 then
							NotiError("Jumlah Salah!")
						else

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								NotifError("Tidak ada orang di sekitar!")
							else

								menu.close()
								TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(closestPlayer), "society_mechanic", "Benny's", amount)
							end
						end
					end,

					function(data, menu)
						menu.close()
					end
				)				
			elseif data.current.value == "ganti_ban" then	
				menu.close()
				gantiBan()
				
			elseif data.current.value == "fix_vehicle" then
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)

				if IsPedSittingInAnyVehicle(playerPed) then
					NotifInformasi("Tidak boleh di dalam kendaraan!")
					return
				end

				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

					TriggerEvent( "mythic_progbar:client:progress",
						{
							name = "fixing_vehicle",
							duration = 15000,
							label = "Perbaiki Kendaraan...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},

						function(status)
							ClearPedTasksImmediately(playerPed)
							isBusy = false
							if not status then
								SetVehicleFixed(vehicle)
								SetVehicleDeformationFixed(vehicle)
								SetVehicleBodyHealth(vehicle, 1000.00)
								SetVehicleEngineHealth(vehicle, 1000.00)
								SetVehicleUndriveable(vehicle, false)
								SetVehicleEngineOn(vehicle, true, true)
								NotifSukses("Kendaraan sukses diperbaiki!")
							end
						end
					)
				else
					NotifError("Tidak ada kendaraan!")
				end
					
			elseif data.current.value == "clean_vehicle" then
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)

				if IsPedSittingInAnyVehicle(playerPed) then
					NotifInformasi("Tidak boleh di dalam kendaraan!")
					return
				end

				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
					TriggerEvent( "mythic_progbar:client:progress",
						{
							name = "cleaning_vehicle",
							duration = 5000,
							label = "Mencuci Kendaraan...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},

						function(status)
							ClearPedTasksImmediately(playerPed)
							isBusy = false
							if not status then
								SetVehicleDirtLevel(vehicle, 0)
								ClearPedTasksImmediately(playerPed)
								NotifSukses("Kendaraan telah dicuci!")
							end
						end
					)
				else
					NotifError("Tidak ada kendaraan!")
				end
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end


function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(6)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenLSAction()
	if IsControlJustReleased(0, 38) and not lsMenuIsShowed then
		if ((PlayerData.job ~= nil and PlayerData.job.name == 'bennys') or Config.IsMechanicJobOnly == false) then
			lsMenuIsShowed = true
			local coords 		= GetEntityCoords(GetPlayerPed(-1))
			local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 71)
			if (vehicle ~= nil) then
				FreezeEntityPosition(vehicle, true)
				FreezeEntityPosition(GetPlayerPed(-1), true)
				myCar = ESX.Game.GetVehicleProperties(vehicle)
				ESX.UI.Menu.CloseAll()
				GetAction({value = 'main'})
			end
		end
	end
	if isInLSMarker and not hasAlreadyEnteredMarker then
		hasAlreadyEnteredMarker = true
	end
	if not isInLSMarker and hasAlreadyEnteredMarker then
		hasAlreadyEnteredMarker = false
	end

end

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)


---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------LSCUSTOM--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	ESX.TriggerServerCallback('esx_bennysjob:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx_bennysjob:installMod')
AddEventHandler('esx_bennysjob:installMod', function()
	local coords 		= GetEntityCoords(GetPlayerPed(-1))
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('esx_bennysjob:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('esx_bennysjob:cancelInstallMod')
AddEventHandler('esx_bennysjob:cancelInstallMod', function()
	local coords 		= GetEntityCoords(GetPlayerPed(-1))
	local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
	ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'bottom-right',
		elements = elems
	}, function(data, menu)
		local isRimMod = false
		local found = false
		local coords 		= GetEntityCoords(GetPlayerPed(-1))
		local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end
		RegisterLS()
		for k,v in pairs(Config.Menus) do
			if k == data.current.modType or isRimMod then
				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
					TriggerEvent('esx_bennysjob:installMod')
				else
					local vehiclePrice = 80000
					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end
					if data.current.price ~= nil then
						if isRimMod then
							price = math.floor(vehiclePrice * data.current.price / 100)
							TriggerServerEvent("esx_bennysjob:buyMod", price)
						elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
							price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
							TriggerServerEvent("esx_bennysjob:buyMod", price)
						elseif v.modType == 17 then
							price = math.floor(vehiclePrice * v.price[1] / 100)
							TriggerServerEvent("esx_bennysjob:buyMod", price)
						else
							price = math.floor(vehiclePrice * v.price / 100)
							TriggerServerEvent("esx_bennysjob:buyMod", price)
						end
					end
				end
				menu.close()
				found = true
				break
			end
		end
		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('esx_bennysjob:cancelInstallMod')
		local playerPed = PlayerPedId()
		local coords 		= GetEntityCoords(GetPlayerPed(-1))
		local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
		SetVehicleDoorsShut(vehicle, false)
		if parent == nil then
			lsMenuIsShowed = false
			local coords 		= GetEntityCoords(GetPlayerPed(-1))
			local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
			FreezeEntityPosition(vehicle, false)
			FreezeEntityPosition(GetPlayerPed(-1), false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function DrawText3Ds(x, y, z, text)

	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextFont(6)
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 240
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 150)
end

function UpdateMods(data)
	local coords 		= GetEntityCoords(GetPlayerPed(-1))
	local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
	if data.modType ~= nil then
		local props = {}
		
		if data.wheelType then
			props['wheels'] = data.wheelType
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'neonColor' then
			if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
				props['neonEnabled'] = { false, false, false, false }
			else
				props['neonEnabled'] = { true, true, true, true }
			end
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		elseif data.modType == 'tyreSmokeColor' then
			props['modSmokeEnabled'] = true
			ESX.Game.SetVehicleProperties(vehicle, props)
			props = {}
		end
		props[data.modType] = data.modNum
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

function GetAction(data)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil
	local playerPed = PlayerPedId()
	local coords 		= GetEntityCoords(GetPlayerPed(-1))
	local vehicle  		= GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, false, 23)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)
	FreezeEntityPosition(vehicle, true)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	myCar = currentMods
	if data.value == 'modSpeakers' or
		data.value == 'modTrunk' or
		data.value == 'modHydrolic' or
		data.value == 'modEngineBlock' or
		data.value == 'modAirFilter' or
		data.value == 'modStruts' or
		data.value == 'modTank' then
		SetVehicleDoorOpen(vehicle, 4, false)
		SetVehicleDoorOpen(vehicle, 5, false)
	elseif data.value == 'modDoorSpeaker' then
		SetVehicleDoorOpen(vehicle, 0, false)
		SetVehicleDoorOpen(vehicle, 1, false)
		SetVehicleDoorOpen(vehicle, 2, false)
		SetVehicleDoorOpen(vehicle, 3, false)
	else
		SetVehicleDoorsShut(vehicle, false)
	end
	local vehiclePrice = 80000
	for i=1, #Vehicles, 1 do
		if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
			vehiclePrice = Vehicles[i].price
			break
		end
	end
	RegisterLS()
	for k,v in pairs(Config.Menus) do
		if data.value == k then
			menuName  = k
			menuTitle = v.label
			parent    = v.parent
			if v.modType ~= nil then
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
 				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end
				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = math.floor(vehiclePrice * v.price / 100)
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = math.floor(vehiclePrice * v.price / 100)
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}
					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)
					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName ~= nil then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				else
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName ~= nil then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end
	table.sort(elements, function(a, b)
		return a.label < b.label
	end)
	OpenLSMenu(elements, menuName, menuTitle, parent)
end


function Nearbywheel(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local minDistance = 1.5
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local vehicle = Nearbywheelvehicle()
		if vehicle ~= 0 then
			local closestTire = Nearbywheel(vehicle)
			if closestTire ~= nil then
				if IsVehicleTyreBurst(vehicle, closestTire.tireIndex, 0) == false then
					Citizen.Wait(1500)
				else
					DrawText3Ds(closestTire.bonePos.x, closestTire.bonePos.y, closestTire.bonePos.z, "Ban Bocor")
				end
			end
		end
	end
end)

function Nearbywheelvehicle()
	local plyPed = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.0, 0.0)
	local radius = 0.3
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, plyPed, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function gantiBan()
	FreezeEntityPosition(GetPlayerPed(-1), false)
	menggantiBan = true
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_rub_tyre_01'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.11, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	while menggantiBan do
		Citizen.Wait(250)
		local vehicle   = Nearbywheelvehicle()
		local coords    = GetEntityCoords(GetPlayerPed(-1))
		local playerPed = PlayerPedId()
		LoadDict('anim@heists@box_carry@')
	
		if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and menggantiBan == true then
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
			TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end
		
		if DoesEntityExist(vehicle) then
			menggantiBan = false
			ClearPedTasks(GetPlayerPed(-1))
			DeleteEntity(prop)
			isBusy = true
			TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
			TriggerEvent( "mythic_progbar:client:progress",
				{
					name = "wheelchange_vehicle",
					duration = 15000,
					label = "Mengganti Ban...",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true
					}
				},
				function(status)
					ClearPedTasksImmediately(playerPed)
					isBusy = false
					if not status then
						local closestTire = Nearbywheel(vehicle)
						if closestTire ~= nil then
							SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
							ClearPedTasksImmediately(playerPed)
							NotifSukses("Ban telah terganti!")
						end

					end

				end
			)
		end
	end
end


function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

-- Blip on Map for Car Garages:
Citizen.CreateThread(function()
	if Config.EnableCarGarageBlip == true then	
		for k,v in pairs(Config.CarZones) do
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite(blip, Config.CarGarageSprite)
				SetBlipDisplay(blip, Config.CarGarageDisplay)
				SetBlipScale  (blip, Config.CarGarageScale)
				SetBlipColour (blip, Config.CarGarageColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.CarGarageName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end	
end)

local insideMarker = false

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.MechanicDatabaseName) then
			for k,v in pairs(Config.CarZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 10.0) and insideMarker == false then
						DrawMarker(Config.MechanicCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.MechanicCarMarkerScale.x, Config.MechanicCarMarkerScale.y, Config.MechanicCarMarkerScale.y, Config.MechanicCarMarkerColor.r,Config.MechanicCarMarkerColor.g,Config.MechanicCarMarkerColor.b,Config.MechanicCarMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 2.5 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.CarDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then
							MechanicGarage('car')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end
		end
	end
end)

-- Mechanic Garage Menu:
MechanicGarage = function(type)
	local elements = {
		{ label = Config.LabelStoreVeh, action = "store_vehicle" },
		{ label = Config.LabelGetVeh, action = "get_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_MechanicGarage_menu",
		{
			title    = Config.TitleMechanicGarage,
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local action = data.current.action
		if action == "get_vehicle" then
			if type == 'car' then
				VehicleMenu('car')
			end
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				ESX.ShowNotification(Config.VehicleParked)
			else
				ESX.ShowNotification(Config.NoVehicleNearby)
			end
			insideMarker = false
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu:
VehicleMenu = function(type)
	local storage = nil
	local elements = {}
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	if type == 'car' then
		if ESX.PlayerData.job.grade_name == 'magang' then
				table.insert(elements,{label = 'Tidak ada kendaraan'})
		elseif ESX.PlayerData.job.grade_name == 'karyawan_bengkel' then
			for k,v in pairs(Config.MechanicVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
			end
		elseif ESX.PlayerData.job.grade_name == 'karyawan_senior' then
			for k,v in pairs(Config.MechanicVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
			end
		elseif ESX.PlayerData.job.grade_name == 'kepala_staff' then
			for k,v in pairs(Config.MechanicVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
			end
		elseif ESX.PlayerData.job.grade_name == 'boss' then
			for k,v in pairs(Config.MechanicVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
			end
		end
	end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_MechanicGarage_vehicle_garage",
		{
			title    = Config.TitleMechanicGarage,
			align    = "bottom-right",
			elements = elements
		},
	function(data, menu)
		menu.close()
		insideMarker = false
		local plate = exports['t1ger_cardealer']:ProduceNumberPlate()
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)

		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
		TriggerEvent("carremote:grantKeys", veh)
		
		if type == 'car' then
			ESX.ShowNotification(Config.CarOutFromPolGar)
		end
		
		exports["LegacyFuel"]:SetFuel(veh, 100.0)
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Load Timer Function for Vehicle Spawn:
function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name == "boss" then
			for k,v in pairs(Config.PickupItems) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if distance <= 20.0 and not currentlyItem then
					
				DrawMarker(-1, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.ItemMarkerScale.x, Config.ItemMarkerScale.y, Config.ItemMarkerScale.z, Config.ItemMarkerColor.r,Config.ItemMarkerColor.g,Config.ItemMarkerColor.b,Config.ItemMarkerColor.a, false, true, 2, true, false, false, false)
										
				else
					Citizen.Wait(1000)
				end	
				if distance <= 1.0 and not currentlyItem then
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawItem3DText)
					if IsControlJustPressed(0, Config.KeyToStartItem) then
						GetItemEvent()	
					end
				end
			end
		end		
	end
end)

function GetItemEvent()
	
	currentlyItem = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)	
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)

	TriggerEvent("mythic_progbar:client:progress",
		{
		name = "get_items",
		duration = 15000,
		label = "Mengambil Bahan...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true
		},
		animation = {
            task = "PROP_HUMAN_BUM_BIN",
        },
        prop = {

		},
	},
	
	function(status)
		if not status then
			ESX.TriggerServerCallback("rtx_bennys:checkSpaceForFixtool",function(hasSpace)
				if hasSpace then
					TriggerServerEvent("rtx_bennys:reward",'fixtool',5)
					ClearPedTasks(playerPed)
					currentlyItem = false
				else
					ESX.ShowNotification("Inventory kamu sudah penuh")
					ClearPedTasks(playerPed)
					currentlyItem = false
				end					
			end)
		end
	end)
end


-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name == "boss" then
			for k,v in pairs(Config.CraftItems) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if distance <= 20.0 and not currentlyCrafting then
					
				DrawMarker(Config.CraftMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.CraftMarkerScale.x, Config.CraftMarkerScale.y, Config.CraftMarkerScale.z, Config.CraftMarkerColor.r,Config.CraftMarkerColor.g,Config.CraftMarkerColor.b,Config.CraftMarkerColor.a, false, true, 2, true, false, false, false)
										
				else
					Citizen.Wait(1000)
				end	
				if distance <= 1.0 and not currentlyCrafting then
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawCraft3DText)
					if IsControlJustPressed(0, Config.KeyToStartCraft) then
						CraftingEvent()	
					end
				end
			end
		end		
	end
end)

function CraftingEvent()
	
	currentlyCrafting = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)	
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)

	ESX.TriggerServerCallback("rtx_bennys:removeFixtool", function(fixtoolcount)
		if fixtoolcount then
			TriggerEvent("mythic_progbar:client:progress",
				{
				name = "craft_repairkit",
				duration = 20000,
				label = "Membuat RepairKit...",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true
				},
				animation = {
					animDict = "missmechanic",
					anim = "work2_base",
				},
				prop = {

				},
			},			
			function(status)
				if not status then
					ESX.TriggerServerCallback("rtx_bennys:checkSpaceForFixkit", function(hasSpace)
						if hasSpace then
							TriggerServerEvent("rtx_bennys:reward",'fixkit',1)
							ClearPedTasks(playerPed)
							currentlyCrafting = false
						else
							ESX.ShowNotification("Inventory kamu sudah penuh")
							Citizen.Wait(1000)
							TriggerServerEvent("rtx_bennys:reward",'fixtool',2)
							ClearPedTasks(playerPed)
							currentlyCrafting = false				
						end
					end)					
				end
			end)
		else
			ESX.ShowNotification("Kamu membutuhkan ~y~2x Fix Tool~s~ untuk membuat ~b~1x RepairKit~s~!")
			currentlyCrafting = false
		end
	end)
end

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if ESX.PlayerData.job and ESX.PlayerData.job.name == "bennys" and ESX.PlayerData.job.grade_name ~= "magang" then
			for k,v in pairs(Config.Tires) do
				local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if distance <= 20.0 and not currentlyGetTire then
					
				DrawMarker(Config.TireMarker, v.Pos.x, v.Pos.y, v.Pos.z-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.TireMarkerScale.x, Config.TireMarkerScale.y, Config.TireMarkerScale.z, Config.TireMarkerColor.r,Config.TireMarkerColor.g,Config.TireMarkerColor.b,Config.TireMarkerColor.a, false, true, 2, true, false, false, false)
										
				else
					Citizen.Wait(1000)
				end	
				if distance <= 1.0 and not currentlyGetTire then
					DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, Config.DrawTire3DText)
					if IsControlJustPressed(0, Config.KeyToStartTire) then
						GetTireEvent()	
					end
				end
			end
		end		
	end
end)

function GetTireEvent()
	
	currentlyGetTire = true
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)	
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)

	TriggerEvent("mythic_progbar:client:progress",
		{
		name = "getting_tire",
		duration = 5000,
		label = "Mengambil Ban...",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true
		},
		animation = {

		},
		prop = {

		},
	},			
	function(status)
		if not status then
			ESX.TriggerServerCallback("rtx_bennys:checkSpaceForTire", function(hasSpace)
				if hasSpace then
					TriggerServerEvent("rtx_bennys:reward",'ban',1)
					ClearPedTasks(playerPed)
					currentlyGetTire = false
				else
					ESX.ShowNotification("Inventory kamu sudah penuh")
					ClearPedTasks(playerPed)
					currentlyGetTire = false				
				end
			end)					
		end
	end)
end

--////////////////////////////////////////
-- USABLE ITEM
--///////////////////////////////////////
RegisterNetEvent('rtx_bennys:GantiBan')
AddEventHandler('rtx_bennys:GantiBan', function()

	local playerPed = PlayerPedId()
	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasrepairLicense)
		if hasrepairLicense then

			FreezeEntityPosition(GetPlayerPed(-1), false)
			bancadangan = true
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			prop = CreateObject(GetHashKey('prop_rub_tyre_01'), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.025, 0.11, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
			while bancadangan do
				Citizen.Wait(250)
				local vehicle   = Nearbywheelvehicle()
				local coords    = GetEntityCoords(GetPlayerPed(-1))
				local playerPed = PlayerPedId()
				LoadDict('anim@heists@box_carry@')
			
				if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 3 ) and bancadangan == true then
					SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
					TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
				
				if DoesEntityExist(vehicle) then
					ESX.ShowNotification("Kamu menggunakan ~y~Ban")
					bancadangan = false
					ClearPedTasks(GetPlayerPed(-1))
					DeleteEntity(prop)
					isBusy = true
					TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
					TriggerEvent("mythic_progbar:client:progress",
						{

							name = "wheelchange_vehicle",
							duration = 15000,
							label = "Mengganti ban..",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},

						function(status)
							ClearPedTasksImmediately(playerPed)
							isBusy = false
							if not status then
								local closestTire = Nearbywheel(vehicle)
								if closestTire ~= nil then
									SetVehicleTyreFixed(vehicle, closestTire.tireIndex)
									ClearPedTasksImmediately(playerPed)
									TriggerServerEvent('rtx_bennys:removeItem','ban', 1)
									NotifSukses("Ban telah diganti!")
								end
							end
						end)
				end
			end		
		else
			NotifError("Tidak memiliki lisensi")
		end
	end, GetPlayerServerId(PlayerId()), 'repair')
end)

RegisterNetEvent('rtx_bennys:RepairWithFixkit')
AddEventHandler('rtx_bennys:RepairWithFixkit', function()

	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'))
		return
	end

	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasRepairLicense)
		if hasRepairLicense then

			if DoesEntityExist(vehicle) then
				isBusy = true
				ESX.ShowNotification("Kamu menggunakan ~y~Repair Kit")
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					TriggerEvent("mythic_progbar:client:progress",
						{
							name = "fixing_vehicle",
							duration = 15000,
							label = "Perbaiki Kendaraan...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true
							}
						},
						function(status)
							ClearPedTasksImmediately(playerPed)
							isBusy = false
							if not status then
								SetVehicleFixed(vehicle)
								SetVehicleDeformationFixed(vehicle)
								SetVehicleBodyHealth(vehicle, 1000.00)
								SetVehicleEngineHealth(vehicle, 1000.00)
								SetVehicleUndriveable(vehicle, false)
								SetVehicleEngineOn(vehicle, true, true)
								NotifSukses("Kendaraan sukses diperbaiki!")
								TriggerServerEvent('rtx_bennys:removeItem','fixkit',1)
							end
					end)				
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		else
			NotifError("Tidak memiliki lisensi")
		end
	end, GetPlayerServerId(PlayerId()), 'repair')
end)
