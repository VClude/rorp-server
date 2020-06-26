fx_version 'adamant'

game 'gta5'

description 'ESX Optional Needs'

version '1.0.0'

ui_page 'index.html'

files {
	'index.html'
  }

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/drunk.lua'
}

export 'DoAcid'