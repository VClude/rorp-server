local open = false
local ESX = nil

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

-- Melihat lisensi senjata
RegisterCommand('menuident', function()
	menuIdentitas()
end,false)


function menuIdentitas()

	local elements = {}

	table.insert(elements, {label = ('KTP'), value = 'ktp'}) 
	table.insert(elements, {label = ('SIM'), value = 'sim'}) 
	table.insert(elements, {label = ('Lisensi Senjata'), value = 'lisensi'}) 

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'client',
		{

		title    = ('Menu Identitas'),
		align    = 'bottom-right',
		elements = elements,

		},

		function(data,menu)

			if data.current.value == "ktp" then

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menu_ktp',
					{
						title    = ('Menu KTP'),
						align    = 'bottom-right',
						elements = {

							{label = ('Melihat KTP'), value = 'ktp1'},
							{label = ('Menunjukan KTP'), value = 'ktp2'},

						}
					},
					function(data2,menu2)

						if data2.current.value == "ktp1" then

							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasKTP)
								if hasKTP then
									TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
									ESX.UI.Menu.CloseAll()
								else
									ESX.ShowNotification('Belum memiliki KTP')
								end
							end, GetPlayerServerId(PlayerId()), 'KTP')
						
						else

							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasKTP)
								if hasKTP then
									local player, distance = ESX.Game.GetClosestPlayer()

									if distance ~= -1 and distance <= 3.0 then
										TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
										ExecuteCommand('me Menunjukan KTP')
										ESX.UI.Menu.CloseAll()
									else
										ESX.ShowNotification('Tidak ada orang disekitar')
										ESX.UI.Menu.CloseAll()
									end
								else
									ESX.ShowNotification('Belum memiliki KTP')
								end
							end, GetPlayerServerId(PlayerId()), 'KTP')

						end

					end,
					function(data2,menu2)
						menu2.close()
					end
				)
			
			elseif data.current.value == "sim" then

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menu_sim',
					{
						title    = ('Menu SIM'),
						align    = 'bottom-right',
						elements = {

							{label = ('Melihat SIM'), value = 'sim1'},
							{label = ('Menunjukan SIM'), value = 'sim2'},

						}
					},
					function(data2,menu2)

						if data2.current.value == "sim1" then

							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
							ESX.UI.Menu.CloseAll()
						
						else

							local player, distance = ESX.Game.GetClosestPlayer()

							if distance ~= -1 and distance <= 3.0 then
							  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
							  ExecuteCommand('me Menunjukan SIM')
							  ESX.UI.Menu.CloseAll()
							else
							  ESX.ShowNotification('Tidak ada orang disekitar')
							  ESX.UI.Menu.CloseAll()
							end

						end

					end,
					function(data2,menu2)
						menu2.close()
					end
				)

			elseif data.current.value == "lisensi" then

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menu_lisensi',
					{
						title    = ('Menu Lisensi'),
						align    = 'bottom-right',
						elements = {

							{label = ('Melihat Lisensi'), value = 'lisensi1'},
							{label = ('Menunjukan Lisensi'), value = 'lisensi2'},

						}
					},
					function(data2,menu2)

						if data2.current.value == "lisensi1" then

							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
							ESX.UI.Menu.CloseAll()
						
						else

							local player, distance = ESX.Game.GetClosestPlayer()

							if distance ~= -1 and distance <= 3.0 then
							  TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
							  ExecuteCommand('me Menunjukan Lisensi')
							  ESX.UI.Menu.CloseAll()
							else
							  ESX.ShowNotification('Tidak ada orang disekitar')
							  ESX.UI.Menu.CloseAll()
							end

						end

					end,
					function(data2,menu2)
						menu2.close()
					end
				)

			end

		end,
		function(data, menu)
			menu.close()
		end

	)

end