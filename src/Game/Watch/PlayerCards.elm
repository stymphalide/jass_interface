module Game.Watch.PlayerCards exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)

import Msgs exposing (Msg)
import Game.Model exposing (..)

import Game.Watch.Card exposing (viewCard)


viewPlayerCards : Maybe (List Card) -> Int -> List (Html Msg)
viewPlayerCards mCards width =
    case mCards of
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            let
                cardWidth =
                    (toFloat width) / 10
                    |> round
            in
                List.map (viewPlayerCard cardWidth) cards

viewPlayerCard : Int -> Card -> Html Msg
viewPlayerCard width card =
    li [class "inline-block"] 
    [ div [] 
        [viewCard width card]
     
    ]