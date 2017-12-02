module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, value, placeholder)
import Html.Events exposing (on, targetValue, onClick, onInput)
import Json.Decode
import List

import Models exposing (Model, Input(..), Mode(..))
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
        , (toString model.player) |> (++) "\n Player: " |> text
        ]

page : Model -> Html Msg
page model =
    case model.mode of
        Init ->
            init model.player model.gameId
        Play gameId player ->
            Game.View.viewPlay model.game
        Lobby player ->
            Game.View.viewLobby player
        Watch gameId player ->
            Game.View.viewWatch model.game
        

init : Input Player -> Maybe GameId -> Html Msg
init iPlayer mGameId =
    case iPlayer of
        Changing player ->
            div [] 
            [ input [ placeholder "Player name",  onInput newInput ] []
            , a [class "btn", onClick (Msgs.PlayerChange Msgs.Approve)] [ text "Log In" ]
            ]
        Constant player ->
            case mGameId of
            Nothing ->
                div []
                    [ playBtn "Play New Game" player
                    , watchBtn "Watch Previous Game" "0" player
                    , slct ["0", "1", "2", "3"]
                    ]
            Just gameId ->
                div []
                    [ playBtn "Play New Game" player
                    , watchBtn "Watch Previous Game" gameId player
                    , slct ["0", "1", "2", "3"]
                    ]  

newInput : String -> Msg
newInput s =
    Msgs.PlayerChange (Msgs.Update s)


watchBtn : String -> GameId -> Player -> Html Msg
watchBtn txt gameId player =
    a [class "btn block mx-auto", onClick (Msgs.OnLocationChange (Watch gameId player)) ] 
        [ text txt
        ]

playBtn : String -> Player -> Html Msg
playBtn txt player =
    a [class "btn block mx-auto", onClick (Msgs.OnLocationChange(Lobby player))]
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