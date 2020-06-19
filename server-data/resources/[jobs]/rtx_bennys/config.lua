Config                            = {}
Config.Locale = 'en'
Config.DrawDistance = 20
Config.BuyItems  = 25
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = true
Config.EnableEmploy				  = true
Config.speed_up = 0.01
Config.speed_up_slow = 0.006 
Config.speed_down_slow = 0.0055 
Config.speed_down = 0.015

Config.max = 31.75 
Config.beforemax = 31.53 
Config.beforemin = 29.95 
Config.min = 29.83 
Config.spawndistance = 23

Config.debug = false

--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config.KeyToOpenCarGarage = 38			-- default 38 is E

Config.MechanicDatabaseName = 'bennys'	-- set the exact name from your jobs database for Mechanic

--Mechanic Car Garage:
Config.CarZones = {
	MechanicCarGarage = {
		Pos = {
			{x = -165.52,  y = -1302.9, z = 31.3},
		}
	}
}

-- Mechanic Car Garage Blip Settings:
Config.CarGarageSprite = 357
Config.CarGarageDisplay = 4
Config.CarGarageScale = 0.65
Config.CarGarageColour = 38
Config.CarGarageName = "Bennys Car Garage"
Config.EnableCarGarageBlip = false

-- Mechanic Car Garage Marker Settings:
Config.MechanicCarMarker = 27 													-- marker type
Config.MechanicCarMarkerColor = { r = 50, g = 50, b = 204, a = 100 } 			-- rgba color of the marker
Config.MechanicCarMarkerScale = { x = 1.5, y = 1.5, z = 1.0 }  				-- the scale for the marker on the x, y and z axis
Config.CarDraw3DText = "Tekan ~g~[E]~s~ untuk membuka ~y~Garasi Bennys~s~"				-- set your desired text here

-- -- Mechanic Cars:
Config.MechanicVehicles = {
	{ model = 'flatbed3', label = 'FLATBED', price = 0 },
	{ model = 'towtruck', label = 'TOWING Truck', price = 0 }
}

-- Menu Labels & Titles:
Config.LabelStoreVeh = "Menyimpan Kendaraan"
Config.LabelGetVeh = "Mengambil Kendaraan"
Config.LabelPrimaryCol = "Primary"
Config.LabelSecondaryCol = "Secondary"
Config.LabelExtra = "Extra"
Config.LabelLivery = "Livery"
Config.TitleMechanicGarage = "Garasi Bennys"
Config.TitleMechanicExtra = "Extra"
Config.TitleMechanicLivery = "Livery"
Config.TitleColorType = "Color Type"
Config.TitleValues = "Value"

-- ESX.ShowNotifications:
Config.VehicleParked = "~b~Kendaraan~s~ disimpan!"
Config.NoVehicleNearby = "Tidak ada ~b~Kendaraan~s~ disekitar!"
Config.CarOutFromPolGar = "Kamu mengambil ~b~Kendaraan~s~ di ~y~Garasi Bennys~s~!"

Config.VehicleLoadText = "Wait for vehicle to spawn"			-- text on screen when vehicle model is being loaded

 

Config.Zones = {

	Cloakrooms = {

		Pos = {["x"] = -213.94, ["y"] = -1333.38, ["z"] = 30.89},

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},

	CarLift = {

		Pos = { x = -219.3204, y = -1326.43, z = 31.90041},

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},	
	
	CarLift2 = {

		Pos = { x = -212.44, y = -1317.55, z = 31.90041},

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1
   
	},
	
	
	ls1 = {

		Pos   = { x = -222.25, y = -1329.58, z = 30.89 },

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},
	
	ls2 = {

		Pos   = { x = -199.11, y = -1324.4, z = 31.13 },

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},
	
	ls3 = {

		Pos   = { x = -221.82, y = -1324.24, z = 31.13 },

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},

	BossMenu = {

		Pos = {["x"] = -208.06, ["y"] = -1341.21, ["z"] = 34.89},

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},

	InventoryMenu = {

		Pos = {["x"] = -196.32, ["y"] = -1315.21, ["z"] = 31.09},

		Size = {x = 1.5, y = 1.5, z = 1.0},

		Color = {r = 204, g = 204, b = 0},

		Type = -1

	},
	

	-- Vehicles = {

	-- 	Pos = {["x"] = -171.45, ["y"] = -1295.49, ["z"] = 32.14},

	-- 	Size = {x = 1.0, y = 1.0, z = 1.0},

	-- 	Color = {r = 255, g = 102, b = 255},

	-- 	Type = 36,

	-- 	Spawner = vector3(-171.45, -1295.49, 31.14),

	-- 	InsideShop = vector3(183.91, -1302.92, 31.29),

	-- 	SpawnPoints = {

	-- 		{coords = vector3(-164.18, -1299.0, 31.17), heading = 170.5, radius = 2.5},

	-- 		{coords = vector3(-158.58, -1298.67, 31.14), heading = 170.5, radius = 2.5},

	-- 		{coords = vector3(-158.25, -1304.87, 31.31), heading = 1.5, radius = 2.5},

	-- 		{coords = vector3(-164.68, -1305.38, 31.33), heading = 1.5, radius = 2.5},

	-- 		{coords = vector3(-169.11, -1305.54, 31.34), heading = 1.5, radius = 2.5}

	-- 	}

	-- }

}

