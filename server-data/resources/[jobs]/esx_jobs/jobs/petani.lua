Config.Jobs.petani = {

	BlipInfos = {
		Sprite = 85,
		Color = 4
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = 'youga2',
			Trailer = 'none',
			HasCaution = true
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 2402.97, y = 5021.44, z = 46.13},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('dd_dress_locker'),
			Type = 'cloakroom',
			Hint = _U('cloak_change'),
			GPS = {x = 740.80, y = -970.06, z = 23.46}
		},

		Wool = {
			Pos = {x = 2345.74, y = 5024.06, z = 43.7},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('dd_wool'),
			Type = 'work',
			Duration = 20000,
			Item = {
				{
					name = _U('dd_wool'),
					db_name = 'jeruk',
					time = 3,
					max = 40,
					add = 1,
					remove = 0,
					requires = 'nothing',
					requires_name = 'Nothing',
					drop = 100
				}
			},
			Hint = _U('dd_pickup'),
			GPS = {x = 715.95, y = -959.63, z = 29.39}
		},

		VehicleSpawner = {
			Pos = {x = 2404.81, y = 5037.68, z = 45.99},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U('spawn_veh'),
			Type = 'vehspawner',
			Spawner = 1,
			Hint = _U('spawn_veh_button'),
			Caution = 2000,
			GPS = {x = 1978.92, y = 5171.70, z = 46.63}
		},

		VehicleSpawnPoint = {
			Pos = {x = 2421.24, y = 5031.01, z = 45.95},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U('service_vh'),
			Type = 'vehspawnpt',
			Spawner = 1,
			Heading = 270.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 2400.07, y = 5053.74, z = 46.39},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U('return_vh'),
			Type = 'vehdelete',
			Hint = _U('return_vh_button'),
			Spawner = 1,
			Caution = 2000,
			GPS = 0,
			Teleport = 0
		},

		Delivery = {
			Pos = {x = -437.62, y = 1591.73, z = 357.55},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Marker = 1,
			Blip = true,
			Name = _U('delivery_point'),
			Type = 'delivery',
			Spawner = 1,
			Item = {
				{
					name = _U('delivery'),
					time = 0.5,
					remove = 1,
					max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 40,
					requires = 'clothe',
					requires_name = _U('dd_clothing'),
					drop = 100
				}
			},
			Hint = _U('dd_deliver_clothes'),
			GPS = {x = 1978.92, y = 5171.70, z = 46.63}
		}
	}
}
