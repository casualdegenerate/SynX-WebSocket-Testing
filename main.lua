-- // luvit (https://luvit.io)
local WebSocket = require'websocket' -- // lit install b42nk/websocket (https://github.com/IZEDx/luvit-websocket)
local WS = WebSocket.server.new():listen(11337) -- // SynX Port
-- local X = 10 -- // Debug info
WS:on('connect', function(client)
	p('Client connected.', client) -- // Debug info to understand what client(table) holds
	client:send('Welcome!') -- // Debug info
end)

WS:on('data', function(client, message) -- // Messages from SynX
	-- // This part that is all commented out is my initial idea on what I wanted to do first, and it works* It will allow me to run functions that SynX did not allow, and to create files outside of workspace* Although, I was thinking of making a discord bot with this, instead of a webhook
--	if message:find('--code') then
--		pcall(function()
--			load(message)()
--		end)
--	else
		print(message) -- // Debug info
--	end
end)

WS:on('disconnect', function(client)
	p('Client Disconnected') -- // Debug info
end)
