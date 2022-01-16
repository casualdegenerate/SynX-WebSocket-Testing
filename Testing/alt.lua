-- // SynX (x.synapse.to)
local WS = {}
-- // This is used twice and it's a function to prevent copy paste
local function Connect()
	-- // This is used to yield it until the webhook is connected
	ISOPEN = pcall(function()
		-- // This is my port I use on my computer to connect SynX
		WS[1] = syn.websocket.connect'ws://localhost:11337'
	end)
	-- // This is to keep it connected
	WS[1].OnClose:Connect(function()
--		print('close') -- // Debug info
		ISOPEN = false -- // This is to tell it to stop when it's closed to prevent the :Send to prevent dropping messages
	end)
	-- // This is to reconnect the .OnMessage when the old connection was disconnected
	WS[1].OnMessage:Connect(function(msg)
		-- // The other side can push scripts into SynX
		if msg:find('--code') then
			loadstring(msg)()
		end
--		print(msg) -- // Debug info
	end)
end

-- // This is to reconnect it. 
coroutine.wrap(function()
	-- // Initial run of the connection
	Connect()
	-- // This will ensure that the connection is held until you teleport or close the game
	while true do
		-- // Checks if it was closed
		if not ISOPEN then
			-- // With the power of flex tape, we can fix this spaget code
			Connect()
		end
		wait(1)
	end
end)()


-- // This is to see if it works, but I will break this down
for i = 1, 300 do
	-- // repeat wait() is to check when it's connected so that you can send a message without any messages being dropped, planning of making :Send so it's a function that will yield until the WebSocket is connected
	repeat wait(.3) print('waiting for connection ' .. tostring(WS[1])) until ISOPEN
	-- // This is a message being sent, please refer to https://x.synapse.to/docs/reference/websocket_lib.html#send to understand how this works
	WS[1]:Send("In computing, human-readable data is often encoded as ASCII or Unicode text, rather than as binary data. In most contexts, the alternative to a human-readable representation is a machine-readable format or medium of data primarily designed for reading by electronic, mechanical or optical devices, or computers. For example, Universal Product Code (UPC) barcodes are very difficult to read for humans, but very effective and reliable with the proper equipment, whereas the strings of numerals that commonly accompany the label are the human-readable form of the barcode information. Since any type of data encoding can be parsed by a suitably programmed computer, the decision to use binary encoding rather than text encoding is usually made to conserve storage space. Encoding data in a binary format typically requires fewer bytes of storage and increases efficiency of access (input and output) by eliminating format parsing or conversion." .. i)
	wait(1)
end