Config.PickupItems = 
{
	{ 
		Pos = { x = -185.57, y = -1318.51, z = 31.3 },
		Heading = 93.76,
		InUse = false
	}
}

Config.ItemMarker = -1 														-- marker type
Config.ItemMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 				-- rgba color of the marker
Config.ItemMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  				-- the scale for the marker on the x, y and z axis
Config.DrawItem3DText = "Tekan ~g~[E]~s~ untuk mengambil ~b~Barang~s~"		-- set your desired text here
Config.KeyToStartItem = 38




Config.CraftItems = 
{
	{ 
		Pos = { x = -176.66, y = -1286.24, z = 31.3 },
		Heading = 271.69,
		InUse = false
	}
}

Config.CraftMarker = -1 														-- marker type
Config.CraftMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 				-- rgba color of the marker
Config.CraftMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  					-- the scale for the marker on the x, y and z axis
Config.DrawCraft3DText = "Tekan ~g~[E]~s~ untuk membuat ~b~RepairKit~s~"		-- set your desired text here
Config.KeyToStartCraft = 38



Config.Tires = 
{
	{ 
		Pos = { x = -227.34, y = -1334.33, z = 30.89 },
		Heading = 183.94,
		InUse = false
	}
}

Config.TireMarker = -1 														-- marker type
Config.TireMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 				-- rgba color of the marker
Config.TireMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  					-- the scale for the marker on the x, y and z axis
Config.DrawTire3DText = "Tekan ~g~[E]~s~ untuk mengambil ~b~Ban~s~"		-- set your desired text here
Config.KeyToStartTire = 38




Config.Uniforms = {
	working = {
		male = {
			["tshirt_1"] = 76,
			["tshirt_2"] = 1,
			["torso_1"] = 62,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 31,
			["pants_1"] = 9,
			["pants_2"] = 11,
			["shoes_1"] = 55,
			["shoes_2"] = 5,
			["helmet_1"] = 83,
			["helmet_2"] = 0,
			["chain_1"] = -1,
			["chain_2"] = 0,
			["ears_1"] = -1,
			["ears_2"] = 0
		},
		female = {
			["tshirt_1"] = 2,
			["tshirt_2"] = 0,
			["torso_1"] = 286,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 0,
			["pants_1"] = 92,
			["pants_2"] = 20,
			["shoes_1"] = 52,
			["shoes_2"] = 0,
			["helmet_1"] = -1,
			["helmet_2"] = -1,
			["chain_1"] = -1,
			["chain_2"] = 0,
			["ears_1"] = -1,
			["ears_2"] = 0
		}
	}
}

---------------------------------------------------------------------------------------------------
----------------------------------------------------------- LSCUSTOMS -----------------------------
---------------------------------------------------------------------------------------------------

Config.Colors = {
	{ label = _U('black'), value = 'black'},
	{ label = _U('white'), value = 'white'},
	{ label = _U('grey'), value = 'grey'},
	{ label = _U('red'), value = 'red'},
	{ label = _U('pink'), value = 'pink'},
	{ label = _U('blue'), value = 'blue'},
	{ label = _U('yellow'), value = 'yellow'},
	{ label = _U('green'), value = 'green'},
	{ label = _U('orange'), value = 'orange'},
	{ label = _U('brown'), value = 'brown'},
	{ label = _U('purple'), value = 'purple'},
	{ label = _U('chrome'), value = 'chrome'},
	{ label = _U('gold'), value = 'gold'}
}

