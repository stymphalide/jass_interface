module Game.Watch.Groups exposing (..)
{-
    @moduledoc
    Renders the Groups in the watch part.
-}
import List
import Html exposing (..)
import Html.Attributes exposing (class)

import Msgs exposing (Msg)

import Game.Model exposing (Group, Card, Player, History, Language)

import Game.Watch.Card exposing (viewCard)

-- At the top are the names of the players
-- next is their points
-- then the played cards are displayed.
viewGroup : Language -> Maybe Group -> Int -> Html Msg
viewGroup lang mGroup width =
    case mGroup of 
        Nothing ->
            div [][text "No Group Found!"]
        Just group ->
            div [] 
            [ h2 [] [ text (groupName group.players)]
            , h3 [] ["Points: " ++ (toString group.points) |> text]
            , div [class "clearfix"] (viewWonTurns lang group.wonCards width)
            ]
-- "Group pl_1 pl_2"
groupName : List Player -> String
groupName players =
    List.foldr concat "" ("Group" :: players )
concat : String -> String -> String
concat a b = 
    a ++ " " ++ b

-- Helper function to split the list into two groups
-- (Better way?)
unwrapMaybeGroups : Maybe (List Group) -> List Group 
unwrapMaybeGroups mGroups =
    case mGroups of
        Nothing ->
            []
        Just groups ->
            groups

-- Renders the history of the group.
-- Just lists them in pairs of 4
viewWonTurns : Language -> History -> Int -> List (Html Msg)
viewWonTurns lang mTurns width =
    case mTurns of
        Nothing ->
            []
        Just wonCards ->
            List.map (viewWonTurn lang width)  wonCards 
viewWonTurn : Language -> Int -> List Card -> Html Msg
viewWonTurn lang width cards =
    let
        cardWidth =
            toFloat width / 4.2 |> round
    in
        li [class "inline-block"] (List.map (viewCard lang cardWidth) cards)