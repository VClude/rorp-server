ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rorp_daftarwarga:addKTP')
AddEventHandler('rorp_daftarwarga:addKTP', function(type,jmlhUang)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_license:addLicense', _source, type)
	TriggerClientEvent('esx:showNotification', _source, (_U('test_berhasil')))
	Citizen.Wait(2000)
	xPlayer.addMoney(jmlhUang)
	TriggerClientEvent('esx:showNotification', _source, (_U('uang_subsidi', ESX.Math.GroupDigits(jmlhUang))))

end)