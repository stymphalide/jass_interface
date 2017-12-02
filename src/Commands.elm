module Commands exposing (..)

import WebSocket
import Window
import Task

import Globals exposing (serverUrl)
import Msgs exposing (Msg)
import Encoders exposing (..)

import Game.Model exposing (Game, Player, GameId, GameCoord)

getWindowSize : Cmd Msg
getWindowSize =
    Window.size 
    |> Task.perform Msgs.SizeUpdated

fetchGame : GameId -> Player -> Cmd Msg
fetchGame gameId player =
    WebSocket.send serverUrl (encodeGame gameId player)

fetchWatch : GameId -> Player -> GameCoord  -> Cmd Msg
fetchWatch gameId player gameCoord =
    WebSocket.send serverUrl (encodeWatch gameId player gameCoord)

fetchLobby : Player -> Cmd Msg
fetchLobby player =
    WebSocket.send serverUrl (encodeLobby player)