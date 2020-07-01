Config = {}
Config.Locale = 'en'
Config.IncludeCash = true -- DONT TOUCH!
Config.IncludeWeapons = true -- TRUE or FALSE
Config.IncludeAccounts = true -- TRUE or FALSE
Config.ExcludeAccountsList = {"bank", "money"} --  DONT TOUCH!
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.

-- List of item names that will close ui when used
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit", "cannabis"}

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
Config.localWeight = {
    alive_chicken = 20000,armbrace = 1000,ban = 2000,bandage = 1000,beer = 1000,binocular = 1000,blowpipe = 1000,blowtorch = 1000,bodybandage = 1000,bread = 1000,breadb = 1000,breadh = 1000,breads = 1000,burger = 1000,cannabis = 1000,carokit = 1000,carotool = 1000,cashew = 1000,cheese = 1000,chemicals = 1000,chemicalslisence = 1000,chips = 1000,chocolate = 1000,cigarette = 1000,clothe = 2000,cocacola = 1000,cocaine_cut = 1000,cocaine_packaged = 1000,cocaine_uncut = 1000,coca_leaf = 1000,coke = 1000,copper = 1000,cupcake = 1000,cutted_wood = 2000,cut_money = 1000,diamond = 2000,drill = 1000,drpepper = 1000,drugscales = 1000,energy = 1000,esjeruk = 500,essence = 2000,fabric = 2000,fish = 1000,fixkit = 500,fixtool = 500,gazbottle = 1000,gold = 1000,gps = 1000,grand_cru = 1000,hackerDevice = 1000,ham = 1000,hamburger = 1000,heroin = 1000,heroinbubuk = 1000,highgradefert = 1000,hotdog = 1000,hydrochloric_acid = 1000,icetea = 1000,iron = 1000,jeruk = 1000,kosmetickasada = 1000,legbrace = 1000,lemonade = 1000,lighter = 1000,lockpick = 1000,lowgradefert = 1000,lsa = 1000,lsd = 1000,marijuana = 1000,meat = 1000,meats = 20000,meat_cincang = 20000,medikit = 1000,meth = 1000,meth_packaged = 1000,meth_raw = 1000,moneywash = 1000,neckbrace = 1000,nitrocannister = 1000,packaged_chicken = 2000,packaged_plank = 1000,petrol = 2000,petrol_raffin = 4000,phone = 1000,pickaxe = 1000,pistachio = 1000,plantpot = 1000,poppyresin = 500,rollingpaper = 1000,ruby = 500,sandwich = 1000,sausage = 1000,scubagear = 1000,silver = 500,sim = 1000,slaughtered_chicken = 20000,sodium_hydroxide = 1000,sorted_money = 1000,sosis = 2000,stone = 1000,sugarcane = 1,sulfuric_acid = 1000,tebu = 1000,tequila = 1000,thionyl_chloride = 1000,vodka = 1000,washed_stone = 1000,washpan = 1000,water = 1000,WEAPON_ADVANCEDRIFLE = 1000,WEAPON_APPISTOL = 1000,WEAPON_ASSAULTRIFLE = 1000,WEAPON_ASSAULTSHOTGUN = 1000,WEAPON_ASSAULTSMG = 1000,WEAPON_AUTOSHOTGUN = 1000,WEAPON_BALL = 1000,WEAPON_BAT = 1000,WEAPON_BATTLEAXE = 1000,WEAPON_BOTTLE = 1000,WEAPON_BULLPUPRIFLE = 1000,WEAPON_BULLPUPSHOTGUN = 1000,WEAPON_BZGAS = 1000,WEAPON_CARBINERIFLE = 1000,WEAPON_COMBATMG = 1000,WEAPON_COMBATPDW = 1000,WEAPON_COMBATPISTOL = 1000,WEAPON_COMPACTLAUNCHER = 1000,WEAPON_COMPACTRIFLE = 1000,WEAPON_CROWBAR = 1000,WEAPON_DAGGER = 1000,WEAPON_DBSHOTGUN = 1000,WEAPON_DIGISCANNER = 1000,WEAPON_DOUBLEACTION = 1000,WEAPON_FIREEXTINGUISHER = 1000,WEAPON_FIREWORK = 1000,WEAPON_FLARE = 1000,WEAPON_FLAREGUN = 1000,WEAPON_FLASHLIGHT = 1000,WEAPON_GARBAGEBAG = 1000,WEAPON_GOLFCLUB = 1000,WEAPON_GRENADE = 1000,WEAPON_GRENADELAUNCHER = 1000,WEAPON_GUSENBERG = 1000,WEAPON_HAMMER = 1000,WEAPON_HANDCUFFS = 1000,WEAPON_HATCHET = 1000,WEAPON_HEAVYPISTOL = 1000,WEAPON_HEAVYSHOTGUN = 1000,WEAPON_HEAVYSNIPER = 1000,WEAPON_HOMINGLAUNCHER = 1000,WEAPON_KNIFE = 1000,WEAPON_KNUCKLE = 1000,WEAPON_MACHETE = 1000,WEAPON_MACHINEPISTOL = 1000,WEAPON_MARKSMANPISTOL = 1000,WEAPON_MARKSMANRIFLE = 1000,WEAPON_MG = 1000,WEAPON_MICROSMG = 1000,WEAPON_MINIGUN = 1000,WEAPON_MINISMG = 1000,WEAPON_MOLOTOV = 1000,WEAPON_MUSKET = 1000,WEAPON_NIGHTSTICK = 1000,WEAPON_PETROLCAN = 1000,WEAPON_PIPEBOMB = 1000,WEAPON_PISTOL = 1000,WEAPON_PISTOL50 = 1000,WEAPON_POOLCUE = 1000,WEAPON_PROXMINE = 1000,WEAPON_PUMPSHOTGUN = 1000,WEAPON_RAILGUN = 1000,WEAPON_REVOLVER = 1000,WEAPON_RPG = 1000,WEAPON_SAWNOFFSHOTGUN = 1000,WEAPON_SMG = 1000,WEAPON_SMOKEGRENADE = 1000,WEAPON_SNIPERRIFLE = 1000,WEAPON_SNOWBALL = 1000,WEAPON_SNSPISTOL = 1000,WEAPON_SPECIALCARBINE = 1000,WEAPON_STICKYBOMB = 1000,WEAPON_STINGER = 1000,WEAPON_STUNGUN = 1000,WEAPON_SWITCHBLADE = 1000,WEAPON_VINTAGEPISTOL = 1000,WEAPON_WRENCH = 1000,weed_packaged = 1000,weed_untrimmed = 1000,whisky = 1000,wine = 1000,wood = 20000,wool = 2000,wrench = 1000
    }
    
