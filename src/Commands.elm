module Commands exposing (..)

import WebSocket
import Window
import Task
import Json.Encode exposing (..)

import Models exposing (Route)
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
            fetchGame (-1, -1)
        Models.Watch gameId ->
            fetchGame (-1, -1)
        Models.NotFoundRoute ->
            Cmd.none

fetchGame : (Int, Int) -> Cmd Msg
fetchGame (round, turn) =
    WebSocket.send serverUrl (encodeGame round turn )

encodeGame : Int -> Int -> String
encodeGame round turn =
    encode 4 (gameObject round turn "pl_2" "3")

gameObject : Int -> Int -> Player -> String -> Value
gameObject round turn player gameId =
        object 
            [ ("round", int round)
            , ("turn", int turn)
            , ("player", string player)
            , ("gameId", string gameId)
            ]

