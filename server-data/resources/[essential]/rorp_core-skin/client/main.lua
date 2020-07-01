ESX = nil
PlayerData = nil
local isSkinCreatorOpened = false		
local cam = -1							
local heading = 332.219879				
local zoom = "visage"					
local isCameraActive, isCameraActiveOld, lastSkinOld
local zoomOffsetOld, camOffsetOld, headingOld = 0.0, 0.0, 90.0
local FirstSpawn     = true
local NewPlayer		 = true
local PlayerLoaded   = false
local PrevHat,PrevGlasses, PrevEars
local gender = 0
local face

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)
------------------------------------------------------------------
--                          NUI
------------------------------------------------------------------

RegisterNUICallback('updateSkin', function(data)
	local playerPed = PlayerPedId()
	v = data.value
		
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			gender = 0
		else
			gender = 1
		end
	end)
	mum = tonumber(data.mum)
	dad = tonumber(data.dad)
	dadmumpercent = tonumber(data.dadmumpercent)
	skin = tonumber(data.skin)
	eyecolor = tonumber(data.eyecolor)
	acne = tonumber(data.acne)
	skinproblem = tonumber(data.skinproblem)
	freckle = tonumber(data.freckle)
	wrinkle = tonumber(data.wrinkle)
	wrinkleopacity = tonumber(data.wrinkleopacity)
	hair = tonumber(data.hair)
	haircolor = tonumber(data.haircolor)
	haircolor2 = tonumber(data.haircolor2)
	lipstick = tonumber(data.lipstick)
	lipstickcolor = tonumber(data.lipstickcolor)
	lipstickopacity = tonumber(data.lipstickopacity)
	blush = tonumber(data.blush)
	blushcolor = tonumber(data.blushcolor)
	blushopacity = tonumber(data.blushopacity)
	makeup = tonumber(data.makeup)
	makeupcolor = tonumber(data.makeupcolor)
	makeupcolor2 = tonumber(data.makeupcolor2)
	makeupopacity = tonumber(data.makeupopacity)
	eyebrow = tonumber(data.eyebrow)
	eyebrowopacity = tonumber(data.eyebrowopacity)
	beard = tonumber(data.beard)
	beardopacity = tonumber(data.beardopacity)
	beardcolor = tonumber(data.beardcolor)
	-- Clothes
	hats = tonumber(data.hats)
	hats_texture = tonumber(data.hats_texture)
	glasses = tonumber(data.glasses)
	glasses_texture = tonumber(data.glasses_texture)
	ears = tonumber(data.ears)
	ears_texture = tonumber(data.ears_texture)
	tops = tonumber(data.tops)
	pants = tonumber(data.pants)
	shoes = tonumber(data.shoes)
	watches = tonumber(data.watches)

	if(v == true) then
		local ped = GetPlayerPed(-1)
		local torso = GetPedDrawableVariation(ped, 3)
		local torsotext = GetPedTextureVariation(ped, 3)
		local leg = GetPedDrawableVariation(ped, 4)
		local legtext = GetPedTextureVariation(ped, 4)
		local shoes = GetPedDrawableVariation(ped, 6)
		local shoestext = GetPedTextureVariation(ped, 6)
		local accessory = GetPedDrawableVariation(ped, 7)
		local accessorytext = GetPedTextureVariation(ped, 7)
		local undershirt = GetPedDrawableVariation(ped, 8)
		local undershirttext = GetPedTextureVariation(ped, 8)
		local torso2 = GetPedDrawableVariation(ped, 11)
		local torso2text = GetPedTextureVariation(ped, 11)
		local prop_hat = GetPedPropIndex(ped, 0)
		local prop_hat_text = GetPedPropTextureIndex(ped, 0)
		local prop_mask = GetPedDrawableVariation(ped, 1)
		local prop_mask_text = 0
		local prop_glasses = GetPedPropIndex(ped, 1)
		local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
		local prop_earrings = GetPedPropIndex(ped, 2)
		local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
		local prop_watches = GetPedPropIndex(ped, 6)
		local prop_watches_text = GetPedPropTextureIndex(ped, 6)
		
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				gender = 0
			else
				gender = 1
			end
		end)
		
		local skin_data = {["sex"]=gender,["face"]=dadmumpercent,["dad"]=dad,["mom"]=mum,["skin"]=skin,["eye_color"]=eyecolor,["complexion_1"]=skinproblem,["complexion_2"]=1,["moles_1"]=freckle,["moles_2"]=1,["age_1"]=wrinkle,["age_2"]=wrinkleopacity,["eyebrows_1"]=eyebrow,["eyebrows_2"]=eyebrowopacity,["beard_1"]=beard,["beard_2"]=beardopacity,["beard_3"]=beardcolor,["beard_4"]=beardcolor,["hair_1"]=hair,["hair_2"]=0,["hair_color_1"]=haircolor,["hair_color_2"]=haircolor2,["lipstick_1"]=lipstick,["lipstick_2"]=lipstickopacity,["lipstick_3"]=lipstickcolor,["lipstick_4"]=lipstickcolor,["blush_1"]=blush,["blush_2"]=blushopacity,["blush_3"]=blushcolor,["makeup_1"]=makeup,["makeup_2"]=makeupopacity,["makeup_3"]=makeupcolor,["makeup_4"]=makeupcolor2,["arms"]=torso,["arms_2"]=torsotext,["pants_1"]=leg,["pants_2"]=legtext,["shoes_1"]=shoes,["shoes_2"]=shoestext,["chain_1"]=accessory,["chain_2"]=accessorytext,["tshirt_1"]=undershirt,["tshirt_2"]=undershirttext,["torso_1"]=torso2,["torso_2"]=torso2text,["helmet_1"]=prop_hat,["helmet_2"]=prop_hat_text,["mask_1"]=0,["mask_2"]=0,["bproof_1"]=0,["bproof_2"]=0,["decals_1"]=0,["decals_2"]=0,["bracelets_1"]=-1,["bracelets_2"]=-1,["bags_1"]=0,["bags_2"]=0,["glasses_1"]=prop_glasses,["glasses_2"]=prop_glasses_text,["ears_1"]=prop_earrings,["ears_2"]=prop_earrings_text,["watches_1"]=prop_watches,["watches_2"]=prop_watches_text}
		
		TriggerServerEvent('esx_skin:save', skin_data)
		
		CloseSkinCreator()
	else


		-- Face
		SetPedHeadBlendData         (GetPlayerPed(-1), dad, mum, nil, skin, skin, skin, dadmumpercent * 0.1, dadmumpercent * 0.1, nil, true);
		
		SetPedEyeColor				(GetPlayerPed(-1), eyecolor)
		if acne == 0 then
			SetPedHeadOverlay		(GetPlayerPed(-1), 0, acne, 0.0)
		else
			SetPedHeadOverlay		(GetPlayerPed(-1), 0, acne, 1.0)
		end
		SetPedHeadOverlay			(GetPlayerPed(-1), 6, skinproblem, 1.0)
		if freckle == 0 then
			SetPedHeadOverlay		(GetPlayerPed(-1), 9, freckle, 0.0)
		else
			SetPedHeadOverlay		(GetPlayerPed(-1), 9, freckle, 1.0)
		end
		
		SetPedHeadOverlay       	(GetPlayerPed(-1), 3, wrinkle, wrinkleopacity * 0.1)
		SetPedComponentVariation	(GetPlayerPed(-1), 2, hair, 0, 2)
		SetPedHairColor				(GetPlayerPed(-1), haircolor, haircolor2)
		SetPedHeadOverlay       	(GetPlayerPed(-1), 2, eyebrow, eyebrowopacity * 0.1) 
		SetPedHeadOverlay       	(GetPlayerPed(-1), 1, beard, beardopacity * 0.1)   
		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 1, 1, beardcolor, beardcolor) 
		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 2, 1, beardcolor, beardcolor)
		SetPedHeadOverlay       	(GetPlayerPed(-1), 8, lipstick, lipstickopacity * 0.1)   	-- Lipstick
		SetPedHeadOverlay       	(GetPlayerPed(-1), 4, makeup, makeupopacity * 0.1) 		-- Makeup
		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 4, 1, makeupcolor, makeupcolor2)      -- Makeup Color
		SetPedHeadOverlayColor  	(GetPlayerPed(-1), 8, 1, lipstickcolor, lipstickcolor)      -- Lipstick Color
		SetPedHeadOverlay			(GetPlayerPed(-1), 5, blush, blushopacity * 0.1)			-- Blush + opacity
		SetPedHeadOverlayColor		(GetPlayerPed(-1), 5, 2, blushcolor)	-- Blush Color
		
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
				SetPedComponentVariation(GetPlayerPed(-1), 4, 61, pants_texture, 2)
				SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 2)
			else
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
				SetPedComponentVariation(GetPlayerPed(-1), 4, 15, pants_texture, 2)
				SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2)
			end
		end)
		-- Unused yet
		-- These presets will be editable in V2 release
		SetPedComponentVariation	(GetPlayerPed(-1), 1,  0,0, 2)    	-- Mask
		SetPedComponentVariation	(GetPlayerPed(-1), 7,  0,0, 2)    	-- Chain
		SetPedComponentVariation	(GetPlayerPed(-1), 5, 0 ,0, 2)
		ClearPedProp(GetPlayerPed(-1), 0)	
		ClearPedProp(GetPlayerPed(-1), 1)
		ClearPedProp(GetPlayerPed(-1), 2)
		ClearPedProp(GetPlayerPed(-1), 6)
	end
