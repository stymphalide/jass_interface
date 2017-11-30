module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- Client Model
import Msgs exposing (Msg)


-- Game specific
import Game.Model exposing(Game, Player, GameId)

import Game.Views.Game exposing (viewGame)

viewPlay :  Player -> Maybe Game -> GameId-> Html Msg
viewPlay player game gameId =
    div []
    [ page False player game gameId
    ]
viewWatch : Player -> Maybe Game -> GameId-> Html Msg
viewWatch player game gameId =
    div []
    [ page True player game gameId
    ]       


page : Bool -> Player -> Maybe Game ->  GameId-> Html Msg
page isWatch player game gameId =
    case game of
        Nothing ->
            init player gameId
        Just g ->
            viewGame isWatch g gameId

init : Player-> GameId -> Html Msg
init player gameId =
    div [] 
        [ a [onClick (Msgs.FetchGame (0, 0) player gameId)] [text "Start Game"]
        ]

errorWatch : Html Msg
errorWatch =
    div [] [text "No Game Id found!"]