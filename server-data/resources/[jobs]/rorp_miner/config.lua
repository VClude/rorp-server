Config              = {}
Config.Locale       = 'id'

Config.DrawDistance = 20.0
Config.BlipSprite = 318
Config.BlipScale = 0.8
Config.BlipColour = 5

Config.MaxCaution = 10000


-- Quarry Settings:
Config.Miner = {

    Vehicles = {

        Truck = {
            Spawner = 1,
            Hash = 'rubble',
            Trailer = 'none',
            HasCaution = true
        }

	},

    Zones = {

        Office = {

            Coords = vector3(892.35, -2172.77, 31.28),
            BlipName = "1. Kantor T.Batu",
            Blip = true,
            Size = {x = 3.0, y = 3.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'cloakroom',
            Hint = 'Tekan ~INPUT_CONTEXT~ mengganti baju',
            Marker = 1,
        },

        Quary = {

            Coords = vector3(2972.1259765625, 2841.3889160156, 46.025562286377),
            BlipName = "2. Pengambilan Batu",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'work',
            Hint = 'Tekan ~INPUT_CONTEXT~ mengambil batu',
            Marker = -1,
        },

        Washer = {

            Coords = vector3(1966.31, 530.83, 160.73),
            BlipName = "3. Pencucian Batu",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'wash',
            Hint = 'Tekan ~INPUT_CONTEXT~ mencuci batu',
            Marker = 1,
        },

        Foundry = {

            Coords = vector3(1088.3415527344, -2001.4940185547, 29.879274368286),
            BlipName = "4. Peleburan Batu",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'smelting',
            Hint = 'Tekan ~INPUT_CONTEXT~ melebur batu',
            Marker = 1,
        },

        CooperDelivery = {

            Coords = vector3(-169.481, -2659.16, 5.00103),
            BlipName = "5. Penjualan Tembaga",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'delivery',
            Hint = 'Tekan ~INPUT_CONTEXT~ menjual tembaga',
            Marker = 1,
            Items = {
                {
                    price = 600,
                    requires = 'copper',
                }
            },
        },

        IronDelivery = {

            Coords = vector3(-148.78, -1040.38, 26.27),
            BlipName = "6. Penjualan Besi",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'delivery',
            Hint = 'Tekan ~INPUT_CONTEXT~ menjual besi',
            Marker = 1,
            Items = {
                {
                    price = 300,
                    requires = 'iron',
                }
            },
        },

        GoldDelivery = {

            Coords = vector3(261.48, 207.35, 109.28),
            BlipName = "7. Penjualan Emas",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'delivery',
            Hint = 'Tekan ~INPUT_CONTEXT~ menjual emas',
            Marker = 1,
            Items = {
                {
                    price = 30000,
                    requires = 'gold',
                }
            },        
        },

        DiamondDelivery = {

            Coords = vector3(-621.04, -228.53, 37.05),
            BlipName = "8. Penjualan Berlian",
            Blip = true,
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Type = 'delivery',
            Hint = 'Tekan ~INPUT_CONTEXT~ menjual berlian',
            Marker = 1,
            Items = {
                {
                    price = 50000,
                    requires = 'diamond',
                }
            },
        },

        VehicleSpawner = {

            Coords = vector3(884.86, -2176.51, 29.51),
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 204, g = 204, b = 0},
            Marker = 1,
            Blip = false,
            Name = _U('spawn_veh'),
            Type = 'vehspawner',
            Spawner = 1,
            Hint = 'Tekan ~INPUT_CONTEXT~ mengambil kendaraan',
            Caution = 2000,
        },
            
        VehicleSpawnPoint = {

            Coords = vector3(879.55, -2189.79, 29.51),
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Marker = -1,
            Blip = false,
            Name = _U('service_vh'),
            Type = 'vehspawnpt',
            Spawner = 1,
            Heading = 90.1,
        },
            
        VehicleDeletePoint = {

            Coords = vector3(881.93, -2198.01, 29.51),
            Size = {x = 5.0, y = 5.0, z = 1.0},
            Color = {r = 255, g = 0, b = 0},
            Marker = 1,
            Blip = false,
            Name = _U('return_vh'),
            Type = 'vehdelete',
            Hint = 'Tekan ~INPUT_CONTEXT~ mengembalikan kendaraan',
            Spawner = 1,
            Caution = 2000,
            Teleport = 0,
        }
    }
}

-- Mining Spots:
Config.MiningSpots = 
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
}

Config.MiningMarker = 27 												-- marker type
Config.MiningMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 		-- rgba color of the marker
Config.MiningMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  			-- the scale for the marker on the x, y and z axis
Config.DrawMining3DText = "Tekan ~g~[E]~s~ untuk ~b~Menambang~s~"		-- set your desired text here

Config.KeyToStartMining = 38

-- Washer Settings:
Config.WasherLocation = {
	{ ["x"] = 1966.8696289063, ["y"] = 536.98706054688, ["z"] = 160.92445373535, ["h"] = 0 },
	{ ["x"] = 1966.31, ["y"] = 530.83, ["z"] = 160.73, ["h"] = 0 }

}

Config.WasherBlipNameOnMap = "Washer"				-- set name of the blip
Config.WasherBlipSprite = 318						-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.WasherBlipDisplay = 4						-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.WasherBlipScale = 1.0						-- set blip scale/size on your map
Config.WasherBlipColour = 5							-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/

Config.WasherMarker = 27 												-- marker type
Config.WasherMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 		-- rgba color of the marker
Config.WasherMarkerScale = { x = 2.5, y = 2.5, z = 2.5 }  			-- the scale for the marker on the x, y and z axis
Config.DrawWasher3DText = "Tekan ~g~[E]~s~ untuk ~b~Mencuci Batu~s~"				-- set your desired text here

Config.KeyToStartWashing = 38

-- Smelter Settings:
Config.SmelterLocation = {
	{ ["x"] = 1088.3415527344, ["y"] = -2001.4940185547, ["z"] = 30.879274368286, ["h"] = 0 },
}

Config.SmelterBlipNameOnMap = "Smelter"				-- set name of the blip
Config.SmelterBlipSprite = 318						-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.SmelterBlipDisplay = 4						-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.SmelterBlipScale = 1.0						-- set blip scale/size on your map
Config.SmelterBlipColour = 5						-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/

-- Smelter Spots:
Config.SmelterSpots = 
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
	
}

Config.SmelterMarker = 27 												            -- marker type
Config.SmelterMarkerColor = { r = 240, g = 52, b = 52, a = 100 } 		            -- rgba color of the marker
Config.SmelterMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  			            -- the scale for the marker on the x, y and z axis
Config.DrawSmelter3DText = "Tekan ~g~[E]~s~ untuk ~y~Melebur Batu~s~"				-- set your desired text here

Config.KeyToStartSmelting = 38

Config.GoldSpot = 
{

	{ ["x"] = 228.58, ["y"] = 213.83, ["z"] = 105.73, ["h"] = 0 }
	
}

Config.GoldMarker = 27 												-- marker type
Config.GoldColor = { r = 240, g = 52, b = 52, a = 100 } 		-- rgba color of the marker
Config.GoldScale = { x = 1.25, y = 1.25, z = 1.25 }  			-- the scale for the marker on the x, y and z axis
Config.DrawGold3DText = "Tekan ~g~[E]~s~ untuk ~y~Menjual Emas~s~"				-- set your desired text here

Config.KeyToStartSell = 38