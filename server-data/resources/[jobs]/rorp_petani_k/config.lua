Config = {}

Config.Locale = 'en' -- This is making it so that the script is in english if you wish to change the language goto the locales folder and edit en.lua and translate the lines

Config.TotalSpawnedCorps = 5
Config.TotalSpawnedTimes = 20

-- The marker Locations of the Points you need to drive over
Config.PlantMarkers = {
	vector3(-1933.58, 1954.09, 160.92),
	vector3(-1927.91, 1916.07, 170.89),
	vector3(-1943.28, 1940.42, 164.32),
}

-- This is the locations of the crops that spawn, so if you want 10 crops to spawn you need add 10 points if that makes sense
Config.FarmFields = vector3(-1934.96, 1929.59, 167.52)

-- Marker to take off uniform
Config.Management = vector3(443.03, 6459.09, 28.79)

-- Marker to sell the crops
Config.SellCrops = vector3(442.31, 6506.72, 28.77)

-- The Marker to start the job
Config.StartJob = { pos = vector3(-1920.96, 2048.85, 140.74), heading = 256.2 }

-- This is the options in the menu to select what crop you want to plant
Config.Seeds = {
	{label = 'Sugarcane Seeds', DBname = 'sugarcane'}, -- DBNAME IS THE ITEM YOU GET WHEN YOU HARVEST
	-- {label = 'TEST', DBname = 'test_item'},
}

-- This is the option for selling crops
Config.Crops = {
	{label = 'Sugarcane Seeds', DBname = 'sugarcane', price = 200},-- DBNAME IS THE ITEM YOU WOULD LIKE TO SELL
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