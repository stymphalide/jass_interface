module Commands exposing (..)
{-
    @moduledoc
    Provides commands to do whatever is not pure in a functional sense.
-}


import WebSocket
import Window
-- To communicate with the outside of elm
import Task

import Globals exposing (serverUrl)
import Msgs exposing (Msg)
import Models exposing (Mode, Input(..))
import Encoders exposing (..)

import Game.Model exposing (Game, Player, GameId, GameCoord, Action(..))

-- Get window size from the browser
getWindowSize : Cmd Msg
getWindowSize =
    Window.size 
    |> Task.perform Msgs.SizeUpdated

-- Send data about the game state to the server
fetchPlay : GameId -> Player -> Action -> Cmd Msg
fetchPlay gameId player action =
    WebSocket.send serverUrl (encodePlay gameId player action)

-- Send data of the next game State to the server
fetchWatch : GameId -> Player -> GameCoord  -> Cmd Msg
fetchWatch gameId player gameCoord =
    WebSocket.send serverUrl (encodeWatch gameId player gameCoord)

-- Send data of the lobby to the server.
fetchLobby : List Player -> Cmd Msg
fetchLobby players =
    case List.head players of
        Nothing ->
            Cmd.none
        Just player ->
            WebSocket.send serverUrl (encodeLobby player)

-- Send who is logged in to the server
fetchGames : Input Player -> Cmd Msg
fetchGames iPlayer =
    case iPlayer of
        Changing player ->
            Cmd.none 
        Constant player ->
            WebSocket.send serverUrl (encodeInit player)
