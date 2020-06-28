Config = {}

Config.Locale = 'en' -- This is making it so that the script is in english if you wish to change the language goto the locales folder and edit en.lua and translate the lines

-- The marker Locations of the Points you need to drive over
Config.PlantMarkers = {
	vector3(714.31, 6459.42, 30.89),
	vector3(719.9, 6480.5, 28.40),
	vector3(652.99, 6485.8, 29.62),
}

-- This is the locations of the crops that spawn, so if you want 10 crops to spawn you need add 10 points if that makes sense
Config.CropLocations = {
	-- vector3(714.31, 6459.42, 30.89),
	-- vector3(719.9, 6480.5, 28.40),
	-- vector3(652.99, 6485.8, 29.62),
	-- vector3(653.7, 6480.58, 30.12),
	vector3(664.95, 6474.08, 30.31)
}

Config.LokasiTebu = vector3(664.95, 6474.08, 30.31)


-- Marker to take off uniform
Config.Management = vector3(443.03, 6459.09, 28.79)
-- Marker to sell the crops
Config.SellCrops = vector3(442.31, 6506.72, 28.77)

-- The Marker to start the job
Config.StartJob = { pos = vector3(437.37, 6455.59, 28.74), heading = 327.41 }

-- This is the options in the menu to select what crop you want to plant
Config.Seeds = {
	{label = 'Sugarcane Seeds', DBname = 'sugarcane'}, -- DBNAME IS THE ITEM YOU GET WHEN YOU HARVEST
	{label = 'Poppy Seeds', DBname = 'poppyresin'},
	-- {label = 'TEST', DBname = 'test_item'},
}

-- This is the option for selling crops
Config.Crops = {
	{label = 'Sugarcane Seeds', DBname = 'sugarcane', price = 200},
	 -- DBNAME IS THE ITEM YOU WOULD LIKE TO SELL
	-- {label = 'TEST', DBname = 'test_item', price = 0},
}
-- The Vehicle that is spawned
Config.WorkVehicle = 'Tractor'

-- The database job name
Config.JobName = 'farmer'

-- The Uniform for male and female, You need to change this to the uniform of your liking
Config.Uniform = {
	male = {
		tshirt_1 = 59,  tshirt_2 = 1,
		torso_1 = 55,   torso_2 = 0,
		decals_1 = 0,   decals_2 = 0,
		arms = 41,
		pants_1 = 25,   pants_2 = 0,
		shoes_1 = 25,   shoes_2 = 0,
		helmet_1 = 46,  helmet_2 = 0,
		chain_1 = 0,    chain_2 = 0,
		ears_1 = 2,     ears_2 = 0,
		bproof_1 = -1
	}, 
	female = {
		tshirt_1 = 59,  tshirt_2 = 1,
		torso_1 = 55,   torso_2 = 0,
		decals_1 = 0,   decals_2 = 0,
		arms = 41,
		pants_1 = 25,   pants_2 = 0,
		shoes_1 = 25,   shoes_2 = 0,
		helmet_1 = 46,  helmet_2 = 0,
		chain_1 = 0,    chain_2 = 0,
		ears_1 = 2,     ears_2 = 0,
		bproof_1 = -1
	}
}

Config.BlipID = 1