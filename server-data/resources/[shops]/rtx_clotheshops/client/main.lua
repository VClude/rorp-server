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
local isClotheCreatorOpened = false		-- Change this value to show/hide UI
local cam = -1							-- Camera control
local firstclothe = false
local heading = 332.219879				-- Heading coord
local zoom = "vetements"					-- Define which tab is shown first (Default: Head)
local isCameraActive, isCameraActiveOld, lastSkinOld
local zoomOffsetOld, camOffsetOld, headingOld = 0.0, 0.0, 90.0
local NewPlayer		 = true
local PrevHat, PrevGlasses, PrevEars, PrevWatches, PrevBracelets, PrevBags, PrevChains, PrevMask, PrevPants, PrevShirt, PrevShirt2, PrevShoes

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

RegisterNUICallback('updateSkinSave', function(data)
	local playerPed = PlayerPedId()
	v = data.value
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			gender = 0
		else
			gender = 1
		end
	end)
	dad = tonumber(data.dad)
	mum = tonumber(data.mum)
	gender = tonumber(data.gender)
	dadmumpercent = tonumber(data.dadmumpercent)
	skin = tonumber(data.skin)
	eyecolor = tonumber(data.eyecolor)
	acne = tonumber(data.acne)
	skinproblem = tonumber(data.skinproblem)
	freckle = tonumber(data.freckle)
	wrinkle = tonumber(data.wrinkle)
	wrinkleopacity = tonumber(data.wrinkleopacity)
	eyebrowopacity = tonumber(data.eyebrowopacity)
	beard = tonumber(data.beard)
	beardopacity = tonumber(data.beardopacity)
	beardcolor = tonumber(data.beardcolor)
	-- Clothes
	hats = tonumber(data.hats)
	hats_texture = tonumber(data.hats_texture)
	masks = tonumber(data.masks)
	masks_texture = tonumber(data.masks_texture)
	glasses = tonumber(data.glasses)
	glasses_texture = tonumber(data.glasses_texture)
	ears = tonumber(data.ears)
	ears_texture = tonumber(data.ears_texture)
	tops = tonumber(data.tops)
	tops_texture = tonumber(data.tops_texture)
	tops_texture2 = tonumber(data.tops_texture2)
	pants = tonumber(data.pants)
	pants_texture = tonumber(data.pants_texture)
	shoes = tonumber(data.shoes)
	shoes_texture = tonumber(data.shoes_texture)
	watches = tonumber(data.watches)
	watches_texture = tonumber(data.watches_texture)
	bracelets = tonumber(data.bracelets)
	bracelets_texture = tonumber(data.bracelets_texture)
	bag = tonumber(data.bag)
	bag_texture = tonumber(data.bag_texture)
	chain = tonumber(data.chain)
	chain_texture = tonumber(data.chain_texture)


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
		local prop_mask_text = GetPedTextureVariation(ped, 1)
		local prop_glasses = GetPedPropIndex(ped, 1)
		local prop_glasses_text = GetPedPropTextureIndex(ped, 1)
		local prop_earrings = GetPedPropIndex(ped, 2)
		local prop_earrings_text = GetPedPropTextureIndex(ped, 2)
		local prop_watches = GetPedPropIndex(ped, 6)
		local prop_watches_text = GetPedPropTextureIndex(ped, 6)
		local prop_bracelets = GetPedPropIndex(ped, 7)
		local prop_bracelets_text = GetPedPropTextureIndex(ped, 7)
		local prop_bag = GetPedDrawableVariation(ped, 5)
		local prop_bag_text = GetPedTextureVariation(ped, 5)
		local prop_chain = GetPedDrawableVariation(ped, 7)
		local prop_chain_text = GetPedTextureVariation(ped, 7)
			
		TriggerServerEvent('rtx_clotheshops:saveclothe', torso, torsotext, leg, legtext, shoes, shoestext, accessory, accessorytext, undershirt, undershirttext, torso2, torso2text, prop_hat, prop_hat_text, prop_glasses, prop_glasses_text, prop_earrings, prop_earrings_text, prop_watches, prop_watches_text, prop_mask, prop_mask_text, prop_bracelets, prop_bracelets_text, prop_bag, prop_bag_text, prop_chain, prop_chain_text)
		
		CloseClotheCreator()
	else

	
		-- Clothes variations
		if PrevHat ~= hats then
			PrevHat = hats
			hats_texture = 0
			local maxHat
			if hats == 0 then
				maxHat = 0
			else
				maxHat = GetNumberOfPedPropTextureVariations	(GetPlayerPed(-1), 0, hats) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "helmet_2",
				defaultVal = 0,
				maxVal = maxHat
			})
		end
		
		if hats == 0 then
			ClearPedProp(GetPlayerPed(-1), 0)
		else
			SetPedPropIndex(GetPlayerPed(-1), 0, hats, hats_texture, 2)
		end
		
		if PrevGlasses ~= glasses then
			PrevGlasses = glasses
			glasses_texture = 0
			local maxGlasses
			if glasses == 0 then maxGlasses = 0
			else maxGlasses = GetNumberOfPedPropTextureVariations	(GetPlayerPed(-1), 1, glasses - 1)
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "glasses_2",
				defaultVal = 0,
				maxVal = maxGlasses
			})
		end
		if glasses == 0 then		
			ClearPedProp(GetPlayerPed(-1), 1)
		else
			SetPedPropIndex(GetPlayerPed(-1), 1, glasses, glasses_texture, 2)--Glasses
		end
		
		if PrevEars ~= ears then
			PrevEars = ears
			ears_texture = 0
			local maxEars
			if ears == 0 then maxEars = 0
			else maxEars = GetNumberOfPedPropTextureVariations	(GetPlayerPed(-1), 1, ears - 1)
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "ears_2",
				defaultVal = 0,
				maxVal = maxEars
			})
		end
		if ears == 0 then		ClearPedProp(GetPlayerPed(-1), 2)
		else
			SetPedPropIndex(GetPlayerPed(-1), 2, ears, ears_texture, 2)
		end

		if PrevWatches ~= watches then
			PrevWatches = watches
			watches_texture = 0
			local maxWatches
			if watches == 0 then maxWatches = 0
			else maxWatches = GetNumberOfPedPropTextureVariations	(GetPlayerPed(-1), 1, watches - 1)
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "watches_2",
				defaultVal = 0,
				maxVal = maxWatches
			})
		end
		if watches == 0 then		ClearPedProp(GetPlayerPed(-1), 6)
		else
			SetPedPropIndex(GetPlayerPed(-1), 6, watches, watches_texture, 2)
		end
		
		if PrevBracelets ~= bracelets then
			PrevBracelets = bracelets
			bracelets_texture = 0
			local maxBracelets
			if bracelets == 0 then maxBracelets = 0
			else maxBracelets = GetNumberOfPedPropTextureVariations	(GetPlayerPed(-1), 1, bracelets - 1)
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "bracelets_2",
				defaultVal = 0,
				maxVal = maxBracelets
			})
		end
		if bracelets == 0 then		ClearPedProp(GetPlayerPed(-1), 7)
		else
			SetPedPropIndex(GetPlayerPed(-1), 7, bracelets, bracelets_texture, 2)
		end
	
		if PrevMask ~= masks then
			PrevMask = masks
			mask_texture = 0
			local maxMask
			if masks == 0 then
				maxMask = 0
			else
				maxMask = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 1, masks) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "mask_2",
				defaultVal = 0,
				maxVal = maxMask
			})
		end
		
		if masks == 0 then
			SetPedComponentVariation(GetPlayerPed(-1), 1, 0 ,0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 1, masks, masks_texture, 2)
		end
		
		if PrevBags ~= bag then
			PrevBags = bag
			bag_texture = 0
			local maxBag
			if bag == 0 then
				maxBag = 0
			else
				maxBag = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 1, bag) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "bags_2",
				defaultVal = 0,
				maxVal = maxBag
			})
		end
		
		if bag == 0 then
			SetPedComponentVariation(GetPlayerPed(-1), 5, 0 ,0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 5, bag, bag_texture, 2)
		end
		
		if PrevChains ~= chain then
			PrevChains = chain
			chain_texture = 0
			local maxChain
			if chain == 0 then
				maxChain = 0
			else
				maxChain = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 1, chain) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "chain_2",
				defaultVal = 0,
				maxVal = maxChain
			})
		end
		
		if chain == 0 then
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0 ,0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 7, chain, chain_texture, 2)
		end		
		
		if PrevPants ~= pants then
			PrevPants = pants
			pants_texture = 0
			local maxPant
			if pants == 0 then
				maxPant = 0
			else
				maxPant = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 4, pants) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "pants_2",
				defaultVal = 0,
				maxVal = maxPant
			})
		end
		
		if PrevShirt ~= tops then
			PrevShirt = tops
			tops_texture = 0
			local maxTops
			if tops == 0 then
				maxTops = 0
			else
				maxTops = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 11, tops) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "torso_2",
				defaultVal = 0,
				maxVal = maxTops
			})
		end
		if PrevShirt2 ~= tops then
			PrevShirt2 = tops
			tops_texture2 = 0
			local maxTops2
			if tops == 0 then
				maxTops2 = 0
			else
				maxTops2 = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 8, tops) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "tshirt_2",
				defaultVal = 0,
				maxVal = maxTops2
			})
		end
		
		if PrevShoes ~= shoes then
			PrevShoes = shoes
			shoes_texture2 = 0
			local maxShoes
			if shoes == 0 then
				maxShoes = 0
			else
				maxShoes = GetNumberOfPedTextureVariations	(GetPlayerPed(-1), 6, shoes) - 1
			end
			SendNUIMessage({
				type = "updateMaxVal",
				classname = "shoes_2",
				defaultVal = 0,
				maxVal = maxShoes
			})
		end
		
	TriggerEvent('skinchanger:getSkin', function(skin)
		-- Keep these 4 variations together.
		if skin.sex == 0 then
			if tops == 0 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 1 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 1, tops_texture, 2) 	-- Torso 2
			elseif tops == 2 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 2, tops_texture, 2) 	-- Torso 2
			elseif tops == 3 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 1, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 3, tops_texture, 2) 	-- Torso 2
			elseif tops == 4 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 4, tops_texture, 2) 	-- Torso 2
			elseif tops == 5 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 5, tops_texture, 2) 	-- Torso 2
			elseif tops == 6 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 5, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 6, tops_texture, 2) 	-- Torso 2	
			elseif tops == 7 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 5, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 7, tops_texture, 2) 	-- Torso 2
			elseif tops == 8 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 8, tops_texture, 2) 	-- Torso 2		
			elseif tops == 9 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 9, tops_texture, 2) 	-- Torso 2	
			elseif tops == 10 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 8, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 10, tops_texture, 2) 	-- Torso 2
			elseif tops == 11 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 7, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 11, tops_texture, 2) 	-- Torso 2
			elseif tops == 12 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 12, tops_texture, 2) 	-- Torso 2
			elseif tops == 13 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 13, tops_texture, 2) 	-- Torso 2
			elseif tops == 14 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 14, tops_texture, 2) 	-- Torso 2
			elseif tops == 15 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 0, tops_texture, 2) 	-- Torso 2
			elseif tops == 16 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 16, tops_texture, 2) 	-- Torso 2
			elseif tops == 17 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 17, tops_texture, 2) 	-- Torso 2
			elseif tops == 18 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 18, tops_texture, 2) 	-- Torso 2
			elseif tops == 19 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 19, tops_texture, 2) 	-- Torso 2
			elseif tops == 20 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 20, tops_texture, 2) 	-- Torso 2
			elseif tops == 21 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 7, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 21, tops_texture, 2) 	-- Torso 2
			elseif tops == 22 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 22, tops_texture, 2) 	-- Torso 2
			elseif tops == 23 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 23, tops_texture, 2) 	-- Torso 2
			elseif tops == 24 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 24, tops_texture, 2) 	-- Torso 2
			elseif tops == 25 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 7, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 25, tops_texture, 2) 	-- Torso 2
			elseif tops == 26 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 26, tops_texture, 2) 	-- Torso 2
			elseif tops == 27 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 27, tops_texture, 2) 	-- Torso 2
			elseif tops == 28 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 28, tops_texture, 2) 	-- Torso 
			elseif tops == 29 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 33, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 29, tops_texture, 2) 	-- Torso 2
			elseif tops == 30 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 34, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 30, tops_texture, 2) 	-- Torso 2
			elseif tops == 31 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 34, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 31, tops_texture, 2) 	-- Torso 2
			elseif tops == 32 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 36, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 32, tops_texture, 2) 	-- Torso 2
			elseif tops == 33 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 33, tops_texture, 2) 	-- Torso 2
			elseif tops == 34 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 34, tops_texture, 2) 	-- Torso 2
			elseif tops == 35 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 4, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 35, tops_texture, 2) 	-- Torso 2
			elseif tops == 36 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 36, tops_texture, 2) 	-- Torso 2
			elseif tops == 37 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 18, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 37, tops_texture, 2) 	-- Torso 2
			elseif tops == 38 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 38, tops_texture, 2) 	-- Torso 2
			elseif tops == 39 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 39, tops_texture, 2) 	-- Torso 2
			elseif tops == 40 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 7, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 40, tops_texture, 2) 	-- Torso 2
			elseif tops == 41 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 41, tops_texture, 2) 	-- Torso 2
			elseif tops == 42 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 42, tops_texture, 2) 	-- Torso 2
			elseif tops == 43 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 43, tops_texture, 2) 	-- Torso 2
			elseif tops == 44 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 44, tops_texture, 2) 	-- Torso 2
			elseif tops == 45 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 45, tops_texture, 2) 	-- Torso 2
			elseif tops == 46 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 52, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 46, tops_texture, 2) 	-- Torso 2
			elseif tops == 47 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 47, tops_texture, 2) 	-- Torso 2
			elseif tops == 48 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 48, tops_texture, 2) 	-- Torso 2
			elseif tops == 49 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 49, tops_texture, 2) 	-- Torso 2
			elseif tops == 50 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 50, tops_texture, 2) 	-- Torso 2
			elseif tops == 51 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 50, 1, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 23, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 70, 0, 2) 	-- Torso 2
			elseif tops == 52 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 50, 1, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 23, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 70, 1, 2) 	-- Torso 2
			elseif tops == 53 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 50, 1, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 23, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 70, 7, 2) 	-- Torso 2
			elseif tops == 54 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 3, 1, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 72, 1, 2) 	-- Torso 2
			elseif tops == 55 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 87, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 5, 0, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 74, 0, 2) 	-- Torso 2
			elseif tops == 56 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 12, 2, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 28, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 77, 0, 2) 	-- Torso 2
			elseif tops == 57 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 79, 0, 2) 	-- Torso 2
			elseif tops == 58 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 80, 0, 2) 	-- Torso 2
			elseif tops == 59 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 80, 1, 2) 	-- Torso 2
			elseif tops == 60 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 82, 5, 2) 	-- Torso 2
			elseif tops == 61 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 82, 8, 2) 	-- Torso 2
			elseif tops == 62 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 82, 9, 2) 	-- Torso 2
			elseif tops == 63 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 0, 2) 	-- Torso 2
			elseif tops == 64 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 2, 2) 	-- Torso 2
			elseif tops == 65 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 4, 2) 	-- Torso 2
			elseif tops == 66 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 11, 2) 	-- Torso 2
			elseif tops == 67 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 0, 2) 	-- Torso 2
			elseif tops == 68 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 1, 2) 	-- Torso 2
			elseif tops == 69 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 2, 2) 	-- Torso 2
			elseif tops == 70 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 4, 2) 	-- Torso 2
			elseif tops == 71 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, 8, 2) 	-- Torso 2
			elseif tops == 72 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 89, 0, 2) 	-- Torso 2
			elseif tops == 73 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 95, 0, 2) 	-- Torso 2
			elseif tops == 74 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 99, 1, 2) 	-- Torso 2
			elseif tops == 75 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, 13, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 99, 3, 2) 	-- Torso 2
			elseif tops == 76 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, 13, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 101, 0, 2) 	-- Torso 2
			elseif tops == 77 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 105, 0, 2) 	-- Torso 2
			elseif tops == 78 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 10, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 106, 0, 2) 	-- Torso 2
			elseif tops == 79 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 73, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 109, 0, 2) 	-- Torso 2
			elseif tops == 80 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 111, 0, 2) 	-- Torso 2
			elseif tops == 81 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 111, 3, 2) 	-- Torso 2
			elseif tops == 82 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 113, 0, 2) 	-- Torso 2
			elseif tops == 83 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, 5, 2) 	-- Torso 2
			elseif tops == 84 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, 9, 2) 	-- Torso 2
			elseif tops == 85 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, 10, 2) 	-- Torso 2
			elseif tops == 86 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, 14, 2) 	-- Torso 2
			elseif tops == 87 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 131, 0, 2) 	-- Torso 2
			elseif tops == 88 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 134, 0, 2) 	-- Torso 2
			elseif tops == 89 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 134, 1, 2) 	-- Torso 2
			elseif tops == 90 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 0, 2) 	-- Torso 2
			elseif tops == 91 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 2, 2) 	-- Torso 2
			elseif tops == 92 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 4, 2) 	-- Torso 2
			elseif tops == 93 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 5, 2) 	-- Torso 2
			elseif tops == 94 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 6, 2) 	-- Torso 2
			elseif tops == 95 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 8, 2) 	-- Torso 2
			elseif tops == 96 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, 9, 2) 	-- Torso 2
			elseif tops == 97 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 146, 0, 2) 	-- Torso 2
			elseif tops == 98 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 16, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 166, 0, 2) 	-- Torso 2
			elseif tops == 99 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, 1, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 167, 0, 2) 	-- Torso 2
			elseif tops == 100 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 10, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 100, tops_texture, 2) 	-- Torso 2
			elseif tops == 101 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 75, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 101, tops_texture, 2) 	-- Torso 2
			elseif tops == 102 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 74, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 102, tops_texture, 2) 	-- Torso 2
			elseif tops == 103 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 75, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 103, tops_texture, 2) 	-- Torso 2
			elseif tops == 104 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 74, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 104, tops_texture, 2) 	-- Torso 2
			elseif tops == 105 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 105, tops_texture, 2) 	-- Torso 2
			elseif tops == 106 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 96, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 106, tops_texture, 2) 	-- Torso 2
			elseif tops == 107 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 107, tops_texture, 2) 	-- Torso 2
			elseif tops == 108 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 108, tops_texture, 2) 	-- Torso 2
			elseif tops == 109 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 50, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 109, tops_texture, 2) 	-- Torso 2
			elseif tops == 110 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 110, tops_texture, 2) 	-- Torso 2
			elseif tops == 111 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 111, tops_texture, 2) 	-- Torso 2
			elseif tops == 112 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 112, tops_texture, 2) 	-- Torso 2
			elseif tops == 113 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 113, tops_texture, 2) 	-- Torso 2
			elseif tops == 114 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 28, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 114, tops_texture, 2) 	-- Torso 2
			elseif tops == 115 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 115, tops_texture, 2) 	-- Torso 2
			elseif tops == 116 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 116, tops_texture, 2) 	-- Torso 2
			elseif tops == 117 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 117, tops_texture, 2) 	-- Torso 2
			elseif tops == 118 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 5, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 118, tops_texture, 2) 	-- Torso 2
			elseif tops == 119 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 119, tops_texture, 2) 	-- Torso 2
			elseif tops == 120 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 50, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 120, tops_texture, 2) 	-- Torso 2
			elseif tops == 121 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 121, tops_texture, 2) 	-- Torso 2
			elseif tops == 122 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 75, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 122, tops_texture, 2) 	-- Torso 2
			elseif tops == 123 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 123, tops_texture, 2) 	-- Torso 2
			elseif tops == 124 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 124, tops_texture, 2) 	-- Torso 2
			elseif tops == 125 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 125, tops_texture, 2) 	-- Torso 2
			elseif tops == 126 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, tops_texture, 2) 	-- Torso 2
			elseif tops == 127 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 127, tops_texture, 2) 	-- Torso 2
			elseif tops == 128 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 128, tops_texture, 2) 	-- Torso 2	
			elseif tops == 129 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 129, tops_texture, 2) 	-- Torso 2
			elseif tops == 130 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 11, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 130, tops_texture, 2) 	-- Torso 2
			elseif tops == 131 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 131, tops_texture, 2) 	-- Torso 2
			elseif tops == 132 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 132, tops_texture, 2) 	-- Torso 2
			elseif tops == 133 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 133, tops_texture, 2) 	-- Torso 2
			elseif tops == 134 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 134, tops_texture, 2) 	-- Torso 2
			elseif tops == 135 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 135, tops_texture, 2) 	-- Torso 2
			elseif tops == 136 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 136, tops_texture, 2) 	-- Torso 2
			elseif tops == 137 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 50, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 137, tops_texture, 2) 	-- Torso 2
			elseif tops == 138 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 138, tops_texture, 2) 	-- Torso 2
			elseif tops == 139 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 139, tops_texture, 2) 	-- Torso 2
			elseif tops == 140 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 44, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 140, tops_texture, 2) 	-- Torso 2
			elseif tops == 141 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 141, tops_texture, 2) 	-- Torso 2
			elseif tops == 142 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 11, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 142, tops_texture, 2) 	-- Torso 2
			elseif tops == 143 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, tops_texture, 2) 	-- Torso 2
			elseif tops == 144 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 144, tops_texture, 2) 	-- Torso 2
			elseif tops == 145 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 145, tops_texture, 2) 	-- Torso 2
			elseif tops == 146 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 146, tops_texture, 2) 	-- Torso 2
			elseif tops == 147 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 147, tops_texture, 2) 	-- Torso 2
			elseif tops == 148 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 148, tops_texture, 2) 	-- Torso 2
			elseif tops == 149 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 77, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 149, tops_texture, 2) 	-- Torso 2
			elseif tops == 150 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 150, tops_texture, 2) 	-- Torso 2																
			elseif tops == 151 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 151, tops_texture, 2) 	-- Torso 2
			elseif tops == 152 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 152, tops_texture, 2) 	-- Torso 2
			elseif tops == 153 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 153, tops_texture, 2) 	-- Torso 2
			elseif tops == 154 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 154, tops_texture, 2) 	-- Torso 2
			elseif tops == 155 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 77, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 155, tops_texture, 2) 	-- Torso 2
			elseif tops == 156 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 75, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 156, tops_texture, 2) 	-- Torso 2
			elseif tops == 157 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 81, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 157, tops_texture, 2) 	-- Torso 2
			elseif tops == 158 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 134, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 158, tops_texture, 2) 	-- Torso 2
			elseif tops == 159 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 134, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 159, tops_texture, 2) 	-- Torso 2
			elseif tops == 160 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 132, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 160, tops_texture, 2) 	-- Torso 2
			elseif tops == 161 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 71, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 161, tops_texture, 2) 	-- Torso 2
			elseif tops == 162 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 85, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 162, tops_texture, 2) 	-- Torso 2
			elseif tops == 163 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 163, tops_texture, 2) 	-- Torso 2
			elseif tops == 164 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 164, tops_texture, 2) 	-- Torso 2
			elseif tops == 165 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 165, tops_texture, 2) 	-- Torso 2
			elseif tops == 166 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 32, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 166, tops_texture, 2) 	-- Torso 2
			elseif tops == 167 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 167, tops_texture, 2) 	-- Torso 2
			elseif tops == 168 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 168, tops_texture, 2) 	-- Torso 2
			elseif tops == 169 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 169, tops_texture, 2) 	-- Torso 2
			elseif tops == 170 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 103, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 170, tops_texture, 2) 	-- Torso 2
			elseif tops == 171 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 171, tops_texture, 2) 	-- Torso 2
			elseif tops == 172 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 31, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 172, tops_texture, 2) 	-- Torso 2
			elseif tops == 173 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 138, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 173, tops_texture, 2) 	-- Torso 2
			elseif tops == 174 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 44, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 174, tops_texture, 2) 	-- Torso 2
			elseif tops == 175 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 105, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 175, tops_texture, 2) 	-- Torso 2
			elseif tops == 176 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 105, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 176, tops_texture, 2) 	-- Torso 2
			elseif tops == 177 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 177, tops_texture, 2) 	-- Torso 2
			elseif tops == 178 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 178, tops_texture, 2) 	-- Torso 2	
			elseif tops == 179 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 81, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 179, tops_texture, 2) 	-- Torso 2
			elseif tops == 180 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 180, tops_texture, 2) 	-- Torso 2
			elseif tops == 181 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 181, tops_texture, 2) 	-- Torso 2
			elseif tops == 182 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 182, tops_texture, 2) 	-- Torso 2
			elseif tops == 183 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 107, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 183, tops_texture, 2) 	-- Torso 2
			elseif tops == 184 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 184, tops_texture, 2) 	-- Torso 2
			elseif tops == 185 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 60, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 185, tops_texture, 2) 	-- Torso 2
			elseif tops == 186 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 186, tops_texture, 2) 	-- Torso 2
			elseif tops == 187 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 187, tops_texture, 2) 	-- Torso 2
			elseif tops == 188 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 188, tops_texture, 2) 	-- Torso 2
			elseif tops == 189 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 60, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 189, tops_texture, 2) 	-- Torso 2
			elseif tops == 190 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 190, tops_texture, 2) 	-- Torso 2
			elseif tops == 191 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 191, tops_texture, 2) 	-- Torso 2
			elseif tops == 192 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 192, tops_texture, 2) 	-- Torso 2
			elseif tops == 193 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 193, tops_texture, 2) 	-- Torso 2
			elseif tops == 194 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 194, tops_texture, 2) 	-- Torso 2
			elseif tops == 195 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 195, tops_texture, 2) 	-- Torso 2
			elseif tops == 196 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 196, tops_texture, 2) 	-- Torso 2
			elseif tops == 197 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 197, tops_texture, 2) 	-- Torso 2
			elseif tops == 198 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 198, tops_texture, 2) 	-- Torso 2
			elseif tops == 199 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 199, tops_texture, 2) 	-- Torso 2
			elseif tops == 200 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 200, tops_texture, 2) 	-- Torso 2
			elseif tops == 201 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 200, tops_texture, 2) 	-- Torso 2
			elseif tops == 202 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 202, tops_texture, 2) 	-- Torso 2
			elseif tops == 203 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 203, tops_texture, 2) 	-- Torso 2
			elseif tops == 204 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 204, tops_texture, 2) 	-- Torso 2
			elseif tops == 205 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 205, tops_texture, 2) 	-- Torso 2
			elseif tops == 206 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 206, tops_texture, 2) 	-- Torso 2
			elseif tops == 207 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 207, tops_texture, 2) 	-- Torso 2
			elseif tops == 208 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 208, tops_texture, 2) 	-- Torso 2
			elseif tops == 209 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 209, tops_texture, 2) 	-- Torso 2
			elseif tops == 210 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 210, tops_texture, 2) 	-- Torso 2
			elseif tops == 211 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 211, tops_texture, 2) 	-- Torso 2
			elseif tops == 212 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 1, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 212, tops_texture, 2) 	-- Torso 2
			elseif tops == 213 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 213, tops_texture, 2) 	-- Torso 2
			elseif tops == 214 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 214, tops_texture, 2) 	-- Torso 2
			elseif tops == 215 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 215, tops_texture, 2) 	-- Torso 2
			elseif tops == 216 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 216, tops_texture, 2) 	-- Torso 2
			elseif tops == 217 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 217, tops_texture, 2) 	-- Torso 2
			elseif tops == 218 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 218, tops_texture, 2) 	-- Torso 2
			elseif tops == 219 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 219, tops_texture, 2) 	-- Torso 2
			elseif tops == 220 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 220, tops_texture, 2) 	-- Torso 2
			elseif tops == 221 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 221, tops_texture, 2) 	-- Torso 2
			elseif tops == 222 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 222, tops_texture, 2) 	-- Torso 2
			elseif tops == 223 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 223, tops_texture, 2) 	-- Torso 2
			elseif tops == 224 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 224, tops_texture, 2) 	-- Torso 2
			elseif tops == 225 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 225, tops_texture, 2) 	-- Torso 2
			elseif tops == 226 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 226, tops_texture, 2) 	-- Torso 2
			elseif tops == 227 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 227, tops_texture, 2) 	-- Torso 2
			elseif tops == 228 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 227, tops_texture, 2) 	-- Torso 2	
			elseif tops == 229 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 229, tops_texture, 2) 	-- Torso 2
			elseif tops == 230 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 230, tops_texture, 2) 	-- Torso 2
			elseif tops == 231 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 230, tops_texture, 2) 	-- Torso 2
			elseif tops == 232 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 232, tops_texture, 2) 	-- Torso 2
			elseif tops == 233 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 72, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 233, tops_texture, 2) 	-- Torso 2
			elseif tops == 234 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 234, tops_texture, 2) 	-- Torso 2
			elseif tops == 235 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 235, tops_texture, 2) 	-- Torso 2
			elseif tops == 236 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 236, tops_texture, 2) 	-- Torso 2
			elseif tops == 237 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 237, tops_texture, 2) 	-- Torso 2
			elseif tops == 238 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 238, tops_texture, 2) 	-- Torso 2
			elseif tops == 239 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 239, tops_texture, 2) 	-- Torso 2
			elseif tops == 240 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 240, tops_texture, 2) 	-- Torso 2
			elseif tops == 241 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 241, tops_texture, 2) 	-- Torso 2
			elseif tops == 242 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 242, tops_texture, 2) 	-- Torso 2
			elseif tops == 243 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 243, tops_texture, 2) 	-- Torso 2
			elseif tops == 244 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 244, tops_texture, 2) 	-- Torso 2
			elseif tops == 245 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 245, tops_texture, 2) 	-- Torso 2
			elseif tops == 246 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 245, tops_texture, 2) 	-- Torso 2
			elseif tops == 247 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 247, tops_texture, 2) 	-- Torso 2
			elseif tops == 248 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 248, tops_texture, 2) 	-- Torso 2
			elseif tops == 249 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 249, tops_texture, 2) 	-- Torso 2
			elseif tops == 250 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 250, tops_texture, 2) 	-- Torso 2																
			elseif tops == 251 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 251, tops_texture, 2) 	-- Torso 2
			elseif tops == 252 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 251, tops_texture, 2) 	-- Torso 2
			elseif tops == 253 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 253, tops_texture, 2) 	-- Torso 2
			elseif tops == 254 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 254, tops_texture, 2) 	-- Torso 2
			elseif tops == 255 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 255, tops_texture, 2) 	-- Torso 2
			elseif tops == 256 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 256, tops_texture, 2) 	-- Torso 2
			elseif tops == 257 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 257, tops_texture, 2) 	-- Torso 2
			elseif tops == 258 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 258, tops_texture, 2) 	-- Torso 2
			elseif tops == 259 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 259, tops_texture, 2) 	-- Torso 2
			elseif tops == 260 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 260, tops_texture, 2) 	-- Torso 2
			elseif tops == 261 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 261, tops_texture, 2) 	-- Torso 2
			elseif tops == 262 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 262, tops_texture, 2) 	-- Torso 2
			elseif tops == 263 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 263, tops_texture, 2) 	-- Torso 2
			elseif tops == 264 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 264, tops_texture, 2) 	-- Torso 2
			elseif tops == 265 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 265, tops_texture, 2) 	-- Torso 2
			elseif tops == 266 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 266, tops_texture, 2) 	-- Torso 2
			elseif tops == 267 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 6, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 267, tops_texture, 2) 	-- Torso 2
			elseif tops == 268 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 268, tops_texture, 2) 	-- Torso 2
			elseif tops == 269 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 269, tops_texture, 2) 	-- Torso 2
			elseif tops == 270 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 270, tops_texture, 2) 	-- Torso 2
			elseif tops == 271 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 271, tops_texture, 2) 	-- Torso 2
			elseif tops == 272 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 272, tops_texture, 2) 	-- Torso 2
			elseif tops == 273 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 274 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 275 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 276 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 277 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 278 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2	
			elseif tops == 279 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 279, tops_texture, 2) 	-- Torso 2
			elseif tops == 280 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 280, tops_texture, 2) 	-- Torso 2
			elseif tops == 281 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 281, tops_texture, 2) 	-- Torso 2
			elseif tops == 282 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 282, tops_texture, 2) 	-- Torso 2
			elseif tops == 283 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 282, tops_texture, 2) 	-- Torso 2
			elseif tops == 284 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 285 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 286 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 287 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 288 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 288, tops_texture, 2) 	-- Torso 2
			elseif tops == 289 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 288, tops_texture, 2) 	-- Torso 2
			elseif tops == 290 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 290, tops_texture, 2) 	-- Torso 2
			elseif tops == 291 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 292 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 292, tops_texture, 2) 	-- Torso 2
			elseif tops == 293 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 293, tops_texture, 2) 	-- Torso 2
			elseif tops == 294 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 294, tops_texture, 2) 	-- Torso 2
			elseif tops == 295 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 18, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 295, tops_texture, 2) 	-- Torso 2
			elseif tops == 296 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 296, tops_texture, 2) 	-- Torso 2
			elseif tops == 297 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 297, tops_texture, 2) 	-- Torso 2
			elseif tops == 298 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 298, tops_texture, 2) 	-- Torso 2
			elseif tops == 299 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 8, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 299, tops_texture, 2) 	-- Torso 2
			elseif tops == 300 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 300, tops_texture, 2) 	-- Torso 2		
			elseif tops == 301 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 301, tops_texture, 2) 	-- Torso 2		
			elseif tops == 302 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 302, tops_texture, 2) 	-- Torso 2		
			elseif tops == 303 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 303, tops_texture, 2) 	-- Torso 2		
			elseif tops == 304 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 304, tops_texture, 2) 	-- Torso 2	
			elseif tops == 305 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 305, tops_texture, 2) 	-- Torso 2	
			elseif tops == 306 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 306, tops_texture, 2) 	-- Torso 2	
			elseif tops == 307 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 307, tops_texture, 2) 	-- Torso 2	
			elseif tops == 308 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 308, tops_texture, 2) 	-- Torso 2	
			elseif tops == 309 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 309, tops_texture, 2) 	-- Torso 2	
			elseif tops == 310 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 24, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 310, tops_texture, 2) 	-- Torso 2	
			elseif tops == 311 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 38, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 311, tops_texture, 2) 	-- Torso 2	
			elseif tops == 312 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 18, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 312, tops_texture, 2) 	-- Torso 2	
			elseif tops == 313 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 313, tops_texture, 2) 	-- Torso 2				
			end
			if pants == 0 then 		SetPedComponentVariation(GetPlayerPed(-1), 4, 61, pants_texture, 2)
			elseif pants == 1 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 1, pants_texture, 2)
			elseif pants == 2 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 2, pants_texture, 2)
			elseif pants == 3 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 3, pants_texture, 2)
			elseif pants == 4 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 4, pants_texture, 2)
			elseif pants == 5 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 5, pants_texture, 2)
			elseif pants == 6 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 6, pants_texture, 2)
			elseif pants == 7 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 7, pants_texture, 2)
			elseif pants == 8 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 8, pants_texture, 2)
			elseif pants == 9 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 9, pants_texture, 2)
			elseif pants == 10 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 10, pants_texture, 2)
			elseif pants == 11 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 12 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 12, pants_texture, 2)
			elseif pants == 13 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 14 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 14, pants_texture, 2)
			elseif pants == 15 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 15, pants_texture, 2)
			elseif pants == 16 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 16, pants_texture, 2)
			elseif pants == 17 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 17, pants_texture, 2)
			elseif pants == 18 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 18, pants_texture, 2)
			elseif pants == 19 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 19, pants_texture, 2)
			elseif pants == 20 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 20, pants_texture, 2)
			elseif pants == 21 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 21, pants_texture, 2)
			elseif pants == 22 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 22, pants_texture, 2)
			elseif pants == 23 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 23, pants_texture, 2)
			elseif pants == 24 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 24, pants_texture, 2)
			elseif pants == 25 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 25, pants_texture, 2)
			elseif pants == 26 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 26, pants_texture, 2)
			elseif pants == 27 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 27, pants_texture, 2)
			elseif pants == 28 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 28, pants_texture, 2)
			elseif pants == 29 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 29, pants_texture, 2)
			elseif pants == 30 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 30, pants_texture, 2)
			elseif pants == 31 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 31, pants_texture, 2)
			elseif pants == 32 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 33 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 33, pants_texture, 2)
			elseif pants == 34 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 34, pants_texture, 2)
			elseif pants == 35 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 35, pants_texture, 2)
			elseif pants == 36 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 36, pants_texture, 2)
			elseif pants == 37 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 37, pants_texture, 2)
			elseif pants == 38 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 39 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 40 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 41 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 41, pants_texture, 2)
			elseif pants == 42 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 42, pants_texture, 2)
			elseif pants == 43 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 43, pants_texture, 2)
			elseif pants == 44 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 45 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 45, pants_texture, 2)
			elseif pants == 46 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 47 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 47, pants_texture, 2)
			elseif pants == 48 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 48, pants_texture, 2)
			elseif pants == 49 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 49, pants_texture, 2)
			elseif pants == 50 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 50, pants_texture, 2)
			elseif pants == 51 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 51, pants_texture, 2)
			elseif pants == 52 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 52, pants_texture, 2)
			elseif pants == 53 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 53, pants_texture, 2)
			elseif pants == 54 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 54, pants_texture, 2)
			elseif pants == 55 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 55, pants_texture, 2)
			elseif pants == 56 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 56, pants_texture, 2)
			elseif pants == 57 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 57, pants_texture, 2)
			elseif pants == 58 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 58, pants_texture, 2)
			elseif pants == 59 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 60 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 60, pants_texture, 2)
			elseif pants == 61 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 62 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 62, pants_texture, 2)
			elseif pants == 63 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 63, pants_texture, 2)
			elseif pants == 64 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 64, pants_texture, 2)
			elseif pants == 65 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 65, pants_texture, 2)
			elseif pants == 66 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 67 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 68 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 69 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 69, pants_texture, 2)			
			elseif pants == 70 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 71 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 71, pants_texture, 2)
			elseif pants == 72 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 72, pants_texture, 2)
			elseif pants == 73 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 73, pants_texture, 2)
			elseif pants == 74 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 74, pants_texture, 2)
			elseif pants == 75 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 75, pants_texture, 2)
			elseif pants == 76 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 76, pants_texture, 2)
			elseif pants == 77 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 78 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 78, pants_texture, 2)
			elseif pants == 79 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 79, pants_texture, 2)
			elseif pants == 80 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 80, pants_texture, 2)
			elseif pants == 81 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 81, pants_texture, 2)
			elseif pants == 82 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 82, pants_texture, 2)
			elseif pants == 83 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 83, pants_texture, 2)
			elseif pants == 84 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 85 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 85, pants_texture, 2)
			elseif pants == 86 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 86, pants_texture, 2)
			elseif pants == 87 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 87, pants_texture, 2)
			elseif pants == 88 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 88, pants_texture, 2)
			elseif pants == 89 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 89, pants_texture, 2)
			elseif pants == 90 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 91 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 92 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 92, pants_texture, 2)
			elseif pants == 93 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 93, pants_texture, 2)
			elseif pants == 94 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 95 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 95, pants_texture, 2)
			elseif pants == 96 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 96, pants_texture, 2)
			elseif pants == 97 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 97, pants_texture, 2)
			elseif pants == 98 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 98, pants_texture, 2)
			elseif pants == 99 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 100 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 101 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 102 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 102, pants_texture, 2)
			elseif pants == 103 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 103, pants_texture, 2)
			elseif pants == 104 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 104, pants_texture, 2)
			elseif pants == 105 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 105, pants_texture, 2)
			elseif pants == 106 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 106, pants_texture, 2)
			elseif pants == 107 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 108 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 109 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 110 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 111 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 112 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 113 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 113, pants_texture, 2)
			end
			
            if shoes == 0 then		SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 2)
			elseif shoes == 1 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 2 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 2, shoes_texture, 2)
			elseif shoes == 3 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 3, shoes_texture, 2)
			elseif shoes == 4 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 4, shoes_texture, 2)
			elseif shoes == 5 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 5, shoes_texture, 2)
			elseif shoes == 6 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 6, shoes_texture, 2)
			elseif shoes == 7 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 7, shoes_texture, 2)
			elseif shoes == 8 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 8, shoes_texture, 2)
			elseif shoes == 9 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 9, shoes_texture, 2)
			elseif shoes == 10 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 10, shoes_texture, 2)
			elseif shoes == 11 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 11, shoes_texture, 2)
			elseif shoes == 12 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 12, shoes_texture, 2)
			elseif shoes == 13 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 14 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 14, shoes_texture, 2)
			elseif shoes == 15 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 15, shoes_texture, 2)
			elseif shoes == 16 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 16, shoes_texture, 2)
			elseif shoes == 17 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 17, shoes_texture, 2)
			elseif shoes == 18 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 18, shoes_texture, 2)
			elseif shoes == 19 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 19, shoes_texture, 2)
			elseif shoes == 20 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 20, shoes_texture, 2)
			elseif shoes == 21 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 21, shoes_texture, 2)
			elseif shoes == 22 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 22, shoes_texture, 2)
			elseif shoes == 23 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 23, shoes_texture, 2)
			elseif shoes == 24 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 24, shoes_texture, 2)
			elseif shoes == 25 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 25, shoes_texture, 2)
			elseif shoes == 26 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 26, shoes_texture, 2)
			elseif shoes == 27 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 27, shoes_texture, 2)
			elseif shoes == 28 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 28, shoes_texture, 2)
			elseif shoes == 29 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 29, shoes_texture, 2)
			elseif shoes == 30 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 30, shoes_texture, 2)
			elseif shoes == 31 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 31, shoes_texture, 2)
			elseif shoes == 32 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 32, shoes_texture, 2)
			elseif shoes == 33 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 34 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 34, shoes_texture, 2)
			elseif shoes == 35 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 35, shoes_texture, 2)
			elseif shoes == 36 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 36, shoes_texture, 2)
			elseif shoes == 37 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 37, shoes_texture, 2)
			elseif shoes == 38 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 38, shoes_texture, 2)
			elseif shoes == 39 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 40 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 40, shoes_texture, 2)
			elseif shoes == 41 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 41, shoes_texture, 2)
			elseif shoes == 42 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 42, shoes_texture, 2)
			elseif shoes == 43 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 43, shoes_texture, 2)
			elseif shoes == 44 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 44, shoes_texture, 2)
			elseif shoes == 45 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 45, shoes_texture, 2)
			elseif shoes == 46 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 46, shoes_texture, 2)
			elseif shoes == 47 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 47, shoes_texture, 2)
			elseif shoes == 48 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 48, shoes_texture, 2)
			elseif shoes == 49 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 49, shoes_texture, 2)
			elseif shoes == 50 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 50, shoes_texture, 2)
			elseif shoes == 51 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 51, shoes_texture, 2)
			elseif shoes == 52 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 52, shoes_texture, 2)
			elseif shoes == 53 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 53, shoes_texture, 2)
			elseif shoes == 54 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 54, shoes_texture, 2)
			elseif shoes == 55 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 55, shoes_texture, 2)
			elseif shoes == 56 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 56, shoes_texture, 2)
			elseif shoes == 57 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 57, shoes_texture, 2)
			elseif shoes == 58 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 58, shoes_texture, 2)
			elseif shoes == 59 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 59, shoes_texture, 2)
			elseif shoes == 60 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 60, shoes_texture, 2)
			elseif shoes == 61 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 61, shoes_texture, 2)
			elseif shoes == 62 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 62, shoes_texture, 2)
			elseif shoes == 63 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 63, shoes_texture, 2)
			elseif shoes == 64 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 64, shoes_texture, 2)
			elseif shoes == 65 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 65, shoes_texture, 2)
			elseif shoes == 66 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 66, shoes_texture, 2)
			elseif shoes == 67 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 67, shoes_texture, 2)
			elseif shoes == 68 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 68, shoes_texture, 2)
			elseif shoes == 69 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 69, shoes_texture, 2)
			elseif shoes == 70 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 70, shoes_texture, 2)
			elseif shoes == 71 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 71, shoes_texture, 2)
			elseif shoes == 72 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 72, shoes_texture, 2)
			elseif shoes == 73 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 73, shoes_texture, 2)
			elseif shoes == 74 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 74, shoes_texture, 2)
			elseif shoes == 75 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 75, shoes_texture, 2)
			elseif shoes == 76 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 76, shoes_texture, 2)
			elseif shoes == 77 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 77, shoes_texture, 2)
			elseif shoes == 78 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 78, shoes_texture, 2)
			elseif shoes == 79 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 79, shoes_texture, 2)
			elseif shoes == 80 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 80, shoes_texture, 2)
			elseif shoes == 81 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 81, shoes_texture, 2)
			elseif shoes == 82 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 82, shoes_texture, 2)
			elseif shoes == 83 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 83, shoes_texture, 2)
			elseif shoes == 84 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 84, shoes_texture, 2)
			elseif shoes == 85 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 85, shoes_texture, 2)
			elseif shoes == 86 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 86, shoes_texture, 2)
			elseif shoes == 87 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 87, shoes_texture, 2)
			elseif shoes == 88 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 88, shoes_texture, 2)
			elseif shoes == 89 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 89, shoes_texture, 2)
			elseif shoes == 90 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 90, shoes_texture, 2)
			elseif shoes == 91 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 0, shoes_texture, 2)
			elseif shoes == 92 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 0, shoes_texture, 2)
			elseif shoes == 93 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 0, shoes_texture, 2)
			elseif shoes == 94 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 0, shoes_texture, 2)			
			end
			
		else
			if tops == 0 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 1 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 20, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 1, tops_texture, 2) 	-- Torso 2
			elseif tops == 2 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 2, tops_texture, 2) 	-- Torso 2
			elseif tops == 3 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 10, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 3, tops_texture, 2) 	-- Torso 2
			elseif tops == 4 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 6, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 4, tops_texture, 2) 	-- Torso 2
			elseif tops == 5 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 6, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 5, tops_texture, 2) 	-- Torso 2
			elseif tops == 6 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 6, tops_texture, 2) 	-- Torso 2
			elseif tops == 7 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 7, tops_texture, 2) 	-- Torso 2
			elseif tops == 8 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 8, tops_texture, 2) 	-- Torso 2
			elseif tops == 9 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 9, tops_texture, 2) 	-- Torso 2
			elseif tops == 10 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 21, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 10, tops_texture, 2) 	-- Torso 2
			elseif tops == 11 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 11, tops_texture, 2) 	-- Torso 2
			elseif tops == 12 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 12, tops_texture, 2) 	-- Torso 2
			elseif tops == 13 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 13, tops_texture, 2) 	-- Torso 2
			elseif tops == 14 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 14, tops_texture, 2) 	-- Torso 2
			elseif tops == 15 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 16 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 16, tops_texture, 2) 	-- Torso 2
			elseif tops == 17 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 17, tops_texture, 2) 	-- Torso 2
			elseif tops == 18 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 18, tops_texture, 2) 	-- Torso 2
			elseif tops == 19 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 19, tops_texture, 2) 	-- Torso 2
			elseif tops == 20 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 20, tops_texture, 2) 	-- Torso 2
			elseif tops == 21 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 21, tops_texture, 2) 	-- Torso 2
			elseif tops == 22 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 22, tops_texture, 2) 	-- Torso 2
			elseif tops == 23 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 23, tops_texture, 2) 	-- Torso 2
			elseif tops == 24 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 24, tops_texture, 2) 	-- Torso 2
			elseif tops == 25 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 25, tops_texture, 2) 	-- Torso 2
			elseif tops == 26 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 26, tops_texture, 2) 	-- Torso 2
			elseif tops == 27 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 27, tops_texture, 2) 	-- Torso 2
			elseif tops == 28 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 28, tops_texture, 2) 	-- Torso 2
			elseif tops == 29 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 30 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 1, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 30, tops_texture, 2) 	-- Torso 2
			elseif tops == 31 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 31, tops_texture, 2) 	-- Torso 2
			elseif tops == 32 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 32, tops_texture, 2) 	-- Torso 2
			elseif tops == 33 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 33, tops_texture, 2) 	-- Torso 2
			elseif tops == 34 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 34, tops_texture, 2) 	-- Torso 2
			elseif tops == 35 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 35, tops_texture, 2) 	-- Torso 2
			elseif tops == 36 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 36, tops_texture, 2) 	-- Torso 2
			elseif tops == 37 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 37, tops_texture, 2) 	-- Torso 2
			elseif tops == 38 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 38, tops_texture, 2) 	-- Torso 2
			elseif tops == 39 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 39, tops_texture, 2) 	-- Torso 2
			elseif tops == 40 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 40, tops_texture, 2) 	-- Torso 2
			elseif tops == 41 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 41, tops_texture, 2) 	-- Torso 2
			elseif tops == 42 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 42, tops_texture, 2) 	-- Torso 2
			elseif tops == 43 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 43, tops_texture, 2) 	-- Torso 2
			elseif tops == 44 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 44, tops_texture, 2) 	-- Torso 2
			elseif tops == 45 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 45, tops_texture, 2) 	-- Torso 2
			elseif tops == 46 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 46, tops_texture, 2) 	-- Torso 2
			elseif tops == 47 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 47, tops_texture, 2) 	-- Torso 2
			elseif tops == 48 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 49 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 49, tops_texture, 2) 	-- Torso 2
			elseif tops == 50 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 50, tops_texture, 2) 	-- Torso 2
			elseif tops == 51 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 51, tops_texture, 2) 	-- Torso 2
			elseif tops == 52 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 52, tops_texture, 2) 	-- Torso 2
			elseif tops == 53 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 53, tops_texture, 2) 	-- Torso 2
			elseif tops == 54 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 54, tops_texture, 2) 	-- Torso 2
			elseif tops == 55 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 55, tops_texture, 2) 	-- Torso 2
			elseif tops == 56 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 	-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 		-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 56, tops_texture, 2) 	-- Torso 2
			elseif tops == 57 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 51, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 57, tops_texture, 2) 	-- Torso 2
			elseif tops == 58 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 29, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 58, tops_texture, 2) 	-- Torso 2
			elseif tops == 59 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 51, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 59, tops_texture, 2) 	-- Torso 2
			elseif tops == 60 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 51, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 59, tops_texture, 2) 	-- Torso 2
			elseif tops == 61 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 61, tops_texture, 2) 	-- Torso 2
			elseif tops == 62 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 62, tops_texture, 2) 	-- Torso 2
			elseif tops == 63 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 63, tops_texture, 2) 	-- Torso 2
			elseif tops == 64 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 64, tops_texture, 2) 	-- Torso 2
			elseif tops == 65 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 65, tops_texture, 2) 	-- Torso 2
			elseif tops == 66 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 21, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 66, tops_texture, 2) 	-- Torso 2
			elseif tops == 67 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 67, tops_texture, 2) 	-- Torso 2
			elseif tops == 68 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 68, tops_texture, 2) 	-- Torso 2
			elseif tops == 69 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 69, tops_texture, 2) 	-- Torso 2
			elseif tops == 70 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 70, tops_texture, 2) 	-- Torso 2
			elseif tops == 71 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 71, tops_texture, 2) 	-- Torso 2
			elseif tops == 72 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 72, tops_texture, 2) 	-- Torso 2
			elseif tops == 73 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 73, tops_texture, 2) 	-- Torso 2
			elseif tops == 74 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 74, tops_texture, 2) 	-- Torso 2
			elseif tops == 75 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 75, tops_texture, 2) 	-- Torso 2
			elseif tops == 76 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 76, tops_texture, 2) 	-- Torso 2
			elseif tops == 77 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 77, tops_texture, 2) 	-- Torso 2
			elseif tops == 78 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 78, tops_texture, 2) 	-- Torso 2
			elseif tops == 79 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 79, tops_texture, 2) 	-- Torso 2
			elseif tops == 80 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 80, tops_texture, 2) 	-- Torso 2
			elseif tops == 81 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 81, tops_texture, 2) 	-- Torso 2
			elseif tops == 82 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 83 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 83, tops_texture, 2) 	-- Torso 2
			elseif tops == 84 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 84, tops_texture, 2) 	-- Torso 2
			elseif tops == 85 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 85, 0, 2) 	-- Torso 2
			elseif tops == 86 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, 0, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 86, 0, 2) 	-- Torso 2
			elseif tops == 87 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 87, tops_texture, 2) 	-- Torso 2
			elseif tops == 88 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 88, tops_texture, 2) 	-- Torso 2
			elseif tops == 89 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 89, tops_texture, 2) 	-- Torso 2
			elseif tops == 90 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 90, tops_texture, 2) 	-- Torso 2
			elseif tops == 91 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 91, tops_texture, 2) 	-- Torso 2
			elseif tops == 92 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 92, tops_texture, 2) 	-- Torso 2
			elseif tops == 93 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 59, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 93, tops_texture, 2) 	-- Torso 2
			elseif tops == 94 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 94, tops_texture, 2) 	-- Torso 2
			elseif tops == 95 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 59, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 95, tops_texture, 2) 	-- Torso 2
			elseif tops == 96 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 96, tops_texture, 2) 	-- Torso 2
			elseif tops == 97 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 97, tops_texture, 2) 	-- Torso 2
			elseif tops == 98 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 98, tops_texture, 2) 	-- Torso 2
			elseif tops == 99 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 99, tops_texture, 2) 	-- Torso 2
			elseif tops == 100 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 100, tops_texture, 2) 	-- Torso 2
			elseif tops == 101 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 101, tops_texture, 2) 	-- Torso 2
			elseif tops == 102 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 102, tops_texture, 2) 	-- Torso 2
			elseif tops == 103 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 103, tops_texture, 2) 	-- Torso 2
			elseif tops == 104 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 104, tops_texture, 2) 	-- Torso 2
			elseif tops == 105 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 105, tops_texture, 2) 	-- Torso 2
			elseif tops == 106 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 106, tops_texture, 2) 	-- Torso 2
			elseif tops == 107 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 107, tops_texture, 2) 	-- Torso 2
			elseif tops == 108 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 108, tops_texture, 2) 	-- Torso 2
			elseif tops == 109 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 109, tops_texture, 2) 	-- Torso 2
			elseif tops == 110 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 110, tops_texture, 2) 	-- Torso 2
			elseif tops == 111 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 111, tops_texture, 2) 	-- Torso 2
			elseif tops == 112 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 112, tops_texture, 2) 	-- Torso 2
			elseif tops == 113 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 113, tops_texture, 2) 	-- Torso 2
			elseif tops == 114 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 114, tops_texture, 2) 	-- Torso 2
			elseif tops == 115 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 115, tops_texture, 2) 	-- Torso 2
			elseif tops == 116 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 116, tops_texture, 2) 	-- Torso 2
			elseif tops == 117 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 117, tops_texture, 2) 	-- Torso 2
			elseif tops == 118 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 118, tops_texture, 2) 	-- Torso 2
			elseif tops == 119 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 119, tops_texture, 2) 	-- Torso 2
			elseif tops == 120 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 120, tops_texture, 2) 	-- Torso 2
			elseif tops == 121 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 121, tops_texture, 2) 	-- Torso 2
			elseif tops == 122 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 122, tops_texture, 2) 	-- Torso 2
			elseif tops == 123 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 123, tops_texture, 2) 	-- Torso 2
			elseif tops == 124 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 15, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 0, tops_texture, 2) 	-- Torso 2
			elseif tops == 125 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 125, tops_texture, 2) 	-- Torso 2
			elseif tops == 126 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 126, tops_texture, 2) 	-- Torso 2
			elseif tops == 127 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 127, tops_texture, 2) 	-- Torso 2
			elseif tops == 128 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 128, tops_texture, 2) 	-- Torso 2
			elseif tops == 129 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 129, tops_texture, 2) 	-- Torso 2
			elseif tops == 130 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 130, tops_texture, 2) 	-- Torso 2
			elseif tops == 131 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 131, tops_texture, 2) 	-- Torso 2
			elseif tops == 132 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 132, tops_texture, 2) 	-- Torso 2
			elseif tops == 133 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 133, tops_texture, 2) 	-- Torso 2
			elseif tops == 134 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 134, tops_texture, 2) 	-- Torso 2
			elseif tops == 135 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 135, tops_texture, 2) 	-- Torso 2
			elseif tops == 136 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 136, tops_texture, 2) 	-- Torso 2
			elseif tops == 137 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 137, tops_texture, 2) 	-- Torso 2
			elseif tops == 138 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 138, tops_texture, 2) 	-- Torso 2
			elseif tops == 139 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 139, tops_texture, 2) 	-- Torso 2
			elseif tops == 140 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 140, tops_texture, 2) 	-- Torso 2
			elseif tops == 141 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 141, tops_texture, 2) 	-- Torso 2
			elseif tops == 142 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 142, tops_texture, 2) 	-- Torso 2
			elseif tops == 143 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 143, tops_texture, 2) 	-- Torso 2
			elseif tops == 144 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 144, tops_texture, 2) 	-- Torso 2
			elseif tops == 145 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 145, tops_texture, 2) 	-- Torso 2
			elseif tops == 146 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 146, tops_texture, 2) 	-- Torso 2
			elseif tops == 147 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 147, tops_texture, 2) 	-- Torso 2
			elseif tops == 148 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 148, tops_texture, 2) 	-- Torso 2
			elseif tops == 149 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 149, tops_texture, 2) 	-- Torso 2
			elseif tops == 150 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 150, tops_texture, 2) 	-- Torso 2
			elseif tops == 151 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 151, tops_texture, 2) 	-- Torso 2
			elseif tops == 152 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 152, tops_texture, 2) 	-- Torso 2
			elseif tops == 153 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 153, tops_texture, 2) 	-- Torso 2
			elseif tops == 154 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 154, tops_texture, 2) 	-- Torso 2
			elseif tops == 155 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 155, tops_texture, 2) 	-- Torso 2
			elseif tops == 156 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 156, tops_texture, 2) 	-- Torso 2
			elseif tops == 157 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 157, tops_texture, 2) 	-- Torso 2
			elseif tops == 158 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 158, tops_texture, 2) 	-- Torso 2
			elseif tops == 159 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 159, tops_texture, 2) 	-- Torso 2
			elseif tops == 160 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 160, tops_texture, 2) 	-- Torso 2
			elseif tops == 161 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 161, tops_texture, 2) 	-- Torso 2
			elseif tops == 162 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 162, tops_texture, 2) 	-- Torso 2
			elseif tops == 163 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 163, tops_texture, 2) 	-- Torso 2
			elseif tops == 164 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 164, tops_texture, 2) 	-- Torso 2
			elseif tops == 165 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 165, tops_texture, 2) 	-- Torso 2
			elseif tops == 166 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 166, tops_texture, 2) 	-- Torso 2
			elseif tops == 167 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 167, tops_texture, 2) 	-- Torso 2
			elseif tops == 168 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 168, tops_texture, 2) 	-- Torso 2
			elseif tops == 169 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 169, tops_texture, 2) 	-- Torso 2
			elseif tops == 170 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 170, tops_texture, 2) 	-- Torso 2
			elseif tops == 171 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 171, tops_texture, 2) 	-- Torso 2
			elseif tops == 172 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 172, tops_texture, 2) 	-- Torso 2
			elseif tops == 173 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 173, tops_texture, 2) 	-- Torso 2
			elseif tops == 174 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 174, tops_texture, 2) 	-- Torso 2
			elseif tops == 175 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 175, tops_texture, 2) 	-- Torso 2
			elseif tops == 176 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 176, tops_texture, 2) 	-- Torso 2
			elseif tops == 177 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 177, tops_texture, 2) 	-- Torso 2
			elseif tops == 178 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 178, tops_texture, 2) 	-- Torso 2
			elseif tops == 179 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 179, tops_texture, 2) 	-- Torso 2
			elseif tops == 180 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 180, tops_texture, 2) 	-- Torso 2
			elseif tops == 181 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 181, tops_texture, 2) 	-- Torso 2
			elseif tops == 182 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 182, tops_texture, 2) 	-- Torso 2
			elseif tops == 183 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 183, tops_texture, 2) 	-- Torso 2
			elseif tops == 184 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 184, tops_texture, 2) 	-- Torso 2
			elseif tops == 185 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 185, tops_texture, 2) 	-- Torso 2
			elseif tops == 186 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 186, tops_texture, 2) 	-- Torso 2
			elseif tops == 187 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 187, tops_texture, 2) 	-- Torso 2
			elseif tops == 188 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 189 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 189, tops_texture, 2) 	-- Torso 2
			elseif tops == 190 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 190, tops_texture, 2) 	-- Torso 2
			elseif tops == 191 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 191, tops_texture, 2) 	-- Torso 2
			elseif tops == 192 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 192, tops_texture, 2) 	-- Torso 2
			elseif tops == 193 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 193, tops_texture, 2) 	-- Torso 2
			elseif tops == 194 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 194, tops_texture, 2) 	-- Torso 2
			elseif tops == 195 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 195, tops_texture, 2) 	-- Torso 2
			elseif tops == 196 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 196, tops_texture, 2) 	-- Torso 2
			elseif tops == 197 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 197, tops_texture, 2) 	-- Torso 2
			elseif tops == 198 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 198, tops_texture, 2) 	-- Torso 2
			elseif tops == 199 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 199, tops_texture, 2) 	-- Torso 2
			elseif tops == 200 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 200, tops_texture, 2) 	-- Torso 2
			elseif tops == 201 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 201, tops_texture, 2) 	-- Torso 2
			elseif tops == 202 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 202, tops_texture, 2) 	-- Torso 2
			elseif tops == 203 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 204 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 204, tops_texture, 2) 	-- Torso 2
			elseif tops == 205 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 205, tops_texture, 2) 	-- Torso 2
			elseif tops == 206 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 206, tops_texture, 2) 	-- Torso 2
			elseif tops == 207 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 207, tops_texture, 2) 	-- Torso 2
			elseif tops == 208 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 208, tops_texture, 2) 	-- Torso 2
			elseif tops == 209 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 209, tops_texture, 2) 	-- Torso 2
			elseif tops == 210 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 210, tops_texture, 2) 	-- Torso 2
			elseif tops == 211 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 211, tops_texture, 2) 	-- Torso 2
			elseif tops == 212 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 212, tops_texture, 2) 	-- Torso 2
			elseif tops == 213 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 213, tops_texture, 2) 	-- Torso 2
			elseif tops == 214 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 214, tops_texture, 2) 	-- Torso 2
			elseif tops == 215 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 215, tops_texture, 2) 	-- Torso 2
			elseif tops == 216 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 216, tops_texture, 2) 	-- Torso 2
			elseif tops == 217 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 217, tops_texture, 2) 	-- Torso 2
			elseif tops == 218 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 218, tops_texture, 2) 	-- Torso 2
			elseif tops == 219 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 219, tops_texture, 2) 	-- Torso 2
			elseif tops == 220 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 220, tops_texture, 2) 	-- Torso 2
			elseif tops == 221 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 221, tops_texture, 2) 	-- Torso 2
			elseif tops == 222 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 222, tops_texture, 2) 	-- Torso 2
			elseif tops == 223 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 223, tops_texture, 2) 	-- Torso 2
			elseif tops == 224 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 224, tops_texture, 2) 	-- Torso 2
			elseif tops == 225 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 225, tops_texture, 2) 	-- Torso 2
			elseif tops == 226 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 226, tops_texture, 2) 	-- Torso 2
			elseif tops == 227 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 227, tops_texture, 2) 	-- Torso 2
			elseif tops == 228 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 228, tops_texture, 2) 	-- Torso 2
			elseif tops == 229 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 229, tops_texture, 2) 	-- Torso 2
			elseif tops == 230 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 230, tops_texture, 2) 	-- Torso 2
			elseif tops == 231 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 231, tops_texture, 2) 	-- Torso 2
			elseif tops == 232 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 232, tops_texture, 2) 	-- Torso 2
			elseif tops == 233 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 233, tops_texture, 2) 	-- Torso 2
			elseif tops == 234 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 234, tops_texture, 2) 	-- Torso 2
			elseif tops == 235 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 235, tops_texture, 2) 	-- Torso 2
			elseif tops == 236 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 236, tops_texture, 2) 	-- Torso 2
			elseif tops == 237 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 237, tops_texture, 2) 	-- Torso 2
			elseif tops == 238 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 238, tops_texture, 2) 	-- Torso 2
			elseif tops == 239 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 239, tops_texture, 2) 	-- Torso 2
			elseif tops == 240 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 240, tops_texture, 2) 	-- Torso 2
			elseif tops == 241 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 241, tops_texture, 2) 	-- Torso 2
			elseif tops == 242 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 242, tops_texture, 2) 	-- Torso 2
			elseif tops == 243 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 243, tops_texture, 2) 	-- Torso 2
			elseif tops == 244 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 244, tops_texture, 2) 	-- Torso 2
			elseif tops == 245 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 245, tops_texture, 2) 	-- Torso 2
			elseif tops == 246 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 246, tops_texture, 2) 	-- Torso 2
			elseif tops == 247 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 247, tops_texture, 2) 	-- Torso 2
			elseif tops == 248 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 248, tops_texture, 2) 	-- Torso 2
			elseif tops == 249 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 249, tops_texture, 2) 	-- Torso 2
			elseif tops == 250 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 250, tops_texture, 2) 	-- Torso 2
			elseif tops == 251 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 251, tops_texture, 2) 	-- Torso 2
			elseif tops == 252 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 252, tops_texture, 2) 	-- Torso 2
			elseif tops == 253 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 253, tops_texture, 2) 	-- Torso 2
			elseif tops == 254 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 255 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 11, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 255, tops_texture, 2) 	-- Torso 2
			elseif tops == 256 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 256, tops_texture, 2) 	-- Torso 2
			elseif tops == 257 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 257, tops_texture, 2) 	-- Torso 2
			elseif tops == 258 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 258, tops_texture, 2) 	-- Torso 2
			elseif tops == 259 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 259, tops_texture, 2) 	-- Torso 2
			elseif tops == 260 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 261 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 2, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 261, tops_texture, 2) 	-- Torso 2
			elseif tops == 262 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 262, tops_texture, 2) 	-- Torso 2
			elseif tops == 263 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 263, tops_texture, 2) 	-- Torso 2
			elseif tops == 264 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 264, tops_texture, 2) 	-- Torso 2
			elseif tops == 265 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 265, tops_texture, 2) 	-- Torso 2
			elseif tops == 266 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 266, tops_texture, 2) 	-- Torso 2
			elseif tops == 267 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 267, tops_texture, 2) 	-- Torso 2
			elseif tops == 268 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 268, tops_texture, 2) 	-- Torso 2
			elseif tops == 269 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 269, tops_texture, 2) 	-- Torso 2
			elseif tops == 270 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 270, tops_texture, 2) 	-- Torso 2
			elseif tops == 271 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 271, tops_texture, 2) 	-- Torso 2
			elseif tops == 272 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 272, tops_texture, 2) 	-- Torso 2
			elseif tops == 273 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 273, tops_texture, 2) 	-- Torso 2
			elseif tops == 274 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 274, tops_texture, 2) 	-- Torso 2
			elseif tops == 275 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 9, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 275, tops_texture, 2) 	-- Torso 2
			elseif tops == 276 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 276, tops_texture, 2) 	-- Torso 2
			elseif tops == 277 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 277, tops_texture, 2) 	-- Torso 2
			elseif tops == 278 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 7, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 0, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 278, tops_texture, 2) 	-- Torso 2
			elseif tops == 279 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 279, tops_texture, 2) 	-- Torso 2
			elseif tops == 280 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 280, tops_texture, 2) 	-- Torso 2
			elseif tops == 281 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 281, tops_texture, 2) 	-- Torso 2
			elseif tops == 282 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 282, tops_texture, 2) 	-- Torso 2
			elseif tops == 283 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 12, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 283, tops_texture, 2) 	-- Torso 2
			elseif tops == 284 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 284, tops_texture, 2) 	-- Torso 2
			elseif tops == 285 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 285, tops_texture, 2) 	-- Torso 2
			elseif tops == 286 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 286, tops_texture, 2) 	-- Torso 2
			elseif tops == 287 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 14, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 15, tops_texture, 2) 	-- Torso 2
			elseif tops == 288 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 288, tops_texture, 2) 	-- Torso 2
			elseif tops == 289 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 289, tops_texture, 2) 	-- Torso 2
			elseif tops == 290 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 294, tops_texture, 2) 	-- Torso 2
			elseif tops == 291 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 1, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 295, tops_texture, 2) 	-- Torso 2
			elseif tops == 292 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 292, tops_texture, 2) 	-- Torso 2
			elseif tops == 293 then
				SetPedComponentVariation(GetPlayerPed(-1), 3, 3, 0, 2)		-- Torso
				SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) 		-- Neck
				SetPedComponentVariation(GetPlayerPed(-1), 8, 2, tops_texture2, 2) 	-- Undershirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 293, tops_texture, 2) 	-- Torso 2
			end
		
			if pants == 0 then 		SetPedComponentVariation(GetPlayerPed(-1), 4, 15, pants_texture, 2)
			elseif pants == 1 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 1, pants_texture, 2)
			elseif pants == 2 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 2, pants_texture, 2)
			elseif pants == 3 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 3, pants_texture, 2)
			elseif pants == 4 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 4, pants_texture, 2)
			elseif pants == 5 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 5, pants_texture, 2)
			elseif pants == 6 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 6, pants_texture, 2)
			elseif pants == 7 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 7, pants_texture, 2)
			elseif pants == 8 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 8, pants_texture, 2)
			elseif pants == 9 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 9, pants_texture, 2)
			elseif pants == 10 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 10, pants_texture, 2)
			elseif pants == 11 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 11, pants_texture, 2)
			elseif pants == 12 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 12, pants_texture, 2)
			elseif pants == 13 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 14 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 14, pants_texture, 2)
			elseif pants == 15 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 15, pants_texture, 2)
			elseif pants == 16 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 16, pants_texture, 2)
			elseif pants == 17 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 17, pants_texture, 2)
			elseif pants == 18 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 18, pants_texture, 2)
			elseif pants == 19 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 19, pants_texture, 2)
			elseif pants == 20 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 20, pants_texture, 2)
			elseif pants == 21 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 21, pants_texture, 2)
			elseif pants == 22 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 22, pants_texture, 2)
			elseif pants == 23 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 23, pants_texture, 2)
			elseif pants == 24 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 24, pants_texture, 2)
			elseif pants == 25 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 25, pants_texture, 2)
			elseif pants == 26 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 26, pants_texture, 2)
			elseif pants == 27 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 27, pants_texture, 2)
			elseif pants == 28 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 28, pants_texture, 2)
			elseif pants == 29 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 29, pants_texture, 2)
			elseif pants == 30 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 30, pants_texture, 2)
			elseif pants == 31 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 31, pants_texture, 2)
			elseif pants == 32 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 33 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 33, pants_texture, 2)
			elseif pants == 34 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 34, pants_texture, 2)
			elseif pants == 35 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 35, pants_texture, 2)
			elseif pants == 36 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 36, pants_texture, 2)
			elseif pants == 37 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 37, pants_texture, 2)
			elseif pants == 38 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 39 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 40 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 41 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 41, pants_texture, 2)
			elseif pants == 42 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 43 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 43, pants_texture, 2)
			elseif pants == 44 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 44, pants_texture, 2)
			elseif pants == 45 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 45, pants_texture, 2)
			elseif pants == 46 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 47 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 47, pants_texture, 2)
			elseif pants == 48 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 48, pants_texture, 2)
			elseif pants == 49 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 49, pants_texture, 2)
			elseif pants == 50 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 50, pants_texture, 2)
			elseif pants == 51 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 51, pants_texture, 2)
			elseif pants == 52 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 52, pants_texture, 2)
			elseif pants == 53 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 53, pants_texture, 2)
			elseif pants == 54 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 54, pants_texture, 2)
			elseif pants == 55 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 55, pants_texture, 2)
			elseif pants == 56 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 56, pants_texture, 2)
			elseif pants == 57 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 57, pants_texture, 2)
			elseif pants == 58 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 58, pants_texture, 2)
			elseif pants == 59 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 60 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 60, pants_texture, 2)
			elseif pants == 61 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 62 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 62, pants_texture, 2)
			elseif pants == 63 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 63, pants_texture, 2)
			elseif pants == 64 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 64, pants_texture, 2)
			elseif pants == 65 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 65, pants_texture, 2)
			elseif pants == 66 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 66, pants_texture, 2)
			elseif pants == 67 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 67, pants_texture, 2)
			elseif pants == 68 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 69 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)			
			elseif pants == 70 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 71 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 71, pants_texture, 2)
			elseif pants == 72 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 73 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 73, pants_texture, 2)
			elseif pants == 74 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 74, pants_texture, 2)
			elseif pants == 75 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 75, pants_texture, 2)
			elseif pants == 76 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 76, pants_texture, 2)
			elseif pants == 77 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 77, pants_texture, 2)
			elseif pants == 78 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 78, pants_texture, 2)
			elseif pants == 79 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 80 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 80, pants_texture, 2)
			elseif pants == 81 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 81, pants_texture, 2)
			elseif pants == 82 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 82, pants_texture, 2)
			elseif pants == 83 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 83, pants_texture, 2)
			elseif pants == 84 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 84, pants_texture, 2)
			elseif pants == 85 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 85, pants_texture, 2)
			elseif pants == 86 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 87 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 87, pants_texture, 2)
			elseif pants == 88 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 88, pants_texture, 2)
			elseif pants == 89 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 89, pants_texture, 2)
			elseif pants == 90 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 91 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 91, pants_texture, 2)
			elseif pants == 92 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 92, pants_texture, 2)
			elseif pants == 93 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 93, pants_texture, 2)
			elseif pants == 94 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 95 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 96 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 97 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 97, pants_texture, 2)
			elseif pants == 98 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 98, pants_texture, 2)
			elseif pants == 99 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 99, pants_texture, 2)
			elseif pants == 100 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 101 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 101, pants_texture, 2)
			elseif pants == 102 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 102, pants_texture, 2)
			elseif pants == 103 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 104 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 104, pants_texture, 2)
			elseif pants == 105 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 0, pants_texture, 2)
			elseif pants == 106 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 106, pants_texture, 2)
			elseif pants == 107 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 107, pants_texture, 2)
			elseif pants == 108 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 108, pants_texture, 2)
			elseif pants == 109 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 109, pants_texture, 2)
			elseif pants == 110 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 110, pants_texture, 2)
			elseif pants == 111 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 111, pants_texture, 2)
			elseif pants == 112 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 112, pants_texture, 2)
			elseif pants == 113 then	SetPedComponentVariation(GetPlayerPed(-1), 4, 113, pants_texture, 2)
			end
            if shoes == 0 then		SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2)
			elseif shoes == 1 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 2 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 2, shoes_texture, 2)
			elseif shoes == 3 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 3, shoes_texture, 2)
			elseif shoes == 4 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 4, shoes_texture, 2)
			elseif shoes == 5 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 5, shoes_texture, 2)
			elseif shoes == 6 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 6, shoes_texture, 2)
			elseif shoes == 7 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 7, shoes_texture, 2)
			elseif shoes == 8 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 8, shoes_texture, 2)
			elseif shoes == 9 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 9, shoes_texture, 2)
			elseif shoes == 10 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 10, shoes_texture, 2)
			elseif shoes == 11 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 11, shoes_texture, 2)
			elseif shoes == 12 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 13 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 13, shoes_texture, 2)
			elseif shoes == 14 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 14, shoes_texture, 2)
			elseif shoes == 15 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 15, shoes_texture, 2)
			elseif shoes == 16 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 16, shoes_texture, 2)
			elseif shoes == 17 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 17, shoes_texture, 2)
			elseif shoes == 18 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 19 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 19, shoes_texture, 2)
			elseif shoes == 20 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 20, shoes_texture, 2)
			elseif shoes == 21 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 21, shoes_texture, 2)
			elseif shoes == 22 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 22, shoes_texture, 2)
			elseif shoes == 23 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 23, shoes_texture, 2)
			elseif shoes == 24 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 24, shoes_texture, 2)
			elseif shoes == 25 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 25, shoes_texture, 2)
			elseif shoes == 26 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 26, shoes_texture, 2)
			elseif shoes == 27 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 27, shoes_texture, 2)
			elseif shoes == 28 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 28, shoes_texture, 2)
			elseif shoes == 29 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 29, shoes_texture, 2)
			elseif shoes == 30 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 30, shoes_texture, 2)
			elseif shoes == 31 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 31, shoes_texture, 2)
			elseif shoes == 32 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 32, shoes_texture, 2)
			elseif shoes == 33 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 33, shoes_texture, 2)
			elseif shoes == 34 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 35 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 35, shoes_texture, 2)
			elseif shoes == 36 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 36, shoes_texture, 2)
			elseif shoes == 37 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 37, shoes_texture, 2)
			elseif shoes == 38 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 38, shoes_texture, 2)
			elseif shoes == 39 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 39, shoes_texture, 2)
			elseif shoes == 40 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 41 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 1, shoes_texture, 2)
			elseif shoes == 42 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 42, shoes_texture, 2)
			elseif shoes == 43 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 43, shoes_texture, 2)
			elseif shoes == 44 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 44, shoes_texture, 2)
			elseif shoes == 45 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 45, shoes_texture, 2)
			elseif shoes == 46 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 46, shoes_texture, 2)
			elseif shoes == 47 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 47, shoes_texture, 2)
			elseif shoes == 48 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 48, shoes_texture, 2)
			elseif shoes == 49 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 49, shoes_texture, 2)
			elseif shoes == 50 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 50, shoes_texture, 2)
			elseif shoes == 51 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 51, shoes_texture, 2)
			elseif shoes == 52 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 52, shoes_texture, 2)
			elseif shoes == 53 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 53, shoes_texture, 2)
			elseif shoes == 54 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 54, shoes_texture, 2)
			elseif shoes == 55 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 55, shoes_texture, 2)
			elseif shoes == 56 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 56, shoes_texture, 2)
			elseif shoes == 57 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 57, shoes_texture, 2)
			elseif shoes == 58 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 58, shoes_texture, 2)
			elseif shoes == 59 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 59, shoes_texture, 2)
			elseif shoes == 60 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 60, shoes_texture, 2)
			elseif shoes == 61 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 61, shoes_texture, 2)
			elseif shoes == 62 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 62, shoes_texture, 2)
			elseif shoes == 63 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 63, shoes_texture, 2)
			elseif shoes == 64 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 64, shoes_texture, 2)
			elseif shoes == 65 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 65, shoes_texture, 2)
			elseif shoes == 66 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 66, shoes_texture, 2)
			elseif shoes == 67 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 67, shoes_texture, 2)
			elseif shoes == 68 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 68, shoes_texture, 2)
			elseif shoes == 69 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 69, shoes_texture, 2)
			elseif shoes == 70 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 70, shoes_texture, 2)
			elseif shoes == 71 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 71, shoes_texture, 2)
			elseif shoes == 72 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 72, shoes_texture, 2)
			elseif shoes == 73 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 73, shoes_texture, 2)
			elseif shoes == 74 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 74, shoes_texture, 2)
			elseif shoes == 75 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 75, shoes_texture, 2)
			elseif shoes == 76 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 76, shoes_texture, 2)
			elseif shoes == 77 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 77, shoes_texture, 2)
			elseif shoes == 78 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 78, shoes_texture, 2)
			elseif shoes == 79 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 79, shoes_texture, 2)
			elseif shoes == 80 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 80, shoes_texture, 2)
			elseif shoes == 81 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 81, shoes_texture, 2)
			elseif shoes == 82 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 82, shoes_texture, 2)
			elseif shoes == 83 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 83, shoes_texture, 2)
			elseif shoes == 84 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 84, shoes_texture, 2)
			elseif shoes == 85 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 85, shoes_texture, 2)
			elseif shoes == 86 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 86, shoes_texture, 2)
			elseif shoes == 87 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 87, shoes_texture, 2)
			elseif shoes == 88 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 88, shoes_texture, 2)
			elseif shoes == 89 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 89, shoes_texture, 2)
			elseif shoes == 90 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 90, shoes_texture, 2)
			elseif shoes == 91 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 91, shoes_texture, 2)
			elseif shoes == 92 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 92, shoes_texture, 2)
			elseif shoes == 93 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 93, shoes_texture, 2)
			elseif shoes == 94 then	SetPedComponentVariation(GetPlayerPed(-1), 6, 94, shoes_texture, 2)
		end
	end
		-- Unused yet
		-- These presets will be editable in V2 release SetPedPropIndex(GetPlayerPed(-1), 2, ears, ears_texture, 2)
	end)
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
function CloseClotheCreator()
	local ped = PlayerPedId()
	isClotheCreatorOpened = false
	ShowClotheCreator(false)
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
	
	if firstclothe == true then
		Citizen.Wait(550)
		TriggerEvent('rtx_selection:showmenu')
		firstclothe = false
	elseif firstclothe == false then
		SetPlayerInvincible(ped, false)
		TriggerEvent("rtx_property:SaveClothesToWardrobe")
	end
