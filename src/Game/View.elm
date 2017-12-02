module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- General
import Globals exposing (error)
import Msgs exposing (Msg)

-- Game specific
import Game.Model exposing(Game, Player)

import Game.Play.Game as Play
import Game.Watch.Game as Watch

viewPlay : Maybe Game -> Html Msg
viewPlay mGame =
    case mGame of
        Nothing ->
            Play.init
        Just game ->
            Play.viewGame game

viewWatch : Maybe Game -> Html Msg
viewWatch mGame  =
    case mGame of
        Nothing ->
            Watch.init
        Just game ->
            Watch.viewGame game

viewLobby : Player -> Html Msg
viewLobby player  =
    div [] [text player]


