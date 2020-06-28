
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
alive_chicken = 20000,armbrace = 1000,ban = 2000,bandage = 1000,beer = 1000,binocular = 1000,blowpipe = 1000,blowtorch = 1000,bodybandage = 1000,bread = 1000,breadb = 1000,breadh = 1000,breads = 1000,burger = 1000,cannabis = 1000,carokit = 1000,carotool = 1000,cashew = 1000,cheese = 1000,chemicals = 1000,chemicalslisence = 1000,chips = 1000,chocolate = 1000,cigarette = 1000,clothe = 2000,cocacola = 1000,cocaine_cut = 1000,cocaine_packaged = 1000,cocaine_uncut = 1000,coca_leaf = 1000,coke = 1000,copper = 1000,cupcake = 1000,cutted_wood = 2000,cut_money = 1000,diamond = 2000,drill = 1000,drpepper = 1000,drugscales = 1000,energy = 1000,esjeruk = 500,essence = 2000,fabric = 2000,fish = 1000,fixkit = 500,fixtool = 500,gazbottle = 1000,gold = 1000,gps = 1000,grand_cru = 1000,hackerDevice = 1000,ham = 1000,hamburger = 1000,heroin = 1000,heroinbubuk = 1000,highgradefert = 1000,hotdog = 1000,hydrochloric_acid = 1000,icetea = 1000,iron = 1000,jeruk = 1000,kosmetickasada = 1000,legbrace = 1000,lemonade = 1000,lighter = 1000,lockpick = 1000,lowgradefert = 1000,lsa = 1000,lsd = 1000,marijuana = 1000,meat = 1000,meats = 20000,meat_cincang = 20000,medikit = 1000,meth = 1000,meth_packaged = 1000,meth_raw = 1000,moneywash = 1000,neckbrace = 1000,nitrocannister = 1000,packaged_chicken = 2000,packaged_plank = 1000,petrol = 2000,petrol_raffin = 4000,phone = 1000,pickaxe = 1000,pistachio = 1000,plantpot = 1000,poppyresin = 500,rollingpaper = 1000,ruby = 500,sandwich = 1000,sausage = 1000,scubagear = 1000,silver = 500,sim = 1000,slaughtered_chicken = 20000,sodium_hydroxide = 1000,sorted_money = 1000,sosis = 2000,stone = 1000,sugarcane = 1,sulfuric_acid = 1000,tebu = 1000,tequila = 1000,thionyl_chloride = 1000,vodka = 1000,washed_stone = 1000,washpan = 1000,water = 1000,WEAPON_ADVANCEDRIFLE = 1000,WEAPON_APPISTOL = 1000,WEAPON_ASSAULTRIFLE = 1000,WEAPON_ASSAULTSHOTGUN = 1000,WEAPON_ASSAULTSMG = 1000,WEAPON_AUTOSHOTGUN = 1000,WEAPON_BALL = 1000,WEAPON_BAT = 1000,WEAPON_BATTLEAXE = 1000,WEAPON_BOTTLE = 1000,WEAPON_BULLPUPRIFLE = 1000,WEAPON_BULLPUPSHOTGUN = 1000,WEAPON_BZGAS = 1000,WEAPON_CARBINERIFLE = 1000,WEAPON_COMBATMG = 1000,WEAPON_COMBATPDW = 1000,WEAPON_COMBATPISTOL = 1000,WEAPON_COMPACTLAUNCHER = 1000,WEAPON_COMPACTRIFLE = 1000,WEAPON_CROWBAR = 1000,WEAPON_DAGGER = 1000,WEAPON_DBSHOTGUN = 1000,WEAPON_DIGISCANNER = 1000,WEAPON_DOUBLEACTION = 1000,WEAPON_FIREEXTINGUISHER = 1000,WEAPON_FIREWORK = 1000,WEAPON_FLARE = 1000,WEAPON_FLAREGUN = 1000,WEAPON_FLASHLIGHT = 1000,WEAPON_GARBAGEBAG = 1000,WEAPON_GOLFCLUB = 1000,WEAPON_GRENADE = 1000,WEAPON_GRENADELAUNCHER = 1000,WEAPON_GUSENBERG = 1000,WEAPON_HAMMER = 1000,WEAPON_HANDCUFFS = 1000,WEAPON_HATCHET = 1000,WEAPON_HEAVYPISTOL = 1000,WEAPON_HEAVYSHOTGUN = 1000,WEAPON_HEAVYSNIPER = 1000,WEAPON_HOMINGLAUNCHER = 1000,WEAPON_KNIFE = 1000,WEAPON_KNUCKLE = 1000,WEAPON_MACHETE = 1000,WEAPON_MACHINEPISTOL = 1000,WEAPON_MARKSMANPISTOL = 1000,WEAPON_MARKSMANRIFLE = 1000,WEAPON_MG = 1000,WEAPON_MICROSMG = 1000,WEAPON_MINIGUN = 1000,WEAPON_MINISMG = 1000,WEAPON_MOLOTOV = 1000,WEAPON_MUSKET = 1000,WEAPON_NIGHTSTICK = 1000,WEAPON_PETROLCAN = 1000,WEAPON_PIPEBOMB = 1000,WEAPON_PISTOL = 1000,WEAPON_PISTOL50 = 1000,WEAPON_POOLCUE = 1000,WEAPON_PROXMINE = 1000,WEAPON_PUMPSHOTGUN = 1000,WEAPON_RAILGUN = 1000,WEAPON_REVOLVER = 1000,WEAPON_RPG = 1000,WEAPON_SAWNOFFSHOTGUN = 1000,WEAPON_SMG = 1000,WEAPON_SMOKEGRENADE = 1000,WEAPON_SNIPERRIFLE = 1000,WEAPON_SNOWBALL = 1000,WEAPON_SNSPISTOL = 1000,WEAPON_SPECIALCARBINE = 1000,WEAPON_STICKYBOMB = 1000,WEAPON_STINGER = 1000,WEAPON_STUNGUN = 1000,WEAPON_SWITCHBLADE = 1000,WEAPON_VINTAGEPISTOL = 1000,WEAPON_WRENCH = 1000,weed_packaged = 1000,weed_untrimmed = 1000,whisky = 1000,wine = 1000,wood = 20000,wool = 2000,wrench = 1000
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
