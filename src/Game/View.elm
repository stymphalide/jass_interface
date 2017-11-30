module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- Client Model
import Msgs exposing (Msg)


-- Game specific
import Game.Model exposing(Game, Player, GameId)

import Game.Play.Game as Play
import Game.Watch.Game as Watch

viewPlay :  Player -> Maybe Game -> GameId -> Html Msg
viewPlay player game gameId =
    case game of
        Nothing ->
            init player gameId
        Just g ->
            Play.viewGame g gameId
viewWatch : Player -> Maybe Game -> GameId-> Html Msg
viewWatch player game gameId =
    case game of
        Nothing ->
            init player gameId
        Just g ->
            Watch.viewGame g gameId


init : Player-> GameId -> Html Msg
init player gameId =
    div [] 
        [ a [onClick (Msgs.FetchGame (0, 0) player gameId True)] [text "Start Game"]
        ]
