local Keys = {
	["ESC"] = 322,
	["F1"] = 288,
	["F2"] = 289,
	["F3"] = 170,
	["F5"] = 166,
	["F6"] = 167,
	["F7"] = 168,
	["F8"] = 169,
	["F9"] = 56,
	["F10"] = 57,
	["~"] = 243,
	["1"] = 157,
	["2"] = 158,
	["3"] = 160,
	["4"] = 164,
	["5"] = 165,
	["6"] = 159,
	["7"] = 161,
	["8"] = 162,
	["9"] = 163,
	["-"] = 84,
	["="] = 83,
	["BACKSPACE"] = 177,
	["TAB"] = 37,
	["Q"] = 44,
	["W"] = 32,
	["E"] = 38,
	["R"] = 45,
	["T"] = 245,
	["Y"] = 246,
	["U"] = 303,
	["P"] = 199,
	["["] = 39,
	["]"] = 40,
	["ENTER"] = 18,
	["CAPS"] = 137,
	["A"] = 34,
	["S"] = 8,
	["D"] = 9,
	["F"] = 23,
	["G"] = 47,
	["H"] = 74,
	["K"] = 311,
	["L"] = 182,
	["LEFTSHIFT"] = 21,
	["Z"] = 20,
	["X"] = 73,
	["C"] = 26,
	["V"] = 0,
	["B"] = 29,
	["N"] = 249,
	["M"] = 244,
	[","] = 82,
	["."] = 81,
	["LEFTCTRL"] = 36,
	["LEFTALT"] = 19,
	["SPACE"] = 22,
	["RIGHTCTRL"] = 70,
	["HOME"] = 213,
	["PAGEUP"] = 10,
	["PAGEDOWN"] = 11,
	["DELETE"] = 178,
	["LEFT"] = 174,
	["RIGHT"] = 175,
	["TOP"] = 27,
	["DOWN"] = 173,
	["NENTER"] = 201,
	["N4"] = 108,
	["N5"] = 60,
	["N6"] = 107,
	["N+"] = 96,
	["N-"] = 97,
	["N7"] = 117,
	["N8"] = 61,
	["N9"] = 118
}
local CharPed1 = nil
local CharPed2 = nil
local CharPed3 = nil
local CharPed4 = nil
local characterskin1 = nil
local characterskin2 = nil
local characterskin3 = nil
local characterskin4 = nil

ESX = nil

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
		end
	end
)

function startAnimAction(lib, anim)

	ESX.Streaming.RequestAnimDict(

		lib,

		function()

			TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)

		end

	)

end

RegisterNetEvent("rtx_doplnky:mainmenu")
AddEventHandler(
	"rtx_doplnky:mainmenu",
	function()
		OpenAccessoryMenu()
	end
)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"doplnky_menu",
		{
			title = "Accessories",
			align = "bottom-right",
			elements = {
				{label = "Hats", value = "cepice"},
				{label = "Ears", value = "usi"},
				
				{label = "Chains", value = "krk"},
				{label = "Masks", value = "Masks"},
				{label = "Glasses", value = "bryle"},
				{label = "Watches", value = "hodinky",},
				
				{label = "Bracelets", value = "naramky",},
				
				{label = "Bags", value = "tasky",}
			}
		},
		function(data, menu)
			menu.close()
			if data.current.value == "cepice" then
				OpenHatsMenu()
			elseif data.current.value == "usi" then
				OpenEarsMenu()
			elseif data.current.value == "Masks" then
				OpenMasksMenu()
			elseif data.current.value == "bryle" then
				OpenGlassesMenu()
			elseif data.current.value == "hodinky" then
				OpenWatchesMenu()
			elseif data.current.value == "naramky" then
				OpenBraceletMenu()
			elseif data.current.value == "tasky" then
				OpenBagsMenu()
			elseif data.current.value == "krk" then
				OpenChainsMenu()				
			end
		end,
		function(data, menu)
			TriggerEvent("rtx_interakce:Menu")
			menu.close()
		end
	)
