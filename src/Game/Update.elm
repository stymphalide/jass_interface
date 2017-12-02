module Game.Update exposing (..)

import Json.Decode as Decode

import Decoders exposing (gameDecoder, lobbyDecoder, gameIdsDecoder)

import Game.Model exposing (Game, Lobby, GameId)



updateGame : String -> Maybe Game
updateGame gameString =
    case decodeGame gameString of
        Ok game ->
            Just game
        Err err ->
            Nothing

decodeGame : String -> Result String Game
decodeGame gameString =
    Decode.decodeString gameDecoder gameString


updateLobby : String -> Maybe Lobby
updateLobby lobbyString =
    case decodeLobby lobbyString of
        Ok result ->
            Just result
        Err err ->
            Nothing


decodeLobby : String -> Result String Lobby
decodeLobby lobbyString =
    Decode.decodeString lobbyDecoder lobbyString

updateInit : String -> Maybe (List GameId)
updateInit gamesString =
    case decodeInit gamesString of
        Err err ->
            Nothing
        Ok gameIds ->
            Just gameIds

decodeInit : String -> Result String (List GameId)
decodeInit gamesString =
    Decode.decodeString gameIdsDecoder gamesString