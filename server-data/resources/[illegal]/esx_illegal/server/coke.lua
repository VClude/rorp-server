local playersProcessingCocaLeaf = {}

RegisterServerEvent('esx_illegal:pickedUpCocaLeaf')
AddEventHandler('esx_illegal:pickedUpCocaLeaf', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local getC = math.random(1,6)
	if xPlayer.canCarryItem('tebu', getC) then
		xPlayer.addInventoryItem('tebu', getC)
	else
		xPlayer.showNotification("Inventory Anda Penuh")
	end
end)


