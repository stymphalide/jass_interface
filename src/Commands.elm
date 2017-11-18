module Commands exposing (..)

import WebSocket
import Window
import Task


import Models exposing (Route)
import Globals exposing (serverUrl)
import Msgs exposing (Msg)

import Game.Model exposing (Game)

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
    fileName round turn

fileName : Int -> Int -> String
fileName round turn =
    "../db/game_3/r" ++ (toString round) ++ "t"++ (toString turn) ++ ".json"