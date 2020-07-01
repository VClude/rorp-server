ESX = nil
local isDead = false
local isVip = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	if ESX ~= nil then
		ESX.TriggerServerCallback('esx_billing:getVip', function(vip)
			if vip then
				isVip = true
			end
	end)
	end
end)

function ShowBillsMenu()
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		if #bills > 0 then
			ESX.UI.Menu.CloseAll()
			local elements = {}

			for k,v in ipairs(bills) do
				local vipprice = (isVip) and v.amount * 0.8 or v.amount
				table.insert(elements, {
					label  = ('%s - <span style="color:red;">%s</span>'):format(v.label, _U('invoices_item', ESX.Math.GroupDigits(vipprice))),
					billId = v.id
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
				title    = _U('invoices'),
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				menu.close()

				ESX.TriggerServerCallback('esx_billing:payBill', function()
					ShowBillsMenu()
				end, data.current.billId)
			end, function(data, menu)
				menu.close()
			end)
		else
			ESX.ShowNotification(_U('no_invoices'))
		end
	end)
end

RegisterCommand('showbills', function()
	if not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
		ShowBillsMenu()
	end
end, false)

-- RegisterKeyMapping('showbills', _U('keymap_showbills'), 'keyboard', 'F7')

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('playerSpawned', function(spawn) isDead = false end)
