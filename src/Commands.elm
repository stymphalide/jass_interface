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
        Models.Play gameId ->
            fetchGame gameId (-1, -1)
        Models.Watch gameId ->
            fetchGame gameId (-1, -1)
        Models.NotFoundRoute ->
            Cmd.none

fetchGame : GameId -> (Int, Int) -> Cmd Msg
fetchGame gameId (round, turn) =
    WebSocket.send serverUrl (encodeGame round turn gameId)

encodeGame : Int -> Int -> Player -> GameId
encodeGame round turn gameId =
    encode 4 (gameObject round turn gameId "pl_2" )

gameObject : Int -> Int ->  GameId -> Player -> Value
gameObject round turn gameId player  =
        object 
            [ ("round", int round)
            , ("turn", int turn)
            , ("gameId", string gameId)
            , ("player", string player)
            ]

