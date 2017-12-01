module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, value, placeholder)
import Html.Events exposing (on, targetValue, onClick, onInput)
import Json.Decode
import List

import Models exposing (Model, Input)
import Msgs exposing (Msg)

import Game.Model exposing (GameId, Player)
import Game.View

-- VIEW
view : Model -> Html Msg
view model =
    div [] 
        [ page model
        , text (toString model.windowSize)
        , (toString model.game) |> (++) "GameString: " |> text
        , (toString model.gameId) |> (++) "\nGameId: " |> text 
        ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.Init ->
            init model.player model.gameId
        Models.Play ->
            Game.View.viewPlay model.player model.game model.gameId
        Models.Watch gameId ->
            Game.View.viewWatch model.player model.game gameId
        Models.NotFoundRoute ->
            notFoundView

init : Maybe Player -> Maybe GameId -> Html Msg
init mPlayer mGameId =
    case mPlayer of
        Nothing ->
            div [] 
            [ input [ placeholder "Player name",  on "input" (Json.Decode.map (Msgs.PlayerChange Msgs.Update) targetValue) ] []
            , a [class "btn", onClick (Msgs.PlayerChange Msgs.Approve)] [ text "Log In" ]
            ]
        Just player ->
            case mGameId of
            Nothing ->
                div []
                    [ btn "Play New Game" ("play")
                    , btn "Watch Previous Game" ("watch/0")
                    , slct ["0", "1", "2", "3"]
                    ]
            Just gameId ->
                div []
                    [ btn "Play New Game" ("play/")
                    , btn "Watch Previous Game" ("watch/" ++ gameId)
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
    [ select [ on "change" (Json.Decode.map Msgs.GameIdUpdate targetValue ) ]
        (List.map viewOption gameIds)
    ]

viewOption : GameId -> Html Msg
viewOption gameId =
    option [value gameId] [text ("Game " ++ gameId)]

notFoundView : Html Msg
notFoundView =
    div []
        [ text "Not found"
        ]