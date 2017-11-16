module Updates exposing (..)

import Navigation exposing (Location)

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (routeCommand)
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
                ({model | route = newRoute}, routeCommand newRoute)
        Msgs.GameUpdate gameString ->
            let
                newGame = updateGame gameString
            in
                ({model | game = newGame}, Cmd.none)



