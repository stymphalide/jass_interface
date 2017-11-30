'use strict'

const WebSocket = require('ws');
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

	// A little hack as long as I don't hava a db
	switch(data.player) {
		case "pl_1":
			return ['0', '1', '2', '3'];
		case "pl_2":
			return ['0', '1', '2', '3'];
		case "pl_3":
			return ['0', '1', '2', '3'];
		case "pl_4":
			return ['0', '1', '2', '3'];
		default:
			return [];
	}
}

var play = function(ws, data) {
	// Is there a gameId?
	// If not look for open lobbies
	// Or Create a new one ==> Lobby

	// If there is a gameId ==> Game
	// Send action to the gameProcess	
}

var watch = function(ws, data) {
	var gameId = data.gameId;
	// Check whether the game exists
	var gameIds = listGameIds();
	if(gameId in gameIds) {
		// Fetch the appropriate game data
		var round = data.round;
		var turn = data.turn;
		var filePath = './db/game_' + gameId + '/r' + round + 't' + turn + '.json'
		const fs = require('fs');
		fs.readFile(filePath, 'utf8', (err, gameData) => {
			if(err) {
				return console.log(err);
			} else {
				// Filter unnecessary information
				console.log("Fetching Game...");
				var gameState = JSON.parse(gameData);
				var aP = data.player;
				gameState.activePlayer = aP;
				gameState.cardsPlayer = gameState.cards[aP];
				delete gameState.cards;
				console.log("Updated Game State");
				console.log(gameState);
				// Send the updated game
				console.log("Send Game");
				var gameString = JSON.stringify(gameState);
				ws.send(gameString);
			}
		});
	} else {
		console.log("No such game found!")
	}

}

var listGameIds = function() {
	// Fetch the games
	// To be replaced by a SQL Query
	const 
		{ spawnSync } = require('child_process'),
		ls = spawnSync( 'ls', [ './db' ]);
	var data = ls.stdout.toString();
	var games = data.split("\n");
	var gameIds = [];
	for (var i = 0; i < games.length; i++) {
		if(games[i] == "") {} else {
			var g = games[i];
			var l = g.length;
			gameIds.push(g[l -1]);
		}
	}
	return gameIds;
}
