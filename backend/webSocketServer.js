const WebSocket = require('ws');
const path = require('path')
// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});

console.log("Socket serving at ws://localhost:5000" )

wss.on('connection', function connection(ws) {
	console.log("Connection established")
	ws.on('message', function incoming(data) {
		console.log("I got a message.")
		data = JSON.parse(data)
		console.log(data)
		if(data.mode != undefined) {
			switch(data.mode) {
				case "init":
					init(ws, data);
					break;
				case "play":
					play(ws, data);
					break;
				case "watch":
					watch(ws, data);
					break;
				default:
					console.log("Invalid mode sent!");
			}
		} else {
			console.log("Invalid data sent!")
		}
	});
});

var init = function(ws, data) {
	// Have a look at the db

	// Send all games corresponding to data.player
}


var play = function(ws, data) {
	// Is there a gameId?
	// If not look for open lobbies
	// Or Create a new one ==> Lobby

	// If there is a gameId ==> Game
	// Send action to the gameProcess	
}

var watch = function(ws, data) {
	gameId = data.gameId;
	// Check whether the game exists
	
	// Fetch the appropriate game data

	// Filter unnecessary information

	// Send the updated game
}

var listGames = function() {
	const util = require('util');
	sys.
}
