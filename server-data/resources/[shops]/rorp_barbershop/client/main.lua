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


--                          Variables
------------------------------------------------------------------
ESX = nil
local isBarberCreatorOpened = false		-- Change this value to show/hide UI
local cam = -1							-- Camera control
local heading = 332.219879				-- Heading coord
local zoom = "pilosite"					-- Define which tab is shown first (Default: Head)
local isCameraActive, isCameraActiveOld, lastSkinOld
local zoomOffsetOld, camOffsetOld, headingOld = 0.0, 0.0, 90.0
local NewPlayer		 = true
local PrevHat,PrevGlasses, PrevEars, PrevWatches, PrevMask

--                          SHOP
------------------------------------------------------------------

local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false
local HasLoadCloth			  = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

------------------------------------------------------------------
--                          NUI
------------------------------------------------------------------

RegisterNUICallback('updateSkinSaveBarber', function(data)
	local playerPed = PlayerPedId()
	v = data.value
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
	-- Barbers


	if(v == true) then
		local ped = GetPlayerPed(-1)
			
		TriggerServerEvent('rorp_barbershop:saveBarber', hair, haircolor, haircolor2, eyebrow, eyebrowopacity, beard, beardopacity, beardcolor, lipstick, lipstickcolor, lipstickopacity, blush, blushcolor, blushopacity, makeup, makeupcolor, makeupcolor2, makeupopacity)
		
		CloseBarberCreator()
	else

	
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
function CloseBarberCreator()
	local ped = PlayerPedId()
	isBarberCreatorOpened = false
	ShowBarberCreator(false)
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
	
	-- Player
	SetPlayerInvincible(ped, false)
end

function ShowBarberCreator(enable)
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
				openBarberCreator = enable,
				gender = "male"
			})
		else
			SendNUIMessage({
				openBarberCreator = enable,
				gender = "female"
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

--esx_barberskin code--
function OpenMenuBarber(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict MenuBarber
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

		ESX.UI.MenuBarber.Open('default', GetCurrentResourceName(), 'skin', {
			title    = _U('skin_MenuBarber'),
			align    = 'top-left',
			elements = elements
		}, function(data, MenuBarber)
			TriggerEvent('skinchanger:getSkin', function(skin)
				lastSkinOld = skin
			end)

			submitCb(data, MenuBarber)
			DeleteSkinCam()
		end, function(data, MenuBarber)
			MenuBarber.close()
			DeleteSkinCam()
			TriggerEvent('skinchanger:loadSkin', lastSkinOld)

			if cancelCb ~= nil then
				cancelCb(data, MenuBarber)
			end
		end, function(data, MenuBarber)
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

					MenuBarber.update({name = elements[i].name}, newData)
				end

				MenuBarber.refresh()
			end
		end, function(data, MenuBarber)
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

function OpenSaveableMenuBarber(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	OpenMenuBarber(function(data, MenuBarber)
		MenuBarber.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_barberskin:save', skin)

			if submitCb ~= nil then
				submitCb(data, MenuBarber)
			end
		end)

	end, cancelCb, restrict)
end

RegisterNetEvent('rorp_barbershop:openSaveableMenuBarber')
AddEventHandler('rorp_barbershop:openSaveableMenuBarber', function(submitCb, cancelCb)
	ShowBarberCreator(true)
end)

function OpenBarberShopMenu()

  TriggerEvent(“dpc:EquipLast”)
  
  local price = Config.Price
  
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'shop_barber',
    {
      title = _U('shop_barber'),
	  align    = 'bottom-right',
      elements = {
        { label = _U('yes') .. ' (<span style="color:red">$' .. price .. '</span>)', value = 'yes' },
        { label = _U('no'), value = 'no' },
      }
    },
    function (data, menu)
      if data.current.value == 'yes' then
        TriggerServerEvent('rorp_barbershop:buycosmetics', price)
      end
      menu.close()
    end,
    function (data, menu)
      menu.close()
    end
  )

end

AddEventHandler('rorp_barbershop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

AddEventHandler('rorp_barbershop:hasExitedMarker', function(zone)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

end)

-- Create Blips
Citizen.CreateThread(function()

	for i=1, #Config.Shops, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 71)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('barbers'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('rorp_barbershop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('rorp_barbershop:hasExitedMarker', LastZone)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then

				if CurrentAction == 'shop_menu' then
					OpenBarberShopMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end

		end

	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        if GetEntityHealth(playerPed) <= 0 and isBarberCreatorOpened == true then
			CloseBarberCreator()
		end
    end
end)

