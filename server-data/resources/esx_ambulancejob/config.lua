

Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 50  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 5  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(353.58, -1406.65, 32.43), heading = 40.4}

Config.Hospitals = {

	Hoofdbureau = {

		Blip = {
			coords = vector3(342.82, -1397.9, 31.51),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(352.63, -1419.28, 31.94),
			vector3(280.98, -1445.62, 28.97)
		},

		Pharmacies = {
			vector3(365.32, -1384.34, 3143),
			vector3(308.0, -1466.75, 2897)
		},

		Vehicles = {
			{
				Spawner = vector3(301.41, -1429.03, 29.97),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(299.71, -1431.31, 29.8), heading = 225.19, radius = 4.0},
					{coords = vector3(294.07, -1439.11, 29.8), heading = 225.67, radius = 4.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(313.42, -1465.16, 46.5), heading = 136.39, radius = 10.0},
					{coords = vector3(299.5, -1453.2, 46.5), heading = 136.11, radius = 10.0}
				}
			}
		},
		
		FastTravels = {
		
			{
				From = vector3(338.63, -1427.37, 31.43),
				To = {coords = vector3(337.31, -1429.53, 45.4), heading = 143.72},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		}

	},
	
	Stad = {

		Blip = {
			coords = vector3(358.11, -590.55, 28.79),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(339.08, -581.91, 27.92)
		},

		Pharmacies = {
			vector3(337.43, -586.39, 27.9)
		},

		Vehicles = {
		{
				Spawner = vector3(358.36, -589.13, 28.8),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(366.4, -593.51, 28.7), heading = 349.36, radius = 4.0},
					{coords = vector3(362.86, -590.59, 28.68), heading = 156.78, radius = 4.0}
				}
			},
			{
				Spawner = vector3(296.04, -591.46, 43.27),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(293.38, -590.37, 43.13), heading = 337.59, radius = 4.0},
					{coords = vector3(288.56, -588.34, 43.15), heading = 155.19, radius = 4.0}
				}
			}

		},

		Helicopters = {
			{
				Spawner = vector3(340.15, -581.41, 73.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
				}
			}
		},

		FastTravels = {
		
			{
				From = vector3(335.72, -580.28, 42.29),
				To = {coords = vector3(335.79, -580.26, 74.07), heading = 153.31},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(326.2, -580.32, 27.45),
				To = {coords = vector3(327.19, -580.29, 43.28), heading = 246.09},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		}
		
	},
	
	SandyShores = {

		Blip = {
			coords = vector3(1839.19, 3673.06, 34.28),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(1825.37, 3674.64, 33.27)
		},

		Pharmacies = {
			vector3(1843.75, 3681.47, 33.27)
		},

		Vehicles = {
		{
				Spawner = vector3(1841.78, 3675.08, 33.28),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(1841.08, 3668.66, 33.68), heading = 295.16, radius = 4.0}
				}
			},
			{
				Spawner = vector3(1825.33, 3689.86, 33.22),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(1826.69, 3693.69, 34.22), heading = 297.62, radius = 4.0}
				}
			}

		},

		Helicopters = {
			{
				Spawner = vector3(340.15, -581.41, 73.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
				}
			}
		}
		
		},
	
	PaletoBay = {

		Blip = {
			coords = vector3(-247.18, 6330.59, 32.43),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(-253.01, 6326.98, 31.41)
		},

		Pharmacies = {
			vector3(-242.01, 6320.06, 31.41)
		},

		Vehicles = {
			{
				Spawner = vector3(-247.75, 6334.95, 31.49),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(-242.37, 6335.37, 32.43), heading = 224.32, radius = 4.0}
				}
			}

		},

		Helicopters = {
			{
				Spawner = vector3(340.15, -581.41, 73.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
				}
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
