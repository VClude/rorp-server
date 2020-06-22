Config = {}
Config.Locale = 'en'
Config.DebugLog = false

-- Fuel options: These just set the initial fuel to 100%, if you're using the associated fuel script. Be sure to set any others to false.
-- Note:  If using newer versions of LegacyFuel, make sure LegacyFuelFolderName matches the name of the LegacyFuel resource folder, in case you renamed it.
Config.UseLegacyFuel = true
Config.LegacyFuelFolderName = 'LegacyFuel'
Config.UseFrFuel = false

Config.PutPlayerInBusOnSpawn = true
Config.OnlyShowPedsOnClient = true

Config.EnterVehicleTimeout = 10000
Config.DelayBetweenChanges = 1000
Config.DeleteDistance = 100.0
Config.Markers = {
    Size = 10.0,
    StartColor = {r = 20, g = 200, b = 20, a = 100},
    AbortColor = {r = 200, g = 20, b = 20, a = 100},
}

Config.ShowOverlay = true

Config.Routes = {
    AirportRoute,
    ScenicRoute,
    MetroRoute
}
