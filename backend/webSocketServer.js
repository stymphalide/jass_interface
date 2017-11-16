const WebSocket = require('ws');

// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});

console.log("Socket serving at ws://localhost:5000" )

wss.on('connection', function connection(ws) {
	console.log("Connection established")
	ws.on('message', function incoming(data) {
		data = JSON.parse(data);
		if (data.type == "game") {
			gameState = require('../db/game_0/r_' + data.r + '_t_'+data.t + '.json');
			ws.send(JSON.stringify(gameState));
		}
	});
});

