module Commands exposing (..)

import WebSocket

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)

import Msgs exposing (Msg)
import Models exposing (Model)

import Game.Model exposing (Game)





gameDecoder : Decode.Decoder Game
gameDecoder =
    decode Game
    |> required -- tbc