fx_version 'adamant'

game 'gta5'

description 'Mythic Framework Hospital & Damage System'

version '1.2.0'

client_scripts {
	'config.lua',
	'client/wound.lua',
	'client/main.lua',
	'client/items.lua',
}

server_scripts {
	'server/wound.lua',
	'server/main.lua',
}

dependencies {
	'mythic_progbar',
	'mythic_notify',
}

exports {
    'IsInjuredOrBleeding',
	'DoLimbAlert',
	'DoBleedAlert',
}

server_exports {
    'GetCharsInjuries',
}