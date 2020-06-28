resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Illegal'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua',
	'server/heroin.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua',
	'client/heroin.lua',
}

dependencies {
	'es_extended'
}
