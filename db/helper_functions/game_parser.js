const game_data = require("../game_0/game_full.json");

var fs = require('fs')

group_1 = {
	points : 0,
	players : [
		game_data.players[0], 
		game_data.players[2]
	],
	wonCards : []
};
group_2 = {
	points : 0,
	players : [
		game_data.players[1],
		game_data.players[3]
	],
	wonCards : []
}

function initial_game(activePlayer) {
	var initial_game = {
		type : "",
		players : [],
		round : 0,
		turn : 0,
		groups : [],
		activePlayer : "",
		onTurnPlayer : "",
		cardsPlayer : [],
		cardsTable : {
			pos1 : null, 
			pos2 : null, 
			pos3 : null, 
			pos4 : null
		}
	};
	initial_game.type = game_data.type;
	initial_game.players = game_data.players;
	initial_game.groups = [group_1, group_2];
	initial_game.activePlayer = activePlayer
	initial_game.onTurnPlayer = initial_game.activePlayer
	initial_game.cardsPlayer = game_data.cards[initial_game.activePlayer]
	return initial_game
}

function getGameStatus(activePlayer) {
	var game = game_data;
	var game_msg = initial_game(activePlayer);
	var gameMsgs = [[JSON.stringify(initial_game())]];
	var rounds = game.rounds;
	for(var r = 0; r < 9; r++) {
		var cards = rounds[r].cards;
		for(var t = 0; t < 4 ; t++) {
			var i_pl = game_msg.players.indexOf(game_msg.onTurnPlayer);
			// To set the cards of the same players always at the same position
			var c_idx = game.cards[game_msg.onTurnPlayer].indexOf(cards[t]);
			// Update the cards Table 
			// and the cards of the player in our internal game Model
			game_msg.cardsTable["pos" + (i_pl+1)] = game.cards[game_msg.onTurnPlayer].splice(c_idx,1)[0];
			game_msg.turn++;
			game_msg.cardsPlayer = game.cards[game_msg.activePlayer]
			gameMsgs[r].push(JSON.stringify(game_msg));
			game_msg.onTurnPlayer = game_msg.players[(i_pl + 1) % 4]
		}
		game_msg.round++;
		var g_idx = game.players.indexOf(rounds[r].winner)
		g_idx %= 2;
		moveCards(g_idx, game_msg.cardsTable);
		gameMsgs.push([JSON.stringify(game_msg)]);
		game_msg.onTurnPlayer = rounds[r].winner
		game_msg.turn = 0;

	}

	return gameMsgs;
}

function moveCards(group_idx, table) {
	cards = []
	for(var i = 1; i <= 4; i++) {
		cards.push(table["pos" + i]);
		table["pos" + i] = null;
	}
	if (group_idx == 0) {
		group_1.wonCards.push(cards);
	} else {
		group_2.wonCards.push(cards);
	}
}

gameMsgs = getGameStatus("pl_2");
for (var r = 0; r < 9; r++) {
	for (var t = 0; t <= 4; t++) {
		console.log(r, t)
		fs.writeFile( "../game_0/r" +r+ "t"+t+".json", gameMsgs[r][t], 'utf8', (err) => {
			if (err) throw err;
			console.log("File saved")
		})
	}
}