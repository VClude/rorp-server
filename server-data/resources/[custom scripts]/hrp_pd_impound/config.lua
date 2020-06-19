Config 					= {}

Config.Impound 			= {
	Name = "MissionRow",
	RetrieveLocation = { X = 409.18, Y = -1622.76, Z = 29.29 },
	StoreLocation = { X = 872.64, Y = -1350.50, Z = 26.30 },
	SpawnLocations = {
		{ x = 401.85, y = -1631.46, z = 29.29, h = 315.1 },
		{ x = 401.85, y = -1631.46, z = 29.29, h = 315.1 },
		{ x = 401.85, y = -1631.46, z = 29.29, h = 315.1 },
		{ x = 401.85, y = -1631.46, z = 29.29, h = 315.1 },
		{ x = 401.85, y = -1631.46, z = 29.29, h = 315.1 },
	},
	AdminTerminalLocations = {
		{ x = 403.72, y = -1623.97, z = 29.29 }
	}
}

Config.Rules = {
	maxWeeks		= 5,
	maxDays			= 6,
	maxHours		= 24,

	minFee			= 50,
	maxFee 			= 15000,

	minReasonLength	= 10,
}

--------------------------------------------------------------------------------
----------------------- SERVERS WITHOUT ESX_MIGRATE ----------------------------
---------------- This could work, it also could not work... --------------------
--------------------------------------------------------------------------------
-- Should be true if you still have an owned_vehicles table without plate column.
Config.NoPlateColumn = false
-- Only change when NoPlateColumn is true, menu's will take longer to show but otherwise you might not have any data.
-- Try increments of 250
Config.WaitTime = 250
