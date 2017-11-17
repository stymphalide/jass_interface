module Game.Views.Groups exposing (..)

import List
import Html exposing (..)

import Msgs exposing (Msg)

import Game.Model exposing (Group, Card, Player, History)

import Game.Views.Card exposing (viewCard)


viewGroup : Maybe Group -> Html Msg
viewGroup mGroup =
    case mGroup of 
        Nothing ->
            div [][text "No Group Found!"]
        Just group ->
            div [] 
            [ h2 [] [ text (groupName group.players)]
            , div [] (viewWonTurns group.wonCards)
            ]

groupName : List Player -> String
groupName players =
    List.foldr concat "" ("Group" :: players )

concat : String -> String -> String
concat a b = 
    a ++ " " ++ b

unwrapMaybeGroups : Maybe (List Group) -> List Group 
unwrapMaybeGroups mGroups =
    case mGroups of
        Nothing ->
            []
        Just groups ->
            groups

viewWonTurns : History-> List (Html Msg)
viewWonTurns mTurns =
    case mTurns of
        Nothing ->
            []
        Just wonCards ->
            List.map viewWonTurn wonCards

viewWonTurn : List Card -> Html Msg
viewWonTurn cards =
    li [] (List.map viewCard cards)