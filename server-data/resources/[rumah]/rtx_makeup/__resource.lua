-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/arrow-left.png",
	"ui/assets/arrow-right.png",
	"ui/assets/radio-check.png",
	"ui/assets/radio-check-black.png",
	"ui/assets/head.png",
	"ui/assets/identity.png",
	"ui/assets/pilosite.png",
	"ui/assets/Propertymakeups.png",
	"ui/assets/cursor.png",
	"ui/fonts/Circular-Bold.ttf",
	"ui/fonts/Circular-Book.ttf",
	"ui/front.js",
	"ui/script.js",
	"ui/style.css",
	'ui/debounce.min.js',
	-- JS LOCALES
	'ui/locales/nl.js',
	'ui/locales/en.js',
	"ui/tabs.css"
}

-- Server Scripts
server_scripts {
    '@mysql-async/lib/MySQL.lua',     -- MySQL init
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
    'server/main.lua',
}

-- Client Scripts
client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger'
}
