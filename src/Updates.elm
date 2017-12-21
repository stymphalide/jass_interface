module Updates exposing (..)
{-
    @moduledoc
    Updates the model based on Messages
-}

import Msgs exposing (Msg)
import Models exposing (Model, Input(..), Mode(..), initialModel)
import Commands exposing (..)

import Game.Update exposing (updateGame, updateLobby, updateInit)
import Game.Model exposing (Player, GameCoord, Lobby(..), Action(..), Language(..))

-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnLocationChange mode ->
            onLocationChange mode model
        Msgs.LogOut ->
            ({initialModel | windowSize = model.windowSize}, Cmd.none)
        Msgs.PlayerChange input ->
            playerChange input model
        Msgs.GameUpdate gameString ->
            let
                mNewGame = 
                    case updateGame gameString of
                        Nothing ->
                            Nothing
                        Just game ->
                            Just {game | language = model.language}

            in
                ({model | game = mNewGame}, Cmd.none)
        Msgs.FetchGame mGameCoord mPlayer action ->
            fetchGame model model.mode mGameCoord mPlayer action 
        Msgs.GameIdUpdate gameId ->
            ({model | gameId = Just gameId}, Cmd.none)
        Msgs.LobbyUpdate lobbyString ->
            lobbyUpdate model lobbyString
        Msgs.InitUpdate gamesString ->
            let
                mGames =
                    updateInit gamesString
            in
                ({model | games = mGames }, Cmd.none)
        Msgs.SizeUpdated newSize ->
            ({model | windowSize = newSize}, Cmd.none)
        Msgs.OnKeyUp key ->
            mapKeyToUpdate key model
        Msgs.LanguageChange langString ->
            case langString of
                "french" ->
                    ({model | language = French}, Cmd.none)
                "german" ->
                    ({model | language = German}, Cmd.none)
                _ ->
                    (model, Cmd.none)

-- Changes the mode of the Model
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

-- As long as the player name isn't validated the incoming string is added to the name
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
                ({model | player = pl}, fetchGames pl) 
-- Helper for playerChange, makes the name constant
makeConstant : Input Player -> Input Player
makeConstant iPlayer =
    case iPlayer of 
        Changing player ->
            Constant player
        Constant player ->
            iPlayer

-- Makes a command to send data to the wss
fetchGame : Model ->  Mode -> Maybe GameCoord -> Maybe Player -> Action -> (Model, Cmd Msg)
fetchGame model mode mGameCoord mPlayer action=
    case mode of
        Init ->
            (model, Cmd.none)
        Play gameId player ->
            (model, fetchPlay gameId player action)
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

-- Whenever new players are added, the lobby is updated
lobbyUpdate : Model -> String -> (Model, Cmd Msg)
lobbyUpdate model lobbyString =
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


mapKeyToUpdate : Int -> Model -> (Model, Cmd Msg)
mapKeyToUpdate key model =
    case model.mode of
        Init ->
            case model.player of
                Changing player ->
                    if key == 13 then
                        playerChange Msgs.Approve model
                    else
                        (model, Cmd.none)
                Constant player->
                    (model, Cmd.none)
        _ ->
            (model, Cmd.none)
