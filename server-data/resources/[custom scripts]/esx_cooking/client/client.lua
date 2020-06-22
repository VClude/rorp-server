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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

hasProperty = nil
hasProperty1 = nil
hasProperty2 = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if hasProperty == nil and ESX ~= nil then
			ESX.TriggerServerCallback("checkProperty", function(cb) hasProperty = cb end)
		end
		
		if hasProperty1 == nil and ESX ~= nil then
			ESX.TriggerServerCallback("checkProperty1", function(cb) hasProperty1 = cb end)
		end
		
		if hasProperty2 == nil and ESX ~= nil then
			ESX.TriggerServerCallback("checkProperty2", function(cb) hasProperty2 = cb end)
        end
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if hasProperty1 == nil and ESX ~= nil then
			ESX.TriggerServerCallback("checkProperty1", function(cb) hasProperty1 = cb end)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if hasProperty2 == nil and ESX ~= nil then
			ESX.TriggerServerCallback("checkProperty2", function(cb) hasProperty2 = cb end)
        end
    end
end)]]

local orders = {}

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))

		--Property 1
        if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder.x, Config.Zones.FoodOrder.y, Config.Zones.FoodOrder.z, true) < Config.DrawDistance and hasProperty then
            DrawText3Ds(Config.Zones.FoodOrder.x, Config.Zones.FoodOrder.y, Config.Zones.FoodOrder.z + 0., "Press [~g~E~s~] to open the order menu", 0.4)
		end
		       
		if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder.x, Config.Zones.FoodOrder.y, Config.Zones.FoodOrder.z, true) < 1 and hasProperty then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu(true)
			end
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu.x, Config.Zones.KitchenMenu.y, Config.Zones.KitchenMenu.z, true) < Config.DrawDistance and hasProperty then
            DrawText3Ds(Config.Zones.KitchenMenu.x, Config.Zones.KitchenMenu.y, Config.Zones.KitchenMenu.z + 0., "Press [~g~E~s~] to open the kitchen menu", 0.4)
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu.x, Config.Zones.KitchenMenu.y, Config.Zones.KitchenMenu.z, true) < 1 and hasProperty then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu2(true)
			end
		end

		--Property 2
		if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder1.x, Config.Zones.FoodOrder1.y, Config.Zones.FoodOrder1.z, true) < Config.DrawDistance and hasProperty1 then
            DrawText3Ds(Config.Zones.FoodOrder1.x, Config.Zones.FoodOrder1.y, Config.Zones.FoodOrder1.z + 0., "Press [~g~E~s~] to open the order menu", 0.4)
		end
		       
		if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder1.x, Config.Zones.FoodOrder1.y, Config.Zones.FoodOrder1.z, true) < 1 and hasProperty1 then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu(true)
			end
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu1.x, Config.Zones.KitchenMenu1.y, Config.Zones.KitchenMenu1.z, true) < Config.DrawDistance and hasProperty1 then
            DrawText3Ds(Config.Zones.KitchenMenu1.x, Config.Zones.KitchenMenu1.y, Config.Zones.KitchenMenu1.z + 0., "Press [~g~E~s~] to open the kitchen menu", 0.4)
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu1.x, Config.Zones.KitchenMenu1.y, Config.Zones.KitchenMenu1.z, true) < 1 and hasProperty1 then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu2(true)
			end
		end

		--Property 4
		if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder2.x, Config.Zones.FoodOrder2.y, Config.Zones.FoodOrder2.z, true) < Config.DrawDistance and hasProperty2 then
            DrawText3Ds(Config.Zones.FoodOrder2.x, Config.Zones.FoodOrder2.y, Config.Zones.FoodOrder2.z + 0., "Press [~g~E~s~] to open the order menu", 0.4)
		end
		       
		if GetDistanceBetweenCoords(coords, Config.Zones.FoodOrder2.x, Config.Zones.FoodOrder2.y, Config.Zones.FoodOrder2.z, true) < 1 and hasProperty2 then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu(true)
			end
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu2.x, Config.Zones.KitchenMenu2.y, Config.Zones.KitchenMenu2.z, true) < Config.DrawDistance and hasProperty2 then
            DrawText3Ds(Config.Zones.KitchenMenu2.x, Config.Zones.KitchenMenu2.y, Config.Zones.KitchenMenu2.z + 0., "Press [~g~E~s~] to open the kitchen menu", 0.4)
		end

		if GetDistanceBetweenCoords(coords, Config.Zones.KitchenMenu2.x, Config.Zones.KitchenMenu2.y, Config.Zones.KitchenMenu2.z, true) < 1 and hasProperty2 then
			if IsControlJustReleased(0, Keys['E']) then
				OpenMenu2(true)
			end
		end

		--If you want you can add more propertys here
    end
end)

