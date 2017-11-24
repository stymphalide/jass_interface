module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, value)
import Html.Events exposing (on)
import Json.Decode
import List

import Models exposing (Model)
import Msgs exposing (Msg)
import Decoders exposing (gameIdDecoder)

import Game.Model exposing (GameId)
import Game.View

-- VIEW
view : Model -> Html Msg
view model =
    div [] 
        [ page model
        , text (toString model.windowSize)
        , text (toString model.game)
        , text (toString model.gameId)
        ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.Init ->
            init
        Models.Play ->
            Game.View.viewPlay model.player model.game 
        Models.Watch ->
            Game.View.viewWatch model.player model.game 
        Models.NotFoundRoute ->
            notFoundView

init : Html Msg
init =
    div []
        [ btn "Play New Game" "play"
        , btn "Watch Previous Game" "watch"
        , slct ["0", "1", "2", "3"]
        ]

btn : String -> String -> Html Msg
btn txt path =
    a [class "btn block mx-auto", href path] 
        [ text txt
        ]

slct : List GameId ->  Html Msg
slct gameIds =
    div [] 
    [ select [ on "change" (Json.Decode.map Msgs.GameIdUpdate Decoders.gameIdDecoder ) ]
        ( List.map viewOption gameIds)
    ]

viewOption : GameId -> Html Msg
viewOption gameId =
    option [value gameId] [text ("Game " ++ gameId)]

notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]