end)

-- Character rotation
RegisterNUICallback('rotateleftheading', function(data)
	local currentHeading = GetEntityHeading(GetPlayerPed(-1))
	heading = heading+tonumber(data.value)
end)

RegisterNUICallback('rotaterightheading', function(data)
	local currentHeading = GetEntityHeading(GetPlayerPed(-1))
	heading = heading-tonumber(data.value)
end)

-- Define which part of the body must be zoomed
RegisterNUICallback('zoom', function(data)
	zoom = data.zoom
end)


------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------
function CloseSkinCreator()
	local ped = PlayerPedId()
	isSkinCreatorOpened = false
	ShowSkinCreator(false)
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
	
	-- Player
	SetPlayerInvincible(ped, false)
	TriggerEvent('rorp_character:phase2')
end

function ShowSkinCreator(enable)
local elements    = {}
	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local _components = {}

		for i=1, #components, 1 do
			_components[i] = components[i]
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed,  _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end
	end)
	isCameraActive = true
	SetNuiFocus(enable, enable)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			SendNUIMessage({
				openSkinCreator = enable,
				gender = "muz"
			})
		else
			SendNUIMessage({
				openSkinCreator = enable,
				gender = "zena"
			})
		end
	end)
	
	for index, data in ipairs(elements) do
		local name, Valmax

		for key, value in pairs(data) do
			if key == 'name' then
				name = value
			end
			if key == 'max' then
				Valmax = value
			end
		end
		
		SendNUIMessage({
			type = "updateMaxVal",
			classname = name,
			defaultVal = 0,
			maxVal = Valmax
		})
	end
