Config = {}
Config.Blip			= {sprite= 524, color = 30}
Config.InpoundBlip	= {sprite= 524, color = 20}
Config.BoatBlip		= {sprite= 410, color = 30}
Config.AirplaneBlip	= {sprite= 524, color = 188}
Config.MecanoBlip	= {sprite= 357, color = 26}
Config.Price		= 500 -- pound price to get vehicle back
Config.SwitchGaragePrice		= 2000 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = false -- Store all vehicles in garage on server start?
Config.Locale = 'en'

Config.Inpounds = {
	Pusat_Refound = {
		Pos = {x=215.800, y=-810.057, z=30.727},
		Marker = { w= 0.8, h= 0.5, r = 204, g = 204, b = 0},
		Name = _U('refound_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 30.5722},
			Heading = 160.0,
		},	
	},
}
Config.Garages = {
	Garasi_Taman = {
		Pos = {x = 1033.9229736328,y = -767.10662841797,z = 58.003326416016 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1040.6834716797,y = -778.18170166016,z = 58.022853851318 },
			Heading = 359.92,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1022.7816772461,y = -763.78955078125,z = 57.961227416992 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garasi_Golf = {
		Name = _('garage_name'),
		SpawnPoint = {
			Pos = {x = -1358.66,y = -19.53,z = 52.55 },
			Heading = 53.23,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1362.39,y = -23.69,z = 52.82 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garasi_Perumahan = {
		Name = _('garage_name'),
		SpawnPoint = {
			Pos = {x = 317.1,y = -2031.78,z = 20.2 },
			Heading = 322.11,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 335.22,y = -2040.34,z = 20.7 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garasi_Pelabuhan = {
		Name = "Garasi Pelabuhan",
		SpawnPoint = {
			Pos = {x = -777.69,y = -1324.03,z = 5.15 },
			Heading = 315.06,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -776.31,y = -1334.08,z = 5 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	-- Garasi_Paleto = {
	-- 	Name = _('garage_name'),
	-- 	SpawnPoint = {
	-- 		Pos = {x = -90.09,y = 6555.63,z = 31.49 },
	-- 		Heading = 224.36,
	-- 		Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = _U('spawn_car')
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = -77.89,y = 6537.23,z = 31.49 },
	-- 		Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = _U('store_car')
	-- 	}, 	
	-- },
	-- Garasi_Shandy = {
	-- 	Name = _('garage_name'),
	-- 	SpawnPoint = {
	-- 		Pos = {x = 1480.74,y = 3751.08,z = 33.75 },
	-- 		Heading = 224.36,
	-- 		Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = _U('spawn_car')
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = 1463.99,y = 3741.58,z = 33.56 },
	-- 		Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = _U('store_car')
	-- 	},
	-- },
	Garasi_Walkot = {
		Name = _('garage_name'),
		SpawnPoint = {
			Pos = {x = -414.41,y = 1201.2,z = 324.96 },
			Heading = 165.35,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -389.18,y = 1219.6,z = 324.96 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		},
	},
}

-- Config.GaragesMecano = {
-- 	Bennys = {
-- 		Name = _U('bennys_pound'),
-- 		SpawnPoint = {
-- 			Pos = {x = 477.729,y = -1888.856,z = 26.094},
-- 			Heading = 303.0,
-- 			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 			HelpPrompt = _U('take_from_pound')
-- 		},
-- 		DeletePoint = {
-- 			Pos = {x = 459.733,y = -1890.335,z = 25.776},
-- 			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 			HelpPrompt = _U('store_in_pound')
-- 		}, 	
-- 	},
-- 	police = {
-- 		Name = _U('police_pound'),
-- 		SpawnPoint = {
-- 			Pos = {x = 449.253,y = -1024.322,z = 28.57},
-- 			Heading = 100.0,
-- 			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 			HelpPrompt = _U('take_from_pound')
-- 		},
-- 		DeletePoint = {
-- 			Pos = {x = 452.305,y = -996.752,z = 25.776},
-- 			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 			HelpPrompt = _U('store_in_pound')
-- 		}, 	
-- 	},
-- 	police2 = {
-- 		Name = _U('police_pound'),
-- 		SpawnPoint = {
-- 			Pos = {x = 1868.325,y = 3694.566,z = 33.61},
-- 			Heading = 100.0,
-- 			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 			HelpPrompt = _U('take_from_pound')
-- 		},
-- 		DeletePoint = {
-- 			Pos = {x = 1860.925,y = 3706.958,z = 33.36},
-- 			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 			HelpPrompt = _U('store_in_pound')
-- 		}, 	
-- 	},
-- 	police3 = {
-- 		Name = _U('police_pound'),
-- 		SpawnPoint = {
-- 			Pos = {x = -474.000,y = 6029.71,z = 30.94},
-- 			Heading = 226.0,
-- 			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 			HelpPrompt = _U('take_from_pound')
-- 		},
-- 		DeletePoint = {
-- 			Pos = {x = -462.932,y = 60.41,z = 31.34},
-- 			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 			HelpPrompt = _U('store_in_pound')
-- 		}, 	
-- 	},
	-- Bennys2 = {
		-- Marker = 1,
		-- SpawnPoint = {
			-- Pos = {x=-190.455, y= -1290.654, z= 30.295},
			-- Color = {r=0,g=255,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- },
		-- DeletePoint = {
			-- Pos = {x=-190.379, y=-1284.667, z=30.233},
			-- Color = {r=255,g=0,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- }, 	
	-- },
-- }

-- Config.BoatGarages = {
	-- BoatGarage_Centre = {
	-- 	Pos = {x = -742.47064208984,y = -1332.4702148438,z = 1.59 },
	-- 	Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
	-- 	Name = _U('boat_garage_name'),
	-- 	HelpPrompt = _U('open_boat_garage'),
	-- 	SpawnPoint = {
	-- 		Pos = {x = -736.47064208984,y = -1342.4702148438,z = 1.0 },
	-- 		MarkerPos = {x = -733.58,y = -1338.62,z = 1.5 },
	-- 		Heading = 230.0,
	-- 		Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = _U('spawn_boat')
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = -740.06408691406,y = -1361.8474121094,z = 1.8801808655262 },
	-- 		Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = _U('store_boat')
	-- 	}, 	
	-- },
-- }

-- Config.AirplaneGarages = {
	-- AirplaneGarage_Centre = {
	-- 	Pos = {x = -1280.1153564453,y = -3378.1647949219,z = 13.940155029297 },
	-- 	Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
	-- 	Name = _U('plane_garage_name'),
	-- 	HelpPrompt = _U('open_plane_garage'),
	-- 	SpawnPoint = {
	-- 		Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
	-- 		Heading = 160.0,
	-- 		Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = _U('spawn_plane')
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
	-- 		Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = _U('store_plane')
	-- 	}, 	
	-- },
-- }


-- Config.SocietyGarages = {
-- 	police =  { -- database job name
-- 		{
-- 			Pos = {x = 446.39,y = -984.844,z = 30.696 },
-- 			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
-- 			Name = _U('police_garage_name'),
-- 			HelpPrompt = _U('open_police_garage'),
-- 			SpawnPoint = {
-- 				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
-- 				Heading = 160.0,
-- 				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 				HelpPrompt = _U('spawn_police_garage')
-- 			},
-- 			DeletePoint = {
-- 				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
-- 				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 				HelpPrompt = _U('store_police_garage')
-- 			}, 	
-- 		},
-- 		{
-- 			Pos = {x = 448.1153564453,y = -976.86,z = 30.696 },
-- 			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
-- 			Name = _U('police_garage_name'),
-- 			HelpPrompt = _U('open_police_garage'),
-- 			SpawnPoint = {
-- 				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
-- 				Heading = 160.0,
-- 				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 				HelpPrompt = _U('spawn_police_garage')
-- 			},
-- 			DeletePoint = {
-- 				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
-- 				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 				HelpPrompt = _U('store_police_garage')
-- 			}, 	
-- 		},
-- 	},
-- 	brinks =  {
-- 		{
-- 			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
-- 			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
-- 			Name = _U('brinks_garage_name'),
-- 			HelpPrompt = _U('open_brinks_garage'),
-- 			SpawnPoint = {
-- 				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
-- 				Heading = 160.0,
-- 				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 				HelpPrompt = _U('spawn_brinks_garage')
-- 			},
-- 			DeletePoint = {
-- 				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
-- 				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 				HelpPrompt = _U('store_brinks_garage')
-- 			}, 	
-- 		},
--     },
-- 	ambulance =  {
-- 		{
-- 			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
-- 			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
-- 			Name = _U('ambulance_garage_name'),
-- 			HelpPrompt = _U('open_ambulance_garage'),
-- 			SpawnPoint = {
-- 				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
-- 				Heading = 160.0,
-- 				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 				HelpPrompt = _U('spawn_ambulance_garage')
-- 			},
-- 			DeletePoint = {
-- 				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
-- 				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 				HelpPrompt = _U('store_ambulance_garage')
-- 			}, 	
-- 		},
-- 	},
-- 	taxi =  {
-- 		{
-- 			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
-- 			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
-- 			Name = _U('taxi_garage_name'),
-- 			HelpPrompt = _U('open_taxi_garage'),
-- 			SpawnPoint = {
-- 				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
-- 				Heading = 160.0,
-- 				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
-- 				HelpPrompt = _U('spawn_taxi_garage')
-- 			},
-- 			DeletePoint = {
-- 				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
-- 				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
-- 				HelpPrompt = _U('store_taxi_garage')
-- 			}, 	
-- 		},
--     },
-- }
