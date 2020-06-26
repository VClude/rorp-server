Config                            = {}
Config.Locale           = 'id'
Config.DrawDistance     = 20
Config.Size         	= {x = 1.5, y = 1.5, z = 1.5}
Config.Color        	= {r = 0, g = 128, b = 255}
Config.Type        		= 1

Config.ZonesDistributor = {

	Distributor = {
		Items = {},
		Pos = {
			{x = -830.3,   y = -1255.77,  z = 5.58}
		}
	}
}

Config.Blips = {
    {
        Pos = {["x"] = -630.26, ["y"] = 234.47, ["z"] = 81.88},
        Sprite  = 93,
        Display = 4,
        Scale   = 1.2,
        Colour  = 32,
        Name    = _U('Blip')
    },
}

Config.Recipes = {
	-- Can be a normal ESX item
	["burger"] = { 
		{item = "bread", quantity = 1 }, 
		{item = "cashew", quantity = 4 },
	}
	
}

-- Enable crafting menu through a keyboard shortcut
Config.Keyboard = {
	useKeyboard = false
}

Config.Zones = {
	Cloakrooms = {
		Pos = {["x"] = -634.64, ["y"] = 225.57, ["z"] = 81.88},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
    },
    
    Cooking = {
		Pos = {["x"] = -629.39, ["y"] = 223.53, ["z"] = 81.88},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
    },
    
    InventoryMenu = {
		Pos = {["x"] = -634.59, ["y"] = 228.05, ["z"] = 81.88},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
    },
    
    BossMenu = {
		Pos = {["x"] = -627.59, ["y"] = 228.47, ["z"] = 82.88},
		Size = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = -1
	}
}

Config.Uniforms = {
	working = {
		male = {
			["tshirt_1"] = 15,
			["tshirt_2"] = 0,
			["torso_1"] = 43,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 0,
			["pants_1"] = 49,
			["pants_2"] = 1,
			["shoes_1"] = 20,
			["shoes_2"] = 0,
			["helmet_1"] = -1,
			["helmet_2"] = -1,
			["chain_1"] = -1,
			["chain_2"] = 0,
			["ears_1"] = 2,
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