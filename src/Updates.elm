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
                newPlayer = 
                    case newGame of
                        Nothing ->
                            model.player
                        Just g ->
                            g.activePlayer
            in
                ({model | game = newGame, player = newPlayer}, Cmd.none)
        Msgs.FetchGame (round, turn) player->
            case model.gameId of
                Nothing ->
                    (model, Cmd.none)
                Just gameId ->
                    (model, fetchGame gameId (round, turn) player)
        Msgs.GameIdUpdate gameId ->
            ({model | gameId = Just gameId}, Cmd.none)
        Msgs.SizeUpdated newSize ->
            ({model | windowSize = newSize}, Cmd.none)