'use strict'

const WebSocket = require('ws');
// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});

// Holder for the lobbies. Consists of arrays with max length 3
var lobbies = [];
// Consists of objects with four players and a game instance
var games = {};

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
	// Send action to the gameProcess
	// Verify the action
	var gameId = data.gameId;
	if(gameId) {
		var game = games[gameId].game;
		var player = data.player;
		console.log(game);
		// Adapt the game Object
		game.activePlayer = data.player;
		game.cardsPlayer = game.cards[player];
		var gameString = JSON.stringify(game);
		ws.send(gameString);
	} else {
		console.log("Invalid data sent!");
	}
}
var initialiseGame = function(players) {
	console.log("Initialise Game");
	// Split the objects up into
	// List of players
	// List of objects with ws
	// Game Process
	// Make new object, and add to games

	// Hack: Simply send a message to all players with a fake gameId
	// Hack: initialise an example game that can be sent to the players
	// Get names
	var names = [];
	for(var i = 0; i < players.length; i++) {
		names.push(Object.keys(players[i])[0]);
	}
	// The fake initial game
	var exampleGame = JSON.parse("{\"turn\":0,\"table\":{\"pos4\":null,\"pos3\":null,\"pos2\":null,\"pos1\":null},\"round\":0,\"players\":[\"pl_1\",\"pl_2\",\"pl_3\",\"pl_4\"],\"onTurnPlayer\":\"pl_2\",\"groups\":[{\"wonCards\":[],\"points\":0,\"players\":[\"pl_3\",\"pl_1\"]},{\"wonCards\":[],\"points\":0,\"players\":[\"pl_4\",\"pl_2\"]}],\"gameType\":null,\"cards\":{\"pl_4\":[{\"number\":\"7\",\"color\":\"hearts\"},{\"number\":\"9\",\"color\":\"hearts\"},{\"number\":\"queen\",\"color\":\"hearts\"},{\"number\":\"8\",\"color\":\"spades\"},{\"number\":\"9\",\"color\":\"spades\"},{\"number\":\"queen\",\"color\":\"spades\"},{\"number\":\"queen\",\"color\":\"diamonds\"},{\"number\":\"7\",\"color\":\"clubs\"},{\"number\":\"king\",\"color\":\"clubs\"}],\"pl_3\":[{\"number\":\"6\",\"color\":\"hearts\"},{\"number\":\"king\",\"color\":\"hearts\"},{\"number\":\"6\",\"color\":\"spades\"},{\"number\":\"7\",\"color\":\"spades\"},{\"number\":\"ace\",\"color\":\"spades\"},{\"number\":\"king\",\"color\":\"diamonds\"},{\"number\":\"10\",\"color\":\"clubs\"},{\"number\":\"jack\",\"color\":\"clubs\"},{\"number\":\"queen\",\"color\":\"clubs\"}],\"pl_2\":[{\"number\":\"8\",\"color\":\"hearts\"},{\"number\":\"jack\",\"color\":\"hearts\"},{\"number\":\"10\",\"color\":\"spades\"},{\"number\":\"6\",\"color\":\"diamonds\"},{\"number\":\"8\",\"color\":\"diamonds\"},{\"number\":\"ace\",\"color\":\"diamonds\"},{\"number\":\"8\",\"color\":\"clubs\"},{\"number\":\"9\",\"color\":\"clubs\"},{\"number\":\"ace\",\"color\":\"clubs\"}],\"pl_1\":[{\"number\":\"10\",\"color\":\"hearts\"},{\"number\":\"ace\",\"color\":\"hearts\"},{\"number\":\"jack\",\"color\":\"spades\"},{\"number\":\"king\",\"color\":\"spades\"},{\"number\":\"7\",\"color\":\"diamonds\"},{\"number\":\"9\",\"color\":\"diamonds\"},{\"number\":\"10\",\"color\":\"diamonds\"},{\"number\":\"jack\",\"color\":\"diamonds\"},{\"number\":\"6\",\"color\":\"clubs\"}]}}");
	// adapt it to our purposes.
	var examplePlayers = exampleGame.players;
	exampleGame.players = names;
	var idxOnTurnPlayer = examplePlayers.indexOf(exampleGame.onTurnPlayer);
	exampleGame.onTurnPlayer = names[idxOnTurnPlayer];
	for(var i = 0; i < names.length; i++) {
		var n = names[i];
		var exN = examplePlayers[i];
		exampleGame.cards[n] = exampleGame.cards[exN];
		delete exampleGame.cards[exN];
	}
	exampleGame.groups[0].players = [names[2], names[0]];
	exampleGame.groups[1].players = [names[3], names[1]];
	// Example GameId
	var gameId = "42";
	// send fake gameId to websockets.
	var pls = {};
	for (var i = 0; i < players.length; i++) {
		var gameInfo = {gameId: gameId};
		var stringGameInfo = JSON.stringify(gameInfo);
		var ws = players[i][names[i]];
		// Add it to pls
		pls[names[i]] = {name : names[i], ws : ws};
		console.log(names[i]);
		ws.send(stringGameInfo);
	}
	games[gameId] = {gameId : gameId, players : pls, game : exampleGame};
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