Config.LicensePrice = 5000

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

        },
        Items = {
            {name = 'bread'},
            {name = 'water'},
            {name = 'cigarette'},
            {name = 'lighter'},
            {name = 'rollingpaper'},
            {name = 'phone'},
            {name = 'sandwich'},
            {name = 'hamburger'},
            {name = 'cupcake'},
            {name = 'chips'},
            {name = 'pistachio'},
            {name = 'chocolate'},
            {name = 'cashew'},
            {name = 'cocacola'},
            {name = 'drpepper'},
            {name = 'energy'},
            {name = 'lemonade'},
            {name = 'icetea'}
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
        
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            {name = "WEAPON_STUNGUN", ammo = 1},
            {name = "WEAPON_PETROLCAN", ammo = 4500},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            {name = "WEAPON_PISTOL", ammo = 45},
            {name = "WEAPON_APPISTOL", ammo = 45},
            {name = "WEAPON_SMG", ammo = 45},
            {name = "WEAPON_ADVANCEDRIFLE", ammo = 45},
            {name = "WEAPON_ASSAULTRIFLE", ammo = 45},
            {name = "WEAPON_ASSAULTSHOTGUN", ammo = 25},
            {name = "WEAPON_ASSAULTSMG", ammo = 45},
            {name = "WEAPON_AUTOSHOTGUN", ammo = 45},
            {name = "WEAPON_CARBINERIFLE", ammo = 25},
            {name = "WEAPON_COMBATPISTOL", ammo = 45},
            {name = "WEAPON_PUMPSHOTGUN", ammo = 25}
        },
        Ammo = {
            {name = "WEAPON_PISTOL_AMMO", weaponhash = "WEAPON_PISTOL", ammo = 24},
            {name = "WEAPON_APPISTOL_AMMO", weaponhash = "WEAPON_APPISTOL", ammo = 24},
            {name = "WEAPON_SMG_AMMO", weaponhash = "WEAPON_SMG", ammo = 24},
            {name = "WEAPON_ADVANCEDRIFLE_AMMO", weaponhash = "WEAPON_ADVANCEDRIFLE", ammo = 24},
            {name = "WEAPON_ASSAULTRIFLE_AMMO", weaponhash = "WEAPON_ASSAULTRIFLE", ammo = 24},
            {name = "WEAPON_ASSAULTSHOTGUN_AMMO", weaponhash = "WEAPON_ASSAULTSHOTGUN", ammo = 12},
            {name = "WEAPON_ASSAULTSMG_AMMO", weaponhash = "WEAPON_ASSAULTSMG", ammo = 24},
            {name = "WEAPON_AUTOSHOTGUN_AMMO", weaponhash = "WEAPON_AUTOSHOTGUN", ammo = 12},
            {name = "WEAPON_CARBINERIFLE_AMMO", weaponhash = "WEAPON_CARBINERIFLE", ammo = 24},
            {name = "WEAPON_COMBATPISTOL_AMMO", weaponhash = "WEAPON_COMBATPISTOL", ammo = 24},
            {name = "WEAPON_PUMPSHOTGUN_AMMO", weaponhash = "WEAPON_PUMPSHOTGUN", ammo = 12}
        },
        Items = {

        }
    },
    -- LicenseShop = {
    --     Locations = {
    --         { x = 12.47, y = -1105.5, z = 29.8}
    --     }
    -- }
}
