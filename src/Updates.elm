module Updates exposing (..)

import Navigation exposing (Location)
import WebSocket
--import RemoteData

import Msgs exposing (Msg)
import Models exposing (Model, Input(..), Mode(..))
import Commands exposing (fetchGame, fetchWatch, fetchLobby)

import Game.Update exposing (updateGame)
import Game.Model exposing (Player)

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnLocationChange mode ->
            case mode of
                Init ->
                    ({model | mode = Init}, Cmd.none)
                Watch gameId player ->
                    ({model | mode = Watch gameId player}, Cmd.none)
                Lobby player ->
                    ({model | mode = Lobby player}, Cmd.none)
                Play gameId player ->
                    ({model | mode = Play gameId player}, Cmd.none)
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
            in
                ({model | game = mNewGame}, Cmd.none)
        Msgs.FetchGame mGameCoord mPlayer ->
            case model.mode of
                Init ->
                    (model, Cmd.none)
                Play gameId player ->
                    (model, fetchGame gameId player)
                Watch gameId player ->
                    case mGameCoord of
                        Nothing ->
                            case mPlayer of
                                Nothing ->
                                    (model, fetchWatch gameId player (0, 0))
                                Just pl ->
                                    (model, fetchWatch gameId pl (0, 0))
                        Just gameCoord ->
                            case mPlayer of
                                Nothing ->
                                    (model, fetchWatch gameId player gameCoord)
                                Just pl ->
                                    (model, fetchWatch gameId pl gameCoord)
                Lobby player ->
                    (model, fetchLobby player)
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