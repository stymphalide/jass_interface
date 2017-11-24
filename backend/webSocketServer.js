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
		console.log(data.player, data.gameId)
		console.log("I will fetch the game.")
		var gamePath = path.resolve(__dirname + "/../db/")+  "/game_" + data.gameId +"/r" + data.round + "t"+data.turn + ".json"
		console.log("@" + gamePath)
		const game = require(gamePath)
		var gameState = game
		console.log("I will update the game")
		gameState.activePlayer = data.player
		gameState.cardsPlayer = gameState.cards[data.player]
		console.log(gameState)
		//console.log(gameState)
		console.log("I will send the game")
		ws.send(JSON.stringify(gameState));
	});
});

