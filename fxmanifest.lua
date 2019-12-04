fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {"rdr3"}

server_script "server.lua"

client_script "client.lua"
client_script "model.lua"
client_script "cl_runcode.lua"
-- client_script "td.lua"
client_script "loadipl.lua"
client_script "respawn.lua"
-- client_script "ragdoll.lua"