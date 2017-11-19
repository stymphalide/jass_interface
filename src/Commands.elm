module Commands exposing (..)

import WebSocket
import Window
import Task
import Json.Encode exposing (..)

import Models exposing (Route, GameId)
import Globals exposing (serverUrl)
import Msgs exposing (Msg)

import Game.Model exposing (Game, Player)

getWindowSize : Cmd Msg
getWindowSize =
    Window.size 
    |> Task.perform Msgs.SizeUpdated

routeCommand : Route -> Cmd Msg
routeCommand route =
    case route of
        Models.Init ->
            Cmd.none
        Models.Play gameId player->
            fetchGame gameId (-1, -1) player
        Models.Watch gameId player->
            fetchGame gameId (-1, -1) player
        Models.NotFoundRoute ->
            Cmd.none

fetchGame : GameId -> (Int, Int) -> Player -> Cmd Msg
fetchGame gameId (round, turn) player =
    WebSocket.send serverUrl (encodeGame round turn gameId player)

encodeGame : Int -> Int -> GameId -> Player -> String
encodeGame round turn gameId player =
    encode 4 (gameObject round turn gameId player)

gameObject : Int -> Int ->  GameId -> Player -> Value
gameObject round turn gameId player  =
        object 
            [ ("round", int round)
            , ("turn", int turn)
            , ("gameId", string gameId)
            , ("player", string player)
            ]

