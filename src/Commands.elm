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
            fetchGame
        Models.Watch gameId ->
            fetchGame
        Models.NotFoundRoute ->
            Cmd.none

fetchGame : Cmd Msg
fetchGame =
    WebSocket.send serverUrl "fetchGame"