RegisterCommand("accept", function()
	local coords = GetEntityCoords(GetPlayerPed(-1))

	--WildOatsDrive
	if GetDistanceBetweenCoords(coords, Config.Zones.RecieveFood.x, Config.Zones.RecieveFood.y, Config.Zones.RecieveFood.z, true) < 2 then
		for k, v in pairs(orders) do
			TriggerServerEvent("esx_cooking:giveItem", v)
		end

		orders = {}
	end

	--WhispymoundDrive
	if GetDistanceBetweenCoords(coords, Config.Zones.RecieveFood1.x, Config.Zones.RecieveFood1.y, Config.Zones.RecieveFood1.z, true) < 2 then
		for k, v in pairs(orders) do
			TriggerServerEvent("esx_cooking:giveItem", v)
		end

		orders = {}
	end

	--RichardMajesticApt2
	if GetDistanceBetweenCoords(coords, Config.Zones.RecieveFood2.x, Config.Zones.RecieveFood2.y, Config.Zones.RecieveFood2.z, true) < 2 then
		for k, v in pairs(orders) do
			TriggerServerEvent("esx_cooking:giveItem", v)
		end

		orders = {}
	end

	--If you want you can add more propertys here
end)

--Order Menu
function OpenMenu(enable)
    SetNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableui",
        enable = enable,
    })
end

function OpenMenu1(enable1)
    SetNuiFocus(enable1, enable1)
    SendNUIMessage({
        type1 = "enableui1",
        enable1 = enable1,
    })
end

--Kitchen Menu
function OpenMenu2(enable2)
    SetNuiFocus(enable2, enable2)
    SendNUIMessage({
        type2 = "enableui2",
        enable2 = enable2,
    })
end

RegisterNUICallback("close", function()
	OpenMenu(false)
	OpenMenu1(false)
	OpenMenu2(false)
end)

--Order Menu Stuff
--Burger
RegisterNUICallback("buybreadb", function()
	ESX.TriggerServerCallback("checkMoney", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~burger bread~s~." .. " ~y~Please wait for your order~s~.")
			Wait(10000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "breadb")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

RegisterNUICallback("buycheese", function()
	ESX.TriggerServerCallback("checkMoney1", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~cheese~s~." .. " ~y~Please wait for your order~s~.")
			Wait(10000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "cheese")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

RegisterNUICallback("buymeat", function()
	ESX.TriggerServerCallback("checkMoney2", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~meat~s~" .. " ~y~Please wait for your order~s~.")
			Wait(10000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "meat")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

--Hot Dog
RegisterNUICallback("buybreadh", function()
	ESX.TriggerServerCallback("checkMoney", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~hotdog bread~s~." .. " ~y~Please wait for your order~s~.")
			Wait(60000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "breadh")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

RegisterNUICallback("buysausage", function()
	ESX.TriggerServerCallback("checkMoney3", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~sausage~s~." .. " ~y~Please wait for your order~s~.")
			Wait(60000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "sausage")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

--Sandwich
RegisterNUICallback("buybreads", function()
	ESX.TriggerServerCallback("checkMoney", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~sandwich bread~s~." .. " ~y~Please wait for your order~s~.")
			Wait(60000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "breads")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

RegisterNUICallback("buycheese1", function()
	ESX.TriggerServerCallback("checkMoney1", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~cheese~s~." .. " ~y~Please wait for your order~s~.")
			Wait(60000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "cheese")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

RegisterNUICallback("buyham", function()
	ESX.TriggerServerCallback("checkMoney1", function(cb)
		if cb then
			ESX.ShowNotification("~g~You have ordered ~y~1x ~g~ham~s~" .. " ~y~Please wait for your order~s~.")
			Wait(60000)
			ESX.ShowNotification("~g~Your order was been delivered on your door.~s~")
            table.insert(orders, "ham")
		else
			ESX.ShowNotification("~r~You don't have enough money!~s~")
		end
	end)
end)

--Kitchen Menu Stuff

RegisterNUICallback("makeburger", function()
	OpenMenu2(false)
	ESX.TriggerServerCallback("esx_cooking:checkItem", function(cb1)
		if cb1 then
			ESX.ShowNotification("~y~You're preparing your burger~s~")
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
			Wait(2*60000)
			ClearPedTasksImmediately(PlayerPedId())
			TriggerServerEvent("esx_cooking:giveItem1")
		else
			ESX.ShowNotification("~r~You don't have enough ingredients to perpare this food~s~")
		end
	end, "breadb", "cheese", "meat")
end)

RegisterNUICallback("makesandwich", function()
	OpenMenu2(false)
	ESX.TriggerServerCallback("esx_cooking:checkItem", function(cb1)
		if cb1 then
			ESX.ShowNotification("~y~You're preparing your sandwich~s~")
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
			Wait(2*60000)
			ClearPedTasksImmediately(PlayerPedId())
			TriggerServerEvent("esx_cooking:giveItem2")
		else
			ESX.ShowNotification("~r~You don't have enough ingredients to perpare this food~s~")
		end
	end, "breads", "cheese", "ham")
end)

RegisterNUICallback("makehotdog", function()
	OpenMenu2(false)
	ESX.TriggerServerCallback("esx_cooking:checkItem1", function(cb1)
		if cb1 then
			ESX.ShowNotification("~y~You're preparing your hot dog~s~")
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, false)
			Wait(2*60000)
			ClearPedTasksImmediately(PlayerPedId())
			TriggerServerEvent("esx_cooking:giveitem3")
		else
			ESX.ShowNotification("~r~You don't have enough ingredients to perpare this food~s~")
		end
	end, "breadh", "sausage")
end)

RegisterNUICallback("page-prv", function()
	OpenMenu1(false)
	OpenMenu(true)
end)

RegisterNUICallback("page-nxt", function()
	OpenMenu(false)
	OpenMenu1(true)
end)

--DrawText3Ds
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0, 0, 0, 0.0)
end