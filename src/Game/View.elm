module Game.View exposing (..)


import Html exposing (..)
import Game.Model exposing(Game)
import Msgs exposing (Msg)




view : Html Msg
view =
    div [] [text "The game has started" ]