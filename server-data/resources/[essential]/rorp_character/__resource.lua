resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    '@mysql-async/lib/MySQL.lua',     -- MySQL init
	'@es_extended/locale.lua',
	'config.lua',
    'server/main.lua',
}

-- Client Scripts
client_scripts {
	'@es_extended/locale.lua',
    'config.lua',
	'client/main.lua'
}
