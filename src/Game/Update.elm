module Game.Update exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)


import Game.Model exposing (Game)
import Decoders exposing (gameDecoder)



updateGame : String -> Maybe Game
updateGame gameString =
    decodeGame gameString
decodeGame : String -> Maybe Game
decodeGame gameString =
    case Decode.decodeString gameDecoder gameString of
        Ok game ->
            Just game
        Err err ->
            Nothing