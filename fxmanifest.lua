fx_version 'adamant'
games { 'gta5' };

name 'CADvanced MDT';
description 'CADvanced MDT, a FiveM resource that provides integration between CADvanced (https://cadvanced.app) and FiveM in the form of an in-game MDT.'
version '1.0.0'

ui_page 'ui/build/index.html'

files {
    'ui/build/index.html',
    'ui/build/bundle.js'
}

client_scripts {
    'client/client-main.lua'
}

server_scripts {
    'server/lib/util.lua',
    'server/main.lua',
    'config.lua',
    'version.lua',
    'server/main.lua',
    'modules/api.lua',
    'modules/config.lua',
}
