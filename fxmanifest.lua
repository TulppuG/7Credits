fx_version 'cerulean'
game 'gta5'

author 'tulppu.'
lua54 'yes'

exports {
    'GetPlayerCredits',
    'GivePlayerCredits',
    'RemovePlayerCredits',
    'SetPlayerCredits',
}

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', 
    'server/main.lua',
    'server/functions.lua'
} 

client_script 'client/main.lua'

ui_page 'html/index.html'

files {'html/index.html', 'html/listener.js', 'html/style.css', 'html/img/*.png'}