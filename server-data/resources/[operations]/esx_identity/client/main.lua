local guiEnabled, hasIdentity, isDead = false, false, false
local myIdentity, myIdentifiers = {}, {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

function EnableGui(state)
	SetNuiFocus(state, state)
	guiEnabled = state

	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end

RegisterNetEvent('esx_identity:showRegisterIdentity')
AddEventHandler('esx_identity:showRegisterIdentity', function()
	if not isDead then
		EnableGui(true)
	end
end)

RegisterNetEvent('esx_identity:identityCheck')
AddEventHandler('esx_identity:identityCheck', function(identityCheck)
	hasIdentity = identityCheck
end)

RegisterNetEvent('esx_identity:saveID')
AddEventHandler('esx_identity:saveID', function(data)
	myIdentifiers = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
	else
		ESX.ShowNotification(_U('create_a_character'))
	end
end)

RegisterNUICallback('register', function(data, cb)
	local reason = ""
	myIdentity = data
	for theData, value in pairs(myIdentity) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)
			
			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Invalid date of birth!"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Unacceptable player height!"
					break
				end
			else
				reason = "Unacceptable player height!"
				break
			end
		end
	end
	
	if reason == "" then
		SetEntityCoords(PlayerPedId(), -1036.02, -2737.04, 19.2, 0.0, 0.0, 0.0, true)
		TriggerServerEvent('esx_identity:setIdentity', data, myIdentifiers)
		EnableGui(false)
		Citizen.Wait(500)
		local skinfemale = {["tshirt_2"]=0,["eyebrows_2"]=10,["eye_color"]=2,["watches_1"]=6,["ears_2"]=-1,["lipstick_4"]=35,["moles_1"]=0,["mom"]=21,["chain_1"]=0,["mask_1"]=0,["hair_1"]=4,["bags_1"]=0,["lipstick_3"]=35,["age_2"]=0,["ears_1"]=-1,["hair_color_1"]=35,["bracelets_1"]=-1,["torso_1"]=207,["makeup_2"]=4,["glasses_2"]=-1,["glasses_1"]=-1,["watches_2"]=1,["bags_2"]=0,["face"]=10,["arms_2"]=0,["arms"]=11,["dad"]=0,["beard_2"]=0,["skin"]=12,["sex"]=1,["age_1"]=0,["blush_1"]=0,["shoes_2"]=1,["beard_1"]=0,["moles_2"]=1,["complexion_1"]=0,["makeup_4"]=35,["hair_color_2"]=35,["makeup_1"]=6,["torso_2"]=0,["helmet_2"]=-1,["tshirt_1"]=2,["lipstick_1"]=0,["mask_2"]=0,["eyebrows_1"]=0,["shoes_1"]=1,["chain_2"]=0,["blush_2"]=0,["bracelets_2"]=-1,["pants_2"]=1,["helmet_1"]=-1,["makeup_3"]=20,["pants_1"]=0,["hair_2"]=0,["complexion_2"]=1,["lipstick_2"]=10}
		local skinmale = {["age_1"]=0,["makeup_2"]=0,["eyebrows_1"]=0,["helmet_1"]=-1,["lipstick_3"]=0,["tshirt_2"]=0,["sex"]=0,["helmet_2"]=-1,["bracelets_1"]=-1,["glasses_2"]=-1,["eye_color"]=2,["arms"]=4,["makeup_3"]=0,["tshirt_1"]=15,["lipstick_2"]=0,["chain_2"]=0,["hair_color_1"]=4,["beard_1"]=0,["moles_2"]=1,["face"]=0,["moles_1"]=0,["watches_1"]=-1,["beard_3"]=0,["glasses_1"]=-1,["dad"]=0,["shoes_1"]=1,["arms_2"]=0,["hair_2"]=0,["watches_2"]=-1,["mom"]=21,["pants_1"]=25,["complexion_1"]=0,["ears_2"]=-1,["hair_1"]=2,["pants_2"]=0,["beard_2"]=5,["age_2"]=0,["lipstick_4"]=0,["torso_1"]=171,["bags_2"]=0,["blush_3"]=32,["beard_4"]=0,["lipstick_1"]=0,["blush_1"]=0,["mask_2"]=0,["shoes_2"]=0,["chain_1"]=0,["makeup_4"]=0,["skin"]=12,["mask_1"]=0,["eyebrows_2"]=10,["blush_2"]=0,["ears_1"]=-1,["torso_2"]=0,["makeup_1"]=0,["hair_color_2"]=4,["bags_1"]=0,["bracelets_2"]=-1,["complexion_2"]=1}
		if data.sex == 'F' then
		TriggerEvent('skinchanger:loadSkin', skinfemale)
		elseif data.sex == 'M' then
		TriggerEvent('skinchanger:loadSkin', skinmale)
		end
		Citizen.Wait(500)
		TriggerEvent('esx_skin:openSaveableMenu', myIdentifiers.id)
	else
		ESX.ShowNotification(reason)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if guiEnabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'Your player name is either too short or too long.'
	end
	
	-- Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Your player name contains special characters that are not allowed on this server.'
	end
	
	-- Does the player carry a first and last name?
	-- 
	-- Example:
	-- Allowed:     'Bob Joe'
	-- Not allowed: 'Bob'
	-- Not allowed: 'Bob joe'
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return 'Your name contains more than two spaces'
	end
	
	if spacesWithUpper ~= spacesInName then
		return 'your name must start with a capital letter.'
	end

	return ''
end
