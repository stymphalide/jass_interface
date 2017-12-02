'use strict'

const WebSocket = require('ws');
// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});


// Holder for the lobbies. Consists of arrays with max length 3
var lobbies = [];
// Consists of objects with four players and a game instance
var games = [];

console.log("Socket serving at ws://localhost:5000" );

wss.on('connection', function connection(ws) {
	console.log("Connection established")
	ws.on('close', function close() {
		console.log('Disconnected');
	});
	ws.on('message', function incoming(data) {
		console.log("I got a message.")
		data = JSON.parse(data)
		console.log(data)
		if(data.mode != undefined) {
			switch(data.mode) {
				case "init":
					init(ws, data);
					break;
				case "lobby":
					lobby(ws, data);
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
			console.log("Invalid data sent!");
		}
	});
});

var init = function(ws, data) {
	// Have a look at the db
	// Send all games corresponding to data.player

	// A little hack as long as I don't hava a db
	var games = undefined;
	switch(data.player) {
		case "pl_1":
			games = ['0', '1', '2', '3'];
			break;
		case "pl_2":
			games = ['0', '1', '2', '3'];
			break;
		case "pl_3":
			games = ['0', '1', '2', '3'];
			break;
		case "pl_4":
			games = ['0', '1', '2', '3'];
			break;
		default:
	}
	var gamesString = JSON.stringify(games);
	ws.send(gamesString);
}

var play = function(ws, data) {
	// Is there a gameId?
	// If not look for open lobbies
	// Or Create a new one ==> Lobby
	// If there is a gameId ==> Game
	// Send action to the gameProcess

}
var initialiseGame = function(players) {
	console.log("Initialise Game");
	// Split the objects up into
	// List of players
	// List of objects with ws
	// Game Process
	// Make new object, and add to games

	// Hack: Simply send a message to all players with a fake gameId
	// Get names
	var names = [];
	for(var i = 0; i < players.length; i++) {
		names.push(Object.keys(players[i])[0]);
	}
	// Actually send them to ws.
	for (var i = 0; i < players.length; i++) {
		var gameId = "42";
		var gameInfo = {gameId: gameId};
		var stringGameInfo = JSON.stringify(gameInfo);
		var ws = players[i][names[i]];
		console.log(names[i]);
		ws.send(stringGameInfo);
	}
}


var lobby = function(ws, data) {
	// Is there a lobby active?
	var info = {};
	info[data.player] = ws;
	console.log("Looking for lobbies.");
	if(lobbies.length > 0) {
		console.log("Lobby found.");
		// Yes => add player to lobby and initialise game if ready and close lobby
		var l = lobbies[lobbies.length - 1]; // Get the last lobby
		if(l.length == 3) {
			console.log("Lobby is full now.");
			// Initialise Game
			l.push(info);
			var g = lobbies.pop();
			initialiseGame(g);
		} else {
			console.log("Player added to lobby");
			l.push(info);
			console.log("Send updated lobby to players");
			// Get names
			var names = [];
			for(var i = 0; i < l.length; i++) {
				names.push(Object.keys(l[i])[0]);
			}
			// Actually send them to ws.
			for (var i = 0; i < l.length; i++) {
				var stringNames = JSON.stringify(names);
				var ws = l[i][names[i]];
				ws.send(stringNames);
			}
		}
	} else {
		// No => Initialise one
		console.log("New Lobby created")
		lobbies.push([info]);
	}
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
