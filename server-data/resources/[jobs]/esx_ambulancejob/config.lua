Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true}

Config.ReviveReward               = 700  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(365.35, -593.44, 43.28), heading = 63.99}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(317.3, -590.66, 43.28),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(299.15, -598.12, 42.28),
			vector3(334.8, -592.72, 42.28)
		},

		Pharmacies = {
			vector3(344.71, -592.45, 42.28)
		},

		Vehicles = {
			{
				Spawner = vector3(299.05, -573.07, 43.26),
				InsideShop = vector3(290.37, -561.75, 43.26),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(291.88, -573.33, 43.2), heading = 61.22, radius = 4.0},
					{coords = vector3(291.88, -573.33, 43.2), heading = 61.22, radius = 4.0},
					{coords = vector3(291.88, -573.33, 43.2), heading = 61.22, radius = 4.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(345.64, -580.65, 74.16),
				InsideShop = vector3(350.91, -587.78, 74.16),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(350.91, -587.78, 74.16), heading = 248.66, radius = 10.0},
					{coords = vector3(350.91, -587.78, 74.16), heading = 248.66, radius = 10.0}
				}
			}
		},

		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = {coords = vector3(272.8, -1358.8, 23.5), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(329.81, -601.02, 42.28),
				To = {coords = vector3(338.96, -583.99, 74.16), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},
			{
				From = vector3(338.96, -583.99, 73.16),
				To = {coords = vector3(329.81, -601.02, 42.28), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance', price = 5000}
		},

		doctor = {
			{model = 'ambulance', price = 4500}
		},

		chief_doctor = {
			{model = 'ambulance', price = 3000}
		},

		boss = {
			{model = 'ambulance', price = 2000}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'buzzard2', price = 150000}
		},

		chief_doctor = {
			{model = 'buzzard2', price = 150000},
			{model = 'seasparrow', price = 300000}
		},

		boss = {
			{model = 'buzzard2', price = 10000},
			{model = 'seasparrow', price = 250000}
		}
	}
}
