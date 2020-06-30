

Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 50  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 30 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(364.1, -593.16, 43.28), heading = 65.61}

Config.Hospitals = {

	PillboxHill = {

		Blip = {
			coords = vector3(305.21, -586.99, 43.28),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(299.08, -598.26, 42.28),
			vector3(338.61, -595.46, 42.28)
		},

		Pharmacies = {
			vector3(344.77, -592.43, 42.28)
		},

		Vehicles = {
			{
				Spawner = vector3(295.9, -590.41, 42.26),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(290.61, -590.51, 43.18), heading = 338.03, radius = 4.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.65, -580.75, 73.16),
				InsideShop = vector3(351.11, -587.95, 74.16),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.11, -587.95, 74.16), heading = 228.37, radius = 10.0}
				}
			}
		},
		
		FastTravels = {
		
			{
				From = vector3(329.77, -601.06, 42.28),
				To = {coords = vector3(338.49, -583.85, 74.16), heading = 251.4},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(338.49, -583.85, 73.16),
				To = {coords = vector3(329.77, -601.06, 43.28), heading = 143.72},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance2', price = 1}
		},

		doctor = {
			{model = 'ambulance2', price = 1}
		},

		chief_doctor = {
			{model = 'ambulance2', price = 1}
		},

		boss = {
			{model = 'ambulance1', price = 1},
			{model = 'ambulance2', price = 1},
			{model = 'ambulance3', price = 1}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {},


		chief_doctor = {
			{model = 'ambuheli', price = 1}
		},

		boss = {
			{model = 'ambuheli', price = 1}
		}
	}
}
