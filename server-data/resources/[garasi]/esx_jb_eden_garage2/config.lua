Config = {}
Config.Blip			= {sprite= 524, color = 30}
Config.InpoundBlip	= {sprite= 524, color = 20}
Config.Price		= 2000 -- pound price to get vehicle back
Config.SwitchGaragePrice		= 2000 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = true -- Store all vehicles in garage on server start?
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
			Pos = {x = -783.83,y = -1333.2,z = 5.0 },
			Heading = 69.59,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -763.06,y = -1321.89,z = 5.0 },
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

