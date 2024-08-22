fx_version "cerulean"
game "gta5"

author "Mrlion"
description "Script for EMS, adds medibag for them"
version "2.0"
lua54 "true"

shared_scripts {
    '@ox_lib/init.lua',
    "config.lua"
}

client_scripts {
    "client/client.lua",
}

server_scripts {
    "server/server.lua"
}

files {
    "locales/*.json"
}
