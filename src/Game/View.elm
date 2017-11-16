module Game.View exposing (..)


import Html exposing (..)
import Game.Model exposing(Game)
import Msgs exposing (Msg)

view : String -> Html Msg
view game =
    div [] [text game ]