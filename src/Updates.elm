module Updates exposing (..)

import Navigation exposing (Location)
import WebSocket
--import RemoteData

import Msgs exposing (Msg)
import Models exposing (Model, Input(..), Route(..))
import Commands exposing (fetchGame)

import Game.Update exposing (updateGame)
import Game.Model exposing (Player)

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnLocationChange route ->
            case route of
                Init ->
                    ({model | route = Init}, Cmd.none)
                Watch gameId player ->
                    ({model | route = Watch gameId player}, Cmd.none)
                Lobby player ->
                    ({model | route = Lobby player}, Cmd.none)
                Play gameId player ->
                    ({model | route = Play gameId player}, Cmd.none)
        Msgs.PlayerChange input ->
            case input of
                Msgs.Update player ->
                    case model.player of
                        Changing pl ->
                            ({model | player = Changing player}, Cmd.none)
                        Constant player ->
                            (model, Cmd.none)
                Msgs.Approve ->
                    let 
                        pl = 
                            makeConstant model.player
                    in
                        ({model | player = pl}, Cmd.none)
        Msgs.GameUpdate gameString ->
            let
                mNewGame = updateGame gameString
                newPlayer = 
                    case mNewGame of
                        Nothing ->
                            model.player
                        Just game ->
                            Models.Constant game.activePlayer
            in
                ({model | game = mNewGame, player = newPlayer}, Cmd.none)
        Msgs.FetchGame (round, turn) player gameId isWatch->
            (model, fetchGame gameId (round, turn) player isWatch)
        Msgs.GameIdUpdate gameId ->
            ({model | gameId = Just gameId}, Cmd.none)
        Msgs.SizeUpdated newSize ->
            ({model | windowSize = newSize}, Cmd.none)


makeConstant : Input Player -> Input Player
makeConstant iPlayer =
    case iPlayer of 
        Changing player ->
            Constant player
        Constant player ->
            iPlayer