module Updates exposing (..)

import Navigation exposing (Location)
import WebSocket
--import RemoteData

import Msgs exposing (Msg)
import Models exposing (Model, Input(..), Mode(..))
import Commands exposing (fetchPlay, fetchWatch, fetchLobby)

import Game.Update exposing (updateGame, updateLobby)
import Game.Model exposing (Player, GameCoord, Lobby(..))

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnLocationChange mode ->
            onLocationChange mode model
        Msgs.PlayerChange input ->
            playerChange input model
        Msgs.GameUpdate gameString ->
            let
                mNewGame = updateGame gameString
            in
                ({model | game = mNewGame}, Cmd.none)
        Msgs.FetchGame mGameCoord mPlayer ->
            fetchGame model model.mode mGameCoord mPlayer 
        Msgs.GameIdUpdate gameId ->
            ({model | gameId = Just gameId}, Cmd.none)
        Msgs.LobbyUpdate lobbyString ->
            let
                mLobby =
                    updateLobby lobbyString
                mPlayer =
                    case model.player of
                        Changing pl ->
                            Nothing
                        Constant pl ->
                            Just pl
            in
                case mLobby of
                    Nothing ->
                        (model, Cmd.none)
                    Just lobby ->
                        case lobby of
                            Players players ->
                                ({model | mode = (Lobby players)}, Cmd.none)
                            GameInfo gameId ->
                                case mPlayer of
                                    Nothing ->
                                        ({model | mode = Init}, Cmd.none)
                                    Just player ->
                                        ({model | mode = (Play gameId player), gameId = Just gameId}, Cmd.none)
        Msgs.SizeUpdated newSize ->
            ({model | windowSize = newSize}, Cmd.none)





onLocationChange : Mode -> Model -> (Model, Cmd Msg)
onLocationChange mode model =
    case mode of
        Init ->
            ({model | mode = Init}, Cmd.none)
        Watch gameId player ->
            ({model | mode = Watch gameId player}, Cmd.none)
        Lobby players ->
            ({model | mode = Lobby players}, fetchLobby players)
        Play gameId player ->
            ({model | mode = Play gameId player}, Cmd.none)


playerChange : Msgs.InputUpdate -> Model -> (Model, Cmd Msg)
playerChange input model =
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

makeConstant : Input Player -> Input Player
makeConstant iPlayer =
    case iPlayer of 
        Changing player ->
            Constant player
        Constant player ->
            iPlayer


fetchGame : Model ->  Mode -> Maybe GameCoord -> Maybe Player -> (Model, Cmd Msg)
fetchGame model mode mGameCoord mPlayer=
    case mode of
        Init ->
            (model, Cmd.none)
        Play gameId player ->
            (model, fetchPlay gameId player)
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
        Lobby players ->
            (model, fetchLobby players)