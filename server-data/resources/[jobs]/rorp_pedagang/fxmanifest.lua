fx_version 'adamant'

game 'gta5'

description 'RORP Pedagang'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'id.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'id.lua',
	'config.lua',
	'client/main.lua'
}
