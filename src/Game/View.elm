module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- General
import Globals exposing (error)
import Msgs exposing (Msg)

-- Game specific
import Game.Model exposing(Game, Player, GameId)

import Game.Play.Game as Play
import Game.Watch.Game as Watch

viewPlay :  Player -> Maybe Game -> GameId-> Html Msg
viewPlay player mGame gameId =
    case mGame of
        Nothing ->
            Play.init player gameId
        Just game ->
            Play.viewGame game gameId


viewWatch : Player -> Maybe Game -> GameId -> Html Msg
viewWatch player mGame gameId =
    case mGame of
        Nothing ->
            Watch.init player gameId
        Just game ->
            Watch.viewGame game gameId

viewLobby : Player -> Html Msg
viewLobby player  =
    div [] [text player]


