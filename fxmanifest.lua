fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'
description 'HX Sportschool'

version '0.0.2'

dependencies {
	'/server:5104',
    '/onesync',
	'ox_lib',
}

shared_scripts {
	'@ox_lib/init.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

client_scripts {
  'client/*.lua'
}