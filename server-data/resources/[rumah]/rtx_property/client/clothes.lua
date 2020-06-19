function OpenClothes(room)

    local options = {
        { label = 'Change clothes', action = ShowChangeClothes },
        { label = 'Save clothes', action = ShowSaveClothes },
        { label = 'Remove clothes', action = ShowRemoveClothes }
    }

    local menu = {
        name = 'clothes',
        title = 'Clothes',
        options = options
    }

    TriggerEvent('rtx_core:openMenu', menu)
end

function ShowChangeClothes()
    ESX.TriggerServerCallback('rtx_property:getClothes', function(clothes)
        local options = {}

        for k, v in pairs(clothes) do
            v.action = function()
                ChangeToClothes(v.skin, v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'show_clothes',
            title = 'Clothes',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function ChangeToClothes(clothes, label)
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadClothesWardrobe', skin, clothes)
		
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
		local prop_mask_text = GetPedTextureVariation(ped, 1)
		local prop_glasses = GetPedPropIndex(ped, 1)
		local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
		local prop_earrings = GetPedPropIndex(ped, 2)
		local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
		local prop_watches = GetPedPropIndex(ped, 6)
		local prop_watches_text = GetPedPropTextureIndex(ped, 6)
		
		TriggerServerEvent('esx_clotheskin:saveclothe', torso, torsotext, leg, legtext, shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat, prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches, prop_watches_text, prop_mask, prop_mask_text)
    end)
    ESX.UI.Menu.CloseAll()
    exports['mythic_notify']:SendAlert('success', 'Clothes changed to: ' .. label)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			local args = "se převlékl"
			TriggerServerEvent('rtx_clientsendableme', GetPlayerServerId(PlayerId()), args)
		else
			local args = "se převlékla"
			TriggerServerEvent('rtx_clientsendableme', GetPlayerServerId(PlayerId()), args)
		end
	end)
end

function ShowSaveClothes()
    local menu = {
        type = 'dialog',
        title = 'The name of the outfit',
        action = SaveClothes
    }
    TriggerEvent('rtx_core:openMenu', menu)
end

function SaveClothes(value)
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
	local prop_mask_text = GetPedTextureVariation(ped, 1)
	local prop_glasses = GetPedPropIndex(ped, 1)
	local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
	local prop_earrings = GetPedPropIndex(ped, 2)
	local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
	local prop_watches = GetPedPropIndex(ped, 6)
	local prop_watches_text = GetPedPropTextureIndex(ped, 6)
	
	local skin_data = {["arms"]=torso,["arms_2"]=torsotext,["pants_1"]=leg,["pants_2"]=legtext,["shoes_1"]=shoes,["shoes_2"]=shoestext,["chain_1"]=accessory,["chain_2"]=accessorytext,["tshirt_1"]=undershirt,["tshirt_2"]=undershirttext,["torso_1"]=torso2,["torso_2"]=torso2text,["helmet_1"]=prop_hat,["helmet_2"]=prop_hat_text,["mask_1"]=prop_mask,["mask_2"]=prop_mask_text,["glasses_1"]=prop_glasses,["glasses_2"]=prop_glasses_text,["ears_1"]=prop_earrings,["ears_2"]=prop_earrings_text,["watches_1"]=prop_watches,["watches_2"]=prop_watches_text}
	
    TriggerServerEvent('rtx_clothewardrobe:saveOutfit', value, skin_data)
	exports['mythic_notify']:SendAlert('success', 'Clothes saved: ' .. value)
    ESX.UI.Menu.CloseAll()
end

function ShowRemoveClothes()
    ESX.TriggerServerCallback('rtx_property:getClothes', function(clothes)
        local options = {}

        for k, v in pairs(clothes) do
            v.action = function()
                RemoveClothes(v.label)
            end
            table.insert(options, v)
        end

        local menu = {
            name = 'remove_clothes',
            title = 'Remove clothes',
            options = options
        }

        TriggerEvent('rtx_core:openMenu', menu)
    end)
end

function RemoveClothes(label)
    TriggerServerEvent('rtx_property:removeOutfit', label)
    exports['mythic_notify']:SendAlert('success', 'Clothes removed: ' .. label)
    ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('rtx_property:SaveClothesToWardrobe')
AddEventHandler('rtx_property:SaveClothesToWardrobe', function()
	ShowSaveClothes()
end)