function GetColors(color)
    local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = _U('black')},
			{ index = 1, label = _U('graphite')},
			{ index = 2, label = _U('black_metallic')},
			{ index = 3, label = _U('caststeel')},
			{ index = 11, label = _U('black_anth')},
			{ index = 12, label = _U('matteblack')},
			{ index = 15, label = _U('darknight')},
			{ index = 16, label = _U('deepblack')},
			{ index = 21, label = _U('oil')},
			{ index = 147, label = _U('carbon')}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = _U('vanilla')},
			{ index = 107, label = _U('creme')},
			{ index = 111, label = _U('white')},
			{ index = 112, label = _U('polarwhite')},
			{ index = 113, label = _U('beige')},
			{ index = 121, label = _U('mattewhite')},
			{ index = 122, label = _U('snow')},
			{ index = 131, label = _U('cotton')},
			{ index = 132, label = _U('alabaster')},
			{ index = 134, label = _U('purewhite')}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = _U('silver')},
			{ index = 5, label = _U('metallicgrey')},
			{ index = 6, label = _U('laminatedsteel')},
			{ index = 7, label = _U('darkgray')},
			{ index = 8, label = _U('rockygray')},
			{ index = 9, label = _U('graynight')},
			{ index = 10, label = _U('aluminum')},
			{ index = 13, label = _U('graymat')},
			{ index = 14, label = _U('lightgrey')},
			{ index = 17, label = _U('asphaltgray')},
			{ index = 18, label = _U('grayconcrete')},
			{ index = 19, label = _U('darksilver')},
			{ index = 20, label = _U('magnesite')},
			{ index = 22, label = _U('nickel')},
			{ index = 23, label = _U('zinc')},
			{ index = 24, label = _U('dolomite')},
			{ index = 25, label = _U('bluesilver')},
			{ index = 26, label = _U('titanium')},
			{ index = 66, label = _U('steelblue')},
			{ index = 93, label = _U('champagne')},
			{ index = 144, label = _U('grayhunter')},
			{ index = 156, label = _U('grey')}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = _U('red')},
			{ index = 28, label = _U('torino_red')},
			{ index = 29, label = _U('poppy')},
			{ index = 30, label = _U('copper_red')},
			{ index = 31, label = _U('cardinal')},
			{ index = 32, label = _U('brick')},
			{ index = 33, label = _U('garnet')},
			{ index = 34, label = _U('cabernet')},
			{ index = 35, label = _U('candy')},
			{ index = 39, label = _U('matte_red')},
			{ index = 40, label = _U('dark_red')},
			{ index = 43, label = _U('red_pulp')},
			{ index = 44, label = _U('bril_red')},
			{ index = 46, label = _U('pale_red')},
			{ index = 143, label = _U('wine_red')},
			{ index = 150, label = _U('volcano')}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = _U('electricpink')},
			{ index = 136, label = _U('salmon')},
			{ index = 137, label = _U('sugarplum')}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = _U('topaz')},
			{ index = 60, label = _U('light_blue')},
			{ index = 61, label = _U('galaxy_blue')},
			{ index = 62, label = _U('dark_blue')},
			{ index = 63, label = _U('azure')},
			{ index = 64, label = _U('navy_blue')},
			{ index = 65, label = _U('lapis')},
			{ index = 67, label = _U('blue_diamond')},
			{ index = 68, label = _U('surfer')},
			{ index = 69, label = _U('pastel_blue')},
			{ index = 70, label = _U('celeste_blue')},
			{ index = 73, label = _U('rally_blue')},
			{ index = 74, label = _U('blue_todise')},
			{ index = 75, label = _U('blue_night')},
			{ index = 77, label = _U('cyan_blue')},
			{ index = 78, label = _U('cobalt')},
			{ index = 79, label = _U('electric_blue')},
			{ index = 80, label = _U('horizon_blue')},
			{ index = 82, label = _U('metallic_blue')},
			{ index = 83, label = _U('aquamarine')},
			{ index = 84, label = _U('blue_agathe')},
			{ index = 85, label = _U('zirconium')},
			{ index = 86, label = _U('spinel')},
			{ index = 87, label = _U('tourmaline')},
			{ index = 127, label = _U('todise')},
			{ index = 140, label = _U('bubble_gum')},
			{ index = 141, label = _U('midnight_blue')},
			{ index = 146, label = _U('forbidden_blue')},
			{ index = 157, label = _U('glacier_blue')}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = _U('yellow')},
			{ index = 88, label = _U('wheat')},
			{ index = 89, label = _U('raceyellow')},
			{ index = 91, label = _U('paleyellow')},
			{ index = 126, label = _U('lightyellow')}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = _U('met_dark_green')},
			{ index = 50, label = _U('rally_green')},
			{ index = 51, label = _U('pine_green')},
			{ index = 52, label = _U('olive_green')},
			{ index = 53, label = _U('light_green')},
			{ index = 55, label = _U('lime_green')},
			{ index = 56, label = _U('forest_green')},
			{ index = 57, label = _U('lawn_green')},
			{ index = 58, label = _U('imperial_green')},
			{ index = 59, label = _U('green_bottle')},
			{ index = 92, label = _U('citrus_green')},
			{ index = 125, label = _U('green_anis')},
			{ index = 128, label = _U('khaki')},
			{ index = 133, label = _U('army_green')},
			{ index = 151, label = _U('dark_green')},
			{ index = 152, label = _U('hunter_green')},
			{ index = 155, label = _U('matte_foilage_green')}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = _U('tangerine')},
			{ index = 38, label = _U('orange')},
			{ index = 41, label = _U('matteorange')},
			{ index = 123, label = _U('lightorange')},
			{ index = 124, label = _U('peach')},
			{ index = 130, label = _U('pumpkin')},
			{ index = 138, label = _U('orangelambo')}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = _U('copper')},
			{ index = 47, label = _U('lightbrown')},
			{ index = 48, label = _U('darkbrown')},
			{ index = 90, label = _U('bronze')},
			{ index = 94, label = _U('brownmetallic')},
			{ index = 95, label = _U('Expresso')},
			{ index = 96, label = _U('chocolate')},
			{ index = 97, label = _U('terracotta')},
			{ index = 98, label = _U('marble')},
			{ index = 99, label = _U('sand')},
			{ index = 100, label = _U('sepia')},
			{ index = 101, label = _U('bison')},
			{ index = 102, label = _U('palm')},
			{ index = 103, label = _U('caramel')},
			{ index = 104, label = _U('rust')},
			{ index = 105, label = _U('chestnut')},
			{ index = 108, label = _U('brown')},
			{ index = 109, label = _U('hazelnut')},
			{ index = 110, label = _U('shell')},
			{ index = 114, label = _U('mahogany')},
			{ index = 115, label = _U('cauldron')},
			{ index = 116, label = _U('blond')},
			{ index = 129, label = _U('gravel')},
			{ index = 153, label = _U('darkearth')},
			{ index = 154, label = _U('desert')}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = _U('indigo')},
			{ index = 72, label = _U('deeppurple')},
			{ index = 76, label = _U('darkviolet')},
			{ index = 81, label = _U('amethyst')},
			{ index = 142, label = _U('mysticalviolet')},
			{ index = 145, label = _U('purplemetallic')},
			{ index = 148, label = _U('matteviolet')},
			{ index = 149, label = _U('mattedeeppurple')}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = _U('brushechrome')},
			{ index = 118, label = _U('blackchrome')},
			{ index = 119, label = _U('brushedaluminum')},
			{ index = 120, label = _U('chrome')}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = _U('gold')},
			{ index = 158, label = _U('puregold')},
			{ index = 159, label = _U('brushedgold')},
			{ index = 160, label = _U('lightgold')}
		}
	end
    return colors
