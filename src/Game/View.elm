module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Events exposing (onClick)

-- Client Model
import Msgs exposing (Msg)

-- Game specific
import Game.Model exposing(Game)

import Game.Views.Game exposing (viewGame)

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