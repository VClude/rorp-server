fx_version 'adamant'

game 'gta5'

description 'Daftar Warga'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/id.lua',
    'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/id.lua',
    'client/main.lua',
    'client/utils.lua'

}
ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/logo.png',
	'html/id_card.png',
	'html/styles.css',
	'html/questions.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

dependency 'es_extended'