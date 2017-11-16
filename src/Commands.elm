module Commands exposing (..)

import WebSocket

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)

import Msgs exposing (Msg)
import Models exposing (Route)
import Routing exposing (serverUrl)
import Decoders exposing (gameDecoder)

import Game.Model exposing (Game)



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
        |> Cmd.map Msgs.GameUpdate