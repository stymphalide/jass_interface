module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- Client Model
import Msgs exposing (Msg)


-- Game specific
import Game.Model exposing(Game, Player)

import Game.Views.Game exposing (viewGame)

viewPlay :  Player -> Maybe Game -> Html Msg
viewPlay player game =
    div []  
    [ page False player game
    ]
        
viewWatch : Player -> Maybe Game -> Html Msg
viewWatch player game =
    div []
    [ page True player game
    ]       


page : Bool -> Player -> Maybe Game -> Html Msg
page isWatch player game =
    case game of
        Nothing ->
            init player
        Just g ->
            viewGame isWatch g
init : Player -> Html Msg
init player =
    div [] 
        [ a [onClick (Msgs.FetchGame (0, 0) player)] [text "Start Game"]
        ]