end

RegisterNetEvent('rorp_core-skin:loadMenu')
AddEventHandler('rorp_core-skin:loadMenu', function()
	ShowSkinCreator(true)
end)

-- Disable Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isCameraActive == true then
			DisableControlAction(2, 14, true)
			DisableControlAction(2, 15, true)
			DisableControlAction(2, 16, true)
			DisableControlAction(2, 17, true)
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true)
			DisableControlAction(0, 24, true)

			local ped = PlayerPedId()
			
			-- Player
			SetPlayerInvincible(ped, true)

			-- Camera
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
			if(not DoesCamExist(cam)) then
				cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
				SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
				SetCamRot(cam, 0.0, 0.0, 0.0)
				SetCamActive(cam,  true)
				RenderScriptCams(true,  false,  0,  true,  true)
				SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
			end
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
			if zoom == "visage" or zoom == "pilosite" then
				SetCamCoord(cam, x+0.2, y+0.5, z+0.7)
				SetCamRot(cam, 0.0, 0.0, 150.0)
			elseif zoom == "vetements" then
				SetCamCoord(cam, x+0.3, y+2.0, z+0.0)
				SetCamRot(cam, 0.0, 0.0, 170.0)
			end
			SetEntityHeading(GetPlayerPed(-1), heading)
		else
			Citizen.Wait(500)
		end
	end

end)

--esx_skin code--
function OpenMenu(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
			for i=1, #components, 1 do
				_components[i] = components[i]
			end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				zoomOffset= _components[i].zoomOffset,
				camOffset = _components[i].camOffset,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end

		CreateSkinCam()
		zoomOffsetOld = _components[1].zoomOffset
		camOffsetOld = _components[1].camOffset

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
			title    = _U('skin_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				lastSkinOld = skin
			end)

			submitCb(data, menu)
			DeleteSkinCam()
		end, function(data, menu)
			menu.close()
			DeleteSkinCam()
			TriggerEvent('skinchanger:loadSkin', lastSkinOld)

			if cancelCb ~= nil then
				cancelCb(data, menu)
			end
		end, function(data, menu)
			local skin, components, maxVals

			TriggerEvent('skinchanger:getSkin', function(getSkin)
				skin = getSkin
			end)

			zoomOffsetOld = data.current.zoomOffset
			camOffsetOld = data.current.camOffset

			if skin[data.current.name] ~= data.current.value then
				-- Change skin element
				TriggerEvent('skinchanger:change', data.current.name, data.current.value)

				-- Update max values
				TriggerEvent('skinchanger:getData', function(comp, max)
					components, maxVals = comp, max
				end)

				local newData = {}

				for i=1, #elements, 1 do
					newData = {}
					newData.max = maxVals[elements[i].name]

					if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
						newData.value = 0
					end

					menu.update({name = elements[i].name}, newData)
				end

				menu.refresh()
			end
		end, function(data, menu)
			DeleteSkinCam()
		end)
	end)
