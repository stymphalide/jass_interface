module Game.View exposing (..)


import Html exposing (..)
import Html.Events exposing (onClick)
import Game.Model exposing(Game)
import Msgs exposing (Msg)

view : Maybe Game  -> Html Msg
view game =
    div []  [page game]

page : Maybe Game -> Html Msg
page game =
    case game of
        Nothing ->
            init 
        Just g ->
            viewGame g
init :  Html Msg
init =
    div [] 
        [ a [onClick Msgs.Send ] [text "Start Game"]
        ]
viewGame : Game -> Html Msg
viewGame game =
    div [] 
    [ h1 [] [ text game.gameType ]
    ]