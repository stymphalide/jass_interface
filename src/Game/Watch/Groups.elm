module Game.Watch.Groups exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (class)

import Msgs exposing (Msg)

import Game.Model exposing (Group, Card, Player, History)

import Game.Watch.Card exposing (viewCard)


viewGroup : Maybe Group -> Int -> Html Msg
viewGroup mGroup width =
    case mGroup of 
        Nothing ->
            div [][text "No Group Found!"]
        Just group ->
            div [] 
            [ h2 [] [ text (groupName group.players)]
            , h3 [] ["Points: " ++ (toString group.points) |> text]
            , div [class "clearfix"] (viewWonTurns group.wonCards width)
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


viewWonTurns : History -> Int -> List (Html Msg)
viewWonTurns mTurns width =
    case mTurns of
        Nothing ->
            []
        Just wonCards ->
            List.map (viewWonTurn width)  wonCards 

viewWonTurn : Int -> List Card -> Html Msg
viewWonTurn width cards =
    let
        cardWidth =
            toFloat width / 4.2 |> round
    in
        li [class "inline-block"] (List.map (viewCard cardWidth) cards)