end

function ShowClotheCreator(enable)
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
				openClotheCreator = enable,
				gender = "muz"
			})
		else
			SendNUIMessage({
				openClotheCreator = enable,
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

RegisterNetEvent('hud:loadMenuClothe')
AddEventHandler('hud:loadMenuClothe', function()
	ShowClotheCreator(true)
end)

RegisterNetEvent('hud:loadMenuClotheFIRST')
AddEventHandler('hud:loadMenuClotheFIRST', function()
	firstclothe = true
	ShowClotheCreator(true)
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

--esx_clotheskin code--
function OpenMenuClothe(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict MenuClothe
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

		ESX.UI.MenuClothe.Open('default', GetCurrentResourceName(), 'skin', {
			title    = _U('skin_MenuClothe'),
			align    = 'top-left',
			elements = elements
		}, function(data, MenuClothe)
			TriggerEvent('skinchanger:getSkin', function(skin)
				lastSkinOld = skin
			end)

			submitCb(data, MenuClothe)
			DeleteSkinCam()
		end, function(data, MenuClothe)
			MenuClothe.close()
			DeleteSkinCam()
			TriggerEvent('skinchanger:loadSkin', lastSkinOld)

			if cancelCb ~= nil then
				cancelCb(data, MenuClothe)
			end
		end, function(data, MenuClothe)
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

					MenuClothe.update({name = elements[i].name}, newData)
				end

				MenuClothe.refresh()
			end
		end, function(data, MenuClothe)
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

function OpenSaveableMenuClothe(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkinOld = skin
	end)

	OpenMenuClothe(function(data, MenuClothe)
		MenuClothe.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_clotheskin:save', skin)

			if submitCb ~= nil then
				submitCb(data, MenuClothe)
			end
		end)

	end, cancelCb, restrict)
end

AddEventHandler('esx_clotheskin:getLastSkin', function(cb)
	cb(lastSkinOld)
end)

AddEventHandler('esx_clotheskin:setLastSkin', function(skin)
	lastSkinOld = skin
end)

RegisterNetEvent('esx_clotheskin:openMenuClothe')
AddEventHandler('esx_clotheskin:openMenuClothe', function(submitCb, cancelCb)
	OpenMenuClothe(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_clotheskin:openRestrictedMenuClothe')
AddEventHandler('esx_clotheskin:openRestrictedMenuClothe', function(submitCb, cancelCb, restrict)
	OpenMenuClothe(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_clotheskin:openSaveableMenuClothe')
AddEventHandler('esx_clotheskin:openSaveableMenuClothe', function(submitCb, cancelCb)
	ShowClotheCreator(true)
end)

RegisterNetEvent('esx_clotheskin:openSaveableRestrictedMenuClothe')
AddEventHandler('esx_clotheskin:openSaveableRestrictedMenuClothe', function(submitCb, cancelCb, restrict)
	OpenSaveableMenuClothe(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_clotheskin:requestSaveSkin')
AddEventHandler('esx_clotheskin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_clotheskin:responseSaveSkin', skin)
	end)
end)

function OpenShopMenu()
  
  local price = Config.price
  
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'shop_clothes',
    {
      title = _U('shop_clothes'),
	  align    = 'bottom-right',
      elements = {
        { label = _U('yes') .. ' (<span style="color:red;">$' .. price .. '</span>)', value = 'yes' },
        { label = _U('no'), value = 'no' },
      }
    },
    function (data, menu)
      if data.current.value == 'yes' then
        TriggerServerEvent('rtx_clotheshops:buyclothes', price)
      end
      menu.close()
    end,
    function (data, menu)
      menu.close()
    end
  )

end

AddEventHandler('rtx_clotheshopsshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

AddEventHandler('rtx_clotheshopsshop:hasExitedMarker', function(zone)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

end)

-- Create Blips
Citizen.CreateThread(function()

	for i=1, #Config.Shops, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 48)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('clothes'))
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
			TriggerEvent('rtx_clotheshopsshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('rtx_clotheshopsshop:hasExitedMarker', LastZone)
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
					OpenShopMenu()
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
        if GetEntityHealth(playerPed) <= 0 and isClotheCreatorOpened == true then
			CloseClotheCreator()
		end
    end
end)

