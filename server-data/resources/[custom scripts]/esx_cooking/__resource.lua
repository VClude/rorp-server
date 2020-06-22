resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts({
    "client/client.lua",
    "config.lua"
})

ui_page('html/index.html')

files({
    "html/index.html",
    "html/index.js",
    "html/index.css",
    "html/reset.css",
    "html/images/coke.jpg",
    "html/images/burger.png",
    "html/images/stove.jpg",
    "html/images/burger.png",
    "html/images/hotdog.png",
    "html/images/shop.jpg",
    "html/images/cheese.png",
    "html/images/breadb.png",
    "html/images/meat.png",
    "html/images/breadh.png",
    "html/images/sausage.png",
    "html/images/ham.png",
    "html/images/breads.png",
    "html/images/sandwich.png"
})

server_scripts({
    "server/server.lua",
    '@mysql-async/lib/MySQL.lua',
    "config.lua"
})