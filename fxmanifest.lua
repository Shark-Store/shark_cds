fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    '@vrp/lib/utils.lua',
	'config.lua'
}

client_scripts {
	"@vrp/config/Item.lua",
	"@vrp/config/Native.lua",
	"client-side/client.lua"
}

server_scripts {
	"server-side/server.lua"
}

author 'Bartolomeu#0612 & zRP.Zueira#7945'
description 'Sistema de pegar coordenadas'
version '1.0'      