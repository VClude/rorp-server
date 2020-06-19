Config = {}

Config.Locale = 'en'
Config.OpenControl = 101
Config.TrunkOpenControl = 58
Config.DeleteDropsOnStart = true
Config.HotKeyCooldown = 1000
Config.CheckLicense = TRUE
Config.PlayerMaxWeight = 100
Config.StashMaxWeight = 650
Config.GloveboxMaxWeight = 35

Config.Shops = {
    ['TwentyFourSeven'] = {
        coords = {
            vector3(374.07, 325.86, 102.680),
            vector3(2557.46, 382.32, 107.80),
            vector3(-3039.01, 586.17, 7.10),
            vector3(-3241.9, 1001.56, 12.0),
            vector3(547.444, 2671.24, 41.30),        
        },
        items = {
            { name = "bread", price = 3799, count = 1 },
        },
        markerType = 27,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~24/~s~~y~7~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = true,
        job = 'all'
    },

    ['LTDgasoline'] = {
        coords = {
            vector3(-707.86, -914.62, 18.32),
            vector3(-48.58, -1757.69, 28.62),
            vector3(-1820.79, 792.52, 137.15),
            vector3(1163.39, -323.94, 68.31),
            vector3(1698.19, 4924.7, 41.16)
        },
        items = {
            { name = "bread", price = 20, count = 5 },         
        },
        markerType = 27,
        markerColour = { r = 255, g = 0, b = 0  },
        msg = '~g~LTD~s~~y~-~s~~g~Gasoline~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = true,
        job = 'all'
    },

    ['HighTimes'] = {
        coords = {
            vector3(-1172.46, -1571.33, 4.66), -- beach area
            vector3(169.48, -222.78, 54.24) -- hightimes building
        },
        items = {
            { name = "siccor", price = 24, count = 1 },    
        },
        markerType = 20,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~High~s~ ~INPUT_CONTEXT~ ~g~Times~s~',
        enableBlip = true,
        job = 'all'
    },

    ['KeySmith'] = {
        coords = {
            vector3(170.14, -1799.41, 29.32)
        },
        items = {
            { name = "bread", price = 74, count = 1 },

        },
        markerType = 20,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~Key~s~ ~INPUT_CONTEXT~ ~g~Smith~s~',
        enableBlip = true,
        job = 'all'
    },

    ['MethShop'] = {
        coords = {
            vector3(1924.18, 4625.01, 40.47) -- hightimes building
        },
        items = {
            { name = "bread", price = 13099, count = 1 },     
        },
        markerType = 20,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~Underground~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = false,
        job = 'all'
    },

    ['CokeShop'] = {
        coords = {
            vector3(1393.25, 1128.64, 109.75) -- ranch
        },
        items = {
            { name = "bread", price = 10099, count = 1 },     
        },
        markerType = 20,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~Underground~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = false,
        job = 'all'
    },

    ['WeedShop'] = {
        coords = {
            vector3(1044.56, -3194.79, -38.16) -- hidden weed farm
        },
        items = {
            { name = "bread", price = 8099, count = 1 },     
        },
        markerType = 20,
        markerColour = { r = 0, g = 255, b = 0 },
        msg = '~g~Underground~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = false,
        job = 'all'
    },

    ['YouTool'] = {
        coords = {
            vector3(-10.23, 6500.23, 31.51), -- paleto
            vector3(2745.99, 3469.66, 55.67), -- sandy
            vector3(343.92, -1298.22, 32.51) -- downtown
        },
        items = {            
            { name = "bread", price = 124, count = 1 },
        },
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 0  },
        msg = '~g~You~s~ ~INPUT_CONTEXT~ ~g~Tool~s~',
        enableBlip = true,
        job = 'all'
    },

    ['Pharmacy'] = { -- needs done
        coords = {
            vector3(306.66, -595.06, 43.28), -- pillbox
            vector3(342.39, -1399.86, 32.51), -- central
            vector3(1150.13, -1530.14, 35.39), -- st fransis
            vector3(1831.34, 3675.47, 34.67), -- sandy
            vector3(-471.55, -324.94, 34.51), -- MT Z
            vector3(-253.2843, 6322.373, 39.56) -- paleto
        },
        items = {
            { name = "bread", price = 24, count = 1 },
        },
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 0  },
        msg = '~g~Pharmacy~s~ ~INPUT_CONTEXT~ ~g~Shop~s~',
        enableBlip = false,
        job = 'all'
    },

    ['Ammu-Nation'] = {
        coords = {
            vector3(-662.1, -935.3, 21.83),
			vector3(810.16, -2157.65, 29.62),
			vector3(1693.94, 3759.85, 34.71),
			vector3(-330.2, 6083.8, 31.45),
			vector3(252.3, -50.0, 69.94),
			vector3(21.95, -1106.64, 29.8),
			vector3(2567.6, 294.3, 108.73),
			vector3(-1305.96, -394.11, 36.72),
			vector3(-1117.5, 2698.6, 18.55),
			vector3(841.94, -1033.64, 28.19)
        },
        items = {
            { name = "WEAPON_PISTOL", price = 3799, count = 1 },
            { name = "WEAPON_PISTOL50", price = 8500, count = 1 },
            { name = "WEAPON_SWITCHBLADE", price = 100, count = 1 },
            { name = "WEAPON_BAT", price = 150, count = 1 },
            { name = "WEAPON_CROWBAR", price = 200, count = 1 },
            { name = "WEAPON_PUMPSHOTGUN", price = 17500, count = 1 },
			{ name = "rtx_ammo_pistol", price = 50, count = 1 },			
			{ name = "rtx_ammo_shotgun", price = 60, count = 1 },
        },
        markerType = 20,
        markerColour = { r = 0, g = 0, b = 255  },
        msg = '~y~[E]~s~ ~g~Weapon shop~s~',
        enableBlip = true,
        job = 'all'
    },

    ['Dark-Nation'] = {
        coords = {
			vector3(2340.95, 3127.96, 48.21)
        },
        items = {
            { name = "WEAPON_MICROSMG", price = 136500, count = 1 },
            { name = "WEAPON_ASSAULTRIFLE", price = 332500, count = 1 },
            { name = "WEAPON_ADVANCEDRIFLE", price = 273500, count = 1 },
            { name = "WEAPON_SPECIALCARBINE", price = 316000, count = 1 },
			{ name = "WEAPON_HEAVYSNIPER", price = 1037250, count = 1 },
			{ name = "rtx_ammo_pistol", price = 50, count = 1 },
			{ name = "rtx_ammo_pistol_large", price = 100, count = 1 },
			{ name = "rtx_ammo_shotgun", price = 60, count = 1 },
			{ name = "rtx_ammo_shotgun_large", price = 110, count = 1 },
			{ name = "rtx_ammo_smg", price = 70, count = 1 },
			{ name = "rtx_ammo_smg_large", price = 120, count = 1 },
			{ name = "rtx_ammo_rifle", price = 80, count = 1 },
			{ name = "rtx_ammo_rifle_large", price = 130, count = 1 },
			{ name = "rtx_ammo_snp", price = 90, count = 1 },
			{ name = "rtx_ammo_snp_large", price = 140, count = 1 },	
        },
        markerType = 20,
        markerColour = { r = 0, g = 0, b = 255  },
        msg = '~y~[E]~s~ ~g~Weapon shop~s~',
        enableBlip = false,
        job = 'all'
    },

    ['Weapon Shop - Police'] = {
        coords = {
            vector3(450.06, -990.55, 30.69), -- MR
            vector3(-1098.81, -826.0, 14.28), -- Vespucci
            vector3(353.26, -1594.11, 29.29), -- DAVIS
            vector3(858.34, -1321.28, 28.14), -- LA MESA
            vector3(1841.77, 3690.71, 34.27) -- SANDY
        },
        items = {
            { name = "WEAPON_COMBATPISTOL", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_STUNGUN", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_SMG", price = 0, count = 1, grade = 3 },
            { name = "WEAPON_NIGHTSTICK", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_FLASHLIGHT", price = 0, count = 1, grade = 0 },
            { name = "WEAPON_PUMPSHOTGUN", price = 0, count = 1, grade = 2 },
            { name = "WEAPON_CARBINERIFLE", price = 0, count = 1, grade = 6 },
            { name = "WEAPON_HEAVYSNIPER", price = 0, count = 1, grade = 9 },
            { name = "rtx_ammo_pistol", price = 0, count = 1, grade = 0 },
            { name = "rtx_ammo_rifle", price = 0, count = 1, grade = 6 },
            { name = "rtx_ammo_shotgun", price = 0, count = 1, grade = 2 },
            { name = "rtx_ammo_smg", price = 0, count = 1, grade = 3 },
            { name = "rtx_ammo_snp", price = 0, count = 1, grade = 9 },            
        },
        markerType = 20,
        markerColour = { r = 0, g = 0, b = 255 },
        msg = '[E] Police shop',
        job = 'police'
    },

    ['Vest Shop'] = { -- police shop
        coords = {
            vector3(458.06, -990.55, 30.69), -- MISSONROW
            vector3(-1102.98, -829.27, 14.28), -- Vespucci
            vector3(373.21, -1617.18, 29.29), -- DAVIS
            vector3(830.39, -1311.17, 28.14), -- LA MESA
            vector3(619.03, 17.28, 87.82), -- Vinewood
            vector3(1845.83, 3692.63, 34.27) -- SANDY
        },
        items = {
            { name = "bread", price = 0, count = 5, grade = 0 },
        },
        markerType = 20,
        markerColour = { r = 0, g = 0, b = 255 },
        msg = '[E] Armor Shop',
        job = 'police'
    },
}

