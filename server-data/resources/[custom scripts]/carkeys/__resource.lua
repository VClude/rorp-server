description "Carkeys resource created by james."

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
	"client/functions.lua",
	"client/keys.lua",
	"client/main.lua"
}

server_scripts {
	"@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
	"server/main.lua",
	"server/keys.lua",
	"server/database.lua"
}

shared_scripts {
	"config.lua"
}

exports {
	"AddTemporaryKey"
}