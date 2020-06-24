Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = false
Config.EnableBlips = true

Config.SpawnPos = vector3(-712.24,-1339.78,-0.41)
Config.SpawnHeading = 136.88

--- #### PRICES	
Config.Seashark = 89
Config.Dinghy = 99
Config.Jetmax = 129
Config.Marquis = 109
Config.Tug = 300


--- #### MARKER EDITS
Config.TypeMarker = 35
-- Config.MarkerScale = {{x = 1.000,y = 2.000,z = 1.000}}
-- Config.MarkerColor = {{r = 0,g = 255,b = 255}}
	
Config.MarkerZones = { 

    {x = -731.02, y = -1309.17, z = 5.0},

}

Config.MarkerReturnZones = { 

    {x = -712.24, y = -1339.78, z = -0.41},

}


-- Edit blip titles
Config.BlipZones = { 

    {title="Rental Perahu", colour=7, x = -731.02, y = -1309.17, z = 5.0},

}
