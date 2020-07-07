Config = {}
Config.Locale = 'en'
Config.IncludeCash = true -- DONT TOUCH!
Config.IncludeWeapons = true -- TRUE or FALSE
Config.IncludeAccounts = true -- TRUE or FALSE
Config.ExcludeAccountsList = {"bank", "money"} --  DONT TOUCH!
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.CloseControl = 200

-- List of item names that will close ui when used
Config.CloseUiItems = {"fixkit", "medikit"} -- Add your own items here!

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2

Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 2
Config.WeaponColor = 1

Config.LicensePrice = 80000

Config.Shops = {
    RegularShop = {
        Locations = {
		{x = 373.875,   y = 325.896,  z = 102.566},
		{x = 2557.458,  y = 382.282,  z = 107.622},
		{x = -3038.939, y = 585.954,  z = 6.908},
		{x = -3241.927, y = 1001.462, z = 11.830},
		-- {x = 547.431,   y = 2671.710, z = 41.156},
		-- {x = 1961.464,  y = 3740.672, z = 31.343},
		-- {x = 2678.916,  y = 3280.671, z = 54.241},
		-- {x = 1729.216,  y = 6414.131, z = 34.037},
		{x = -48.519,   y = -1757.514, z = 28.421},
		{x = 1163.373,  y = -323.801,  z = 68.205},
		{x = -707.501,  y = -914.260,  z = 18.215},
		{x = -1820.523, y = 792.518,   z = 137.118},
		-- {x = 1698.388,  y = 4924.404,  z = 41.063},
        {x = 25.723,   y = -1346.966, z = 28.497}, 
        {x = -1045.41, y = -2750.77, z = 20.36} 

        },
        Items = {
            {name = 'bread'}, -- add more items here
            {name = 'water'}
        }
    },

    RobsLiquor = {
	Locations = {
		{x = 1135.808,  y = -982.281,  z = 45.415},
	
        },
        Items = {
            {name = 'beer'},
            {name = 'wine'},
            {name = 'vodka'},
            {name = 'tequila'},
            {name = 'whisky'},
            {name = 'energy'}
        }
	},

    WeaponShop = {
        Locations = {
            { x = -662.180, y = -934.961, z = 20.829 },            
            { x = 810.2, y = -2157.3, z = 28.6 },
			{ x = 252.3, y = -50.0, z = 68.9 },
			{ x = 22.0, y = -1107.2, z = 28.8 },
            { x = 2567.6, y = 294.3, z = 107.7 },
            { x = 842.4, y = -1033.4, z = 27.1 },
            -- { x = -1117.5, y = 2698.6, z = 17.5 },
            -- { x = 1693.4, y = 3759.5, z = 33.7 },
            -- { x = -330.2, y = 6083.8, z = 30.4 },
        
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1, price = 80},
            {name = "WEAPON_PETROLCAN", ammo = 4500, price = 150},
            {name = "WEAPON_KNIFE", ammo = 1, price = 5000},
            {name = "WEAPON_BAT", ammo = 1, price = 3000},
            {name = "WEAPON_PISTOL", ammo = 45, price = 20000}
        },
        Ammo = {
            {name = "WEAPON_PISTOL_AMMO", weaponhash = "WEAPON_PISTOL", ammo = 24, price = 2000}
        },
        Items = {

        }
    },
}
