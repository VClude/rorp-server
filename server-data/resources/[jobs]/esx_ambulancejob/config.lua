

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

	Pillbox Hill = {

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
				Marker = {type = -1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(338.49, -583.85, 73.16),
				To = {coords = vector3(329.77, -601.06, 43.28), heading = 143.72},
				Marker = {type = -1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}
		}

	}
	
	-- Stad = {

	-- 	Blip = {
	-- 		coords = vector3(358.11, -590.55, 28.79),
	-- 		sprite = 61,
	-- 		scale  = 1.2,
	-- 		color  = 2
	-- 	},

	-- 	AmbulanceActions = {
	-- 		vector3(339.08, -581.91, 27.92)
	-- 	},

	-- 	Pharmacies = {
	-- 		vector3(337.43, -586.39, 27.9)
	-- 	},

	-- 	Vehicles = {
	-- 	{
	-- 			Spawner = vector3(358.36, -589.13, 28.8),
	-- 			InsideShop = vector3(446.7, -1355.6, 43.5),
	-- 			Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(366.4, -593.51, 28.7), heading = 349.36, radius = 4.0},
	-- 				{coords = vector3(362.86, -590.59, 28.68), heading = 156.78, radius = 4.0}
	-- 			}
	-- 		},
	-- 		{
	-- 			Spawner = vector3(296.04, -591.46, 43.27),
	-- 			InsideShop = vector3(446.7, -1355.6, 43.5),
	-- 			Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(293.38, -590.37, 43.13), heading = 337.59, radius = 4.0},
	-- 				{coords = vector3(288.56, -588.34, 43.15), heading = 155.19, radius = 4.0}
	-- 			}
	-- 		}

	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(340.15, -581.41, 73.17),
	-- 			InsideShop = vector3(305.6, -1419.7, 41.5),
	-- 			Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
	-- 			}
	-- 		}
	-- 	},

	-- 	FastTravels = {
		
	-- 		{
	-- 			From = vector3(335.72, -580.28, 42.29),
	-- 			To = {coords = vector3(335.79, -580.26, 74.07), heading = 153.31},
	-- 			Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
	-- 		},

	-- 		{
	-- 			From = vector3(326.2, -580.32, 27.45),
	-- 			To = {coords = vector3(327.19, -580.29, 43.28), heading = 246.09},
	-- 			Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
	-- 		}
	-- 	}
		
	-- },
	
	-- SandyShores = {

	-- 	Blip = {
	-- 		coords = vector3(1839.19, 3673.06, 34.28),
	-- 		sprite = 61,
	-- 		scale  = 1.2,
	-- 		color  = 2
	-- 	},

	-- 	AmbulanceActions = {
	-- 		vector3(1825.37, 3674.64, 33.27)
	-- 	},

	-- 	Pharmacies = {
	-- 		vector3(1843.75, 3681.47, 33.27)
	-- 	},

	-- 	Vehicles = {
	-- 	{
	-- 			Spawner = vector3(1841.78, 3675.08, 33.28),
	-- 			InsideShop = vector3(446.7, -1355.6, 43.5),
	-- 			Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(1841.08, 3668.66, 33.68), heading = 295.16, radius = 4.0}
	-- 			}
	-- 		},
	-- 		{
	-- 			Spawner = vector3(1825.33, 3689.86, 33.22),
	-- 			InsideShop = vector3(446.7, -1355.6, 43.5),
	-- 			Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(1826.69, 3693.69, 34.22), heading = 297.62, radius = 4.0}
	-- 			}
	-- 		}

	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(340.15, -581.41, 73.17),
	-- 			InsideShop = vector3(305.6, -1419.7, 41.5),
	-- 			Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
	-- 			}
	-- 		}
	-- 	}
		
	-- 	},
	
	-- PaletoBay = {

	-- 	Blip = {
	-- 		coords = vector3(-247.18, 6330.59, 32.43),
	-- 		sprite = 61,
	-- 		scale  = 1.2,
	-- 		color  = 2
	-- 	},

	-- 	AmbulanceActions = {
	-- 		vector3(-253.01, 6326.98, 31.41)
	-- 	},

	-- 	Pharmacies = {
	-- 		vector3(-242.01, 6320.06, 31.41)
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(-247.75, 6334.95, 31.49),
	-- 			InsideShop = vector3(446.7, -1355.6, 43.5),
	-- 			Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(-242.37, 6335.37, 32.43), heading = 224.32, radius = 4.0}
	-- 			}
	-- 		}

	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(340.15, -581.41, 73.17),
	-- 			InsideShop = vector3(305.6, -1419.7, 41.5),
	-- 			Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
	-- 			SpawnPoints = {
	-- 				{coords = vector3(351.62, -588.0, 74.17), heading = 241.37, radius = 10.0}
	-- 			}
	-- 		}
	-- 	}
	-- }
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
