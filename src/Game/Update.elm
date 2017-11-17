module Game.Update exposing (..)

import Json.Decode as Decode

import Decoders exposing (gameDecoder)

import Game.Model exposing (Game)



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