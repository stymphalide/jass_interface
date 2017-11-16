module Game.View exposing (..)


import Html exposing (..)
import Html.Events exposing (onClick)
import Game.Model exposing(Game)
import Msgs exposing (Msg)

view : Maybe String -> Html Msg
view game =
    div []  [page game]

page : Maybe String -> Html Msg
page game =
    case game of
        Nothing ->
            init
        Just gameString ->
            div [] [text gameString]

init : Html Msg
init =
    div [] 
        [ a [onClick Msgs.Send] [text "Start Game"]
        ]