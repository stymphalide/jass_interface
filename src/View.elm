module View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)

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
    case model.route of
        Models.Init ->
            init
        Models.Play gameId ->
            Game.View.view model.game 
        Models.Watch gameId ->
            Game.View.view model.game 
        Models.NotFoundRoute ->
            notFoundView


init : Html Msg
init =
    div []
        [ btn "Play New Game" "play/0"
        , btn "Watch Previous Game" "watch/0" 
        ]

btn : String -> String -> Html Msg
btn txt path =       
    a [class "btn block mx-auto", href path] 
        [ text txt 
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]