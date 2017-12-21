module View exposing (..)
{-
    @moduledoc
    Renders the html of the site
-}

-- Html tags
import Html exposing (..)
-- Html Attributes
import Html.Attributes exposing (class, href, value, placeholder)
-- Html Events
import Html.Events exposing (on, onClick, onInput, keyCode, targetValue)
-- To decode a Json into a string
import Json.Decode
-- List utility functions
import List 

import Models exposing (Model, Input(..), Mode(..))
import Msgs exposing (Msg)

import Game.Model exposing (GameId, Player)
import Game.View

-- VIEW
-- Renders the model (and at the moment shows some info about the model)
view : Model -> Html Msg
view model =
    div [] 
        [ page model
        , nav model
        ]
-- This function renders a different view base on the mode, the model is in
page : Model -> Html Msg
page model =
    case model.mode of
        Init ->
            init model.player model.gameId model.games
        Play gameId player ->
            Game.View.viewPlay model.windowSize model.game
        Lobby players ->
            Game.View.viewLobby model.windowSize players
        Watch gameId player ->
            Game.View.viewWatch model.windowSize model.game
        
-- Renders the initial mode, depends whether there is a player logge in or not.
-- and whether a game is selected or not
init : Input Player -> Maybe GameId  -> Maybe (List GameId) -> Html Msg
init iPlayer mGameId mGameIds =
    case iPlayer of
        Changing player ->
            div [onKeyUp Msgs.OnKeyUp] 
            [ input [ placeholder "Player name",  onInput newInput ] []
            , a [class "btn", onClick (Msgs.PlayerChange Msgs.Approve)] [ text "Log In" ]
            ]
        Constant player ->
            case mGameIds of
                Nothing ->
                    div []
                        [ playBtn "Play New Game" player
                        ]
                Just gameIds ->
                    case mGameId of
                        Nothing ->
                            div []
                                [ playBtn "Play New Game" player
                                , watchBtn "Watch Previous Game" "0" player
                                , slct gameIds
                                ]
                        Just gameId ->
                            div []
                                [ playBtn "Play New Game" player
                                , watchBtn "Watch Previous Game" gameId player
                                , slct gameIds
                                ]  
-- Helper function to update the name
newInput : String -> Msg
newInput s =
    Msgs.PlayerChange (Msgs.Update s)

-- Button to change the Mode to Watch
watchBtn : String -> GameId -> Player -> Html Msg
watchBtn txt gameId player =
    a [class "btn block mx-auto", onClick (Msgs.OnLocationChange (Watch gameId player)) ] 
        [ text txt
        ]

-- Button to change the Mode to Play
playBtn : String -> Player -> Html Msg
playBtn txt player =
    a [class "btn block mx-auto", onClick (Msgs.OnLocationChange (Lobby [player]))]
        [ text txt
        ]
-- Renders the different available gameIds
slct : List GameId ->  Html Msg
slct gameIds =
    div [] 
    [ select [ on "change" (Json.Decode.map Msgs.GameIdUpdate targetValue ) ]
        (List.map viewOption gameIds)
    ]
-- Helper for the slct function, to update the model
viewOption : GameId -> Html Msg
viewOption gameId =
    option [value gameId] [text ("Game " ++ gameId)]


nav : Model -> Html Msg
nav model =
    case model.mode of
        Init ->
            case model.player of
                Changing player ->
                    div [] [] -- Nothing to navigate to
                Constant player ->
                    logout
        Lobby players ->
            logout
        Play gameId player ->
            logout
        Watch gameId player ->
            logout

logout : Html Msg
logout =
    a [ class "btn", onClick <| Msgs.LogOut] [text "Logout"]

-- Helper to find onKeyUp
onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
    on "keyup" (Json.Decode.map tagger keyCode)