end

function GetWindowName(index)
	if (index == 1) then
		return "Pure Black"
	elseif (index == 2) then
		return "Darksmoke"
	elseif (index == 3) then
		return "Lightsmoke"
	elseif (index == 4) then
		return "Limo"
	elseif (index == 5) then
		return "Green"
	else
		return "Unknown"
	end
end

function GetHornName(index)
	if (index == 0) then
		return "Truck Horn"
	elseif (index == 1) then
		return "Cop Horn"
	elseif (index == 2) then
		return "Clown Horn"
	elseif (index == 3) then
		return "Musical Horn 1"
	elseif (index == 4) then
		return "Musical Horn 2"
	elseif (index == 5) then
		return "Musical Horn 3"
	elseif (index == 6) then
		return "Musical Horn 4"
	elseif (index == 7) then
		return "Musical Horn 5"
	elseif (index == 8) then
		return "Sad Trombone"
	elseif (index == 9) then
		return "Classical Horn 1"
	elseif (index == 10) then
		return "Classical Horn 2"
	elseif (index == 11) then
		return "Classical Horn 3"
	elseif (index == 12) then
		return "Classical Horn 4"
	elseif (index == 13) then
		return "Classical Horn 5"
	elseif (index == 14) then
		return "Classical Horn 6"
	elseif (index == 15) then
		return "Classical Horn 7"
	elseif (index == 16) then
		return "Scale - Do"
	elseif (index == 17) then
		return "Scale - Re"
	elseif (index == 18) then
		return "Scale - Mi"
	elseif (index == 19) then
		return "Scale - Fa"
	elseif (index == 20) then
		return "Scale - Sol"
	elseif (index == 21) then
		return "Scale - La"
	elseif (index == 22) then
		return "Scale - Ti"
	elseif (index == 23) then
		return "Scale - Do"
	elseif (index == 24) then
		return "Jazz Horn 1"
	elseif (index == 25) then
		return "Jazz Horn 2"
	elseif (index == 26) then
		return "Jazz Horn 3"
	elseif (index == 27) then
		return "Jazz Horn Loop"
	elseif (index == 28) then
		return "Star Spangled Banner 1"
	elseif (index == 29) then
		return "Star Spangled Banner 2"
	elseif (index == 30) then
		return "Star Spangled Banner 3"
	elseif (index == 31) then
		return "Star Spangled Banner 4"
	elseif (index == 32) then
		return "Classical Horn 8 Loop"
	elseif (index == 33) then
		return "Classical Horn 9 Loop"
	elseif (index == 34) then
		return "Classical Horn 10 Loop"
	elseif (index == 35) then
		return "Classical Horn 8"
	elseif (index == 36) then
		return "Classical Horn 9"
	elseif (index == 37) then
		return "Classical Horn 10"
	elseif (index == 38) then
		return "Funeral Loop"
	elseif (index == 39) then
		return "Funeral"
	elseif (index == 40) then
		return "Spooky Loop"
	elseif (index == 41) then
		return "Spooky"
	elseif (index == 42) then
		return "San Andreas Loop"
	elseif (index == 43) then
		return "San Andreas"
	elseif (index == 44) then
		return "Liberty City Loop"
	elseif (index == 45) then
		return "Liberty City"
	elseif (index == 46) then
		return "Festive 1 Loop"
	elseif (index == 47) then
		return "Festive 1"
	elseif (index == 48) then
		return "Festive 2 Loop"
	elseif (index == 49) then
		return "Festive 2"
	elseif (index == 50) then
		return "Festive 3 Loop"
	elseif (index == 51) then
		return "Festive 3"
	else
		return "Unknown Horn"
	end