end

function CreateSkinCam()
	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)

	isCameraActiveOld = true
	SetCamRot(cam, 0.0, 0.0, 270.0, true)
	SetEntityHeading(playerPed, 90.0)
end

function DeleteSkinCam()
	isCameraActiveOld = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCameraActiveOld then
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local angle = headingOld * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffsetOld * theta.x),
				y = coords.y + (zoomOffsetOld * theta.y)
			}

			local angleToLook = headingOld - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffsetOld * thetaToLook.x),
				y = coords.y + (zoomOffsetOld * thetaToLook.y)
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffsetOld)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffsetOld)

			ESX.ShowHelpNotification(_U('use_rotate_view'))
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local angle = 90

	while true do
		Citizen.Wait(0)

		if isCameraActiveOld then
			if IsControlPressed(0, 108) then
				angle = angle - 1
			elseif IsControlPressed(0, 109) then
				angle = angle + 1
			end

			if angle > 360 then
				angle = angle - 360
			elseif angle < 0 then
				angle = angle + 360
			end

			headingOld = angle + 0.0
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not playerLoaded do
			Citizen.Wait(100)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	playerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(lastSkinOld)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	lastSkinOld = skin
end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
	OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	ShowSkinCreator(true)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:responseSaveSkin', skin)
	end)
end)

function OpenDefaultMenu(menu)

    local emptyMenu = { { label = 'Empty Menu', action = nil } }

    local elements = {}
    local actions = {}

    for k, v in pairs(getOrElse(menu.options, emptyMenu)) do
        local key = getOrElse(v.value, k)
        table.insert(elements, { label = v.label, value = key })
        actions[key] = v.action
    end

    if menu.onOpen then
        menu.onOpen()
    end

    ESX.UI.Menu.Open(getOrElse(menu.type, 'default'), GetCurrentResourceName(), getOrElse(menu.name, getOrElse(menu.title, 'default-menu-name')), {
        title = getOrElse(menu.title, 'default-menu-title'),
        align = getOrElse(menu.align, 'bottom-right'),
        elements = getOrElse(elements, emptyMenu)
    }, function(data, m)
        if getOrElse(actions[data.current.value], nil) then
            actions[data.current.value](data.current, m)
        else
           exports['mythic_notify']:SendAlert('inform', 'This menu havent action!', 5000)
        end
    end, function(data, m)
        if getOrElse(menu.close, nil) then
            menu.close()
        end
        m.close()
    end, function(data, m)
        if menu.onChange then
            menu.onChange(data, m)
        end
    end)
end

function OpenDialogMenu(menu)
    ESX.UI.Menu.Open(getOrElse(menu.type, 'dialog'), GetCurrentResourceName(), getOrElse(menu.name, getOrElse(menu.title, 'default-menu-name')), {
        title = getOrElse(menu.title, 'default-menu-title'),
        align = getOrElse(menu.align, 'middle')
    },
            function(data, m)
                if getOrElse(menu.action, nil) then
                    menu.action(data.value)
                    m.close()
                else
                   exports['mythic_notify']:SendAlert('inform', 'This menu havent action!', 5000)
                end
            end,
            function(data, m)
                if getOrElse(menu.close, nil) then
                    menu.close()
                end
                m.close()
            end)
end

function OpenListMenu(menu)

    local elements = {
        head = menu.head or {},
        rows = menu.rows or {}
    }

    for k, v in pairs(menu.options) do
        local cols = {}
        for _, v2 in pairs(v) do
            table.insert(cols, v2)
        end
        table.insert(elements.rows, {
            data = v,
            cols = cols
        })
    end

    ESX.UI.Menu.Open('list', GetCurrentResourceName(), menu.name or 'default_list_menu', elements, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end)
end

function OpenConfirmationMenu(menu)
    local options = {
        { label = 'Yes', action = menu.confirmation },
        { label = 'No', action = menu.denial },
    }

    local confirmation = {
        title = 'Confirmation',
        name = 'confirmation_' .. menu.name,
        options = options
    }

    OpenDefaultMenu(confirmation)
end