Config.Stash = {
    ['Police'] = { -- MR
        coords = vector3(473.31, -989.78, 24.91),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Sandy'] = {
        coords = vector3(1855.81, 3699.02, 34.27),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Mc'] = { -- davis
        coords = vector3(371.27, -1612.74, 29.31),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Vespucci'] = {
        coords = vector3(-1086.33, -809.95, 11.04),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['LaMesa'] = {
        coords = vector3(838.17, -1396.02, 26.31),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Vinewood'] = {
        coords = vector3(977.15, -104.21, 74.85),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Soa'] = {
        coords = vector3(535.94, -21.73, 70.63),
        size = vector3(1.0, 1.0, 1.0),
        job = 'soa',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Mechanic'] = {
        coords = vector3(956.04, -966.72, 39.51),
        size = vector3(1.0, 1.0, 1.0),
        job = 'mechanic',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    },
    ['Stashbarn'] = { -- Stashbarn/meth
        coords = vector3(1930.27, 4626.62, 44.17),
        size = vector3(1.0, 1.0, 1.0),
        job = 'all',
        markerType = 20,
        markerColour = { r = 255, g = 0, b = 255 },
        msg = 'Open Stash ~INPUT_CONTEXT~'
    }
}

Config.VehicleLimit = {
    ['Zentorno'] = 10,
    ['Panto'] = 1,
    ['Zion'] = 5
}
Config.VehicleWeight2 = { 
    ['Zentorno'] = 10,
    ['Panto'] = 1,
    ['Zion'] = 5
}

Config.VehicleSlot = {
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 15, --Coupes
    [4] = 5, --Muscle
    [5] = 5, --Sports Classics
    [6] = 5, --Sports
    [7] = 0, --Super
    [8] = 5, --Motorcycles
    [9] = 10, --Off-road
    [10] = 20, --Industrial
    [11] = 20, --Utility
    [12] = 30, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 90, --Military
    [20] = 0, --Commercial
    [21] = 0 --Trains
}
Config.VehicleWeight = {
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 16, --Coupes
    [4] = 5, --Muscle
    [5] = 5, --Sports Classics
    [6] = 5, --Sports
    [7] = 0, --Super
    [8] = 5, --Motorcycles
    [9] = 10, --Off-road
    [10] = 20, --Industrial
    [11] = 20, --Utility
    [12] = 30, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 90, --Military
    [20] = 0, --Commercial
    [21] = 0 --Trains
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847
