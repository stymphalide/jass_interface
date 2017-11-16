module View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)

import Commands exposing (fetchGame)
import Models exposing (Model)
import Msgs exposing (Msg)
import Game.View 
import Routing exposing (gamePath)

-- VIEW
view : Model -> Html Msg
view model =
    div [] 
        [
            page model
        ]

page : Model -> Html Msg
page model =
    case model.game of
        Nothing ->
            init
        Just game ->
            Game.View.view game


init : Html Msg
init =
    div []
        [ btn "Play New Game" "play"
        , btn "Watch Previous Game" "watch" 
        ]

btn : String -> String -> Html Msg
btn txt path =       
    a [class "btn block mx-auto", onClick Msgs.Send ] 
        [ text txt 
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]