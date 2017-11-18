const WebSocket = require('ws');

// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});

console.log("Socket serving at ws://localhost:5000" )

wss.on('connection', function connection(ws) {
	console.log("Connection established")
	ws.on('message', function incoming(data) {
		console.log("I got a message.")
		if(data == "fetchGame") {
			console.log("I will fetch the game.")
			gameState = require('../db/game_0/r1t0.json');
			console.log(gameState)
			ws.send(JSON.stringify(gameState));
		}
	});
});