end
function OpenGlassesMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"glasses_menu",

		{

			title = "Glasses",

			align = "bottom-right",

			elements = {

				{label = "Glasses", value = "brylenlist"},
				
				{label = "Take off Glasses", value = "brylesundat"},

				{label = "Add Glasses", value = "brylepridat"},

				{label = "Remove Glasses", value = "bryleodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "brylenlist" then
				ShowChangeBryle()
			elseif data.current.value == "brylesundat" then
				SundatBryle()
			elseif data.current.value == "brylepridat" then
				ShowSaveBryle()
			elseif data.current.value == "bryleodstranit" then
				ShowRemoveBryle()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end
function ShowChangeBryle()
    ESX.TriggerServerCallback('rtx_doplnky:getBryle', function(doplnekbryle)
        local options = {}

        for k, v in pairs(doplnekbryle) do
            v.action = function()
                ZmenitBryle(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'brylelist',
            title = 'Glasses',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatBryle()
	startAnimAction("clothingspecs", "try_glasses_positive_a")
	Citizen.Wait(1000)
	ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_glasses = -1
		local prop_glasses_text = -1
		ClearPedProp(GetPlayerPed(-1), 1)
		TriggerServerEvent('rtx_doplnky:saveaktualnibryle', prop_glasses, prop_glasses_text)
    end)
end


function ZmenitBryle(doplnekbryle, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekBryle', skin, doplnekbryle)
		
		local ped = GetPlayerPed(-1)
		local prop_glasses = GetPedPropIndex(ped, 1)
		local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
		TriggerServerEvent('rtx_doplnky:saveaktualnibryle', prop_glasses, prop_glasses_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveBryle()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveBryle
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveBryle(value)
    local ped = GetPlayerPed(-1)
	local prop_glasses = GetPedPropIndex(ped, 1)
	local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
	
	local skin_data = {["glasses_1"]=prop_glasses,["glasses_2"]=prop_glasses_text}
	
    TriggerServerEvent('rtx_doplnky:saveBryle', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveBryle()
    ESX.TriggerServerCallback('rtx_doplnky:getBryle', function(doplnekbryle)
        local options = {}

        for k, v in pairs(doplnekbryle) do
            v.action = function()
                RemoveBryle(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_bryle',
            title = 'Remove glasses',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveBryle(label)
    TriggerServerEvent('rtx_doplnky:removeBryle', label)
    ESX.UI.Menu.CloseAll()
end

function OpenWatchesMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"watches_menu",

		{

			title = "Watches",

			align = "bottom-right",

			elements = {

				{label = "Watches", value = "hodinkynlist"},
				
				{label = "Take off watches", value = "hodinkysundat"},

				{label = "Add watches", value = "hodinkypridat"},

				{label = "Remove watches", value = "hodinkyodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "hodinkynlist" then
				ShowChangeHodinky()
			elseif data.current.value == "hodinkysundat" then
				SundatHodinky()
			elseif data.current.value == "hodinkypridat" then
				ShowSaveHodinky()
			elseif data.current.value == "hodinkyodstranit" then
				ShowRemoveHodinky()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeHodinky()
    ESX.TriggerServerCallback('rtx_doplnky:getHodinky', function(doplnekhodinky)
        local options = {}

        for k, v in pairs(doplnekhodinky) do
            v.action = function()
                ZmenitHodinky(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'hodinkylist',
            title = 'Watches',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatHodinky()
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_watches = -1
		local prop_watches_text = -1
		ClearPedProp(GetPlayerPed(-1), 6)
		TriggerServerEvent('rtx_doplnky:saveaktualnihodinky', prop_watches, prop_watches_text)
    end)
end


function ZmenitHodinky(doplnekhodinky, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekHodinky', skin, doplnekhodinky)
		
		local ped = GetPlayerPed(-1)
		local prop_watches = GetPedPropIndex(ped, 6)
		local prop_watches_text = GetPedPropTextureIndex(ped, 6)
		TriggerServerEvent('rtx_doplnky:saveaktualnihodinky', prop_watches, prop_watches_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveHodinky()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveHodinky
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveHodinky(value)
    local ped = GetPlayerPed(-1)
	local prop_watches = GetPedPropIndex(ped, 6)
	local prop_watches_text = GetPedPropTextureIndex(ped, 6)
	
	local skin_data = {["watches_1"]=prop_watches,["watches_2"]=prop_watches_text}
	
    TriggerServerEvent('rtx_doplnky:saveHodinky', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveHodinky()
    ESX.TriggerServerCallback('rtx_doplnky:getHodinky', function(doplnekhodinky)
        local options = {}

        for k, v in pairs(doplnekhodinky) do
            v.action = function()
                RemoveHodinky(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_hodinky',
            title = 'Remove watches',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveHodinky(label)
    TriggerServerEvent('rtx_doplnky:removeHodinky', label)
    ESX.UI.Menu.CloseAll()
end

function OpenMasksMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"mask_menu",

		{

			title = "Masks",

			align = "bottom-right",

			elements = {

				{label = "Masks", value = "Masksnlist"},
				
				{label = "Take off mask", value = "Maskssundat"},

				{label = "Add mask", value = "Maskspridat"},

				{label = "Remove mask", value = "Masksodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "Masksnlist" then
				ShowChangeMasks()
			elseif data.current.value == "Maskssundat" then
				SundatMasks()
			elseif data.current.value == "Maskspridat" then
				ShowSaveMasks()
			elseif data.current.value == "Masksodstranit" then
				ShowRemoveMasks()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeMasks()
    ESX.TriggerServerCallback('rtx_doplnky:getMasks', function(doplnekMasks)
        local options = {}

        for k, v in pairs(doplnekMasks) do
            v.action = function()
                ZmenitMasks(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'Maskslist',
            title = 'Masks',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatMasks()
	startAnimAction("missfbi4", "takeoff_mask")
	Citizen.Wait(1000)
	ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_mask = -1
		local prop_mask_text = -1
		SetPedComponentVariation	(GetPlayerPed(-1), 1,  0,0, 2)
		TriggerServerEvent('rtx_doplnky:saveaktualniMasks', prop_mask, prop_mask_text)
    end)
end


function ZmenitMasks(doplnekMasks, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekMasks', skin, doplnekMasks)
		
		local ped = GetPlayerPed(-1)
		local prop_mask = GetPedDrawableVariation(ped, 1)
		local prop_mask_text = GetPedTextureVariation(ped, 1)
		TriggerServerEvent('rtx_doplnky:saveaktualniMasks', prop_mask, prop_mask_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveMasks()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveMasks
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveMasks(value)
    local ped = GetPlayerPed(-1)
	local prop_mask = GetPedDrawableVariation(ped, 1)
	local prop_mask_text = GetPedTextureVariation(ped, 1)
	
	local skin_data = {["mask_1"]=prop_mask,["mask_2"]=prop_mask_text}
	
    TriggerServerEvent('rtx_doplnky:saveMasks', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveMasks()
    ESX.TriggerServerCallback('rtx_doplnky:getMasks', function(doplnekMasks)
        local options = {}

        for k, v in pairs(doplnekMasks) do
            v.action = function()
                RemoveMasks(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_Masks',
            title = 'Remove',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveMasks(label)
    TriggerServerEvent('rtx_doplnky:removeMasks', label)
    ESX.UI.Menu.CloseAll()
end

function OpenEarsMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"ears_menu",

		{

			title = "Ears",

			align = "bottom-right",

			elements = {

				{label = "Ears", value = "usinlist"},
				
				{label = "Take off ear", value = "usisundat"},

				{label = "Add ear", value = "usipridat"},

				{label = "Remove ear", value = "usiodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "usinlist" then
				ShowChangeUsi()
			elseif data.current.value == "usisundat" then
				SundatUsi()
			elseif data.current.value == "usipridat" then
				ShowSaveUsi()
			elseif data.current.value == "usiodstranit" then
				ShowRemoveUsi()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeUsi()
    ESX.TriggerServerCallback('rtx_doplnky:getUsi', function(doplnekusi)
        local options = {}

        for k, v in pairs(doplnekusi) do
            v.action = function()
                ZmenitUsi(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'usilist',
            title = 'Ears',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatUsi()
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_earrings = -1
		local prop_earrings_text = -1
		ClearPedProp(GetPlayerPed(-1), 2)
		TriggerServerEvent('rtx_doplnky:saveaktualniusi', prop_earrings, prop_earrings_text)
    end)
end


function ZmenitUsi(doplnekusi, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekUsi', skin, doplnekusi)
		
		local ped = GetPlayerPed(-1)
		local prop_earrings = GetPedPropIndex(ped, 2)
		local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
		TriggerServerEvent('rtx_doplnky:saveaktualniusi', prop_earrings, prop_earrings_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveUsi()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveUsi
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveUsi(value)
    local ped = GetPlayerPed(-1)
	local prop_earrings = GetPedPropIndex(ped, 2)
	local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
	
	local skin_data = {["ears_1"]=prop_earrings,["ears_2"]=prop_earrings_text}
	
    TriggerServerEvent('rtx_doplnky:saveUsi', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveUsi()
    ESX.TriggerServerCallback('rtx_doplnky:getUsi', function(doplnekusi)
        local options = {}

        for k, v in pairs(doplnekusi) do
            v.action = function()
                RemoveUsi(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_usi',
            title = 'Remove ear',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveUsi(label)
    TriggerServerEvent('rtx_doplnky:removeUsi', label)
    ESX.UI.Menu.CloseAll()
end

function OpenHatsMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"hats_menu",

		{

			title = "hats",

			align = "bottom-right",

			elements = {

				{label = "hats", value = "cepicenlist"},
				
				{label = "Take off hat", value = "cepicesundat"},

				{label = "Add hat", value = "cepicepridat"},

				{label = "Remove hat", value = "cepiceodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "cepicenlist" then
				ShowChangeCepice()
			elseif data.current.value == "cepicesundat" then
				SundatCepice()
			elseif data.current.value == "cepicepridat" then
				ShowSaveCepice()
			elseif data.current.value == "cepiceodstranit" then
				ShowRemoveCepice()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeCepice()
    ESX.TriggerServerCallback('rtx_doplnky:getCepice', function(doplnekcepice)
        local options = {}

        for k, v in pairs(doplnekcepice) do
            v.action = function()
                ZmenitCepice(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'cepicelist',
            title = 'hats',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatCepice()
	startAnimAction("missfbi4", "takeoff_mask")
	Citizen.Wait(1000)
	ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_hat = -1
		local prop_hat_text = -1
		ClearPedProp(GetPlayerPed(-1), 0)
		TriggerServerEvent('rtx_doplnky:saveaktualnicepice', prop_hat, prop_hat_text)
    end)
end


function ZmenitCepice(doplnekcepice, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekCepice', skin, doplnekcepice)
		
		local ped = GetPlayerPed(-1)
		local prop_hat = GetPedPropIndex(ped, 0)
		local prop_hat_text = GetPedPropTextureIndex(ped, 0)
		TriggerServerEvent('rtx_doplnky:saveaktualnicepice', prop_hat, prop_hat_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveCepice()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveCepice
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveCepice(value)
    local ped = GetPlayerPed(-1)
	local prop_hat = GetPedPropIndex(ped, 0)
	local prop_hat_text = GetPedPropTextureIndex(ped, 0)
	
	local skin_data = {["helmet_1"]=prop_hat,["helmet_2"]=prop_hat_text}
	
    TriggerServerEvent('rtx_doplnky:saveCepice', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveCepice()
    ESX.TriggerServerCallback('rtx_doplnky:getCepice', function(doplnekcepice)
        local options = {}

        for k, v in pairs(doplnekcepice) do
            v.action = function()
                RemoveCepice(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_cepice',
            title = 'Remove',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveCepice(label)
    TriggerServerEvent('rtx_doplnky:removeCepice', label)
    ESX.UI.Menu.CloseAll()
end

function OpenBraceletMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"bracelet_menu",

		{

			title = "Bracelets",

			align = "bottom-right",

			elements = {

				{label = "Bracelets", value = "narameknlist"},
				
				{label = "Take off bracelet", value = "narameksundat"},

				{label = "Add bracelet", value = "naramekpridat"},

				{label = "Remove bracelet", value = "naramekodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "narameknlist" then
				ShowChangeNaramek()
			elseif data.current.value == "narameksundat" then
				SundatNaramek()
			elseif data.current.value == "naramekpridat" then
				ShowSaveNaramek()
			elseif data.current.value == "naramekodstranit" then
				ShowRemoveNaramek()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeNaramek()
    ESX.TriggerServerCallback('rtx_doplnky:getNaramek', function(doplneknaramek)
        local options = {}

        for k, v in pairs(doplneknaramek) do
            v.action = function()
                ZmenitNaramek(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'narameklist',
            title = 'Bracelets',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatNaramek()
	Citizen.Wait(1000)
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_bracelets = -1
		local prop_bracelets_text = -1
		ClearPedProp(GetPlayerPed(-1), 7)
		TriggerServerEvent('rtx_doplnky:saveaktualninaramek', prop_bracelets, prop_bracelets_text)
    end)
end


function ZmenitNaramek(doplneknaramek, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekNaramek', skin, doplneknaramek)
		
		local ped = GetPlayerPed(-1)
		local prop_bracelets = GetPedPropIndex(ped, 7)
		local prop_bracelets_text = GetPedPropTextureIndex(ped, 7)
		TriggerServerEvent('rtx_doplnky:saveaktualninaramek', prop_bracelets, prop_bracelets_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveNaramek()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveNaramek
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveNaramek(value)
    local ped = GetPlayerPed(-1)
	local prop_bracelets = GetPedPropIndex(ped, 7)
	local prop_bracelets_text = GetPedPropTextureIndex(ped, 7)
	
	local skin_data = {["bracelets_1"]=prop_bracelets,["bracelets_2"]=prop_bracelets_text}
	
    TriggerServerEvent('rtx_doplnky:saveNaramek', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveNaramek()
    ESX.TriggerServerCallback('rtx_doplnky:getNaramek', function(doplneknaramek)
        local options = {}

        for k, v in pairs(doplneknaramek) do
            v.action = function()
                RemoveNaramek(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_naramek',
            title = 'Remove bracelet',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveNaramek(label)
    TriggerServerEvent('rtx_doplnky:removeNaramek', label)
    ESX.UI.Menu.CloseAll()
end

function OpenBagsMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"bags_menu",

		{

			title = "Bags",

			align = "bottom-right",

			elements = {

				{label = "Bags", value = "taskanlist"},
				
				{label = "Take off bag", value = "taskasundat"},

				{label = "Add bag", value = "taskapridat"},

				{label = "Remove bag", value = "taskaodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "taskanlist" then
				ShowChangeTaska()
			elseif data.current.value == "taskasundat" then
				SundatTaska()
			elseif data.current.value == "taskapridat" then
				ShowSaveTaska()
			elseif data.current.value == "taskaodstranit" then
				ShowRemoveTaska()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeTaska()
    ESX.TriggerServerCallback('rtx_doplnky:getTaska', function(doplnektaska)
        local options = {}

        for k, v in pairs(doplnektaska) do
            v.action = function()
                ZmenitTaska(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'taskalist',
            title = 'Bags',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatTaska()
	Citizen.Wait(1000)
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_bag = -1
		local prop_bag_text = -1
		SetPedComponentVariation	(GetPlayerPed(-1), 5,  0,0, 2)
		TriggerServerEvent('rtx_doplnky:saveaktualnitaska', prop_bag, prop_bag_text)
    end)
end


function ZmenitTaska(doplnektaska, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekTaska', skin, doplnektaska)
		
		local ped = GetPlayerPed(-1)
		local prop_bag = GetPedDrawableVariation(ped, 5)
		local prop_bag_text = GetPedTextureVariation(ped, 5)
		TriggerServerEvent('rtx_doplnky:saveaktualnitaska', prop_bag, prop_bag_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveTaska()
    local menu = {
        type = 'dialog',
        title = 'Name',
        action = SaveTaska
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveTaska(value)
    local ped = GetPlayerPed(-1)
	local prop_bag = GetPedDrawableVariation(ped, 5)
	local prop_bag_text = GetPedTextureVariation(ped, 5)
	
	local skin_data = {["bags_1"]=prop_bag,["bags_2"]=prop_bag_text}
	
    TriggerServerEvent('rtx_doplnky:saveTaska', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveTaska()
    ESX.TriggerServerCallback('rtx_doplnky:getTaska', function(doplnektaska)
        local options = {}

        for k, v in pairs(doplnektaska) do
            v.action = function()
                RemoveTaska(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_taska',
            title = 'Remove bag',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveTaska(label)
    TriggerServerEvent('rtx_doplnky:removeTaska', label)
    ESX.UI.Menu.CloseAll()
end

function OpenChainsMenu()

	ESX.UI.Menu.Open(

		"default",

		GetCurrentResourceName(),

		"chains_menu",

		{

			title = "Chains",

			align = "bottom-right",

			elements = {

				{label = "Chains", value = "krknlist"},
				
				{label = "Take off chain", value = "krksundat"},

				{label = "Add chain", value = "krkpridat"},

				{label = "Remove chain", value = "krkodstranit"}
				
			}

		},

		function(data, menu)

			if data.current.value == "krknlist" then
				ShowChangeKrk()
			elseif data.current.value == "krksundat" then
				SundatKrk()
			elseif data.current.value == "krkpridat" then
				ShowSaveKrk()
			elseif data.current.value == "krkodstranit" then
				ShowRemoveKrk()
			end

		end,

		function(data, menu)
			OpenAccessoryMenu()
			menu.close()

		end

	)

end

function ShowChangeKrk()
    ESX.TriggerServerCallback('rtx_doplnky:getKrk', function(doplnekkrk)
        local options = {}

        for k, v in pairs(doplnekkrk) do
            v.action = function()
                ZmenitKrk(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'krklist',
            title = 'Chains',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function SundatKrk()
	Citizen.Wait(1000)
    TriggerEvent('skinchanger:getSkin', function(skin)	
		local ped = GetPlayerPed(-1)
		local prop_chain = -1
		local prop_chain_text = -1
		SetPedComponentVariation	(GetPlayerPed(-1), 7,  0,0, 2)
		TriggerServerEvent('rtx_doplnky:saveaktualnikrk', prop_chain, prop_chain_text)
    end)
end


function ZmenitKrk(doplnekkrk, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadDoplnekKrk', skin, doplnekkrk)
		
		local ped = GetPlayerPed(-1)
		local prop_chain = GetPedDrawableVariation(ped, 7)
		local prop_chain_text = GetPedTextureVariation(ped, 7)
		TriggerServerEvent('rtx_doplnky:saveaktualnikrk', prop_chain, prop_chain_text)
    end)
    ESX.UI.Menu.CloseAll()
end

function ShowSaveKrk()
    local menu = {
        type = 'dialog',
        title = 'Name doplňku',
        action = SaveKrk
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveKrk(value)
    local ped = GetPlayerPed(-1)
	local prop_chain = GetPedDrawableVariation(ped, 7)
	local prop_chain_text = GetPedTextureVariation(ped, 7)
	
	local skin_data = {["chain_1"]=prop_chain,["chain_2"]=prop_chain_text}
	
    TriggerServerEvent('rtx_doplnky:saveKrk', value, skin_data)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveKrk()
    ESX.TriggerServerCallback('rtx_doplnky:getKrk', function(doplnekkrk)
        local options = {}

        for k, v in pairs(doplnekkrk) do
            v.action = function()
                RemoveKrk(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_krk',
            title = 'Remove chain',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveKrk(label)
    TriggerServerEvent('rtx_doplnky:removeKrk', label)
    ESX.UI.Menu.CloseAll()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0,83) then
			OpenAccessoryMenu()
		end

	end
end)