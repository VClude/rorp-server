fx_version 'adamant'

game 'gta5'

-- this_is_a_map 'yes'

-- file 'nacelle.ytyp'

-- data_file 'DLC_ITYP_REQUEST' 'nacelle.ytyp'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