end

function GetNeons()
	local neons = {
	    { label = _U('white'), 			r = 255, 	g = 255, 	b = 255},
	    { label = "Slate Gray", 	r = 112, 	g = 128, 	b = 144},
	    { label = "Blue", 			r = 0, 		g = 0, 		b = 255},
	    { label = "Light Blue", 	r = 0, 		g = 150, 	b = 255},
	    { label = "Navy Blue", 		r = 0, 		g = 0, 		b = 128},
	    { label = "Sky Blue", 		r = 135, 	g = 206, 	b = 235},
	    { label = "Turquoise", 		r = 0, 		g = 245, 	b = 255},
	    { label = "Mint Green", 	r = 50, 	g = 255, 	b = 155},
	    { label = "Lime Green", 	r = 0, 		g = 255, 	b = 0},
	    { label = "Olive", 			r = 128, 	g = 128, 	b = 0},
	    { label = _U('yellow'), 		r = 255, 	g = 255, 	b = 0},
	    { label = _U('gold'), 			r = 255, 	g = 215, 	b = 0},
	    { label = _U('orange'), 		r = 255, 	g = 165, 	b = 0},
	    { label = _U('wheat'), 			r = 245, 	g = 222, 	b = 179},
	    { label = _U('red'), 			r = 255, 	g = 0, 		b = 0},
	    { label = _U('pink'), 			r = 255, 	g = 161, 	b = 211},
	    { label = _U('brightpink'), 	r = 255, 	g = 0, 		b = 255},
	    { label = _U('purple'), 		r = 153, 	g = 0, 		b = 153},
	    { label = "Ivory", 			r = 41, 	g = 36, 	b = 33}
   	}
   	return neons
end

function GetPlatesName(index)
	if (index == 0) then
		return _U('blue_on_white_1')
	elseif (index == 1) then
		return _U('yellow_on_black')
	elseif (index == 2) then
		return _U('yellow_blue')
	elseif (index == 3) then
		return _U('blue_on_white_2')
	elseif (index == 4) then
		return _U('blue_on_white_3')
	end
