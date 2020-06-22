
Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = 74

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 200

Config.localWeight = {
alive_chicken = 20000,ban = 2000,bandage = 2,beer = 20,binocular = 20,blowpipe = 2,blowtorch = 20,bread = 1,cannabis = 3,carokit = 3,carotool = 2,cashew = 20,chips = 20,chocolate = 20,cigarette = 20,clothe = 100,cocacola = 20,copper = 1,cupcake = 20,cutted_wood = 1,diamond = 1,drill = 20,drpepper = 20,drugscales = 20,energy = 20,essence = 1,fabric = 100,fish = 1,fixkit = 500,fixtool = 500,gazbottle = 2,gold = 1,gps = 20,grand_cru = 20,hackerDevice = 1,hamburger = 20,highgradefert = 20,icetea = 20,iron = 1,jeruk = 2,kosmetickasada = 1,lemonade = 20,lighter = 20,lockpick = 20,lowgradefert = 20,marijuana = 2,medikit = 2,nitrocannister = 1,packaged_chicken = 2000,packaged_plank = 1,petrol = 1,petrol_raffin = 1,phone = 20,pickaxe = 1000,pistachio = 20,plantpot = 20,rollingpaper = 20,rtx_ammo_pistol = 10,rtx_ammo_pistol_large = 10,rtx_ammo_rifle = 10,rtx_ammo_rifle_large = 10,rtx_ammo_shotgun = 10,rtx_ammo_shotgun_large = 10,rtx_ammo_smg = 10,rtx_ammo_smg_large = 10,rtx_ammo_snp = 10,rtx_ammo_snp_large = 10,ruby = 500,sandwich = 20,scubagear = 20,silver = 100,sim = 1,slaughtered_chicken = 20000,stone = 250,tequila = 20,vodka = 20,washed_stone = 250,washpan = 1000,water = 100,WEAPON_ADVANCEDRIFLE = 1,WEAPON_APPISTOL = 1,WEAPON_ASSAULTRIFLE = 1,WEAPON_ASSAULTSHOTGUN = 1,WEAPON_ASSAULTSMG = 1,WEAPON_AUTOSHOTGUN = 1,WEAPON_BALL = 1,WEAPON_BAT = 1,WEAPON_BATTLEAXE = 1,WEAPON_BOTTLE = 1,WEAPON_BULLPUPRIFLE = 1,WEAPON_BULLPUPSHOTGUN = 1,WEAPON_BZGAS = 1,WEAPON_CARBINERIFLE = 1,WEAPON_COMBATMG = 1,WEAPON_COMBATPDW = 1,WEAPON_COMBATPISTOL = 1,WEAPON_COMPACTLAUNCHER = 1,WEAPON_COMPACTRIFLE = 1,WEAPON_CROWBAR = 1,WEAPON_DAGGER = 1,WEAPON_DBSHOTGUN = 1,WEAPON_DIGISCANNER = 1,WEAPON_DOUBLEACTION = 1,WEAPON_FIREEXTINGUISHER = 1,WEAPON_FIREWORK = 1,WEAPON_FLARE = 1,WEAPON_FLAREGUN = 1,WEAPON_FLASHLIGHT = 1,WEAPON_GARBAGEBAG = 1,WEAPON_GOLFCLUB = 1,WEAPON_GRENADE = 1,WEAPON_GRENADELAUNCHER = 1,WEAPON_GUSENBERG = 1,WEAPON_HAMMER = 1,WEAPON_HANDCUFFS = 1,WEAPON_HATCHET = 1,WEAPON_HEAVYPISTOL = 1,WEAPON_HEAVYSHOTGUN = 1,WEAPON_HEAVYSNIPER = 1,WEAPON_HOMINGLAUNCHER = 1,WEAPON_KNIFE = 1,WEAPON_KNUCKLE = 1,WEAPON_MACHETE = 1,WEAPON_MACHINEPISTOL = 1,WEAPON_MARKSMANPISTOL = 1,WEAPON_MARKSMANRIFLE = 1,WEAPON_MG = 1,WEAPON_MICROSMG = 1,WEAPON_MINIGUN = 1,WEAPON_MINISMG = 1,WEAPON_MOLOTOV = 1,WEAPON_MUSKET = 1,WEAPON_NIGHTSTICK = 1,WEAPON_PETROLCAN = 1,WEAPON_PIPEBOMB = 1,WEAPON_PISTOL = 1,WEAPON_PISTOL50 = 1,WEAPON_POOLCUE = 1,WEAPON_PROXMINE = 1,WEAPON_PUMPSHOTGUN = 1,WEAPON_RAILGUN = 1,WEAPON_REVOLVER = 1,WEAPON_RPG = 1,WEAPON_SAWNOFFSHOTGUN = 1,WEAPON_SMG = 1,WEAPON_SMOKEGRENADE = 1,WEAPON_SNIPERRIFLE = 1,WEAPON_SNOWBALL = 1,WEAPON_SNSPISTOL = 1,WEAPON_SPECIALCARBINE = 1,WEAPON_STICKYBOMB = 1,WEAPON_STINGER = 1,WEAPON_STUNGUN = 1,WEAPON_SWITCHBLADE = 1,WEAPON_VINTAGEPISTOL = 1,WEAPON_WRENCH = 1,whisky = 20,wine = 20,wood = 1,wool = 200,wrench = 1
}

Config.VehicleWeight = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 200000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 200000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
