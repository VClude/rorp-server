Config = {}

Config.Locale = 'en'

--Options

Config.EnableMapsBlimps = true -- Enables the blips on the map.
Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.
Config.RequireCopsOnline = false --Will require that cops are online to pickup or process.
Config.EnableCopCheckMessage = true --Will enable a message in the console when the server refreshes the current cop count.

--The time the server will wait until checking the current cop count again (in Minutes).
Config.CopsCheckRefreshTime = 30

--The time it takes to process one item
Config.Delays = {
	HeroinProcessing = 2000 * 10,
}

--Drug Dealer item Prices
Config.DrugDealerItems = {
	heroin = 546,
}

--The amount of cops that need to be online to harvest/process these drugs.
--Only needed when RequireCopsOnline is set to true
Config.Cops = {
	Heroin = 4,
	DrugDealer = 4,
}

--Drug Zones
Config.CircleZones = {
	--Heroin
	HeroinField = {coords = vector3(299.44, 4323.16, 47.69), blimpcoords = vector3(299.44, 4323.16, 47.69), name = _U('blip_heroinfield'), color = 7, sprite = 497, radius = 0, enabled = true, illegal = true},
	
	--DrugDealer
	DrugDealer = {coords = vector3(1724.75, 4737.8, 41.12), blimpcoords = vector3(1724.75, 4737.8, 41.12), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 0.0, enabled = true, illegal = true},
	
}