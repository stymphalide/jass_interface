var path = require('path')
var fs = require('fs')

function initial_game(game_data) {
	var initial_game = {
		type : "",
		players : [],
		round : 0,
		turn : 0,
		groups : [],
		activePlayer : "",
		onTurnPlayer : "",
		cards : {},
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
	initial_game.cards = game_data.cards
	initial_game.onTurnPlayer = game_data.rounds[0].startingPlayer;
	return initial_game
}


getGameStatus =  function(gameId) {
	const game_data = require(path.resolve(__dirname + "/../game_"+ gameId +"/game_full.json"));
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


	var game = game_data;

	var game_msg = initial_game( game_data);
	var gameMsgs = [[JSON.stringify(game_msg)]];
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

			gameMsgs[r].push(JSON.stringify(game_msg));
			game_msg.onTurnPlayer = game_msg.players[(i_pl + 1) % 4]
		}
		game_msg.round++;
		var g_idx = game.players.indexOf(rounds[r].winner)
		g_idx %= 2;
		moveCards(g_idx, game_msg.cardsTable);
		game_msg.onTurnPlayer = rounds[r].winner
		game_msg.turn = 0;
		gameMsgs.push([JSON.stringify(game_msg)]);

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

gameId = 3
gameMsgs = getGameStatus(gameId)
for (var r = 0; r < 9; r++) {
	for(var t = 0; t <= 4; t++) {
		fs.writeFile( path.resolve( __dirname + "/../")+ "/game_" + gameId + "/r"+r+"t"+t+".json", gameMsgs[r][t],"utf8", (err) => {})
	}
}


