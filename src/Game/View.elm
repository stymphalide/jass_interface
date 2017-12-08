module Game.View exposing (..)

-- elm Libraries
import List
import Html exposing (..)
import Html.Events exposing (onClick)
import Window exposing(Size)


-- General
import Globals exposing (error)
import Msgs exposing (Msg)

-- Game specific
import Game.Model exposing(Game, Player)

import Game.Play.Game as Play
import Game.Watch.Game as Watch

viewPlay : Size -> Maybe Game -> Html Msg
viewPlay size mGame =
    case mGame of
        Nothing ->
            Play.init
        Just game ->
            Play.viewGame game

viewWatch : Size -> Maybe Game -> Html Msg
viewWatch size mGame  =
    case mGame of
        Nothing ->
            Watch.init
        Just game ->
            Watch.viewGame size game

viewLobby : Size -> List Player -> Html Msg
viewLobby size players  =
    div [] 
        (List.map viewPlayer players)

viewPlayer : Player -> Html Msg
viewPlayer player =
    div [] [text player]

