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

function initial_game() {
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
	initial_game.activePlayer = game_data.rounds[0].startingPlayer
	initial_game.onTurnPlayer = initial_game.activePlayer
	initial_game.cardsPlayer = game_data.cards[initial_game.activePlayer]
	return initial_game
}

function getGameStatus(round, turn) {
	var game = game_data;
	var game_msg = initial_game();
	rounds = game.rounds;
	for(var r = 0; r < round; r++) {
		var cards = rounds[r].cards;
		for(var t = 0; t < 4 ; t++) {
			var c_idx = game_msg.cardsPlayer.indexOf(cards[t]);
			// To set the cards of the same players always at the same position
			var p_idx = game.players.indexOf(game_msg.activePlayer);
			// Update the cards Table 
			// and the cards of the player in our internal game Model
			game_msg.cardsTable["pos" + (p_idx+1)] = game.cards[game_msg.activePlayer].splice(c_idx,c_idx)[0];

			var i_pl = game_msg.players.indexOf(game.activePlayer);
			game_msg.activePlayer = game_msg.players[(i_pl + 1) %4]
			game_msg.cardsPlayer = game_msg.activePlayer
			game_msg.turn++;
			if ( r + 1 == round && t + 1 == turn) {
				break;
			}
		}
		if(r + 1 == round) {
			return game_msg;
		}
		var g_idx = game.players.indexOf(rounds[r].winner)
		g_idx %= 2;
		moveCards(g_idx, game_msg.cardsTable);
		game_msg.activePlayer = rounds[r].winner
		game_msg.round++;
	}

	return game_msg;
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


function splitGame(round, turn) {
	for(var r = 0; r < round; r++) {
		for (var i = 0; i < turn; i++) {

			game_msg = JSON.stringify(getGameStatus(r, i));
			fs.writeFile('../game_0/r_'+r+'_t_' + i+'.json', game_msg, 'utf8', function () {})
		}
	}
}
splitGame(9,4);