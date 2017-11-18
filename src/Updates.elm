module Updates exposing (..)

import Navigation exposing (Location)
import WebSocket
--import RemoteData

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (fetchGame)
import Routing exposing (parseLocation)

import Game.Update exposing (updateGame)


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ({model | route = newRoute}, Cmd.none)
        Msgs.GameUpdate gameString ->
            let
                newGame = updateGame gameString
            in
                ({model | game = newGame}, Cmd.none)
        Msgs.FetchGame (round, turn) ->
            (model, fetchGame model.gameId (round, turn))
        Msgs.SizeUpdated newSize ->
            ({model | windowSize = newSize}, Cmd.none)