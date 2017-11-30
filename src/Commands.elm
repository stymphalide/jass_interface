module Commands exposing (..)

import WebSocket
import Window
import Task
import Json.Encode exposing (..)

import Globals exposing (serverUrl)
import Msgs exposing (Msg)

import Game.Model exposing (Game, Player, GameId, GameCoord)

getWindowSize : Cmd Msg
getWindowSize =
    Window.size 
    |> Task.perform Msgs.SizeUpdated

fetchGame : GameId -> GameCoord -> Player -> Bool -> Cmd Msg
fetchGame gameId gameCoord player isWatch =
    WebSocket.send serverUrl (encodeGame gameCoord gameId player isWatch)


-- Encoder for the query json
encodeGame : GameCoord -> GameId -> Player -> Bool -> String
encodeGame gameCoord gameId player isWatch =
    if isWatch then
        encode 4 (gameObject gameCoord gameId player "watch")
    else
        encode 4 (gameObject gameCoord gameId player "play")

gameObject : GameCoord ->  GameId -> Player -> String -> Value
gameObject (round, turn) gameId player mode =
        object 
            [ ("round", int round)
            , ("turn", int turn)
            , ("gameId", string gameId)
            , ("player", string player)
            , ("mode", string mode)
            ]