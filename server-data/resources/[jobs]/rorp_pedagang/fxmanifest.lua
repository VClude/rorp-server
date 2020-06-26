fx_version 'adamant'

game 'gta5'

description 'RORP Pedagang'

version '1.0.0'

ui_page {
	
	'html/index.html'

}

files {
	'html/index.html',
	'html/index.css',
	'html/fonts/SignPainter.ttf',
	'html/item-quantity-dropdown.min.js',

	'html/ui.html',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
	'html/iransans.otf',
	-- default
	'html/img/default.png',
	'html/img/bread.png',
	'html/img/close.png',
	'html/img/croquettes.png',
	'html/img/water.png',
	'html/img/plus.png',
	'html/img/minus.png',
  
  }

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

dependency 'es_extended'
