module Updates exposing (..)

import Navigation exposing (Location)

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (fetchGame)
import Routing exposing (parseLocation)

import Game.Update exposing (updateGame)

import WebSocket

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
        Msgs.Send ->
            (model, fetchGame)



