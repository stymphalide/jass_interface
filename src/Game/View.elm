module Game.View exposing (..)
{-
    @moduledoc
    Renders GameSpecific views
    Redirects Mostly to the Play/Watch modules section
-}


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

-- redirect
viewPlay : Size -> Maybe Game -> Html Msg
viewPlay size mGame =
    case mGame of
        Nothing ->
            Play.init
        Just game ->
            Play.viewGame game
-- Redirect
viewWatch : Size -> Maybe Game -> Html Msg
viewWatch size mGame  =
    case mGame of
        Nothing ->
            Watch.init
        Just game ->
            Watch.viewGame size game


-- Very besic lobby rendering (to be improved.)
viewLobby : Size -> List Player -> Html Msg
viewLobby size players  =
    div [] 
        (List.map viewPlayer players)

viewPlayer : Player -> Html Msg
viewPlayer player =
    div [] [text player]

