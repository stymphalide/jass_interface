const WebSocket = require('ws');

// Create Server
const wss = new WebSocket.Server({host:"localhost", port: 5000});

console.log("Socket serving at ws://localhost:5000" )

wss.on('connection', function connection(ws) {

	ws.on('message', function incoming(message) {
		console.log('received: %s', message)
		ws.send("I received your message %s", message)
	});

	ws.send('something')


});
