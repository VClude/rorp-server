Config = {}
Config.Locale = 'en'
Config.DebugLog = false

-- Fuel options: These just set the initial fuel to 100%, if you're using the associated fuel script. Be sure to set any others to false.
-- Note:  If using newer versions of LegacyFuel, make sure LegacyFuelFolderName matches the name of the LegacyFuel resource folder, in case you renamed it.
Config.UseLegacyFuel = true
Config.LegacyFuelFolderName = 'LegacyFuel'
Config.UseFrFuel = false

Config.PutPlayerInBusOnSpawn = true
Config.OnlyShowPedsOnClient = true

Config.EnterVehicleTimeout = 10000
Config.DelayBetweenChanges = 1000
Config.DeleteDistance = 100.0
Config.Markers = {
    Size = 10.0,
    StartColor = {r = 20, g = 200, b = 20, a = 100},
    AbortColor = {r = 200, g = 20, b = 20, a = 100},
}

Config.ShowOverlay = true

Config.Routes = {
    AirportRoute,
    ScenicRoute,
    MetroRoute
}

Config.Uniforms = {
	working = {
		male = {
			["tshirt_1"] = -1,
			["tshirt_2"] = -1,
			["torso_1"] = 95,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 0,
			["pants_1"] = 62,
			["pants_2"] = 0,
			["shoes_1"] = 5,
			["shoes_2"] = 0,
			["helmet_1"] = 143,
			["helmet_2"] = 143,
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
