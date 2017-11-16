module View exposing (..)


import Html exposing (..)
import Html.Attributes exposing (class, href)
-- import Html.Events exposing (onClick)

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
            Game.View.view gameId
        Models.Watch gameId ->
            Game.View.view gameId
        Models.NotFoundRoute ->
            notFoundView

init : Html Msg
init =
    div []
        [ btn "Play New Game" "play"
        , btn "Watch Previous Game" "watch" 
        ]

btn : String -> String -> Html Msg
btn txt path =       
    a [class "btn block mx-auto", href (gamePath path) ] 
        [ text txt 
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]