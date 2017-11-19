module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- Client Model
import Msgs exposing (Msg)
import Models exposing (Route)

-- Game specific
import Game.Model exposing(Game)

import Game.Views.Game exposing (viewGame)

view : Route -> Maybe Game -> Html Msg
view route game =
    case route of
        Models.Init ->
            div [] []
        Models.Watch player gameId  ->
            div []  
            [ page True game
            ]
        Models.Play player gameId  ->
            div []
            [ page False game
            ]
        Models.NotFoundRoute ->
            div [] []
            

page : Bool -> Maybe Game -> Html Msg
page isWatch game =
    case game of
        Nothing ->
            init 
        Just g ->
            viewGame isWatch g
init : Html Msg
init =
    div [] 
        [ a [onClick (Msgs.FetchGame (0, 0) "pl_1")] [text "Start Game"]
        ]