end
function RegisterLS()
	if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), Config.Zones.ls1.Pos.x, Config.Zones.ls1.Pos.y, Config.Zones.ls1.Pos.z, true) < 2) then
	Config.Menus = {
		main = {
			label = 'COSMETICS',
			parent = nil,
			cosmetics = _U('cosmetics')
		},
			cosmetics = {
			label				= _U('cosmetics'),
			parent				= 'main',
			bodyparts			= _U('bodyparts'),
			windowTint			= _U('windowtint'),
			modHorns			= _U('horns'),
			neonColor			= _U('neons'),
			modXenon			= _U('headlights'),
			plateIndex			= _U('licenseplates'),
			wheels				= _U('wheels'),
			modPlateHolder		= _U('modplateholder'),
			modVanityPlate		= _U('modvanityplate'),
			modTrimA			= _U('interior'),
			modOrnaments		= _U('trim'),
			modDashboard		= _U('dashboard'),
			modDial				= _U('speedometer'),
			modDoorSpeaker		= _U('door_speakers'),
			modSeats			= _U('seats'),
			modSteeringWheel	= _U('steering_wheel'),
			modShifterLeavers	= _U('gear_lever'),
			modAPlate			= _U('quarter_deck'),
			modSpeakers			= _U('speakers'),
			modTrunk			= _U('trunk'),
			modHydrolic			= _U('hydraulic'),
			modEngineBlock		= _U('engine_block'),
			modAirFilter		= _U('air_filter'),
			modStruts			= _U('struts'),
			modArchCover		= _U('arch_cover'),
			modAerials			= _U('aerials'),
			modTrimB			= _U('wings'),
			modTank				= _U('fuel_tank'),
			modWindows			= _U('windows')
		},

		modPlateHolder = {
			label = 'Plate - Back',
			parent = 'cosmetics',
			modType = 25,
			price = 1.1
		},
		modVanityPlate = {
			label = 'Plate - Front',
			parent = 'cosmetics',
			modType = 26,
			price = 1.1
		},
		modTrimA = {
			label = 'Trim',
			parent = 'cosmetics',
			modType = 27,
			price = 2.98
		},
		modOrnaments = {
			label = 'Ornament',
			parent = 'cosmetics',
			modType = 28,
			price = 0.9
		},
		modDashboard = {
			label = 'Dashboard',
			parent = 'cosmetics',
			modType = 29,
			price = 1.65
		},
		modDial = {
			label = 'Speedometer',
			parent = 'cosmetics',
			modType = 30,
			price = 4.19
		},
		modDoorSpeaker = {
			label = 'Door Speaker',
			parent = 'cosmetics',
			modType = 31,
			price = 2.58
		},
		modSeats = {
			label = 'Seats',
			parent = 'cosmetics',
			modType = 32,
			price = 2.65
		},
		modSteeringWheel = {
			label = 'Steering Wheel',
			parent = 'cosmetics',
			modType = 33,
			price = 2.19
		},
		modShifterLeavers = {
			label = 'Gear Lever',
			parent = 'cosmetics',
			modType = 34,
			price = 1.26
		},
		modAPlate = {
			label = 'Plate',
			parent = 'cosmetics',
			modType = 35,
			price = 2.19
		},
		modSpeakers = {
			label = 'Speaker',
			parent = 'cosmetics',
			modType = 36,
			price = 2.98
		},
		modTrunk = {
			label = 'Trunk',
			parent = 'cosmetics',
			modType = 37,
			price = 5.58
		},
		modHydrolic = {
			label = 'Hydrolic',
			parent = 'cosmetics',
			modType = 38,
			price = 5.12
		},
		modEngineBlock = {
			label = 'Engine Block',
			parent = 'cosmetics',
			modType = 39,
			price = 5.12
		},
		modAirFilter = {
			label = 'Air Filter',
			parent = 'cosmetics',
			modType = 40,
			price = 3.72
		},
		modStruts = {
			label = 'Struts',
			parent = 'cosmetics',
			modType = 41,
			price = 6.51
		},
		modArchCover = {
			label = 'Arch Cover',
			parent = 'cosmetics',
			modType = 42,
			price = 4.19
		},
		modAerials = {
			label = 'Antenna',
			parent = 'cosmetics',
			modType = 43,
			price = 1.12
		},
		modTrimB = {
			label = 'Trim',
			parent = 'cosmetics',
			modType = 44,
			price = 6.05
		},
		modTank = {
			label = 'Fuel Tank',
			parent = 'cosmetics',
			modType = 45,
			price = 4.19
		},
		modWindows = {
			label = 'Windows',
			parent = 'cosmetics',
			modType = 46,
			price = 4.19
		},

		wheels = {
			label = _U('wheels'),
			parent = 'cosmetics',
			modFrontWheelsTypes = _U('wheel_type'),
			tyreSmokeColor = _U('tiresmoke')
		},
		modFrontWheelsTypes = {
			label               = _U('wheel_type'),
			parent              = 'wheels',
			modFrontWheelsType0 = _U('sport'),
			modFrontWheelsType1 = _U('muscle'),
			modFrontWheelsType2 = _U('lowrider'),
			modFrontWheelsType3 = _U('suv'),
			modFrontWheelsType4 = _U('allterrain'),
			modFrontWheelsType5 = _U('tuning'),
			modFrontWheelsType6 = _U('motorcycle'),
			modFrontWheelsType7 = _U('highend')
		},
		modFrontWheelsType0 = {
			label = _U('sport'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 0,
			price = 4.65
		},
		modFrontWheelsType1 = {
			label = _U('muscle'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 1,
			price = 4.19
		},
		modFrontWheelsType2 = {
			label = _U('lowrider'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 2,
			price = 4.65
		},
		modFrontWheelsType3 = {
			label = _U('suv'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 3,
			price = 4.19
		},
		modFrontWheelsType4 = {
			label = _U('allterrain'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 4,
			price = 4.19
		},
		modFrontWheelsType5 = {
			label = _U('tuning'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 5,
			price = 5.12
		},
		modFrontWheelsType6 = {
			label = _U('motorcycle'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 6,
			price = 3.26
		},
		modFrontWheelsType7 = {
			label = _U('highend'),
			parent = 'modFrontWheelsTypes',
			modType = 23,
			wheelType = 7,
			price = 5.12
		},
		modFrontWheelsColor = {
			label = 'Peinture Jantes',
			parent = 'wheels'
		},
		wheelColor = {
			label = 'Peinture Jantes',
			parent = 'modFrontWheelsColor',
			modType = 'wheelColor',
			price = 0.66
		},
		plateIndex = {
			label = _U('licenseplates'),
			parent = 'cosmetics',
			modType = 'plateIndex',
			price = 1.1
		},
		Xenon = {
			label = _U('headlights'),
			parent = 'cosmetics',
			modType = 22,
			price = 0.72
		},
		bodyparts = {
			label = _U('bodyparts'),
			parent = 'cosmetics',
			modFender = _U('leftfender'),
			modRightFender = _U('rightfender'),
			modSpoilers = _U('spoilers'),
			modSideSkirt = _U('sideskirt'),
			modFrame = _U('cage'),
			modHood = _U('hood'),
			modGrille = _U('grille'),
			modRearBumper = _U('rearbumper'),
			modFrontBumper = _U('frontbumper'),
			modExhaust = _U('exhaust'),
			modRoof = _U('roof')
		},
		modSpoilers = {
			label = _U('spoilers'),
			parent = 'bodyparts',
			modType = 0,
			price = 2.65
		},
		modFrontBumper = {
			label = _U('frontbumper'),
			parent = 'bodyparts',
			modType = 1,
			price = 2.12
		},
		modRearBumper = {
			label = _U('rearbumper'),
			parent = 'bodyparts',
			modType = 2,
			price = 2.12
		},
		modSideSkirt = {
			label = _U('sideskirt'),
			parent = 'bodyparts',
			modType = 3,
			price = 2.65
		},
		modExhaust = {
			label = _U('exhaust'),
			parent = 'bodyparts',
			modType = 4,
			price = 2.12
		},
		modFrame = {
			label = _U('cage'),
			parent = 'bodyparts',
			modType = 5,
			price = 2.12
		},
		modGrille = {
			label = _U('grille'),
			parent = 'bodyparts',
			modType = 6,
			price = 3.72
		},
		modHood = {
			label = _U('hood'),
			parent = 'bodyparts',
			modType = 7,
			price = 2.88
		},
		modFender = {
			label = _U('leftfender'),
			parent = 'bodyparts',
			modType = 8,
			price = 2.12
		},
		modRightFender = {
			label = _U('rightfender'),
			parent = 'bodyparts',
			modType = 9,
			price = 2.12
		},
		modRoof = {
			label = _U('roof'),
			parent = 'bodyparts',
			modType = 10,
			price = 2.58
		},
		windowTint = {
			label = _U('windowtint'),
			parent = 'cosmetics',
			modType = 'windowTint',
			price = 1.12
		},
		modHorns = {
			label = _U('horns'),
			parent = 'cosmetics',
			modType = 14,
			price = 1.12
		},
		neonColor = {
			label = _U('neons'),
			parent = 'cosmetics',
			modType = 'neonColor',
			price = 1.12
		},
		tyreSmokeColor = {
			label = _U('tiresmoke'),
			parent = 'wheels',
			modType = 'tyreSmokeColor',
			price = 1.12
		}

	}
	elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), Config.Zones.ls2.Pos.x, Config.Zones.ls2.Pos.y, Config.Zones.ls2.Pos.z, true) < 2) then
		Config.Menus = {
			main = {
				label = 'Respray',
				parent = nil,
				cosmetics = _U('cosmetics')
			},
				cosmetics = {
				label				= _U('cosmetics'),
				parent				= 'main',
				resprays			= _U('respray'),
				wheels				= _U('wheels'),
				modLivery			= _U('stickers')
			},
			modLivery = {
				label = 'Stickers',
				parent = 'cosmetics',
				modType = 48,
				price = 9.3
			},

			wheels = {
				label = _U('wheels'),
				parent = 'cosmetics',
				modFrontWheelsColor = _U('wheel_color')
			},
			modFrontWheelsColor = {
				label = 'Wheels Color',
				parent = 'wheels'
			},
			wheelColor = {
				label = 'Wheels Color',
				parent = 'modFrontWheelsColor',
				modType = 'wheelColor',
				price = 0.66
			},
			resprays = {
				label = _U('respray'),
				parent = 'cosmetics',
				primaryRespray = _U('primary'),
				secondaryRespray = _U('secondary'),
				pearlescentRespray = _U('pearlescent'),
			},
			primaryRespray = {
				label = _U('primary'),
				parent = 'resprays',
			},
			secondaryRespray = {
				label = _U('secondary'),
				parent = 'resprays',
			},
			pearlescentRespray = {
				label = _U('pearlescent'),
				parent = 'resprays',
			},
			color1 = {
				label = _U('primary'),
				parent = 'primaryRespray',
				modType = 'color1',
				price = 1.12
			},
			color2 = {
				label = _U('secondary'),
				parent = 'secondaryRespray',
				modType = 'color2',
				price = 0.66
			},
			pearlescentColor = {
				label = _U('pearlescent'),
				parent = 'pearlescentRespray',
				modType = 'pearlescentColor',
				price = 0.88
			}

		}
	elseif (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), Config.Zones.ls3.Pos.x, Config.Zones.ls3.Pos.y, Config.Zones.ls3.Pos.z, true) < 2) then
		Config.Menus = {
			main = {
				label = 'Engine Upgrade',
				parent = nil,
				upgrades = _U('upgrades')
			},
			upgrades = {
				label = _U('upgrades'),
				parent = 'main',
				modEngine = _U('engine'),
				modBrakes = _U('brakes'),
				modTransmission = _U('transmission'),
				modSuspension = _U('suspension'),
				modArmor = _U('armor'),
				modTurbo = _U('turbo')
			},
			modEngine = {
				label = _U('engine'),
				parent = 'upgrades',
				modType = 11,
				price = {5, 15, 20, 30}
			},
			modBrakes = {
				label = _U('brakes'),
				parent = 'upgrades',
				modType = 12,
				price = {5.65, 10.3, 13.6, 15.95}
			},
			modTransmission = {
				label = _U('transmission'),
				parent = 'upgrades',
				modType = 13,
				price = {13.95, 15.5, 16.2}
			},
			modSuspension = {
				label = _U('suspension'),
				parent = 'upgrades',
				modType = 15,
				price = {3.72, 7.44, 12.88, 19.77, 24.2}
			},
			modArmor = {
				label = _U('armor'),
				parent = 'upgrades',
				modType = 16,
				price = {24.77, 30, 40.00, 50.00, 60.00, 65.00}
			},
			modTurbo = {
				label = _U('turbo'),
				parent = 'upgrades',
				modType = 17,
				price = {21.81}
			}
		}
	end
end
 

