fx_version 'adamant'

game 'gta5'

client_scripts {
    'config.lua',
    'client/cupboard.lua',
    'client/kitchen.lua',
    'client/shower.lua',
    'client/garage.lua',
    'client/clothes.lua',
    'client/main.lua',
    'client/property.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'config.lua',
    'server/main.lua',
    'server/property.lua',
    'server/garage.lua',
    'server/clothes.lua',
    'server/inventory.lua',
}

dependencies {
	'es_extended',
	'instance',
	'cron',
	'esx_addonaccount',
	'esx_addoninventory',
	'es_extended',
	'skinchanger',
	'esx_datastore'
}