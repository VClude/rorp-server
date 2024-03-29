Config = {}

Config.Locale = 'en' -- This is making it so that the script is in english if you wish to change the language goto the locales folder and edit en.lua and translate the lines

Config.TotalSpawnedCorps = 10
Config.TotalSpawnedTimes = 10
Config.cropsThreshold = 10

-- The marker Locations of the Points you need to drive over
Config.PlantMarkers = {
	vector3(-1928.93, 1952.65, 156.57),
	vector3(-1927.91, 1916.07, 170.89),
	vector3(-1934.96, 1929.59, 167.52)
}

-- This is the locations of the crops that spawn, so if you want 10 crops to spawn you need add 10 points if that makes sense
-- Config.FarmFields = vector3(-1934.96, 1929.59, 167.52)
Config.CropLocations = {
	vector3(-1937.14, 1941.36, 162.78),
	vector3(-1888.37, 1912.65, 162.13),
	vector3(-1906.66, 1913.3, 166.75),
	vector3(-1925.4, 1924.18, 167.36),
	vector3(-1965.32, 1946.65, 165.13),
	vector3(-1975.29, 1942.9, 169.68),
	vector3(-1944.77, 1926.31, 170.6),
	vector3(-1915.73, 1907.24, 169.92),
	vector3(-1892.01, 1921.36, 160.64),
	vector3(-1944.65, 1949.94, 159.5),
}

-- Marker to take off uniform
Config.ChangeClothes = vector3(443.03, 6459.09, 28.79)

-- Marker to sell the crops
Config.SellCrops = vector3(-1923.9, 2059.66, 140.83)

-- Marker to packaging the crops
Config.PackagingCropCoords = vector3(-1931.47, 2062.42, 140.94)

-- The Marker to start the job
Config.StartJob = { pos = vector3(-1920.96, 2048.85, 140.74), heading = 256.2 }

-- This is the options in the menu to select what crop you want to plant
Config.Seeds = {
	{label = 'Bibit Kedelai', DBname = 'kedelai'}, -- DBNAME IS THE ITEM YOU GET WHEN YOU HARVEST
	{label = 'Bibit Cocoa', DBname = 'cocoa'},
	{label = 'Bibit Teh', DBname = 'teh'},
	{label = 'Bitbit Kopi', DBname = 'bijikopi'},
	-- {label = 'TEST', DBname = 'test_item'},
}

-- This is the option for selling crops
Config.Crops = {
	{label = 'Sugarcane Seeds', DBname = 'sugarcane', price = 200},-- DBNAME IS THE ITEM YOU WOULD LIKE TO SELL
	-- {label = 'TEST', DBname = 'test_item', price = 0},
}

-- This is the option for selling crops
Config.PackagingCrop = {
	{label = 'Botol Kecap', DBname = 'botolkecap', bahan1 = 'kedelai', bahan2 = 'botolkaca'},
	{label = 'Botol Coklat', DBname = 'botolcoklat', bahan1 = 'cocoa', bahan2 = 'botolkaca'},
	{label = 'Teh Celup', DBname = 'tehcelup', bahan1 = 'teh', bahan2 = 'kain'},
	{label = 'Botol Kopi', DBname = 'botolkopi', bahan1 = 'bijikopi', bahan2 = 'botolkaca'},-- DBNAME IS THE ITEM YOU WOULD LIKE TO SELL
	-- {label = 'TEST', DBname = 'test_item', price = 0},
}

-- The Vehicle that is spawned
Config.WorkVehicle = 'Tractor2'

-- The database job name
Config.JobName = 'petani'

-- The Uniform for male and female, You need to change this to the uniform of your liking
Config.Uniform = {
	male = {
		tshirt_1 = 15,  tshirt_2 = 0,
		torso_1 = 52,   torso_2 = 0,
		decals_1 = 0,   decals_2 = 0,
		arms = 64,
		pants_1 = 90,   pants_2 = 0,
		shoes_1 = 34,   shoes_2 = 0,
		helmet_1 = 3,   helmet_2 = 2,
		chain_1 = -1,   chain_2 = -1,
		ears_1 = -1,    ears_2 = -1,
		bproof_1 = -1
	}, 
	female = {
		tshirt_1 = 177,  tshirt_2 = 0,
		torso_1 = 45,   torso_2 = 0,
		decals_1 = 0,   decals_2 = 0,
		arms = 78,
		pants_1 = 93,   pants_2 = 0,
		shoes_1 = 5,   shoes_2 = 0,
		helmet_1 = 1,  helmet_2 = 0,
		chain_1 = 0,    chain_2 = 0,
		ears_1 = -1,     ears_2 = 0,
		bproof_1 = -1
	}
}

Config.BlipID = 1