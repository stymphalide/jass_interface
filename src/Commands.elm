module Commands exposing (..)

import WebSocket
import Window
import Task

import Globals exposing (serverUrl)
import Msgs exposing (Msg)
import Models exposing (Mode, Input(..))
import Encoders exposing (..)

import Game.Model exposing (Game, Player, GameId, GameCoord)

getWindowSize : Cmd Msg
getWindowSize =
    Window.size 
    |> Task.perform Msgs.SizeUpdated

fetchPlay : GameId -> Player -> Cmd Msg
fetchPlay gameId player =
    WebSocket.send serverUrl (encodePlay gameId player)

fetchWatch : GameId -> Player -> GameCoord  -> Cmd Msg
fetchWatch gameId player gameCoord =
    WebSocket.send serverUrl (encodeWatch gameId player gameCoord)

fetchLobby : List Player -> Cmd Msg
fetchLobby players =
    case List.head players of
        Nothing ->
            Cmd.none
        Just player ->
            WebSocket.send serverUrl (encodeLobby player)

fetchGames : Input Player -> Cmd Msg
fetchGames iPlayer =
    case iPlayer of
        Changing player ->
            Cmd.none 
        Constant player ->
            WebSocket.send serverUrl (encodeInit player)
