Config.Jobs.miner = {

	BlipInfos = {
		Sprite = 318,
		Color = 5
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = 'rubble',
			Trailer = 'none',
			HasCaution = true
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 892.35, y = -2172.77, z = 31.28},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_miner_locker'),
			Type = 'cloakroom',
			Hint = _U('cloak_change'),
			GPS = {x = 884.86, y = -2176.51, z = 29.51}
		},

		Mine = {
			Pos = {x = 2970.8962402344, y = 2837.1481933594, z = 42.39},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_rock'),
			Type = 'cust_work',
			MiningSpots = 
			{
				{ 
					Pos = { x = 2972.1259765625, y = 2841.3889160156, z = 46.025562286377 },
					Heading = 292.26123046875,
					InUse = false
				},
				{ 
					Pos = { x = 2973.166015625, y = 2837.9240722656, z = 45.692588806152 },
					Heading = 294.16989135742,
					InUse = false
				},
				{ 
					Pos = { x = 2974.2604980469, y = 2834.1079101563, z = 45.742488861084 },
					Heading = 312.42669677734,
					InUse = false
				},
				{ 
					Pos = { x = 2977.44, y = 2832.41, z = 46.41 },
					Heading = 320.27,
					InUse = false
				},
				{ 
					Pos = { x = 2978.7, y = 2829.05, z = 46.25 },
					Heading = 284.95,
					InUse = false
				},
				{ 
					Pos = { x = 2980.33, y = 2825.32, z = 45.93 },
					Heading = 315.82,
					InUse = false
				}
			},

			MiningMarker = 27, 												-- marker type
			MiningMarkerColor = { r = 30, g = 139, b = 195, a = 170 }, 		-- rgba color of the marker
			MiningMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }, 			-- the scale for the marker on the x, y and z axis
			DrawMining3DText = "Tekan ~g~[E]~s~ untuk ~b~Menambang~s~",				-- set your desired text here
			
			KeyToStartMining = 38,
			Hint = _U('m_pickrocks'),
			GPS = {x = 1966.8696289063, y = 536.98706054688, z = 160.92445373535}
		},


		StoneWash = {
			Pos = {x = 1966.8696289063, y = 536.98706054688, z = 160.92445373535},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_washrock'),
			Type = 'cust_work',
			WasherLocation = {
				{ ["x"] = 1966.8696289063, ["y"] = 536.98706054688, ["z"] = 160.92445373535, ["h"] = 0 },
				{ ["x"] = 1966.31, ["y"] = 530.83, ["z"] = 160.73, ["h"] = 0 },
				{ ["x"] = 1965.01, ["y"] = 525.86, ["z"] = 160.93, ["h"] = 0 },
				{ ["x"] = 1972.54, ["y"] = 523.3, ["z"] = 160.97, ["h"] = 0 },
				{ ["x"] = 1971.23, ["y"] = 518.41, ["z"] = 161.14, ["h"] = 0 },
			},
			
			WasherBlipNameOnMap = "Washer",				-- set name of the blip
			WasherBlipSprite = 318,						-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
			WasherBlipDisplay = 4,						-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
			WasherBlipScale = 1.0,						-- set blip scale/size on your map
			WasherBlipColour = 5,							-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/
			
			WasherMarker = 27, 												-- marker type
			WasherMarkerColor = { r = 30, g = 139, b = 195, a = 170 }, 		-- rgba color of the marker
			WasherMarkerScale = { x = 2.5, y = 2.5, z = 2.5 },  			-- the scale for the marker on the x, y and z axis
			DrawWasher3DText = "Tekan ~g~[E]~s~ untuk ~b~Mencuci Batu~s~",				-- set your desired text here
			
			KeyToStartWashing = 38,
			Hint = _U('m_rock_button'),
			GPS = {x = 1088.3415527344, y = -2001.4940185547, z = 30.879274368286}
		},

		Foundry = {
			Pos = {x = 1088.3415527344, y = -2001.4940185547, z = 30.879274368286},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_rock_smelting'),
			Type = 'work',
			SmelterBlipNameOnMap = "Smelter",				-- set name of the blip
			SmelterBlipSprite = 318,					-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
			SmelterBlipDisplay = 4,						-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
			SmelterBlipScale = 1.0,						-- set blip scale/size on your map
			SmelterBlipColour = 5,					-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/
			
			-- Smelter Spots:
			SmelterSpots = 
			{
			
				{ 
					Pos = { x = 1088.0810546875, y = -2001.5245361328, z = 30.879693984985 },
					Heading = 145.24116516114,
					InUse = false
				},
					
				{ 
					Pos = { x = 1088.5109863281, y = -2005.1209716797, z = 31.153043746948 },
					Heading = 57.49296951294,
					InUse = false
				},
				
				
				{ 
					Pos = { x = 1084.6192626953, y = -2001.9174804688, z = 31.406444549561 },
					Heading = 225.95713806152,
					InUse = false
				}
				
			},
			
			SmelterMarker = 27,												-- marker type
			SmelterMarkerColor = { r = 240, g = 52, b = 52, a = 100 }, 		-- rgba color of the marker
			SmelterMarkerScale = { x = 1.25, y = 1.25, z = 1.25 },  			-- the scale for the marker on the x, y and z axis
			DrawSmelter3DText = "Tekan ~g~[E]~s~ untuk ~y~Melebur Batu~s~",				-- set your desired text here
			
			KeyToStartSmelting = 38,
			Hint = _U('m_melt_button'),
			GPS = {x = -169.48, y = -2659.16, z = 5.00}
		},

		VehicleSpawner = {
			Pos = {x = 884.86, y = -2176.51, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U('spawn_veh'),
			Type = 'vehspawner',
			Spawner = 1,
			Hint = _U('spawn_veh_button'),
			Caution = 2000,
			GPS = {x = 2962.40, y = 2746.20, z = 42.39}
		},

		VehicleSpawnPoint = {
			Pos = {x = 879.55, y = -2189.79, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U('service_vh'),
			Type = 'vehspawnpt',
			Spawner = 1,
			Heading = 90.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {x = 881.93, y = -2198.01, z = 29.51},
			Size = {x = 5.0, y = 5.0, z = 1.0},
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

		CopperDelivery = {
			Pos = {x = -169.481, y = -2659.16, z = 5.00103},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Marker = 1,
			Blip = true,
			Name = _U('m_sell_copper'),
			Type = 'delivery',
			Spawner = 1,
			Item = {
				{
					name = _U('delivery'),
					time = 0.5,
					remove = 1,
					max = 56, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 5,
					requires = 'copper',
					requires_name = _U('m_copper'),
					drop = 100
				}
			},
			Hint = _U('m_deliver_copper'),
			GPS = {x = -148.78, y = -1040.38, z = 26.27}
		},

		IronDelivery = {
			Pos = {x = -148.78, y = -1040.38, z = 26.27},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_sell_iron'),
			Type = 'delivery',
			Spawner = 1,
			Item = {
				{
					name = _U('delivery'),
					time = 0.5,
					remove = 1,
					max = 42, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 9,
					requires = 'iron',
					requires_name = _U('m_iron'),
					drop = 100
				}
			},
			Hint = _U('m_deliver_iron'),
			GPS = {x = 261.48, y = 207.35, z = 109.28}
		},

		GoldDelivery = {
			Pos = {x = 261.48, y = 207.35, z = 109.28},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_sell_gold'),
			Type = 'delivery',
			Spawner = 1,
			Item = {
				{
					name = _U('delivery'),
					time = 0.5,
					remove = 1,
					max = 21, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 25,
					requires = 'gold',
					requires_name = _U('m_gold'),
					drop = 100
				}
			},
			Hint = _U('m_deliver_gold'),
			GPS = {x = -621.04, y = -228.53, z = 37.05}
		},

		DiamondDelivery = {
			Pos = {x = -621.04, y = -228.53, z = 37.05},
			Color = {r = 204, g = 204, b = 0},
			Size = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U('m_sell_diamond'),
			Type = 'delivery',
			Spawner = 1,
			Item = {
				{
					name = _U('delivery'),
					time = 0.5,
					remove = 1,
					max = 50, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 250,
					requires = 'uncut_diamond','uncut_rubbies',
					requires_name = _U('m_diamond'),'Ruby',
					drop = 100
				}
			},
			Hint = _U('m_deliver_diamond'),
			GPS = {x = 2962.40, y = 2746.20, z = 42.39}
		}

	}
}
