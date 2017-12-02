module Game.Update exposing (..)

import Json.Decode as Decode

import Decoders exposing (gameDecoder, lobbyDecoder)

import Game.Model exposing (Game, Lobby)



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